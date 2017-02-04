import macros
import field
import typetraits

proc get_fields(body: NimNode): seq[Field]=
  result = @[]
  for stmt in body:
    if stmt.kind == nnkCommand and stmt[0] == newIdentNode(!"field"):
      if stmt[1].kind != nnkCall:
        quit "Usage: field Name(type)"
      let field_name = $stmt[1][0]
      let field_type = $stmt[1][1]
      case field_type
        of "int":
          result.add(IntField(name: field_name))
        of "string":
          result.add(StrField(name: field_name))
        else:
          quit "Unknown field type"

    else:
      quit "Invalid field definition: \n" & stmt.tree_repr
  return


macro model(name: string, body: untyped): untyped =
  result = new_nim_node(nnk_stmt_list)
  let fields = get_fields(body)
  for f in fields:
    echo f.name
    echo $f

  return result

model "Person":
  field Name(string):
    max_length = 128
  field Age(int):
    unsigned
    validate Age > 20
