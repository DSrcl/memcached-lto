LDFLAGS=-lssl -lcrypto
LD=clang
MEMCACHED_DIR=memcached
LIBEVENT_DIR=libevent

.PHONY: memcached-bc libevent-bc

all: memcached-lto

memcached-lto.o: memcached-bc libevent-bc
	llvm-link $(MEMCACHED_DIR)/memcached $(LIBEVENT_DIR)/*.o | llc -filetype=obj -O3 -o $@

memcached-bc:
	$(MAKE) -C $(MEMCACHED_DIR)

libevent-bc:
	$(MAKE) -i -C $(LIBEVENT_DIR)

clean:
	rm -f memcached-lto memcached-lto.o
	$(MAKE) -C $(MEMCACHED_DIR) clean
	$(MAKE) -C $(LIBEVENT_DIR) clean
