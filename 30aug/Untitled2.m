    
data=[1 0 1 0 1 0 1 0 1 0 1 0 1 0 1]
constlen=7
    codegen = [171 200]    % Polynomial
    trellis = poly2trellis(constlen, codegen)
    codedata = convenc(data, trellis)