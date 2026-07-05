#include<bits/stdc++.h>
using namespace std;

set<pair<int, pair<int, int>>> P;
mt19937 RNG;

int main(int argc, char * argv[]){
    RNG.seed(atoi(argv[1]));
    int N = atoi(argv[2]);
    cout << N << "\n";
    for(int i = 0; i < N; ++i){
        int A = RNG() % 2000001;
        int B = RNG() % 2000001;
        int C = RNG() % 2000001;
        int D = RNG() % 2000001;
        int E = RNG() % 2000001;
        int F = RNG() % 2000001;
        int G = RNG() % 2000000+1;
        while(P.count({A, {B, C}})){
            int A = RNG() % 2000001;
            int B = RNG() % 2000001;
            int C = RNG() % 2000001;
        }
        A-=1000000;
        B-=1000000;
        C-=1000000;
        D-=1000000;
        E-=1000000;
        F-=1000000;
        cout << A << " " << B << " " << C << " " << D << " " << E << " " << F << " " << G << "\n";
    }
}