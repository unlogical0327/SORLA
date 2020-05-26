% This program parse CAN bus data 
clear all
%a=importdata('D:\lidar_mmwave\RLA\RLA_15_Implementation-master\Data\Cali_mode\history_data\candata_22.txt');
a=importdata('candata_0614_2.txt');
[w,l]=size(a);
frame_count=0;
for i=1:w
   if mod(i,5)==1
       frame_count=frame_count+1;
       nav_status(frame_count)=a(i,4);
   end
       if mod(i,5)==2
           % convert dec to unsigned hex and back to dec
           Lidar_y_hex=[dec2hex(a(i,1),2),dec2hex(a(i,2),2),dec2hex(a(i,3),2),dec2hex(a(i,4),2)];       
            if (dec2hex(a(i,1))=='FF')
                Lidar_y(frame_count)=he2de(Lidar_y_hex,1);
           else
                Lidar_y(frame_count)=he2de(Lidar_y_hex,0);
           end
       end
       if mod(i,5)==3
           Lidar_x_hex=[dec2hex(a(i,1),2),dec2hex(a(i,2),2),dec2hex(a(i,3),2),dec2hex(a(i,4),2)];
           if (dec2hex(a(i,1))=='FF')
                Lidar_x(frame_count)=he2de(Lidar_x_hex,1);
           else
                Lidar_x(frame_count)=he2de(Lidar_x_hex,0);
           end
       end
       if mod(i,5)==4
           Lidar_theta_hex=[dec2hex(a(i,1),2),dec2hex(a(i,2),2),dec2hex(a(i,3),2),dec2hex(a(i,4),2)];
           if (dec2hex(a(i,1))=='FF')
                Lidar_theta(frame_count)=he2de(Lidar_theta_hex,1)/100;
           else
                Lidar_theta(frame_count)=he2de(Lidar_theta_hex,0)/100;
           end
           if (frame_count>1)  % start after the first
               if ((Lidar_theta(frame_count)-Lidar_theta(frame_count-1))>100)
                   Lidar_theta(frame_count)=Lidar_theta(frame_count)-360;
                   disp('wrap around 360 degree at');
                   disp(frame_count);
               elseif ((Lidar_theta(frame_count)-Lidar_theta(frame_count-1))<-100)
                   Lidar_theta(frame_count)=Lidar_theta(frame_count)+360;
                   disp('wrap around 360 degree at');
                   disp(frame_count);
               end
           end
       end
          if mod(i,5)==0
             counter(frame_count)=a(i,4);
          end      
end
figure;plot(nav_status);title('navigation status');
len_min=min(length(Lidar_x),length(Lidar_y));
figure;plot(Lidar_x(1:len_min),Lidar_y(1:len_min),'-o');title('navigation trace');axis equal 
figure;plot(Lidar_theta);title('rotation angle');