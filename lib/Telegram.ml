module Chat = struct
  type t = { id : int; _type : string [@key "type"] }
  [@@deriving yojson { strict = false }]
end

module User = struct
  type t = { id : int; is_bot : bool; first_name : string }
  [@@deriving yojson { strict = false }]
end

module Message = struct
  type t = {
    message_id : int;
    from : User.t;
    date : int;
    chat : Chat.t;
    text : string;
  }
  [@@deriving yojson { strict = false }]
end

module Update = struct
  type t = { update_id : int; message : Message.t }
  [@@deriving yojson { strict = false }]
end
