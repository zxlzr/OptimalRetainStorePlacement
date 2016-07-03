%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fisher's Linear Discriminant Analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
% Obtaining Sb and Sw
cMean = zeros(M-k,M-k);
Sb = zeros(M-k,M-k);
Sw = zeros(M-k,M-k);

pcaMean = mean(Wpca,2);

for i = 1:k
    cMean = mean(Wpca(:,n*i-(n-1):n*i),2);
    Sb = Sb + (cMean-pcaMean)*(cMean-pcaMean)';
end

Sb = n*Sb;

for i = 1:k
    cMean = mean(Wpca(:,n*i-(n-1):n*i),2);
    for j = n*i-(n-1):n*i
         Sw = Sw + (Wpca(:,j)-cMean)*(Wpca(:,j)-cMean)';
    end
end

% Obtaining Fisher eigenvectors and eigenvalues
[Vf, Df] = eig(Sb,Sw);

% Calculating weights
 Df = fliplr(diag(Df));
 Vf = fliplr(Vf);

% Calculating fisher weights
Wf = Vf'*Wpca;