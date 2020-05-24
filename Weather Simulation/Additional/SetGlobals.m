function SetGlobals(pObs,NTeams)

global c0 c1 c2 c3 C RC

c0 = pObs * NTeams / log2(NTeams);
c1 = 1;
c2 = 5;
c3 = 0.1;

C = 0.0;

RC = 1.0;

end