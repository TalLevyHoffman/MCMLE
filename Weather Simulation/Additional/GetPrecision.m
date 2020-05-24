function eps = GetPrecision(W)

    eps = min( abs( diff( sort( W ) ) ) ) / 50;
    
end