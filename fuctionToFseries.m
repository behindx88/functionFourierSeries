%函数在x_0处的傅里叶级数展开
clear,clc
syms x
f=@(x) cos(1e-3.*x.^2+1e-2.*x+1);
% f=@(x) sin(x)+sin(2.*x);
[A,B,F] = fseries(f,x,3,-5,5)
% ff=@(x) A(1)/2+A(2).*cos(x)+B(1).*sin(x)+A(3).*cos(2.*x)+B(2).*sin(2.*x);
% ff=@(x) A(1)/2+A(2).*cos(x)+B(1).*sin(x)+A(3).*cos(2.*x)+B(2).*sin(2.*x)+A(4).*cos(3.*x)+B(3).*sin(3.*x);
figure,fplot(f),hold on,fplot(F),hold off
function [A,B,F]=fseries(f,x,n,a,b)  
%用于求解函数的傅里叶级数展开  
    if nargin==3, a=-pi; b=pi; end  
    L=(b-a)/2;
    class(f)
    f
    if a+b
        f=@(x) f(x-L-a);
%         f=subs(f,x,x-L-a);
    end %变量区域互换 
    class(f)
    f
    A=integral(f,-L,L)/L;
    B=[];
    F=@(x) A/2; %计算a0  
    for i=1:n  
        an=integral(@(x) f(x).*cos(i.*pi.*x/L),-L,L)/L;   
        bn=integral(@(x) f(x).*sin(i.*pi.*x/L),-L,L)/L;   
        A=[A, an];   
        B=[B, bn];   
        F=@(x) F(x)+an*cos(i*pi*x/L)+bn*sin(i*pi*x/L);  
    end  
%     if a+b, F=subs(F,x,x+L+a); end %换回变量区域  
    if a+b, F=@(x) F(x+L+a); end %换回变量区域  
end  