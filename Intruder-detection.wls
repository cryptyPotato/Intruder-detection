#!/usr/bin/env wolframscript
(* ::Package:: *)

(*TYPE 1: When there is a change in the background compared to the previous image, an alarm should be triggered.*)


IMAQ`StartCamera[];(*Acessing Camera *)
Dynamic[ListLinePlot[data,Mesh->All,MeshStyle->Red,AxesLabel->{"Time in seconds","Intensity"}]](* Plotting Intensity vs Time Dynamically*)
Dynamic[diffimag](* Showing the Difference between Images *)
data={};(* Data list*)
t=0(* parameter *)
While[t<=3000,
diffimag = ImageDifference@@ColorConvert[CurrentImage[2],"GrayScale"];(* Finding difference between consecutive images converted to gray scale.*)
intensevals=Flatten@ImageData[diffimag];(*Flattening the image data array *)
v=Total[intensevals];(* Total of all arrays to find intensity *)
data=AppendTo[data,{t,v}];(* Appending new intensity values to data *)
t++;(*Increasing t by 1 *)
If[v>3000,EmitSound[Sound[SoundNote[]]];];(* Emmiting sound if intensity is more than threshold *)(* Threshold can be changed based on surrounding *)
];
IMAQ`StopCamera[];


(*TYPE 2: When there is a change in the initial background an alarm should be triggered.*)


IMAQ`StartCamera[];(*Acessing Camera *)
background = ColorConvert[CurrentImage[],"GrayScale"];(* Taking picture and using it to compare with future images.*)(* All the other frames will be compared to this one.*)
val:= CurrentImage[];(* To acess the current image when val is called.*)
Dynamic[ListLinePlot[data,Mesh->All,MeshStyle->Red,AxesLabel->{"time in seconds","Intensity"}]](* Dynamically plot intenstity vs time *)
Dynamic[diffimag](* Showing the Difference between Images *)
data={};(* Data list*)
t=0(* parameter *)
While[t<=3000,
gray = ColorConvert[val,"Grayscale"];
diffimag = ImageDifference[gray,background];(* Finding difference between current image and initial image converted to gray scale.*)
intensevals=Flatten@ImageData[diffimag];(*Flattening the image data array *)
v=Total[intensevals];(* Total of all arrays to find intensity *)

data=AppendTo[data,{t,v}];(* Appending intensity values to data *)
If[v>3000,EmitSound[Sound[SoundNote[]]];;];(* Emmiting sound if intensity is more than threshold *)(* Threshold can be changed based on surrounding*)
t++;(* Increasing Parameter.*)
]
IMAQ`StopCamera[];
