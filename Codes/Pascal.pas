program Pascal(input, output, stdErr);


const
	ITLIM: Int64 = 99999; (*Z jakiegos powodu kazda stala > 32768 musi byc w const*)
var
	VELX: array of Double;
	VELY: array of Double;
	VELZ: array of Double;
	POSX: array of Double;
	POSY: array of Double;
	POSZ: array of Double;
	MASS: array of Double;
	dX: array of Double;
	dY: array of Double;
	dZ: array of Double;
	dvX: array of Double;
	dvY: array of Double;
	dvZ: array of Double;
	WYPX: Double;
	WYPY: Double;
	WYPZ: Double;
	N: Int64;
	i: Int64;
	j: Int64;
	IT: Int64;
	G: Double;
	dT: Double;
	Skalar: Double;
	Distsq: Double;
begin
	G := 6.67 * 1e-11;
	dT := 0.001;
	read(N);
	setLength(VELX, N);
	setLength(VELY, N);
	setLength(VELZ, N);
	setLength(POSX, N);
	setLength(POSY, N);
	setLength(POSZ, N);
	setLength(MASS, N);
	setLength(dX, N);
	setLength(dY, N);
	setLength(dZ, N);
	setLength(dvX, N);
	setLength(dvY, N);
	setLength(dvZ, N);

	for i := 0 to N-1 do
	begin
		read(POSX[i], POSY[i], POSZ[i], VELX[i], VELY[i], VELZ[i], MASS[i]);
	
	end;

	for IT := 0 to ITLIM do
	begin
		for i := 0 to N-1 do
		begin
			dvX[i] := 0.00;
			dvY[i] := 0.00;
			dvZ[i] := 0.00;
			dX[i] := 0.00;
			dY[i] := 0.00;
			dZ[i] := 0.00;
		end;
		for i := 0 to N-1 do
		begin
			WYPX := 0.00;
			WYPY := 0.00;
			WYPZ := 0.00;
			for j := 0 to N-1 do
			begin
				if (i = j) then
				begin
					continue;
				end;
				Distsq := (POSX[j]-POSX[i])*(POSX[j]-POSX[i])+(POSY[j]-POSY[i])*(POSY[j]-POSY[i])+(POSZ[j]-POSZ[i])*(POSZ[j]-POSZ[i]);
				Skalar := (G * MASS[i] * MASS[j])/Distsq;
				WYPX += Skalar * ((POSX[j]-POSX[i])/sqrt(Distsq));
				WYPY += Skalar * ((POSY[j]-POSY[i])/sqrt(Distsq));
				WYPZ += Skalar * ((POSZ[j]-POSZ[i])/sqrt(Distsq));
				
			end;
			WYPX := WYPX / MASS[i];
			WYPY := WYPY / MASS[i];
			WYPZ := WYPZ / MASS[i];
			dvX[i] := WYPX * dT;
			dvY[i] := WYPY * dT;
			dvZ[i] := WYPZ * dT;
			dX[i] := VELX[i] * dT;
			dY[i] := VELY[i] * dT;
			dZ[i] := VELZ[i] * dT;
		end;
		for i := 0 to N-1 do
		begin
			VELX[i]+=dvX[i];
			VELY[i]+=dvY[i];
			VELZ[i]+=dvZ[i];
			POSX[i]+=dX[i]+0.5*dT*dvX[i];
			POSY[i]+=dY[i]+0.5*dT*dvY[i];
			POSZ[i]+=dZ[i]+0.5*dT*dvZ[i];
		end;
		
	end;
	for i:= 0 to N-1 do
	begin
		writeLn(POSX[i]:0:15, ' ', POSY[i]:0:15, ' ', POSZ[i]:0:15);
	end;

end.
