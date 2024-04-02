classdef time < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        OKButton                     matlab.ui.control.Button
        TimeParameterLabel           matlab.ui.control.Label
        UppervalueoftEditField       matlab.ui.control.NumericEditField
        UppervalueoftEditFieldLabel  matlab.ui.control.Label
        LowervalueoftEditField       matlab.ui.control.NumericEditField
        LowervalueoftEditFieldLabel  matlab.ui.control.Label
    end

    
    properties (Access = private)
        CallingApp % Description
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, caller, lowert, uppert)
            app.CallingApp=caller;
            app.LowervalueoftEditField.Value=lowert;
            app.UppervalueoftEditField.Value=uppert;
        end

        % Value changed function: UppervalueoftEditField
        function UppervalueoftEditFieldValueChanged(app, event)
            value = app.UppervalueoftEditField.Value;
            
        end

        % Value changed function: LowervalueoftEditField
        function LowervalueoftEditFieldValueChanged(app, event)
            value = app.LowervalueoftEditField.Value;
            
        end

        % Button pushed function: OKButton
        function OKButtonPushed(app, event)
            updatemaint(app.CallingApp,app.LowervalueoftEditField.Value,app.UppervalueoftEditField.Value)
            delete(app)
            %   assignin('base','lowert',app.LowervalueoftEditField)
            % assignin('base','uppert',app.UppervalueoftEditField)
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

            % Create LowervalueoftEditFieldLabel
            app.LowervalueoftEditFieldLabel = uilabel(app.UIFigure);
            app.LowervalueoftEditFieldLabel.HorizontalAlignment = 'right';
            app.LowervalueoftEditFieldLabel.Position = [157 359 93 22];
            app.LowervalueoftEditFieldLabel.Text = 'Lower value of t ';

            % Create LowervalueoftEditField
            app.LowervalueoftEditField = uieditfield(app.UIFigure, 'numeric');
            app.LowervalueoftEditField.ValueChangedFcn = createCallbackFcn(app, @LowervalueoftEditFieldValueChanged, true);
            app.LowervalueoftEditField.Position = [265 359 100 22];

            % Create UppervalueoftEditFieldLabel
            app.UppervalueoftEditFieldLabel = uilabel(app.UIFigure);
            app.UppervalueoftEditFieldLabel.HorizontalAlignment = 'right';
            app.UppervalueoftEditFieldLabel.Position = [160 319 90 22];
            app.UppervalueoftEditFieldLabel.Text = 'Upper value of t';

            % Create UppervalueoftEditField
            app.UppervalueoftEditField = uieditfield(app.UIFigure, 'numeric');
            app.UppervalueoftEditField.ValueChangedFcn = createCallbackFcn(app, @UppervalueoftEditFieldValueChanged, true);
            app.UppervalueoftEditField.Position = [265 319 100 22];

            % Create TimeParameterLabel
            app.TimeParameterLabel = uilabel(app.UIFigure);
            app.TimeParameterLabel.Position = [232 435 91 22];
            app.TimeParameterLabel.Text = 'Time Parameter';

            % Create OKButton
            app.OKButton = uibutton(app.UIFigure, 'push');
            app.OKButton.ButtonPushedFcn = createCallbackFcn(app, @OKButtonPushed, true);
            app.OKButton.Position = [265 258 100 23];
            app.OKButton.Text = 'OK';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = time(varargin)

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