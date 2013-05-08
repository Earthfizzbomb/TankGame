program TankGame;
//Left tank fires. Need to change code for firing right tank.
//Needs collision detection.
{$mode objfpc}{$H+}

uses
  SysUtils,  crt, Classes;

{$R *.res}

var
  XPosShotsP1, YPosShotsP1, XPosShotsP2, YPosShotsP2: array of integer;
  P1numofshots, P2numofshots, Count: integer;
  P1YPos, P2YPos: integer;
  userkey: char;
  p1lowestallowed, p1highestallowed, p1highestbulletallowed, p2lowestallowed, p2highestallowed, p2highestbulletallowed: integer;
begin
  cursoroff;
  p1lowestallowed := windmaxy;
  p2lowestallowed := windmaxy;
  p1highestbulletallowed := 27;
  p2highestbulletallowed := 4;
  P1numofshots := 0;
  P2numofshots := 0;
  //P1numofshots := 0;
  //P2numofshots := 0;
  P1YPos := windmaxY div 2;
  P2YPos := windmaxY div 2;
  gotoXY(4, P1YPos);
  Write('| |-');
  gotoXY(24, P2YPos);
  Write('-| |');
  for Count := 1 to windmaxY do
  begin
    gotoXY(14, Count);
    Write(' |');
  end;
  repeat
    if keypressed then
      userkey := readkey
    else
      userkey := '#';  //A value that is not used
    //p1's controls
    if (userkey = 'w') and (P1YPos > p1lowestallowed) then
    begin
      gotoXY(4, P1YPos);
      Write('    ');
      P1YPos := P1YPos - 1;
      gotoXY(4, P1YPos);
      Write('| |-');
    end;
    if (userkey = 'a') or (userkey = 's') and (P1YPos < p1highestallowed) then
    begin
      gotoXY(4, P1YPos);
      Write('    ');
      Inc(P1YPos);
      gotoXY(4, P1YPos);
      Write('| |-');
    end;
    if (userkey = 'z') then
    begin
      Inc(P1numofshots);
      setlength(XPosShotsP1, P1numofshots);
      setlength(YPosShotsP1, P1numofshots);
      YposshotsP1[P1numofshots-1] := P1Ypos;
      Xposshotsp1[p1numofshots-1] := 8;
    end;
    //p2's controls
    if (userkey = 'i') and (P2YPos > p2lowestallowed) then
    begin
      gotoXY(24, P2YPos);
      Write('    ');
      P2YPos := P2YPos - 1;
      gotoXY(24, P2YPos);
      Write('-| |');
    end;
    if (userkey = 'j') or (userkey = 'k') and (P2YPos < p2highestallowed) then
    begin
      gotoXY(24, P2YPos);
      Write('    ');
      Inc(P2YPos);
      gotoXY(24, P2YPos);
      Write('-| |');
    end;
    if (userkey = 'm') then
    begin
      Inc(P2numofshots);
      setlength(XPosShotsP2, P2numofshots);
      setlength(YPosShotsP2, P2numofshots);
      YposshotsP2[P2numofshots] := P2Ypos;
    end;
    if (p1numofshots > 0) then
    begin
     // for Count := 0 to P1numofshots do
      for Count := 0 to P1numofshots - 1 do //Dynamic arrays are zero-based
      begin
        //Go to previous position of shell
        gotoXY(xposshotsp1[Count] - 1, yposshotsp1[Count]);
        if (WhereX > 7) then  //Do not destroy own gun!
          write(' ');  //Delete shell from previous position
        gotoXY(xposshotsp1[Count], yposshotsp1[Count]);
        if WhereX <= p1highestbulletallowed then
          begin
            Write('-');
            Inc(XPosShotsP1[Count]);
          end;
      end;
    end;
    if (p2numofshots > 0) then
    begin
      for Count := 0 to P2numofshots do
      begin
        gotoXY(xposshotsp2[Count], yposshotsp2[Count]);

        Write('-');
        Inc(XPosShotsP2[Count]);
      end;
    end;
    for Count := 1 to windmaxY do
  begin
    gotoXY(15, Count);
    Write('|');
    end;
    sleep(50);
    until False;
end.



