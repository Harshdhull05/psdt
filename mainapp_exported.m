classdef mainapp_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        ExportGraphicsButton           matlab.ui.control.Button
        InputParametersPanel           matlab.ui.container.Panel
        VelocityButton                 matlab.ui.control.Button
        TimeButton                     matlab.ui.control.Button
        UseifvelocitiesarefromaccelerationanddecelerationPanel  matlab.ui.container.Panel
        PlotPSDButton                  matlab.ui.control.Button
        PlotGlevelsButton              matlab.ui.control.Button
        InputSensitivitiesPanel        matlab.ui.container.Panel
        SensitivityofzEditField        matlab.ui.control.NumericEditField
        SensitivityofzEditFieldLabel   matlab.ui.control.Label
        SensitivityofyEditField        matlab.ui.control.NumericEditField
        SensitivityofyEditFieldLabel   matlab.ui.control.Label
        SensitivityofxEditField        matlab.ui.control.NumericEditField
        SensitivityofxEditFieldLabel   matlab.ui.control.Label
        ImportPanel                    matlab.ui.container.Panel
        filenameEditField_2            matlab.ui.control.EditField
        filenameEditField_2Label       matlab.ui.control.Label
        ImportvelocityfileButton       matlab.ui.control.Button
        filenameEditField              matlab.ui.control.EditField
        filenameEditFieldLabel         matlab.ui.control.Label
        ImportsignalfileButton         matlab.ui.control.Button
        PlotPSDvelocityButton          matlab.ui.control.Button
        PlotGlevelsvelocityButton      matlab.ui.control.Button
        PlotPSDtimeButton              matlab.ui.control.Button
        EntervalueofSamplingrateEditField  matlab.ui.control.NumericEditField
        EntervalueofSamplingrateLabel  matlab.ui.control.Label
        PlotGlevelstimeButton          matlab.ui.control.Button
        UIAxes6                        matlab.ui.control.UIAxes
        UIAxes5                        matlab.ui.control.UIAxes
        UIAxes4                        matlab.ui.control.UIAxes
        UIAxes3                        matlab.ui.control.UIAxes
        UIAxes2                        matlab.ui.control.UIAxes
        UIAxes                         matlab.ui.control.UIAxes
    end

    % 
     properties (Access = private)
         DialogApp % Description
         Currentlowert=0;
         Currentuppert=0;
     
         Currentlowerv=0;
         Currentupperv=0;
     end
  
    
    methods (Access = public)
        
        function updatemaint(app, lower, upper)
            app.Currentlowert=lower;
            app.Currentuppert=upper;
            app.TimeButton.Enable="on";
            app.VelocityButton.Enable="on";
            
        end
        
        function updatemainv(app, lower, upper)
            app.Currentlowerv=lower;
            app.Currentupperv=upper;
            app.TimeButton.Enable="on";
            app.VelocityButton.Enable="on";
        end
    end
   
    
    
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            updatemaint(app,app.Currentlowert,app.Currentuppert)
            updatemainv(app,app.Currentlowerv,app.Currentupperv)
            
        end

        % Button pushed function: ImportsignalfileButton
        function ImportsignalfileButtonPushed(app, event)
            [filename,path]=uigetfile();
            app.filenameEditField.Value=filename;
        end

        % Button pushed function: TimeButton
        function TimeButtonPushed(app, event)
          app.TimeButton.Enable="off";
          lowervalue=app.Currentlowert;
          uppervalue=app.Currentuppert;
          time(app,lowervalue,uppervalue);

        end

        % Button pushed function: VelocityButton
        function VelocityButtonPushed(app, event)
            app.VelocityButton.Enable="off";
          lowervalue=app.Currentlowerv;
          uppervalue=app.Currentupperv;
          velocity(app,lowervalue,uppervalue);
        end

        % Value changed function: SensitivityofxEditField
        function SensitivityofxEditFieldValueChanged(app, event)
            value = app.SensitivityofxEditField.Value;
            
        end

        % Value changed function: EntervalueofSamplingrateEditField
        function EntervalueofSamplingrateEditFieldValueChanged(app, event)
            value = app.EntervalueofSamplingrateEditField.Value;
            
        end

        % Button pushed function: PlotGlevelstimeButton
        function PlotGlevelstimeButtonPushed(app, event)
              T=readtable(app.filenameEditField.Value);
             
              
              indexl=(((app.EntervalueofSamplingrateEditField.Value)*(app.Currentlowert))+1);
              indexu=(((app.EntervalueofSamplingrateEditField.Value)*(app.Currentuppert))+1);
              timedata=T.(cell2mat(T.Properties.VariableNames(4)))((indexl):(indexu));
              voltagedatax=T.(cell2mat(T.Properties.VariableNames(1)))((indexl):(indexu));
              voltagedatay=T.(cell2mat(T.Properties.VariableNames(2)))((indexl):(indexu));
              voltagedataz=T.(cell2mat(T.Properties.VariableNames(3)))((indexl):(indexu));
                voltagedatax=voltagedatax./app.SensitivityofxEditField.Value;
                voltagedatay=voltagedatay./app.SensitivityofyEditField.Value;
                voltagedataz=voltagedataz./app.SensitivityofzEditField.Value;
              plot(app.UIAxes,timedata,10*log10(voltagedatax))
              plot(app.UIAxes2,timedata,10*log10(voltagedatay))
              plot(app.UIAxes3,timedata,10*log10(voltagedataz))
             % % for velocity
              % A=readtable(app.filenameEditField_2.Value);
              % rows=A.v==app.Currentlowerv;
              % ilv=find(rows==1);
              % 
              %  rows=A.v==app.Currentupperv;
              % iuv=find(rows==1);
              % T=readtable(app.filenameEditField.Value);
              % timedatav=T.t((ilv):(iuv));
              % voltagedatavx=T.x((ilv):(iuv));
              % voltagedatavy=T.y((ilv):(iuv));
              % voltagedatavz=T.z((ilv):(iuv));
              %   voltagedatavx=voltagedatavx./app.SensitivityofxEditField.Value;
              %   voltagedatavy=voltagedatavy./app.SensitivityofyEditField.Value;
              %   voltagedatavz=voltagedatavz./app.SensitivityofzEditField.Value;
              % plot(app.UIAxes,timedatav,10*log10(voltagedatavx))
              % plot(app.UIAxes2,timedatav,10*log10(voltagedatavy))
              % plot(app.UIAxes3,timedatav,10*log10(voltagedatavz))
           
%             vdata=zeros(iuv-ilv+1,1);
% for i=1:iuv-ilv+1
%     vdata(i,1)=A.v(ilv-1,1);
%     ilv=ilv+1;
% end
            







           
        end

        % Value changed function: SensitivityofyEditField
        function SensitivityofyEditFieldValueChanged(app, event)
            value = app.SensitivityofyEditField.Value;
            
        end

        % Value changed function: SensitivityofzEditField
        function SensitivityofzEditFieldValueChanged(app, event)
            value = app.SensitivityofzEditField.Value;
            
        end

        % Value changed function: filenameEditField
        function filenameEditFieldValueChanged2(app, event)
            value = app.filenameEditField.Value;
            value = app.filenameEditField.Value;
            app.filenameEditField.Value=filename;
             figure(app.UIFigure)
            
            
        end

        % Button pushed function: PlotPSDtimeButton
        function PlotPSDtimeButtonPushed(app, event)
            T=readtable(app.filenameEditField.Value);
                      
            indexl=(((app.EntervalueofSamplingrateEditField.Value)*(app.Currentlowert))+1);
            indexu=(((app.EntervalueofSamplingrateEditField.Value)*(app.Currentuppert))+1);
            timedata=T.t((indexl):(indexu));
            voltagedatax=T.(cell2mat(T.Properties.VariableNames(1)))((indexl):(indexu));
            voltagedatay=T.(cell2mat(T.Properties.VariableNames(2)))((indexl):(indexu));
            voltagedataz=T.(cell2mat(T.Properties.VariableNames(3)))((indexl):(indexu));
              voltagedatax=voltagedatax./app.SensitivityofxEditField.Value;
              voltagedatay=voltagedatay./app.SensitivityofyEditField.Value;
              voltagedataz=voltagedataz./app.SensitivityofzEditField.Value;
            
            [pxx,f] = pwelch( voltagedatax,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes4,f,10*log10(pxx))
            [pxx,f] = pwelch( voltagedatay,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes5,f,10*log10(pxx))
            [pxx,f] = pwelch( voltagedataz,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes6,f,10*log10(pxx))
        end

        % Button pushed function: ImportvelocityfileButton
        function ImportvelocityfileButtonPushed(app, event)
            [filename,path]=uigetfile();
            app.filenameEditField_2.Value=filename;
        end

        % Value changed function: filenameEditField_2
        function filenameEditField_2ValueChanged(app, event)
            value = app.filenameEditField_2.Value;
             app.filenameEditField_2.Value=filename;
             figure(app.UIFigure)
            
        end

        % Button pushed function: PlotGlevelsvelocityButton
        function PlotGlevelsvelocityButtonPushed(app, event)
           
            A=readtable(app.filenameEditField_2.Value);
n=size(A.(cell2mat(A.Properties.VariableNames(1))));
  if (app.Currentlowerv<=app.Currentupperv)
i=1;
while(i<(n(1)+1))
   if(A.(cell2mat(A.Properties.VariableNames(1)))(i)>=app.Currentlowerv)
        upper_bound=A.(cell2mat(A.Properties.VariableNames(1)))(i);
        lower_bound=A.(cell2mat(A.Properties.VariableNames(1)))(i-1);
        break;
   end
   i=i+1;
end

if(abs(app.Currentlowerv-upper_bound)>abs(app.Currentlowerv-lower_bound))
app.Currentlowerv=lower_bound;
else
    app.Currentlowerv=upper_bound;

end
% for upperv
 j=1;
      
while(j<(n(1)+1))
   if(A.(cell2mat(A.Properties.VariableNames(1)))(j)>=app.Currentupperv)
        upper_bound2=A.(cell2mat(A.Properties.VariableNames(1)))(j);
        lower_bound2=A.(cell2mat(A.Properties.VariableNames(1)))(j-1);
        break;
   end
   j=j+1;
end

if(abs(app.Currentupperv-upper_bound2)>abs(app.Currentupperv-lower_bound2))
app.Currentupperv=lower_bound2;
else
    app.Currentupperv=upper_bound2;

end
% app.Currentlowerv=round(app.Currentlowerv,1);
% app.Currentupperv=round(app.Currentupperv,1);
               % rows=A.v==app.Currentlowerv;
               % if (app.Currentlowerv<app.Currentupperv)
               tolerance=1e-11;
               rows=ismembertol(A.(cell2mat(A.Properties.VariableNames(1))),app.Currentlowerv,tolerance);
               ilv=find(rows==1);
               rows1=ismembertol(A.(cell2mat(A.Properties.VariableNames(1))),app.Currentupperv,tolerance);
              
               iuv=find(rows1==1);
          % new
                 y1=A.(cell2mat(A.Properties.VariableNames(2)))(ilv);
                 y2=A.(cell2mat(A.Properties.VariableNames(2)))(iuv);
               T=readtable(app.filenameEditField.Value);
              tolerance=1e-10;
               v=ismembertol(T.(cell2mat(T.Properties.VariableNames(4))),y1,tolerance);
             
                ilvt=find(v==1);
                u=ismembertol(T.(cell2mat(T.Properties.VariableNames(4))),y2,tolerance);
                 
                 iuvt=find(u==1);
               timedatav=T.(cell2mat(T.Properties.VariableNames(4)))((ilvt):(iuvt));
               voltagedatavx=T.(cell2mat(T.Properties.VariableNames(1)))((ilvt):(iuvt));
               voltagedatavy=T.(cell2mat(T.Properties.VariableNames(2)))((ilvt):(iuvt));
               voltagedatavz=T.(cell2mat(T.Properties.VariableNames(3)))((ilvt):(iuvt));
                 voltagedatavx=voltagedatavx./app.SensitivityofxEditField.Value;
                 voltagedatavy=voltagedatavy./app.SensitivityofyEditField.Value;
                voltagedatavz=voltagedatavz./app.SensitivityofzEditField.Value;
               plot(app.UIAxes,timedatav,10*log10(voltagedatavx))
               plot(app.UIAxes2,timedatav,10*log10(voltagedatavy))
               plot(app.UIAxes3,timedatav,10*log10(voltagedatavz))
  else 
            m=max(A.v);
      tolerance=1e-15;

 ma=ismembertol(A.(cell2mat(A.Properties.VariableNames(1))),m,tolerance);
xm=find(ma==1);
maxdata=A.(cell2mat(A.Properties.VariableNames(1)))((xm):(end));
      i=1;
while(i<(n(1)+1))
   if(maxdata(i)<=app.Currentlowerv)
        upper_bound=maxdata(i);
        lower_bound=maxdata(i-1);
        break;
   end
   i=i+1;
end

if(abs(app.Currentlowerv-upper_bound)>abs(app.Currentlowerv-lower_bound))
app.Currentlowerv=lower_bound;
else
    app.Currentlowerv=upper_bound;

end
% for upperv
 j=1;


while(j<(n(1)+1))
   if(maxdata(j)<=app.Currentupperv)
        upper_bound2=maxdata(j);
        lower_bound2=maxdata(j-1);
        break;
   end
   j=j+1;
end

if(abs(app.Currentupperv-upper_bound2)>abs(app.Currentupperv-lower_bound2))
app.Currentupperv=lower_bound2;
else
    app.Currentupperv=upper_bound2;

end
                  T=readtable(app.filenameEditField.Value);
     
v12=ismembertol(maxdata,app.Currentlowerv,tolerance);
x22=find(v12==1);
v13=ismembertol(maxdata,app.Currentupperv,tolerance);
x23=find(v13==1);
x22=x22+xm-1;
x23=x23+xm-1;
x222=A.(cell2mat(A.Properties.VariableNames(2)))(x22);
x232=A.(cell2mat(A.Properties.VariableNames(2)))(x23);
tolerance1=1e-6;
 tl=ismembertol(T.(cell2mat(T.Properties.VariableNames(4))),x222,tolerance1);
 xlf=find(tl==1);
  tu=ismembertol(T.(cell2mat(T.Properties.VariableNames(4))),x232,tolerance1);
 xuf=find(tu==1);
 timedata2=T.(cell2mat(T.Properties.VariableNames(4)))((xlf):(xuf));
            voltagedatavx2=T.(cell2mat(T.Properties.VariableNames(1)))((xlf):(xuf));
               voltagedatavy2=T.(cell2mat(T.Properties.VariableNames(2)))((xlf):(xuf));
               voltagedatavz2=T.(cell2mat(T.Properties.VariableNames(3)))((xlf):(xuf));
                %  voltagedatavx2=voltagedatavx2./app.SensitivityofxEditField.Value;
                %  voltagedatavy2=voltagedatavy2./app.SensitivityofyEditField.Value;
                % voltagedatavz2=voltagedatavz2./app.SensitivityofzEditField.Value;
               plot(app.UIAxes,timedata2,10*log10(voltagedatavx2))
               plot(app.UIAxes2,timedata2,10*log10(voltagedatavy2))
               plot(app.UIAxes3,timedata2,10*log10(voltagedatavz2))
   end
        end

        % Button pushed function: PlotPSDvelocityButton
        function PlotPSDvelocityButtonPushed(app, event)
                          A=readtable(app.filenameEditField_2.Value);
n=size(A.(cell2mat(A.Properties.VariableNames(1))));
  if (app.Currentlowerv<=app.Currentupperv)
i=1;
while(i<(n(1)+1))
   if(A.(cell2mat(A.Properties.VariableNames(1)))(i)>=app.Currentlowerv)
        upper_bound=A.(cell2mat(A.Properties.VariableNames(1)))(i);
        lower_bound=A.(cell2mat(A.Properties.VariableNames(1)))(i-1);
        break;
   end
   i=i+1;
end

if(abs(app.Currentlowerv-upper_bound)>abs(app.Currentlowerv-lower_bound))
app.Currentlowerv=lower_bound;
else
    app.Currentlowerv=upper_bound;

end
% for upperv
 j=1;
      
while(j<(n(1)+1))
   if(A.(cell2mat(A.Properties.VariableNames(1)))(j)>=app.Currentupperv)
        upper_bound2=A.(cell2mat(A.Properties.VariableNames(1)))(j);
        lower_bound2=A.(cell2mat(A.Properties.VariableNames(1)))(j-1);
        break;
   end
   j=j+1;
end

if(abs(app.Currentupperv-upper_bound2)>abs(app.Currentupperv-lower_bound2))
app.Currentupperv=lower_bound2;
else
    app.Currentupperv=upper_bound2;

end

               % rows=A.v==app.Currentlowerv;
               % if (app.Currentlowerv<app.Currentupperv)
               tolerance=1e-11;
               rows=ismembertol(A.(cell2mat(A.Properties.VariableNames(1))),app.Currentlowerv,tolerance);
               ilv=find(rows==1);
               rows1=ismembertol(A.(cell2mat(A.Properties.VariableNames(1))),app.Currentupperv,tolerance);
              
               iuv=find(rows1==1);
          % new
                 y1=A.(cell2mat(A.Properties.VariableNames(2)))(ilv);
                 y2=A.(cell2mat(A.Properties.VariableNames(2)))(iuv);
               T=readtable(app.filenameEditField.Value);
              tolerance=1e-10;
               v=ismembertol(T.(cell2mat(T.Properties.VariableNames(4))),y1,tolerance);
             
                ilvt=find(v==1);
                u=ismembertol(T.(cell2mat(T.Properties.VariableNames(4))),y2,tolerance);
                 
                 iuvt=find(u==1);
               timedatav=T.(cell2mat(T.Properties.VariableNames(4)))((ilvt):(iuvt));
               voltagedatavx=T.(cell2mat(T.Properties.VariableNames(1)))((ilvt):(iuvt));
               voltagedatavy=T.(cell2mat(T.Properties.VariableNames(2)))((ilvt):(iuvt));
               voltagedatavz=T.(cell2mat(T.Properties.VariableNames(3)))((ilvt):(iuvt));
                
                 voltagedatavx=voltagedatavx./app.SensitivityofxEditField.Value;
                 voltagedatavy=voltagedatavy./app.SensitivityofyEditField.Value;
               voltagedatavz=voltagedatavz./app.SensitivityofzEditField.Value;
                  [pxx,f] = pwelch( voltagedatavx,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes4,f,10*log10(pxx))
            [pxx,f] = pwelch( voltagedatavy,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes5,f,10*log10(pxx))
            [pxx,f] = pwelch( voltagedatavz,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes6,f,10*log10(pxx)) 
                         else
                                   m=max(A.v);
      tolerance=1e-15;

 ma=ismembertol(A.(cell2mat(A.Properties.VariableNames(1))),m,tolerance);
xm=find(ma==1);
maxdata=A.(cell2mat(A.Properties.VariableNames(1)))((xm):(end));
      i=1;
while(i<(n(1)+1))
   if(maxdata(i)<=app.Currentlowerv)
        upper_bound=maxdata(i);
        lower_bound=maxdata(i-1);
        break;
   end
   i=i+1;
end

if(abs(app.Currentlowerv-upper_bound)>abs(app.Currentlowerv-lower_bound))
app.Currentlowerv=lower_bound;
else
    app.Currentlowerv=upper_bound;

end
% for upperv
 j=1;


while(j<(n(1)+1))
   if(maxdata(j)<=app.Currentupperv)
        upper_bound2=maxdata(j);
        lower_bound2=maxdata(j-1);
        break;
   end
   j=j+1;
end

if(abs(app.Currentupperv-upper_bound2)>abs(app.Currentupperv-lower_bound2))
app.Currentupperv=lower_bound2;
else
    app.Currentupperv=upper_bound2;

end
                  T=readtable(app.filenameEditField.Value);
     
v12=ismembertol(maxdata,app.Currentlowerv,tolerance);
x22=find(v12==1);
v13=ismembertol(maxdata,app.Currentupperv,tolerance);
x23=find(v13==1);
x22=x22+xm-1;
x23=x23+xm-1;
x222=A.(cell2mat(A.Properties.VariableNames(2)))(x22);
x232=A.(cell2mat(A.Properties.VariableNames(2)))(x23);
tolerance1=1e-6;
 tl=ismembertol(T.(cell2mat(T.Properties.VariableNames(4))),x222,tolerance1);
 xlf=find(tl==1);
  tu=ismembertol(T.(cell2mat(T.Properties.VariableNames(4))),x232,tolerance1);
 xuf=find(tu==1);
 timedata2=T.(cell2mat(T.Properties.VariableNames(4)))((xlf):(xuf));
            voltagedatavx=T.(cell2mat(T.Properties.VariableNames(1)))((xlf):(xuf));
               voltagedatavy=T.(cell2mat(T.Properties.VariableNames(2)))((xlf):(xuf));
               voltagedatavz=T.(cell2mat(T.Properties.VariableNames(3)))((xlf):(xuf));
                   [pxx,f] = pwelch( voltagedatavx,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes4,f,10*log10(pxx))
            [pxx,f] = pwelch( voltagedatavy,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes5,f,10*log10(pxx))
            [pxx,f] = pwelch( voltagedatavz,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes6,f,10*log10(pxx)) 

                         end
        
        end

        % Button pushed function: PlotGlevelsButton
        function PlotGlevelsButtonPushed(app, event)
            A=readtable(app.filenameEditField_2.Value);
 B=readtable(app.filenameEditField.Value);
 n=size(A.(cell2mat(A.Properties.VariableNames(1))));
i=1;
while(i<(n(1)+1))
   if(A.(cell2mat(A.Properties.VariableNames(1)))(i)>=app.Currentlowerv)
        upper_bound=A.(cell2mat(A.Properties.VariableNames(1)))(i);
        lower_bound=A.(cell2mat(A.Properties.VariableNames(1)))(i-1);
        break;
   end
   i=i+1;
end

if(abs(app.Currentlowerv-upper_bound)>abs(app.Currentlowerv-lower_bound))
app.Currentlowerv=lower_bound;
else
    app.Currentlowerv=upper_bound;

end

 tolerance=1e-6;
 v=ismembertol(A.(cell2mat(A.Properties.VariableNames(1))),app.Currentlowerv,tolerance);
x1=find(v==1);
 y1=A.(cell2mat(A.Properties.VariableNames(2)))(x1);
  tolerance=1e-6;
 v2=ismembertol(B.(cell2mat(B.Properties.VariableNames(4))),y1,tolerance);
 x13=find(v2==1);
  m=max(A.(cell2mat(A.Properties.VariableNames(1))));
      tolerance=1e-6;

 ma=ismembertol(A.(cell2mat(A.Properties.VariableNames(1))),m,tolerance);
xm=find(ma==1);
maxdata=A.(cell2mat(A.Properties.VariableNames(1)))((xm):(end));
 j=1;


while(j<(n(1)+1))
   if(maxdata(j)<=app.Currentupperv)
        upper_bound2=maxdata(j);
        lower_bound2=maxdata(j-1);
        break;
   end
   j=j+1;
end

if(abs(app.Currentupperv-upper_bound2)>abs(app.Currentupperv-lower_bound2))
app.Currentupperv=lower_bound2;
else
    app.Currentupperv=upper_bound2;

end
v13=ismembertol(maxdata,app.Currentupperv,tolerance);
x23=find(v13==1);
x23=x23+xm-1;
x232=A.(cell2mat(A.Properties.VariableNames(2)))(x23);
tolerance1=1e-6;
 tl=ismembertol(B.(cell2mat(B.Properties.VariableNames(4))),x232,tolerance1);
 xlf=find(tl==1);
 timedatav=B.(cell2mat(B.Properties.VariableNames(4)))((x13):(xlf));
               voltagedatavx=B.(cell2mat(B.Properties.VariableNames(1)))((x13):(xlf));
               voltagedatavy=B.(cell2mat(B.Properties.VariableNames(2)))((x13):(xlf));
               voltagedatavz=B.(cell2mat(B.Properties.VariableNames(3)))((x13):(xlf));
                 voltagedatavx=voltagedatavx./app.SensitivityofxEditField.Value;
                 voltagedatavy=voltagedatavy./app.SensitivityofyEditField.Value;
                voltagedatavz=voltagedatavz./app.SensitivityofzEditField.Value;
               plot(app.UIAxes,timedatav,10*log10(voltagedatavx))
               plot(app.UIAxes2,timedatav,10*log10(voltagedatavy))
               plot(app.UIAxes3,timedatav,10*log10(voltagedatavz))
        end

        % Button pushed function: PlotPSDButton
        function PlotPSDButtonPushed(app, event)
              
                A=readtable(app.filenameEditField_2.Value);
 B=readtable(app.filenameEditField.Value);
 n=size(A.(cell2mat(A.Properties.VariableNames(1))));
i=1;
while(i<(n(1)+1))
   if(A.(cell2mat(A.Properties.VariableNames(1)))(i)>=app.Currentlowerv)
        upper_bound=A.(cell2mat(A.Properties.VariableNames(1)))(i);
        lower_bound=A.(cell2mat(A.Properties.VariableNames(1)))(i-1);
        break;
   end
   i=i+1;
end

if(abs(app.Currentlowerv-upper_bound)>abs(app.Currentlowerv-lower_bound))
app.Currentlowerv=lower_bound;
else
    app.Currentlowerv=upper_bound;

end

 tolerance=1e-15;
 v=ismembertol(A.(cell2mat(A.Properties.VariableNames(1))),app.Currentlowerv,tolerance);
x1=find(v==1);
 y1=A.(cell2mat(A.Properties.VariableNames(2)))(x1);
  tolerance=1e-15;
 v2=ismembertol(B.(cell2mat(B.Properties.VariableNames(4))),y1,tolerance);
 x13=find(v2==1);
  m=max(A.(cell2mat(A.Properties.VariableNames(1))));
      tolerance=1e-15;

 ma=ismembertol(A.(cell2mat(A.Properties.VariableNames(1))),m,tolerance);
xm=find(ma==1);
maxdata=A.(cell2mat(A.Properties.VariableNames(1)))((xm):(end));
 j=1;


while(j<(n(1)+1))
   if(maxdata(j)<=app.Currentupperv)
        upper_bound2=maxdata(j);
        lower_bound2=maxdata(j-1);
        break;
   end
   j=j+1;
end

if(abs(app.Currentupperv-upper_bound2)>abs(app.Currentupperv-lower_bound2))
app.Currentupperv=lower_bound2;
else
    app.Currentupperv=upper_bound2;

end
v13=ismembertol(maxdata,app.Currentupperv,tolerance);
x23=find(v13==1);
x23=x23+xm-1;
x232=A.(cell2mat(A.Properties.VariableNames(2)))(x23);
tolerance1=1e-6;
 tl=ismembertol(B.(cell2mat(B.Properties.VariableNames(4))),x232,tolerance1);
 xlf=find(tl==1);
 timedatav=B.(cell2mat(B.Properties.VariableNames(4)))((x13):(xlf));
               voltagedatavx=B.(cell2mat(B.Properties.VariableNames(1)))((x13):(xlf));
               voltagedatavy=B.(cell2mat(B.Properties.VariableNames(2)))((x13):(xlf));
               voltagedatavz=B.(cell2mat(B.Properties.VariableNames(3)))((x13):(xlf));
                 voltagedatavx=voltagedatavx./app.SensitivityofxEditField.Value;
                 voltagedatavy=voltagedatavy./app.SensitivityofyEditField.Value;
                voltagedatavz=voltagedatavz./app.SensitivityofzEditField.Value;
                [pxx,f] = pwelch( voltagedatavx,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes4,f,10*log10(pxx))
            [pxx,f] = pwelch( voltagedatavy,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes5,f,10*log10(pxx))
            [pxx,f] = pwelch( voltagedatavz,500,0,500,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes6,f,10*log10(pxx)) 

        end

        % Button pushed function: ExportGraphicsButton
        function ExportGraphicsButtonPushed(app, event)
            exportgraphics(app.UIAxes,"plot.pdf","Append",true);
            exportgraphics(app.UIAxes2,"plot.pdf","Append",true);
            exportgraphics(app.UIAxes3,"plot.pdf","Append",true);
            exportgraphics(app.UIAxes4,"plot.pdf","Append",true);
            exportgraphics(app.UIAxes5,"plot.pdf","Append",true);
            exportgraphics(app.UIAxes6,"plot.pdf","Append",true);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1050 612];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Glevelx')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.FontWeight = 'bold';
            app.UIAxes.Position = [333 464 145 133];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Glevely')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.FontWeight = 'bold';
            app.UIAxes2.Position = [572 464 150 139];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.UIFigure);
            title(app.UIAxes3, 'Glevelz')
            xlabel(app.UIAxes3, 'X')
            ylabel(app.UIAxes3, 'Y')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.FontWeight = 'bold';
            app.UIAxes3.Position = [831 465 156 139];

            % Create UIAxes4
            app.UIAxes4 = uiaxes(app.UIFigure);
            title(app.UIAxes4, 'PSDx')
            xlabel(app.UIAxes4, 'X')
            ylabel(app.UIAxes4, 'Y')
            zlabel(app.UIAxes4, 'Z')
            app.UIAxes4.FontWeight = 'bold';
            app.UIAxes4.Position = [333 266 145 137];

            % Create UIAxes5
            app.UIAxes5 = uiaxes(app.UIFigure);
            title(app.UIAxes5, 'PSDy')
            xlabel(app.UIAxes5, 'X')
            ylabel(app.UIAxes5, 'Y')
            zlabel(app.UIAxes5, 'Z')
            app.UIAxes5.FontWeight = 'bold';
            app.UIAxes5.Position = [572 258 150 137];

            % Create UIAxes6
            app.UIAxes6 = uiaxes(app.UIFigure);
            title(app.UIAxes6, 'PSDz')
            xlabel(app.UIAxes6, 'X')
            ylabel(app.UIAxes6, 'Y')
            zlabel(app.UIAxes6, 'Z')
            app.UIAxes6.FontWeight = 'bold';
            app.UIAxes6.Position = [831 258 156 136];

            % Create PlotGlevelstimeButton
            app.PlotGlevelstimeButton = uibutton(app.UIFigure, 'push');
            app.PlotGlevelstimeButton.ButtonPushedFcn = createCallbackFcn(app, @PlotGlevelstimeButtonPushed, true);
            app.PlotGlevelstimeButton.FontWeight = 'bold';
            app.PlotGlevelstimeButton.Position = [28 59 112 23];
            app.PlotGlevelstimeButton.Text = 'Plot Glevels time';

            % Create EntervalueofSamplingrateLabel
            app.EntervalueofSamplingrateLabel = uilabel(app.UIFigure);
            app.EntervalueofSamplingrateLabel.HorizontalAlignment = 'right';
            app.EntervalueofSamplingrateLabel.FontWeight = 'bold';
            app.EntervalueofSamplingrateLabel.Position = [32 382 88 30];
            app.EntervalueofSamplingrateLabel.Text = {'Enter value of '; 'Sampling rate'};

            % Create EntervalueofSamplingrateEditField
            app.EntervalueofSamplingrateEditField = uieditfield(app.UIFigure, 'numeric');
            app.EntervalueofSamplingrateEditField.ValueChangedFcn = createCallbackFcn(app, @EntervalueofSamplingrateEditFieldValueChanged, true);
            app.EntervalueofSamplingrateEditField.FontWeight = 'bold';
            app.EntervalueofSamplingrateEditField.Position = [135 390 100 22];

            % Create PlotPSDtimeButton
            app.PlotPSDtimeButton = uibutton(app.UIFigure, 'push');
            app.PlotPSDtimeButton.ButtonPushedFcn = createCallbackFcn(app, @PlotPSDtimeButtonPushed, true);
            app.PlotPSDtimeButton.FontWeight = 'bold';
            app.PlotPSDtimeButton.Position = [32 20 100 23];
            app.PlotPSDtimeButton.Text = 'Plot PSD time';

            % Create PlotGlevelsvelocityButton
            app.PlotGlevelsvelocityButton = uibutton(app.UIFigure, 'push');
            app.PlotGlevelsvelocityButton.ButtonPushedFcn = createCallbackFcn(app, @PlotGlevelsvelocityButtonPushed, true);
            app.PlotGlevelsvelocityButton.FontWeight = 'bold';
            app.PlotGlevelsvelocityButton.Position = [175 59 132 23];
            app.PlotGlevelsvelocityButton.Text = 'Plot Glevels velocity';

            % Create PlotPSDvelocityButton
            app.PlotPSDvelocityButton = uibutton(app.UIFigure, 'push');
            app.PlotPSDvelocityButton.ButtonPushedFcn = createCallbackFcn(app, @PlotPSDvelocityButtonPushed, true);
            app.PlotPSDvelocityButton.FontWeight = 'bold';
            app.PlotPSDvelocityButton.Position = [175 20 114 23];
            app.PlotPSDvelocityButton.Text = 'Plot PSD velocity';

            % Create ImportPanel
            app.ImportPanel = uipanel(app.UIFigure);
            app.ImportPanel.BorderType = 'none';
            app.ImportPanel.BorderWidth = 2;
            app.ImportPanel.Title = 'Import';
            app.ImportPanel.FontWeight = 'bold';
            app.ImportPanel.Position = [9 434 284 170];

            % Create ImportsignalfileButton
            app.ImportsignalfileButton = uibutton(app.ImportPanel, 'push');
            app.ImportsignalfileButton.ButtonPushedFcn = createCallbackFcn(app, @ImportsignalfileButtonPushed, true);
            app.ImportsignalfileButton.FontWeight = 'bold';
            app.ImportsignalfileButton.Position = [70 120 111 23];
            app.ImportsignalfileButton.Text = 'Import signal file';

            % Create filenameEditFieldLabel
            app.filenameEditFieldLabel = uilabel(app.ImportPanel);
            app.filenameEditFieldLabel.HorizontalAlignment = 'right';
            app.filenameEditFieldLabel.FontWeight = 'bold';
            app.filenameEditFieldLabel.Position = [27 88 54 22];
            app.filenameEditFieldLabel.Text = 'filename';

            % Create filenameEditField
            app.filenameEditField = uieditfield(app.ImportPanel, 'text');
            app.filenameEditField.ValueChangedFcn = createCallbackFcn(app, @filenameEditFieldValueChanged2, true);
            app.filenameEditField.FontWeight = 'bold';
            app.filenameEditField.Position = [96 88 100 22];

            % Create ImportvelocityfileButton
            app.ImportvelocityfileButton = uibutton(app.ImportPanel, 'push');
            app.ImportvelocityfileButton.ButtonPushedFcn = createCallbackFcn(app, @ImportvelocityfileButtonPushed, true);
            app.ImportvelocityfileButton.FontWeight = 'bold';
            app.ImportvelocityfileButton.Position = [64 57 121 23];
            app.ImportvelocityfileButton.Text = 'Import velocity file';

            % Create filenameEditField_2Label
            app.filenameEditField_2Label = uilabel(app.ImportPanel);
            app.filenameEditField_2Label.HorizontalAlignment = 'right';
            app.filenameEditField_2Label.FontWeight = 'bold';
            app.filenameEditField_2Label.Position = [27 24 54 22];
            app.filenameEditField_2Label.Text = 'filename';

            % Create filenameEditField_2
            app.filenameEditField_2 = uieditfield(app.ImportPanel, 'text');
            app.filenameEditField_2.ValueChangedFcn = createCallbackFcn(app, @filenameEditField_2ValueChanged, true);
            app.filenameEditField_2.FontWeight = 'bold';
            app.filenameEditField_2.Position = [96 24 100 22];

            % Create InputSensitivitiesPanel
            app.InputSensitivitiesPanel = uipanel(app.UIFigure);
            app.InputSensitivitiesPanel.BorderType = 'none';
            app.InputSensitivitiesPanel.BorderWidth = 2;
            app.InputSensitivitiesPanel.Title = 'Input Sensitivities';
            app.InputSensitivitiesPanel.FontWeight = 'bold';
            app.InputSensitivitiesPanel.Position = [21 94 287 146];

            % Create SensitivityofxEditFieldLabel
            app.SensitivityofxEditFieldLabel = uilabel(app.InputSensitivitiesPanel);
            app.SensitivityofxEditFieldLabel.HorizontalAlignment = 'right';
            app.SensitivityofxEditFieldLabel.FontWeight = 'bold';
            app.SensitivityofxEditFieldLabel.Position = [18 95 90 22];
            app.SensitivityofxEditFieldLabel.Text = 'Sensitivity of x';

            % Create SensitivityofxEditField
            app.SensitivityofxEditField = uieditfield(app.InputSensitivitiesPanel, 'numeric');
            app.SensitivityofxEditField.ValueChangedFcn = createCallbackFcn(app, @SensitivityofxEditFieldValueChanged, true);
            app.SensitivityofxEditField.FontWeight = 'bold';
            app.SensitivityofxEditField.Position = [123 95 100 22];

            % Create SensitivityofyEditFieldLabel
            app.SensitivityofyEditFieldLabel = uilabel(app.InputSensitivitiesPanel);
            app.SensitivityofyEditFieldLabel.HorizontalAlignment = 'right';
            app.SensitivityofyEditFieldLabel.FontWeight = 'bold';
            app.SensitivityofyEditFieldLabel.Position = [19 57 90 22];
            app.SensitivityofyEditFieldLabel.Text = 'Sensitivity of y';

            % Create SensitivityofyEditField
            app.SensitivityofyEditField = uieditfield(app.InputSensitivitiesPanel, 'numeric');
            app.SensitivityofyEditField.ValueChangedFcn = createCallbackFcn(app, @SensitivityofyEditFieldValueChanged, true);
            app.SensitivityofyEditField.FontWeight = 'bold';
            app.SensitivityofyEditField.Position = [124 57 100 22];

            % Create SensitivityofzEditFieldLabel
            app.SensitivityofzEditFieldLabel = uilabel(app.InputSensitivitiesPanel);
            app.SensitivityofzEditFieldLabel.HorizontalAlignment = 'right';
            app.SensitivityofzEditFieldLabel.FontWeight = 'bold';
            app.SensitivityofzEditFieldLabel.Position = [20 23 89 22];
            app.SensitivityofzEditFieldLabel.Text = 'Sensitivity of z';

            % Create SensitivityofzEditField
            app.SensitivityofzEditField = uieditfield(app.InputSensitivitiesPanel, 'numeric');
            app.SensitivityofzEditField.ValueChangedFcn = createCallbackFcn(app, @SensitivityofzEditFieldValueChanged, true);
            app.SensitivityofzEditField.FontWeight = 'bold';
            app.SensitivityofzEditField.Position = [124 23 100 22];

            % Create UseifvelocitiesarefromaccelerationanddecelerationPanel
            app.UseifvelocitiesarefromaccelerationanddecelerationPanel = uipanel(app.UIFigure);
            app.UseifvelocitiesarefromaccelerationanddecelerationPanel.Title = 'Use if velocities are from acceleration and deceleration';
            app.UseifvelocitiesarefromaccelerationanddecelerationPanel.FontWeight = 'bold';
            app.UseifvelocitiesarefromaccelerationanddecelerationPanel.Position = [370 20 352 162];

            % Create PlotGlevelsButton
            app.PlotGlevelsButton = uibutton(app.UseifvelocitiesarefromaccelerationanddecelerationPanel, 'push');
            app.PlotGlevelsButton.ButtonPushedFcn = createCallbackFcn(app, @PlotGlevelsButtonPushed, true);
            app.PlotGlevelsButton.FontWeight = 'bold';
            app.PlotGlevelsButton.Position = [122 92 100 23];
            app.PlotGlevelsButton.Text = 'Plot Glevels';

            % Create PlotPSDButton
            app.PlotPSDButton = uibutton(app.UseifvelocitiesarefromaccelerationanddecelerationPanel, 'push');
            app.PlotPSDButton.ButtonPushedFcn = createCallbackFcn(app, @PlotPSDButtonPushed, true);
            app.PlotPSDButton.FontWeight = 'bold';
            app.PlotPSDButton.Position = [122 39 100 23];
            app.PlotPSDButton.Text = 'Plot PSD';

            % Create InputParametersPanel
            app.InputParametersPanel = uipanel(app.UIFigure);
            app.InputParametersPanel.BorderType = 'none';
            app.InputParametersPanel.BorderWidth = 2;
            app.InputParametersPanel.Title = 'Input Parameters';
            app.InputParametersPanel.FontWeight = 'bold';
            app.InputParametersPanel.Position = [24 255 274 99];

            % Create TimeButton
            app.TimeButton = uibutton(app.InputParametersPanel, 'push');
            app.TimeButton.ButtonPushedFcn = createCallbackFcn(app, @TimeButtonPushed, true);
            app.TimeButton.FontWeight = 'bold';
            app.TimeButton.Position = [14 39 100 23];
            app.TimeButton.Text = 'Time';

            % Create VelocityButton
            app.VelocityButton = uibutton(app.InputParametersPanel, 'push');
            app.VelocityButton.ButtonPushedFcn = createCallbackFcn(app, @VelocityButtonPushed, true);
            app.VelocityButton.FontWeight = 'bold';
            app.VelocityButton.Position = [139 39 100 23];
            app.VelocityButton.Text = 'Velocity';

            % Create ExportGraphicsButton
            app.ExportGraphicsButton = uibutton(app.UIFigure, 'push');
            app.ExportGraphicsButton.ButtonPushedFcn = createCallbackFcn(app, @ExportGraphicsButtonPushed, true);
            app.ExportGraphicsButton.FontWeight = 'bold';
            app.ExportGraphicsButton.Position = [763 68 151 27];
            app.ExportGraphicsButton.Text = 'ExportGraphics';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = mainapp_exported

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.UIFigure)

                % Execute the startup function
                runStartupFcn(app, @startupFcn)
            else

                % Focus the running singleton app
                figure(runningApp.UIFigure)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end