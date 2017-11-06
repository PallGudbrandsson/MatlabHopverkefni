%Skilgreina x,y,t
function J = smooth(gogn)
x = gogn(:,2);
y = gogn(:,3);
t = gogn(:,1);

ode = (diff(x,t),3).^2 + (diff(y,t,3)).^2; %3. stigs diffurjöfnu sett upp 
J = cumtrapz(ode); %Heildið fundið
end