use time::{Duration, PrimitiveDateTime};

pub fn after(start: PrimitiveDateTime) -> PrimitiveDateTime {
    start + Duration::seconds(1_000_000_000)
}

fn main() {
    let start = PrimitiveDateTime::new(
        time::Date::from_calendar_date(2015, time::Month::January, 24).unwrap(),
        time::Time::from_hms(22, 0, 0).unwrap(),
    );

    let result = after(start);

    println!("{}", result);
}