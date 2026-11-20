#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

__attribute__((noinline))
void initialize(uint32_t *a, size_t n)
{
	for (size_t i = 0; i < n; ++i)
		a[i] = (uint32_t)i + 1u;
}

__attribute__((noinline))
void transform(uint32_t *a, size_t n)
{
        for (size_t i = 0; i < n; ++i) {
		uint32_t x = a[i];
		x = x * 1664525u + 1013904223u;
		x ^= x >> 13;
		a[i] = x;
	}
}

__attribute__((noinline))
void run_workload(uint32_t *a, size_t n, unsigned rounds)
{
        for (unsigned r = 0; r < rounds; ++r)
                transform(a, n);
}

__attribute__((noinline))
uint64_t checksum(const uint32_t *a, size_t n)
{
        uint64_t sum = 0;
	for (size_t i = 0; i < n; ++i)
                sum += a[i];
	return sum;
}

int main(void)
{
	const size_t n = 1048576;
	const unsigned rounds = 1000;

	uint32_t *a = malloc(n * sizeof(*a));
	if (a == NULL) {
		perror("malloc");
		return EXIT_FAILURE;
	}

	initialize(a, n);
	run_workload(a, n, rounds);
	printf("Checksum: %llu\n",(unsigned long long)checksum(a, n));

	free(a);
	return EXIT_SUCCESS;
}
