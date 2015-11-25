function CIJ=read_matfile(path)
a=matfile(path);
fiel=fields(a);
for i=1:length(fiel)
    [m n]=size(getfield(a,fiel{i}))
    if(m==n)
        CIJ=fiel{i}
    end;

end;
