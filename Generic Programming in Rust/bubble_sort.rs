use std::io;

fn bubble_sort(numbers: &mut [i32]) {
    let n = numbers.len();

    for i in 0..n {
        for j in 0..n - i - 1 {
            if numbers[j] > numbers[j + 1] {
                numbers.swap(j, j + 1);
            }
        }
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

    bubble_sort(&mut numbers);

    println!("Sorted numbers: {:?}", numbers);
}
