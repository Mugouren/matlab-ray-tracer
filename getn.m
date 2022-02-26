
function n = getn(zmin,zmax,rmin,rmax,dz,dr)
    N = floor((zmax-zmin)/dz);
    M = floor((rmax-rmin)/dr);
    n = ones(M,N);
    % dr---M---i
    % dz---N---j
    % an element nij occupy an area dr*dz
    % from:  rmin + (i-1)*dr,  zmin + (j-1)*dz
    %      to:  rmin + i*dr,         zmin + j*dz 
    
    % parameters of graded-index fiber
    n1 = 1.564; A = 0.5;
    
    for i = 1:M
        for j = 1:N
            n(i,j) = n1*sqrt(1-(A*(rmin + (i-0.5)*dr))^2);
        end
    end

    % imagesc(n);
end