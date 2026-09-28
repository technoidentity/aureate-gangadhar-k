pub fn nth(n: u32) -> u32 {
    let mut count = 0;
    let mut number = 2;

    loop {
        if is_prime(number) {
            if count == n {
                return number;
            }

            count += 1;
        }

        number += 1;
    }
}

fn is_prime(number: u32) -> bool {
    if number < 2 {
        return false;
    }

    for divisor in 2..number {
        if number % divisor == 0 {
            return false;
        }
    }

    true
}

fn main() {
    for n in [0, 1, 2, 5, 10] {
        println!("The {}th prime is {}", n, nth(n));
    }
}