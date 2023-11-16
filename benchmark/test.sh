ab -n 200 -c 10 -g rr.data http://granz.channel.it22.com/rr > rr.log
ab -n 200 -c 10 -g rr-weight.data http://granz.channel.it22.com/rr-weight > rr-weight.log
ab -n 200 -c 10 -g least-conn.data http://granz.channel.it22.com/ > least-conn.log
ab -n 200 -c 10 -g ip-hash.data http://granz.channel.it22.com/ip-hash > ip-hash.log
ab -n 200 -c 10 -g generic-hash.data http://granz.channel.it22.com/generic-hash > generic-hash.log

ab -n 100 -c 10 -g one.data http://granz.channel.it22.com/one > one.log
ab -n 100 -c 10 -g two.data http://granz.channel.it22.com/two > two.log
ab -n 100 -c 10 -g three.data http://granz.channel.it22.com/three > three.log
