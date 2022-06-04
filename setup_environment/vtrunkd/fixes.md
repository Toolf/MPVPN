# Fixes

При білді vtrunkd виникла помилка
'''
gcc -std=gnu99 -DSYSLOG=1 -O3  -W -o vtrunkd main.o cfg_file.tab.o cfg_file.lex.o server.o client.o lib.o frame_llist.o llist.o auth.o tunnel.o lock.o netlib.o tun_dev.o tap_dev.o pty_dev.o pipe_dev.o tcp_proto.o udp_proto.o log.o linkfd.o lfd_shaper.o lfd_zlib.o lfd_lzo.o lfd_encrypt.o speed_algo.o timer.o packet_code.o udp_states.o pid.o   -lbsd -lpthread  -lm
/bin/ld: linkfd.o:(.bss+0x1068): multiple definition of `shm_conn_info'; server.o:(.bss+0x8): first defined here
collect2: error: ld returned 1 exit status
make: *** [Makefile:67: vtrunkd] Error 1
'''

Її вирішення вже існує в одному з [форків](https://github.com/maxrd2/vtrunkd/commit/eed9d0679de69aff1964d0aeec770743fcdbb7c8)