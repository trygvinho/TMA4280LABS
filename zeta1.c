#include "stdio.h"
#include "math.h"
#include "stdlib.h"
#include "mpi.h"
#include "math.h"
#include "time.h"

#define PI 3.14159265358979323846

int main(int argc , char ** argv){
int size,rank,dnorg;
/*int n=(int)pow(2,24);*/
int input=atoi(argv[1]);
int n=atoi(argv[2]);
double S=0.0;
double *v;
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
for(int i=1; i<1+dnorg; i++){
v[i-1]=1/pow(i+(j*n)/size,2);}
MPI_Send(v,dnorg,MPI_DOUBLE,j,0,MPI_COMM_WORLD);
free(v);
double *v;}
dnorg=n/size;
v=(double *)malloc(sizeof(double)*(int)(dnorg));
for(int i=1; i<1+dnorg; i++){
v[i-1]=1/pow(i,2);}}
else{
dnorg=((rank+1)*n)/size-(rank*n)/size;
v=(double *)malloc(sizeof(double)*(int)(dnorg));
MPI_Recv(v,dnorg,MPI_DOUBLE,0,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);}
/*printf("Rank: %d, and v[0]: %.18f\n",rank,v[0]);*/
if(input==0){
if(rank>0){
for(int i=0;i<dnorg;i++){
S=S+v[i];}
MPI_Send(&S,1,MPI_DOUBLE,0,0,MPI_COMM_WORLD);}
if(rank==0){
double S2=0.0;
for(int i=0;i<dnorg;i++){
S=S+v[i];}
for(int i=1; i<size; i++){
MPI_Recv(&S2,1,MPI_DOUBLE,i,0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
S=S+S2;}
/*printf("\n##########   MPI implementation for zeta  ###########\n\n");*/
clock_gettime(CLOCK_REALTIME, &finish);
double time_spent = (double)((finish.tv_sec+finish.tv_nsec*1e-9) - (double)(start.tv_sec+start.tv_nsec*1e-9));
printf("Zeta mpi: Error: P=%d and n=%d is %.18f with time: %.9f\n",size,n,fabs(sqrt(6*S)-PI),time_spent);}}
/*if(rank==0){
for(int i=0; i<n/size;i++){
printf("%f\t",v[i]);}
printf("\n");}*/

/*Reduction,(all processes should store the global sum)*/
if(input==1){
/*printf("%d\n",dnorg);*/
double *v2;
v2=(double *)malloc(sizeof(double)*(int)(dnorg));
MPI_Allreduce(v,v2,dnorg,MPI_DOUBLE,MPI_SUM,MPI_COMM_WORLD);
for(int i=0;i<dnorg;i++){
S=S+v2[i];}
clock_gettime(CLOCK_REALTIME, &finish);
if(rank==0){
double time_spent = (double)((finish.tv_sec+finish.tv_nsec*1e-9) - (double)(start.tv_sec+start.tv_nsec*1e-9));
printf("Zeta reduc: Error: P=%d and n=%d is %.18f with time: %.9f\n",size,n,fabs(sqrt(6*S)-PI),time_spent);}
free(v2);}
free(v);}
else{
if(rank==0){
printf("ABORT! INPUT NOT POWER OF 2\n");}}
MPI_Finalize();
}
