function tpsolvena(type,Omega)
% TPSOLVENA  Computes vibration levels for a rigid rotor fitted with an
%            automatic ball balancer.
%            type takes the value '0' or '1'. '0' is for a simulation in 
%            which case Omega is the rotation speed. '1' is for a parameter
%            sweep in which case Omega is the maximum rotation speed.
% TPSOLVENA  Requires the functions tpna, tpmassna and peakdet to be in the
%            same directory.
% DISCLAIMER This program is provided "as is" without any warranty of any 
%            kind, either express or implied, including but not limited to, 
%            the implied warranties of, fitness for a particular purpose. 

% **All parameter values are non-dimensional** see paper

% rotor properties
Jt = 3.25;        % transverse moment of inertia
Jp = 0.5;         % polar moment of inertia

%imbalance properties
epsilon = 5e-5;   % eccentricity
chi = 5e-5;       % misalignment
beta = 1;         % phase between eccentricity and misalignment

% autobalancer properties
mu=1e-4;          % ball mass
m1 = mu;          % mass of ball 1 etc.
m2 = mu;
m3 = mu;
m4 = mu;

z1 = 2;           % axial location of ball 1 etc.
z2 = 2;
z3 =-2;
z4 =-2;

% stiffness and damping constants see paper for details
k11 = 1;              k33 = 5;
k12 = 0;              k34 = 0;
k22 = 9;              k44 = 45;
c=0.02;
c11 = c*k11;          c33 = c*k33;
c12 = c*k12;          c34 = c*k34;
c22 = c*k22;          c44 = c*k44;

cb = 0.01; % race damping constant

global par;

switch type
   case 0
      % This is the code for the simualtion case
      disp('Plotting Simulation')
      % Define all the constants as a global variable 1x27 vector
      par = [Omega, Jt, Jp, epsilon, chi, beta, m1, m2, m3, m4, z1, z2, z3, z4, k11, k12, k22, c11, c12, c22, k33, k34, k44, c33, c34, c44, cb];
      % solve the system 'tpna' using ode45 with the 'options' of a mass matrix 'tpmassna' and a strong dependence on 2nd order derivates.
      options = odeset('Mass',@tpmassna,'MStateDependence','strong','AbsTol',1e-14);
      [T,Y] = ode45(@tpna,[0 800],[0 0 0 0 0 0 0 0 pi/2 0 -pi/2 0 pi/2 0 -pi/2 0],options);
      x=Y(:,1);
      y=Y(:,3);
      phix=Y(:,5);
      phiy=Y(:,7);
      % 'vibration' is a measure of the average vibration level at a distance of one unit
      % length from the midspan.
      vibration=(1/2)*(((x+phiy).^2+(y-phix).^2).^(1/2)+((x-phiy).^2+(y+phix).^2).^(1/2)); 
      plot(T,vibration,'k'); 
   case 1
      disp('Plotting parameter sweep in Omega')
      % This is the code for the parameter sweep in the rotation speed Omega

      Omend=Omega;  % maximum value for Omega
      dOm=0.1;  % step size for Omega

      rmax=cell(1,1+Omend/dOm);  % Here I'm just initializing an empty cell to stor the maximum vibration value in     
      rmin=cell(1,1+Omend/dOm);  % And the same for the minimum vibration levels.    

      tic % starting a timer just to check how long the code takes to run

      for i = 0:(Omend/dOm)         
      Omega=i*dOm;  % increase Omega by the stepsize
      % Define all the constants as a global variable 1x27 vector
      par = [Omega, Jt, Jp, epsilon, chi, beta, m1, m2, m3, m4, z1, z2, z3, z4, k11, k12, k22, c11, c12, c22, k33, k34, k44, c33, c34, c44, cb];
      % solve the system 'tpna' using ode45 with the 'options' of a mass matrix 'tpmassna' and a strong dependence on 2nd order derivates.
      options = odeset('Mass',@tpmassna,'MStateDependence','strong','AbsTol',1e-14);
      [T,Y] = ode45(@tpna,[0 800],[0 0 0 0 0 0 0 0 pi/2 0 -pi/2 0 pi/2 0 -pi/2 0],options);

      stp=(find(T>700,1,'first'));
      x=Y(:,1);
      y=Y(:,3);
      phix=Y(:,5);
      phiy=Y(:,7);
      % 'vibration' is a measure of the average vibration level at a distance of one unit
      % length from the midspan.
      vibration=(1/2)*(((x+phiy).^2+(y-phix).^2).^(1/2)+((x-phiy).^2+(y+phix).^2).^(1/2));
      [maxtab, mintab] = peakdet(vibration(stp:end), 0.01); %storing the max and min vibration levels using the function peakdet
      rmax{i+1}=maxtab(:,2);                       
      rmin{i+1}=mintab(:,2);
      i;   % take away the semicolon if you want to see how far along the computation you are
      end

      toc  % stop the timer and display the time since tic

      Omega=0:dOm:Omend+0.1;    % Define the Omega range in order for plotting           
      hold on
      for i=1:(1+Omend/dOm)           
      plot(Omega(i),rmax{i},'k.','MarkerEdgeColor','k');
      end

   otherwise
      disp('First argument should be either 0 or 1.')
end