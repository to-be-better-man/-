clear
close all
c=3e8;b=1;a=10*b; 
Nt=20000; %Ԥ������㣨�ܲ�����ӦΪNt+1������0��
dt=1/(1000*c);%dt��ѡȡ���н�������̫�˽⣿
tn=-1*Nt*dt/2:dt:Nt*dt/2;%�ܱ���Bzʵʱ�仯����ʵʱ��
T=(-Nt/2:1:Nt/2)/100;%Ϊ�˻�ͼ��������Ϊ����λʱ�������,ά����tn����һ��
syms x y z t%�˴�����ľ�Ϊ���ű��������ڼ���΢�֣�Ӧ��ע���ͼʱӦת��Ϊ��ֵ�������ھ��������
f=a*b/(x.^2+y.^2+z.^2-c^2*t.^2+a*b+1i*(a*(z-c*t)-b*(z+c*t)));
F=[0 0 f];
A=curl(F,[x y z]);
for i=2:25%��ѭ������Ҫ��i�����2�׿�ʼ����ֹ���������������
    A=curl(A,[x,y,z]);%�˲�ִ����A��Ϊ�����ˣ�����A�����������ȣ�
    B=curl(A,[x y z]);%B���ڶ�A��һ������ʱ�����ǳ�BΪһ�׵ģ��˲�ִ����BΪ����
    if B(3)==0 %����Ҫ�е�һ������ΪmatlabFunction��Ϊ0����ᱨ����ֹ
        str0=[num2str(i),'��B_z����Ϊ0'];
        disp(str0)
    else
        figure
        Bz=matlabFunction(B(3));%�ɷ��ű���ת��Ϊ��������https://blog.csdn.net/weixin_41973774/article/details/107239370
        rot=Bz(tn,0,0.05,0);%���������Bx=@(t,x,y,z)x=0,y=0.05,z=?
        real_Bz=real(rot);
        aa=max(abs(real_Bz));
        normal_real_Bz=real_Bz/aa;%���ֻ�뵽ĳһ��ͼ�������������м�end��ɾȥ��β����end
        plot(T,normal_real_Bz)
        %%�������Ұ�����
        ABz=abs(normal_real_Bz-0.5);
        p=find(ABz==min(ABz));%p��normal_real_Bz�벨��ʱ������arry�����ﲻ����дΪABz==0.5����Ϊ��ɢ��������ݼ�����������ǡ����ô�����ĵ�
        %����find������https://blog.csdn.net/qq_45767476/article/details/109081132
        pp=find(T(p)>0);%ppָ��p,�˲���������ָ��p��pp��Ϊ��ʱ��
        ppp=find(pp==min(pp));%pppָ��p,��ѡȡ����0�����ʱ��
        ip=p(pp(ppp));
        text(T(ip),normal_real_Bz(ip),'*');
        str00=[num2str(i),'�װ벨��ʱ��t=',num2str(T(ip))];
        disp(str00)
        line([T(ip),T(ip)],[0,normal_real_Bz(ip)],'linestyle','--');%���ƣ�T(pp),0)����T��pp),normal_real_Bz))����
        str1=['   t_1_/_2=',num2str(T(ip))];
        text(T(ip),normal_real_Bz(ip),str1);
        %%����������ͼ�񲿷�
        xlabel('t(1/10c)','FontName','Times New Roman','FontSize',14);
        ylabel('Normalised B_z','FontName','Times New Roman','FontSize',14);
        str2=[num2str(i),'��B_z����'];
        title(str2)
        axis([-20 30 -1 1]);%���������᷶Χǰ�����Ǻ�����
        set(gca,'XTick',-20:10:30);
        set(gca,'XTicklabel',{'-20','-10','0','10','20','30'})
        set(gca,'YTick',-1:1:1);
        set(gca,'YTicklabel',{'-1','0','1'});
        grid on;
    end
end
      
    
   


