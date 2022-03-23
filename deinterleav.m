function[rx2]=deinterleav(rx1)
    rx2 = matdeintrlv(rx1,2,2);
    rx2=rx2';
    rx2=rx2(:)';
end