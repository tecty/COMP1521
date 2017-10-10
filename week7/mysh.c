// mysh.c ... a very simple shell
// Started by John Shepherd, October 2017
// Completed by <<YOU>>, October 2017

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <assert.h>

extern char *strdup(char *);
void trim(char *);
char **tokenise(char *, char *);
void freeTokens(char **);
int isExecutable(char *);
void execute(char **, char **, char **);

int main(int argc, char *argv[], char *envp[])
{
   pid_t pid;   // pid of child process
   int stat;    // return status of child
   char **path; // array of directory names

   // set up command PATH from environment variable
   int i;
   for (i = 0; envp[i] != NULL; i++) {
      if (strncmp(envp[i], "PATH", 4) == 0) break;
   }
   if (envp[i] == NULL)
      path = tokenise("/bin:/usr/bin",":");
   else
      // &envp[i][5] ignores "PATH="
      path = tokenise(&envp[i][5],":");

#ifdef DBUG
   for (i = 0; path[i] != NULL;i++)
      printf("dir[%d] = %s\n",i,path[i]);
#endif

   // main loop: print prompt, read line, execute command
   char line[BUFSIZ];
   printf("mysh$ ");
   while (fgets(line, BUFSIZ, stdin) != NULL) {
      trim(line); // remove leading/trailing space
      if (strcmp(line,"exit") == 0) break;
      if (strcmp(line,"") == 0) { printf("mysh$ "); continue; }

      // implement the tokenise/fork/execute/cleanup code
      if ((pid = fork())!= 0) {
          /* here is parent process */
          wait(&stat);
          if (stat< 0) {
              /* print the error */
              perror("Error msg:");
          }
      }
      else{
          /* here is child process */
          // a way to do the pipe
          char **commands  =  tokenise(line,"|");

          // store the file descripter
          int pip[2] ={0};
        //   // the pipe for this process and its child
        //   int my_parent = -1;
        //   int my_child = -1;

        //   for (int i = 0; commands[i] != NULL; i++) {
        //       /* for each possible commands, fork it */
        //       if (commands[i+1]!= NULL) {
        //           /* create a pipe for this programe and next programe */
        //           pipe(pipe);
        //       }
        //       else{
        //           /* Here is child commands */
        //           execute(tokenise(commands[0]," "),path,envp);
        //       }
          //
        //       if (fork()== 0) {
        //           /* here is child process, run the 1st to the last-1 command */
        //           execute(tokenise(commands[0]," "),path,envp);
        //       }
          //
        //   }

        for (int i = 0; commands[i] != NULL; i++) {
            /* print all the pip */
            printf("%s\n",commands[i] );
        }


        if (commands[1] != NULL) {
            /* here is a pipe of two commands*/
            pipe(pip);
            if (fork()!= 0) {
                /* here will run the first commands */
                // close child's pip
                // close(pip[1]);
                printf("%d\n", pip[0]);
                // open the pip as stdout
                dup2(pip[0],STDOUT_FILENO);
                execute(tokenise(commands[0]," "),path,envp);

            }
            else{
                /* here is a child process, 2nd commands */
                // close parent's pip
                // close(pip[0]);
                printf("%d\n",pip[1] );
                // open the pip as stdout
                dup2(pip[2],STDIN_FILENO);
                execute(tokenise(commands[1]," "),path,envp);

            }

        }
        else{
            // the command not has pip execute
            execute(tokenise(commands[0]," "),path,envp);

        }


      }



      printf("mysh$ ");
   }
   printf("\n");
   return(EXIT_SUCCESS);
}

// execute: run a program, given command-line args, path and envp
void execute(char **args, char **path, char **envp)
{
    // implement the find-the-executable and execve() it code
    char *command = NULL;
    // for (int i = 0; args[i]!= NULL; i++) {
    //     /* show all the args */
    //     printf("%s\n",args[i] );
    // }

    if (args[0][0]== '/' || args[0][0] == '.') {
        /* start with specify path */

        if (isExecutable(args[0])) {
            /* the specify file is executable */
            command = strdup(args[0]);
        }

    }
    else{
        // try to search this command in the bin folders
        while (path != NULL) {
            /* search for the location */
            char tmp[100];
            // assemble the location of possible executable file
            sprintf(tmp, "%s/%s",path[0], args[0]);
            if (isExecutable(tmp)) {
                /* the file is found */
                command = strdup(tmp);
                break;
            }
            path++;
        }
    }

    if (command == NULL) {
        /* command not found */
        printf("Command not found\n" );
    }
    else{
        // execute the file
        execve(command,args,envp);
        // free the duplicate string
        free(command);
    }
}

// isExecutable: check whether this process can execute a file
int isExecutable(char *cmd)
{
   struct stat s;
   // must be accessible
   if (stat(cmd, &s) < 0)
      return 0;
   // must be a regular file
   //if (!(s.st_mode & S_IFREG))
   if (!S_ISREG(s.st_mode))
      return 0;
   // if it's owner executable by us, ok
   if (s.st_uid == getuid() && s.st_mode & S_IXUSR)
      return 1;
   // if it's group executable by us, ok
   if (s.st_gid == getgid() && s.st_mode & S_IXGRP)
      return 1;
   // if it's other executable by us, ok
   if (s.st_mode & S_IXOTH)
      return 1;
   return 0;
}

// tokenise: split a string around a set of separators
// create an array of separate strings
// final array element contains NULL
char **tokenise(char *str, char *sep)
{
   // temp copy of string, because strtok() mangles it
   char *tmp;
   // count tokens
   tmp = strdup(str);
   int n = 0;
   strtok(tmp, sep); n++;
   while (strtok(NULL, sep) != NULL) n++;
   free(tmp);
   // allocate array for argv strings
   char **strings = malloc((n+1)*sizeof(char *));
   assert(strings != NULL);
   // now tokenise and fill array
   tmp = strdup(str);
   char *next; int i = 0;
   next = strtok(tmp, sep);
   strings[i++] = strdup(next);
   while ((next = strtok(NULL,sep)) != NULL)
      strings[i++] = strdup(next);
   strings[i] = NULL;
   free(tmp);
   return strings;
}

// freeTokens: free memory associated with array of tokens
void freeTokens(char **toks)
{
   for (int i = 0; toks[i] != NULL; i++)
      free(toks[i]);
   free(toks);
}

// trim: remove leading/trailing spaces from a string
void trim(char *str)
{
   int first, last;
   first = 0;
   while (isspace(str[first])) first++;
   last  = strlen(str)-1;
   while (isspace(str[last])) last--;
   int i, j = 0;
   for (i = first; i <= last; i++) str[j++] = str[i];
   str[j] = '\0';
}
