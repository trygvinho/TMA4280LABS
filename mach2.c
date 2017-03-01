#include "stdio.h"
#include "math.h"
#include "stdlib.h"
#include "math.h"
#include "time.h"
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
double *v=(double *)malloc(sizeof(double)*(n/size)),*v2=(double *)malloc(sizeof(double)*(n/size));
double S=0.0,S2=0.0;
double z1=0.2, z2=1.0/239.0;
if(rank==0){
/*#pragma omp parallel for schedule(static)*/
for(int j=size-1; j>-1;j--){
#pragma omp parallel for schedule(static)
for(int i=(j*n)/size+1; i<(n*(j+1))/size+1;i++){
v[i-1-(j*n)/size]=pow(-1,i-1)*pow(z1,2*i-1)/(2*i-1);
v2[i-1-(j*n)/size]=pow(-1,i-1)*pow(z2,2*i-1)/(2*i-1);}
if(j!=0){
MPI_Send(v,n/size,MPI_DOUBLE,j,0,MPI_COMM_WORLD);
MPI_Send(v2,n/size,MPI_DOUBLE,j,1,MPI_COMM_WORLD);}}}
else{
MPI_Recv(v,n/size,MPI_DOUBLE,0,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
MPI_Recv(v2,n/size,MPI_DOUBLE,0,1,MPI_COMM_WORLD,MPI_STATUS_IGNORE);}
double *v3=(double *)malloc(sizeof(double)*(int)(n/size));
double *v4=(double *)malloc(sizeof(double)*(int)(n/size));
MPI_Allreduce(v,v3,n/size,MPI_DOUBLE,MPI_SUM,MPI_COMM_WORLD);
MPI_Allreduce(v2,v4,n/size,MPI_DOUBLE,MPI_SUM,MPI_COMM_WORLD);
#pragma omp parallel for reduction(+:S), reduction(+:S2)
for(int i=0; i<n/size;i++){
S=S+v3[i];
S2=S2+v4[i];}
/*printf("La illaha illallah %d\t%.18f\t%d\t%f\t%f\n",n,fabs(16*S-4*S2-PI),rank,fabs(S-atan(z1)),fabs(S2-atan(z2)));*/
clock_gettime(CLOCK_REALTIME, &finish);
if(rank==0){
double time_spent = (double)((finish.tv_sec+finish.tv_nsec*1e-9) - (double)(start.tv_sec+start.tv_nsec*1e-9));
printf("For Mach: Error: %.18f, time: %.9f, threads: %d and k:%d\n",fabs(16*S-4*S2-PI),time_spent,omp_get_max_threads(),k);}
free(v);
free(v2);
free(v3);
free(v4);
MPI_Finalize();}
