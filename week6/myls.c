// myls.c ... my very own "ls" implementation

#include <stdlib.h>
#include <stdio.h>
#include <bsd/string.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <grp.h>
#include <pwd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <error.h>
#include <errno.h>
#include <dirent.h>


#define MAXDIRNAME 100
#define MAXFNAME   200
#define MAXNAME    20
#define MAX_STATUS_COUNT 200


char *rwxmode(mode_t, char *);
char *username(uid_t, char *);
char *groupname(gid_t, char *);



int main(int argc, char *argv[])
{
    // string buffers for various names
    char dirname[MAXDIRNAME];
    char uname[MAXNAME+1]; 
    char gname[MAXNAME+1]; 
    char mode[MAXNAME+1]; 

    // collect the directory name, with "." as default
    if (argc < 2)
        strlcpy(dirname, ".", MAXDIRNAME);
    else
        strlcpy(dirname, argv[1], MAXDIRNAME);

    // check that the name really is a directory
    struct stat info;
    if (stat(dirname, &info) < 0)
        { perror(argv[0]); exit(EXIT_FAILURE); }
        if ((info.st_mode & S_IFMT) != S_IFDIR)
        { fprintf(stderr, "%s: Not a directory\n",argv[0]); exit(EXIT_FAILURE); }

    // open the directory to start reading
    DIR *df; 
    // try to open the directory     
    df= opendir(dirname);
    // unable to open that directory 
    if (df == NULL){
        // try to print out the error message
        error(errno, errno,"Can not open the directory: %s\n", dirname);
    }
    
    
        
    
    
    // read directory entries
    struct dirent *entry[MAX_STATUS_COUNT];
    
    int count_entry = 0; 
    // readthough all the entry in the directory 
    while((entry[count_entry] = readdir(df))!= NULL){
        if (entry[count_entry]->d_name[0] == '.'){
            // filter the first charater is .
            continue ;
        }
        
        // add one for each recorded file 
        count_entry ++;        
        
    }
    
    
    int swap = 1;
    // sort the array entry 
    while (swap){
        // re initial the swap flag
        swap =  0;
        for (int i= 0; i < count_entry-1; i++){
            // search throught the array 
            if (strcmp(entry[i]->d_name, entry[i+1]->d_name)>0){
                struct dirent *tmp = entry[i];
                entry[i]= entry[i+1];
                entry[i+1] = tmp;
                swap = 1;
            }            
            
        
        }
    }
   
    struct stat sb;
    
    for (int i = 0; i< count_entry; i++){
        // get the file name with directory 
        char fileLo[512];
        sprintf(fileLo, "%s/%s", dirname, entry[i]->d_name);


        // print the information of all sorted entry 
        if (lstat(fileLo, &sb) == -1) {
            // try to get the information of this file
            perror("stat");
            exit(EXIT_FAILURE);
        }


        // alloc enought space for file name to show 
        char fileName[512];
        // give it the basic value of file name;
        strcpy(fileName, entry[i]->d_name);
        
        
        // try to read the real address if it is a symbolic link 
        if ((sb.st_mode& S_IFMT)==S_IFLNK){
            char addr[255]="";
            printf("%s",addr);
            readlink(fileLo, addr,255);
            //printf("%s\n",addr);
            // refresh the fileName to print 
            //printf("%s\n",addr);
            
            strcat(fileName, " -> ");
            strcat(fileName, addr);
            
            strcat(fileName, "\0");
            
        
        } 
        
    
        
        printf("%s  %-8.8s %-8.8s %8lld  %s\n",
               rwxmode(sb.st_mode, mode),
               username(sb.st_uid, uname),
               groupname(sb.st_gid, gname),
               (long long)sb.st_size,
               fileName); 
    
        //printf("%s", fileName);
    }
    
       
    // finish up
    closedir(df); // UNCOMMENT this line
    return EXIT_SUCCESS;
}





// convert octal mode to -rwxrwxrwx string
char *rwxmode(mode_t mode, char *str)
{
    //clear the input string 
    strcpy(str,"");
    // use the input mode to generate the string represent the file mode.
    
    // determine the file type
    switch (mode& S_IFMT){
    case S_IFREG:strcat(str,"-");break;
    case S_IFLNK:strcat(str,"l");break;
    case S_IFDIR:strcat(str,"d");break;
    // unknown file type for this iteration
    default: strcat(str,"?"); break;
    }

    // determine owner premission 
    strcat(str,((mode&S_IRUSR)?"r":"-"));
    strcat(str,((mode&S_IWUSR)?"w":"-"));
    strcat(str,((mode&S_IXUSR)?"x":"-"));
    
    // determine group premission 
    strcat(str,((mode&S_IRGRP)?"r":"-"));
    strcat(str,((mode&S_IWGRP)?"w":"-"));
    strcat(str,((mode&S_IXGRP)?"x":"-"));
    
    // determine others premission 
    strcat(str,((mode&S_IROTH)?"r":"-"));
    strcat(str,((mode&S_IWOTH)?"w":"-"));
    strcat(str,((mode&S_IXOTH)?"x":"-"));
    
    
    return str;
}

// convert user id to user name
char *username(uid_t uid, char *name)
{
    struct passwd *uinfo = getpwuid(uid);
    if (uinfo == NULL)
        snprintf(name, MAXNAME, "%d?", (int)uid);
    else
        snprintf(name, MAXNAME, "%s", uinfo->pw_name);
    return name;
}

// convert group id to group name
char *groupname(gid_t gid, char *name)
{
    struct group *ginfo = getgrgid(gid);
    if (ginfo == NULL)
        snprintf(name, MAXNAME, "%d?", (int)gid);
    else
        snprintf(name, MAXNAME, "%s", ginfo->gr_name);
    return name;
}
