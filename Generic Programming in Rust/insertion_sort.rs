use std::io;

fn insertion_sort<T: Ord>(numbers: &mut [T]) {
    for i in 1..numbers.len() {
        let mut j = i;
        while j > 0 && numbers[j - 1] > numbers[j] {
            numbers.swap(j - 1, j);
            j -= 1;
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

    insertion_sort(&mut numbers);

    println!("Sorted numbers: {:?}", numbers);
}

