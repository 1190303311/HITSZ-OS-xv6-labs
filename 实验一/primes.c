#include "kernel/types.h"
#include "user.h"

void primes(int *num, int count);
int main(int argc, char *argv[])
{
    int status=-1;
    if(argc>1)
    {
        fprintf(2,"usage: primes\n");
        exit(1);
    }
    int num[34];
    for(int i=0; i<34;i++)
        num[i]=i+2;
    primes(num,34);//每次向下一个进程传送数组和个数
    wait(&status);
    exit(0);
}

void primes(int *num, int count)
{

    if(count==1)//只剩一个数字时，递归结束条件
    {
        printf("prime %d",*num);
        return;
    }
    int p[2],status=-1;
    pipe(p);
    int temp = *num,k;//temp是当前进程处理的第一个数字，筛选后面数字的依据
    printf("prime %d\n",temp);
    if(fork()==0)//子进程从管道读取int数组，并根据temp进行选择，选择结果通过递归传入下一个进程
    {   
        close(p[1]);//读取之前必须先将write端关闭
        int counter=0,buf;
        while(read(p[0],&buf,4)!=0)
        {
            if(buf%temp!=0)
            {
                num[counter]=buf;
                counter++;
            }
        }
        primes(num,counter);
        wait(&status);
        exit(0);
    }
    else//父进程，将这一层处理好的数据打包给子进程
    {
        for(int i=1; i<count; i++)
        {
            int n;
            k=num[i];
            if((n=write(p[1],&k,4))!=4)
            {
                fprintf(2,"write error from parent\n");
                exit(1);
            }
        }
        close(p[1]);
        wait(&status);
        exit(0);
    }
}
