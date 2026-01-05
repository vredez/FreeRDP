BUILD_DIR := build

.PHONY: build b
build b:
	cmake --build $(BUILD_DIR)

.PHONY: configure c
configure c:
	mkdir -p build
	cmake -S . -B build -DWITH_CLIENT_SDL2=OFF

.PHONY: clean
clean:
	cmake --build $(BUILD_DIR) --target clean
