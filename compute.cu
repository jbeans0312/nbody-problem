#include <stdlib.h>
#include <math.h>
#include <cuda_runtime.h>
#include "cuda.h"
#include "vector.h"
#include "config.h"

//Global values and accelerations
vector3* vals;
vector3** accels;

//Parallel implementation
__global__ void parallelCompute(vector3* vals, vector3** accels, vector3* d_vel, vector3* d_pos, double* d_mass){
}

//Memory allocation and driver code
void compute(){
}