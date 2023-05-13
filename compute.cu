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
    int myId = blockIdx.x * blockDim.x + threadId.x
    int i = myId / NUMENTITIES;
    int j = myId % NUMENTITIES

    accels[myId] = &values[myId*NUMENTITIES];

    if(myId < NUMENTITIES * NUMENTITIES){
        if(i == j){
            FILL_VECTOR(accels[i][j],0,0,0);
        }else{
            vector3 distance;

            //calculate distance in 3D
            distance[0]=d_pos[i][0]-d_pos[j][0];
            distance[1]=d_pos[i][1]-d_pos[j][1];
            distance[2]=d_pos[i][2]-d_pos[j][2];

            //calculate acceleration values
            //fun fun fun physics calculation stuff
            double magnitude_sq=distance[0]*distance[0]+distance[1]*distance[1]+distance[2]*distance[2];
            double magnitude=sqrt(magnitude_sq);
			double accelmag=-1*GRAV_CONSTANT*d_mass[j]/magnitude_sq;
            FILL_VECTOR(accels[i][j],accelmag*distance[0]/magnitude,accelmag*distance[1]/magnitude,accelmag*distance[2]/magnitude);
        }

        vector3 accel_sum = {(double) *(accels[myId])[0], (double) *(accels[myId])[1], (double) *(accels[myId])[2]};

        d_vel[i][0]+=accel_sum[0]*INTERVAL;
		d_pos[i][0]=d_vel[i][0]*INTERVAL;

		d_vel[i][1]+=accel_sum[1]*INTERVAL;
		d_pos[i][1]=d_vel[i][1]*INTERVAL;

		d_vel[i][2]+=accel_sum[2]*INTERVAL;
		d_pos[i][2]=d_vel[i][2]*INTERVAL;
    }
}


//Memory allocation and driver code
void compute(){
}