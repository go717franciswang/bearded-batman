### basic JPEG implementation
```sh
gnome-open grizzly.jpg
octave jpeg.m 0.25
octave jpeg.m 0.50
octave jpeg.m 1.00
octave jpeg.m 2.00
octave jpeg.m 4.00
octave jpeg.m 8.00
```
![](grizzly.jpg)
![](grizzly_jpeg_0.25.jpg)
![](grizzly_jpeg_0.50.jpg)
![](grizzly_jpeg_1.00.jpg)
![](grizzly_jpeg_2.00.jpg)
![](grizzly_jpeg_4.00.jpg)
![](grizzly_jpeg_8.00.jpg)

### dependencies
* octave-signal
  * dct
  * idct
* octave-image
  * ~~rgb2ycbcr~~
```sh
apt-get install octave-signal
apt-get install octave-image
```
