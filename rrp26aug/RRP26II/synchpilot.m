function[syncheddata]=synchpilot(ffsignal)
global plotmodulateddata
% syncheddata=synchpilot(ffsignal)
    for i=1:52
        syncheddata1(i)=ffsignal(i+6);
    end
    k=1;
    for i=(1:13:52)
        for j=(i+1:i+12);
            syncheddata(k)=syncheddata1(j);
            k=k+1;
        end
    end
    if plotmodulateddata==1
    scatterplot(syncheddata)
    end
end