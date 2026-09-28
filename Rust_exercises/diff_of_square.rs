use std::io;

fn main() {
    println!("Enter a number:");

    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();

    let n: u32 = input.trim().parse().expect("Please enter a whole number");

    let mut sum = 0;
    let mut sum_of_squares = 0;

    for i in 1..=n {
        sum += i;
        sum_of_squares += i * i;
    }

    let square_of_sum = sum * sum;

    println!("Square of sum: {}", square_of_sum);
    println!("Sum of squares: {}", sum_of_squares);
    println!("Difference: {}", square_of_sum - sum_of_squares);
}
