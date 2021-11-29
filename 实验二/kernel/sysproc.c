#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "sysinfo.h" // 加入sysinfo头文件，结构体定义

uint64
sys_exit(void)
{
  int n;
  if(argint(0, &n) < 0)
    return -1;
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  if(argaddr(0, &p) < 0)
    return -1;
  return wait(p);
}

uint64
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

// systrace lab2 mission1
uint64
sys_trace(void)
{
  int mask;
  if(argint(0, &mask) <0 ) // 获取mask参数
    return -1;
  struct proc *p = myproc(); // 将当前进程的proc结构体（内核上下文）mask进行设置
  p->mask = mask; // 因此trace后面的程序根据mask进行判断是否需要追踪自己的信息
  return 0;
}

// sysinfo lab2 mission2
uint64
sys_sysinfo(void)
{
  uint64 pout; //用来获取参数，也就是copyout到用户内存地址空间的地址
  struct sysinfo pin; //用来获取结构体三个属性的值
  struct proc *p = myproc(); // 生成copyout的参数，pagetable
  if(argaddr(0, &pout)<0) // 获取参数，一个在用户地址空间指向sysinfo结构体的指针
    return -1;
  calsize(&pin); // 获取内存剩余字节数
  unused_pro(&pin); // 获取空闲进程数
  usable_file(&pin); // 获取可用文件描述符数
  if(copyout(p->pagetable, (uint64)pout, (char *)&pin, sizeof(pin)) < 0)
    return -1; // 将内核地址空间的pin复制到用户地址空间
  return 0;
}
