function [zmax1,rmax1] = meshcheck(zmin,zmax,rmin,rmax,dz,dr)
    N = floor((zmax-zmin)/dz);
    M = floor((rmax-rmin)/dr);
    zmax1 = dz*N+zmin;
    rmax1 = dr*M+rmin;
    if zmax1 == zmax && rmax1 == rmax
        fprintf('dz = %.4f, dr = %.4f\n',dz,dr);
    elseif zmax1 == zmax
        fprintf('warning: rmax is modified.\n');
        fprintf('dz = %.4f, dr = %.4f\n',dz,dr);
    elseif rmax1 == rmax
        fprintf('warning: zmax is modified.\n');
        fprintf('dz = %.4f, dr = %.4f\n',dz,dr);
    else
        fprintf('warning: zmax and rmax is modified.\n');
        fprintf('dz = %.4f, dr = %.4f\n',dz,dr); 
    end
end