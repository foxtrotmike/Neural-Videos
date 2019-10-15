clear
clc
Sn=[0 0 1 1; 1 0 1 0];T=2*[0 1 1 0]-1;
% Sn=[rand(2,100) 3+rand(2,100) 8+rand(2,100)];
U=rand(2,10)'*Sn; Th=(min(U')+(max(U')-min(U')).*rand(1,10))'; S=U>repmat(Th,1,size(U,2));
% T=2*[1*ones(1,100) 0*ones(1,100) 1*ones(1,100); ...
%     0*ones(1,100) 1*ones(1,100) 0*ones(1,100);...
%   ]-1;
% S=[1 0 0 1; 1 0 1 0]; T=2*[1 0 0 0;0 1 1 1;]-1;
Ni=size(S,1); No=size(T,1)  ;
W=0.5*rand(Ni,No);
B=0.1*rand(No,1);
theta=0.1 ;alpha=0.5;

% mov = avifile('testm.avi','fps',10,'quality',100);
% x1=-0.5:2.5;
% winsize(1:2) = [0 0];

epoch=0;
stopflag=0;
while(~stopflag)
    clc
    stopflag=1;
    epoch=epoch+1;
    for k=1:size(S,2)
        X=S(:,k);
        U=B+W'*X;
        Y=myHLims(U,theta);
        YY(:,k)=Y;
        %     indx=find(Y~=T(:,k));
        %     B(indx)=B(indx)+T(indx,k);
        %     for m=1:length(indx)
        %         W(:,indx(m))=W(:,indx(m))+T(indx(m),k)*X;
        %     end
        
        for j=1:No            
            if(T(j,k)~=Y(j))
                stopflag=0;
                B(j)=B(j)+alpha*T(j,k);
                for i=1:Ni
                    W(i,j)=W(i,j)+alpha*T(j,k)*X(i);
                end
            end
        end
    end
    
    
%     W'
%     B'
    YY
    T
%         fig=figure;
%         mTextBox = uicontrol('style','text');
%         set(mTextBox,'String','Visualization by Fayyaz Afsar, DCIS, PIEAS, PAKISTAN, 2007.')
%         set(mTextBox,'Units','characters')
%         set(mTextBox,'Position',[1 0  30 2])
%         hold on
%         clr={'r','b','g','k'}
%         for no=1:No
%             plot(x1,(-B(no)-W(1,no)*x1-theta)/W(2,no),clr{2*(no-1)+1},'linewidth',2)
%             plot(x1,(-B(no)-W(1,no)*x1+theta)/W(2,no),clr{2*(no-1)+2},'linewidth',2)
%            
%         end
%         plot(S(1,1),S(2,1),'ks','markersize',10)
%         plot(S(1,2:end),S(2,2:end),'ko','markersize',10)
%         axis([-0.5 +2.5 -0.5 2.5])
%         xlabel('X_1'),ylabel('X_2'),
%         title(['AND using Multi-Output Perceptron: \theta = ' num2str(theta) ' \alpha = '...
%             num2str(alpha) ' epcoh = ' num2str(epoch)])
%         
%         grid 
%         legend('Y_1: W^TX+B=\theta','Y_1: W^TX+B=-\theta',...
%             'Y_2: W^TX+B=\theta','Y_2: W^TX+B=-\theta','Class: (1,-1)', 'Class: (-1,1)')
%         F = getframe(fig);
%         mov = addframe(mov,F);
    pause
    close all
end
% mov = close(mov);
