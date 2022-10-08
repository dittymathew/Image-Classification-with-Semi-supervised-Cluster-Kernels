x=[25.25, 40.63, 27.38, 45.63, 42.63; 35.25, 25.75, 26.25, 37.36, 37.25];
plot([10,20,50,70,100],x,'linewidth',2);
xlabel('Train data size','FontSize',12);
ylabel('Accuracy','FontSize',12);
legend('Scene-15','Caltech-101');
set(gca,'FontSize', 12);


%%Scene-15 Accuracy

x= [72.5000,77.1250,76.7500,67.8750,66.8750;80.3750,72.3750,82.6250,82.1250,80.7500;45.5000,68.5000,69.5000,70.6250,70.1250];
figure;
plot([5,10,20,70,100],x,'linewidth',2);
xlabel('K(No of clusters of k-means)','FontSize',16);
ylabel('Accuracy','FontSize',16);
legend('Train Data Size =10','Train Data Size =50','Train Data Size =100');
set(gca,'FontSize', 16);

%%Scene -15 Accuracy without RBF

x= [75.6250,76.2500,76.2500,66.0000,52.5000; 77.0000,80.5000,83.0000,84.5000,81.2500; 78.0000,82.6250,83.0000,85.1250,84.6250]
figure;
plot([5,10,20,70,100],x,'linewidth',2);
xlabel('K(No of clusters of k-means)','FontSize',12);
ylabel('Accuracy','FontSize',12);
legend('Train Data Size =10','Train Data Size =50','Train Data Size =100');
set(gca,'FontSize', 12);


%%Caltech-101 Accuracy


x=[53.8750,54.7500,59.7500,45.5000,44.0000; 38.6250,39.8750,67.6250,52.3750,48.3750; 35.5000,32.5000,37.2500,35.6250,36.2500];
figure;
plot([5,10,20,70,100],x,'linewidth',2);
xlabel('K(No of clusters of k-means)','FontSize',16);
ylabel('Accuracy','FontSize',16);
legend('Train Data Size =10','Train Data Size =50','Train Data Size =100');
set(gca,'FontSize', 16);

%% Caltech-101 Accuracy without RBF

x=[57.1250,63.0000,71.5000,66.5000,54.3750; 63.1250,73.0000,79.0000,81.0000,82.1250; 60.3750,73.2500,75.2500,82.3750,83.2500]
figure;
plot([5,10,20,70,100],x,'linewidth',2);
xlabel('K(No of clusters of k-means)','FontSize',12);
ylabel('Accuracy','FontSize',12);
legend('Train Data Size =10','Train Data Size =50','Train Data Size =100');
set(gca,'FontSize', 12);