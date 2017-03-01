#include "stdio.h"
#include "math.h"
#include "stdlib.h"
#include "mpi.h"
#include "math.h"
#include "omp.h"
#include "time.h"

#define PI 3.14159265358979323846

int main(int argc , char ** argv){
int size,rank,dnorg;
/*int n=(int)pow(2,24);*/
int input=atoi(argv[1]);
int n=atoi(argv[2]);
double S=0.0,S2=0.0;
double z1=0.2, z2=1.0/239.0;
double *v,*v2;
struct timespec start, finish;
clock_gettime(CLOCK_REALTIME, &start);
MPI_Init(&argc,&argv);
MPI_Comm_size(MPI_COMM_WORLD,&size);
MPI_Comm_rank(MPI_COMM_WORLD,&rank);
if((n!=0) && ((n & (n-1))==0)){
if(rank==0){
for(int j=1; j<size; j++){
dnorg=((j+1)*n)/size-(j*n)/size;
v=(double *)malloc(sizeof(double)*(int)(dnorg));
v2=(double *)malloc(sizeof(double)*(int)(dnorg));
for(int i=1; i<1+dnorg; i++){
v2[i-1]=pow(-1,i+(j*n)/size-1)*pow(z2,2*(i+(j*n)/size)-1)/(2*(i+(j*n)/size)-1);
v[i-1]=pow(-1,i+(j*n)/size-1)*pow(z1,2*(i+(j*n)/size)-1)/(2*(i+(j*n)/size)-1);
}
MPI_Send(v,dnorg,MPI_DOUBLE,j,0,MPI_COMM_WORLD);
MPI_Send(v2,dnorg,MPI_DOUBLE,j,1,MPI_COMM_WORLD);
free(v);
free(v2);
double *v,*v2;}
dnorg=n/size;
/*printf("%d%d%d\n",n,size,dnorg);*/
v=(double *)malloc(sizeof(double)*(int)(dnorg));
v2=(double *)malloc(sizeof(double)*(int)(dnorg));
for(int i=1; i<1+dnorg; i++){
v2[i-1]=pow(-1,i-1)*pow(z2,2*i-1)/(2*i-1);
v[i-1]=pow(-1,i-1)*pow(z1,2*i-1)/(2*i-1);}}
else{
dnorg=((rank+1)*n)/size-(rank*n)/size;
v=(double *)malloc(sizeof(double)*(int)(dnorg));
v2=(double *)malloc(sizeof(double)*(int)(dnorg));
MPI_Recv(v,dnorg,MPI_DOUBLE,0,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
MPI_Recv(v2,dnorg,MPI_DOUBLE,0,1,MPI_COMM_WORLD,MPI_STATUS_IGNORE);}
/*printf("Rank: %d, and v[0]: %.18f\t, and v2[0]: %.18f\n",rank,v[0],v2[0]);*/
if(input==0){
if(rank>0){
for(int i=0;i<dnorg;i++){
S=S+v[i];
S2=S2+v2[i];}
MPI_Send(&S,1,MPI_DOUBLE,0,0,MPI_COMM_WORLD);
MPI_Send(&S2,1,MPI_DOUBLE,0,1,MPI_COMM_WORLD);}
if(rank==0){
double S3=0.0,S4=0.0;
for(int i=0;i<dnorg;i++){
S=S+v[i];
S2=S2+v2[i];}
for(int i=1; i<size; i++){
MPI_Recv(&S3,1,MPI_DOUBLE,i,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
MPI_Recv(&S4,1,MPI_DOUBLE,i,1,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
S=S+S3;
S2=S2+S4;}
/*printf("\n##########   MPI implementation for mach  ###########\n\n");*/
clock_gettime(CLOCK_REALTIME, &finish);
double time_spent = (double)((finish.tv_sec+finish.tv_nsec*1e-9) - (double)(start.tv_sec+start.tv_nsec*1e-9));
printf("Mach mpi: Error: P=%d and n=%d is %.18f with time: %.9f\n",size,n,fabs(16*S-4*S2-PI),time_spent);}}
/*if(rank==0){
for(int i=0; i<n/size;i++){
printf("%f\t",v[i]);}
printf("\n");}*/

/*Reduction,(all processes should store the global sum)*/
if(input==1){
/*printf("%d\n",dnorg);*/
double *v3,*v4;
v3=(double *)malloc(sizeof(double)*(int)(dnorg));
v4=(double *)malloc(sizeof(double)*(int)(dnorg));
MPI_Allreduce(v,v3,dnorg,MPI_DOUBLE,MPI_SUM,MPI_COMM_WORLD);
MPI_Allreduce(v2,v4,dnorg,MPI_DOUBLE,MPI_SUM,MPI_COMM_WORLD);
for(int i=0;i<dnorg;i++){
S=S+v3[i];
S2=S2+v4[i];}
clock_gettime(CLOCK_REALTIME, &finish);
if(rank==0){
double time_spent = (double)((finish.tv_sec+finish.tv_nsec*1e-9) - (double)(start.tv_sec+start.tv_nsec*1e-9));
printf("Mach reduc: Error: P=%d and n=%d is %.18f with time: %.9f\n",size,n,fabs(16*S-4*S2-PI),time_spent);}
free(v3);
free(v4);}
free(v);
free(v2);}
/*printf("%f\n",pow(-1,1-1)*pow(z1,2*1-1)/(2*1-1));*/
else{
if(rank==0){
printf("ABORT! INPUT NOT POWER OF 2\n");}}
MPI_Finalize();
}
