// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"

void freerange(void *pa_start, void *pa_end);

extern char end[]; // first address after kernel.
                   // defined by kernel.ld.

struct run {
  struct run *next;
};

struct kmem{
  struct spinlock lock;
  struct run *freelist;
};

struct kmem kmems[NCPU]; // 为每个CPU维护一个空闲链表

void
kinit()
{
  for(int i=0; i<NCPU; i++)
    initlock(&kmems[i].lock, "kmem");//初始化所有cpu空闲链表的锁，都命名为kmem，否则测试结果不完全显示
  freerange(end, (void *)PHYSTOP);
}

void
freerange(void *pa_start, void *pa_end)
{//将所有空闲块都分配给调用函数的第一个CPU，其他CPU需要空闲块时自己的链表没有就去steal
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    kfree(p);
}

// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
  push_off();//获取当前cpu号，push_off禁止中断，pop_off启用
  uint64 cpu = cpuid();
  pop_off();
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);

  r = (struct run*)pa;

  acquire(&kmems[cpu].lock);//内存块回收到当前cpu的空闲链表中
  r->next = kmems[cpu].freelist;
  kmems[cpu].freelist = r;
  release(&kmems[cpu].lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
  struct run *r;
  push_off();//获取当前cpu号
  uint64 cpu = cpuid();
  pop_off();

  acquire(&kmems[cpu].lock);//先对当前cpu空闲链表加锁
  r = kmems[cpu].freelist;
  if(r)//如果非空，就释放锁返回空闲块
  {
    kmems[cpu].freelist = r->next;
    release(&kmems[cpu].lock);
  }
  else//否则代表自己没有可分配的空闲块，去其他cpu steal
  {
    release(&kmems[cpu].lock);//steal之前释放当前cpu的锁
    for(int i=0; i<NCPU; i++)
    {
      acquire(&kmems[i].lock);//循环取出每个cpu的空闲链表，查询是否非空
      r = kmems[i].freelist;
      if(r)//非空就跳出循环，返回一个空闲块
      {
        kmems[i].freelist = r->next;
        release(&kmems[i].lock);
        break;
      }
      release(&kmems[i].lock);//释放cpu i的锁，检查下一个cpu的空闲链表
    }
  }
  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
  return (void*)r;
}
