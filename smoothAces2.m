function[h, d] = smoothAces(H, D, dl)

s = size(D);

st = s(1);



h = H;
d = [];

for( i = 1:dl)
	d(i,:) = D(1,:);
end
D = [d;D];


for( i = st:(st+dl+1) )
	D(i,:) = D(st,:);
end

for( i = 1:(st) )
	r = i:(i+dl);
	d(i,:) = sum(D(r,:))/dl;	
end

disp(num2str(size(d)))
