### original
```sh
gnome-open holy-animal.jpg
```
![](holy-animal.jpg)

### reduce intensity

```sh
octave reduceIntensity.m holy-animal.jpg 16
octave reduceIntensity.m holy-animal.jpg 8
octave reduceIntensity.m holy-animal.jpg 4
octave reduceIntensity.m holy-animal.jpg 2
```
![](holy-animal_16.jpg)
![](holy-animal_8.jpg)
![](holy-animal_4.jpg)
![](holy-animal_2.jpg)

### blur
```sh
octave blur.m holy-animal.jpg 3
octave blur.m holy-animal.jpg 10
octave blur.m holy-animal.jpg 20
```
![](holy-animal_blurred_3.jpg)
![](holy-animal_blurred_10.jpg)
![](holy-animal_blurred_20.jpg)

### rotate
```sh
octave rotate.m holy-animal.jpg 90
octave rotate.m holy-animal.jpg 45
```
![](holy-animal_rotated_90.jpg)
![](holy-animal_rotated_45.jpg)

### pixelize
```sh
octave pixelize.m holy-animal.jpg 3
octave pixelize.m holy-animal.jpg 9
octave pixelize.m holy-animal.jpg 27
```
![](holy-animal_pixelized_3.jpg)
![](holy-animal_pixelized_9.jpg)
![](holy-animal_pixelized_27.jpg)

