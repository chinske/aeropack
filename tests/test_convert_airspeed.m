% Test CONVERT_AIRSPEED
close all
clear all
clc

nfail = 0;

% --------------------------------------------------
% --------------------------------------------------
% Test 1
% Test each permutation for accuracy.
% --------------------------------------------------
% --------------------------------------------------
disp('Testing each permutation for accuracy...')
disp(' ')

p = 26420;
T = 230;
vtas = 258.4;
veas = 147.7;
vcas = 157.3;

% --------------------------------------------------
disp('CAS -> EAS')
v_in = vcas;
v_true = veas;
v_test = convert_airspeed(v_in,'cas','eas',p,T);
perr = 100*(v_test-v_true)/v_true;

disp(['True Value: ',num2str(v_true)])
disp(['COMP Value: ',num2str(v_test)])
disp(['Error: ',num2str(perr),' %'])
if abs(perr) < 1
    disp('****************************** PASS')
else
    disp('****************************** FAIL, Error >= 1 %')
    nfail = nfail + 1;
end
disp(' ')

% --------------------------------------------------
disp('CAS -> TAS')
v_in = vcas;
v_true = vtas;
v_test = convert_airspeed(v_in,'cas','tas',p,T);
perr = 100*(v_test-v_true)/v_true;

disp(['True Value: ',num2str(v_true)])
disp(['COMP Value: ',num2str(v_test)])
disp(['Error: ',num2str(perr),' %'])
if abs(perr) < 1
    disp('****************************** PASS')
else
    disp('****************************** FAIL, Error >= 1 %')
    nfail = nfail + 1;
end
disp(' ')

% --------------------------------------------------
disp('EAS -> CAS')
v_in = veas;
v_true = vcas;
v_test = convert_airspeed(v_in,'eas','cas',p,T);
perr = 100*(v_test-v_true)/v_true;

disp(['True Value: ',num2str(v_true)])
disp(['COMP Value: ',num2str(v_test)])
disp(['Error: ',num2str(perr),' %'])
if abs(perr) < 1
    disp('****************************** PASS')
else
    disp('****************************** FAIL, Error >= 1 %')
    nfail = nfail + 1;
end
disp(' ')

% --------------------------------------------------
disp('EAS -> TAS')
v_in = veas;
v_true = vtas;
v_test = convert_airspeed(v_in,'eas','tas',p,T);
perr = 100*(v_test-v_true)/v_true;

disp(['True Value: ',num2str(v_true)])
disp(['COMP Value: ',num2str(v_test)])
disp(['Error: ',num2str(perr),' %'])
if abs(perr) < 1
    disp('****************************** PASS')
else
    disp('****************************** FAIL, Error >= 1 %')
    nfail = nfail + 1;
end
disp(' ')

% --------------------------------------------------
disp('TAS -> CAS')
v_in = vtas;
v_true = vcas;
v_test = convert_airspeed(v_in,'tas','cas',p,T);
perr = 100*(v_test-v_true)/v_true;

disp(['True Value: ',num2str(v_true)])
disp(['COMP Value: ',num2str(v_test)])
disp(['Error: ',num2str(perr),' %'])
if abs(perr) < 1
    disp('****************************** PASS')
else
    disp('****************************** FAIL, Error >= 1 %')
    nfail = nfail + 1;
end
disp(' ')

% --------------------------------------------------
disp('TAS -> EAS')
v_in = vtas;
v_true = veas;
v_test = convert_airspeed(v_in,'tas','eas',p,T);
perr = 100*(v_test-v_true)/v_true;

disp(['True Value: ',num2str(v_true)])
disp(['COMP Value: ',num2str(v_test)])
disp(['Error: ',num2str(perr),' %'])
if abs(perr) < 1
    disp('****************************** PASS')
else
    disp('****************************** FAIL, Error >= 1 %')
    nfail = nfail + 1;
end
disp(' ')

% --------------------------------------------------
% --------------------------------------------------
% Test 2
% Test ability to accept vector inputs.
% --------------------------------------------------
% --------------------------------------------------
disp('Testing ability to accept vector inputs...')
disp(' ')

disp('CAS -> EAS')
try
    v_out = convert_airspeed([25,50,75,100],'cas','eas',p,T);
    v_out = convert_airspeed([25;50;75;100],'cas','eas',p,T);
    disp('****************************** PASS')
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end
disp('CAS -> TAS')
try
    v_out = convert_airspeed([25,50,75,100],'cas','tas',p,T);
    v_out = convert_airspeed([25;50;75;100],'cas','tas',p,T);
    disp('****************************** PASS')
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end
disp('EAS -> CAS')
try
    v_out = convert_airspeed([25,50,75,100],'eas','cas',p,T);
    v_out = convert_airspeed([25;50;75;100],'eas','cas',p,T);
    disp('****************************** PASS')
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end
disp('EAS -> TAS')
try
    v_out = convert_airspeed([25,50,75,100],'eas','tas',p,T);
    v_out = convert_airspeed([25;50;75;100],'eas','tas',p,T);
    disp('****************************** PASS')
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end
disp('TAS -> CAS')
try
    v_out = convert_airspeed([25,50,75,100],'tas','cas',p,T);
    v_out = convert_airspeed([25;50;75;100],'tas','cas',p,T);
    disp('****************************** PASS')
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end
disp('TAS -> EAS')
try
    v_out = convert_airspeed([25,50,75,100],'tas','eas',p,T);
    v_out = convert_airspeed([25;50;75;100],'tas','eas',p,T);
    disp('****************************** PASS')
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp(' ')

% --------------------------------------------------
% --------------------------------------------------
% Test 3
% Test v_in = 0.
% --------------------------------------------------
% --------------------------------------------------
disp('Testing v_in = 0...')
disp(' ')

disp('CAS -> EAS')
v_out = convert_airspeed(0,'cas','eas',p,T);
if v_out == 0
    disp('****************************** PASS')
else
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp('CAS -> TAS')
v_out = convert_airspeed(0,'cas','tas',p,T);
if v_out == 0
    disp('****************************** PASS')
else
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp('EAS -> CAS')
v_out = convert_airspeed(0,'eas','cas',p,T);
if v_out == 0
    disp('****************************** PASS')
else
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp('EAS -> TAS')
v_out = convert_airspeed(0,'eas','tas',p,T);
if v_out == 0
    disp('****************************** PASS')
else
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp('TAS -> CAS')
v_out = convert_airspeed(0,'tas','cas',p,T);
if v_out == 0
    disp('****************************** PASS')
else
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp('TAS -> EAS')
v_out = convert_airspeed(0,'tas','eas',p,T);
if v_out == 0
    disp('****************************** PASS')
else
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp(' ')

% --------------------------------------------------
% --------------------------------------------------
% Test 4
% Test v_in = [0,0,0].
% --------------------------------------------------
% --------------------------------------------------
disp('Testing v_in = [0,0,0]...')
disp(' ')

disp('CAS -> EAS')
try
    v_out = convert_airspeed([0,0,0],'cas','eas',p,T);
    if isequal(v_out,[0,0,0])
        disp('****************************** PASS')
    else
        disp('****************************** FAIL')
        nfail = nfail + 1;
    end
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp('CAS -> TAS')
try
    v_out = convert_airspeed([0,0,0],'cas','tas',p,T);
    if isequal(v_out,[0,0,0])
        disp('****************************** PASS')
    else
        disp('****************************** FAIL')
        nfail = nfail + 1;
    end
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp('EAS -> CAS')
try
    v_out = convert_airspeed([0,0,0],'eas','cas',p,T);
    if isequal(v_out,[0,0,0])
        disp('****************************** PASS')
    else
        disp('****************************** FAIL')
        nfail = nfail + 1;
    end
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp('EAS -> TAS')
try
    v_out = convert_airspeed([0,0,0],'eas','tas',p,T);
    if isequal(v_out,[0,0,0])
        disp('****************************** PASS')
    else
        disp('****************************** FAIL')
        nfail = nfail + 1;
    end
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp('TAS -> CAS')
try
    v_out = convert_airspeed([0,0,0],'tas','cas',p,T);
    if isequal(v_out,[0,0,0])
        disp('****************************** PASS')
    else
        disp('****************************** FAIL')
        nfail = nfail + 1;
    end
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp('TAS -> EAS')
try
    v_out = convert_airspeed([0,0,0],'tas','eas',p,T);
    if isequal(v_out,[0,0,0])
        disp('****************************** PASS')
    else
        disp('****************************** FAIL')
        nfail = nfail + 1;
    end
catch
    disp('****************************** FAIL')
    nfail = nfail + 1;
end

disp(' ')

% --------------------------------------------------
% --------------------------------------------------
% Test 5
% Test input in knots.
% --------------------------------------------------
% --------------------------------------------------
disp('Testing input in knots...')
disp(' ')

[T, a, p, rho] = atmosisag(10000.*0.3048);
T = 275.15;
vcas = 200;
v_in = vcas;
v_true = 234.7;
v_test = convert_airspeed(v_in,'cas','tas',p,T,'knots');
perr = 100*(v_test-v_true)/v_true;

disp(['True Value: ',num2str(v_true)])
disp(['COMP Value: ',num2str(v_test)])
disp(['Error: ',num2str(perr),' %'])
if abs(perr) < 1
    disp('****************************** PASS')
else
    disp('****************************** FAIL, Error >= 1 %')
    nfail = nfail + 1;
end
disp(' ')

% --------------------------------------------------
% --------------------------------------------------
% Test Summary
% --------------------------------------------------
% --------------------------------------------------
disp(['Number of FAILED tests: ',num2str(nfail)])
disp(' ')