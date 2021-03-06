import ../client
import ../base_types
import parsejson
import ../jsonwriter
import asyncdispatch
import tables
import times

type
  StatusCause* = object
    `field`*: string
    `message`*: string
    `reason`*: string

proc load*(self: var StatusCause, parser: var JsonParser) =
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
        case key:
          of "field":
            load(self.`field`,parser)
          of "message":
            load(self.`message`,parser)
          of "reason":
            load(self.`reason`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: StatusCause, s: JsonWriter) =
  s.objectStart()
  if not self.`field`.isEmpty:
    s.name("field")
    self.`field`.dump(s)
  if not self.`message`.isEmpty:
    s.name("message")
    self.`message`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  s.objectEnd()

proc isEmpty*(self: StatusCause): bool =
  if not self.`field`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  true

type
  StatusDetails* = object
    `uid`*: string
    `retryAfterSeconds`*: int
    `group`*: string
    `causes`*: seq[StatusCause]
    `name`*: string
    `kind`*: string

proc load*(self: var StatusDetails, parser: var JsonParser) =
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
        case key:
          of "uid":
            load(self.`uid`,parser)
          of "retryAfterSeconds":
            load(self.`retryAfterSeconds`,parser)
          of "group":
            load(self.`group`,parser)
          of "causes":
            load(self.`causes`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: StatusDetails, s: JsonWriter) =
  s.objectStart()
  if not self.`uid`.isEmpty:
    s.name("uid")
    self.`uid`.dump(s)
  if not self.`retryAfterSeconds`.isEmpty:
    s.name("retryAfterSeconds")
    self.`retryAfterSeconds`.dump(s)
  if not self.`group`.isEmpty:
    s.name("group")
    self.`group`.dump(s)
  if not self.`causes`.isEmpty:
    s.name("causes")
    self.`causes`.dump(s)
  if not self.`name`.isEmpty:
    s.name("name")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    s.name("kind")
    self.`kind`.dump(s)
  s.objectEnd()

proc isEmpty*(self: StatusDetails): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`retryAfterSeconds`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`causes`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

type
  Preconditions* = object
    `uid`*: string
    `resourceVersion`*: string

proc load*(self: var Preconditions, parser: var JsonParser) =
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
        case key:
          of "uid":
            load(self.`uid`,parser)
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Preconditions, s: JsonWriter) =
  s.objectStart()
  if not self.`uid`.isEmpty:
    s.name("uid")
    self.`uid`.dump(s)
  if not self.`resourceVersion`.isEmpty:
    s.name("resourceVersion")
    self.`resourceVersion`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Preconditions): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`resourceVersion`.isEmpty: return false
  true

type
  ServerAddressByClientCIDR_v2* = object
    `serverAddress`*: string
    `clientCIDR`*: string

proc load*(self: var ServerAddressByClientCIDR_v2, parser: var JsonParser) =
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
        case key:
          of "serverAddress":
            load(self.`serverAddress`,parser)
          of "clientCIDR":
            load(self.`clientCIDR`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ServerAddressByClientCIDR_v2, s: JsonWriter) =
  s.objectStart()
  s.name("serverAddress")
  self.`serverAddress`.dump(s)
  s.name("clientCIDR")
  self.`clientCIDR`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ServerAddressByClientCIDR_v2): bool =
  if not self.`serverAddress`.isEmpty: return false
  if not self.`clientCIDR`.isEmpty: return false
  true

type
  Patch_v2* = distinct string

proc load*(self: var Patch_v2, parser: var JsonParser) =
  load(string(self),parser)

proc dump*(self: Patch_v2, s: JsonWriter) =
  dump(string(self),s)

proc isEmpty*(self: Patch_v2): bool = string(self).isEmpty

type
  Initializer* = object
    `name`*: string

proc load*(self: var Initializer, parser: var JsonParser) =
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
        case key:
          of "name":
            load(self.`name`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Initializer, s: JsonWriter) =
  s.objectStart()
  s.name("name")
  self.`name`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Initializer): bool =
  if not self.`name`.isEmpty: return false
  true

type
  StatusCause_v2* = object
    `field`*: string
    `message`*: string
    `reason`*: string

proc load*(self: var StatusCause_v2, parser: var JsonParser) =
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
        case key:
          of "field":
            load(self.`field`,parser)
          of "message":
            load(self.`message`,parser)
          of "reason":
            load(self.`reason`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: StatusCause_v2, s: JsonWriter) =
  s.objectStart()
  if not self.`field`.isEmpty:
    s.name("field")
    self.`field`.dump(s)
  if not self.`message`.isEmpty:
    s.name("message")
    self.`message`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  s.objectEnd()

proc isEmpty*(self: StatusCause_v2): bool =
  if not self.`field`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  true

type
  StatusDetails_v2* = object
    `uid`*: string
    `retryAfterSeconds`*: int
    `group`*: string
    `causes`*: seq[StatusCause_v2]
    `name`*: string
    `kind`*: string

proc load*(self: var StatusDetails_v2, parser: var JsonParser) =
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
        case key:
          of "uid":
            load(self.`uid`,parser)
          of "retryAfterSeconds":
            load(self.`retryAfterSeconds`,parser)
          of "group":
            load(self.`group`,parser)
          of "causes":
            load(self.`causes`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: StatusDetails_v2, s: JsonWriter) =
  s.objectStart()
  if not self.`uid`.isEmpty:
    s.name("uid")
    self.`uid`.dump(s)
  if not self.`retryAfterSeconds`.isEmpty:
    s.name("retryAfterSeconds")
    self.`retryAfterSeconds`.dump(s)
  if not self.`group`.isEmpty:
    s.name("group")
    self.`group`.dump(s)
  if not self.`causes`.isEmpty:
    s.name("causes")
    self.`causes`.dump(s)
  if not self.`name`.isEmpty:
    s.name("name")
    self.`name`.dump(s)
  if not self.`kind`.isEmpty:
    s.name("kind")
    self.`kind`.dump(s)
  s.objectEnd()

proc isEmpty*(self: StatusDetails_v2): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`retryAfterSeconds`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`causes`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

type
  ListMeta_v2* = object
    `resourceVersion`*: string
    `selfLink`*: string
    `continue`*: string

proc load*(self: var ListMeta_v2, parser: var JsonParser) =
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
        case key:
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
          of "selfLink":
            load(self.`selfLink`,parser)
          of "continue":
            load(self.`continue`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ListMeta_v2, s: JsonWriter) =
  s.objectStart()
  if not self.`resourceVersion`.isEmpty:
    s.name("resourceVersion")
    self.`resourceVersion`.dump(s)
  if not self.`selfLink`.isEmpty:
    s.name("selfLink")
    self.`selfLink`.dump(s)
  if not self.`continue`.isEmpty:
    s.name("continue")
    self.`continue`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ListMeta_v2): bool =
  if not self.`resourceVersion`.isEmpty: return false
  if not self.`selfLink`.isEmpty: return false
  if not self.`continue`.isEmpty: return false
  true

type
  Status_v2* = object
    `code`*: int
    `apiVersion`*: string
    `message`*: string
    `details`*: StatusDetails_v2
    `reason`*: string
    `status`*: string
    `kind`*: string
    `metadata`*: ListMeta_v2

proc load*(self: var Status_v2, parser: var JsonParser) =
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
        case key:
          of "code":
            load(self.`code`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "message":
            load(self.`message`,parser)
          of "details":
            load(self.`details`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "status":
            load(self.`status`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Status_v2, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("v1")
  s.name("kind"); s.value("Status_v2")
  if not self.`code`.isEmpty:
    s.name("code")
    self.`code`.dump(s)
  if not self.`message`.isEmpty:
    s.name("message")
    self.`message`.dump(s)
  if not self.`details`.isEmpty:
    s.name("details")
    self.`details`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  if not self.`status`.isEmpty:
    s.name("status")
    self.`status`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Status_v2): bool =
  if not self.`code`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`details`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[Status_v2], name: string, namespace = "default"): Future[Status_v2] {.async.}=
  return await client.get("/api/v1", t, name, namespace)

proc create*(client: Client, t: Status_v2, namespace = "default"): Future[Status_v2] {.async.}=
  return await client.create("/api/v1", t, namespace)

proc delete*(client: Client, t: typedesc[Status_v2], name: string, namespace = "default") {.async.}=
  await client.delete("/api/v1", t, name, namespace)

type
  Initializers* = object
    `pending`*: seq[Initializer]
    `result`*: Status_v2

proc load*(self: var Initializers, parser: var JsonParser) =
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
        case key:
          of "pending":
            load(self.`pending`,parser)
          of "result":
            load(self.`result`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Initializers, s: JsonWriter) =
  s.objectStart()
  s.name("pending")
  self.`pending`.dump(s)
  if not self.`result`.isEmpty:
    s.name("result")
    self.`result`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Initializers): bool =
  if not self.`pending`.isEmpty: return false
  if not self.`result`.isEmpty: return false
  true

type
  APIResource* = object
    `version`*: string
    `singularName`*: string
    `shortNames`*: seq[string]
    `categories`*: seq[string]
    `group`*: string
    `namespaced`*: bool
    `name`*: string
    `verbs`*: seq[string]
    `kind`*: string
    `storageVersionHash`*: string

proc load*(self: var APIResource, parser: var JsonParser) =
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
        case key:
          of "version":
            load(self.`version`,parser)
          of "singularName":
            load(self.`singularName`,parser)
          of "shortNames":
            load(self.`shortNames`,parser)
          of "categories":
            load(self.`categories`,parser)
          of "group":
            load(self.`group`,parser)
          of "namespaced":
            load(self.`namespaced`,parser)
          of "name":
            load(self.`name`,parser)
          of "verbs":
            load(self.`verbs`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "storageVersionHash":
            load(self.`storageVersionHash`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: APIResource, s: JsonWriter) =
  s.objectStart()
  if not self.`version`.isEmpty:
    s.name("version")
    self.`version`.dump(s)
  s.name("singularName")
  self.`singularName`.dump(s)
  if not self.`shortNames`.isEmpty:
    s.name("shortNames")
    self.`shortNames`.dump(s)
  if not self.`categories`.isEmpty:
    s.name("categories")
    self.`categories`.dump(s)
  if not self.`group`.isEmpty:
    s.name("group")
    self.`group`.dump(s)
  s.name("namespaced")
  self.`namespaced`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  s.name("verbs")
  self.`verbs`.dump(s)
  s.name("kind")
  self.`kind`.dump(s)
  if not self.`storageVersionHash`.isEmpty:
    s.name("storageVersionHash")
    self.`storageVersionHash`.dump(s)
  s.objectEnd()

proc isEmpty*(self: APIResource): bool =
  if not self.`version`.isEmpty: return false
  if not self.`singularName`.isEmpty: return false
  if not self.`shortNames`.isEmpty: return false
  if not self.`categories`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`namespaced`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`verbs`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`storageVersionHash`.isEmpty: return false
  true

type
  ListMeta* = object
    `remainingItemCount`*: int
    `resourceVersion`*: string
    `selfLink`*: string
    `continue`*: string

proc load*(self: var ListMeta, parser: var JsonParser) =
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
        case key:
          of "remainingItemCount":
            load(self.`remainingItemCount`,parser)
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
          of "selfLink":
            load(self.`selfLink`,parser)
          of "continue":
            load(self.`continue`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ListMeta, s: JsonWriter) =
  s.objectStart()
  if not self.`remainingItemCount`.isEmpty:
    s.name("remainingItemCount")
    self.`remainingItemCount`.dump(s)
  if not self.`resourceVersion`.isEmpty:
    s.name("resourceVersion")
    self.`resourceVersion`.dump(s)
  if not self.`selfLink`.isEmpty:
    s.name("selfLink")
    self.`selfLink`.dump(s)
  if not self.`continue`.isEmpty:
    s.name("continue")
    self.`continue`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ListMeta): bool =
  if not self.`remainingItemCount`.isEmpty: return false
  if not self.`resourceVersion`.isEmpty: return false
  if not self.`selfLink`.isEmpty: return false
  if not self.`continue`.isEmpty: return false
  true

type
  FieldsV1* = distinct Table[string,string]

proc load*(self: var FieldsV1, parser: var JsonParser) =
  load(Table[string,string](self),parser)

proc dump*(self: FieldsV1, s: JsonWriter) =
  dump(Table[string,string](self),s)

proc isEmpty*(self: FieldsV1): bool = Table[string,string](self).isEmpty

type
  MicroTime* = distinct DateTime

proc load*(self: var MicroTime, parser: var JsonParser) =
  load(DateTime(self),parser)

proc dump*(self: MicroTime, s: JsonWriter) =
  dump(DateTime(self),s)

proc isEmpty*(self: MicroTime): bool = DateTime(self).isEmpty

type
  Time* = distinct DateTime

proc load*(self: var Time, parser: var JsonParser) =
  load(DateTime(self),parser)

proc dump*(self: Time, s: JsonWriter) =
  dump(DateTime(self),s)

proc isEmpty*(self: Time): bool = DateTime(self).isEmpty

type
  GroupVersionForDiscovery_v2* = object
    `version`*: string
    `groupVersion`*: string

proc load*(self: var GroupVersionForDiscovery_v2, parser: var JsonParser) =
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
        case key:
          of "version":
            load(self.`version`,parser)
          of "groupVersion":
            load(self.`groupVersion`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: GroupVersionForDiscovery_v2, s: JsonWriter) =
  s.objectStart()
  s.name("version")
  self.`version`.dump(s)
  s.name("groupVersion")
  self.`groupVersion`.dump(s)
  s.objectEnd()

proc isEmpty*(self: GroupVersionForDiscovery_v2): bool =
  if not self.`version`.isEmpty: return false
  if not self.`groupVersion`.isEmpty: return false
  true

type
  OwnerReference_v2* = object
    `uid`*: string
    `controller`*: bool
    `apiVersion`*: string
    `blockOwnerDeletion`*: bool
    `name`*: string
    `kind`*: string

proc load*(self: var OwnerReference_v2, parser: var JsonParser) =
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
        case key:
          of "uid":
            load(self.`uid`,parser)
          of "controller":
            load(self.`controller`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "blockOwnerDeletion":
            load(self.`blockOwnerDeletion`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: OwnerReference_v2, s: JsonWriter) =
  s.objectStart()
  s.name("uid")
  self.`uid`.dump(s)
  if not self.`controller`.isEmpty:
    s.name("controller")
    self.`controller`.dump(s)
  s.name("apiVersion")
  self.`apiVersion`.dump(s)
  if not self.`blockOwnerDeletion`.isEmpty:
    s.name("blockOwnerDeletion")
    self.`blockOwnerDeletion`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  s.name("kind")
  self.`kind`.dump(s)
  s.objectEnd()

proc isEmpty*(self: OwnerReference_v2): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`controller`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`blockOwnerDeletion`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

type
  ObjectMeta_v2* = object
    `uid`*: string
    `generateName`*: string
    `finalizers`*: seq[string]
    `deletionGracePeriodSeconds`*: int
    `creationTimestamp`*: Time
    `annotations`*: Table[string,string]
    `generation`*: int
    `labels`*: Table[string,string]
    `resourceVersion`*: string
    `selfLink`*: string
    `initializers`*: Initializers
    `clusterName`*: string
    `namespace`*: string
    `ownerReferences`*: seq[OwnerReference_v2]
    `name`*: string
    `deletionTimestamp`*: Time

proc load*(self: var ObjectMeta_v2, parser: var JsonParser) =
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
        case key:
          of "uid":
            load(self.`uid`,parser)
          of "generateName":
            load(self.`generateName`,parser)
          of "finalizers":
            load(self.`finalizers`,parser)
          of "deletionGracePeriodSeconds":
            load(self.`deletionGracePeriodSeconds`,parser)
          of "creationTimestamp":
            load(self.`creationTimestamp`,parser)
          of "annotations":
            load(self.`annotations`,parser)
          of "generation":
            load(self.`generation`,parser)
          of "labels":
            load(self.`labels`,parser)
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
          of "selfLink":
            load(self.`selfLink`,parser)
          of "initializers":
            load(self.`initializers`,parser)
          of "clusterName":
            load(self.`clusterName`,parser)
          of "namespace":
            load(self.`namespace`,parser)
          of "ownerReferences":
            load(self.`ownerReferences`,parser)
          of "name":
            load(self.`name`,parser)
          of "deletionTimestamp":
            load(self.`deletionTimestamp`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ObjectMeta_v2, s: JsonWriter) =
  s.objectStart()
  if not self.`uid`.isEmpty:
    s.name("uid")
    self.`uid`.dump(s)
  if not self.`generateName`.isEmpty:
    s.name("generateName")
    self.`generateName`.dump(s)
  if not self.`finalizers`.isEmpty:
    s.name("finalizers")
    self.`finalizers`.dump(s)
  if not self.`deletionGracePeriodSeconds`.isEmpty:
    s.name("deletionGracePeriodSeconds")
    self.`deletionGracePeriodSeconds`.dump(s)
  if not self.`creationTimestamp`.isEmpty:
    s.name("creationTimestamp")
    self.`creationTimestamp`.dump(s)
  if not self.`annotations`.isEmpty:
    s.name("annotations")
    self.`annotations`.dump(s)
  if not self.`generation`.isEmpty:
    s.name("generation")
    self.`generation`.dump(s)
  if not self.`labels`.isEmpty:
    s.name("labels")
    self.`labels`.dump(s)
  if not self.`resourceVersion`.isEmpty:
    s.name("resourceVersion")
    self.`resourceVersion`.dump(s)
  if not self.`selfLink`.isEmpty:
    s.name("selfLink")
    self.`selfLink`.dump(s)
  if not self.`initializers`.isEmpty:
    s.name("initializers")
    self.`initializers`.dump(s)
  if not self.`clusterName`.isEmpty:
    s.name("clusterName")
    self.`clusterName`.dump(s)
  if not self.`namespace`.isEmpty:
    s.name("namespace")
    self.`namespace`.dump(s)
  if not self.`ownerReferences`.isEmpty:
    s.name("ownerReferences")
    self.`ownerReferences`.dump(s)
  if not self.`name`.isEmpty:
    s.name("name")
    self.`name`.dump(s)
  if not self.`deletionTimestamp`.isEmpty:
    s.name("deletionTimestamp")
    self.`deletionTimestamp`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ObjectMeta_v2): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`generateName`.isEmpty: return false
  if not self.`finalizers`.isEmpty: return false
  if not self.`deletionGracePeriodSeconds`.isEmpty: return false
  if not self.`creationTimestamp`.isEmpty: return false
  if not self.`annotations`.isEmpty: return false
  if not self.`generation`.isEmpty: return false
  if not self.`labels`.isEmpty: return false
  if not self.`resourceVersion`.isEmpty: return false
  if not self.`selfLink`.isEmpty: return false
  if not self.`initializers`.isEmpty: return false
  if not self.`clusterName`.isEmpty: return false
  if not self.`namespace`.isEmpty: return false
  if not self.`ownerReferences`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`deletionTimestamp`.isEmpty: return false
  true

type
  OwnerReference* = object
    `uid`*: string
    `controller`*: bool
    `apiVersion`*: string
    `blockOwnerDeletion`*: bool
    `name`*: string
    `kind`*: string

proc load*(self: var OwnerReference, parser: var JsonParser) =
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
        case key:
          of "uid":
            load(self.`uid`,parser)
          of "controller":
            load(self.`controller`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "blockOwnerDeletion":
            load(self.`blockOwnerDeletion`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: OwnerReference, s: JsonWriter) =
  s.objectStart()
  s.name("uid")
  self.`uid`.dump(s)
  if not self.`controller`.isEmpty:
    s.name("controller")
    self.`controller`.dump(s)
  s.name("apiVersion")
  self.`apiVersion`.dump(s)
  if not self.`blockOwnerDeletion`.isEmpty:
    s.name("blockOwnerDeletion")
    self.`blockOwnerDeletion`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  s.name("kind")
  self.`kind`.dump(s)
  s.objectEnd()

proc isEmpty*(self: OwnerReference): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`controller`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`blockOwnerDeletion`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

type
  WatchEvent_v2* = WatchEv

type
  APIResourceList* = object
    `apiVersion`*: string
    `groupVersion`*: string
    `resources`*: seq[APIResource]
    `kind`*: string

proc load*(self: var APIResourceList, parser: var JsonParser) =
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
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "groupVersion":
            load(self.`groupVersion`,parser)
          of "resources":
            load(self.`resources`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: APIResourceList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("v1")
  s.name("kind"); s.value("APIResourceList")
  s.name("groupVersion")
  self.`groupVersion`.dump(s)
  s.name("resources")
  self.`resources`.dump(s)
  s.objectEnd()

proc isEmpty*(self: APIResourceList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`groupVersion`.isEmpty: return false
  if not self.`resources`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true


proc list*(client: Client, t: typedesc[APIResource], namespace = "default"): Future[seq[APIResource]] {.async.}=
  return (await client.list("/api/v1", APIResourceList, namespace)).items

type
  Preconditions_v2* = object
    `uid`*: string

proc load*(self: var Preconditions_v2, parser: var JsonParser) =
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
        case key:
          of "uid":
            load(self.`uid`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Preconditions_v2, s: JsonWriter) =
  s.objectStart()
  if not self.`uid`.isEmpty:
    s.name("uid")
    self.`uid`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Preconditions_v2): bool =
  if not self.`uid`.isEmpty: return false
  true

type
  ServerAddressByClientCIDR* = object
    `serverAddress`*: string
    `clientCIDR`*: string

proc load*(self: var ServerAddressByClientCIDR, parser: var JsonParser) =
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
        case key:
          of "serverAddress":
            load(self.`serverAddress`,parser)
          of "clientCIDR":
            load(self.`clientCIDR`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ServerAddressByClientCIDR, s: JsonWriter) =
  s.objectStart()
  s.name("serverAddress")
  self.`serverAddress`.dump(s)
  s.name("clientCIDR")
  self.`clientCIDR`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ServerAddressByClientCIDR): bool =
  if not self.`serverAddress`.isEmpty: return false
  if not self.`clientCIDR`.isEmpty: return false
  true

type
  GroupVersionForDiscovery* = object
    `version`*: string
    `groupVersion`*: string

proc load*(self: var GroupVersionForDiscovery, parser: var JsonParser) =
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
        case key:
          of "version":
            load(self.`version`,parser)
          of "groupVersion":
            load(self.`groupVersion`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: GroupVersionForDiscovery, s: JsonWriter) =
  s.objectStart()
  s.name("version")
  self.`version`.dump(s)
  s.name("groupVersion")
  self.`groupVersion`.dump(s)
  s.objectEnd()

proc isEmpty*(self: GroupVersionForDiscovery): bool =
  if not self.`version`.isEmpty: return false
  if not self.`groupVersion`.isEmpty: return false
  true

type
  APIGroup* = object
    `apiVersion`*: string
    `serverAddressByClientCIDRs`*: seq[ServerAddressByClientCIDR]
    `versions`*: seq[GroupVersionForDiscovery]
    `name`*: string
    `kind`*: string
    `preferredVersion`*: GroupVersionForDiscovery

proc load*(self: var APIGroup, parser: var JsonParser) =
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
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "serverAddressByClientCIDRs":
            load(self.`serverAddressByClientCIDRs`,parser)
          of "versions":
            load(self.`versions`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "preferredVersion":
            load(self.`preferredVersion`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: APIGroup, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("v1")
  s.name("kind"); s.value("APIGroup")
  if not self.`serverAddressByClientCIDRs`.isEmpty:
    s.name("serverAddressByClientCIDRs")
    self.`serverAddressByClientCIDRs`.dump(s)
  s.name("versions")
  self.`versions`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  if not self.`preferredVersion`.isEmpty:
    s.name("preferredVersion")
    self.`preferredVersion`.dump(s)
  s.objectEnd()

proc isEmpty*(self: APIGroup): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`serverAddressByClientCIDRs`.isEmpty: return false
  if not self.`versions`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`preferredVersion`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[APIGroup], name: string, namespace = "default"): Future[APIGroup] {.async.}=
  return await client.get("/api/v1", t, name, namespace)

proc create*(client: Client, t: APIGroup, namespace = "default"): Future[APIGroup] {.async.}=
  return await client.create("/api/v1", t, namespace)

proc delete*(client: Client, t: typedesc[APIGroup], name: string, namespace = "default") {.async.}=
  await client.delete("/api/v1", t, name, namespace)

type
  APIGroupList* = object
    `apiVersion`*: string
    `groups`*: seq[APIGroup]
    `kind`*: string

proc load*(self: var APIGroupList, parser: var JsonParser) =
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
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "groups":
            load(self.`groups`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: APIGroupList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("v1")
  s.name("kind"); s.value("APIGroupList")
  s.name("groups")
  self.`groups`.dump(s)
  s.objectEnd()

proc isEmpty*(self: APIGroupList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`groups`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true


proc list*(client: Client, t: typedesc[APIGroup], namespace = "default"): Future[seq[APIGroup]] {.async.}=
  return (await client.list("/api/v1", APIGroupList, namespace)).items

type
  WatchEvent* = WatchEv

type
  LabelSelectorRequirement* = object
    `key`*: string
    `values`*: seq[string]
    `operator`*: string

proc load*(self: var LabelSelectorRequirement, parser: var JsonParser) =
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
        case key:
          of "key":
            load(self.`key`,parser)
          of "values":
            load(self.`values`,parser)
          of "operator":
            load(self.`operator`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: LabelSelectorRequirement, s: JsonWriter) =
  s.objectStart()
  s.name("key")
  self.`key`.dump(s)
  if not self.`values`.isEmpty:
    s.name("values")
    self.`values`.dump(s)
  s.name("operator")
  self.`operator`.dump(s)
  s.objectEnd()

proc isEmpty*(self: LabelSelectorRequirement): bool =
  if not self.`key`.isEmpty: return false
  if not self.`values`.isEmpty: return false
  if not self.`operator`.isEmpty: return false
  true

type
  LabelSelector* = object
    `matchLabels`*: Table[string,string]
    `matchExpressions`*: seq[LabelSelectorRequirement]

proc load*(self: var LabelSelector, parser: var JsonParser) =
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
        case key:
          of "matchLabels":
            load(self.`matchLabels`,parser)
          of "matchExpressions":
            load(self.`matchExpressions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: LabelSelector, s: JsonWriter) =
  s.objectStart()
  if not self.`matchLabels`.isEmpty:
    s.name("matchLabels")
    self.`matchLabels`.dump(s)
  if not self.`matchExpressions`.isEmpty:
    s.name("matchExpressions")
    self.`matchExpressions`.dump(s)
  s.objectEnd()

proc isEmpty*(self: LabelSelector): bool =
  if not self.`matchLabels`.isEmpty: return false
  if not self.`matchExpressions`.isEmpty: return false
  true

type
  APIResource_v2* = object
    `version`*: string
    `singularName`*: string
    `shortNames`*: seq[string]
    `categories`*: seq[string]
    `group`*: string
    `namespaced`*: bool
    `name`*: string
    `verbs`*: seq[string]
    `kind`*: string

proc load*(self: var APIResource_v2, parser: var JsonParser) =
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
        case key:
          of "version":
            load(self.`version`,parser)
          of "singularName":
            load(self.`singularName`,parser)
          of "shortNames":
            load(self.`shortNames`,parser)
          of "categories":
            load(self.`categories`,parser)
          of "group":
            load(self.`group`,parser)
          of "namespaced":
            load(self.`namespaced`,parser)
          of "name":
            load(self.`name`,parser)
          of "verbs":
            load(self.`verbs`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: APIResource_v2, s: JsonWriter) =
  s.objectStart()
  if not self.`version`.isEmpty:
    s.name("version")
    self.`version`.dump(s)
  s.name("singularName")
  self.`singularName`.dump(s)
  if not self.`shortNames`.isEmpty:
    s.name("shortNames")
    self.`shortNames`.dump(s)
  if not self.`categories`.isEmpty:
    s.name("categories")
    self.`categories`.dump(s)
  if not self.`group`.isEmpty:
    s.name("group")
    self.`group`.dump(s)
  s.name("namespaced")
  self.`namespaced`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  s.name("verbs")
  self.`verbs`.dump(s)
  s.name("kind")
  self.`kind`.dump(s)
  s.objectEnd()

proc isEmpty*(self: APIResource_v2): bool =
  if not self.`version`.isEmpty: return false
  if not self.`singularName`.isEmpty: return false
  if not self.`shortNames`.isEmpty: return false
  if not self.`categories`.isEmpty: return false
  if not self.`group`.isEmpty: return false
  if not self.`namespaced`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`verbs`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true

type
  APIResourceList_v2* = object
    `apiVersion`*: string
    `groupVersion`*: string
    `resources`*: seq[APIResource_v2]
    `kind`*: string

proc load*(self: var APIResourceList_v2, parser: var JsonParser) =
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
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "groupVersion":
            load(self.`groupVersion`,parser)
          of "resources":
            load(self.`resources`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: APIResourceList_v2, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("v1")
  s.name("kind"); s.value("APIResourceList_v2")
  s.name("groupVersion")
  self.`groupVersion`.dump(s)
  s.name("resources")
  self.`resources`.dump(s)
  s.objectEnd()

proc isEmpty*(self: APIResourceList_v2): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`groupVersion`.isEmpty: return false
  if not self.`resources`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[APIResourceList_v2], name: string, namespace = "default"): Future[APIResourceList_v2] {.async.}=
  return await client.get("/api/v1", t, name, namespace)

proc create*(client: Client, t: APIResourceList_v2, namespace = "default"): Future[APIResourceList_v2] {.async.}=
  return await client.create("/api/v1", t, namespace)

proc delete*(client: Client, t: typedesc[APIResourceList_v2], name: string, namespace = "default") {.async.}=
  await client.delete("/api/v1", t, name, namespace)

type
  APIVersions* = object
    `apiVersion`*: string
    `serverAddressByClientCIDRs`*: seq[ServerAddressByClientCIDR]
    `versions`*: seq[string]
    `kind`*: string

proc load*(self: var APIVersions, parser: var JsonParser) =
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
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "serverAddressByClientCIDRs":
            load(self.`serverAddressByClientCIDRs`,parser)
          of "versions":
            load(self.`versions`,parser)
          of "kind":
            load(self.`kind`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: APIVersions, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("v1")
  s.name("kind"); s.value("APIVersions")
  s.name("serverAddressByClientCIDRs")
  self.`serverAddressByClientCIDRs`.dump(s)
  s.name("versions")
  self.`versions`.dump(s)
  s.objectEnd()

proc isEmpty*(self: APIVersions): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`serverAddressByClientCIDRs`.isEmpty: return false
  if not self.`versions`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[APIVersions], name: string, namespace = "default"): Future[APIVersions] {.async.}=
  return await client.get("/api/v1", t, name, namespace)

proc create*(client: Client, t: APIVersions, namespace = "default"): Future[APIVersions] {.async.}=
  return await client.create("/api/v1", t, namespace)

proc delete*(client: Client, t: typedesc[APIVersions], name: string, namespace = "default") {.async.}=
  await client.delete("/api/v1", t, name, namespace)

type
  Patch* = distinct Table[string,string]

proc load*(self: var Patch, parser: var JsonParser) =
  load(Table[string,string](self),parser)

proc dump*(self: Patch, s: JsonWriter) =
  dump(Table[string,string](self),s)

proc isEmpty*(self: Patch): bool = Table[string,string](self).isEmpty

type
  APIGroup_v2* = object
    `apiVersion`*: string
    `serverAddressByClientCIDRs`*: seq[ServerAddressByClientCIDR_v2]
    `versions`*: seq[GroupVersionForDiscovery_v2]
    `name`*: string
    `kind`*: string
    `preferredVersion`*: GroupVersionForDiscovery_v2

proc load*(self: var APIGroup_v2, parser: var JsonParser) =
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
        case key:
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "serverAddressByClientCIDRs":
            load(self.`serverAddressByClientCIDRs`,parser)
          of "versions":
            load(self.`versions`,parser)
          of "name":
            load(self.`name`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "preferredVersion":
            load(self.`preferredVersion`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: APIGroup_v2, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("v1")
  s.name("kind"); s.value("APIGroup_v2")
  if not self.`serverAddressByClientCIDRs`.isEmpty:
    s.name("serverAddressByClientCIDRs")
    self.`serverAddressByClientCIDRs`.dump(s)
  s.name("versions")
  self.`versions`.dump(s)
  s.name("name")
  self.`name`.dump(s)
  if not self.`preferredVersion`.isEmpty:
    s.name("preferredVersion")
    self.`preferredVersion`.dump(s)
  s.objectEnd()

proc isEmpty*(self: APIGroup_v2): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`serverAddressByClientCIDRs`.isEmpty: return false
  if not self.`versions`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`preferredVersion`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[APIGroup_v2], name: string, namespace = "default"): Future[APIGroup_v2] {.async.}=
  return await client.get("/api/v1", t, name, namespace)

proc create*(client: Client, t: APIGroup_v2, namespace = "default"): Future[APIGroup_v2] {.async.}=
  return await client.create("/api/v1", t, namespace)

proc delete*(client: Client, t: typedesc[APIGroup_v2], name: string, namespace = "default") {.async.}=
  await client.delete("/api/v1", t, name, namespace)

type
  ManagedFieldsEntry* = object
    `fieldsType`*: string
    `apiVersion`*: string
    `operation`*: string
    `fieldsV1`*: FieldsV1
    `time`*: Time
    `manager`*: string

proc load*(self: var ManagedFieldsEntry, parser: var JsonParser) =
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
        case key:
          of "fieldsType":
            load(self.`fieldsType`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "operation":
            load(self.`operation`,parser)
          of "fieldsV1":
            load(self.`fieldsV1`,parser)
          of "time":
            load(self.`time`,parser)
          of "manager":
            load(self.`manager`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ManagedFieldsEntry, s: JsonWriter) =
  s.objectStart()
  if not self.`fieldsType`.isEmpty:
    s.name("fieldsType")
    self.`fieldsType`.dump(s)
  if not self.`apiVersion`.isEmpty:
    s.name("apiVersion")
    self.`apiVersion`.dump(s)
  if not self.`operation`.isEmpty:
    s.name("operation")
    self.`operation`.dump(s)
  if not self.`fieldsV1`.isEmpty:
    s.name("fieldsV1")
    self.`fieldsV1`.dump(s)
  if not self.`time`.isEmpty:
    s.name("time")
    self.`time`.dump(s)
  if not self.`manager`.isEmpty:
    s.name("manager")
    self.`manager`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ManagedFieldsEntry): bool =
  if not self.`fieldsType`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`operation`.isEmpty: return false
  if not self.`fieldsV1`.isEmpty: return false
  if not self.`time`.isEmpty: return false
  if not self.`manager`.isEmpty: return false
  true

type
  DeleteOptions* = object
    `orphanDependents`*: bool
    `apiVersion`*: string
    `propagationPolicy`*: string
    `gracePeriodSeconds`*: int
    `dryRun`*: seq[string]
    `kind`*: string
    `preconditions`*: Preconditions

proc load*(self: var DeleteOptions, parser: var JsonParser) =
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
        case key:
          of "orphanDependents":
            load(self.`orphanDependents`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "propagationPolicy":
            load(self.`propagationPolicy`,parser)
          of "gracePeriodSeconds":
            load(self.`gracePeriodSeconds`,parser)
          of "dryRun":
            load(self.`dryRun`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "preconditions":
            load(self.`preconditions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: DeleteOptions, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("v1")
  s.name("kind"); s.value("DeleteOptions")
  if not self.`orphanDependents`.isEmpty:
    s.name("orphanDependents")
    self.`orphanDependents`.dump(s)
  if not self.`propagationPolicy`.isEmpty:
    s.name("propagationPolicy")
    self.`propagationPolicy`.dump(s)
  if not self.`gracePeriodSeconds`.isEmpty:
    s.name("gracePeriodSeconds")
    self.`gracePeriodSeconds`.dump(s)
  if not self.`dryRun`.isEmpty:
    s.name("dryRun")
    self.`dryRun`.dump(s)
  if not self.`preconditions`.isEmpty:
    s.name("preconditions")
    self.`preconditions`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DeleteOptions): bool =
  if not self.`orphanDependents`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`propagationPolicy`.isEmpty: return false
  if not self.`gracePeriodSeconds`.isEmpty: return false
  if not self.`dryRun`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`preconditions`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[DeleteOptions], name: string, namespace = "default"): Future[DeleteOptions] {.async.}=
  return await client.get("/api/v1", t, name, namespace)

proc create*(client: Client, t: DeleteOptions, namespace = "default"): Future[DeleteOptions] {.async.}=
  return await client.create("/api/v1", t, namespace)

proc delete*(client: Client, t: typedesc[DeleteOptions], name: string, namespace = "default") {.async.}=
  await client.delete("/api/v1", t, name, namespace)

type
  ObjectMeta* = object
    `uid`*: string
    `generateName`*: string
    `finalizers`*: seq[string]
    `deletionGracePeriodSeconds`*: int
    `creationTimestamp`*: Time
    `annotations`*: Table[string,string]
    `generation`*: int
    `labels`*: Table[string,string]
    `managedFields`*: seq[ManagedFieldsEntry]
    `resourceVersion`*: string
    `selfLink`*: string
    `clusterName`*: string
    `namespace`*: string
    `ownerReferences`*: seq[OwnerReference]
    `name`*: string
    `deletionTimestamp`*: Time

proc load*(self: var ObjectMeta, parser: var JsonParser) =
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
        case key:
          of "uid":
            load(self.`uid`,parser)
          of "generateName":
            load(self.`generateName`,parser)
          of "finalizers":
            load(self.`finalizers`,parser)
          of "deletionGracePeriodSeconds":
            load(self.`deletionGracePeriodSeconds`,parser)
          of "creationTimestamp":
            load(self.`creationTimestamp`,parser)
          of "annotations":
            load(self.`annotations`,parser)
          of "generation":
            load(self.`generation`,parser)
          of "labels":
            load(self.`labels`,parser)
          of "managedFields":
            load(self.`managedFields`,parser)
          of "resourceVersion":
            load(self.`resourceVersion`,parser)
          of "selfLink":
            load(self.`selfLink`,parser)
          of "clusterName":
            load(self.`clusterName`,parser)
          of "namespace":
            load(self.`namespace`,parser)
          of "ownerReferences":
            load(self.`ownerReferences`,parser)
          of "name":
            load(self.`name`,parser)
          of "deletionTimestamp":
            load(self.`deletionTimestamp`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: ObjectMeta, s: JsonWriter) =
  s.objectStart()
  if not self.`uid`.isEmpty:
    s.name("uid")
    self.`uid`.dump(s)
  if not self.`generateName`.isEmpty:
    s.name("generateName")
    self.`generateName`.dump(s)
  if not self.`finalizers`.isEmpty:
    s.name("finalizers")
    self.`finalizers`.dump(s)
  if not self.`deletionGracePeriodSeconds`.isEmpty:
    s.name("deletionGracePeriodSeconds")
    self.`deletionGracePeriodSeconds`.dump(s)
  if not self.`creationTimestamp`.isEmpty:
    s.name("creationTimestamp")
    self.`creationTimestamp`.dump(s)
  if not self.`annotations`.isEmpty:
    s.name("annotations")
    self.`annotations`.dump(s)
  if not self.`generation`.isEmpty:
    s.name("generation")
    self.`generation`.dump(s)
  if not self.`labels`.isEmpty:
    s.name("labels")
    self.`labels`.dump(s)
  if not self.`managedFields`.isEmpty:
    s.name("managedFields")
    self.`managedFields`.dump(s)
  if not self.`resourceVersion`.isEmpty:
    s.name("resourceVersion")
    self.`resourceVersion`.dump(s)
  if not self.`selfLink`.isEmpty:
    s.name("selfLink")
    self.`selfLink`.dump(s)
  if not self.`clusterName`.isEmpty:
    s.name("clusterName")
    self.`clusterName`.dump(s)
  if not self.`namespace`.isEmpty:
    s.name("namespace")
    self.`namespace`.dump(s)
  if not self.`ownerReferences`.isEmpty:
    s.name("ownerReferences")
    self.`ownerReferences`.dump(s)
  if not self.`name`.isEmpty:
    s.name("name")
    self.`name`.dump(s)
  if not self.`deletionTimestamp`.isEmpty:
    s.name("deletionTimestamp")
    self.`deletionTimestamp`.dump(s)
  s.objectEnd()

proc isEmpty*(self: ObjectMeta): bool =
  if not self.`uid`.isEmpty: return false
  if not self.`generateName`.isEmpty: return false
  if not self.`finalizers`.isEmpty: return false
  if not self.`deletionGracePeriodSeconds`.isEmpty: return false
  if not self.`creationTimestamp`.isEmpty: return false
  if not self.`annotations`.isEmpty: return false
  if not self.`generation`.isEmpty: return false
  if not self.`labels`.isEmpty: return false
  if not self.`managedFields`.isEmpty: return false
  if not self.`resourceVersion`.isEmpty: return false
  if not self.`selfLink`.isEmpty: return false
  if not self.`clusterName`.isEmpty: return false
  if not self.`namespace`.isEmpty: return false
  if not self.`ownerReferences`.isEmpty: return false
  if not self.`name`.isEmpty: return false
  if not self.`deletionTimestamp`.isEmpty: return false
  true

type
  DeleteOptions_v2* = object
    `orphanDependents`*: bool
    `apiVersion`*: string
    `propagationPolicy`*: string
    `gracePeriodSeconds`*: int
    `kind`*: string
    `preconditions`*: Preconditions_v2

proc load*(self: var DeleteOptions_v2, parser: var JsonParser) =
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
        case key:
          of "orphanDependents":
            load(self.`orphanDependents`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "propagationPolicy":
            load(self.`propagationPolicy`,parser)
          of "gracePeriodSeconds":
            load(self.`gracePeriodSeconds`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "preconditions":
            load(self.`preconditions`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: DeleteOptions_v2, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("v1")
  s.name("kind"); s.value("DeleteOptions_v2")
  if not self.`orphanDependents`.isEmpty:
    s.name("orphanDependents")
    self.`orphanDependents`.dump(s)
  if not self.`propagationPolicy`.isEmpty:
    s.name("propagationPolicy")
    self.`propagationPolicy`.dump(s)
  if not self.`gracePeriodSeconds`.isEmpty:
    s.name("gracePeriodSeconds")
    self.`gracePeriodSeconds`.dump(s)
  if not self.`preconditions`.isEmpty:
    s.name("preconditions")
    self.`preconditions`.dump(s)
  s.objectEnd()

proc isEmpty*(self: DeleteOptions_v2): bool =
  if not self.`orphanDependents`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`propagationPolicy`.isEmpty: return false
  if not self.`gracePeriodSeconds`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`preconditions`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[DeleteOptions_v2], name: string, namespace = "default"): Future[DeleteOptions_v2] {.async.}=
  return await client.get("/api/v1", t, name, namespace)

proc create*(client: Client, t: DeleteOptions_v2, namespace = "default"): Future[DeleteOptions_v2] {.async.}=
  return await client.create("/api/v1", t, namespace)

proc delete*(client: Client, t: typedesc[DeleteOptions_v2], name: string, namespace = "default") {.async.}=
  await client.delete("/api/v1", t, name, namespace)

type
  Status* = object
    `code`*: int
    `apiVersion`*: string
    `message`*: string
    `details`*: StatusDetails
    `reason`*: string
    `status`*: string
    `kind`*: string
    `metadata`*: ListMeta

proc load*(self: var Status, parser: var JsonParser) =
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
        case key:
          of "code":
            load(self.`code`,parser)
          of "apiVersion":
            load(self.`apiVersion`,parser)
          of "message":
            load(self.`message`,parser)
          of "details":
            load(self.`details`,parser)
          of "reason":
            load(self.`reason`,parser)
          of "status":
            load(self.`status`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Status, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("v1")
  s.name("kind"); s.value("Status")
  if not self.`code`.isEmpty:
    s.name("code")
    self.`code`.dump(s)
  if not self.`message`.isEmpty:
    s.name("message")
    self.`message`.dump(s)
  if not self.`details`.isEmpty:
    s.name("details")
    self.`details`.dump(s)
  if not self.`reason`.isEmpty:
    s.name("reason")
    self.`reason`.dump(s)
  if not self.`status`.isEmpty:
    s.name("status")
    self.`status`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Status): bool =
  if not self.`code`.isEmpty: return false
  if not self.`apiVersion`.isEmpty: return false
  if not self.`message`.isEmpty: return false
  if not self.`details`.isEmpty: return false
  if not self.`reason`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[Status], name: string, namespace = "default"): Future[Status] {.async.}=
  return await client.get("/api/v1", t, name, namespace)

proc create*(client: Client, t: Status, namespace = "default"): Future[Status] {.async.}=
  return await client.create("/api/v1", t, namespace)

proc delete*(client: Client, t: typedesc[Status], name: string, namespace = "default") {.async.}=
  await client.delete("/api/v1", t, name, namespace)
