function varargout = show_data(varargin)

% SHOW_DATA MATLAB code for show_data.fig
%      SHOW_DATA, by itself, creates a new SHOW_DATA or raises the existing
%      singleton*.
%
%      H = SHOW_DATA returns the handle to a new SHOW_DATA or the handle to
%      the existing singleton*.
%
%      SHOW_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOW_DATA.M with the given input arguments.
%
%      SHOW_DATA('Property','Value',...) creates a new SHOW_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before show_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to show_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help show_data

% Last Modified by GUIDE v2.5 28-Apr-2019 17:21:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @show_data_OpeningFcn, ...
    'gui_OutputFcn',  @show_data_OutputFcn, ...
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

% --- Executes just before show_data is made visible.
function show_data_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for show_data
handles.output = hObject;

setappdata(0, 'segmentList', []);

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = show_data_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in electrode.
function electrode_Callback(hObject, eventdata, handles)
% hObject    handle to electrode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function electrode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to electrode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function threshold_Callback(hObject, eventdata, handles)
threshold_val = get(hObject, 'Value');
set(handles.threshold_edit, 'string', num2str(threshold_val));
present_data(handles)
guidata(hObject, handles);

function threshold_edit_Callback(hObject, eventdata, handles)
edited_val = get(hObject,'string');
set(handles.threshold,'value',str2num(edited_val));
present_data(handles)
guidata(hObject,handles);

function upper_bound_Callback(hObject, eventdata, handles)
bound_val = get(hObject,'string');
set(handles.upper_bound_slider,'value',str2num(bound_val));
handles.dataNeuron.upper_bound = get(handles.upper_bound_slider,'value');
guidata(hObject,handles);

function segment_length_Callback(hObject, eventdata, handles)
segLength_val = get(hObject,'string');
handles.dataNeuron.segment_length = segLength_val;
seg = find(mod(handles.dataNeuron.time, str2num(segLength_val))==0)';
if seg(end) ~= handles.dataNeuron.ad.FragCounts-1
    seg = [seg; handles.dataNeuron.ad.FragCounts-1];
end
set(handles.Segment_menu,'String', 'Segment');
set(handles.segRadioButton,'Value', 0);
handles.dataNeuron.segment = seg;
seg_val = set(handles.Segment_menu,'Value', 1);
handles.dataNeuron.currenSegment = [seg(seg_val), seg(seg_val+1)];
guidata(hObject,handles);

% --- Executes on slider movement.
function upper_bound_slider_Callback(hObject, eventdata, handles)
bound_val = get(hObject, 'Value');
set(handles.upper_bound, 'string', num2str(bound_val));
handles.dataNeuron.upper_bound = bound_val;
guidata(hObject, handles);

function threshold_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function data_shower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_shower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function file_name_Callback(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function file_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function file_directory_Callback(hObject, eventdata, handles)
% hObject    handle to file_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes during object creation, after setting all properties.

function file_directory_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function upper_bound_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function upper_bound_slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Segment_menu_Callback(hObject, eventdata, handles)
val = get(hObject, 'Value');
seg = handles.dataNeuron.segment;
handles.dataNeuron.currenSegment = [seg(val), seg(val+1)];
present_data(handles)
guidata(hObject, handles)

function segment_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to segment_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Segment_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Segment_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function segRadioButton_Callback(hObject, eventdata, handles)
val = get(hObject, 'Value');
if val==0
    set(handles.Segment_menu,'String', 'Segment')
    handles.dataNeuron.currenSegment = [1, handles.dataNeuron.ad.FragCounts];
else
    seg = handles.dataNeuron.segment;
    set(handles.Segment_menu,'String', {1:length(seg)-1});
    seg_val = get(handles.Segment_menu,'Value');
    handles.dataNeuron.currenSegment = [seg(seg_val), seg(seg_val+1)];
end
present_data(handles)
guidata(hObject, handles)
% Hint: get(hObject,'Value') returns toggle state of segRadioButton

function present_data(handles)
threshold = get(handles.threshold, 'Value');
if get(handles.segRadioButton, 'Value')==1
    seg_val = get(handles.Segment_menu, 'Value');
    seg = handles.dataNeuron.segment;
    data = handles.dataNeuron.ad.Values(seg(seg_val):seg(seg_val+1));
    lp_filtered = handles.dataNeuron.lp_filtered(seg(seg_val):seg(seg_val+1));
    time = handles.dataNeuron.time(seg(seg_val):seg(seg_val+1));
    xlabel('Time (Second)')
    axes(handles.data_shower)
    plot(time, data, 'k', time, ones(1,length(time))*threshold, 'b', time, lp_filtered, 'r');
else
    data = handles.dataNeuron.ad.Values;
    lp_filtered = handles.dataNeuron.lp_filtered;
    time = handles.dataNeuron.time;
    xlabel('Time (Second)')
    axes(handles.data_shower)
    plot(time, data, 'k', time, ones(1,length(time))*threshold, 'b', time, lp_filtered, 'r');
end

function loadFileButton_Callback(hObject, eventdata, handles)
% rerefrash variables
setappdata(0,'segment',[]);
setappdata(0,'electrode', []);
% --- low pass filter parameters
LOWPASS_ORDER = 2;                                  % Low pass filter
LOWPASS_UP = 0.02;                                  % Low pass filter
LOPPASS_DOWN = 0.001;

electrode = get(handles.electrode, 'Value');
threshold = get(handles.threshold, 'Value');
file = fullfile(get(handles.file_directory, 'String'),get(handles.file_name, 'String'));
% load the data
[ad] = PL2Ad(file,electrode);
% low filtereing the data
[b_lp a_lp] = butter(LOWPASS_ORDER, [LOPPASS_DOWN LOWPASS_UP],'bandpass');
% Select the data time specified in "startRecording" and "endRecording"
% butons.
if get(handles.startRecording,'Value') | get(handles.endRecording,'Value')
    if get(handles.startRecording,'Value') & get(handles.endRecording,'Value')
        time = [get(handles.startRecording,'Value')*ad.ADFreq:get(handles.endRecording,'Value')*ad.ADFreq];
        H_lp = freqz(b_lp, a_lp, floor(length(time)/2));
        lp_filtered = filtfilt(b_lp, a_lp, ad.Values(time));
    elseif get(handles.startRecording,'Value') & ~get(handles.endRecording,'Value')
        time = [get(handles.startRecording,'Value')*ad.ADFreq:ad.FragCounts-1];
        H_lp = freqz(b_lp, a_lp, floor(length(time)/2));
        lp_filtered = filtfilt(b_lp, a_lp, ad.Values(time));
    else ~get(handles.startRecording,'Value') & get(handles.endRecording,'Value')
        time = [0:ad.get(handles.endRecording,'Value')*ad.ADFreq-1];
        H_lp = freqz(b_lp, a_lp, floor(length(time)/2));
        lp_filtered = filtfilt(b_lp, a_lp, ad.Values(time));
    end
    % Notice -> the following code cut and update the ad struct (!)
    handles.dataNeuron.startRecording = get(handles.startRecording,'Value') * ad.ADFreq;
    handles.dataNeuron.tempTimeValues = ad.Values;
    ad.Values = ad.Values(time); ad.FragCounts = length(time);
    time = (time - handles.dataNeuron.startRecording)/ad.ADFreq;
else
    time = [0:ad.FragCounts-1]/ad.ADFreq;
    H_lp = freqz(b_lp, a_lp, floor(ad.FragCounts/2));
    lp_filtered = filtfilt(b_lp, a_lp, ad.Values);
    handles.dataNeuron.startRecording = 0; 
end
% disable "Recording time" buttons  
set(handles.startRecording,'Enable', 'off')
set(handles.endRecording,'Enable', 'off')
% divide the data to segments
seg = find(mod(time,180)==0)';
if seg(end)~=ad.FragCounts-1
    seg = [seg; ad.FragCounts-1];
end
set(handles.Segment_menu,'String', 'Segment');
set(handles.segRadioButton,'Value', 0)
handles.dataNeuron.time = time;
handles.dataNeuron.segment = seg;
handles.dataNeuron.ad = ad;
handles.dataNeuron.lp_filtered = lp_filtered;
handles.dataNeuron.upper_bound = get(handles.upper_bound_slider,'value');
present_data(handles)
guidata(hObject, handles)

function analyze_pca_Callback(hObject, eventdata, handles)
handles.dataNeuron.threshold = get(handles.threshold, 'Value');
handles.dataNeuron.upper_bound = get(handles.upper_bound_slider,'Value');
dataNeuron = handles.dataNeuron;

setappdata(0,'segment',handles.Segment_menu.Value);
setappdata(0,'electrode',handles.electrode.String{handles.electrode.Value});

pca_presentation(dataNeuron)

% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
file = extractBetween(getappdata(0,'segmentList'),[handles.electrode.String{handles.electrode.Value},'_'],['_', handles.electrode.String{handles.electrode.Value}]);
if isempty(file)
    f = errordlg([handles.electrode.String{handles.electrode.Value}, ' not found'],'File Error')
else
    events = [];
    for seg = 1:length(file)
        events = [events; getappdata(0,[handles.electrode.String{handles.electrode.Value},'_', file{seg},'_', handles.electrode.String{handles.electrode.Value}])];
    end
    events = sort(events);
    [myfile,mypath] = uiputfile('*.mat');
    if ~unique(myfile==0) & ~unique(mypath==0)
        dataInfo.events = events;
        dataInfo.sampleRate = handles.dataNeuron.ad.ADFreq;
        save([mypath,myfile],'dataInfo');
    end
end

function open_file_CloseRequestFcn(hObject, eventdata, handles)
if ~isempty(getappdata(0,'segmentList'))
    file = extractBetween(getappdata(0,'segmentList'),'#','#');
    for f = 1:length(file)
        setappdata(0, file{f}, []);
    end
end
setappdata(0,'segment',[]);
setappdata(0,'electrode', []);
setappdata(0, 'segmentList', []);
delete(hObject);

% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
[file,path,indx] = uigetfile('*.pl2');
if isequal(file,0)
    disp('User selected Cancel')
else
    set(handles.file_name,'string',fullfile(file))
    set(handles.file_directory,'string',fullfile(path))
end


function startRecording_Callback(hObject, eventdata, handles)
set(hObject,'Value', str2num(get(hObject, 'String')));
guidata(hObject,handles);

function startRecording_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function endRecording_Callback(hObject, eventdata, handles)
set(hObject,'Value', str2num(get(hObject, 'String')));
guidata(hObject,handles);

function endRecording_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
