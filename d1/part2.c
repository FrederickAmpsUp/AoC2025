#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
  FILE *input = fopen("input.txt", "r");
  if (!input) {
    printf("failed to open input :(\n");
    return -1;
  }

  int dial = 50;
  int ans = 0;
  char line[16];

  while (fgets(line, 16, input)) {
    if (strlen(line) < 2) {
      printf("not enough characters\n");
      return -1;
    }

    int sign;
    switch (line[0]) {
      case 'L':
        sign = -1;
      break;
      case 'R':
        sign = 1;
      break;
      default:
        printf("unexpected character %c\n", line[0]);
        return -1;
    }

    int dist = atoi(line+1);

    for (int i = 0; i < dist; ++i) {
      // this is really dumb
      dial += sign;
      if (dial >= 100) dial -= 100;
      if (dial <    0) dial += 100;
      if (dial == 0) ans++;
    }
  }

  printf("%d\n", ans);

  return 0;
}
