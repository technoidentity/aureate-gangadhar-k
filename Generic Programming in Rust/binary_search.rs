use std::io;

fn binary_search(numbers: &[i32], target: i32) -> bool {
    let mut low = 0;
    let mut high = numbers.len();

    while low < high {
        let mid = low + (high - low) / 2;

        if numbers[mid] == target {
            return true;
        } else if numbers[mid] < target {
            low = mid + 1;
        } else {
            high = mid;
        }
    }

    false
}

fn main() {
    let mut input = String::new();
    let mut numbers = Vec::new();

    println!("Enter numbers:");
    io::stdin().read_line(&mut input).unwrap();

    for num in input.split_whitespace() {
        numbers.push(num.parse::<i32>().unwrap());
    }

    numbers.sort();

    println!("Sorted numbers: {:?}", numbers);

    input.clear();

    println!("Enter number to search:");
    io::stdin().read_line(&mut input).unwrap();

    let target: i32 = input.trim().parse().unwrap();

    if binary_search(&numbers, target) {
        println!("Number found");
    } else {
        println!("Number not found");
    }
}
