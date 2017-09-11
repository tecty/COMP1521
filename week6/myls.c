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

#define MAXDIRNAME 100
#define MAXFNAME   200
#define MAXNAME    20

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
    struct dirent *entry; 
    // readthough all the entry in the directory 
    while((entry = readdir(df))!= NULL){
        if (entry->d_name[0] == '.'){
            // filter the first charater is .
            continue ;
        }
        // get the file name with directory 
        char fileLo[255];
        sprintf(fileLo, "%s/%s", dirname, entry->d_name);
        
        // var to store the stat struct 
        struct stat sb;
        if (lstat(fileLo, &sb) == -1) {
            // try to get the information of this file
            perror("stat");
            exit(EXIT_FAILURE);
        }

        
        // print the information of this entry
        printf("%s  %-8.8s %-8.8s %8lld  %s\n",
               rwxmode(sb.st_mode, mode),
               username(sb.st_uid, uname),
               groupname(sb.st_gid, gname),
               (long long)sb.st_size,
               entry->d_name);     
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
    case S_IFLNK:strcat(str,"d");break;
    case S_IFDIR:strcat(str,"l");break;
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
