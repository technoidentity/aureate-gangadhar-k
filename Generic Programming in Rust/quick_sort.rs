use std::io;

fn quick_sort(numbers: &mut [i32]) {
    let n = numbers.len();

    if n <= 1 {
        return;
    }

    let pivot = n - 1;
    let mut pos = 0;

    for i in 0..pivot {
        if numbers[i] < numbers[pivot] {
            numbers.swap(i, pos);
            pos += 1;
        }
    }

    numbers.swap(pos, pivot);

    quick_sort(&mut numbers[..pos]);
    quick_sort(&mut numbers[pos + 1..]);
}

fn main() {
    let mut input = String::new();
    let mut numbers = Vec::new();

    println!("Enter numbers:");
    io::stdin().read_line(&mut input).unwrap();

    for num in input.split_whitespace() {
        numbers.push(num.parse::<i32>().unwrap());
    }

    quick_sort(&mut numbers);

    println!("Sorted numbers: {:?}", numbers);
}
