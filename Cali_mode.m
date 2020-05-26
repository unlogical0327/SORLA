clear all
fname=['Lidar_data_0625.txt'];
mode=1;
l=1;
[Lidar_data,data_length,data_round]=load_continous_scan_data(fname,mode);
Lidar_data=Lidar_data';
for i=1:data_length
        x(i,1)=cos(Lidar_data(i,1)/180*pi)*Lidar_data(i,2);
        y(i,1)=sin(Lidar_data(i,1)/180*pi)*Lidar_data(i,2);
        if (Lidar_data(i,3)>=800)
            r(l,1)=x(i,1);
            r(l,2)=y(i,1);
            l=l+1;
        end
end
figure;plot(x,y,'.b');hold on;
plot(r(:,1),r(:,2),'.g');
axis equal 



