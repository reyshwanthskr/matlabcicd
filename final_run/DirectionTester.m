for i = 1:length(out.Direction.Data)
    disp(out.Direction.Data(i))
    disp(out.HeadingAngle.Data(i))
    if i>1
        disp(out.HeadingAngle.Data(i-1)-out.HeadingAngle.Data(i))
    end
end