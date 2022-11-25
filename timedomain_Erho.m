clear
close all
c=3e8;b=1;a=10*b;
Nt=2000; %Ԥ������㣨�ܲ�����ӦΪNt+1������0��
dt=1/(1000*c);%dt��ѡȡ���н�������̫�˽⣿
tn=-1*Nt*dt/2:dt:Nt*dt/2;%�ܱ���Bzʵʱ�仯����ʵʱ��
Rho=1;Theta=pi/4;Z=0;
T=(-Nt/2:1:Nt/2)/100;%Ϊ�˻�ͼ��������Ϊ����λʱ�������,ά����tn����һ��
syms x y z t theta rho%�˴�����ľ�Ϊ���ű��������ڼ���΢�֣�Ӧ��ע���ͼʱӦת��Ϊ��ֵ�������ھ��������
f=a*b/(x.^2+y.^2+z.^2-c^2*t.^2+a*b+1i*(a*(z-c*t)-b*(z+c*t)));
F=[0 0 f];
A=curl(F,[x y z]);
for m=2:9%��ѭ������Ҫ��m�����2�׿�ʼ����ֹ���������������
    A=curl(A,[x,y,z]);%�˲�ִ����A��Ϊ�����ˣ�����A�����������ȣ�
    Ar=cos(theta)*A(1)+sin(theta)*A(2);
    Arho=subs(Ar,{x,y},{rho*cos(theta),rho*sin(theta)});
    Erho=-diff(Arho,t);%û��*1/c����һ����Ӱ��
    if rem(m,2)==1
                str0=[num2str(m),'��ErhoΪ0'];
                disp(str0)
    else
        figure
        E_rho=matlabFunction(Erho);
        E=E_rho(Rho,tn,Theta,Z);%@��rho,t,theta,z)��ֵ
        normal_Erho=real(E)/max(max(max(abs(real(E)))));%���ֻ�뵽ĳһ��ͼ�������������м�end��ɾȥ��β����end
        plot(T,normal_Erho)
        %%�������Ұ�����
        HErho=abs(normal_Erho-0.5);
        p=find(HErho==min(HErho));%p��normal_Erho�벨��ʱ������arry�����ﲻ����дΪHErho==0.5����Ϊ��ɢ��������ݼ�����������ǡ����ô�����ĵ�
        %%����find������https://blog.csdn.net/qq_45767476/article/details/109081132
        pp=find(T(p)>0);%ppָ��p,�˲���������ָ��p��pp��Ϊ��ʱ��
        ppp=find(pp==min(pp));%pppָ��p,��ѡȡ����0�����ʱ��
        ip=p(pp(ppp));%������Ҫ��Ψһ��ַ
        text(T(ip),normal_Erho(ip),'*');
        str00=[num2str(m),'�װ벨��ʱ��t=',num2str(T(ip))];
        disp(str00)
        line([T(ip),T(ip)],[0,normal_Erho(ip)],'linestyle','--');%���ƣ�T(pp),0)����T��pp),normal_real_Erho))����
        str1=['   t_1_/_2=',num2str(T(ip))];
        text(T(ip),normal_Erho(ip),str1);
        %%����������ͼ�񲿷�
        xlabel('t(1/10c)','FontName','Times New Roman','FontSize',14);
        ylabel('Normalised B_z','FontName','Times New Roman','FontSize',14);
        str2=[num2str(m),'��Erho'];
        title(str2)
        axis([-20 20 -1 1]);%���������᷶Χǰ�����Ǻ�����
        set(gca,'XTick',-20:10:20);
        set(gca,'XTicklabel',{'-20','-10','0','10','20'})
        set(gca,'YTick',-1:1:1);
        set(gca,'YTicklabel',{'-1','0','1'});
        grid on;
    end
end





