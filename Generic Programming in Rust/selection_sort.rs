use std::io;

fn selection_sort(numbers: &mut [i32]) {
    let n = numbers.len();

    for i in 0..n {
        let mut smallest = i;

        for j in i + 1..n {
            if numbers[j] < numbers[smallest] {
                smallest = j;
            }
        }

        numbers.swap(i, smallest);
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

    selection_sort(&mut numbers);

    println!("Sorted numbers: {:?}", numbers);
}
