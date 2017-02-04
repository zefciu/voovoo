import strutils

type
  ValidationResult = ref object of RootObj
    ok*: bool
    message*: string

let
  ok = ValidationResult(ok: true, message: "")

type
  Field* = ref object of RootObj
    name*: string

proc `$`* (f: Field): string=
  return "Field"

# method to_sql[T](self: Field, value: T): string=
#   quit "Not implemented"
# 
# method from_sql[T](self: Field, value: string): T=
#   quit "Not implemented"

method validate[T](self: Field, value: T): ValidationResult=
  return ok

method validate_string[T](self: Field, value: T): ValidationResult=
  return ok

type
  IntField* = ref object of Field
    unsigned*: bool

proc `$*` (f: IntField): string=
  return "IntField"

# method to_sql(self: IntField, value: int): string=
#   return intToStr(value)
# 
# method from_sql(self: IntField, value: string): int=
#   return parseInt(value)

type
  StrField* = ref object of Field

# method to_sql(self: StrField, value: string): string=
#   return value
# 
# method from_sql(self.StrField, value: string): string=
#   return value
