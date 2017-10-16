// COMP1521 17s2 Lab08 ... processes competing for a resource

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>

#define MAXLINE BUFSIZ

void copyInput(char *);

void nothing(int sig) {
    /* donothing */
    if (sig == SIGINT) {
        /* code */
        printf("donothing to keyboard interrupt.");
    }
}

void ignore(){
    // set the SIGINT to do nothing
    printf("Try to ignore some signal\n" );
    if (signal(SIGINT,nothing)  ) {
        printf("Coundln't catch keyboard interrupt\n" );
    }
}

int main(void)
{
   struct sigaction act;
   memset (&act, 0, sizeof(act));

   if (fork() != 0) {
       ignore();
      copyInput("Parent");
      // ignore the keyboard interrupt
   }
   else if (fork() != 0) {
       ignore();
      copyInput("Child");
   }
   else {
      copyInput("Grand-child");
   }
   return 0;
}

void copyInput(char *name)
{
   pid_t mypid = getpid();
   char  line[MAXLINE];
   printf("%s (%d) ready\n", name, mypid);
   while (fgets(line, MAXLINE, stdin) != NULL) {
      printf("%s: %s", name, line);
    //   sleep(random()%3);
      sleep(1);
   }
   printf("%s quitting\n", name);
   return;
}
