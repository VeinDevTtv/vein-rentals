var yn=Object.defineProperty;var kn=(e,t,n)=>t in e?yn(e,t,{enumerable:!0,configurable:!0,writable:!0,value:n}):e[t]=n;var ft=(e,t,n)=>kn(e,typeof t!="symbol"?t+"":t,n);(function(){const t=document.createElement("link").relList;if(t&&t.supports&&t.supports("modulepreload"))return;for(const i of document.querySelectorAll('link[rel="modulepreload"]'))l(i);new MutationObserver(i=>{for(const c of i)if(c.type==="childList")for(const u of c.addedNodes)u.tagName==="LINK"&&u.rel==="modulepreload"&&l(u)}).observe(document,{childList:!0,subtree:!0});function n(i){const c={};return i.integrity&&(c.integrity=i.integrity),i.referrerPolicy&&(c.referrerPolicy=i.referrerPolicy),i.crossOrigin==="use-credentials"?c.credentials="include":i.crossOrigin==="anonymous"?c.credentials="omit":c.credentials="same-origin",c}function l(i){if(i.ep)return;i.ep=!0;const c=n(i);fetch(i.href,c)}})();function A(){}function We(e,t){for(const n in t)e[n]=t[n];return e}function dn(e){return e()}function Yt(){return Object.create(null)}function fe(e){e.forEach(dn)}function gt(e){return typeof e=="function"}function we(e,t){return e!=e?t==t:e!==t||e&&typeof e=="object"||typeof e=="function"}let Xe;function Ge(e,t){return e===t?!0:(Xe||(Xe=document.createElement("a")),Xe.href=t,e===Xe.href)}function wn(e){return Object.keys(e).length===0}function pn(e,...t){if(e==null){for(const l of t)l(void 0);return A}const n=e.subscribe(...t);return n.unsubscribe?()=>n.unsubscribe():n}function X(e,t,n){e.$$.on_destroy.push(pn(t,n))}function ae(e,t,n){return e.set(n),t}function s(e,t){e.appendChild(t)}function M(e,t,n){e.insertBefore(t,n||null)}function L(e){e.parentNode&&e.parentNode.removeChild(e)}function Qe(e,t){for(let n=0;n<e.length;n+=1)e[n]&&e[n].d(t)}function f(e){return document.createElement(e)}function $(e){return document.createTextNode(e)}function y(){return $(" ")}function yt(){return $("")}function J(e,t,n,l){return e.addEventListener(t,n,l),()=>e.removeEventListener(t,n,l)}function d(e,t,n){n==null?e.removeAttribute(t):e.getAttribute(t)!==n&&e.setAttribute(t,n)}function En(e){return Array.from(e.childNodes)}function R(e,t){t=""+t,e.data!==t&&(e.data=t)}function I(e,t,n,l){n==null?e.style.removeProperty(t):e.style.setProperty(t,n,"")}function ee(e,t,n){e.classList.toggle(t,!!n)}function $n(e,t,{bubbles:n=!1,cancelable:l=!1}={}){return new CustomEvent(e,{detail:t,bubbles:n,cancelable:l})}function Ze(e,t){return new e(t)}let Le;function je(e){Le=e}function nt(){if(!Le)throw new Error("Function called outside component initialization");return Le}function vn(e){nt().$$.on_mount.push(e)}function Cn(e){nt().$$.after_update.push(e)}function Pn(e){nt().$$.on_destroy.push(e)}function On(){const e=nt();return(t,n,{cancelable:l=!1}={})=>{const i=e.$$.callbacks[t];if(i){const c=$n(t,n,{cancelable:l});return i.slice().forEach(u=>{u.call(e,c)}),!c.defaultPrevented}return!0}}function Ut(e,t){const n=e.$$.callbacks[t.type];n&&n.slice().forEach(l=>l.call(this,t))}const be=[],Xt=[];let ge=[];const Kt=[],hn=Promise.resolve();let ht=!1;function mn(){ht||(ht=!0,hn.then(_n))}function kt(){return mn(),hn}function mt(e){ge.push(e)}const dt=new Set;let me=0;function _n(){if(me!==0)return;const e=Le;do{try{for(;me<be.length;){const t=be[me];me++,je(t),qn(t.$$)}}catch(t){throw be.length=0,me=0,t}for(je(null),be.length=0,me=0;Xt.length;)Xt.pop()();for(let t=0;t<ge.length;t+=1){const n=ge[t];dt.has(n)||(dt.add(n),n())}ge.length=0}while(be.length);for(;Kt.length;)Kt.pop()();ht=!1,dt.clear(),je(e)}function qn(e){if(e.fragment!==null){e.update(),fe(e.before_update);const t=e.dirty;e.dirty=[-1],e.fragment&&e.fragment.p(e.ctx,t),e.after_update.forEach(mt)}}function Sn(e){const t=[],n=[];ge.forEach(l=>e.indexOf(l)===-1?t.push(l):n.push(l)),n.forEach(l=>l()),ge=t}const Ke=new Set;let ce;function wt(){ce={r:0,c:[],p:ce}}function Et(){ce.r||fe(ce.c),ce=ce.p}function te(e,t){e&&e.i&&(Ke.delete(e),e.i(t))}function ue(e,t,n,l){if(e&&e.o){if(Ke.has(e))return;Ke.add(e),ce.c.push(()=>{Ke.delete(e),l&&(n&&e.d(1),l())}),e.o(t)}else l&&l()}function x(e){return(e==null?void 0:e.length)!==void 0?e:Array.from(e)}function xe(e,t){const n={},l={},i={$$scope:1};let c=e.length;for(;c--;){const u=e[c],r=t[c];if(r){for(const o in u)o in r||(l[o]=1);for(const o in r)i[o]||(n[o]=r[o],i[o]=1);e[c]=r}else for(const o in u)i[o]=1}for(const u in l)u in n||(n[u]=void 0);return n}function et(e){return typeof e=="object"&&e!==null?e:{}}function Me(e){e&&e.c()}function ye(e,t,n){const{fragment:l,after_update:i}=e.$$;l&&l.m(t,n),mt(()=>{const c=e.$$.on_mount.map(dn).filter(gt);e.$$.on_destroy?e.$$.on_destroy.push(...c):fe(c),e.$$.on_mount=[]}),i.forEach(mt)}function ke(e,t){const n=e.$$;n.fragment!==null&&(Sn(n.after_update),fe(n.on_destroy),n.fragment&&n.fragment.d(t),n.on_destroy=n.fragment=null,n.ctx=[])}function jn(e,t){e.$$.dirty[0]===-1&&(be.push(e),mn(),e.$$.dirty.fill(0)),e.$$.dirty[t/31|0]|=1<<t%31}function Te(e,t,n,l,i,c,u=null,r=[-1]){const o=Le;je(e);const a=e.$$={fragment:null,ctx:[],props:c,update:A,not_equal:i,bound:Yt(),on_mount:[],on_destroy:[],on_disconnect:[],before_update:[],after_update:[],context:new Map(t.context||(o?o.$$.context:[])),callbacks:Yt(),dirty:r,skip_bound:!1,root:t.target||o.$$.root};u&&u(a.root);let h=!1;if(a.ctx=n?n(e,t.props||{},(g,_,...b)=>{const m=b.length?b[0]:_;return a.ctx&&i(a.ctx[g],a.ctx[g]=m)&&(!a.skip_bound&&a.bound[g]&&a.bound[g](m),h&&jn(e,g)),_}):[],a.update(),h=!0,fe(a.before_update),a.fragment=l?l(a.ctx):!1,t.target){if(t.hydrate){const g=En(t.target);a.fragment&&a.fragment.l(g),g.forEach(L)}else a.fragment&&a.fragment.c();t.intro&&te(e.$$.fragment),ye(e,t.target,t.anchor),_n()}je(o)}class Ne{constructor(){ft(this,"$$");ft(this,"$$set")}$destroy(){ke(this,1),this.$destroy=A}$on(t,n){if(!gt(n))return A;const l=this.$$.callbacks[t]||(this.$$.callbacks[t]=[]);return l.push(n),()=>{const i=l.indexOf(n);i!==-1&&l.splice(i,1)}}$set(t){this.$$set&&!wn(t)&&(this.$$.skip_bound=!0,this.$$set(t),this.$$.skip_bound=!1)}}const Rn="4";typeof window<"u"&&(window.__svelte||(window.__svelte={v:new Set})).v.add(Rn);const _e=[];function bn(e,t){return{subscribe:Y(e,t).subscribe}}function Y(e,t=A){let n;const l=new Set;function i(r){if(we(e,r)&&(e=r,n)){const o=!_e.length;for(const a of l)a[1](),_e.push(a,e);if(o){for(let a=0;a<_e.length;a+=2)_e[a][0](_e[a+1]);_e.length=0}}}function c(r){i(r(e))}function u(r,o=A){const a=[r,o];return l.add(a),l.size===1&&(n=t(i,c)||A),r(e),()=>{l.delete(a),l.size===0&&n&&(n(),n=null)}}return{set:i,update:c,subscribe:u}}function gn(e,t,n){const l=!Array.isArray(e),i=l?[e]:e;if(!i.every(Boolean))throw new Error("derived() expects stores as input, got a falsy value");const c=t.length<2;return bn(n,(u,r)=>{let o=!1;const a=[];let h=0,g=A;const _=()=>{if(h)return;g();const m=t(l?a[0]:a,u,r);c?u(m):g=gt(m)?m:A},b=i.map((m,w)=>pn(m,P=>{a[w]=P,h&=~(1<<w),o&&_()},()=>{h|=1<<w}));return o=!0,_(),function(){fe(b),g(),o=!1}})}function Ln(e,t){if(e instanceof RegExp)return{keys:!1,pattern:e};var n,l,i,c,u=[],r="",o=e.split("/");for(o[0]||o.shift();i=o.shift();)n=i[0],n==="*"?(u.push("wild"),r+="/(.*)"):n===":"?(l=i.indexOf("?",1),c=i.indexOf(".",1),u.push(i.substring(1,~l?l:~c?c:i.length)),r+=~l&&!~c?"(?:/([^/]+?))?":"/([^/]+?)",~c&&(r+=(~l?"?":"")+"\\"+i.substring(c))):r+="/"+i;return{keys:u,pattern:new RegExp("^"+r+"/?$","i")}}function Mn(e){let t,n,l;const i=[e[2]];var c=e[0];function u(r,o){let a={};for(let h=0;h<i.length;h+=1)a=We(a,i[h]);return o!==void 0&&o&4&&(a=We(a,xe(i,[et(r[2])]))),{props:a}}return c&&(t=Ze(c,u(e)),t.$on("routeEvent",e[7])),{c(){t&&Me(t.$$.fragment),n=yt()},m(r,o){t&&ye(t,r,o),M(r,n,o),l=!0},p(r,o){if(o&1&&c!==(c=r[0])){if(t){wt();const a=t;ue(a.$$.fragment,1,0,()=>{ke(a,1)}),Et()}c?(t=Ze(c,u(r,o)),t.$on("routeEvent",r[7]),Me(t.$$.fragment),te(t.$$.fragment,1),ye(t,n.parentNode,n)):t=null}else if(c){const a=o&4?xe(i,[et(r[2])]):{};t.$set(a)}},i(r){l||(t&&te(t.$$.fragment,r),l=!0)},o(r){t&&ue(t.$$.fragment,r),l=!1},d(r){r&&L(n),t&&ke(t,r)}}}function Tn(e){let t,n,l;const i=[{params:e[1]},e[2]];var c=e[0];function u(r,o){let a={};for(let h=0;h<i.length;h+=1)a=We(a,i[h]);return o!==void 0&&o&6&&(a=We(a,xe(i,[o&2&&{params:r[1]},o&4&&et(r[2])]))),{props:a}}return c&&(t=Ze(c,u(e)),t.$on("routeEvent",e[6])),{c(){t&&Me(t.$$.fragment),n=yt()},m(r,o){t&&ye(t,r,o),M(r,n,o),l=!0},p(r,o){if(o&1&&c!==(c=r[0])){if(t){wt();const a=t;ue(a.$$.fragment,1,0,()=>{ke(a,1)}),Et()}c?(t=Ze(c,u(r,o)),t.$on("routeEvent",r[6]),Me(t.$$.fragment),te(t.$$.fragment,1),ye(t,n.parentNode,n)):t=null}else if(c){const a=o&6?xe(i,[o&2&&{params:r[1]},o&4&&et(r[2])]):{};t.$set(a)}},i(r){l||(t&&te(t.$$.fragment,r),l=!0)},o(r){t&&ue(t.$$.fragment,r),l=!1},d(r){r&&L(n),t&&ke(t,r)}}}function Nn(e){let t,n,l,i;const c=[Tn,Mn],u=[];function r(o,a){return o[1]?0:1}return t=r(e),n=u[t]=c[t](e),{c(){n.c(),l=yt()},m(o,a){u[t].m(o,a),M(o,l,a),i=!0},p(o,[a]){let h=t;t=r(o),t===h?u[t].p(o,a):(wt(),ue(u[h],1,1,()=>{u[h]=null}),Et(),n=u[t],n?n.p(o,a):(n=u[t]=c[t](o),n.c()),te(n,1),n.m(l.parentNode,l))},i(o){i||(te(n),i=!0)},o(o){ue(n),i=!1},d(o){o&&L(l),u[t].d(o)}}}function Wt(){const e=window.location.href.indexOf("#/");let t=e>-1?window.location.href.substr(e+1):"/";const n=t.indexOf("?");let l="";return n>-1&&(l=t.substr(n+1),t=t.substr(0,n)),{location:t,querystring:l}}const $t=bn(null,function(t){t(Wt());const n=()=>{t(Wt())};return window.addEventListener("hashchange",n,!1),function(){window.removeEventListener("hashchange",n,!1)}});gn($t,e=>e.location);gn($t,e=>e.querystring);const _t=Y(void 0);async function Gt(e){if(!e||e.length<1||e.charAt(0)!="/"&&e.indexOf("#/")!==0)throw Error("Invalid parameter location");await kt(),history.replaceState({...history.state,__svelte_spa_router_scrollX:window.scrollX,__svelte_spa_router_scrollY:window.scrollY},void 0),window.location.hash=(e.charAt(0)=="#"?"":"#")+e}async function bt(){await kt(),window.history.back()}function zn(e){e?window.scrollTo(e.__svelte_spa_router_scrollX,e.__svelte_spa_router_scrollY):window.scrollTo(0,0)}function An(e,t,n){let{routes:l={}}=t,{prefix:i=""}=t,{restoreScrollState:c=!1}=t;class u{constructor(k,v){if(!v||typeof v!="function"&&(typeof v!="object"||v._sveltesparouter!==!0))throw Error("Invalid component object");if(!k||typeof k=="string"&&(k.length<1||k.charAt(0)!="/"&&k.charAt(0)!="*")||typeof k=="object"&&!(k instanceof RegExp))throw Error('Invalid value for "path" argument - strings must start with / or *');const{pattern:E,keys:j}=Ln(k);this.path=k,typeof v=="object"&&v._sveltesparouter===!0?(this.component=v.component,this.conditions=v.conditions||[],this.userData=v.userData,this.props=v.props||{}):(this.component=()=>Promise.resolve(v),this.conditions=[],this.props={}),this._pattern=E,this._keys=j}match(k){if(i){if(typeof i=="string")if(k.startsWith(i))k=k.substr(i.length)||"/";else return null;else if(i instanceof RegExp){const T=k.match(i);if(T&&T[0])k=k.substr(T[0].length)||"/";else return null}}const v=this._pattern.exec(k);if(v===null)return null;if(this._keys===!1)return v;const E={};let j=0;for(;j<this._keys.length;){try{E[this._keys[j]]=decodeURIComponent(v[j+1]||"")||null}catch{E[this._keys[j]]=null}j++}return E}async checkConditions(k){for(let v=0;v<this.conditions.length;v++)if(!await this.conditions[v](k))return!1;return!0}}const r=[];l instanceof Map?l.forEach((p,k)=>{r.push(new u(k,p))}):Object.keys(l).forEach(p=>{r.push(new u(p,l[p]))});let o=null,a=null,h={};const g=On();async function _(p,k){await kt(),g(p,k)}let b=null,m=null;c&&(m=p=>{p.state&&(p.state.__svelte_spa_router_scrollY||p.state.__svelte_spa_router_scrollX)?b=p.state:b=null},window.addEventListener("popstate",m),Cn(()=>{zn(b)}));let w=null,P=null;const O=$t.subscribe(async p=>{w=p;let k=0;for(;k<r.length;){const v=r[k].match(p.location);if(!v){k++;continue}const E={route:r[k].path,location:p.location,querystring:p.querystring,userData:r[k].userData,params:v&&typeof v=="object"&&Object.keys(v).length?v:null};if(!await r[k].checkConditions(E)){n(0,o=null),P=null,_("conditionsFailed",E);return}_("routeLoading",Object.assign({},E));const j=r[k].component;if(P!=j){j.loading?(n(0,o=j.loading),P=j,n(1,a=j.loadingParams),n(2,h={}),_("routeLoaded",Object.assign({},E,{component:o,name:o.name,params:a}))):(n(0,o=null),P=null);const T=await j();if(p!=w)return;n(0,o=T&&T.default||T),P=j}v&&typeof v=="object"&&Object.keys(v).length?n(1,a=v):n(1,a=null),n(2,h=r[k].props),_("routeLoaded",Object.assign({},E,{component:o,name:o.name,params:a})).then(()=>{_t.set(a)});return}n(0,o=null),P=null,_t.set(void 0)});Pn(()=>{O(),m&&window.removeEventListener("popstate",m)});function S(p){Ut.call(this,e,p)}function C(p){Ut.call(this,e,p)}return e.$$set=p=>{"routes"in p&&n(3,l=p.routes),"prefix"in p&&n(4,i=p.prefix),"restoreScrollState"in p&&n(5,c=p.restoreScrollState)},e.$$.update=()=>{e.$$.dirty&32&&(history.scrollRestoration=c?"manual":"auto")},[o,a,h,l,i,c,S,C]}class Dn extends Ne{constructor(t){super(),Te(this,t,An,Nn,we,{routes:3,prefix:4,restoreScrollState:5})}}function pt(e){if(!e)throw Error("Parameter args is required");if(!e.component==!e.asyncComponent)throw Error("One and only one of component and asyncComponent is required");if(e.component&&(e.asyncComponent=()=>Promise.resolve(e.component)),typeof e.asyncComponent!="function")throw Error("Parameter asyncComponent must be a function");if(e.conditions){Array.isArray(e.conditions)||(e.conditions=[e.conditions]);for(let n=0;n<e.conditions.length;n++)if(!e.conditions[n]||typeof e.conditions[n]!="function")throw Error("Invalid parameter conditions["+n+"]")}return e.loadingComponent&&(e.asyncComponent.loading=e.loadingComponent,e.asyncComponent.loadingParams=e.loadingParams||void 0),{component:e.asyncComponent,userData:e.userData,conditions:e.conditions&&e.conditions.length?e.conditions:void 0,props:e.props&&Object.keys(e.props).length?e.props:{},_sveltesparouter:!0}}const vt=Y(!1),Qt=Y(""),tt=Y([]),Zt=Y([]),Vn=Y(null),Bn=Y([]),Re=Y([]),xt=Y(0),In=Y(0);function en(e,t,n){const l=e.slice();return l[10]=t[n],l}function tn(e,t,n){const l=e.slice();return l[13]=t[n],l}function nn(e){let t,n,l,i,c=e[13].label+"",u,r,o,a;function h(){return e[7](e[13])}return{c(){t=f("button"),n=f("span"),i=y(),u=$(c),r=y(),d(n,"class",l="mdi mdi-"+e[13].icon+" svelte-ncq9ux"),d(t,"class","tab svelte-ncq9ux"),ee(t,"active",e[0]&&e[0].name===e[13].name)},m(g,_){M(g,t,_),s(t,n),s(t,i),s(t,u),s(t,r),o||(a=J(t,"click",h),o=!0)},p(g,_){e=g,_&2&&l!==(l="mdi mdi-"+e[13].icon+" svelte-ncq9ux")&&d(n,"class",l),_&2&&c!==(c=e[13].label+"")&&R(u,c),_&3&&ee(t,"active",e[0]&&e[0].name===e[13].name)},d(g){g&&L(t),o=!1,a()}}}function ln(e){let t,n=e[2].length+"",l;return{c(){t=f("span"),l=$(n),d(t,"class","badge svelte-ncq9ux")},m(i,c){M(i,t,c),s(t,l)},p(i,c){c&4&&n!==(n=i[2].length+"")&&R(l,n)},d(i){i&&L(t)}}}function sn(e){let t,n=e[0].label+"",l,i,c,u=e[0].description+"",r;return{c(){t=f("h3"),l=$(n),i=y(),c=f("p"),r=$(u),d(t,"class","svelte-ncq9ux"),d(c,"class","svelte-ncq9ux")},m(o,a){M(o,t,a),s(t,l),M(o,i,a),M(o,c,a),s(c,r)},p(o,a){a&1&&n!==(n=o[0].label+"")&&R(l,n),a&1&&u!==(u=o[0].description+"")&&R(r,u)},d(o){o&&(L(t),L(i),L(c))}}}function on(e){let t,n,l,i,c,u,r,o,a=e[10].name+"",h,g,_,b,m=e[10].rentalPrice+"",w,P,O,S,C,p,k,v,E,j,T,G,Ee,ne,V,le,se,ie,K,$e;function oe(){return e[8](e[10])}function de(...F){return e[9](e[10],...F)}return{c(){t=f("button"),n=f("div"),l=f("img"),u=y(),r=f("div"),o=f("h3"),h=$(a),g=y(),_=f("p"),b=$("$"),w=$(m),P=$("/hour"),O=y(),S=f("div"),C=f("div"),p=f("span"),p.textContent="Speed",k=y(),v=f("div"),E=f("div"),j=y(),T=f("div"),G=f("span"),G.textContent="Handling",Ee=y(),ne=f("div"),V=f("div"),le=y(),se=f("span"),se.textContent="View Details",ie=y(),Ge(l.src,i=e[10].image)||d(l,"src",i),d(l,"alt",c=e[10].name),d(l,"class","svelte-ncq9ux"),d(n,"class","image-container svelte-ncq9ux"),d(o,"class","svelte-ncq9ux"),d(_,"class","price svelte-ncq9ux"),d(p,"class","stat-label svelte-ncq9ux"),d(E,"class","stat-fill svelte-ncq9ux"),I(E,"width",e[10].stats.speed+"%"),d(v,"class","stat-bar svelte-ncq9ux"),d(C,"class","stat svelte-ncq9ux"),d(G,"class","stat-label svelte-ncq9ux"),d(V,"class","stat-fill svelte-ncq9ux"),I(V,"width",e[10].stats.handling+"%"),d(ne,"class","stat-bar svelte-ncq9ux"),d(T,"class","stat svelte-ncq9ux"),d(S,"class","stats svelte-ncq9ux"),d(se,"class","view-btn svelte-ncq9ux"),d(r,"class","vehicle-info svelte-ncq9ux"),d(t,"class","vehicle-card svelte-ncq9ux")},m(F,H){M(F,t,H),s(t,n),s(n,l),s(t,u),s(t,r),s(r,o),s(o,h),s(r,g),s(r,_),s(_,b),s(_,w),s(_,P),s(r,O),s(r,S),s(S,C),s(C,p),s(C,k),s(C,v),s(v,E),s(S,j),s(S,T),s(T,G),s(T,Ee),s(T,ne),s(ne,V),s(r,le),s(r,se),s(t,ie),K||($e=[J(t,"click",oe),J(t,"keydown",de)],K=!0)},p(F,H){e=F,H&8&&!Ge(l.src,i=e[10].image)&&d(l,"src",i),H&8&&c!==(c=e[10].name)&&d(l,"alt",c),H&8&&a!==(a=e[10].name+"")&&R(h,a),H&8&&m!==(m=e[10].rentalPrice+"")&&R(w,m),H&8&&I(E,"width",e[10].stats.speed+"%"),H&8&&I(V,"width",e[10].stats.handling+"%")},d(F){F&&L(t),K=!1,fe($e)}}}function Fn(e){let t,n,l,i,c,u,r,o,a,h,g,_,b,m=x(e[1]),w=[];for(let p=0;p<m.length;p+=1)w[p]=nn(tn(e,m,p));let P=e[2]&&e[2].length>0&&ln(e),O=e[0]&&sn(e),S=x(e[3]),C=[];for(let p=0;p<S.length;p+=1)C[p]=on(en(e,S,p));return{c(){t=f("div"),n=f("div"),l=f("div");for(let p=0;p<w.length;p+=1)w[p].c();i=y(),c=f("button"),u=f("span"),r=$(`\r
      My Rentals\r
      `),P&&P.c(),o=y(),a=f("div"),O&&O.c(),h=y(),g=f("div");for(let p=0;p<C.length;p+=1)C[p].c();d(l,"class","category-tabs svelte-ncq9ux"),d(u,"class","mdi mdi-car-clock"),d(c,"class","tab rentals-tab svelte-ncq9ux"),d(n,"class","tabs svelte-ncq9ux"),d(a,"class","category-description svelte-ncq9ux"),d(g,"class","vehicles-grid svelte-ncq9ux"),d(t,"class","main-menu svelte-ncq9ux")},m(p,k){M(p,t,k),s(t,n),s(n,l);for(let v=0;v<w.length;v+=1)w[v]&&w[v].m(l,null);s(n,i),s(n,c),s(c,u),s(c,r),P&&P.m(c,null),s(t,o),s(t,a),O&&O.m(a,null),s(t,h),s(t,g);for(let v=0;v<C.length;v+=1)C[v]&&C[v].m(g,null);_||(b=J(c,"click",e[6]),_=!0)},p(p,[k]){if(k&19){m=x(p[1]);let v;for(v=0;v<m.length;v+=1){const E=tn(p,m,v);w[v]?w[v].p(E,k):(w[v]=nn(E),w[v].c(),w[v].m(l,null))}for(;v<w.length;v+=1)w[v].d(1);w.length=m.length}if(p[2]&&p[2].length>0?P?P.p(p,k):(P=ln(p),P.c(),P.m(c,null)):P&&(P.d(1),P=null),p[0]?O?O.p(p,k):(O=sn(p),O.c(),O.m(a,null)):O&&(O.d(1),O=null),k&40){S=x(p[3]);let v;for(v=0;v<S.length;v+=1){const E=en(p,S,v);C[v]?C[v].p(E,k):(C[v]=on(E),C[v].c(),C[v].m(g,null))}for(;v<C.length;v+=1)C[v].d(1);C.length=S.length}},i:A,o:A,d(p){p&&L(t),Qe(w,p),P&&P.d(),O&&O.d(),Qe(C,p),_=!1,b()}}}function Hn(e,t,n){let l,i,c;X(e,tt,b=>n(1,l=b)),X(e,Re,b=>n(2,i=b)),X(e,Zt,b=>n(3,c=b));let u=null;function r(b){n(0,u=b),fetch("https://vein-rentals/selectCategory",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({category:b.name})})}function o(b){Gt(`/vehicle/${b}`)}function a(){Gt("/active-rentals")}return Zt.subscribe(b=>{b&&b.length>0&&(u||r(l[0]))}),tt.subscribe(b=>{b&&b.length>0&&r(b[0])}),[u,l,i,c,r,o,a,b=>r(b),b=>o(b.model),(b,m)=>m.key==="Enter"&&o(b.model)]}class Jn extends Ne{constructor(t){super(),Te(this,t,Hn,Fn,we,{})}}function rn(e,t,n){const l=e.slice();return l[11]=t[n],l}function Yn(e){let t;return{c(){t=f("div"),t.innerHTML='<span class="mdi mdi-loading mdi-spin svelte-fvprnp"></span> <span>Loading vehicle details...</span>',d(t,"class","loading svelte-fvprnp")},m(n,l){M(n,t,l)},p:A,d(n){n&&L(t)}}}function Un(e){let t,n,l,i,c,u,r,o,a,h=e[0].name+"",g,_,b,m=e[0].description+"",w,P,O,S,C,p,k,v,E,j,T=e[0].stats.speed+"",G,Ee,ne,V,le,se,ie,K,$e,oe,de=e[0].stats.acceleration+"",F,H,Ct,Q,ze,Pt,Ae,Ce,Ot,Pe,De=e[0].stats.handling+"",lt,qt,St,Z,Ve,jt,Be,Oe,Rt,qe,Ie=e[0].stats.braking+"",st,Lt,Mt,U,Fe,Tt,Se,Nt,W,pe,it,zt,He,At,Je=(e[2]?Math.floor(e[0].rentalPrice*(e[2].priceMultiplier/.1)):0)+"",ot,Dt,rt,ve,at,Vt,Ye,Bt,ct,It,re,Ft,Ue,ut,Ht,he=x(e[1]),D=[];for(let q=0;q<he.length;q+=1)D[q]=an(rn(e,he,q));let B=e[4]>0&&cn(e);return{c(){t=f("div"),n=f("div"),l=f("div"),i=f("img"),r=y(),o=f("div"),a=f("h2"),g=$(h),_=y(),b=f("p"),w=$(m),P=y(),O=f("div"),S=f("div"),C=f("span"),C.textContent="Speed",p=y(),k=f("div"),v=f("div"),E=y(),j=f("span"),G=$(T),Ee=$("%"),ne=y(),V=f("div"),le=f("span"),le.textContent="Acceleration",se=y(),ie=f("div"),K=f("div"),$e=y(),oe=f("span"),F=$(de),H=$("%"),Ct=y(),Q=f("div"),ze=f("span"),ze.textContent="Handling",Pt=y(),Ae=f("div"),Ce=f("div"),Ot=y(),Pe=f("span"),lt=$(De),qt=$("%"),St=y(),Z=f("div"),Ve=f("span"),Ve.textContent="Braking",jt=y(),Be=f("div"),Oe=f("div"),Rt=y(),qe=f("span"),st=$(Ie),Lt=$("%"),Mt=y(),U=f("div"),Fe=f("h3"),Fe.textContent="Rental Duration",Tt=y(),Se=f("div");for(let q=0;q<D.length;q+=1)D[q].c();Nt=y(),W=f("div"),pe=f("div"),it=f("span"),it.textContent="Base Price:",zt=y(),He=f("span"),At=$("$"),ot=$(Je),Dt=y(),B&&B.c(),rt=y(),ve=f("div"),at=f("span"),at.textContent="Total:",Vt=y(),Ye=f("span"),Bt=$("$"),ct=$(e[3]),It=y(),re=f("button"),Ft=$("Rent Now"),Ge(i.src,c=e[0].image)||d(i,"src",c),d(i,"alt",u=e[0].name),d(i,"class","svelte-fvprnp"),d(l,"class","image-container svelte-fvprnp"),d(a,"class","svelte-fvprnp"),d(b,"class","description svelte-fvprnp"),d(C,"class","stat-label svelte-fvprnp"),d(v,"class","stat-fill svelte-fvprnp"),I(v,"width",e[0].stats.speed+"%"),d(k,"class","stat-bar svelte-fvprnp"),d(j,"class","stat-value svelte-fvprnp"),d(S,"class","stat svelte-fvprnp"),d(le,"class","stat-label svelte-fvprnp"),d(K,"class","stat-fill svelte-fvprnp"),I(K,"width",e[0].stats.acceleration+"%"),d(ie,"class","stat-bar svelte-fvprnp"),d(oe,"class","stat-value svelte-fvprnp"),d(V,"class","stat svelte-fvprnp"),d(ze,"class","stat-label svelte-fvprnp"),d(Ce,"class","stat-fill svelte-fvprnp"),I(Ce,"width",e[0].stats.handling+"%"),d(Ae,"class","stat-bar svelte-fvprnp"),d(Pe,"class","stat-value svelte-fvprnp"),d(Q,"class","stat svelte-fvprnp"),d(Ve,"class","stat-label svelte-fvprnp"),d(Oe,"class","stat-fill svelte-fvprnp"),I(Oe,"width",e[0].stats.braking+"%"),d(Be,"class","stat-bar svelte-fvprnp"),d(qe,"class","stat-value svelte-fvprnp"),d(Z,"class","stat svelte-fvprnp"),d(O,"class","stats-container svelte-fvprnp"),d(o,"class","vehicle-stats svelte-fvprnp"),d(n,"class","vehicle-showcase svelte-fvprnp"),d(Fe,"class","svelte-fvprnp"),d(Se,"class","duration-selector svelte-fvprnp"),d(pe,"class","summary-row svelte-fvprnp"),d(ve,"class","summary-row total svelte-fvprnp"),d(W,"class","rental-summary svelte-fvprnp"),d(re,"class","rent-btn svelte-fvprnp"),re.disabled=Ue=!e[2],d(U,"class","rental-options svelte-fvprnp"),d(t,"class","details-content svelte-fvprnp")},m(q,N){M(q,t,N),s(t,n),s(n,l),s(l,i),s(n,r),s(n,o),s(o,a),s(a,g),s(o,_),s(o,b),s(b,w),s(o,P),s(o,O),s(O,S),s(S,C),s(S,p),s(S,k),s(k,v),s(S,E),s(S,j),s(j,G),s(j,Ee),s(O,ne),s(O,V),s(V,le),s(V,se),s(V,ie),s(ie,K),s(V,$e),s(V,oe),s(oe,F),s(oe,H),s(O,Ct),s(O,Q),s(Q,ze),s(Q,Pt),s(Q,Ae),s(Ae,Ce),s(Q,Ot),s(Q,Pe),s(Pe,lt),s(Pe,qt),s(O,St),s(O,Z),s(Z,Ve),s(Z,jt),s(Z,Be),s(Be,Oe),s(Z,Rt),s(Z,qe),s(qe,st),s(qe,Lt),s(t,Mt),s(t,U),s(U,Fe),s(U,Tt),s(U,Se);for(let z=0;z<D.length;z+=1)D[z]&&D[z].m(Se,null);s(U,Nt),s(U,W),s(W,pe),s(pe,it),s(pe,zt),s(pe,He),s(He,At),s(He,ot),s(W,Dt),B&&B.m(W,null),s(W,rt),s(W,ve),s(ve,at),s(ve,Vt),s(ve,Ye),s(Ye,Bt),s(Ye,ct),s(U,It),s(U,re),s(re,Ft),ut||(Ht=J(re,"click",e[6]),ut=!0)},p(q,N){if(N&1&&!Ge(i.src,c=q[0].image)&&d(i,"src",c),N&1&&u!==(u=q[0].name)&&d(i,"alt",u),N&1&&h!==(h=q[0].name+"")&&R(g,h),N&1&&m!==(m=q[0].description+"")&&R(w,m),N&1&&I(v,"width",q[0].stats.speed+"%"),N&1&&T!==(T=q[0].stats.speed+"")&&R(G,T),N&1&&I(K,"width",q[0].stats.acceleration+"%"),N&1&&de!==(de=q[0].stats.acceleration+"")&&R(F,de),N&1&&I(Ce,"width",q[0].stats.handling+"%"),N&1&&De!==(De=q[0].stats.handling+"")&&R(lt,De),N&1&&I(Oe,"width",q[0].stats.braking+"%"),N&1&&Ie!==(Ie=q[0].stats.braking+"")&&R(st,Ie),N&39){he=x(q[1]);let z;for(z=0;z<he.length;z+=1){const Jt=rn(q,he,z);D[z]?D[z].p(Jt,N):(D[z]=an(Jt),D[z].c(),D[z].m(Se,null))}for(;z<D.length;z+=1)D[z].d(1);D.length=he.length}N&5&&Je!==(Je=(q[2]?Math.floor(q[0].rentalPrice*(q[2].priceMultiplier/.1)):0)+"")&&R(ot,Je),q[4]>0?B?B.p(q,N):(B=cn(q),B.c(),B.m(W,rt)):B&&(B.d(1),B=null),N&8&&R(ct,q[3]),N&4&&Ue!==(Ue=!q[2])&&(re.disabled=Ue)},d(q){q&&L(t),Qe(D,q),B&&B.d(),ut=!1,Ht()}}}function an(e){let t,n,l=e[11].label+"",i,c,u,r,o=Math.floor(e[0].rentalPrice*(e[11].priceMultiplier/.1))+"",a,h,g,_;function b(){return e[8](e[11])}return{c(){t=f("button"),n=f("span"),i=$(l),c=y(),u=f("span"),r=$("$"),a=$(o),h=y(),d(n,"class","duration-label svelte-fvprnp"),d(u,"class","duration-price svelte-fvprnp"),d(t,"class","duration-option svelte-fvprnp"),ee(t,"selected",e[2]&&e[2].time===e[11].time)},m(m,w){M(m,t,w),s(t,n),s(n,i),s(t,c),s(t,u),s(u,r),s(u,a),s(t,h),g||(_=J(t,"click",b),g=!0)},p(m,w){e=m,w&2&&l!==(l=e[11].label+"")&&R(i,l),w&3&&o!==(o=Math.floor(e[0].rentalPrice*(e[11].priceMultiplier/.1))+"")&&R(a,o),w&6&&ee(t,"selected",e[2]&&e[2].time===e[11].time)},d(m){m&&L(t),g=!1,_()}}}function cn(e){let t,n,l,i=e[4]*100+"",c,u,r,o,a,h=(e[2]?Math.floor(e[0].rentalPrice*(e[2].priceMultiplier/.1)*e[4]):0)+"",g;return{c(){t=f("div"),n=f("span"),l=$("Loyalty Discount ("),c=$(i),u=$("%):"),r=y(),o=f("span"),a=$("-$"),g=$(h),d(t,"class","summary-row discount svelte-fvprnp")},m(_,b){M(_,t,b),s(t,n),s(n,l),s(n,c),s(n,u),s(t,r),s(t,o),s(o,a),s(o,g)},p(_,b){b&16&&i!==(i=_[4]*100+"")&&R(c,i),b&21&&h!==(h=(_[2]?Math.floor(_[0].rentalPrice*(_[2].priceMultiplier/.1)*_[4]):0)+"")&&R(g,h)},d(_){_&&L(t)}}}function Xn(e){let t,n,l,i,c;function u(a,h){return a[0]?Un:Yn}let r=u(e),o=r(e);return{c(){t=f("div"),n=f("button"),n.innerHTML=`<span class="mdi mdi-arrow-left"></span>
    Back to Vehicles`,l=y(),o.c(),d(n,"class","back-btn svelte-fvprnp"),d(t,"class","vehicle-details svelte-fvprnp")},m(a,h){M(a,t,h),s(t,n),s(t,l),o.m(t,null),i||(c=J(n,"click",e[7]),i=!0)},p(a,[h]){r===(r=u(a))&&o?o.p(a,h):(o.d(1),o=r(a),o&&(o.c(),o.m(t,null)))},i:A,o:A,d(a){a&&L(t),o.d(),i=!1,c()}}}function Kn(e,t,n){let l;X(e,_t,m=>n(9,l=m));let i=null,c=[],u=null,r=0,o=0;vn(()=>{fetch("https://vein-rentals/viewVehicleDetails",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({model:l.model})})});function a(){if(!i||!u)return 0;let m=i.rentalPrice*(u.priceMultiplier/.1);return o>0&&(m=m*(1-o)),Math.floor(m)}function h(m){n(2,u=m),n(3,r=a())}function g(){!i||!u||fetch("https://vein-rentals/rentVehicle",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({model:i.model,duration:u.time,cost:r})}).then(m=>m.json()).then(m=>{m.success&&bt()})}function _(){bt()}return Vn.subscribe(m=>{m&&(n(0,i=m),n(2,u=null),n(3,r=0))}),Bn.subscribe(m=>{m&&m.length>0&&n(1,c=m)}),In.subscribe(m=>{n(4,o=m),n(3,r=a())}),[i,c,u,r,o,h,g,_,m=>h(m)]}class Wn extends Ne{constructor(t){super(),Te(this,t,Kn,Xn,we,{})}}function un(e,t,n){const l=e.slice();return l[3]=t[n],l}function Gn(e){let t,n,l,i,c,u,r,o;return{c(){t=f("div"),n=f("span"),l=y(),i=f("p"),i.textContent="You don't have any active rentals",c=y(),u=f("button"),u.textContent="Browse Vehicles",d(n,"class","mdi mdi-car-off svelte-1tfrzki"),d(i,"class","svelte-1tfrzki"),d(u,"class","browse-btn svelte-1tfrzki"),d(t,"class","no-rentals svelte-1tfrzki")},m(a,h){M(a,t,h),s(t,n),s(t,l),s(t,i),s(t,c),s(t,u),r||(o=J(u,"click",e[1]),r=!0)},p:A,d(a){a&&L(t),r=!1,o()}}}function Qn(e){let t,n=x(e[0]),l=[];for(let i=0;i<n.length;i+=1)l[i]=fn(un(e,n,i));return{c(){t=f("div");for(let i=0;i<l.length;i+=1)l[i].c();d(t,"class","rentals-list svelte-1tfrzki")},m(i,c){M(i,t,c);for(let u=0;u<l.length;u+=1)l[u]&&l[u].m(t,null)},p(i,c){if(c&1){n=x(i[0]);let u;for(u=0;u<n.length;u+=1){const r=un(i,n,u);l[u]?l[u].p(r,c):(l[u]=fn(r),l[u].c(),l[u].m(t,null))}for(;u<l.length;u+=1)l[u].d(1);l.length=n.length}},d(i){i&&L(t),Qe(l,i)}}}function Zn(e){let t,n,l,i,c,u=e[3].timeRemaining+"",r;return{c(){t=f("div"),n=f("span"),l=y(),i=f("span"),c=$("Time Remaining: "),r=$(u),d(n,"class","mdi mdi-clock-outline"),d(t,"class","status active svelte-1tfrzki")},m(o,a){M(o,t,a),s(t,n),s(t,l),s(t,i),s(i,c),s(i,r)},p(o,a){a&1&&u!==(u=o[3].timeRemaining+"")&&R(r,u)},d(o){o&&L(t)}}}function xn(e){let t,n,l,i,c,u=e[3].timeOverdue+"",r,o,a,h,g,_=e[3].lateFee+"",b;return{c(){t=f("div"),n=f("span"),l=y(),i=f("span"),c=$("Overdue: "),r=$(u),o=y(),a=f("div"),h=f("span"),g=$("Late Fee: $"),b=$(_),d(n,"class","mdi mdi-alert-circle"),d(t,"class","status overdue svelte-1tfrzki"),d(a,"class","late-fee svelte-1tfrzki")},m(m,w){M(m,t,w),s(t,n),s(t,l),s(t,i),s(i,c),s(i,r),M(m,o,w),M(m,a,w),s(a,h),s(h,g),s(h,b)},p(m,w){w&1&&u!==(u=m[3].timeOverdue+"")&&R(r,u),w&1&&_!==(_=m[3].lateFee+"")&&R(b,_)},d(m){m&&(L(t),L(o),L(a))}}}function fn(e){let t,n,l,i=e[3].model+"",c,u,r,o,a=e[3].plate+"",h,g,_,b,m,w,P,O;function S(v,E){return v[3].isOverdue?xn:Zn}let C=S(e),p=C(e);function k(){return e[2](e[3])}return{c(){t=f("div"),n=f("div"),l=f("h3"),c=$(i),u=y(),r=f("p"),o=$("Plate: "),h=$(a),g=y(),p.c(),_=y(),b=f("div"),m=f("button"),m.textContent="Return Vehicle",w=y(),d(l,"class","svelte-1tfrzki"),d(r,"class","plate svelte-1tfrzki"),d(n,"class","rental-info svelte-1tfrzki"),d(m,"class","return-btn svelte-1tfrzki"),ee(m,"overdue",e[3].isOverdue),d(b,"class","rental-actions svelte-1tfrzki"),d(t,"class","rental-card svelte-1tfrzki")},m(v,E){M(v,t,E),s(t,n),s(n,l),s(l,c),s(n,u),s(n,r),s(r,o),s(r,h),s(n,g),p.m(n,null),s(t,_),s(t,b),s(b,m),s(t,w),P||(O=J(m,"click",k),P=!0)},p(v,E){e=v,E&1&&i!==(i=e[3].model+"")&&R(c,i),E&1&&a!==(a=e[3].plate+"")&&R(h,a),C===(C=S(e))&&p?p.p(e,E):(p.d(1),p=C(e),p&&(p.c(),p.m(n,null))),E&1&&ee(m,"overdue",e[3].isOverdue)},d(v){v&&L(t),p.d(),P=!1,O()}}}function el(e){let t,n,l,i,c,u,r;function o(g,_){return g[0]&&g[0].length>0?Qn:Gn}let a=o(e),h=a(e);return{c(){t=f("div"),n=f("button"),n.innerHTML=`<span class="mdi mdi-arrow-left"></span>
    Back to Vehicles`,l=y(),i=f("h2"),i.textContent="My Active Rentals",c=y(),h.c(),d(n,"class","back-btn svelte-1tfrzki"),d(i,"class","svelte-1tfrzki"),d(t,"class","active-rentals svelte-1tfrzki")},m(g,_){M(g,t,_),s(t,n),s(t,l),s(t,i),s(t,c),h.m(t,null),u||(r=J(n,"click",e[1]),u=!0)},p(g,[_]){a===(a=o(g))&&h?h.p(g,_):(h.d(1),h=a(g),h&&(h.c(),h.m(t,null)))},i:A,o:A,d(g){g&&L(t),h.d(),u=!1,r()}}}function tl(e){fetch("https://vein-rentals/returnVehicle",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({rentalId:e})}).then(t=>t.json()).then(t=>{t.success})}function nl(e,t,n){let l;X(e,Re,u=>n(0,l=u));function i(){bt()}return[l,i,u=>tl(u.id)]}class ll extends Ne{constructor(t){super(),Te(this,t,nl,el,we,{})}}function sl(e){let t,n,l,i,c,u,r,o,a,h,g,_,b,m,w,P,O,S,C,p,k,v;return C=new Dn({props:{routes:e[3]}}),{c(){t=f("main"),n=f("div"),l=f("div"),i=f("h1"),i.textContent="Premium Vehicle Rentals",c=y(),u=f("h2"),r=$(e[2]),o=y(),a=f("div"),h=f("span"),g=y(),_=f("span"),b=$(e[1]),m=$(" Loyalty Points"),w=y(),P=f("button"),P.innerHTML='<span class="mdi mdi-close"></span>',O=y(),S=f("div"),Me(C.$$.fragment),d(i,"class","svelte-1gbyypa"),d(u,"class","svelte-1gbyypa"),d(h,"class","mdi mdi-star svelte-1gbyypa"),d(a,"class","loyalty-points svelte-1gbyypa"),d(P,"class","close-btn svelte-1gbyypa"),d(l,"class","header svelte-1gbyypa"),d(S,"class","content svelte-1gbyypa"),d(n,"class","container fade-in slide-up svelte-1gbyypa"),d(t,"class","svelte-1gbyypa"),ee(t,"visible",e[0])},m(E,j){M(E,t,j),s(t,n),s(n,l),s(l,i),s(l,c),s(l,u),s(u,r),s(l,o),s(l,a),s(a,h),s(a,g),s(a,_),s(_,b),s(_,m),s(l,w),s(l,P),s(n,O),s(n,S),ye(C,S,null),p=!0,k||(v=J(P,"click",e[4]),k=!0)},p(E,[j]){(!p||j&4)&&R(r,E[2]),(!p||j&2)&&R(b,E[1]),(!p||j&1)&&ee(t,"visible",E[0])},i(E){p||(te(C.$$.fragment,E),p=!0)},o(E){ue(C.$$.fragment,E),p=!1},d(E){E&&L(t),ke(C),k=!1,v()}}}function il(e,t){const n=document.createElement("div");n.className=`notification ${t} fade-in`,n.textContent=e,document.body.appendChild(n),setTimeout(()=>{n.classList.remove("fade-in"),n.classList.add("fade-out"),setTimeout(()=>{document.body.removeChild(n)},300)},3e3)}function ol(e,t,n){let l,i,c,u,r;X(e,vt,_=>n(0,l=_)),X(e,Re,_=>n(6,i=_)),X(e,xt,_=>n(1,c=_)),X(e,tt,_=>n(7,u=_)),X(e,Qt,_=>n(2,r=_));let o={primary:"#3f51b5",secondary:"#f44336",accent:"#4caf50",background:"#f5f5f5",text:"#212121"};const a={"/":pt({component:Jn}),"/vehicle/:model":pt({component:Wn}),"/active-rentals":pt({component:ll})};window.addEventListener("message",_=>{const b=_.data;switch(b.action){case"openRentalMenu":ae(Qt,r=b.data.location,r),ae(tt,u=b.data.categories,u),ae(Re,i=b.data.activeRentals,i),ae(xt,c=b.data.loyaltyPoints,c),ae(vt,l=!0,l);break;case"updateVehicles":break;case"updateConfig":o=b.data.colors,h();break;case"updateActiveRentals":ae(Re,i=b.data,i);break;case"notification":il(b.data.message,b.data.type);break}});function h(){document.documentElement.style.setProperty("--color-primary",o.primary),document.documentElement.style.setProperty("--color-secondary",o.secondary),document.documentElement.style.setProperty("--color-accent",o.accent),document.documentElement.style.setProperty("--color-background",o.background),document.documentElement.style.setProperty("--color-text",o.text)}function g(){ae(vt,l=!1,l),fetch("https://vein-rentals/closeMenu",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({})})}return vn(()=>{h(),fetch("https://vein-rentals/nuiReady",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({})}),window.addEventListener("keyup",_=>{_.key==="Escape"&&g()})}),[l,c,r,a,g]}class rl extends Ne{constructor(t){super(),Te(this,t,ol,sl,we,{})}}new rl({target:document.getElementById("app")});
