#!/usr/bin/env python3
"""Generate the omegaui profile README SVGs in dark and light variants.

Usage: python3 gen.py OUT_DIR
Every SVG uses an XHTML foreignObject (same technique as the current README),
honours prefers-reduced-motion, and uses only system fonts.
"""
import sys, os

THEMES = {
    "dark": dict(
        card1="#0f1522", card2="#121b2c", border="#232c3a", text="#e6edf3",
        muted="#9198a1", faint="#5d6672", pink="#ff4f9d", cyan="#2ee6d2",
        codebg="rgba(255,255,255,0.035)", codeborder="#1f2733",
        pillbg="rgba(255,255,255,0.03)", pillborder="#262f3b",
        green="#3fb950", red="#f85149", grid="rgba(46,230,210,0.035)",
        bun="#fbf0df", ollama="#e6edf3",
    ),
    "light": dict(
        card1="#ffffff", card2="#f6f8fb", border="#d1d9e0", text="#1f2328",
        muted="#59636e", faint="#8c959f", pink="#d6287a", cyan="#0a8f82",
        codebg="#f6f8fa", codeborder="#e1e6eb",
        pillbg="#f6f8fa", pillborder="#d1d9e0",
        green="#1a7f37", red="#cf222e", grid="rgba(10,143,130,0.05)",
        bun="#c9a66b", ollama="#1f2328",
    ),
}

FONT = '-apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, "Hiragino Sans", "Noto Sans JP", sans-serif'
MONO = 'ui-monospace, "SF Mono", "JetBrains Mono", "Fira Code", Menlo, Consolas, monospace'

REDUCED = "@media (prefers-reduced-motion: reduce) { *, *::before, *::after { animation: none !important; } }"


def svg(w, h, css, body):
    return f'''<svg fill="none" viewBox="0 0 {w} {h}" width="{w}" height="{h}" xmlns="http://www.w3.org/2000/svg">
\t<foreignObject width="100%" height="100%">
\t\t<div xmlns="http://www.w3.org/1999/xhtml">
\t\t\t<style>
* {{ margin: 0; padding: 0; box-sizing: border-box; }}
{css}
{REDUCED}
\t\t\t</style>
{body}
\t\t</div>
\t</foreignObject>
</svg>
'''


CARD_BASE = """
.card {{
  position: relative; overflow: hidden;
  background: linear-gradient(150deg, {card1} 0%, {card2} 100%);
  border: 1px solid {border}; border-radius: 14px;
  font-family: {font}; color: {text};
}}
"""

# ---------------------------------------------------------------- header
MOON_CSS = """
.moonwrap { position: relative; width: 236px; height: 248px; flex: none; }
.container { position: absolute; width: 370px; height: 370px; left: 50%; top: 50%;
  transform: translate(-50%, -50%) scale(0.6); }
.moon { background-color: #ff3995; height: 170px; width: 170px; border-radius: 50%;
  position: absolute; margin: auto; left: 0; right: 0; top: 0; bottom: 0; overflow: hidden;
  animation: headsup 2.4s infinite ease-in-out alternate; }
@keyframes headsup { 100% { transform: translateY(8px) scale(1.03); } }
.face { animation: smile 2.4s infinite ease-in-out alternate; }
@keyframes smile { 100% { transform: translateY(-3px); } }
.crater { background-color: #ff3198; height: 30px; width: 30px; border-radius: 50%; position: relative; }
.crater::before { content: ""; position: absolute; height: 25px; width: 25px; border-radius: 50%;
  box-shadow: -5px 0 0 2px #f91c7c; top: 2px; left: 7px; }
.crater-1 { top: 27px; left: 90px; transform: scale(0.9); }
.crater-2 { bottom: 15px; left: 61px; transform: scale(0.6); }
.crater-3 { left: 15px; transform: scale(0.75); }
.crater-4 { left: 107px; top: 32px; transform: scale(1.18); }
.crater-5 { left: 33px; bottom: 4px; transform: scale(0.65); }
.shadow { height: 190px; width: 190px; box-shadow: 21px 0 0 5px rgba(0,0,0,0.15);
  border-radius: 50%; position: relative; bottom: 157.5px; right: 46px; }
.eye { height: 12px; width: 12px; background-color: #161616; position: relative; border-radius: 50%; }
.eye-l { bottom: 255px; left: 59px; }
.eye-r { bottom: 267px; left: 101px; }
.mouth { height: 5px; width: 10px; border: 3px solid #161616; position: relative; bottom: 262px;
  left: 79px; border-top: none; border-radius: 0 0 40px 40px; }
.blush { height: 7.5px; width: 7.5px; background-color: #f91c44; position: relative; border-radius: 50%; }
.blush-1 { bottom: 273px; left: 50px; }
.blush-2 { bottom: 281px; left: 115px; }
.orbit { height: 280px; width: 280px; border-radius: 50%; position: absolute; margin: auto;
  left: 0; right: 0; top: 0; bottom: 0; animation: spin 14s infinite linear; }
@keyframes spin { 100% { transform: rotate(360deg); } }
.ring { position: absolute; inset: 0; margin: auto; width: 280px; height: 280px; border-radius: 50%;
  border: 2px dashed {orbitline}; }
.rocket { background-color: #fafcf7; border: 2px solid #ebabc4; height: 50px; width: 25px;
  border-radius: 50% 50% 0 0; position: relative; left: -11px; top: 115px; }
.rocket::before { position: absolute; content: ""; background-color: #ff397b; height: 20px; width: 55px;
  z-index: -1; border-radius: 50% 50% 0 0; right: -15px; bottom: 0; }
.rocket::after { position: absolute; content: ""; background-color: #ff398f; height: 4px; width: 15px;
  border-radius: 0 0 2px 2px; bottom: -4px; left: 4.3px; }
.window { height: 10px; width: 10px; background-color: #ffebf4; border: 2px solid #ecb8cd;
  border-radius: 50%; position: relative; top: 17px; left: 5px; }
"""

MOON_HTML = """
<div class="moonwrap"><div class="container">
  <div class="ring"></div>
  <div class="moon">
    <div class="crater crater-1"></div><div class="crater crater-2"></div><div class="crater crater-3"></div>
    <div class="crater crater-4"></div><div class="crater crater-5"></div><div class="shadow"></div>
    <div class="face"><div class="eye eye-l"></div><div class="eye eye-r"></div><div class="mouth"></div>
      <div class="blush blush-1"></div><div class="blush blush-2"></div></div>
  </div>
  <div class="orbit"><div class="rocket"><div class="window"></div></div></div>
</div></div>
"""


def header(t):
    css = CARD_BASE.format(font=FONT, **t) + MOON_CSS.replace("{orbitline}", t["border"]) + f"""
.card {{ width: 790px; height: 250px; margin: 5px; display: flex; align-items: center; }}
.grid {{ position: absolute; inset: 0; background-image:
  linear-gradient({t['grid']} 1px, transparent 1px), linear-gradient(90deg, {t['grid']} 1px, transparent 1px);
  background-size: 32px 32px; mask-image: linear-gradient(90deg, #000 0%, transparent 45%);
  -webkit-mask-image: linear-gradient(90deg, #000 0%, transparent 45%); }}
.right {{ position: relative; flex: 1; padding: 0 36px 0 6px; }}
.eyebrow {{ display: flex; align-items: center; gap: 8px; font-family: {MONO}; font-size: 11px;
  color: {t['faint']}; letter-spacing: 0.4px; margin-bottom: 10px; }}
.live {{ width: 7px; height: 7px; border-radius: 50%; background: {t['cyan']};
  animation: pulse 2.4s ease-in-out infinite; }}
@keyframes pulse {{ 0%,100% {{ opacity: .45; }} 50% {{ opacity: 1; }} }}
.namerow {{ display: flex; align-items: baseline; gap: 12px; }}
.name {{ font-size: 40px; font-weight: 750; letter-spacing: -1px; line-height: 1; }}
.kana {{ font-size: 19px; font-weight: 600; color: {t['pink']}; letter-spacing: 1px; }}
.tag {{ margin-top: 10px; font-size: 15px; line-height: 1.5; color: {t['muted']}; max-width: 480px; }}
.log {{ margin-top: 16px; display: grid; grid-template-columns: 62px 1fr; row-gap: 5px;
  font-family: {MONO}; font-size: 11.5px; line-height: 1.45; }}
.k {{ color: {t['cyan']}; }}
.v {{ color: {t['text']}; opacity: .88; white-space: nowrap; }}
.v b {{ color: {t['pink']}; font-weight: 600; }}
"""
    body = f"""
<div class="card">
  <div class="grid"></div>
  {MOON_HTML}
  <div class="right">
    <div class="eyebrow"><div class="live"></div>github.com/omegaui</div>
    <div class="namerow"><span class="name">Arham</span><span class="kana">アルハム</span></div>
    <div class="tag">Full stack engineer, backend at heart. I build the systems that quietly keep products running, and Linux tools for fun.</div>
    <div class="log">
      <span class="k">now</span><span class="v">senior full stack developer · remote (Europe)</span>
      <span class="k">before</span><span class="v">tech lead, billing platform used by <b>1000s</b> of businesses</span>
      <span class="k">also</span><span class="v">日本語 · <b>JLPT N2</b> certified</span>
    </div>
  </div>
</div>"""
    return svg(800, 260, css, body)


# ---------------------------------------------------------------- stack
STACK = [
    ("backend", [("Node.js", "#5FA04E"), ("Bun", "{bun}"), ("TypeScript", "#3178C6"), ("Go", "#00ADD8"),
                 ("Postgres · Supabase", "#3ECF8E"), ("Redis Cluster", "#DC382D"), ("Deno", "#70FFAF")]),
    ("infra", [("Docker", "#2496ED"), ("GCP", "#4285F4"), ("AWS", "#FF9900"), ("DigitalOcean", "#0080FF"),
               ("Self-hosting", "#A78BFA"), ("Linux", "#FCC624"), ("Ollama", "{ollama}")]),
    ("clients", [("Flutter", "#027DFD"), ("Dart", "#00B4AB"), ("Kotlin", "#A97BFF"),
                 ("Jetpack Compose", "#4285F4"), ("React", "#61DAFB"), ("Java", "#B07219")]),
]


def stack(t):
    css = f"""
.wrap {{ width: 800px; padding: 6px 5px; font-family: {FONT}; }}
.row {{ display: flex; align-items: center; gap: 6px; height: 38px; }}
.lbl {{ width: 78px; flex: none; font-family: {MONO}; font-size: 11px; color: {t['faint']};
  letter-spacing: 1.2px; text-transform: uppercase; }}
.row:first-child .lbl {{ color: {t['cyan']}; }}
.pill {{ display: inline-flex; align-items: center; gap: 6px; padding: 6px 10px; border-radius: 999px;
  background: {t['pillbg']}; border: 1px solid {t['pillborder']}; font-size: 12px; font-weight: 500;
  color: {t['text']}; white-space: nowrap; }}
.row:not(:first-child) .pill {{ color: {t['muted']}; }}
.dot {{ width: 8px; height: 8px; border-radius: 50%; flex: none; }}
"""
    rows = []
    for label, items in STACK:
        pills = "".join(
            f'<span class="pill"><span class="dot" style="background:{c.format(**t)}"></span>{n}</span>'
            for n, c in items)
        rows.append(f'<div class="row"><span class="lbl">{label}</span>{pills}</div>')
    body = '<div class="wrap">' + "".join(rows) + "</div>"
    return svg(800, 130, css, body)


# ---------------------------------------------------------------- featured cards
def featured(t, badge, accent, title, lang, langc, desc, code_lines):
    a = t[accent]
    css = CARD_BASE.format(font=FONT, **t) + f"""
.card {{ width: 388px; height: 268px; margin: 4px; padding: 22px 22px 20px; display: flex; flex-direction: column; }}
.glow {{ position: absolute; right: -60px; top: -60px; width: 180px; height: 180px; border-radius: 50%;
  background: radial-gradient(circle, {a}22 0%, transparent 70%); }}
.top {{ display: flex; justify-content: space-between; align-items: center; }}
.badge {{ font-family: {MONO}; font-size: 10.5px; letter-spacing: 1.3px; text-transform: uppercase;
  color: {a}; border: 1px solid {a}55; background: {a}12; padding: 3px 10px; border-radius: 999px; }}
.lang {{ display: flex; align-items: center; gap: 6px; font-size: 12px; color: {t['muted']}; }}
.ldot {{ width: 9px; height: 9px; border-radius: 50%; background: {langc}; }}
.title {{ margin-top: 14px; font-size: 24px; font-weight: 750; letter-spacing: -0.5px; }}
.desc {{ margin-top: 6px; margin-bottom: 12px; font-size: 13.5px; line-height: 1.5; color: {t['muted']}; }}
.code {{ flex: none; margin-top: auto; background: {t['codebg']}; border: 1px solid {t['codeborder']}; border-radius: 8px;
  padding: 8px 12px; font-family: {MONO}; font-size: 11.5px; line-height: 1.65; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }}
.p {{ color: {a}; }} .c {{ color: {t['text']}; }} .f {{ color: {t['faint']}; }}
.ok {{ color: {t['green']}; }} .no {{ color: {t['red']}; }}
.cur {{ display: inline-block; width: 7px; height: 13px; background: {a}; margin-left: 3px;
  vertical-align: -2px; animation: blink 1.1s step-end infinite; }}
@keyframes blink {{ 50% {{ opacity: 0; }} }}
"""
    code = "".join(f"<div>{l}</div>" for l in code_lines)
    body = f"""
<div class="card"><div class="glow"></div>
  <div class="top"><span class="badge">{badge}</span><span class="lang"><span class="ldot"></span>{lang}</span></div>
  <div class="title">{title}</div>
  <div class="desc">{desc}</div>
  <div class="code">{code}</div>
</div>"""
    return svg(396, 276, css, body)


# ---------------------------------------------------------------- small cards
ICONS = {
    "eye": ("""
.eye { width: 30px; height: 15px; border: 1.5px solid {a}88; border-radius: 50%; position: relative;
  background: {a}12; animation: eyeBlink 5s ease-in-out infinite; }
@keyframes eyeBlink { 0%, 44%, 48%, 100% { transform: scaleY(1); } 46% { transform: scaleY(0.1); } }
.pupil { width: 8px; height: 8px; background: {a}; border-radius: 50%; position: absolute; top: 2px; left: 9.5px; }
""", '<div class="eye"><div class="pupil"></div></div>'),
    "wave": ("""
.wave { display: flex; align-items: center; gap: 3px; height: 18px; }
.wave i { display: block; width: 3px; border-radius: 2px; background: {a}; animation: bar 1.4s ease-in-out infinite; }
.wave i:nth-child(1) { height: 6px; } .wave i:nth-child(2) { height: 14px; animation-delay: .2s; }
.wave i:nth-child(3) { height: 18px; animation-delay: .4s; } .wave i:nth-child(4) { height: 10px; animation-delay: .6s; }
.wave i:nth-child(5) { height: 5px; animation-delay: .8s; }
@keyframes bar { 50% { transform: scaleY(0.4); } }
""", '<div class="wave"><i></i><i></i><i></i><i></i><i></i></div>'),
    "pad": ("""
.pad { width: 34px; height: 20px; border-radius: 10px; border: 1.5px solid {a}88; background: {a}12; position: relative; }
.pad::before { content: ""; position: absolute; left: 6px; top: 7.5px; width: 8px; height: 2px; background: {a};
  box-shadow: 0 0 0 0 {a}; }
.pad::after { content: ""; position: absolute; left: 9px; top: 4.5px; width: 2px; height: 8px; background: {a}; }
.btn { position: absolute; width: 4px; height: 4px; border-radius: 50%; background: {a}; }
.b1 { right: 6px; top: 5px; animation: press 2s ease-in-out infinite; } .b2 { right: 10px; top: 10px; }
@keyframes press { 50% { opacity: .3; } }
""", '<div class="pad"><span class="btn b1"></span><span class="btn b2"></span></div>'),
}


def small(t, name, desc, lang, langc, icon):
    a = langc
    icss, ihtml = ICONS[icon]
    css = CARD_BASE.format(font=FONT, **t) + icss.replace("{a}", a) + f"""
.card {{ width: 256px; height: 160px; margin: 4px; padding: 18px 18px 16px 20px; }}
.accent {{ position: absolute; left: 0; top: 0; bottom: 0; width: 3px; background: {a}; }}
.icon {{ position: absolute; top: 18px; right: 16px; }}
.name {{ font-size: 15px; font-weight: 650; padding-right: 48px; letter-spacing: -0.2px; }}
.desc {{ margin-top: 8px; font-size: 13px; line-height: 1.5; color: {t['muted']}; }}
.meta {{ position: absolute; left: 20px; bottom: 15px; display: flex; align-items: center; gap: 6px;
  font-size: 11.5px; color: {t['muted']}; }}
.ldot {{ width: 9px; height: 9px; border-radius: 50%; background: {langc}; }}
"""
    body = f"""
<div class="card"><div class="accent"></div><div class="icon">{ihtml}</div>
  <div class="name">{name}</div><div class="desc">{desc}</div>
  <div class="meta"><span class="ldot"></span>{lang}</div>
</div>"""
    return svg(264, 168, css, body)


def main(out):
    os.makedirs(out, exist_ok=True)
    for mode, t in THEMES.items():
        files = {
            "header": header(t),
            "stack": stack(t),
            "card-gpm": featured(
                t, "package manager", "cyan", "gpm", "Dart", "#00B4AB",
                "Install apps straight from GitHub repos, with updates built in. "
                "Package management meets cross-platform builds.",
                ['<span class="p">❯</span> <span class="c">gpm install</span> <span class="f">user/repo</span>',
                 '<span class="f">resolving release · building from source</span>',
                 '<span class="ok">✔ installed</span><span class="f"> · tracked for updates</span><span class="cur"></span>']),
            "card-reqseal": featured(
                t, "api security", "pink", "reqseal", "JavaScript", "#F1E05A",
                "Replay protection for HTTP APIs, using one-time, "
                "time-bounded keys checked by O(1) middleware.",
                ['<span class="p">→</span> <span class="c">x-reqseal-key:</span> <span class="f">k9·2f·7a·q1</span>',
                 '<span class="ok">✔ fresh</span><span class="f"> · inside the 30s window</span>',
                 '<span class="no">✖ replayed</span><span class="f"> · key already seen, rejected</span>']),
            "card-nakime": small(t, "nakime", "Tracks PC sessions and flags unauthorized access attempts.",
                                 "Dart", "#00B4AB", "eye"),
            "card-aquiny": small(t, "aquiny", "Voice desktop reminders, scheduled in plain language.",
                                 "Python", "#3572A5" if mode == "light" else "#5B9BD5", "wave"),
            "card-terraria-gamepad": small(t, "terraria_gamepad", "Turns your phone into a wireless gamepad for Terraria.",
                                           "Kotlin", "#A97BFF", "pad"),
        }
        for name, content in files.items():
            with open(os.path.join(out, f"{name}-{mode}.svg"), "w") as fh:
                fh.write(content)
    print("wrote", sorted(os.listdir(out)))


if __name__ == "__main__":
    main(sys.argv[1])
