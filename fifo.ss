

#include<stdio.h>
#include<stdlib.h>
void FIFO();
void lru();
int findLRU();
int main()
{    
    int ch,YN=1,i,l,f;
    char F[10],s[25];
    printf("\nEnter the number of empty frame:\n");
    scanf("%d",&f);
    printf("Enter the length of string\n");
    scanf("%d",&l);
    printf("Enter the string\n");
    scanf("%s",s);
    for(i=0;i<f;i++)
        F[i]=-1;
    do
    {
        printf("\n***********Menu********\n");
        printf("1:FIFO 2:LRU 3:EXIT\n");
        scanf("%d",&ch);
        switch(ch)
        {
            case 1:for(i=0;i<f;i++)
                    F[i]=-1;
                FIFO(s,F,l,f);
                break;
            case 2:for(i=0;i<f;i++)
                    F[i]='\0';
                lru(s,F,l,f);
                break;
            case 3:exit(0);
        }
        printf("\nDo u want to continue IF YES PRESS 1\n\tIF NO PRESS 0:");        
        scanf("%d",&YN);
    }
    while(YN==1);
    return(0);
}
void FIFO(char s[],char F[],int l, int f)
{
    int i,k,j=0,flag=0,cnt=0;
    printf("\nPAGE\tFRAMES\tFAULTS\n");
    for(i=0;i<l;i++)
    {
        for(k=0;k<f;k++)
            if(F[k]==s[i])
                flag=1;
        if(flag==0)
        {
            printf("\n\t%c\t",s[i]);
            F[j]=s[i];
            j++;
            for(k=0;k<f;k++)
                printf("%c",F[k]);
            printf("\tPage fault %d",cnt);
            cnt++;
        }
        else
        {
            flag=0;
            printf("\n\t%c\t",s[i]);
            for(k=0;k<f;k++)
                printf("%c",F[k]);
            printf("\tNO page fault\n");
        }
        if(j==f)
            j=0;
    }
}
void lru(char s[],char F[],int l,int f)
{
    int counter=0,time[10],flag1,flag2,i,j,pos,faults=0;
    for(i=0;i<l;++i)
    {
        flag1=flag2=0;
        for(j=0;j<f;++j)
            if(F[j]==s[i])
            {
                counter++;
                time[j]=counter;
                flag1=flag2=1;
                break;
            }    
        if(flag1==0)
            for(j=0;j<f;++j)
            {
                if(F[j]=='\0')
                {
                    counter++;
                    faults++;
                    F[j]=s[i];
                    time[j]=counter;
                    flag2=1;
                    break;
                }
            }
        if(flag2==0)
        {
            pos=findLRU(time,f);
            counter++;
            faults++;
            F[pos]=s[i];
            time[pos]=counter;
        }
        printf("\n");
        for(j=0;j<f;++j)
            printf("%c\t",F[j]);
    }
    printf("\nTotal Page faults= %d",faults);
}
int findLRU(int time[], int n)
{
    int i,minimum=time[0],pos=0;
    for(i=1;i<n;++i)
        if(time[i]<minimum)
        {
            minimum=time[i];
            pos=i;
        }
    return pos;
}

