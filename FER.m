clear;
% initial location and initial direction of the ray
z0 = 0;
r0 = 0.5;
alpha0 = 0;
% location of the media
zmin = 0;
zmax = 50;
rmin = -1;
rmax = 1;
% mesh size
dz = 0.1;
dr = 0.001;
% maximum steps
Max_Steps = 10000;
% refractive index matrix
[zmax,rmax] = meshcheck(zmin,zmax,rmin,rmax,dz,dr);    
n = getn(zmin,zmax,rmin,rmax,dz,dr);

% go to the first element of the media
r01 = @(z) tan(alpha0)*(z-z0) + r0;
if z0 <= zmin
    if r01(zmin) >= rmin && r01(zmin) <= rmax
        z1 = zmin;
        r1 = r01(zmin);
        alpha1 = alpha0;
    else
        error('The ray doesn''t go through the media.');
    end
else
    error('invalid initial ray.');
end

% dr---M---i
% dz---N---j
ray.z = z1;
ray.r = r1;
ray.alpha = alpha1;
ray.property = 'boundary';

current = 1;
rays(current) = ray;


while current <= Max_Steps
    cur = rays(current);
    geti =  1+floor((cur.r - rmin)/dr);
    getj =  1+floor((cur.z - zmin)/dz);
    if strcmp( cur.property, 'boundary') == 1
        if current == 1
            next.alpha = asin(sin(cur.alpha)/n(geti,getj));
        else
            next.alpha = asin(sin(cur.alpha)/n(geti,getj)*n(geti,getj-1));
        end
        next.z = cur.z + 0.5*dz;
        next.r = tan(next.alpha)*(next.z-cur.z) + cur.r;
        next.property = 'interior';    
        
    else
        next.alpha = cur.alpha - atan(dz/(2*dr)*(n(geti-1,getj)/n(geti+1,getj)-1)/(1+0.5*(n(geti-1,getj)/n(geti+1,getj)+1)));
        next.z = cur.z + 0.5*dz;
        next.r = tan(next.alpha)*(next.z-cur.z) + cur.r;
        next.property = 'boundary';
    end
    
    current = current +1;
    rays(current) = next;
    if next.z >= zmax || next.z <= zmin || next.r >= rmax || next.r <= rmin
        break;
    end
end

nstep = length(rays);
rays_z = zeros(nstep,1);
rays_r = zeros(nstep,1);
for k = 1:nstep
    rays_z(k) = rays(k).z;
    rays_r(k) = rays(k).r;
end

plot(rays_z,rays_r);

