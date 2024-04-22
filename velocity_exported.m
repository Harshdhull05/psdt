classdef velocity_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        OKButton                     matlab.ui.control.Button
        VelocityParameterLabel       matlab.ui.control.Label
        UppervalueofvEditField       matlab.ui.control.NumericEditField
        UppervalueofvEditFieldLabel  matlab.ui.control.Label
        LowervalueofvEditField       matlab.ui.control.NumericEditField
        LowervalueofvEditFieldLabel  matlab.ui.control.Label
    end

    
    properties (Access = private)
        CallingApp % Description
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, caller, lowerv, upperv)
            app.CallingApp=caller;
            app.LowervalueofvEditField.Value=lowerv;
            app.UppervalueofvEditField.Value=upperv;
        end

        % Value changed function: LowervalueofvEditField
        function LowervalueofvEditFieldValueChanged(app, event)
            value = app.LowervalueofvEditField.Value;
            
        end

        % Value changed function: UppervalueofvEditField
        function UppervalueofvEditFieldValueChanged(app, event)
            value = app.UppervalueofvEditField.Value;
            
        end

        % Button pushed function: OKButton
        function OKButtonPushed(app, event)
            updatemainv(app.CallingApp,app.LowervalueofvEditField.Value,app.UppervalueofvEditField.Value)
            delete(app)
            % assignin('base','lowerv',app.LowervalueofvEditField)
            % assignin('base','upperv',app.UppervalueofvEditField)

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

            % Create LowervalueofvEditFieldLabel
            app.LowervalueofvEditFieldLabel = uilabel(app.UIFigure);
            app.LowervalueofvEditFieldLabel.HorizontalAlignment = 'right';
            app.LowervalueofvEditFieldLabel.FontWeight = 'bold';
            app.LowervalueofvEditFieldLabel.Position = [144 343 99 22];
            app.LowervalueofvEditFieldLabel.Text = 'Lower value of v';

            % Create LowervalueofvEditField
            app.LowervalueofvEditField = uieditfield(app.UIFigure, 'numeric');
            app.LowervalueofvEditField.ValueChangedFcn = createCallbackFcn(app, @LowervalueofvEditFieldValueChanged, true);
            app.LowervalueofvEditField.FontWeight = 'bold';
            app.LowervalueofvEditField.Position = [258 343 100 22];

            % Create UppervalueofvEditFieldLabel
            app.UppervalueofvEditFieldLabel = uilabel(app.UIFigure);
            app.UppervalueofvEditFieldLabel.HorizontalAlignment = 'right';
            app.UppervalueofvEditFieldLabel.FontWeight = 'bold';
            app.UppervalueofvEditFieldLabel.Position = [141 303 102 22];
            app.UppervalueofvEditFieldLabel.Text = 'Upper value of v ';

            % Create UppervalueofvEditField
            app.UppervalueofvEditField = uieditfield(app.UIFigure, 'numeric');
            app.UppervalueofvEditField.ValueChangedFcn = createCallbackFcn(app, @UppervalueofvEditFieldValueChanged, true);
            app.UppervalueofvEditField.FontWeight = 'bold';
            app.UppervalueofvEditField.Position = [258 303 100 22];

            % Create VelocityParameterLabel
            app.VelocityParameterLabel = uilabel(app.UIFigure);
            app.VelocityParameterLabel.FontWeight = 'bold';
            app.VelocityParameterLabel.Position = [242 417 112 22];
            app.VelocityParameterLabel.Text = 'Velocity Parameter';

            % Create OKButton
            app.OKButton = uibutton(app.UIFigure, 'push');
            app.OKButton.ButtonPushedFcn = createCallbackFcn(app, @OKButtonPushed, true);
            app.OKButton.FontWeight = 'bold';
            app.OKButton.Position = [258 229 100 23];
            app.OKButton.Text = 'OK';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = velocity_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

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