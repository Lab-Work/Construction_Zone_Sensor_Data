% Juan Carlos Martinez
% Last modified: 3/17/2015
% This script uses the function inpaint_nans.m (need to cite) to do a linear regression of
% the data of the date of dataextractionscript.m, to clean it up.

run dataextractionscript

for i=1:9
    if not(isempty(eval(sprintf('EB%d',i))))
        eval(sprintf('EB%dclean=[inpaint_nans(EB%d(:,1)),inpaint_nans(EB%d(:,2))];',i,i,i));
    else
        eval(sprintf('EB%dclean=[];',i))
    end
end

for i=1:9
    if not(isempty(eval(sprintf('SB%d',i))))
        eval(sprintf('SB%dclean=[inpaint_nans(SB%d(:,1)),inpaint_nans(SB%d(:,2))];',i,i,i));
    else
        eval(sprintf('EB%dclean=[];',i))
    end
end

for i=1:7
    if not(isempty(eval(sprintf('NB%d',i))))
        eval(sprintf('NB%dclean=[inpaint_nans(NB%d(:,1)),inpaint_nans(NB%d(:,2))];',i,i,i));
    else
        eval(sprintf('EB%dclean=[];',i))
    end
end

clear i