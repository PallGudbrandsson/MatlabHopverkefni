%FUNCTION
%Skilgreina x,y,t
function J = smooth(x,y,t)
Fs=40;
dt=diff(t)/1000;

X1=filtering_data(x,[8 10],40); %5 12 nedri og efri mörk FINNA
Y1=filtering_data(y,[8 10],40); %40 gagnapunktar 

X2=diff(X1)./dt; 
X2=[0;X2];

Y2=diff(Y1)./dt;
Y2=[0;Y2];

%Filtera aftur
X2=filtering_data(X2,[4 14],40);
Y2=filtering_data(Y2,[4 14],40);

%Diffra aftur
X3=diff(X2)./dt;
X3=[0;X3];

Y3=diff(Y2)./dt;
Y3=[0;Y3];

%Filtera aftur
X3=filtering_data(X3,[4 14],40);
Y3=filtering_data(Y3,[4 14],40);

%Diffra aftur
X4=diff(X3)./dt;
X4=[0;X4];

Y4=diff(Y3)./dt;
Y4=[0;Y4];

%Filtera aftur
X4=filtering_data(X4,[4 14],40);
Y4=filtering_data(Y4,[4 14],40);


j_temp=(X4.^2+ Y4.^2);

J = trapz(j_temp)*dt(1);

end