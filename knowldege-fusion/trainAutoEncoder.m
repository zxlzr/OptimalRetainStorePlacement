

clear all
close all

maxepoch=30; %In the Science paper we use maxepoch=50, but it works just fine. 
numhid=1024; numpen=512; numpen2=256; numopen=32;
%numhid = 500; numpen = 250; numpen2 = 128; numopen = 64;

%fprintf(1,'Converting Raw files into Matlab format \n');
%converter; 

fprintf(1,'Pretraining a deep autoencoder. \n');
fprintf(1,'The Science paper used 50 epochs. This uses %3i \n', maxepoch);

%makebatches;
data_batch;
[numcases numdims numbatches]=size(batchdata);

fprintf(1,'Pretraining Layer 1 with RBM: %d-%d \n',numdims,numhid);
restart=1;
trainrbm;
hidrecbiases=hidbiases; 
save zhidaovh vishid hidrecbiases visbiases;

fprintf(1,'\nPretraining Layer 2 with RBM: %d-%d \n',numhid,numpen);
batchdata=batchposhidprobs;
numhid=numpen;
restart=1;
trainrbm;
hidpen=vishid; penrecbiases=hidbiases; hidgenbiases=visbiases;
save zhidaohp hidpen penrecbiases hidgenbiases;

fprintf(1,'\nPretraining Layer 3 with RBM: %d-%d \n',numpen,numpen2);
batchdata=batchposhidprobs;
numhid=numpen2;
restart=1;
trainrbm;
hidpen2=vishid; penrecbiases2=hidbiases; hidgenbiases2=visbiases;
save zhidaohp2 hidpen2 penrecbiases2 hidgenbiases2;

fprintf(1,'\nPretraining Layer 4 with RBM: %d-%d \n',numpen2,numopen);
batchdata=batchposhidprobs;
numhid=numopen; 
restart=1;
trainrbmhidlinear;
%trainrbm;
hidtop=vishid; toprecbiases=hidbiases; topgenbiases=visbiases;
save zhidaopo hidtop toprecbiases topgenbiases;

backprop; 
