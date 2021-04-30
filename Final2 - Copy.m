function [] = Final2()
close all
%want to make sure all other figures are closed when this is opened, also
%need to gain access to the global gui to be able to use all functions with
%the same units and ease.
global gui;
gui.fig = figure('numbertitle','off','name','User plotting','position',[200 100 1300 800]);
subplot('position',[.2 .2 .75 .70]);

%Need to set up the edit boxes for the user to be able to manually enter
%information to be plotted
gui.xcoor = uicontrol('style','edit','units','normalize','position',[.15 .05 .3 .05]);
gui.xlabel = uicontrol('style','text','units','normalize','position',[.15 .1 .3 .05],'string','X-Coordinates');

gui.ycoor = uicontrol('style','edit','units','normalize','position',[.45 .05 .3 .05]);
gui.ylabel = uicontrol('style','text','units','normalize','position',[.45 .1 .3 .05],'string','Y-Coordinates');

%First button group is going to be to select the color of the markers.
%These will produce a logical 1 when the button is selected by the user.
gui.bg1 = uibuttongroup('Visible','on','units','normalize','position',[0 .525 .15 .45],'SelectionChangedFCN',@plotNow);
gui.bgtext = uicontrol(gui.bg1,'style','text','units','normalize','string','Color Select','position',[0 .852 1 .1]);
gui.r1 = uicontrol(gui.bg1,'style','radiobutton','units','normalize','string','Red','Position',[0 .710 1 .1]);
gui.r2 = uicontrol(gui.bg1,'Style','radiobutton','units','normalize','String','Blue','Position',[0 .568 1 .1]);
gui.r3 = uicontrol(gui.bg1,'Style','radiobutton','units','normalize','String','Green','position',[0 .426 1 .1]);
gui.r4 = uicontrol(gui.bg1,'style','radiobutton','units','normalize','string','Black','Position',[0 .284 1 .1]);
gui.r5 = uicontrol(gui.bg1,'Style','radiobutton','units','normalize','String','Yellow','Position',[0 .142 1 .1]);
gui.r6 = uicontrol(gui.bg1,'Style','radiobutton','units','normalize','String','Cyan','position',[0 0 1 .1]);

%The second button group will be to choose the style of the marker. Same
%case with the logical one to determine which button is pressed.
gui.bg2 = uibuttongroup('Visible','on','units','normalize','position',[0 .025 .15 .45],'SelectionChangedFCN',@plotNow);
gui.bg2text = uicontrol(gui.bg2,'style','text','units','normalize','string','Marker Select','position',[0 .852 1 .1]);
gui.t1 = uicontrol(gui.bg2,'style','radiobutton','units','normalize','string','X','Position',[0 .710 1 .1]);
gui.t2 = uicontrol(gui.bg2,'Style','radiobutton','units','normalize','String','O','Position',[0 .568 1 .1]);
gui.t3 = uicontrol(gui.bg2,'Style','radiobutton','units','normalize','String','*','position',[0 .426 1 .1]);
gui.t4 = uicontrol(gui.bg2,'style','radiobutton','units','normalize','string','+','Position',[0 .284 1 .1]);
gui.t5 = uicontrol(gui.bg2,'Style','radiobutton','units','normalize','String','Dots','Position',[0 .142 1 .1]);
gui.t6 = uicontrol(gui.bg2,'Style','radiobutton','units','normalize','String','Diamonds','position',[0 0 1 .1]);

%Simple push buttons to be able to plot and reset the graph
gui.plotbutton = uicontrol('style','pushbutton','units','normalize','position',[.8 .05 .15 .1],'string','PLOT','callback',{@plotNow}); 
gui.resetbutton = uicontrol('style','pushbutton','units','normalize','position',[.47 .95 .15 .05],'string','RESET','callback',{@resetNow});

end

function[] = resetNow(~,~)
%This function is to be able to get a clean plot again without having to
%exit and restart the figure. The plot(0,0) cleans the plot, while emptying
%the gui.string will clear out the xcoor and y coor edit boxes.
hold off
global gui;
plot(0,0);
gui.xcoor.String = [];
gui.ycoor.String = [];
hold on
end

function[] = plotNow(~,~)
%This takes the info from the x and y edit boxes, turns the information
%into numbers that the function can read and turn into plot points. If they
%are different in length, it will display a modal error and inform you that
%the numbers need looked at and adjusted. It also determines the line style
%by running the bselection function
global gui;
hold on
line = bselection;
x = str2num(gui.xcoor.String);
y = str2num(gui.ycoor.String);

    if length(x) == length(y)
        plot(x,y,line);
    else
        msgbox('Invalid number of points','Error','error','modal');
    end
end

function[line] = bselection()
% This function runs through every selection to see which button is a
% logical 1, and compares it to the second button group to see which
% selection matches up. This then produces a string that will determine
% what the line looks like. There may be an easier way to do this, but in
% this case it doesn't take too much time and is functioning so I was going
% to leave it like this.
global gui;

        if gui.r1.Value == 1
            if gui.t1.Value == 1
                line = 'rx';
            elseif gui.t2.Value == 1
                line = 'ro';
            elseif gui.t3.Value == 1
                line = 'r*';
            elseif gui.t4.Value == 1
                line = 'r+';
            elseif gui.t5.Value == 1
                line = 'r.';
            else
                line = 'rd';
            end
        elseif gui.r2.Value == 1
            if gui.t1.Value == 1
                line = 'bx';
            elseif gui.t2.Value == 1
                line = 'bo';
            elseif gui.t3.Value == 1
                line = 'b*';
            elseif gui.t4.Value == 1
                line = 'b+';
            elseif gui.t5.Value == 1
                line = 'b.';
            else
                line = 'bd';
            end
        elseif gui.r3.Value == 1
            if gui.t1.Value == 1
                line = 'gx';
            elseif gui.t2.Value == 1
                line = 'go';
            elseif gui.t3.Value == 1
                line = 'g*';
            elseif gui.t4.Value == 1
                line = 'g+';
            elseif gui.t5.Value == 1
                line = 'g.';
            else
                line = 'gd';
            end
        elseif gui.r4.Value == 1
            if gui.t1.Value == 1
                line = 'kx';
            elseif gui.t2.Value == 1
                line = 'ko';
            elseif gui.t3.Value == 1
                line = 'k*';
            elseif gui.t4.Value == 1
                line = 'k+';
            elseif gui.t5.Value == 1
                line = 'k.';
            else
                line = 'kd';
            end
        elseif gui.r5.Value == 1
            if gui.t1.Value == 1
                line = 'yx';
            elseif gui.t2.Value == 1
                line = 'yo';
            elseif gui.t3.Value == 1
                line = 'y*';
            elseif gui.t4.Value == 1
                line = 'y+';
            elseif gui.t5.Value == 1
                line = 'y.';
            else
                line = 'yd';
            end
        else
            if gui.t1.Value == 1
                line = 'cx';
            elseif gui.t2.Value == 1
                line = 'co';
            elseif gui.t3.Value == 1
                line = 'c*';
            elseif gui.t4.Value == 1
                line = 'c+';
            elseif gui.t5.Value == 1
                line = 'c.';
            else
                line = 'cd';
            end
        end
        
end


