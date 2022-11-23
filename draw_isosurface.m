clear
close all
c=3e8;
b=1;a=10*b;
dx=0.01;dy=dx;dz=dx;
Nx=100;Ny=100;Nz=100;
X=linspace(-5,5,Nx);
Y=linspace(-5,5,Ny);
Z=linspace(-5,5,Nz);
[X,Y,Z]=meshgrid(X,Y,Z);
dt=1/(1000*c);%时间*光速的数量级应与网格点间隔相比拟
t=0;
syms x y z
f=a*b./(x.^2+y.^2+z.^2-c^2*t.^2+a*b+1i*(a*(z-c*t)-b*(z+c*t)));
F=[0 0 f];
A=curl(F,[x y z]);
for i=2:3%此循环程序要求i必须从2阶开始，终止阶数可以是无穷大
    A=curl(A,[x,y,z]);%此步执行完A变为两阶了（即对A求了两次旋度）
    B=curl(A,[x y z]);%B等于对A求一次旋度时，我们称B为一阶的，此步执行完B为二阶
    if B(3)==0
                str0=[num2str(i),'阶B_z分量为0'];
                disp(str0)
    else
        B3=matlabFunction((B(3)));
        Bz=B3(X,Y,Z);
        rBz=real(Bz);
        mm=max(max(max(abs(rBz))));%归一化时，忘记添加abs
        nBz=rBz/mm;%nBz保存归一化后的磁场z轴（normal_Bz）分量实部
        figure
        p1=patch(isosurface(X,Y,Z,nBz,0.01));
        %p2=patch(isosurface(X,Y,Z,nBz,-0.01));
        isonormals(X,Y,Z,nBz,p1)
        %isonormals(X,Y,Z,nBz,p2)
        p1.FaceColor='red';
        p1.EdgeColor='none';
        %p2.FaceColor='blue';
        %p2.EdgeColor='none';
        camlight%加灯更有质感,也可以加左右灯left、right\headlight
        camproj perspective%使用透视投影，照相机获得的结果是类似人眼在真实世界中看到的，有“近大远小”的效果
        alpha(.7)%设置面透明度,0为透明
        lighting gouraud  %gouraud 先对顶点颜色插补，再对顶点勾划的面色进行插补，用于曲面表现
        view(3);
        daspect([1 1 1]);
        box on
        xlabel('x轴');ylabel('y轴');zlabel('z轴');
        str2=[num2str(i),'阶B_z分量包络图'];
        title(str2)
        hold on
        %下将z=0切面处的值投影到z=4处
        %         nBz_z=zeros(size(nBz));%给z切面处体数据预分配内存，nBz_z的size必须与nBx一样才可以绘图
        %         nBz_z(:,:,size(nBz,3))=nBz(:,:,81);%要注意81的计算方法，将z=0.1的处体数据赋给同样位置的nBz_z,size(nBz,3)返回nBz第三矩阵的维度
        %         hz=slice(X,Y,Z,nBz_z,[],[],4);%绘制切片同时返还句柄?为什么z=-4时候无图像出现
        %         hz.FaceColor='interp';
        %         hz.EdgeColor='none';
        %         colorbar;
        %         %下将x=0的切面处的值投影到x=5处
        %         nBz_x=zeros(size(nBz));
        %         nBz_x(:,size(nBz,2),:)=nBz(:,130,:);%将x=0处体数据赋给nBz_x，nBz_x第n列存着x=constant的值这块想不明白看笔记
        %         hx=slice(X,Y,Z,nBz_x,-5,[],[]);
        %         hx.FaceColor='interp';
        %         hx.EdgeColor='none';
        %         colorbar;
        %将y=0的切片移到y=5处
        %         nBz_y=zeros(size(nBz));
        %         nBz_y(size(nBz,1),:,:)=nBz(101,:,:);%将x=0.1处体数据赋给nBz_x，nBz_x第n列存着x=constant的值这块想不明白看笔记
        %         hy=slice(X,Y,Z,nBz_y,[],4,[]);
        %         hy.FaceColor='interp';
        %         hy.EdgeColor='none';
        %         colorbar;
    end
end



