classdef mainapp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        PlotPSDvelocityButton          matlab.ui.control.Button
        PlotGlevelsvelocityButton      matlab.ui.control.Button
        filenameEditField_2            matlab.ui.control.EditField
        filenameEditField_2Label       matlab.ui.control.Label
        ImportvelocityfileButton       matlab.ui.control.Button
        PlotPSDtimeButton              matlab.ui.control.Button
        filenameEditField              matlab.ui.control.EditField
        filenameEditFieldLabel         matlab.ui.control.Label
        SensitivityofzEditField        matlab.ui.control.NumericEditField
        SensitivityofzEditFieldLabel   matlab.ui.control.Label
        SensitivityofyEditField        matlab.ui.control.NumericEditField
        SensitivityofyEditFieldLabel   matlab.ui.control.Label
        EntervalueofSamplingrateEditField  matlab.ui.control.NumericEditField
        EntervalueofSamplingrateLabel  matlab.ui.control.Label
        PlotGlevelstimeButton          matlab.ui.control.Button
        SensitivityofxEditField        matlab.ui.control.NumericEditField
        SensitivityofxEditFieldLabel   matlab.ui.control.Label
        VelocityButton                 matlab.ui.control.Button
        TimeButton                     matlab.ui.control.Button
        ImportsignalfileButton         matlab.ui.control.Button
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
              timedata=T.t((indexl):(indexu));
              voltagedatax=T.x((indexl):(indexu));
              voltagedatay=T.y((indexl):(indexu));
              voltagedataz=T.z((indexl):(indexu));
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
            voltagedatax=T.x((indexl):(indexu));
            voltagedatay=T.y((indexl):(indexu));
            voltagedataz=T.z((indexl):(indexu));
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
               rows=A.v==app.Currentlowerv;
               ilv=find(rows==1);
               
                rows=A.v==app.Currentupperv;
               iuv=find(rows==1);
               T=readtable(app.filenameEditField.Value);
               timedatav=T.t((ilv):(iuv));
               voltagedatavx=T.x((ilv):(iuv));
               voltagedatavy=T.y((ilv):(iuv));
               voltagedatavz=T.z((ilv):(iuv));
                 voltagedatavx=voltagedatavx./app.SensitivityofxEditField.Value;
                 voltagedatavy=voltagedatavy./app.SensitivityofyEditField.Value;
                voltagedatavz=voltagedatavz./app.SensitivityofzEditField.Value;
               plot(app.UIAxes,timedatav,10*log10(voltagedatavx))
               plot(app.UIAxes2,timedatav,10*log10(voltagedatavy))
               plot(app.UIAxes3,timedatav,10*log10(voltagedatavz))
           
        end

        % Button pushed function: PlotPSDvelocityButton
        function PlotPSDvelocityButtonPushed(app, event)
             A=readtable(app.filenameEditField_2.Value);
               rows=A.v==app.Currentlowerv;
               ilv=find(rows==1);
               
                rows=A.v==app.Currentupperv;
               iuv=find(rows==1);
               T=readtable(app.filenameEditField.Value);
               timedatav=T.t((ilv):(iuv));
               voltagedatavx=T.x((ilv):(iuv));
               voltagedatavy=T.y((ilv):(iuv));
               voltagedatavz=T.z((ilv):(iuv));
                 voltagedatavx=voltagedatavx./app.SensitivityofxEditField.Value;
                 voltagedatavy=voltagedatavy./app.SensitivityofyEditField.Value;
                voltagedatavz=voltagedatavz./app.SensitivityofzEditField.Value;
                  [pxx,f] = pwelch( voltagedatavx,20,0,20,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes4,f,10*log10(pxx))
            [pxx,f] = pwelch( voltagedatavy,20,0,20,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes5,f,10*log10(pxx))
            [pxx,f] = pwelch( voltagedatavz,20,0,20,app.EntervalueofSamplingrateEditField.Value);
            plot(app.UIAxes6,f,10*log10(pxx))
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Glevelx')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [183 332 145 133];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Glevely')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [327 332 150 133];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.UIFigure);
            title(app.UIAxes3, 'Glevelz')
            xlabel(app.UIAxes3, 'X')
            ylabel(app.UIAxes3, 'Y')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.Position = [476 326 156 139];

            % Create UIAxes4
            app.UIAxes4 = uiaxes(app.UIFigure);
            title(app.UIAxes4, 'PSDx')
            xlabel(app.UIAxes4, 'X')
            ylabel(app.UIAxes4, 'Y')
            zlabel(app.UIAxes4, 'Z')
            app.UIAxes4.Position = [183 197 145 137];

            % Create UIAxes5
            app.UIAxes5 = uiaxes(app.UIFigure);
            title(app.UIAxes5, 'PSDy')
            xlabel(app.UIAxes5, 'X')
            ylabel(app.UIAxes5, 'Y')
            zlabel(app.UIAxes5, 'Z')
            app.UIAxes5.Position = [327 197 150 137];

            % Create UIAxes6
            app.UIAxes6 = uiaxes(app.UIFigure);
            title(app.UIAxes6, 'PSDz')
            xlabel(app.UIAxes6, 'X')
            ylabel(app.UIAxes6, 'Y')
            zlabel(app.UIAxes6, 'Z')
            app.UIAxes6.Position = [476 197 156 136];

            % Create ImportsignalfileButton
            app.ImportsignalfileButton = uibutton(app.UIFigure, 'push');
            app.ImportsignalfileButton.ButtonPushedFcn = createCallbackFcn(app, @ImportsignalfileButtonPushed, true);
            app.ImportsignalfileButton.Position = [29 432 102 23];
            app.ImportsignalfileButton.Text = 'Import signal file';

            % Create TimeButton
            app.TimeButton = uibutton(app.UIFigure, 'push');
            app.TimeButton.ButtonPushedFcn = createCallbackFcn(app, @TimeButtonPushed, true);
            app.TimeButton.Position = [62 270 100 23];
            app.TimeButton.Text = 'Time';

            % Create VelocityButton
            app.VelocityButton = uibutton(app.UIFigure, 'push');
            app.VelocityButton.ButtonPushedFcn = createCallbackFcn(app, @VelocityButtonPushed, true);
            app.VelocityButton.Position = [62 239 100 23];
            app.VelocityButton.Text = 'Velocity';

            % Create SensitivityofxEditFieldLabel
            app.SensitivityofxEditFieldLabel = uilabel(app.UIFigure);
            app.SensitivityofxEditFieldLabel.HorizontalAlignment = 'right';
            app.SensitivityofxEditFieldLabel.Position = [1 205 82 22];
            app.SensitivityofxEditFieldLabel.Text = 'Sensitivity of x';

            % Create SensitivityofxEditField
            app.SensitivityofxEditField = uieditfield(app.UIFigure, 'numeric');
            app.SensitivityofxEditField.ValueChangedFcn = createCallbackFcn(app, @SensitivityofxEditFieldValueChanged, true);
            app.SensitivityofxEditField.Position = [98 205 100 22];

            % Create PlotGlevelstimeButton
            app.PlotGlevelstimeButton = uibutton(app.UIFigure, 'push');
            app.PlotGlevelstimeButton.ButtonPushedFcn = createCallbackFcn(app, @PlotGlevelstimeButtonPushed, true);
            app.PlotGlevelstimeButton.Position = [69 101 105 23];
            app.PlotGlevelstimeButton.Text = 'Plot Glevels time';

            % Create EntervalueofSamplingrateLabel
            app.EntervalueofSamplingrateLabel = uilabel(app.UIFigure);
            app.EntervalueofSamplingrateLabel.HorizontalAlignment = 'right';
            app.EntervalueofSamplingrateLabel.Position = [1 297 82 30];
            app.EntervalueofSamplingrateLabel.Text = {'Enter value of '; 'Sampling rate'};

            % Create EntervalueofSamplingrateEditField
            app.EntervalueofSamplingrateEditField = uieditfield(app.UIFigure, 'numeric');
            app.EntervalueofSamplingrateEditField.ValueChangedFcn = createCallbackFcn(app, @EntervalueofSamplingrateEditFieldValueChanged, true);
            app.EntervalueofSamplingrateEditField.Position = [98 305 100 22];

            % Create SensitivityofyEditFieldLabel
            app.SensitivityofyEditFieldLabel = uilabel(app.UIFigure);
            app.SensitivityofyEditFieldLabel.HorizontalAlignment = 'right';
            app.SensitivityofyEditFieldLabel.Position = [1 176 82 22];
            app.SensitivityofyEditFieldLabel.Text = 'Sensitivity of y';

            % Create SensitivityofyEditField
            app.SensitivityofyEditField = uieditfield(app.UIFigure, 'numeric');
            app.SensitivityofyEditField.ValueChangedFcn = createCallbackFcn(app, @SensitivityofyEditFieldValueChanged, true);
            app.SensitivityofyEditField.Position = [98 176 100 22];

            % Create SensitivityofzEditFieldLabel
            app.SensitivityofzEditFieldLabel = uilabel(app.UIFigure);
            app.SensitivityofzEditFieldLabel.HorizontalAlignment = 'right';
            app.SensitivityofzEditFieldLabel.Position = [1 138 82 22];
            app.SensitivityofzEditFieldLabel.Text = 'Sensitivity of z';

            % Create SensitivityofzEditField
            app.SensitivityofzEditField = uieditfield(app.UIFigure, 'numeric');
            app.SensitivityofzEditField.ValueChangedFcn = createCallbackFcn(app, @SensitivityofzEditFieldValueChanged, true);
            app.SensitivityofzEditField.Position = [98 138 100 22];

            % Create filenameEditFieldLabel
            app.filenameEditFieldLabel = uilabel(app.UIFigure);
            app.filenameEditFieldLabel.HorizontalAlignment = 'right';
            app.filenameEditFieldLabel.Position = [22 400 50 22];
            app.filenameEditFieldLabel.Text = 'filename';

            % Create filenameEditField
            app.filenameEditField = uieditfield(app.UIFigure, 'text');
            app.filenameEditField.ValueChangedFcn = createCallbackFcn(app, @filenameEditFieldValueChanged2, true);
            app.filenameEditField.Position = [87 400 100 22];

            % Create PlotPSDtimeButton
            app.PlotPSDtimeButton = uibutton(app.UIFigure, 'push');
            app.PlotPSDtimeButton.ButtonPushedFcn = createCallbackFcn(app, @PlotPSDtimeButtonPushed, true);
            app.PlotPSDtimeButton.Position = [71 64 100 23];
            app.PlotPSDtimeButton.Text = 'Plot PSD time';

            % Create ImportvelocityfileButton
            app.ImportvelocityfileButton = uibutton(app.UIFigure, 'push');
            app.ImportvelocityfileButton.ButtonPushedFcn = createCallbackFcn(app, @ImportvelocityfileButtonPushed, true);
            app.ImportvelocityfileButton.Position = [26 367 111 23];
            app.ImportvelocityfileButton.Text = 'Import velocity file';

            % Create filenameEditField_2Label
            app.filenameEditField_2Label = uilabel(app.UIFigure);
            app.filenameEditField_2Label.HorizontalAlignment = 'right';
            app.filenameEditField_2Label.Position = [22 342 50 22];
            app.filenameEditField_2Label.Text = 'filename';

            % Create filenameEditField_2
            app.filenameEditField_2 = uieditfield(app.UIFigure, 'text');
            app.filenameEditField_2.ValueChangedFcn = createCallbackFcn(app, @filenameEditField_2ValueChanged, true);
            app.filenameEditField_2.Position = [87 342 100 22];

            % Create PlotGlevelsvelocityButton
            app.PlotGlevelsvelocityButton = uibutton(app.UIFigure, 'push');
            app.PlotGlevelsvelocityButton.ButtonPushedFcn = createCallbackFcn(app, @PlotGlevelsvelocityButtonPushed, true);
            app.PlotGlevelsvelocityButton.Position = [195 100 122 23];
            app.PlotGlevelsvelocityButton.Text = 'Plot Glevels velocity';

            % Create PlotPSDvelocityButton
            app.PlotPSDvelocityButton = uibutton(app.UIFigure, 'push');
            app.PlotPSDvelocityButton.ButtonPushedFcn = createCallbackFcn(app, @PlotPSDvelocityButtonPushed, true);
            app.PlotPSDvelocityButton.Position = [203 64 107 23];
            app.PlotPSDvelocityButton.Text = 'Plot PSD velocity';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = mainapp

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