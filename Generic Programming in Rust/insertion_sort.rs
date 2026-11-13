use std::io;

fn insertion_sort(numbers: &mut [i32]) {
    for i in 1..numbers.len() {
        let current = numbers[i];
        let mut j = i;

        while j > 0 && numbers[j - 1] > current {
            numbers[j] = numbers[j - 1];
            j -= 1;
        }

        numbers[j] = current;
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
