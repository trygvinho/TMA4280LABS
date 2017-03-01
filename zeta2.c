#include "stdio.h"
#include "math.h"
#include "stdlib.h"
#include "math.h"
#include "time.h"
#include "sys/time.h"
#include "omp.h"
#include "mpi.h"

#define PI 3.14159265358979323846

int main(int argc , char ** argv){
int k=atoi(argv[1]);
int n=(int)pow(2,k);
int size,rank;
struct timespec start, finish;
clock_gettime(CLOCK_REALTIME, &start);
MPI_Init(&argc,&argv);
MPI_Comm_size(MPI_COMM_WORLD,&size);
MPI_Comm_rank(MPI_COMM_WORLD,&rank);
double *v=(double *)malloc(sizeof(double)*(n/size));
double S=0.0;
if(rank==0){
/*#pragma omp parallel for schedule(static)*/
for(int j=size-1; j>-1;j--){
#pragma omp parallel for schedule(static)
for(int i=(j*n)/size+1; i<(n*(j+1))/size+1;i++){
v[i-1-(j*n)/size]=1/pow(i,2);}
if(j!=0){
MPI_Send(v,n/size,MPI_DOUBLE,j,0,MPI_COMM_WORLD);}}}
else{
MPI_Recv(v,n/size,MPI_DOUBLE,0,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);}
double *v2=(double *)malloc(sizeof(double)*(int)(n/size));
MPI_Allreduce(v,v2,n/size,MPI_DOUBLE,MPI_SUM,MPI_COMM_WORLD);
#pragma omp parallel for reduction(+:S)
for(int i=0; i<n/size;i++){
S=S+v2[i];}
/*printf("La illaha illallah %d\t%.15f\t%d\t%f\t%f\n",n,fabs(sqrt(6*S)-PI),rank,v2[0],v2[1]);*/
clock_gettime(CLOCK_REALTIME, &finish);
if(rank==0){
double time_spent = (double)((finish.tv_sec+finish.tv_nsec*1e-9) - (double)(start.tv_sec+start.tv_nsec*1e-9));
printf("For zeta: Error: %.18f, time: %.9f, threads: %d and k:%d\n",fabs(sqrt(6*S)-PI),time_spent,omp_get_max_threads(),k);}
free(v);
free(v2);
MPI_Finalize();}



