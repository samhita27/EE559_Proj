% w=pegasos(X,Y,lambda,nepochs)
% Solve the SVM optimization problem without kernels:
%  w = argmin lambda w'*w + 1/m * sum(max(0,1-Y.*X*w))
% Input:
%  X - matrix of instances (each row is an instance)
%  Y - column vector of labels over {+1,-1}
%  lambda - scalar
%  nepochs - how many times to go over the training set
% Output: 
%  w - column vector of weights
%  Written by Shai Shalev-Shwartz, HUJI
function w=pegasos(X,Y,lambda,nepochs)


[m,d] = size(X);
w = zeros(d,1);
t = 1;
for (i=1:nepochs)      % iterations over the full data
    for (tau=1:m)      % pick a single data point
        if (Y(tau).*X(tau,:)*w < 1)   % distance of data point
                                     % from  separator is to small          
                                     % or data point is at the other side of the separator.
            % take a step towards the gradient
            w = (1-1/t)*w + 1/(lambda*t)*Y(tau)*X(tau,:)';
        else
            w = (1-1/t)*w;
        end
        t=t+1;         % increment counter
    end
end