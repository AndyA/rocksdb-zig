const median3 = (a: number, b: number, c: number): number => {
  if (a <= b && b <= c) return b;
  if (a >= b && b >= c) return b;
  if (b <= a && a <= c) return a;
  if (b >= a && a >= c) return a;
  return c;
};

const partition = (A: Uint8Array, lo: number, hi: number): number => {
  const pivot = median3(A[lo], A[hi], A[Math.floor((lo + hi) / 2)]);
  var i = lo - 1;
  var j = hi + 1;
  while (true) {
    while (true) {
      i++;
      if (A[i] >= pivot) break;
    }
    while (true) {
      j--;
      if (A[j] <= pivot) break;
    }
    if (i >= j) return j;
    [A[i], A[j]] = [A[j], A[i]];
  }
};

const quicksort = (A: Uint8Array, lo: number, hi: number): void => {
  if (lo >= 0 && hi >= 0 && lo < hi) {
    const p = partition(A, lo, hi);
    quicksort(A, lo, p);
    quicksort(A, p + 1, hi);
  }
};

const avgSort = (ar: number[], lo: number, hi: number) => {
  if (hi === lo) return;

  if (hi === lo + 1) {
    if (ar[lo] > ar[hi]) {
      [ar[lo], ar[hi]] = [ar[hi], ar[lo]];
    }
    return;
  }
};
