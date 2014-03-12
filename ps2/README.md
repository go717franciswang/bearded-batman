### basic JPEG implementation with DCT (Discrete Cosine Transform)
```sh
gnome-open grizzly.jpg
for i in 0.25 0.5 1 2 4 8
do
octave jpeg.m $i
done
```
![](grizzly.jpg)
![](grizzly_jpeg_0.25.jpg)
![](grizzly_jpeg_0.50.jpg)
![](grizzly_jpeg_1.00.jpg)
![](grizzly_jpeg_2.00.jpg)
![](grizzly_jpeg_4.00.jpg)
![](grizzly_jpeg_8.00.jpg)

### .. with FFT (Fast Fourier Transform)
multipliers are chosen so that the compressed files takes roughly the same bytes as the DCT multipliers in order
```sh
for i in 1 2 8 16 32 64
do
octave jpeg-fft.m $i
done
```
![](grizzly_jpeg_fft_1.00.jpg)
![](grizzly_jpeg_fft_2.00.jpg)
![](grizzly_jpeg_fft_8.00.jpg)
![](grizzly_jpeg_fft_16.00.jpg)
![](grizzly_jpeg_fft_32.00.jpg)
![](grizzly_jpeg_fft_64.00.jpg)

### .. without any transformation
```sh
for i in 1 2 4
do octave jpeg-just-quantization.m $i
done
```
![](grizzly_jpeg_just_quantization_1.00.jpg)
![](grizzly_jpeg_just_quantization_2.00.jpg)
![](grizzly_jpeg_just_quantization_4.00.jpg)

### .. with DCT, constant quantization for Y-channel and more quantization for Cb and Cr
```sh
for i in 1 2 4 8 16 32 64 128
do octave jpeg-colored.m $i
done
```
![](grizzly_jpeg_just_color_1.00.jpg)
![](grizzly_jpeg_just_color_2.00.jpg)
![](grizzly_jpeg_just_color_4.00.jpg)
![](grizzly_jpeg_just_color_8.00.jpg)
![](grizzly_jpeg_just_color_16.00.jpg)
![](grizzly_jpeg_just_color_32.00.jpg)
![](grizzly_jpeg_just_color_64.00.jpg)
![](grizzly_jpeg_just_color_128.00.jpg)

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
