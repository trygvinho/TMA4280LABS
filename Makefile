output: zeta0.o mach0.o zeta1.o mach1.o mach2.o zeta2.o
	gcc zeta0.o -o output -lm
	mpicc mach1.o -o outpat2 -lm
	gcc mach0.o -o outpat -lm
	mpicc zeta1.o -o output2 -lm
	mpicc -fopenmp zeta2.o -o output3 -lm
	mpicc -fopenmp mach2.o -o outpat3 -lm

zeta0.o: zeta0.c
	gcc -c zeta0.c -lm

mach0.o: mach0.c
	gcc -c mach0.c -lm

zeta1.o: zeta1.c
	mpicc -c zeta1.c -lm

mach1.o: mach1.c
	mpicc -c mach1.c -lm

zeta2.o: zeta2.c
	mpicc -c zeta2.c -lm

mach2.o: mach2.c
	mpicc -c mach2.c -lm

utest: output outpat
	./output 3 0
	./outpat 3 0

vtest: output outpat
	./output 16 1
	./outpat 16 1

mpi: output2 outpat2
	mpirun -n 1 ./output2 0 8
	mpirun -n 2 ./output2 0 8
	mpirun -n 8 ./output2 0 8
	mpirun -n 1 ./output2 0 64
	mpirun -n 2 ./output2 0 64
	mpirun -n 8 ./output2 0 64
	mpirun -n 1 ./output2 0 512
	mpirun -n 2 ./output2 0 512
	mpirun -n 8 ./output2 0 512
	mpirun -n 1 ./output2 0 4096
	mpirun -n 2 ./output2 0 4096
	mpirun -n 8 ./output2 0 4096
	mpirun -n 1 ./output2 0 32768
	mpirun -n 2 ./output2 0 32768
	mpirun -n 8 ./output2 0 32768
	mpirun -n 1 ./output2 0 262144
	mpirun -n 2 ./output2 0 262144
	mpirun -n 8 ./output2 0 262144
	mpirun -n 1 ./output2 0 2097152
	mpirun -n 2 ./output2 0 2097152
	mpirun -n 8 ./output2 0 2097152
	mpirun -n 1 ./output2 0 16777216
	mpirun -n 2 ./output2 0 16777216
	mpirun -n 8 ./output2 0 16777216
	mpirun -n 1 ./outpat2 0 8
	mpirun -n 2 ./outpat2 0 8
	mpirun -n 8 ./outpat2 0 8
	mpirun -n 1 ./outpat2 0 64
	mpirun -n 2 ./outpat2 0 64
	mpirun -n 8 ./outpat2 0 64
	mpirun -n 1 ./outpat2 0 512
	mpirun -n 2 ./outpat2 0 512
	mpirun -n 8 ./outpat2 0 512
	mpirun -n 1 ./outpat2 0 4096
	mpirun -n 2 ./outpat2 0 4096
	mpirun -n 8 ./outpat2 0 4096
	mpirun -n 1 ./outpat2 0 32768
	mpirun -n 2 ./outpat2 0 32768
	mpirun -n 8 ./outpat2 0 32768
	mpirun -n 1 ./outpat2 0 262144
	mpirun -n 2 ./outpat2 0 262144
	mpirun -n 8 ./outpat2 0 262144
	mpirun -n 1 ./outpat2 0 2097152
	mpirun -n 2 ./outpat2 0 2097152
	mpirun -n 8 ./outpat2 0 2097152
	mpirun -n 1 ./outpat2 0 16777216
	mpirun -n 2 ./outpat2 0 16777216
	mpirun -n 8 ./outpat2 0 16777216

reduc: outpat2 output2
	mpirun -n 1 ./output2 1 8
	mpirun -n 2 ./output2 1 8
	mpirun -n 8 ./output2 1 8
	mpirun -n 1 ./output2 1 64
	mpirun -n 2 ./output2 1 64
	mpirun -n 8 ./output2 1 64
	mpirun -n 1 ./output2 1 512
	mpirun -n 2 ./output2 1 512
	mpirun -n 8 ./output2 1 512
	mpirun -n 1 ./output2 1 4096
	mpirun -n 2 ./output2 1 4096
	mpirun -n 8 ./output2 1 4096
	mpirun -n 1 ./output2 1 32768
	mpirun -n 2 ./output2 1 32768
	mpirun -n 8 ./output2 1 32768
	mpirun -n 1 ./output2 1 262144
	mpirun -n 2 ./output2 1 262144
	mpirun -n 8 ./output2 1 262144
	mpirun -n 1 ./output2 1 2097152
	mpirun -n 2 ./output2 1 2097152
	mpirun -n 8 ./output2 1 2097152
	mpirun -n 1 ./output2 1 16777216
	mpirun -n 2 ./output2 1 16777216
	mpirun -n 8 ./output2 1 16777216
	mpirun -n 1 ./outpat2 1 8
	mpirun -n 2 ./outpat2 1 8
	mpirun -n 8 ./outpat2 1 8
	mpirun -n 1 ./outpat2 1 64
	mpirun -n 2 ./outpat2 1 64
	mpirun -n 8 ./outpat2 1 64
	mpirun -n 1 ./outpat2 1 512
	mpirun -n 2 ./outpat2 1 512
	mpirun -n 8 ./outpat2 1 512
	mpirun -n 1 ./outpat2 1 4096
	mpirun -n 2 ./outpat2 1 4096
	mpirun -n 8 ./outpat2 1 4096
	mpirun -n 1 ./outpat2 1 32768
	mpirun -n 2 ./outpat2 1 32768
	mpirun -n 8 ./outpat2 1 32768
	mpirun -n 1 ./outpat2 1 262144
	mpirun -n 2 ./outpat2 1 262144
	mpirun -n 8 ./outpat2 1 262144
	mpirun -n 1 ./outpat2 1 2097152
	mpirun -n 2 ./outpat2 1 2097152
	mpirun -n 8 ./outpat2 1 2097152
	mpirun -n 1 ./outpat2 1 16777216
	mpirun -n 2 ./outpat2 1 16777216
	mpirun -n 8 ./outpat2 1 16777216

openmpi: outpat3 output3
	OMP_NUM_THREADS=1 mpirun -n 1 ./output3 3
	OMP_NUM_THREADS=1 mpirun -n 2 ./output3 3
	OMP_NUM_THREADS=1 mpirun -n 8 ./output3 3
	OMP_NUM_THREADS=2 mpirun -n 1 ./output3 3
	OMP_NUM_THREADS=2 mpirun -n 2 ./output3 3
	OMP_NUM_THREADS=2 mpirun -n 8 ./output3 3
	OMP_NUM_THREADS=4 mpirun -n 1 ./output3 3
	OMP_NUM_THREADS=4 mpirun -n 2 ./output3 3
	OMP_NUM_THREADS=4 mpirun -n 8 ./output3 3
	OMP_NUM_THREADS=8 mpirun -n 1 ./output3 3
	OMP_NUM_THREADS=8 mpirun -n 2 ./output3 3
	OMP_NUM_THREADS=8 mpirun -n 8 ./output3 3	
	OMP_NUM_THREADS=1 mpirun -n 1 ./output3 6
	OMP_NUM_THREADS=1 mpirun -n 2 ./output3 6
	OMP_NUM_THREADS=1 mpirun -n 8 ./output3 6
	OMP_NUM_THREADS=2 mpirun -n 1 ./output3 6
	OMP_NUM_THREADS=2 mpirun -n 2 ./output3 6
	OMP_NUM_THREADS=2 mpirun -n 8 ./output3 6
	OMP_NUM_THREADS=4 mpirun -n 1 ./output3 6
	OMP_NUM_THREADS=4 mpirun -n 2 ./output3 6
	OMP_NUM_THREADS=4 mpirun -n 8 ./output3 6
	OMP_NUM_THREADS=8 mpirun -n 1 ./output3 6
	OMP_NUM_THREADS=8 mpirun -n 2 ./output3 6
	OMP_NUM_THREADS=8 mpirun -n 8 ./output3 6
	OMP_NUM_THREADS=1 mpirun -n 1 ./output3 9
	OMP_NUM_THREADS=1 mpirun -n 2 ./output3 9
	OMP_NUM_THREADS=1 mpirun -n 8 ./output3 9
	OMP_NUM_THREADS=2 mpirun -n 1 ./output3 9
	OMP_NUM_THREADS=2 mpirun -n 2 ./output3 9
	OMP_NUM_THREADS=2 mpirun -n 8 ./output3 9
	OMP_NUM_THREADS=4 mpirun -n 1 ./output3 9
	OMP_NUM_THREADS=4 mpirun -n 2 ./output3 9
	OMP_NUM_THREADS=4 mpirun -n 8 ./output3 9
	OMP_NUM_THREADS=8 mpirun -n 1 ./output3 9
	OMP_NUM_THREADS=8 mpirun -n 2 ./output3 9
	OMP_NUM_THREADS=8 mpirun -n 8 ./output3 9
	OMP_NUM_THREADS=1 mpirun -n 1 ./output3 12
	OMP_NUM_THREADS=1 mpirun -n 2 ./output3 12
	OMP_NUM_THREADS=1 mpirun -n 8 ./output3 12
	OMP_NUM_THREADS=2 mpirun -n 1 ./output3 12
	OMP_NUM_THREADS=2 mpirun -n 2 ./output3 12
	OMP_NUM_THREADS=2 mpirun -n 8 ./output3 12
	OMP_NUM_THREADS=4 mpirun -n 1 ./output3 12
	OMP_NUM_THREADS=4 mpirun -n 2 ./output3 12
	OMP_NUM_THREADS=4 mpirun -n 8 ./output3 12
	OMP_NUM_THREADS=8 mpirun -n 1 ./output3 12
	OMP_NUM_THREADS=8 mpirun -n 2 ./output3 12
	OMP_NUM_THREADS=8 mpirun -n 8 ./output3 12
	OMP_NUM_THREADS=1 mpirun -n 1 ./output3 15
	OMP_NUM_THREADS=1 mpirun -n 2 ./output3 15
	OMP_NUM_THREADS=1 mpirun -n 8 ./output3 15
	OMP_NUM_THREADS=2 mpirun -n 1 ./output3 15
	OMP_NUM_THREADS=2 mpirun -n 2 ./output3 15
	OMP_NUM_THREADS=2 mpirun -n 8 ./output3 15
	OMP_NUM_THREADS=4 mpirun -n 1 ./output3 15
	OMP_NUM_THREADS=4 mpirun -n 2 ./output3 15
	OMP_NUM_THREADS=4 mpirun -n 8 ./output3 15
	OMP_NUM_THREADS=8 mpirun -n 1 ./output3 15
	OMP_NUM_THREADS=8 mpirun -n 2 ./output3 15
	OMP_NUM_THREADS=8 mpirun -n 8 ./output3 15
	OMP_NUM_THREADS=1 mpirun -n 1 ./output3 18
	OMP_NUM_THREADS=1 mpirun -n 2 ./output3 18
	OMP_NUM_THREADS=1 mpirun -n 8 ./output3 18
	OMP_NUM_THREADS=2 mpirun -n 1 ./output3 18
	OMP_NUM_THREADS=2 mpirun -n 2 ./output3 18
	OMP_NUM_THREADS=2 mpirun -n 8 ./output3 18
	OMP_NUM_THREADS=4 mpirun -n 1 ./output3 18
	OMP_NUM_THREADS=4 mpirun -n 2 ./output3 18
	OMP_NUM_THREADS=4 mpirun -n 8 ./output3 18
	OMP_NUM_THREADS=8 mpirun -n 1 ./output3 18
	OMP_NUM_THREADS=8 mpirun -n 2 ./output3 18
	OMP_NUM_THREADS=8 mpirun -n 8 ./output3 18
	OMP_NUM_THREADS=1 mpirun -n 1 ./output3 21
	OMP_NUM_THREADS=1 mpirun -n 2 ./output3 21
	OMP_NUM_THREADS=1 mpirun -n 8 ./output3 21
	OMP_NUM_THREADS=2 mpirun -n 1 ./output3 21
	OMP_NUM_THREADS=2 mpirun -n 2 ./output3 21
	OMP_NUM_THREADS=2 mpirun -n 8 ./output3 21
	OMP_NUM_THREADS=4 mpirun -n 1 ./output3 21
	OMP_NUM_THREADS=4 mpirun -n 2 ./output3 21
	OMP_NUM_THREADS=4 mpirun -n 8 ./output3 21
	OMP_NUM_THREADS=8 mpirun -n 1 ./output3 21
	OMP_NUM_THREADS=8 mpirun -n 2 ./output3 21
	OMP_NUM_THREADS=8 mpirun -n 8 ./output3 21
	OMP_NUM_THREADS=1 mpirun -n 1 ./output3 24
	OMP_NUM_THREADS=1 mpirun -n 2 ./output3 24
	OMP_NUM_THREADS=1 mpirun -n 8 ./output3 24
	OMP_NUM_THREADS=2 mpirun -n 1 ./output3 24
	OMP_NUM_THREADS=2 mpirun -n 2 ./output3 24
	OMP_NUM_THREADS=2 mpirun -n 8 ./output3 24
	OMP_NUM_THREADS=4 mpirun -n 1 ./output3 24
	OMP_NUM_THREADS=4 mpirun -n 2 ./output3 24
	OMP_NUM_THREADS=4 mpirun -n 8 ./output3 24
	OMP_NUM_THREADS=8 mpirun -n 1 ./output3 24
	OMP_NUM_THREADS=8 mpirun -n 2 ./output3 24
	OMP_NUM_THREADS=8 mpirun -n 8 ./output3 24
	OMP_NUM_THREADS=1 mpirun -n 1 ./outpat3 3
	OMP_NUM_THREADS=1 mpirun -n 2 ./outpat3 3
	OMP_NUM_THREADS=1 mpirun -n 8 ./outpat3 3
	OMP_NUM_THREADS=2 mpirun -n 1 ./outpat3 3
	OMP_NUM_THREADS=2 mpirun -n 2 ./outpat3 3
	OMP_NUM_THREADS=2 mpirun -n 8 ./outpat3 3
	OMP_NUM_THREADS=4 mpirun -n 1 ./outpat3 3
	OMP_NUM_THREADS=4 mpirun -n 2 ./outpat3 3
	OMP_NUM_THREADS=4 mpirun -n 8 ./outpat3 3
	OMP_NUM_THREADS=8 mpirun -n 1 ./outpat3 3
	OMP_NUM_THREADS=8 mpirun -n 2 ./outpat3 3
	OMP_NUM_THREADS=8 mpirun -n 8 ./outpat3 3	
	OMP_NUM_THREADS=1 mpirun -n 1 ./outpat3 6
	OMP_NUM_THREADS=1 mpirun -n 2 ./outpat3 6
	OMP_NUM_THREADS=1 mpirun -n 8 ./outpat3 6
	OMP_NUM_THREADS=2 mpirun -n 1 ./outpat3 6
	OMP_NUM_THREADS=2 mpirun -n 2 ./outpat3 6
	OMP_NUM_THREADS=2 mpirun -n 8 ./outpat3 6
	OMP_NUM_THREADS=4 mpirun -n 1 ./outpat3 6
	OMP_NUM_THREADS=4 mpirun -n 2 ./outpat3 6
	OMP_NUM_THREADS=4 mpirun -n 8 ./outpat3 6
	OMP_NUM_THREADS=8 mpirun -n 1 ./outpat3 6
	OMP_NUM_THREADS=8 mpirun -n 2 ./outpat3 6
	OMP_NUM_THREADS=8 mpirun -n 8 ./outpat3 6
	OMP_NUM_THREADS=1 mpirun -n 1 ./outpat3 9
	OMP_NUM_THREADS=1 mpirun -n 2 ./outpat3 9
	OMP_NUM_THREADS=1 mpirun -n 8 ./outpat3 9
	OMP_NUM_THREADS=2 mpirun -n 1 ./outpat3 9
	OMP_NUM_THREADS=2 mpirun -n 2 ./outpat3 9
	OMP_NUM_THREADS=2 mpirun -n 8 ./outpat3 9
	OMP_NUM_THREADS=4 mpirun -n 1 ./outpat3 9
	OMP_NUM_THREADS=4 mpirun -n 2 ./outpat3 9
	OMP_NUM_THREADS=4 mpirun -n 8 ./outpat3 9
	OMP_NUM_THREADS=8 mpirun -n 1 ./outpat3 9
	OMP_NUM_THREADS=8 mpirun -n 2 ./outpat3 9
	OMP_NUM_THREADS=8 mpirun -n 8 ./outpat3 9
	OMP_NUM_THREADS=1 mpirun -n 1 ./outpat3 12
	OMP_NUM_THREADS=1 mpirun -n 2 ./outpat3 12
	OMP_NUM_THREADS=1 mpirun -n 8 ./outpat3 12
	OMP_NUM_THREADS=2 mpirun -n 1 ./outpat3 12
	OMP_NUM_THREADS=2 mpirun -n 2 ./outpat3 12
	OMP_NUM_THREADS=2 mpirun -n 8 ./outpat3 12
	OMP_NUM_THREADS=4 mpirun -n 1 ./outpat3 12
	OMP_NUM_THREADS=4 mpirun -n 2 ./outpat3 12
	OMP_NUM_THREADS=4 mpirun -n 8 ./outpat3 12
	OMP_NUM_THREADS=8 mpirun -n 1 ./outpat3 12
	OMP_NUM_THREADS=8 mpirun -n 2 ./outpat3 12
	OMP_NUM_THREADS=8 mpirun -n 8 ./outpat3 12
	OMP_NUM_THREADS=1 mpirun -n 1 ./outpat3 15
	OMP_NUM_THREADS=1 mpirun -n 2 ./outpat3 15
	OMP_NUM_THREADS=1 mpirun -n 8 ./outpat3 15
	OMP_NUM_THREADS=2 mpirun -n 1 ./outpat3 15
	OMP_NUM_THREADS=2 mpirun -n 2 ./outpat3 15
	OMP_NUM_THREADS=2 mpirun -n 8 ./outpat3 15
	OMP_NUM_THREADS=4 mpirun -n 1 ./outpat3 15
	OMP_NUM_THREADS=4 mpirun -n 2 ./outpat3 15
	OMP_NUM_THREADS=4 mpirun -n 8 ./outpat3 15
	OMP_NUM_THREADS=8 mpirun -n 1 ./outpat3 15
	OMP_NUM_THREADS=8 mpirun -n 2 ./outpat3 15
	OMP_NUM_THREADS=8 mpirun -n 8 ./outpat3 15
	OMP_NUM_THREADS=1 mpirun -n 1 ./outpat3 18
	OMP_NUM_THREADS=1 mpirun -n 2 ./outpat3 18
	OMP_NUM_THREADS=1 mpirun -n 8 ./outpat3 18
	OMP_NUM_THREADS=2 mpirun -n 1 ./outpat3 18
	OMP_NUM_THREADS=2 mpirun -n 2 ./outpat3 18
	OMP_NUM_THREADS=2 mpirun -n 8 ./outpat3 18
	OMP_NUM_THREADS=4 mpirun -n 1 ./outpat3 18
	OMP_NUM_THREADS=4 mpirun -n 2 ./outpat3 18
	OMP_NUM_THREADS=4 mpirun -n 8 ./outpat3 18
	OMP_NUM_THREADS=8 mpirun -n 1 ./outpat3 18
	OMP_NUM_THREADS=8 mpirun -n 2 ./outpat3 18
	OMP_NUM_THREADS=8 mpirun -n 8 ./outpat3 18
	OMP_NUM_THREADS=1 mpirun -n 1 ./outpat3 21
	OMP_NUM_THREADS=1 mpirun -n 2 ./outpat3 21
	OMP_NUM_THREADS=1 mpirun -n 8 ./outpat3 21
	OMP_NUM_THREADS=2 mpirun -n 1 ./outpat3 21
	OMP_NUM_THREADS=2 mpirun -n 2 ./outpat3 21
	OMP_NUM_THREADS=2 mpirun -n 8 ./outpat3 21
	OMP_NUM_THREADS=4 mpirun -n 1 ./outpat3 21
	OMP_NUM_THREADS=4 mpirun -n 2 ./outpat3 21
	OMP_NUM_THREADS=4 mpirun -n 8 ./outpat3 21
	OMP_NUM_THREADS=8 mpirun -n 1 ./outpat3 21
	OMP_NUM_THREADS=8 mpirun -n 2 ./outpat3 21
	OMP_NUM_THREADS=8 mpirun -n 8 ./outpat3 21
	OMP_NUM_THREADS=1 mpirun -n 1 ./outpat3 24
	OMP_NUM_THREADS=1 mpirun -n 2 ./outpat3 24
	OMP_NUM_THREADS=1 mpirun -n 8 ./outpat3 24
	OMP_NUM_THREADS=2 mpirun -n 1 ./outpat3 24
	OMP_NUM_THREADS=2 mpirun -n 2 ./outpat3 24
	OMP_NUM_THREADS=2 mpirun -n 8 ./outpat3 24
	OMP_NUM_THREADS=4 mpirun -n 1 ./outpat3 24
	OMP_NUM_THREADS=4 mpirun -n 2 ./outpat3 24
	OMP_NUM_THREADS=4 mpirun -n 8 ./outpat3 24
	OMP_NUM_THREADS=8 mpirun -n 1 ./outpat3 24
	OMP_NUM_THREADS=8 mpirun -n 2 ./outpat3 24
	OMP_NUM_THREADS=8 mpirun -n 8 ./outpat3 24

clean:
	rm *.o output outpat outpat2 output2 output3 outpat3

