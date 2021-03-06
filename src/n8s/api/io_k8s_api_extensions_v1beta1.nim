import ../client
import ../base_types
import parsejson
import ../jsonwriter
import io_k8s_apimachinery_pkg_util_intstr
import io_k8s_apimachinery_pkg_apis_meta_v1
import asyncdispatch
import io_k8s_api_core_v1

type
  IngressBackend* = object
    `serviceName`*: string
    `servicePort`*: io_k8s_apimachinery_pkg_util_intstr.IntOrString

proc load*(self: var IngressBackend, parser: var JsonParser) =
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
          of "serviceName":
            load(self.`serviceName`,parser)
          of "servicePort":
            load(self.`servicePort`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: IngressBackend, s: JsonWriter) =
  s.objectStart()
  s.name("serviceName")
  self.`serviceName`.dump(s)
  s.name("servicePort")
  self.`servicePort`.dump(s)
  s.objectEnd()

proc isEmpty*(self: IngressBackend): bool =
  if not self.`serviceName`.isEmpty: return false
  if not self.`servicePort`.isEmpty: return false
  true

type
  HTTPIngressPath* = object
    `path`*: string
    `backend`*: IngressBackend

proc load*(self: var HTTPIngressPath, parser: var JsonParser) =
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
          of "path":
            load(self.`path`,parser)
          of "backend":
            load(self.`backend`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: HTTPIngressPath, s: JsonWriter) =
  s.objectStart()
  if not self.`path`.isEmpty:
    s.name("path")
    self.`path`.dump(s)
  s.name("backend")
  self.`backend`.dump(s)
  s.objectEnd()

proc isEmpty*(self: HTTPIngressPath): bool =
  if not self.`path`.isEmpty: return false
  if not self.`backend`.isEmpty: return false
  true

type
  IngressTLS* = object
    `secretName`*: string
    `hosts`*: seq[string]

proc load*(self: var IngressTLS, parser: var JsonParser) =
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
          of "secretName":
            load(self.`secretName`,parser)
          of "hosts":
            load(self.`hosts`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: IngressTLS, s: JsonWriter) =
  s.objectStart()
  if not self.`secretName`.isEmpty:
    s.name("secretName")
    self.`secretName`.dump(s)
  if not self.`hosts`.isEmpty:
    s.name("hosts")
    self.`hosts`.dump(s)
  s.objectEnd()

proc isEmpty*(self: IngressTLS): bool =
  if not self.`secretName`.isEmpty: return false
  if not self.`hosts`.isEmpty: return false
  true

type
  HTTPIngressRuleValue* = object
    `paths`*: seq[HTTPIngressPath]

proc load*(self: var HTTPIngressRuleValue, parser: var JsonParser) =
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
          of "paths":
            load(self.`paths`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: HTTPIngressRuleValue, s: JsonWriter) =
  s.objectStart()
  s.name("paths")
  self.`paths`.dump(s)
  s.objectEnd()

proc isEmpty*(self: HTTPIngressRuleValue): bool =
  if not self.`paths`.isEmpty: return false
  true

type
  IngressRule* = object
    `http`*: HTTPIngressRuleValue
    `host`*: string

proc load*(self: var IngressRule, parser: var JsonParser) =
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
          of "http":
            load(self.`http`,parser)
          of "host":
            load(self.`host`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: IngressRule, s: JsonWriter) =
  s.objectStart()
  if not self.`http`.isEmpty:
    s.name("http")
    self.`http`.dump(s)
  if not self.`host`.isEmpty:
    s.name("host")
    self.`host`.dump(s)
  s.objectEnd()

proc isEmpty*(self: IngressRule): bool =
  if not self.`http`.isEmpty: return false
  if not self.`host`.isEmpty: return false
  true

type
  IngressSpec* = object
    `tls`*: seq[IngressTLS]
    `rules`*: seq[IngressRule]
    `backend`*: IngressBackend

proc load*(self: var IngressSpec, parser: var JsonParser) =
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
          of "tls":
            load(self.`tls`,parser)
          of "rules":
            load(self.`rules`,parser)
          of "backend":
            load(self.`backend`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: IngressSpec, s: JsonWriter) =
  s.objectStart()
  if not self.`tls`.isEmpty:
    s.name("tls")
    self.`tls`.dump(s)
  if not self.`rules`.isEmpty:
    s.name("rules")
    self.`rules`.dump(s)
  if not self.`backend`.isEmpty:
    s.name("backend")
    self.`backend`.dump(s)
  s.objectEnd()

proc isEmpty*(self: IngressSpec): bool =
  if not self.`tls`.isEmpty: return false
  if not self.`rules`.isEmpty: return false
  if not self.`backend`.isEmpty: return false
  true

type
  IngressStatus* = object
    `loadBalancer`*: io_k8s_api_core_v1.LoadBalancerStatus

proc load*(self: var IngressStatus, parser: var JsonParser) =
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
          of "loadBalancer":
            load(self.`loadBalancer`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: IngressStatus, s: JsonWriter) =
  s.objectStart()
  if not self.`loadBalancer`.isEmpty:
    s.name("loadBalancer")
    self.`loadBalancer`.dump(s)
  s.objectEnd()

proc isEmpty*(self: IngressStatus): bool =
  if not self.`loadBalancer`.isEmpty: return false
  true

type
  Ingress* = object
    `apiVersion`*: string
    `spec`*: IngressSpec
    `status`*: IngressStatus
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ObjectMeta

proc load*(self: var Ingress, parser: var JsonParser) =
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
          of "spec":
            load(self.`spec`,parser)
          of "status":
            load(self.`status`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: Ingress, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("extensions/v1beta1")
  s.name("kind"); s.value("Ingress")
  if not self.`spec`.isEmpty:
    s.name("spec")
    self.`spec`.dump(s)
  if not self.`status`.isEmpty:
    s.name("status")
    self.`status`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: Ingress): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`spec`.isEmpty: return false
  if not self.`status`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc get*(client: Client, t: typedesc[Ingress], name: string, namespace = "default"): Future[Ingress] {.async.}=
  return await client.get("/apis/extensions/v1beta1", t, name, namespace)

proc create*(client: Client, t: Ingress, namespace = "default"): Future[Ingress] {.async.}=
  return await client.create("/apis/extensions/v1beta1", t, namespace)

proc delete*(client: Client, t: typedesc[Ingress], name: string, namespace = "default") {.async.}=
  await client.delete("/apis/extensions/v1beta1", t, name, namespace)

proc replace*(client: Client, t: Ingress, namespace = "default"): Future[Ingress] {.async.}=
  return await client.replace("/apis/extensions/v1beta1", t, t.metadata.name, namespace)

proc watch*(client: Client, t: typedesc[Ingress], name: string, namespace = "default"): Future[FutureStream[WatchEv[Ingress]]] {.async.}=
  return await client.watch("/apis/extensions/v1beta1", t, name, namespace)

type
  IngressList* = object
    `apiVersion`*: string
    `items`*: seq[Ingress]
    `kind`*: string
    `metadata`*: io_k8s_apimachinery_pkg_apis_meta_v1.ListMeta

proc load*(self: var IngressList, parser: var JsonParser) =
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
          of "items":
            load(self.`items`,parser)
          of "kind":
            load(self.`kind`,parser)
          of "metadata":
            load(self.`metadata`,parser)
      else: raiseParseErr(parser,"string not " & $(parser.kind))

proc dump*(self: IngressList, s: JsonWriter) =
  s.objectStart()
  s.name("apiVersion"); s.value("extensions/v1beta1")
  s.name("kind"); s.value("IngressList")
  s.name("items")
  self.`items`.dump(s)
  if not self.`metadata`.isEmpty:
    s.name("metadata")
    self.`metadata`.dump(s)
  s.objectEnd()

proc isEmpty*(self: IngressList): bool =
  if not self.`apiVersion`.isEmpty: return false
  if not self.`items`.isEmpty: return false
  if not self.`kind`.isEmpty: return false
  if not self.`metadata`.isEmpty: return false
  true


proc list*(client: Client, t: typedesc[Ingress], namespace = "default"): Future[seq[Ingress]] {.async.}=
  return (await client.list("/apis/extensions/v1beta1", IngressList, namespace)).items
