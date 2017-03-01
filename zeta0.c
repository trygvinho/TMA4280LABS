#include "stdio.h"
#include "math.h"
#include "stdlib.h"
#include "math.h"

#define PI 3.14159265358979323846

int main(int argc , char ** argv){
int n=atoi(argv[1]),k=1;
int input=atoi(argv[2]);
double S=0.0;
if(input==0){
double svar1=1.361111111111111;
printf("\n##########   utest for zeta  ###########\n\n");
for(int i=1; i<n+1; i++){
S=S+1/pow(i,2);}
printf("The value for the approx. of pi*pi/6 for n=%d is %.12f\n",n,S);
printf("The respective error from S_3 computed by hand will be %.15f\n",fabs(S-svar1));
printf("\n");}
if(input==1){
printf("\n##########   vtest for zeta  ###########\n\n");
FILE *f=fopen("verificationtestzeta.txt","w");
fprintf(f,"\n##########   vtest for zeta  ###########\n\n");
for(int i=1; i<pow(2,24)+1; i++){
S=S+1/pow(i,2);
if(i%(int)pow(2,k)==0){
printf("For k=%d we have an error of pi which is %.18f\n",k,fabs(PI-sqrt(6*S)));
fprintf(f,"For k=%d we have an error of pi which is %.18f\n",k,fabs(PI-sqrt(6*S)));
k=k+1;}}
fclose(f);}
}
