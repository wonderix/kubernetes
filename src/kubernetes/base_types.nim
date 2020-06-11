import yaml, base64, parsejson, times, tables, json, jsonstream

type 
    ByteArray* = distinct string
    IntOrStringKind* = enum 
        iosString,
        iosInt
    IntOrString* = object
        case kind: IntOrStringKind
        of iosString:
            svalue: string
        of iosInt:
            ivalue: int


setTagUri(ByteArray, "!string")

proc constructObject*( s: var YamlStream, c: ConstructionContext, result: var ByteArray)
    {.raises: [YamlConstructionError, YamlStreamError ].} =
  constructScalarItem(s, item, string):
    try:
      result = decode(item.scalarContent).ByteArray
    except ValueError:
      raise newException(YamlConstructionError,"error")

proc representObject*(value: ByteArray, ts: TagStyle, c: SerializationContext, tag: TagId) {.raises: [].} =
  ## represents an integer value as YAML scalar
  c.put(scalarEvent(encode(string(value)), tag, yAnchorNone))


proc load*(value: var string, parser: var JsonParser )=
  if parser.kind != jsonString: raiseParseErr(parser,"string")
  value = parser.str
  parser.next

proc dump*(v: string, s: JsonStream)=
  s.value(v)

proc isEmpty*(value: string): bool =  value.len == 0

proc load*(value: var int,parser: var JsonParser )=
  if parser.kind != jsonInt: raiseParseErr(parser,"int")
  value = int(parser.getInt)
  parser.next

proc dump*(v: int, s: JsonStream) = s.value(v)

proc isEmpty*(value: int): bool = value == 0

proc load*(value: var float,parser: var JsonParser )=
  if parser.kind != jsonFloat: raiseParseErr(parser,"float")
  value = parser.getFloat
  parser.next

proc dump*(v: float, s: JsonStream) = s.value(v)

proc isEmpty*(value: float): bool = value == 0.0

proc load*(value: var bool,parser: var JsonParser )=
  case parser.kind:
    of jsonTrue:
      value = true
    of jsonFalse:
      value = false
    else: raiseParseErr(parser,"true or false")
  parser.next

proc dump*(v: bool, s: JsonStream) = s.value(v)

proc isEmpty*(value: bool): bool = 
  value == false

proc load*(ios: var IntOrString,parser: var JsonParser )=
  case parser.kind:
    of jsonString:
      ios = IntOrString(kind:iosString,svalue:parser.str)
    of jsonInt:
      ios = IntOrString(kind:iosInt,ivalue:int(parser.getInt))
    else: raiseParseErr(parser,"string or int")
  parser.next

proc dump*(ios: IntOrString, s: JsonStream)=
  case ios.kind:
    of iosInt:
      s.value(ios.ivalue)
    of iosString:
      s.value(ios.svalue)

proc isEmpty*(ios: IntOrString): bool = 
  case ios.kind:
    of iosInt:
      false
    of iosString:
      ios.svalue.len == 0

proc load*(bytes: var ByteArray, parser: var JsonParser )=
  if parser.kind != jsonString: raiseParseErr(parser,"string")
  bytes = decode(parser.str).ByteArray
  parser.next

proc dump*(bytes:  ByteArray, s: JsonStream) = s.value(encode(string(bytes)))

proc isEmpty*(bytes: ByteArray): bool = string(bytes).len == 0


let nullDateTime = initDateTime(1,mJan,0,0,0,0,utc())

proc load*(time: var DateTime, parser: var JsonParser )=
  case parser.kind:
    of jsonString:
      time = parse(parser.str, """yyyy-MM-dd'T'HH:mm:ss'Z'""",utc())
    of jsonNull:
      time = nullDateTime
    else: raiseParseErr(parser,"string or null")
  parser.next

proc dump*(time: DateTime, s: JsonStream) = s.value(time.format("""yyyy-MM-dd'T'HH:mm:ss'Z'"""))

proc isEmpty*(time: DateTime): bool = time.year == 0


proc load*[T](table: var Table[string,T],parser: var JsonParser )=
  if parser.kind != jsonObjectStart: raiseParseErr(parser,"object start")
  parser.next
  while true:
    case parser.kind:
      of jsonObjectEnd:
        parser.next
        return
      of jsonString:
        let key = parser.str
        parser.next
        var item: T
        load(item, parser)
        table[key] = item
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*[T](table: Table[string,T], s: JsonStream)=
  s.objectStart()
  for key, value in table.pairs:
    if not value.isEmpty:
      s.name(key)
      value.dump(s)
  s.objectEnd()

proc isEmpty*[T](table: Table[string,T]): bool = table.len == 0

proc load*[T](sequence: var seq[T],parser: var JsonParser )=
  if parser.kind != jsonArrayStart: raiseParseErr(parser,"array start")
  parser.next
  while true:
    case parser.kind:
      of jsonArrayEnd:
        parser.next
        return
      else:
        var item: T
        load(item, parser)
        sequence.add(item)

proc dump*[T](sequence: seq[T], s: JsonStream)=
  s.arrayStart()
  for value in sequence:
    value.dump(s)
  s.arrayEnd()

proc isEmpty*[T](sequence: seq[T]): bool = sequence.len == 0
