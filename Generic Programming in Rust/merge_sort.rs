use std::io;

fn merge_sort(numbers: &mut [i32]) {
    let n = numbers.len();

    if n <= 1 {
        return;
    }

    let mid = n / 2;

    merge_sort(&mut numbers[..mid]);
    merge_sort(&mut numbers[mid..]);

    let left = numbers[..mid].to_vec();
    let right = numbers[mid..].to_vec();

    let mut i = 0;
    let mut j = 0;
    let mut k = 0;

    while i < left.len() && j < right.len() {
        if left[i] <= right[j] {
            numbers[k] = left[i];
            i += 1;
        } else {
            numbers[k] = right[j];
            j += 1;
        }

        k += 1;
    }

    while i < left.len() {
        numbers[k] = left[i];
        i += 1;
        k += 1;
    }

    while j < right.len() {
        numbers[k] = right[j];
        j += 1;
        k += 1;
    }
}

fn main() {
    let mut input = String::new();
    let mut numbers = Vec::new();

    println!("Enter numbers:");
    io::stdin().read_line(&mut input).unwrap();

    for num in input.split_whitespace() {
        numbers.push(num.parse::<i32>().unwrap());
    }

    merge_sort(&mut numbers);

    println!("Sorted numbers: {:?}", numbers);
}
