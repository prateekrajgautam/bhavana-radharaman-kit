function[codedata,trellis]=convencoder(data)
%function[codedata]=convencoder(data)
    constlen=7;
    codegen = [171 133];    % Polynomial
    trellis = poly2trellis(constlen, codegen);
    codedata = convenc(data, trellis);
end