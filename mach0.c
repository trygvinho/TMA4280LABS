#include "stdio.h"
#include "math.h"
#include "stdlib.h"
#include "math.h"

#define PI 3.141592653589793238462643383279502884197169399375105820974944

int main(int argc , char ** argv){
int n=atoi(argv[1]),k=1;
int input=atoi(argv[2]);
double S1=0.0,S2=0.0;
double z1=0.2, z2=1.0/239.0;
if(input==0){
double svar1=0.197397333333333, svar2=0.004184076002075;
printf("\n##########   utest for mach  ###########\n\n");
for(int i=1; i<n+1; i++){
double k=(double) i;
S1=S1+pow(-1.0,k-1.0)*pow(z1,2.0*k-1)/(2.0*k-1.0);
S2=S2+pow(-1.0,k-1.0)*pow(z2,2.0*k-1)/(2.0*k-1.0);}
printf("The value for the approx. of atan(1/5) and atan(1/239),\n for n=%d are %.12f and %.12f\n",n,S1,S2);
printf("The respective error from S_3 computed by hand will be %.15f,\n for atan(1/5) and %.15f for atan(1/239)\n",fabs(S1-svar1),fabs(S2-svar2));
printf("\n");}
if(input==1){
printf("\n##########   vtest for mach  ###########\n\n");
FILE *f=fopen("verificationtestmach.txt","w");
fprintf(f,"\n##########   vtest for mach  ###########\n\n");
for(int i=1; i<pow(2,24)+1; i++){
double k2=(double) i;
S1=S1+pow(-1.0,k2-1.0)*pow(z1,2.0*k2-1.0)/(2.0*k2-1.0);
S2=S2+pow(-1.0,k2-1.0)*pow(z2,2.0*k2-1.0)/(2.0*k2-1.0);
if(i%(int)pow(2,k)==0){
printf("For k=%d we have an error of pi which is %.18f\n",k,fabs(PI-(16*S1-4*S2)));
fprintf(f,"For k=%d we have an error of pi which is %.18f\n",k,fabs(PI-(16*S1-4*S2)));
k=k+1;}}
fclose(f);}
printf("\n");
/*printf("%f\t%f\n",S1,S2);*/

}
