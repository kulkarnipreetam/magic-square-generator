function Magic_Square_M(n,i,s)
  x=i:n^2+(i-1);
  Ans=ones(n^2,1);z=ones(1,n^2);
  ind1=repmat({x},1,n);ind2=repmat({flip(x)},1,n);
  ind3=repmat({repmat(x,1,n)},1,n);ind4=repmat({z},1,n^2);
  b=blkdiag(ind1{:});
  a=blkdiag(ind3{:});
  e=blkdiag(ind1{:});
  f=flip(blkdiag(ind2{:}),2);
  c=[reshape(e',1,numel(e));reshape(f',1,numel(f))];
  g=blkdiag(ind4{:});
  d=repmat(eye(n^2),1,n^2);
  A=[a;repmat(b,1,n);c;d;g];
  B=[(((n^2*(n^2+1)/2)+(x(1)-1)*n^2)/n)*ones(2*n+2,1);ones(2*n^2,1)];
  C=zeros(n^4,1);
  vtype=1:n^4;
  lx=zeros(n^4,1);
  ux=ones(n^4,1);
  options = optimset('Display','off');
  if s==1
      [t]=intlinprog(C,vtype,[],[],A,B,lx,ux);
  elseif s==2
      [t]=cplexmilp(C,[],[],A,B,[],[],[],lx,ux,vtype);
  end
  for i=1:n^2
    Ans(i,1)=x*t((n^2)*(i-1)+[1:n^2]);
  end;
  for i=1:n
    disp(int16(Ans(n*(i-1)+[1:n]))')
  end;
  disp('Magic Sum='),disp(((n^2*(n^2+1)/2)+(x(1)-1)*n^2)/n)
end
