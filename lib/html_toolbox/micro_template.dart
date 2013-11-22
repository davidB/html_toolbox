// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
part of html_toolbox;

const uriPolicyAll = const _UriPolicyAll();

interpolate(String tmpl, Map kv) {
  var from = new RegExp(r'\$\{([^}]*)\}');
  return tmpl.replaceAllMapped(from, (x) => findValue(kv, x.group(1)));
}

findValue(Map kv, String k) {
  if (kv.containsKey(k)) return kv[k];
  var ks = k.split(".");
  return ks.fold(kv, (v, k) => v[k]);
}

class _UriPolicyAll implements UriPolicy{
  const _UriPolicyAll();
  bool allowsUri(String uri) => true;
}

class MicroTemplate {
  var _tmpl = null;
  var _tmplParent = null;

  /// eg : tmpl = querySelector("script.ach")
  MicroTemplate(Element tmpl) {
    _tmplParent = tmpl.parent;
    //_tmplAchievements = _tmplAchievementsParent.innerHtml;
    _tmpl = (tmpl.tagName.toLowerCase() == "script") ? tmpl.text : tmpl.outerHtml;
    _tmplParent.setInnerHtml('');
  }

  apply(Iterable<Map> items, {NodeValidator validator, UriPolicy uriPolicy : uriPolicyAll}) {
    if (validator == null) {
      validator = new NodeValidator(uriPolicy: uriPolicy);
    }
    _tmplParent.setInnerHtml(
      items.fold("", (acc, item) => acc + (interpolate(_tmpl, item))),
      validator: validator
    );
  }
}