counter=0;
for i = 1:length(data.grad.label)
    if ~strcmp(data.grad.label{i}, data.grad.labelorg{i})
       counter=counter+1; 
    end
end
