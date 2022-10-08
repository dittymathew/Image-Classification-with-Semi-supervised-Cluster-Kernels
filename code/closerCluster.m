function res = closerCluster(data,C,k)

    
   distmatrix = L2_distance(data',C');
   [temp,res] =min(distmatrix,[],2);
   
   
   

