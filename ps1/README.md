### original
```sh
gnome-open holy-animal.jpg
```
![](holy-animal.jpg)

### reduce intensity

```sh
octave reduceIntensity.m holy-animal.jpg 16
```
![](holy-animal_16.jpg)

```sh
octave reduceIntensity.m holy-animal.jpg 8
```
![](holy-animal_8.jpg)

```sh
octave reduceIntensity.m holy-animal.jpg 4
```
![](holy-animal_4.jpg)

```sh
octave reduceIntensity.m holy-animal.jpg 2
```
![](holy-animal_2.jpg)

### blur
```sh
octave blur.m holy-animal.jpg 3
```
![](holy-animal_blurred_3.jpg)

```sh
octave blur.m holy-animal.jpg 10
```
![](holy-animal_blurred_10.jpg)

```sh
octave blur.m holy-animal.jpg 20
```
![](holy-animal_blurred_20.jpg)
