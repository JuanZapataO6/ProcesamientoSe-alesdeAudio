classdef Procesamiento_Audio_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        TabGroup                    matlab.ui.container.TabGroup
        Seal01Tab                   matlab.ui.container.Tab
        SealButtonGroup             matlab.ui.container.ButtonGroup
        MonoButton                  matlab.ui.control.RadioButton
        StereoButton                matlab.ui.control.RadioButton
        PlayButton                  matlab.ui.control.Button
        PausaButton                 matlab.ui.control.Button
        Spinner                     matlab.ui.control.Spinner
        SEAL01Label                 matlab.ui.control.Label
        AmplitudKnob                matlab.ui.control.Knob
        InvertirButton_2            matlab.ui.control.Button
        TipodeentradaButtonGroup    matlab.ui.container.ButtonGroup
        CargarButton                matlab.ui.control.ToggleButton
        GrabarButton_3              matlab.ui.control.ToggleButton
        ChirpButton                 matlab.ui.control.ToggleButton
        GrabarLampLabel             matlab.ui.control.Label
        GrabarLamp                  matlab.ui.control.Lamp
        AmplitudLabel               matlab.ui.control.Label
        UIAxes2                     matlab.ui.control.UIAxes
        UIAxes2_2                   matlab.ui.control.UIAxes
        Seal02Tab                   matlab.ui.container.Tab
        SealButtonGroup_2           matlab.ui.container.ButtonGroup
        MonoButton_2                matlab.ui.control.RadioButton
        StereoButton_2              matlab.ui.control.RadioButton
        PlayButton_2                matlab.ui.control.Button
        PausaButton_2               matlab.ui.control.Button
        Spinner_2                   matlab.ui.control.Spinner
        SEAL02Label                 matlab.ui.control.Label
        AmplitudKnob_2              matlab.ui.control.Knob
        InvertirButton_3            matlab.ui.control.Button
        TipodeentradaButtonGroup_2  matlab.ui.container.ButtonGroup
        CargarButton_2              matlab.ui.control.ToggleButton
        GrabarButton_4              matlab.ui.control.ToggleButton
        ChirpButton_2               matlab.ui.control.ToggleButton
        AmplitudLabel_2             matlab.ui.control.Label
        UIAxes2_3                   matlab.ui.control.UIAxes
        UIAxes2_4                   matlab.ui.control.UIAxes
        GrabarLamp_2Label           matlab.ui.control.Label
        GrabarLamp_2                matlab.ui.control.Lamp
        OperacionesTab              matlab.ui.container.Tab
        OperacinDropDownLabel       matlab.ui.control.Label
        OperacinDropDown            matlab.ui.control.DropDown
        UIAxes2_5                   matlab.ui.control.UIAxes
    end

    
    properties (Access = public)
        Data_audio;
        reproductor;
        amplitud;
        selectedButton_Mono;
        fs;% Description
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            app.reproductor = audioplayer(app.Data_audio,app.fs);
            play(app.reproductor);
            
%             stop(reproductor)
        end

        % Selection changed function: TipodeentradaButtonGroup
        function TipodeentradaButtonGroupSelectionChanged(app, event)
            selectedButton = app.TipodeentradaButtonGroup.SelectedObject
            
            
%             Valor=app.TipodeentradaButtonGroup.Value;
            switch selectedButton.Text
                
                case 'Cargar'
                    %Entrada de Voz y música
                    clear app.Data_audio
                    [archivo,ruta]=uigetfile('*.mp3','Cargar Audio-MP3');                                        
                    if archivo==0
                     return;
                    else
                     Dir_archivo=strcat(ruta,archivo);
                    
                    A = importdata(Dir_archivo);
                    
                    [Data_audio, fs]=audioread(Dir_archivo);
                    app.Data_audio= Data_audio
                    app.fs=fs
                    audioinfo(Dir_archivo);
                    
                    end
%                     if app.selectedButton_Mono=='Stereo' 
%                         
%                         plot(app.UIAxes2,Data_audio(:,1));
%                         plot(app.UIAxes2_2,Data_audio(:,2))
%                     else  
%                         plot(app.UIAxes2,Data_audio(:,1));
%                     end
%                     plot(app.UIAxes2,Data_audio(:,1));
%                     plot(app.UIAxes2_2,Data_audio(:,2))
%                     reproductor = audioplayer(a,fs);
%                     play(reproductor);
%                     pause(10)
%                     stop(reproductor)
                    % importdata()
                    %plot(app.UIAxes,a(:,1))
                    %plot(a(:,2))    
                case 'Grabar'
                    %grabar= audiorecorder(8000,8,1,0);
                    clear app.Data_audio
                    text_Caja={ 'Segundos grabación:',};
                    title_caja='Grabación';
                    num_lines = 1;
                    defaultans = {'2'};
                    caja =inputdlg(text_Caja,title_caja,num_lines,defaultans);
                    T_record=str2num(caja{1});
                    fs=44100
                    app.fs=fs
                    grabar= audiorecorder(fs,8,2)
                    recordblocking(grabar,T_record)              
                    
                    
                    
                    
                    Data_audio = getaudiodata(grabar,"uint8")
                    app.Data_audio = Data_audio
                    
                    plot(app.UIAxes2,Data_audio(:,1));
                    plot(app.UIAxes2_2,Data_audio(:,2))
%                     reproductor_01 = audioplayer(Data_audio,8000,8);
%                     play(reproductor_01);
%                     disp('Sali putoo');
                    
                case 'Chirp'
                     Parameters = {'InitialFrequency:',...
                    'TargetFrequency:', ...
                    'TargetTime:', ...
                    'SweepTime:', ...
                    'SampleRate:', ...
                    'SamplesPerFrame:'
                    };
                    dlgtitle = 'Input';
                    dims = [1 35];
                    definput = {'0','5','10','50','20','100'};
                    answer=definput;
                    answer = inputdlg(Parameters,dlgtitle,dims,definput);
%                     if app.flagChirp == 'True'
%                         answer = inputdlg(Parameters,dlgtitle,dims,definput);
%                         app.flagChirp='False';
%                     end
                    
                    InitFreq=str2num(answer{1});
                    TargetFreq=str2num(answer{2});
                    TargetTime=str2num(answer{3});
                    SweepTime=str2num(answer{4});
                    SampleRate=str2num(answer{5});
                    SamplesPerFrame=str2num(answer{6});
%                     Amplitude=str2num(answer{7});
%                     Amplitude=str2num(app.amplitud);
                      hchirp = dsp.Chirp( ...
                        'InitialFrequency',InitFreq,...
                        'TargetFrequency',TargetFreq, ...
                        'TargetTime',TargetTime, ...
                        'SweepTime', SweepTime, ...
                        'SampleRate',SampleRate, ...
                        'SamplesPerFrame',SamplesPerFrame);
                    
%                     chirp = Amplitude*(step(hchirp))';
%                     Amplitude
                    chirp = app.amplitud*(step(hchirp))';
                    app.Data_audio = chirp
%                     app.chirpData =circshift(app.chirpData,Shift);
                   stem(app.UIAxes2_2,chirp);
                   plot(app.UIAxes2,chirp);
                    
                    
            end
        end

        % Button pushed function: PausaButton
        function PausaButtonPushed(app, event)
            stop(app.reproductor)
        end

        % Button pushed function: InvertirButton_2
        function InvertirButton_2Pushed(app, event)
            B1 = flip(app.Data_audio(:,1));
            B2 = flip(app.Data_audio(:,2));
            B =[B1,B2];
            app.reproductor = audioplayer(B,app.fs);
            play(app.reproductor);
        end

        % Value changed function: AmplitudKnob
        function AmplitudKnobValueChanged(app, event)
            value_amplitud= app.AmplitudKnob.Value;
            
            app.amplitud = value_amplitud;
            
            app.AmplitudeEditField.Value=app.AmplitudeSelect.Value;
            Amplitude=app.AmplitudeSelect.Value;
            
        end

        % Value changed function: Spinner
        function SpinnerValueChanged(app, event)
            value_amplitud = app.Spinner.Value;
            app.amplitud = value_amplitud;
        end

        % Selection changed function: SealButtonGroup
        function SealButtonGroupSelectionChanged(app, event)
            selectedButton = app.SealButtonGroup.SelectedObject;
            app.selectedButton_Mono = selectedButton.Text
              if app.selectedButton_Mono =='Stereo' 
                    app.Data_audio;
                    plot(app.UIAxes2,app.Data_audio(:,1));
                    plot(app.UIAxes2_2,app.Data_audio(:,2))
              elseif app.selectedButton_Mono=='Mono'
                    app.Data_audio;
                    plot(app.UIAxes2,app.Data_audio(:,1));
              end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1176 777];
            app.UIFigure.Name = 'UI Figure';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [31 28 1120 720];

            % Create Seal01Tab
            app.Seal01Tab = uitab(app.TabGroup);
            app.Seal01Tab.Title = 'Señal 01';

            % Create SealButtonGroup
            app.SealButtonGroup = uibuttongroup(app.Seal01Tab);
            app.SealButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @SealButtonGroupSelectionChanged, true);
            app.SealButtonGroup.Title = 'Señal';
            app.SealButtonGroup.Position = [80 405 100 70];

            % Create MonoButton
            app.MonoButton = uiradiobutton(app.SealButtonGroup);
            app.MonoButton.Text = 'Mono';
            app.MonoButton.Position = [11 24 58 22];
            app.MonoButton.Value = true;

            % Create StereoButton
            app.StereoButton = uiradiobutton(app.SealButtonGroup);
            app.StereoButton.Text = 'Stereo';
            app.StereoButton.Position = [11 2 65 22];

            % Create PlayButton
            app.PlayButton = uibutton(app.Seal01Tab, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.Position = [106 149 100 22];
            app.PlayButton.Text = 'Play';

            % Create PausaButton
            app.PausaButton = uibutton(app.Seal01Tab, 'push');
            app.PausaButton.ButtonPushedFcn = createCallbackFcn(app, @PausaButtonPushed, true);
            app.PausaButton.Position = [106 101 100 22];
            app.PausaButton.Text = 'Pausa';

            % Create Spinner
            app.Spinner = uispinner(app.Seal01Tab);
            app.Spinner.ValueChangedFcn = createCallbackFcn(app, @SpinnerValueChanged, true);
            app.Spinner.FontWeight = 'bold';
            app.Spinner.Position = [97 246 109 29];

            % Create SEAL01Label
            app.SEAL01Label = uilabel(app.Seal01Tab);
            app.SEAL01Label.HorizontalAlignment = 'center';
            app.SEAL01Label.FontName = 'Arial Black';
            app.SEAL01Label.FontSize = 30;
            app.SEAL01Label.Position = [1 644 1118 51];
            app.SEAL01Label.Text = 'SEÑAL 01';

            % Create AmplitudKnob
            app.AmplitudKnob = uiknob(app.Seal01Tab, 'continuous');
            app.AmplitudKnob.ValueChangedFcn = createCallbackFcn(app, @AmplitudKnobValueChanged, true);
            app.AmplitudKnob.FontWeight = 'bold';
            app.AmplitudKnob.Position = [87 298 60 60];

            % Create InvertirButton_2
            app.InvertirButton_2 = uibutton(app.Seal01Tab, 'push');
            app.InvertirButton_2.ButtonPushedFcn = createCallbackFcn(app, @InvertirButton_2Pushed, true);
            app.InvertirButton_2.Position = [106 59 100 22];
            app.InvertirButton_2.Text = 'Invertir';

            % Create TipodeentradaButtonGroup
            app.TipodeentradaButtonGroup = uibuttongroup(app.Seal01Tab);
            app.TipodeentradaButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @TipodeentradaButtonGroupSelectionChanged, true);
            app.TipodeentradaButtonGroup.Title = 'Tipo de entrada';
            app.TipodeentradaButtonGroup.Position = [68 499 123 106];

            % Create CargarButton
            app.CargarButton = uitogglebutton(app.TipodeentradaButtonGroup);
            app.CargarButton.Text = 'Cargar';
            app.CargarButton.Position = [11 53 100 22];
            app.CargarButton.Value = true;

            % Create GrabarButton_3
            app.GrabarButton_3 = uitogglebutton(app.TipodeentradaButtonGroup);
            app.GrabarButton_3.Text = 'Grabar';
            app.GrabarButton_3.Position = [11 32 100 22];

            % Create ChirpButton
            app.ChirpButton = uitogglebutton(app.TipodeentradaButtonGroup);
            app.ChirpButton.Text = 'Chirp';
            app.ChirpButton.Position = [11 11 100 22];

            % Create GrabarLampLabel
            app.GrabarLampLabel = uilabel(app.Seal01Tab);
            app.GrabarLampLabel.HorizontalAlignment = 'right';
            app.GrabarLampLabel.Position = [10 122 43 22];
            app.GrabarLampLabel.Text = 'Grabar';

            % Create GrabarLamp
            app.GrabarLamp = uilamp(app.Seal01Tab);
            app.GrabarLamp.Position = [68 122 20 20];

            % Create AmplitudLabel
            app.AmplitudLabel = uilabel(app.Seal01Tab);
            app.AmplitudLabel.FontWeight = 'bold';
            app.AmplitudLabel.Position = [31 249 57 22];
            app.AmplitudLabel.Text = 'Amplitud';

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.Seal01Tab);
            title(app.UIAxes2, 'Señal 01 Canal Derecho')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            app.UIAxes2.Position = [269 348 835 280];

            % Create UIAxes2_2
            app.UIAxes2_2 = uiaxes(app.Seal01Tab);
            title(app.UIAxes2_2, 'Señal 01 Canal Izquierdo')
            xlabel(app.UIAxes2_2, 'X')
            ylabel(app.UIAxes2_2, 'Y')
            app.UIAxes2_2.Position = [269 35 835 280];

            % Create Seal02Tab
            app.Seal02Tab = uitab(app.TabGroup);
            app.Seal02Tab.Title = 'Señal 02';

            % Create SealButtonGroup_2
            app.SealButtonGroup_2 = uibuttongroup(app.Seal02Tab);
            app.SealButtonGroup_2.Title = 'Señal';
            app.SealButtonGroup_2.Position = [80 405 100 70];

            % Create MonoButton_2
            app.MonoButton_2 = uiradiobutton(app.SealButtonGroup_2);
            app.MonoButton_2.Text = 'Mono';
            app.MonoButton_2.Position = [11 24 58 22];
            app.MonoButton_2.Value = true;

            % Create StereoButton_2
            app.StereoButton_2 = uiradiobutton(app.SealButtonGroup_2);
            app.StereoButton_2.Text = 'Stereo';
            app.StereoButton_2.Position = [11 2 65 22];

            % Create PlayButton_2
            app.PlayButton_2 = uibutton(app.Seal02Tab, 'push');
            app.PlayButton_2.Position = [106 149 100 22];
            app.PlayButton_2.Text = 'Play';

            % Create PausaButton_2
            app.PausaButton_2 = uibutton(app.Seal02Tab, 'push');
            app.PausaButton_2.Position = [106 101 100 22];
            app.PausaButton_2.Text = 'Pausa';

            % Create Spinner_2
            app.Spinner_2 = uispinner(app.Seal02Tab);
            app.Spinner_2.FontWeight = 'bold';
            app.Spinner_2.Position = [97 246 109 29];

            % Create SEAL02Label
            app.SEAL02Label = uilabel(app.Seal02Tab);
            app.SEAL02Label.HorizontalAlignment = 'center';
            app.SEAL02Label.FontName = 'Arial Black';
            app.SEAL02Label.FontSize = 30;
            app.SEAL02Label.Position = [1 644 1118 51];
            app.SEAL02Label.Text = 'SEÑAL 02';

            % Create AmplitudKnob_2
            app.AmplitudKnob_2 = uiknob(app.Seal02Tab, 'continuous');
            app.AmplitudKnob_2.FontWeight = 'bold';
            app.AmplitudKnob_2.Position = [87 298 60 60];

            % Create InvertirButton_3
            app.InvertirButton_3 = uibutton(app.Seal02Tab, 'push');
            app.InvertirButton_3.Position = [106 59 100 22];
            app.InvertirButton_3.Text = 'Invertir';

            % Create TipodeentradaButtonGroup_2
            app.TipodeentradaButtonGroup_2 = uibuttongroup(app.Seal02Tab);
            app.TipodeentradaButtonGroup_2.Title = 'Tipo de entrada';
            app.TipodeentradaButtonGroup_2.Position = [68 499 123 106];

            % Create CargarButton_2
            app.CargarButton_2 = uitogglebutton(app.TipodeentradaButtonGroup_2);
            app.CargarButton_2.Text = 'Cargar';
            app.CargarButton_2.Position = [11 53 100 22];
            app.CargarButton_2.Value = true;

            % Create GrabarButton_4
            app.GrabarButton_4 = uitogglebutton(app.TipodeentradaButtonGroup_2);
            app.GrabarButton_4.Text = 'Grabar';
            app.GrabarButton_4.Position = [11 32 100 22];

            % Create ChirpButton_2
            app.ChirpButton_2 = uitogglebutton(app.TipodeentradaButtonGroup_2);
            app.ChirpButton_2.Text = 'Chirp';
            app.ChirpButton_2.Position = [11 11 100 22];

            % Create AmplitudLabel_2
            app.AmplitudLabel_2 = uilabel(app.Seal02Tab);
            app.AmplitudLabel_2.FontWeight = 'bold';
            app.AmplitudLabel_2.Position = [35 249 57 22];
            app.AmplitudLabel_2.Text = 'Amplitud';

            % Create UIAxes2_3
            app.UIAxes2_3 = uiaxes(app.Seal02Tab);
            title(app.UIAxes2_3, 'Señal 01 Canal Derecho')
            xlabel(app.UIAxes2_3, 'X')
            ylabel(app.UIAxes2_3, 'Y')
            app.UIAxes2_3.Position = [269 348 835 280];

            % Create UIAxes2_4
            app.UIAxes2_4 = uiaxes(app.Seal02Tab);
            title(app.UIAxes2_4, 'Señal 01 Canal Izquierdo')
            xlabel(app.UIAxes2_4, 'X')
            ylabel(app.UIAxes2_4, 'Y')
            app.UIAxes2_4.Position = [269 35 835 280];

            % Create GrabarLamp_2Label
            app.GrabarLamp_2Label = uilabel(app.Seal02Tab);
            app.GrabarLamp_2Label.HorizontalAlignment = 'right';
            app.GrabarLamp_2Label.Position = [10 122 43 22];
            app.GrabarLamp_2Label.Text = 'Grabar';

            % Create GrabarLamp_2
            app.GrabarLamp_2 = uilamp(app.Seal02Tab);
            app.GrabarLamp_2.Position = [68 122 20 20];

            % Create OperacionesTab
            app.OperacionesTab = uitab(app.TabGroup);
            app.OperacionesTab.Title = 'Operaciones';

            % Create OperacinDropDownLabel
            app.OperacinDropDownLabel = uilabel(app.OperacionesTab);
            app.OperacinDropDownLabel.HorizontalAlignment = 'right';
            app.OperacinDropDownLabel.Position = [472 630 61 22];
            app.OperacinDropDownLabel.Text = 'Operación';

            % Create OperacinDropDown
            app.OperacinDropDown = uidropdown(app.OperacionesTab);
            app.OperacinDropDown.Items = {'FIR (Convolucion)', 'IIR(Ecuación diferencia)', 'Suma', 'Multiplicación', ''};
            app.OperacinDropDown.Position = [548 630 100 22];
            app.OperacinDropDown.Value = 'Suma';

            % Create UIAxes2_5
            app.UIAxes2_5 = uiaxes(app.OperacionesTab);
            title(app.UIAxes2_5, 'Señal 01 Canal')
            xlabel(app.UIAxes2_5, 'X')
            ylabel(app.UIAxes2_5, 'Y')
            app.UIAxes2_5.Position = [1 1 1118 594];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Procesamiento_Audio_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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