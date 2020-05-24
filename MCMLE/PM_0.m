function PM = PM_0(WMin)

PM = WMin ./ (1-WMin) .* log ( (1+WMin) ./ (2*WMin) );

end