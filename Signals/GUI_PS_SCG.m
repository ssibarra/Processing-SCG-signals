function varargout = GUI_PS_SCG(varargin)
% GUI_PS_SCG MATLAB code for GUI_PS_SCG.fig
%      GUI_PS_SCG, by itself, creates a new GUI_PS_SCG or raises the existing
%      singleton*.
%
%      H = GUI_PS_SCG returns the handle to a new GUI_PS_SCG or the handle to
%      the existing singleton*.
%
%      GUI_PS_SCG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PS_SCG.M with the given input arguments.
%
%      GUI_PS_SCG('Property','Value',...) creates a new GUI_PS_SCG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_PS_SCG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_PS_SCG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_PS_SCG

% Last Modified by GUIDE v2.5 23-Oct-2018 20:42:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_PS_SCG_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_PS_SCG_OutputFcn, ...
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


% --- Executes just before GUI_PS_SCG is made visible.
function GUI_PS_SCG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_PS_SCG (see VARARGIN)

% Choose default command line output for GUI_PS_SCG

handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes GUI_PS_SCG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_PS_SCG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lista.
function lista_Callback(hObject, eventdata, handles)
% hObject    handle to lista (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lista contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lista


% --- Executes during object creation, after setting all properties.
function lista_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lista (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PlayBtn.
function PlayBtn_Callback(hObject, eventdata, handles)
set(handles.text3, 'visible', 'on');
set(handles.text4, 'visible', 'on');
set(handles.text5, 'visible', 'on');
set(handles.text6, 'visible', 'on');
set(handles.text8, 'visible', 'on');
set(handles.text9, 'visible', 'on');
set(handles.text10, 'visible', 'on');
set(handles.text11, 'visible', 'on');
set(handles.text12, 'visible', 'on');
set(handles.text13, 'visible', 'on');
set(handles.text14, 'visible', 'on');
set(handles.text15, 'visible', 'on');


contenido = get(handles.lista, 'String');
pos = get(handles.lista, 'Value');
signal = string(contenido(pos));
load(signal);

global inS tam_val datab datac datae

inS=normalizar(val);

tam_val=length(val);
tam=tam_val/4;
plot(handles.axes1, inS)
title(handles.axes1, 'Se�al original')
xlim(handles.axes1, [0 tam])

Wp=30/2500;
Ws=70/2500;


[n,Wn]=buttord(Wp,Ws,3,60);
[b,a]=butter(n,Wn);
datab=filter(b,a,inS);
plot(handles.axes2, datab)                          
title(handles.axes2, 'Se�al filtrada con Buttord')
xlim(handles.axes2, [0 tam])

[Psnr, snr] = psnr(datab, inS);
peakSnr = sprintf('%0.4f', Psnr);
set (handles.text4, 'String', peakSnr);

error = sprintf('%0.4f', immse(datab, inS));
set (handles.text5, 'String', error);


[N,Wnc]=cheb1ord(Wp,Ws,3,60);
[b,a]=cheby1(N,3,Wnc);
datac=filter(b,a,inS);
plot(handles.axes5, datac)
title(handles.axes5, 'Se�al filtrada con Chebyshev')
xlim(handles.axes5, [0 tam])

[Psnr, snr] = psnr(datac, inS);
peakSnr = sprintf('%0.4f', Psnr);
set (handles.text9, 'String', peakSnr);

error = sprintf('%0.4f', immse(datac, inS));
set (handles.text10, 'String', error);

[N,Wne]=ellipord(Wp,Ws,3,60);
[b,a]=ellip(N,3,60,Wne);
datae=filter(b,a,inS);
plot(handles.axes6, datae)
title(handles.axes6, 'Se�al filtrada con Cauer')
xlim(handles.axes6, [0 tam])

[Psnr, snr] = psnr(datae, inS);
peakSnr = sprintf('%0.4f', Psnr);
set (handles.text13, 'String', peakSnr);

error = sprintf('%0.4f', immse(datae, inS));
set (handles.text14, 'String', error);


function sign = normalizar(val)
maximo=max(abs(val));
n=length(val);
sign=zeros(1,n);
for i=1:1:n
sign(i)=val(i)/maximo;
end


% --- Executes on button press in GRID.
function GRID_Callback(hObject, eventdata, handles)
% hObject    handle to GRID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% Hint: get(hObject,'Value') returns toggle state of GRID


% --- Executes on button press in Espectro.
function Espectro_Callback(hObject, eventdata, handles)
% hObject    handle to Espectro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_ESPECTRO;
