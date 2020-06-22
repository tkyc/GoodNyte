use std::error::Error;

use lambda_runtime::{error::HandlerError, lambda, Context};
use log::{self, error};
use serde_derive::{Deserialize, Serialize};
use simple_error::bail;
use simple_logger;



//TODO: Testing lambda events with rust -- refactor later
#[derive(Deserialize)]
struct CustomEvent {
    #[serde(rename = "message")]
    message: String,
}



#[derive(Serialize)]
struct CustomOutput {
    message: String,
}



fn main() -> Result<(), Box<dyn Error>> {
    simple_logger::init_with_level(log::Level::Debug)?;
    lambda!(my_handler);

    Ok(())
}



fn my_handler(e: CustomEvent, c: Context) -> Result<CustomOutput, HandlerError> {

    if e.message == "" {

        error!("Bad event parameters -- {:?}", c.aws_request_id);

        bail!("Bad even parameters");

    }

    Ok(CustomOutput {
        message: format!("Hello from rust lambda runtime!"),
    })

}
