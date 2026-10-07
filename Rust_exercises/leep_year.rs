pub fn is_leap_year(year: u64) -> bool {
    if year % 400 == 0 {
        true
    } else if year % 100 == 0 {
        false
    } else if year % 4 == 0 {
        true
    } else {
        false
    }
}

fn main() {
    let year = 2000;

    if is_leap_year(year) {
        println!("{} is a leap year", year);
    } else {
        println!("{} is not a leap year", year);
    }
}