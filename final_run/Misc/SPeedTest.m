a=out.Speed.Data
b=out.accel.Data




s=a(1)

for i=2:length(a)
    sign=1;
    if s>a(i)
        sign=-1;
    end
    speedChange=sign*b(i)*0.1;
    if abs(s-a(i))>speedChange
        s=s+speedChange
    else
        s=a(i)
    end

end