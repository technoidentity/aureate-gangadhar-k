use std::io;

fn linear_search(numbers: &[i32], target: i32) -> bool {
    for num in numbers {
        if *num == target {
            return true;
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

    input.clear();

    println!("Enter number to search:");
    io::stdin().read_line(&mut input).unwrap();

    let target: i32 = input.trim().parse().unwrap();

    if linear_search(&numbers, target) {
        println!("Number found");
    } else {
        println!("Number not found");
    }
}
