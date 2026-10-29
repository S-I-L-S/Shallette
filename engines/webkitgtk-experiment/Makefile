CFLAGS := $(shell pkg-config --cflags gtk+-3.0 webkit2gtk-4.1)
LIBS := $(shell pkg-config --libs gtk+-3.0 webkit2gtk-4.1)

shallette-webkit: shallette-webkit.c
	gcc $< -o $@ $(CFLAGS) $(LIBS)

clean:
	rm -f shallette-webkit
