#!/bin/bash

# # data2 directory
# ls -l ../data/bandwidth-*.dat | tr -s ' ' | cut -d' ' -f9 | cut -d'/' -f3 | while read f; do gnuplot -e "
# set ylabel 'Пропускна здатність (Mbits/sec)';
# set xlabel 'Затримка (ms)';
# set title 'OpenVpn';
# set terminal png size 800,600;
# set output '../data2/$f.png';
# plot '../data2/$f' with linespoints
# "; done

# filenames=$(ls -l ../data2/bandwidth-*.dat | tr -s ' ' | cut -d' ' -f9 | cut -d'/' -f3)

# gnuplot -e "
# set ylabel 'Пропускна здатність (Mbits/sec)';
# set xlabel 'Затримка (ms)';
# set terminal png size 800,600;
# set title 'OpenVpn';
# set output '../data2/res.png'; 
# plot for [i=1:10] '../data2/bandwidth-'.i.'0.dat' title 'bandwidth-'.i.'0'  with lines"

# gnuplot -e "
# set ylabel 'Середня квадратичне відхилення (ms)';
# set xlabel 'Затримка (ms)';
# set terminal png size 800,600; 
# set title 'OpenVpn';
# set output '../data2/jitter.png'; 
# plot for [i=1:10] '../data2/jitter-'.i.'0.dat' title 'bandwidth-'.i.'0'  with lines"

# # data1 directory
# ls -l ../data/bandwidth-*.dat | tr -s ' ' | cut -d' ' -f9 | cut -d'/' -f3 | while read f; do gnuplot -e "
# set ylabel 'Пропускна здатність (Mbits/sec)';
# set xlabel 'Затримка (ms)';
# set title 'Vtrunkd';
# set terminal png size 800,600;
# set output '../data1/$f.png';
# plot '../data1/$f' with linespoints
# "; done

# filenames=$(ls -l ../data1/bandwidth-*.dat | tr -s ' ' | cut -d' ' -f9 | cut -d'/' -f3)

# gnuplot -e "
# set ylabel 'Пропускна здатність (Mbits/sec)';
# set xlabel 'Затримка (ms)';
# set terminal png size 800,600; 
# set title 'Vtrunkd';
# set output '../data1/res.png'; 
# plot for [i=1:10] '../data1/bandwidth-'.i.'0.dat' title 'bandwidth-'.i.'0'  with lines"

# # data directory
# ls -l ../data/bandwidth-*.dat | tr -s ' ' | cut -d' ' -f9 | cut -d'/' -f3 | while read f; do gnuplot -e "
# set ylabel 'Пропускна здатність (Mbits/sec)';
# set xlabel 'Затримка (ms)';
# set title 'Vtrunkd';
# set terminal png size 800,600;
# set output '../data/$f.png';
# plot '../data/$f' with linespoints
# "; done

# filenames=$(ls -l ../data/bandwidth-*.dat | tr -s ' ' | cut -d' ' -f9 | cut -d'/' -f3)

# gnuplot -e "
# set ylabel 'Пропускна здатність (Mbits/sec)';
# set xlabel 'Затримка (ms)';
# set terminal png size 800,600; 
# set title 'Vtrunkd';
# set output '../data/res.png'; 
# plot for [i=1:10] '../data/bandwidth-'.i.'0.dat' title 'bandwidth-'.i.'0'  with lines"

# gnuplot -e "
# set ylabel 'Середня квадратичне відхилення (ms)';
# set xlabel 'Затримка (ms)';
# set terminal png size 800,600; 
# set title 'Vtrunkd';
# set output '../data/jitter.png'; 
# plot for [i=1:10] '../data/jitter-'.i.'0.dat' title 'bandwidth-'.i.'0'  with lines"

# loss1

gnuplot -e "
set ylabel 'Пропускна здатність (Mbits/sec)';
set xlabel 'Відсоток втрати пакетів (%)';
set terminal png size 800,600; 
set title 'Vtrunkd';
set output '../loss1/loss.png';
plot for [i=1:10] '../loss1/loss-'.i.'.dat' title 'bandwidth-'.i.'0'  with lines"


gnuplot -e "
set ylabel 'Пропускна здатність (Mbits/sec)';
set xlabel 'Відсоток втрати пакетів (%)';
set terminal png size 800,600; 
set title 'OpenVpn';
set output '../loss2/loss.png';
plot for [i=1:10] '../loss2/loss-'.i.'.dat' title 'bandwidth-'.i.'0'  with lines"