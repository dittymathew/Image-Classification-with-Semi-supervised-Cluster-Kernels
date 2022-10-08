function [ normX ] = Xnorm( Xip, newMax, newMin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


Minval = min(Xip);
Maxval = max(Xip);
normX = zeros(size(Xip));
for i=1:length(Xip)
    for j =1: length(Minval)
    normX(i,j)=(Xip(i,j)-Minval(j))*((newMax-newMin)/(Maxval(j)-Minval(j)))+newMin;
   % x(i,j)=(XC1(i,j)-Minval(j))/(Maxval(j)-Minval(j));
%     func(i,1)=exp(tanh(2*pi*x(i,1)));
%     target(i,1)=func(i,1)+errornum(i,1);
    end
end

end