% Test TAYLORMACCOLL
close all
clear all
clc
disp('Turning warnings off...')
warning off

% --------------------------------------------------
% range of Mach numbers
clear all
gam = 1.4;
deltac = 2.5;
M1 = [20.0:-0.1:1.5];
for i = 1:length(M1)
    disp(['Mach number: ',num2str(M1(i))])
    [eps(i),pcp1(i),rcr1(i)] = taylormaccoll(gam,M1(i),deltac);
end
figure(1)
plot(M1,eps,'DisplayName',['deltac = ',num2str(deltac)])
xlabel('M1')
ylabel('eps')
legend show
legend('Location','eastoutside')
hold on
figure(2)
plot(M1,pcp1,'DisplayName',['deltac = ',num2str(deltac)])
xlabel('M1')
ylabel('pcp1')
legend show
legend('Location','eastoutside')
hold on
figure(3)
plot(M1,rcr1,'DisplayName',['deltac = ',num2str(deltac)])
xlabel('M1')
ylabel('rcr1')
legend show
legend('Location','eastoutside')
hold on

clear all
gam = 1.4;
deltac = 10.0;
M1 = [20:-0.1:1.5];
for i = 1:length(M1)
    disp(['Mach number: ',num2str(M1(i))])
    [eps(i),pcp1(i),rcr1(i)] = taylormaccoll(gam,M1(i),deltac);
end
figure(1)
plot(M1,eps,'DisplayName',['deltac = ',num2str(deltac)])
xlabel('M1')
ylabel('eps')
legend show
legend('Location','eastoutside')
hold on
figure(2)
plot(M1,pcp1,'DisplayName',['deltac = ',num2str(deltac)])
xlabel('M1')
ylabel('pcp1')
legend show
legend('Location','eastoutside')
hold on
figure(3)
plot(M1,rcr1,'DisplayName',['deltac = ',num2str(deltac)])
xlabel('M1')
ylabel('rcr1')
legend show
legend('Location','eastoutside')
hold on

clear all
gam = 1.4;
deltac = 25.0;
M1 = [20:-0.1:1.5];
for i = 1:length(M1)
    disp(['Mach number: ',num2str(M1(i))])
    [eps(i),pcp1(i),rcr1(i)] = taylormaccoll(gam,M1(i),deltac);
end
figure(1)
plot(M1,eps,'DisplayName',['deltac = ',num2str(deltac)])
xlabel('M1')
ylabel('eps')
legend show
legend('Location','eastoutside')
hold on
figure(2)
plot(M1,pcp1,'DisplayName',['deltac = ',num2str(deltac)])
xlabel('M1')
ylabel('pcp1')
legend show
legend('Location','eastoutside')
hold on
figure(3)
plot(M1,rcr1,'DisplayName',['deltac = ',num2str(deltac)])
xlabel('M1')
ylabel('rcr1')
legend show
legend('Location','eastoutside')
hold on

disp('Check figures.  Curves should be smooth.')
disp('Press any key to continue')
pause

% --------------------------------------------------
close all
clear all
clc

nfail = 0;
gam = 1.4;

% Compare to Sims, NASA-SP-3004
M1 = 1.5;
deltac = 2.5;
eps_true = .72979225*180/pi;
pcp1_true = 1.0194326;
rcr1_true = 1.0138422;
try
    nfail = test_case(gam,M1,deltac,eps_true,pcp1_true,rcr1_true,nfail);
catch
    disp('****************************** FAIL, Function Error')
    nfail = nfail + 1;
end

M1 = 1.5;
deltac = 25.0;
eps_true = .95578504*180/pi;
pcp1_true = 1.8977323;
rcr1_true = 1.5758355;
try
    nfail = test_case(gam,M1,deltac,eps_true,pcp1_true,rcr1_true,nfail);
catch
    disp('****************************** FAIL, Function Error')
    nfail = nfail + 1;
end

M1 = 1.75;
deltac = 27.5;
eps_true = .87135164*180/pi;
pcp1_true = 2.2773694;
rcr1_true = 1.7856077;
try
    nfail = test_case(gam,M1,deltac,eps_true,pcp1_true,rcr1_true,nfail);
catch
    disp('****************************** FAIL, Function Error')
    nfail = nfail + 1;
end

M1 = 1.75;
deltac = 30.0;
eps_true = .92802044*180/pi;
pcp1_true = 2.4878749;
rcr1_true = 1.8941358;
try
    nfail = test_case(gam,M1,deltac,eps_true,pcp1_true,rcr1_true,nfail);
catch
    disp('****************************** FAIL, Function Error')
    nfail = nfail + 1;
end

M1 = 20.0;
deltac = 2.5;
eps_true = .06734690*180/pi;
pcp1_true = 2.3107823;
rcr1_true = 1.8035356;
try
    nfail = test_case(gam,M1,deltac,eps_true,pcp1_true,rcr1_true,nfail);
catch
    disp('****************************** FAIL, Function Error')
    nfail = nfail + 1;
end

M1 = 20.0;
deltac = 30.0;
eps_true = .58182628*180/pi;
pcp1_true = 148.05417;
rcr1_true = 5.9729469;
try
    nfail = test_case(gam,M1,deltac,eps_true,pcp1_true,rcr1_true,nfail);
catch
    disp('****************************** FAIL, Function Error')
    nfail = nfail + 1;
end

% Compare to Zucrow and Hoffman
M1 = 3.0;
deltac = 30.0;
eps_true = 39.7841;
pcp1_true = 4.6228;
rcr1_true = 2.7580;
try
    nfail = test_case(gam,M1,deltac,eps_true,pcp1_true,rcr1_true,nfail);
catch
    disp('****************************** FAIL, Function Error')
    nfail = nfail + 1;
end

disp(['Number of failures: ',num2str(nfail)])

% --------------------------------------------------
function nfail = test_case(gam,M1,deltac, ...
    eps_true,pcp1_true,rcr1_true,nfail)

[eps,pcp1,rcr1] = taylormaccoll(gam,M1,deltac);

perr_eps = 100*(eps - eps_true)/eps_true;
perr_pcp1 = 100*(pcp1 - pcp1_true)/pcp1_true;
perr_rcr1 = 100*(rcr1 - rcr1_true)/rcr1_true;

disp('--------------------------------------------------')
disp(['gam:    ',num2str(gam)])
disp(['M1:     ',num2str(M1)])
disp(['deltac: ',num2str(deltac)])

disp(['True EPS     : ',num2str(eps_true)])
disp(['Computed EPS : ',num2str(eps)])
disp(['Percent Error: ',num2str(perr_eps)])
if abs(perr_eps) < 1
    disp('****************************** PASS')
else
    disp('****************************** FAIL, Error >= 1 %')
    nfail = nfail + 1;
end

disp(['True PCP1     : ',num2str(pcp1_true)])
disp(['Computed PCP1 : ',num2str(pcp1)])
disp(['Percent Error : ',num2str(perr_pcp1)])
if abs(perr_pcp1) < 1
    disp('****************************** PASS')
else
    disp('****************************** FAIL, Error >= 1 %')
    nfail = nfail + 1;
end

disp(['True RCR1     : ',num2str(rcr1_true)])
disp(['Computed RCR1 : ',num2str(rcr1)])
disp(['Percent Error: ',num2str(perr_rcr1)])
if abs(perr_rcr1) < 1
    disp('****************************** PASS')
else
    disp('****************************** FAIL, Error >= 1 %')
    nfail = nfail + 1;
end

end