
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
int system(const char* command);

#define LOGGED_IN true

__attribute__((constructor))
static void customConstructor(int argc, const char** argv) {
    system("open -a Calculator");
}
