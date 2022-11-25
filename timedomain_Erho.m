clear
close all
c=3e8;b=1;a=10*b;
Nt=2000; %预设采样点（总采样点应为Nt+1，包括0）
dt=1/(1000*c);%dt的选取很有讲究。不太了解？
tn=-1*Nt*dt/2:dt:Nt*dt/2;%能表明Bz实时变化的真实时间
Rho=1;Theta=pi/4;Z=0;
T=(-Nt/2:1:Nt/2)/100;%为了绘图的美观人为增大单位时间比例尺,维度与tn必须一致
syms x y z t theta rho%此处定义的均为符号变量，便于计算微分，应当注意绘图时应转换为数值变量便于矩阵的运算
f=a*b/(x.^2+y.^2+z.^2-c^2*t.^2+a*b+1i*(a*(z-c*t)-b*(z+c*t)));
F=[0 0 f];
A=curl(F,[x y z]);
for m=2:9%此循环程序要求m必须从2阶开始，终止阶数可以是无穷大
    A=curl(A,[x,y,z]);%此步执行完A变为两阶了（即对A求了两次旋度）
    Ar=cos(theta)*A(1)+sin(theta)*A(2);
    Arho=subs(Ar,{x,y},{rho*cos(theta),rho*sin(theta)});
    Erho=-diff(Arho,t);%没有*1/c，归一化无影响
    if rem(m,2)==1
                str0=[num2str(m),'阶Erho为0'];
                disp(str0)
    else
        figure
        E_rho=matlabFunction(Erho);
        E=E_rho(Rho,tn,Theta,Z);%@（rho,t,theta,z)赋值
        normal_Erho=real(E)/max(max(max(abs(real(E)))));%如果只想到某一阶图像请在以下两行加end并删去结尾处两end
        plot(T,normal_Erho)
        %%以下是找半峰程序
        HErho=abs(normal_Erho-0.5);
        p=find(HErho==min(HErho));%p是normal_Erho半波峰时的索引arry，这里不可以写为HErho==0.5，因为离散化后的数据几乎不可能有恰好这么完美的点
        %%关于find函数：https://blog.csdn.net/qq_45767476/article/details/109081132
        pp=find(T(p)>0);%pp指向p,此步结束所有指向p的pp均为正时间
        ppp=find(pp==min(pp));%ppp指向p,即选取了离0最近的时间
        ip=p(pp(ppp));%最终想要的唯一地址
        text(T(ip),normal_Erho(ip),'*');
        str00=[num2str(m),'阶半波峰时间t=',num2str(T(ip))];
        disp(str00)
        line([T(ip),T(ip)],[0,normal_Erho(ip)],'linestyle','--');%绘制（T(pp),0)到（T（pp),normal_real_Erho))虚线
        str1=['   t_1_/_2=',num2str(T(ip))];
        text(T(ip),normal_Erho(ip),str1);
        %%以下是美化图像部分
        xlabel('t(1/10c)','FontName','Times New Roman','FontSize',14);
        ylabel('Normalised B_z','FontName','Times New Roman','FontSize',14);
        str2=[num2str(m),'阶Erho'];
        title(str2)
        axis([-20 20 -1 1]);%设置坐标轴范围前两个是横坐标
        set(gca,'XTick',-20:10:20);
        set(gca,'XTicklabel',{'-20','-10','0','10','20'})
        set(gca,'YTick',-1:1:1);
        set(gca,'YTicklabel',{'-1','0','1'});
        grid on;
    end
end





