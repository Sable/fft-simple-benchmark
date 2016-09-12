function runner(scale)
%Driver for fast fourier transform
%input is n randomly generated complex numbers stored in an array of size 2*n
%n must be a power of 2
% transf=fft_four1(data,n,1) computes forward transform
% 1/n * fft_four1(transf,n,-1) computes backward tranform

% Create two time signals that are going to be extracted by the fourier transform
n=1024*2^round(scale);
samples = linspace(0,4*pi,n);
x = sin(samples);
y = sin(2*samples);
data = zeros(1, 2*n);
data(1:2:2*n-1) = x+y;

%'computing the forward transform'

tic();
out=fft_four1(data,n,1);
elapsed = toc();

% Extract the real part of the frequencies,
% ignoring the symmetry of the discrete fourier transform
% in the second half
realpart = out(1:2:n-1);

% Make sure we get two significant frequencies
important_freqs = realpart > 2;
%disp(sum(important_freqs));

% Extract the signal amplitudes for both
% and make sure it is respectively pi and 2*pi
%disp((realpart(3)));
%disp((pi));
%disp((realpart(5)));
%disp((2*pi));

% Compare the resulting values and ignore some errors
% that are due to rounding errors or insufficient number of samples
check = (sum(important_freqs) == 2) +...
    (floor(realpart(3)*10*scale) == floor(pi*10*scale)) +...
    (floor(realpart(5)*10*scale) == floor(2*pi*10*scale));

disp('{');
disp('"time":');
disp(elapsed);
disp(', "output":');
disp(check);
disp('}');

end
