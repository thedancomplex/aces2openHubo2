function[h, d] = smoothAces(H, D, dl)

s = size(D);

st = s(1);
sh = s(2);


h = H;
d = [];

for(i = 1:sh)

	d(:,i) = smooth(D(:,i),dl);

end
