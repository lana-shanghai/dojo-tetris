#[system]
mod Spawn {
    use array::ArrayTrait;
    use traits::Into;

    use dojo_examples::components::Rectangle;

    fn execute(ctx: Context) {
        let player = commands::set_entity(
            ctx.caller_account.into(), (Rectangle { height: 20, width: 6 }, )
        );
        return ();
    }
}

#[system]
mod Tetris {
    use array::ArrayTrait;
    use traits::Into;

    use dojo_examples::components::Position;
    use dojo_examples::components::Rectangle;

    fn initialize_grid(width: u8, height: u8) -> Array<u8> {
        let mut grid = ArrayTrait::<u8>::new();
        let mut h: u8 = 0;
        loop {
            if h >= height {
                break ();
            }
            if h < height {
                let mut w: u8 = 0;
                loop {
                    if w >= width {
                        break ();
                    }
                    if w < width {
                        grid.append(0);
                    }
                    w += 1;
                };
            }
            h += 1;
        };
        return grid;
    }

    fn update_grid(grid: Array<u8>) -> Array<u8> {
        // TODO
        grid
    }

    fn check_full_line(grid: Array<u8>, width: u8, height: u8) -> bool {
        let mut full = true;
        let mut w = 0;
        loop {
            if w >= width {
                break ();
            }
            if w < width {
                let idx: u32 = height.into() * width.into() + w.into();
                if *grid.at(idx) == 0 {
                    full = false;
                }
            }
            w += 1;
        };
        return full;
    }

    fn execute(ctx: Context) {
        let box = commands::<Rectangle>::entity(ctx.caller_account.into());
        let grid = initialize_grid(box.height, box.width);
        let uh = commands::set_entity(
            ctx.caller_account.into(),
            (grid), 
        );
        return ();
    }
}

#[system]
mod StartingPosition {
    use array::ArrayTrait;
    use traits::Into;

    use dojo_examples::components::Shape;
    use dojo_examples::components::ShapePosition;
    use dojo_examples::components::Orientation;
    use dojo_examples::components::Coordinates;

    fn generate_starting_coordinates(shape: Shape, orientation: Orientation) -> ShapePosition {
        match shape {
            // A square has `(width - 1)` options of starting placement, independent of orientation
            // The default starting position is the top left corner
            Shape::Square(()) => {
                Coordinates::square_default()
            },
            // A horizontal line has `(width - 3)` options of starting placement
            // A vertical line has `width` options of starting placement
            Shape::Line(()) => {
                match orientation {
                    Orientation::North(()) => {
                        Coordinates::line_north_default()
                    },
                    Orientation::East(()) => {
                        Coordinates::line_east_default()
                    },
                    Orientation::South(()) => {
                        Coordinates::line_north_default()
                    },
                    Orientation::West(()) => {
                        Coordinates::line_east_default()
                    },
                }
            },
        }
    }
}