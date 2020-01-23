function Projekt(n)
    h = 2 / n;
    
    macierz = sparse(n+1,n+1);
    macierz(n+1,n+1) = 1;
    
    prawa = zeros(n+1,1);
    prawa(1) = 30;
    
    for i = 1:n
        for j = 1:n
            macierz(i,j) = B(i,j,h,n);
        end
    end

    wynik = macierz\prawa;

    punkty = [0:1/n:1];

    wartosci = zeros(1,n+1);
    for k = 2:n
        wartosci(k)= -wynik(k-1);
    end
    p = 3;
    x=punkty;
    y=wartosci;

    A(1:p+1,1:p+1)=0;
    b(1:p+1)=0;

    for k=1:n
        for i=1:p+1
             for j=1:p+1
                A(i,j)=A(i,j)+x(k)^(i+j-2);
            end
            b(i)=b(i)+y(k)*x(k)^(i-1);
        end
    end
    
    a=A\b';

    dokl = 10000;
    punkt = [0:1/dokl:1];

    for i=1:dokl+1
        wielomian(i)=0;
        for j=1:p+1
            wielomian(i)=wielomian(i)+a(j)*punkt(i)^(j-1);
        end
    end

    plot(punkt,wielomian);
    hold on
    plot(x,y,'rx');
end

function [xi] = x(i,h)
    xi = 0;
    xi = xi + (i-1) * h;
end

function [E] = E(i,h)
    if(0 <= x(i,h) && x(i,h)<= 1)
        E = 3;
    elseif(1 < x(i,h) && x(i,h)<= 2)
        E = 5;
    else
        E = 0;
    end
end

function [Bij]=B(i,j,h,n)
	Bij=0;
    if(abs(i-j) <= 1)
        if(i==j)
            if(i == 1 || i== n + 1)
                Bij = - E(i,h) * 1 / h;
                if(i==1)
                    Bij = Bij + 3;
                end
            elseif(x(i,h)==1)
                Bij = -8/h;
            else
                Bij = - E(i,h) * 2 / h;
            end
        else
            if(x(i,h)==1)
                Bij = E(j,h) / h;
            else
                Bij = E(i,h) / h;
            end
        end
    end
end
