function varargout = manual_clasification(varargin)
% MANUAL_CLASIFICATION MATLAB code for manual_clasification.fig
%      MANUAL_CLASIFICATION, by itself, creates a new MANUAL_CLASIFICATION or raises the existing
%      singleton*.
%
%      H = MANUAL_CLASIFICATION returns the handle to a new MANUAL_CLASIFICATION or the handle to
%      the existing singleton*.
%
%      MANUAL_CLASIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANUAL_CLASIFICATION.M with the given input arguments.
%
%      MANUAL_CLASIFICATION('Property','Value',...) creates a new MANUAL_CLASIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before manual_clasification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to manual_clasification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help manual_clasification

% Last Modified by GUIDE v2.5 19-Feb-2019 16:21:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @manual_clasification_OpeningFcn, ...
                   'gui_OutputFcn',  @manual_clasification_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before manual_clasification is made visible.
function manual_clasification_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
handles.dataNeuron = varargin{1};
handles.data = varargin{1};

handles.manualClasification.spikes_for_check = find(handles.data.data.in_boundaries);
handles.manualClasification.spikeNum = 1;
set(handles.eventNum, 'string', [num2str(handles.manualClasification.spikeNum) , '/' , num2str(length(handles.manualClasification.spikes_for_check))])
handles.manualClasification.ns = {'Not classified',' Classified as noise', 'Classified as signal'};
handles.manualClasification.classified = ones(size(handles.manualClasification.spikes_for_check));
 set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
plotEvent(handles)
        
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = manual_clasification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function plotEvent(handles)


BEFORE_SPIKES_CHECKING_LONG = 20000;
BEFORE_SPIKES_CHECKING = 2000;
AFTER_SPIKES_CHECKING_LONG = 20000;
AFTER_SPIKES_CHECKING = 2000;

        if handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), 1) - BEFORE_SPIKES_CHECKING_LONG < 1
            BEFORE_SPIKES_CHECKING_LONG = 1;
            if handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), 1) - BEFORE_SPIKES_CHECKING  < 1
                BEFORE_SPIKES_CHECKING = 1;
            end
        end
        
        if  handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), end) + AFTER_SPIKES_CHECKING_LONG > length(handles.data.data.hp_filtered)
            AFTER_SPIKES_CHECKING_LONG = length(handles.data.data.hp_filtered) - handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), end);
            if handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), end) + AFTER_SPIKES_CHECKING > length(handles.data.data.hp_filtered)
                AFTER_SPIKES_CHECKING = length(handles.data.data.hp_filtered) - handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), end);
            end
        end
cla(handles.composedData)
       axes(handles.composedData)
        plot(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), 1)' -...
            BEFORE_SPIKES_CHECKING:handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), end)' + AFTER_SPIKES_CHECKING,...
            handles.data.data.display_filtered(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), 1)'-...
            BEFORE_SPIKES_CHECKING:handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), end)' + AFTER_SPIKES_CHECKING));  hold on
         plot(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum),:)',...
            handles.data.data.display_filtered(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), :)'), 'k');  
cla(handles.lowData)       
        axes(handles.lowData)
        plot(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), 1)' -...
            BEFORE_SPIKES_CHECKING:handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), end)' + AFTER_SPIKES_CHECKING,...
            handles.data.data.lp_filtered(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), 1)' -...
            BEFORE_SPIKES_CHECKING:handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), end)'+AFTER_SPIKES_CHECKING)); hold on
        plot(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum),:)',...
            handles.data.data.lp_filtered(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), :)'), 'k');
cla(handles.highData)               
        axes(handles.highData)
        plot(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), 1)' -...
            BEFORE_SPIKES_CHECKING:handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), end)' + AFTER_SPIKES_CHECKING,...
            handles.data.data.hp_filtered(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), 1)' -...
            BEFORE_SPIKES_CHECKING:handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), end)'+AFTER_SPIKES_CHECKING)); hold on
        plot(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum),:)',...
            handles.data.data.hp_filtered(handles.data.data.lowPassIndices(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum), :)'), 'k');
        
         


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
   % determine the key that was pressed 
     keyPressed = eventdata.Key;
    if strcmpi(keyPressed,'rightarrow')
%       % set focus to the button
%       uicontrol(handles.signalToolBar);
     % call the callback
     signalToolBar_ClickedCallback(handles.signalToolBar,[],handles);
    end
    if strcmpi(keyPressed,'leftarrow')
%       % set focus to the button
%       uicontrol(handles.leftarrow);
     % call the callback
     noiseToolBar_ClickedCallback(handles.noiseToolBar,[],handles);
    end
   
           

% % --- Executes on button press in leftarrow.
% function leftarrow_Callback(hObject, eventdata, handles)
% if handles.manualClasification.spikeNum > length(handles.manualClasification.spikes_for_check)
%     
% else
%     handles.data.data.in_boundaries(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum)) = 0;
%     handles.manualClasification.classified(handles.manualClasification.spikeNum) = 2;
%      set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
%     if handles.manualClasification.spikeNum < length(handles.manualClasification.spikes_for_check)
%         handles.manualClasification.spikeNum = handles.manualClasification.spikeNum + 1;
%         set(handles.eventNum, 'string', [num2str(handles.manualClasification.spikeNum) , '/' , num2str(length(handles.manualClasification.spikes_for_check))])
%         set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
%     end
%     if handles.manualClasification.spikeNum <= length(handles.manualClasification.spikes_for_check)
%         plotEvent(handles)
%     end
% end
%  guidata(hObject, handles);
% 
% 
% % --- Executes on button press in rightarrow.
% function rightarrow_Callback(hObject, eventdata, handles)
% if handles.manualClasification.spikeNum > length(handles.manualClasification.spikes_for_check)
%     
% else
%     handles.data.data.in_boundaries(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum)) = 1;
%     handles.manualClasification.classified(handles.manualClasification.spikeNum) = 3;
%     set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
%     if handles.manualClasification.spikeNum < length(handles.manualClasification.spikes_for_check)
%         handles.manualClasification.spikeNum = handles.manualClasification.spikeNum + 1;
%         set(handles.eventNum, 'string', [num2str(handles.manualClasification.spikeNum) , '/' , num2str(length(handles.manualClasification.spikes_for_check))])
%         set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
%     end
%     if handles.manualClasification.spikeNum <= length(handles.manualClasification.spikes_for_check)
%         plotEvent(handles)
%     end
% end
%  guidata(hObject, handles);
% 
% 
% % --- Executes on button press in back.
% function back_Callback(hObject, eventdata, handles)
% if handles.manualClasification.spikeNum > 1
%     handles.manualClasification.spikeNum = handles.manualClasification.spikeNum - 1;
%     set(handles.eventNum, 'string', [num2str(handles.manualClasification.spikeNum) , '/' , num2str(length(handles.manualClasification.spikes_for_check))])
%     set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
%     plotEvent(handles)
% end
% guidata(hObject, handles);
% 
% 
% % --- Executes on button press in next.
% function next_Callback(hObject, eventdata, handles)
% if handles.manualClasification.spikeNum < length(handles.manualClasification.spikes_for_check)
%     handles.manualClasification.spikeNum = handles.manualClasification.spikeNum + 1;
%     set(handles.eventNum, 'string', [num2str(handles.manualClasification.spikeNum) , '/' , num2str(length(handles.manualClasification.spikes_for_check))])
%     set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
%     plotEvent(handles)
% end
% guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function eventNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eventNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function classification_CreateFcn(hObject, eventdata, handles)
% hObject    handle to classification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in done.
% function done_Callback(hObject, eventdata, handles)
% % - update vector in
% in = getappdata(0,'in');
% in(handles.manualClasification.spikes_for_check) = handles.data.data.in_boundaries(handles.manualClasification.spikes_for_check);
% setappdata(0,'in',in);
% % ---
% 
 


% --------------------------------------------------------------------
function backToolBar_ClickedCallback(hObject, eventdata, handles)
if handles.manualClasification.spikeNum > 1
    handles.manualClasification.spikeNum = handles.manualClasification.spikeNum - 1;
    set(handles.eventNum, 'string', [num2str(handles.manualClasification.spikeNum) , '/' , num2str(length(handles.manualClasification.spikes_for_check))])
    set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
    plotEvent(handles)
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function nextToolBar_ClickedCallback(hObject, eventdata, handles)
if handles.manualClasification.spikeNum < length(handles.manualClasification.spikes_for_check)
    handles.manualClasification.spikeNum = handles.manualClasification.spikeNum + 1;
    set(handles.eventNum, 'string', [num2str(handles.manualClasification.spikeNum) , '/' , num2str(length(handles.manualClasification.spikes_for_check))])
    set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
    plotEvent(handles)
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function noiseToolBar_ClickedCallback(hObject, eventdata, handles)
if handles.manualClasification.spikeNum > length(handles.manualClasification.spikes_for_check)
    
else
    handles.data.data.in_boundaries(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum)) = 0;
    handles.manualClasification.classified(handles.manualClasification.spikeNum) = 2;
     set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
    if handles.manualClasification.spikeNum < length(handles.manualClasification.spikes_for_check)
        handles.manualClasification.spikeNum = handles.manualClasification.spikeNum + 1;
        set(handles.eventNum, 'string', [num2str(handles.manualClasification.spikeNum) , '/' , num2str(length(handles.manualClasification.spikes_for_check))])
        set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
    end
    if handles.manualClasification.spikeNum <= length(handles.manualClasification.spikes_for_check)
        plotEvent(handles)
    end
end
 guidata(hObject, handles);


% --------------------------------------------------------------------
function signalToolBar_ClickedCallback(hObject, eventdata, handles)
if handles.manualClasification.spikeNum > length(handles.manualClasification.spikes_for_check)
    
else
    handles.data.data.in_boundaries(handles.manualClasification.spikes_for_check(handles.manualClasification.spikeNum)) = 1;
    handles.manualClasification.classified(handles.manualClasification.spikeNum) = 3;
    set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
    if handles.manualClasification.spikeNum < length(handles.manualClasification.spikes_for_check)
        handles.manualClasification.spikeNum = handles.manualClasification.spikeNum + 1;
        set(handles.eventNum, 'string', [num2str(handles.manualClasification.spikeNum) , '/' , num2str(length(handles.manualClasification.spikes_for_check))])
        set(handles.classification, 'string', [handles.manualClasification.ns{handles.manualClasification.classified(handles.manualClasification.spikeNum)}])
    end
    if handles.manualClasification.spikeNum <= length(handles.manualClasification.spikes_for_check)
        plotEvent(handles)
    end
end
 guidata(hObject, handles);


% --------------------------------------------------------------------
function saveClassificationToolBar_ClickedCallback(hObject, eventdata, handles)
% - update vector in
in = getappdata(0,'in');
in(handles.manualClasification.spikes_for_check) = handles.data.data.in_boundaries(handles.manualClasification.spikes_for_check);
setappdata(0,'in',in);
