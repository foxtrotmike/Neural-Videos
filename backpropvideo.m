clear
close
clc
P=[-1 -1 1 1;-1 1 -1 1]; T=0.8*[-1 1 1 -1];
[X_1,X_2] = meshgrid(-1.1:.01:1.1, -1.1:.01:1.1);
X1=reshape(X_1,[1 prod(size(X_1))]);X2=reshape(X_2,[1 prod(size(X_2))]);
X=[X1;X2];
net=newff([0 1; 0 1],[4,1],{'tansig','tansig'},'trainlm');
net=initnw(net,2);

net.trainParam.epochs =1;
net.trainParam.show = NaN;
mov = avifile('testlm.avi','fps',10,'quality',100);winsize(1:2) = [0 0];
for k=1:1:1000    
    clc
   
    
    net=train(net,P,T);
    Y=sim(net,X);
    Y_=reshape(Y',size(X_1));
    fig=figure;
    contour(X_1,X_2,Y_)
%     imshow(Y_',[-0.9 +0.9])
    xlabel('x_1'),ylabel('x_2'),zlabel('Y')
    title(['BPNN (XOR) by Fayyaz: Epoch =  ' num2str(k)])
    colormap('hot')
    colorbar
    F = getframe(fig);
    mov = addframe(mov,F);    
    sim(net,P)
    pause(0.05)
    close all
    
end
mov = close(mov);