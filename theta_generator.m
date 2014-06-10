%Generator for theta values, currently only generates circular values
for i=0:31
    delta = 2^(-i);
    theta = atan(delta);
    %fprintf('Iteration: %i, Delta: %32.31f, Radians: %32.31f \n', i, delta, theta);
    t = round(2^30*theta);
    [~,e] = log2(t);
    s = dec2bin(t,max(30,e));
    %s = [s(1:end-30),'.',s(end-30+1:end)];
    fprintf('%i => "00%s",\n',i,s);
end
