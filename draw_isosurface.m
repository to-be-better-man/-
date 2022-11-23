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
dt=1/(1000*c);%ʱ��*���ٵ�������Ӧ��������������
t=0;
syms x y z
f=a*b./(x.^2+y.^2+z.^2-c^2*t.^2+a*b+1i*(a*(z-c*t)-b*(z+c*t)));
F=[0 0 f];
A=curl(F,[x y z]);
for i=2:3%��ѭ������Ҫ��i�����2�׿�ʼ����ֹ���������������
    A=curl(A,[x,y,z]);%�˲�ִ����A��Ϊ�����ˣ�����A�����������ȣ�
    B=curl(A,[x y z]);%B���ڶ�A��һ������ʱ�����ǳ�BΪһ�׵ģ��˲�ִ����BΪ����
    if B(3)==0
                str0=[num2str(i),'��B_z����Ϊ0'];
                disp(str0)
    else
        B3=matlabFunction((B(3)));
        Bz=B3(X,Y,Z);
        rBz=real(Bz);
        mm=max(max(max(abs(rBz))));%��һ��ʱ���������abs
        nBz=rBz/mm;%nBz�����һ����Ĵų�z�ᣨnormal_Bz������ʵ��
        figure
        p1=patch(isosurface(X,Y,Z,nBz,0.01));
        %p2=patch(isosurface(X,Y,Z,nBz,-0.01));
        isonormals(X,Y,Z,nBz,p1)
        %isonormals(X,Y,Z,nBz,p2)
        p1.FaceColor='red';
        p1.EdgeColor='none';
        %p2.FaceColor='blue';
        %p2.EdgeColor='none';
        camlight%�ӵƸ����ʸ�,Ҳ���Լ����ҵ�left��right\headlight
        camproj perspective%ʹ��͸��ͶӰ���������õĽ����������������ʵ�����п����ģ��С�����ԶС����Ч��
        alpha(.7)%������͸����,0Ϊ͸��
        lighting gouraud  %gouraud �ȶԶ�����ɫ�岹���ٶԶ��㹴������ɫ���в岹�������������
        view(3);
        daspect([1 1 1]);
        box on
        xlabel('x��');ylabel('y��');zlabel('z��');
        str2=[num2str(i),'��B_z��������ͼ'];
        title(str2)
        hold on
        %�½�z=0���洦��ֵͶӰ��z=4��
        %         nBz_z=zeros(size(nBz));%��z���洦������Ԥ�����ڴ棬nBz_z��size������nBxһ���ſ��Ի�ͼ
        %         nBz_z(:,:,size(nBz,3))=nBz(:,:,81);%Ҫע��81�ļ��㷽������z=0.1�Ĵ������ݸ���ͬ��λ�õ�nBz_z,size(nBz,3)����nBz���������ά��
        %         hz=slice(X,Y,Z,nBz_z,[],[],4);%������Ƭͬʱ�������?Ϊʲôz=-4ʱ����ͼ�����
        %         hz.FaceColor='interp';
        %         hz.EdgeColor='none';
        %         colorbar;
        %         %�½�x=0�����洦��ֵͶӰ��x=5��
        %         nBz_x=zeros(size(nBz));
        %         nBz_x(:,size(nBz,2),:)=nBz(:,130,:);%��x=0�������ݸ���nBz_x��nBz_x��n�д���x=constant��ֵ����벻���׿��ʼ�
        %         hx=slice(X,Y,Z,nBz_x,-5,[],[]);
        %         hx.FaceColor='interp';
        %         hx.EdgeColor='none';
        %         colorbar;
        %��y=0����Ƭ�Ƶ�y=5��
        %         nBz_y=zeros(size(nBz));
        %         nBz_y(size(nBz,1),:,:)=nBz(101,:,:);%��x=0.1�������ݸ���nBz_x��nBz_x��n�д���x=constant��ֵ����벻���׿��ʼ�
        %         hy=slice(X,Y,Z,nBz_y,[],4,[]);
        %         hy.FaceColor='interp';
        %         hy.EdgeColor='none';
        %         colorbar;
    end
end



