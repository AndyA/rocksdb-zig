const partition = (A: Uint8Array, lo: number, hi: number): number => {
  const pivot = A[lo];
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

// var bytes = Uint8Array.from([10, 3, 9, 2, 11, 1, 3, 3, 3]);
var bytes = Uint8Array.from([11, 10, 5, 5, 5, 5, 2, 1]);
quicksort(bytes, 0, bytes.length - 1);

console.log(bytes);

// const quickSort = (bytes: Uint8Array, start: number, end: number): void => {
//   let lp = start;
//   let rp = end;
//   while (rp >= 0) {
//     if (bytes[lp] > bytes[rp]) {
//       if (lp >= rp) break;
//     }
//   }
// };
