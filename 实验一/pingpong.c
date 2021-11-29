#include "kernel/types.h"
#include "user.h"

int main(int argc, char *argv[])
{
    int p1[2],p2[2];
    pipe(p1);//p1 child reads from parent
    pipe(p2);//p2 child write to parent
    if(argc>1)
    {
        fprintf(2,"usage:pingpang\n");
        exit(1);
    }
    if(fork()==0)
    {
        char c[5];
        char k[] = "ping";
        char r[] = "pong";
        int n;
        n = read(p1[0],c,4);
        if(n<0)
        {
            fprintf(2,"read error from child\n");
            exit(1);
        }
        if(!strcmp(c,k))
        {
            fprintf(1,"%d: received %s\n",getpid(),c);
            n = write(p2[1],r,4);
            if(n!=4)
            {
                fprintf(2,"write error from child\n");
                exit(1);
            }
        }
        close(p1[0]);
        close(p1[1]);
        close(p2[0]);
        close(p2[1]);
        exit(0);
    }
    else
    {
        char c[5];
        int n;
        char k[] = "pong";
        char r[] = "ping";
        n = write(p1[1],r,4);
        if(n!=4)
        {
            fprintf(2,"write error from parent\n");
            exit(1);
        }
        n = read(p2[0],c,4);
        if(n<0)
        {
            fprintf(2,"read error from parent\n");
            exit(1);
        }
        if(!strcmp(c,k))
        {
            fprintf(1,"%d: received %s\n",getpid(),c);
        }
    }
    close(p1[0]);
    close(p1[1]);
    close(p2[0]);
    close(p2[1]);
    exit(0);
}