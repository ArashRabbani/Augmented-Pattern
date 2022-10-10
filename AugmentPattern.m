function [varargout]=AugmentPattern(A,LAB1,GridRatio,show)
if nargin==3; show=0; end
if nargin==2; GridRatio=6; show=0; end
if nargin==1; GridRatio=6; LAB1=zeros(size(A,1),size(A,2)); show=0; end
global opt
opt.Rat=6;
opt.show=show;
opt.Rat=GridRatio;
A=uint8(normal(A).*254); A=A+1;
if ndims(A)==2; A=cat(3,A,A,A); end
A0=A; A=rgb2gray(A);
S=size(A);
LAB1=uint8(LAB1>0);
[B0,LAB2]=MakeSim(A0,S,LAB1);
B0=uint8(B0); LAB2=LAB2-1; LAB2=uint8(LAB2*255);
varargout{1}=B0;
varargout{2}=LAB2;
end
function [B0,LAB2]=MakeSim(A,S,LAB);
global opt;
if numel(unique(LAB))==2; LAB=LAB+1; end
A0=A;
A=rgb2gray(A);
Rat=opt.Rat;
s=ceil(size(A)./Rat);
m=3;
sz=s-2*m;
K=1;
scanstep=ceil(S./80);
bstart=[1,1];
b(1)=bstart(1);
n=ceil((size(A,1)-(1+s(1)))/scanstep(1))*ceil((size(A,2)-(1+s(2)))/scanstep(2));
n=n*2; % for flipped ones
T=zeros(s(1),s(2),n);
TL=uint8(zeros(s(1),s(2),n));
TI=uint8(zeros(s(1),s(2),3,n));
while (b(1)+s(1))<size(A,1)
    b(2)=bstart(2);
    while (b(2)+s(2))<size(A,2)
        T(:,:,K)=A(b(1)+1:b(1)+s(1),b(2)+1:b(2)+s(2));
        TL(:,:,K)=LAB(b(1)+1:b(1)+s(1),b(2)+1:b(2)+s(2));
        TI(:,:,:,K)=A0(b(1)+1:b(1)+s(1),b(2)+1:b(2)+s(2),:);
        K=K+1;
        b(2)=b(2)+scanstep(2);
    end
    b(1)=b(1)+scanstep(1);
end
% flipped part
A_F=flip(flip(A,2),1);
LAB_F=flip(flip(LAB,2),1);
A0_F=flip(flip(A0,2),1);
b(1)=bstart(1);
while (b(1)+s(1))<size(A,1)
    b(2)=bstart(2);
    while (b(2)+s(2))<size(A,2)
        T(:,:,K)=A_F(b(1)+1:b(1)+s(1),b(2)+1:b(2)+s(2));
        TL(:,:,K)=LAB_F(b(1)+1:b(1)+s(1),b(2)+1:b(2)+s(2));
        TI(:,:,:,K)=A0_F(b(1)+1:b(1)+s(1),b(2)+1:b(2)+s(2),:);
        K=K+1;
        b(2)=b(2)+scanstep(2);
    end
    b(1)=b(1)+scanstep(1);
end
W2=zeros(s); W2(1+m:end-m,1+m:end-m)=1; W2=1-W2; W2=W2(:);
T2=zeros(size(T,3),sum(W2==1));
for K=1:size(T,3)
    t=T(:,:,K); t=t(:); t(W2==0)=[];
    T2(K,:)=t;
end
B=zeros(S+s);
B0=cat(3,B,B,B);
L0=B*0;
bs1=m:sz(1):size(B,1)-sz(1)-m;
bs2=m:sz(2):size(B,2)-sz(2)-m;
K=1;
for I=1:numel(bs1)
    for J=1:numel(bs2)
        Loc(K,:)=[bs1(I) bs2(J)];
        K=K+1;
    end
end
ID=Shuff([1:size(Loc,1)]');
if opt.show;
    figure;
end
for K=1:size(Loc,1)
    b=Loc(ID(K),:);
    t=B(b(1)-m+1:b(1)+sz(1)+m,b(2)-m+1:b(2)+sz(2)+m);
    W=t>0;
    W3=W(:);
    W3(W2==0)=[];
    W3=repmat(W3,[1,size(T,3)])';
    [SIM,E,id]=FindSim(t,T,W,T2,W2,W3);
    ERR(K)=E;
    w=bwdist(1-W); w=w./max(w(:)); w(isnan(w))=0;
    B(b(1)-m+1:b(1)+sz(1)+m,b(2)-m+1:b(2)+sz(2)+m)=(t).*w+SIM.*(1-w);
    SIM0=TI(:,:,:,id);
    w0=cat(3,w,w,w);
    t0=B0(b(1)-m+1:b(1)+sz(1)+m,b(2)-m+1:b(2)+sz(2)+m,:);
    t0=double(t0); w0=double(w0); SIM0=double(SIM0);
    B0(b(1)-m+1:b(1)+sz(1)+m,b(2)-m+1:b(2)+sz(2)+m,:)=(t0).*w0+SIM0.*(1-w0);
    SIM0=TL(:,:,id);
    t0=L0(b(1)-m+1:b(1)+sz(1)+m,b(2)-m+1:b(2)+sz(2)+m);
    t0=double(t0); w0=double(w0); SIM0=double(SIM0);
    WW=imdilate(W,ones(m,m));
    g=(t0).*w+SIM0.*(1-w); g=uint8(g); g0=g;
    g=medfilt2(g,[3,3],'symmetric');
    g=medfilt2(g,[3,3],'symmetric');
    g=medfilt2(g,[3,3],'symmetric');
    g(WW==0)=g0(WW==0);
    L0(b(1)-m+1:b(1)+sz(1)+m,b(2)-m+1:b(2)+sz(2)+m,:)=g;
if opt.show
    clf; imshow(uint8(B0(1:S(1),1:S(2),:))); drawnow; 
    imwrite(uint8(B0(1:S(1),1:S(2),:)),['Gif/Frame_' num2str(K) '.png']);
end
end
L0=medfilt2(L0,[3,3],'symmetric');
LAB2=L0;
B=B(1:S(1),1:S(2),:);
B0=B0(1:S(1),1:S(2),:);
LAB2=LAB2(1:S(1),1:S(2));
if opt.show
    make_video_gif
end
end
function [SIM,E,id]=FindSim(t,T,W,T2,W2,W3)
if sum(W(:))==0; ID=randi(size(T,3),1,1); SIM=T(:,:,ID); E=0; id=ID; return; end;
t2=t(:);
t2(W2==0)=[];
t3=repmat(t2,[1,size(T,3)])';
Err=(abs(t3-T2).*W3);
W4=W(:); W4(W2==0)=[];
W4=repmat(W4,[1,size(T,3)])';
Err=sum(Err.*W4,2)./sum(W(:));
[o,p]=sort(Err);
ID=p(1); E=o(1);
id=ID;
if max(W(:))==0; ID=randi(size(T,3),1,1); E=0; end
SIM=T(:,:,ID);
end
function ShuffledData=Shuff(OrigData)
X=randperm(numel(OrigData));
ShuffledData=reshape(OrigData(X),size(OrigData));
end
function [A]=normal(A)
A=double(A);
M1=min(A(:)); M2=max(A(:));
if M1==M2; return; end
A=(A-M1)./(M2-M1);
end
function make_video_gif
filename='Final.gif';
D=dir(['Gif/*.png']);
for I = 2:numel(D)
    A=imread(['Gif/Frame_' num2str(I) '.png']); %A=A(:,200:end-200,:);
%     B=imread(['Gif/Frame_' num2str(I) '.png']); B=B(:,200:end-200,:);
%     A=cat(2,B,A); 
%     A2=uint8(ones(size(A,1)+60,size(A,2),size(A,3)).*255);
%     A2(61:end,:,:)=A; A=A2; %A=imresize(A,.3);%r
A=uint8(A);
    [imind,cm] = rgb2ind(A,256);
    if I == 2;
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.08);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.08);
    end
end
delete('Gif\*')
end
