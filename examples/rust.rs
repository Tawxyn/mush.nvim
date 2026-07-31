//! Rust highlighting fixture for the Mush colorscheme.
//!
//! The fixture intentionally keeps many language constructs in one file.
//!
//! # Rustdoc example
//!
//! ```
//! let widget = mush_rust_fixture::Widget::new(7, "fern");
//! assert_eq!(widget.id(), 7);
//! ```

#![allow(dead_code, unused_variables)]

use crate::support::{Identity, Marker};
use std::fmt::{self, Display};

/// A public type alias with a generic parameter.
pub type ResultMap<T> = Result<T, Box<dyn std::error::Error + Send + Sync>>;

/// A constant and a static value.
pub const MAX_RETRIES: u8 = 3;
pub static APPLICATION_NAME: &str = "mush";
static mut REQUEST_COUNT: usize = 0;

#[derive(Clone, Debug, PartialEq)]
#[repr(C)]
pub struct Widget<'a, T = u32>
where
  T: Copy + Display,
{
  id: T,
  pub name: &'a str,
  enabled: bool,
}

#[derive(Clone, Copy, Debug)]
pub enum Status<T> {
  Ready,
  Busy { progress: u8 },
  Failed(T),
}

#[repr(C)]
pub union NumberBits {
  pub integer: u32,
  pub float: f32,
}

pub trait Render<'a, T: Display>: Sized {
  type Output;
  const KIND: &'static str;

  fn render(&'a self, value: T) -> Self::Output;

  fn kind() -> &'static str {
    Self::KIND
  }
}

impl<'a, T> Widget<'a, T>
where
  T: Copy + Display,
{
  pub fn new(id: T, name: &'a str) -> Self {
    Self {
      id,
      name,
      enabled: true,
    }
  }

  pub const fn id(&self) -> T {
    self.id
  }

  pub fn rename(&mut self, name: &'a str) {
    self.name = name;
  }

  pub async fn refresh(&mut self) -> ResultMap<()> {
    self.enabled = !self.enabled;
    Ok(())
  }
}

impl<'a, T> Render<'a, T> for Widget<'a, T>
where
  T: Copy + Display,
{
  type Output = String;
  const KIND: &'static str = "widget";

  fn render(&'a self, value: T) -> Self::Output {
    format!("{}:{value}", self.name)
  }
}

macro_rules! make_status {
  ($value:expr) => {
    Status::Busy { progress: $value }
  };
}

#[derive(Debug)]
pub struct MarkerAttribute;

pub mod support {
  pub trait Marker {}

  pub struct Identity;

  impl Marker for Identity {}
}

extern "C" {
  fn abs(input: i32) -> i32;
}

#[no_mangle]
pub extern "C" fn mush_callback(value: i32) -> i32 {
  value.saturating_add(1)
}

/// Reads the mutable static through a raw pointer.
///
/// # Safety
///
/// Callers must ensure no concurrent write occurs.
pub unsafe fn request_count() -> usize {
  unsafe { std::ptr::read_volatile(&raw const REQUEST_COUNT) }
}

pub fn exercise<'widget, 'name, T>(
  widget: &'widget mut Widget<'name, T>,
  value: T,
) -> Status<String>
where
  T: Copy + Display + fmt::Debug + 'name,
{
  let immutable = 0xff_u32;
  let mut mutable = 1_000_i64;
  mutable += i64::from(MAX_RETRIES);
  let _mutable_snapshot = mutable;

  let decimal = 42;
  let binary = 0b1010_0101;
  let octal = 0o755;
  let hex = 0xCAFE_BABE_u64;
  let float = 6.022e23_f64;

  let normal = "escaped\nstring";
  let raw = r#"raw "string" with # delimiters"#;
  let bytes = b"bytes\x20";
  let raw_bytes = br#"raw bytes"#;
  let character = '🦀';
  let byte = b'R';
  let formatted = format!("{name}: {value:?}", name = widget.name);

  let add = |left: i32, right: i32| -> i32 { left + right };
  let doubled = (0..4).map(|number| number * 2).collect::<Vec<_>>();

  let status: Status<String> = make_status!(75);
  let message = match status {
    Status::Ready => String::from("ready"),
    Status::Busy {
      progress: progress @ 0..=99,
    } if widget.enabled => {
      format!("working at {progress}%")
    }
    Status::Busy { progress } => format!("done at {progress}%"),
    Status::Failed(ref error) => format!("failed: {error:?}"),
  };

  'outer: loop {
    for number in &doubled {
      if *number > 2 {
        break 'outer;
      }
    }
  }

  let Identity = crate::support::Identity;
  takes_marker::<Identity>();

  unsafe {
    REQUEST_COUNT = REQUEST_COUNT.saturating_add(1);
    let magnitude = abs(-42);
    let bits = NumberBits { integer: hex as u32 };
    let recovered = bits.float;
  }

  widget.rename("moss");
  Status::Failed(message)
}

fn takes_marker<T: Marker>() {}

async fn async_identity<T>(value: T) -> T
where
  T: Send + 'static,
{
  value
}

fn main() {
  let mut widget = Widget::new(7_u32, APPLICATION_NAME);
  let _status = exercise(&mut widget, 11_u32);
  let _future = async_identity(widget.id());
  println!("{} {}", Widget::<u32>::kind(), MAX_RETRIES);
}
