function varargout = raytracing(varargin)
% RAYTRACING MATLAB code file for raytracing.fig
%      RAYTRACING, by itself, creates a new RAYTRACING or raises the existing
%      singleton*.
%
%      H = RAYTRACING returns the handle to a new RAYTRACING or the handle to
%      the existing singleton*.
%
%      RAYTRACING('Property','Value',...) creates a new RAYTRACING using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to raytracing_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      RAYTRACING('CALLBACK') and RAYTRACING('CALLBACK',hObject,...) call the
%      local function named CALLBACK in RAYTRACING.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help raytracing_ui

% Last Modified by GUIDE v2.5 18-Jul-2018 20:08:26

% Begin initialization code - DO NOT EDIT
  gui_Singleton = 1;
  gui_State = struct('gui_Name',       mfilename, ...
                     'gui_Singleton',  gui_Singleton, ...
                     'gui_OpeningFcn', @raytracing_OpeningFcn, ...
                     'gui_OutputFcn',  @raytracing_OutputFcn, ...
                     'gui_LayoutFcn',  [], ...
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
return;


% --- Executes just before raytracing_ui is made visible.
function raytracing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

  % Choose default command line output for raytracing_ui
  handles.output = hObject;


  %%%%% load gui inital parameter data  %%%%%
  % using the last session parameter
  handles.prm = [];
  filename = 'prm_list/input_tmp.dat';
  prm = input_param(filename);
  if isempty(prm)
    return;
  end
  % determine the text in popup(unit_fq00)
  set(handles.popup_unit_fq00,'String',{'Efreq';'kHz'});
  handles = set_param(hObject,handles, prm);


  % Update handles structure
  guidata(hObject, handles);


  % UIWAIT makes raytracing_ui wait for user response (see UIRESUME)
  % uiwait(handles.figure1);

  % return;

% --- Outputs from this function are returned to the command line.
function varargout = raytracing_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_load.
function varargout = btn_load_Callback(hObject, eventdata, handles)
  [filename, pathname] = uigetfile('prm_list/*.dat');
  if filename
    input_filename = [pathname,filename];
    prm = input_param(input_filename);
    set_param(hObject,handles, prm);
end

% --- Executes on button press in btn_start.
function varargout = btn_start_Callback(hObject, eventdata, handles)
  filename = 'prm_list/input_tmp.dat';
  save_param(filename,handles.prm);
  disp('Under calculation...');
  raytracing_main(filename);
%   guidata(hObject,handles);
return;


% --- Executes on button press in btn_save.
function varargout = btn_save_Callback(hObject, eventdata, handles)
  [filename, pathname] = uiputfile('prm_list/*.dat');
  if filename
    save_filename = [pathname,filename];
    save_param(save_filename,handles.prm);
  end
return;



% --- Executes on button press in btn_exit.
function varargout = btn_exit_Callback(hObject, eventdata, handles)
  close all
  delete(gcf)
return;

% %--------------------------------------------------------------------
% % get parameters
% %--------------------------------------------------------------------
% function prm = param_get(handles)
%     % disp(handles)
%     prm.N = str2double(get(handles.edit_N,'String'));
%     prm.M = str2double(get(handles.edit_M,'String'));
%     prm.unit_fq00 = str2double(get(handles.popup_unit_fq00,'String'));
%     prm.th00 = str2double(get(handles.edit_th00,'String'));
%     prm.ph00 = str2double(get(handles.edit_ph00,'String'));
%     prm.dl00 = str2double(get(handles.edit_dl00,'String'));
%     prm.es00 = str2double(get(handles.edit_es00,'String'));
%     prm.XLPP = str2double(get(handles.edit_XLPP,'String'));
%
%     prm.unit_fq00 = get(handles.popup_unit_fq00,'Value');
% return


function edit_N_Callback(hObject, eventdata, handles)
  handles.prm.N = str2double(get(hObject,'String'));
  guidata(hObject,handles);

function edit_M_Callback(hObject, eventdata, handles)
  handles.prm.M = str2double(get(hObject,'String'));
  guidata(hObject,handles);

function edit_th00_Callback(hObject, eventdata, handles)
  handles.prm.th00 = str2double(get(hObject,'String'));
  guidata(hObject,handles);

function edit_ph00_Callback(hObject, eventdata, handles)
  handles.prm.ph00 = str2double(get(hObject,'String'));
  guidata(hObject,handles);

function edit_dl00_Callback(hObject, eventdata, handles)
  handles.prm.dl00 = str2double(get(hObject,'String'));
  guidata(hObject,handles);

function edit_es00_Callback(hObject, eventdata, handles)
  handles.prm.es00 = str2double(get(hObject,'String'));
  guidata(hObject,handles);

function edit_XLPP_Callback(hObject, eventdata, handles)
  handles.prm.XLPP = str2double(get(hObject,'String'));
  guidata(hObject,handles);

function edit_NLPMAX_Callback(hObject, eventdata, handles)
  handles.prm.NLPMAX = str2double(get(hObject,'String'));
  guidata(hObject,handles);

function popup_unit_fq00_Callback(hObject, eventdata, handles)
  handles.prm.unit_fq00 = get(hObject,'Value');
  guidata(hObject,handles);


% -----------------------------------------------------------------------%
% --- You dont't care about this program under here. --------------------%
% --- Executes during object creation, after setting all properties. ----%
% -----------------------------------------------------------------------%
function edit_N_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
end

function edit_M_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
end

function edit_th00_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
end

function edit_ph00_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
end

function edit_dl00_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
end

function edit_es00_CreateFcn(hObject, eventdata, handles)
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
      set(hObject,'BackgroundColor','white');
  end

function edit_XLPP_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_NLPMAX_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popup_unit_fq00_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
