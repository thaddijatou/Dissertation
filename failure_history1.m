function[downT,upT] = failure_history1(lambda,MTTR,duration)
    duration = duration * 24 * 365 + 1;
    cur_t = 0;
    i = 1;
    while (cur_t <= duration)
        TTF = -log(rand(1,1))/lambda*8760;
        TTR = -log(rand(1,1))*MTTR;
        
        downT(i)=cur_t+TTF;
        upT(i) = downT(i)+TTR;
        cur_t = upT(i);
        i = i+1;
    end
    downT(end) = duration;
    upT(end) = duration;
end