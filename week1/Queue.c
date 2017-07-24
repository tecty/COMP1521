// ADT for a FIFO queue
// COMP1521 17s2 Week01 Lab Exercise
// Written by John Shepherd, July 2017
// Modified by Toby HUANG z5141448

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "Queue.h"

typedef struct QueueNode {
   int jobid;  // unique job ID
   int size;   // size/duration of job
   struct QueueNode *next;
} QueueNode;

struct QueueRep {
   int nitems;      // # of nodes
   QueueNode *head; // first node
   QueueNode *tail; // last node
};


// TODO:
// remove the #if 0 and #endif
// once you've added code to use this function

// create a new node for a Queue
static
QueueNode *makeQueueNode(int id, int size)
{
   QueueNode *new;
   new = malloc(sizeof(struct QueueNode));
   assert(new != NULL);
   new->jobid = id;
   new->size = size;
   new->next = NULL;
   return new;
}

// make a new empty Queue
Queue makeQueue()
{
   Queue new;
   new = malloc(sizeof(struct QueueRep));
   assert(new != NULL);
   new->nitems = 0; new->head = new->tail = NULL;
   return new;
}

// release space used by Queue
void  freeQueue(Queue q)
{
   assert(q != NULL);
   while (leaveQueue(q)!= 0) {
       /* delete all the node by repeat the leaveQueue */
   }

}

// add a new item to tail of Queue
void  enterQueue(Queue q, int id, int size)
{
    assert(q != NULL);

    // create a node
    QueueNode *thisNode=makeQueueNode(id,size);
    if (q->head  == NULL) {
        /* the head is empty, thisNode is the first node */
        q->tail = q->head = thisNode;
    }
    else {
        /* append the tail */
        q->tail->next=  thisNode;
        q->tail = thisNode;
    }
    q->nitems ++;
}

// remove item on head of Queue
int   leaveQueue(Queue q)
{
    assert(q != NULL);



    if (q->nitems == 0) {
        /* the queue is empty */
        return 0;
    }
    else{
        int jobid = q->head->jobid;
        QueueNode *deleteNode= q->head;
        q->head = q->head->next;
        if (q->head == NULL) {
            /* the queue is alread empty, set the tail to empty */
            q->tail = q->head;
        }
        free(deleteNode);

        // set item count decrease
        q->nitems --;
        return jobid;
    }
}

// count # items in Queue
int   lengthQueue(Queue q)
{
   assert(q != NULL);
   return q->nitems;
}

// return total size in all Queue items
int   volumeQueue(Queue q)
{
   assert(q != NULL);
   int volume =0;
   if (q->nitems == 0) {
       /* the queue is empty */
       return 0;
   }
   else {
       QueueNode *thisNode= q->head;
       while (thisNode !=NULL) {
           /* add up all the volume of all the node */
           volume +=thisNode->size;
           thisNode = thisNode->next;
       }

        //  return the size of the queue;
        return volume;

   }


}

// return size/duration of first job in Queue
int   nextDurationQueue(Queue q)
{
   assert(q != NULL);
   if (q->nitems == 0) {
       /* the queue is empty */

       return 0;
   }
   else {
       return q->head->size;
   }

}


// display jobid's in Queue
void showQueue(Queue q)
{
   QueueNode *curr;
   curr = q->head;
   while (curr != NULL) {
      printf(" (%d,%d)", curr->jobid, curr->size);
      curr = curr->next;
   }
}
