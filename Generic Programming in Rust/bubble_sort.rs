use std::io;

fn bubble_sort<T: Ord>(numbers: &mut [T]) {
    let mut end = numbers.len();

    while end > 1 {
        let mut last_swap = 0;
        for j in 1..end {
            let i = j - 1;
            if numbers[i] > numbers[j] {
                numbers.swap(i, j);
                last_swap = j;
            }
        }
        end = last_swap;
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

