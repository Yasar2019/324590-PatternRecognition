gpu = gpuDevice;

y=linspace(1,1000,1000);
x = zeros(1,1000); 
pc1=0.5; 
pc2=0.5; 
for m=[2 5 10 20 50 100 200 500 1000] 
    m1 = floor(m*pc1); 
    m2 = floor(m*pc2); 
    g=0; 
    for n=1:1000 
        result = 0; 
        if n==1 
            result = 0.5; 
        else 
            for r=0:m2 
                for s = 0:m1 
                    if(s>r) 
                       g =n*((n-1)^2)*pc1*(s+1)/(m1+n); 
                    else 
                       g=n*((n-1)^2)*pc2*(r+1)/(m2+n); 
                    end 
                    result = result+g*prod(m2-r+1:m2-r+n-2)/prod(m2+1:m2+n-1)*prod(m1-s+1:m1-s+n-2)/prod(m1+1:m1+n-1); 
                end 
            end 
        end 
        x(n) = result; 
    end 
    hold on 
    semilogx(y,x); 
end
