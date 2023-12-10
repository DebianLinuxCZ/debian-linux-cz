# Debian-Linux.cz

Repositář pro web Debian-Linux.cz. Web používá generátor statických stránek [Jekyll](https://jekyllrb.com/).

### Šablona
Web používá šablonu [minimal-mistakes](https://github.com/mmistakes/minimal-mistakes).

### Obsah
Obsah všech stránek je v adresáři `_pages` a je psaný v HTML nebo Markdownu. Analogicky příspěvky na blog jsou v adresáři `_posts`. Pár stránek o Markdownu:
- [Mastering Markdown - GitHub Guides](https://guides.github.com/features/mastering-markdown/)
- [Basic writing and formatting syntax - User Documentation](https://help.github.com/articles/basic-writing-and-formatting-syntax/)
- [Syntax | kramdown](https://kramdown.gettalong.org/syntax.html)

### Příprava
Abyste byli schopni spustit níže uvedené příkazy, je nutné mít nainstalované [Ruby 3.1](https://www.ruby-lang.org/en/documentation/installation/), které je [výchozí v Debianu](https://packages.debian.org/bookworm/ruby), a GNU Make.

Před prvním sestavením (nebo po změně souboru `Gemfile`) je potřeba stáhnout potřebné závislosti.
```
$ make prepare
```

### Náhled
Při úpravách vzhledu i obsahu je dobré rovnou se podívat na výsledek. Níže uvedený příkaz sestaví obsah repositáře a zpřístupní ho na lokální adrese http://localhost:4000/.
```
$ make run
```
Příkaz stačí spustit jednou v samostatném terminálu a nechat běžet. Pokud pak ve zdrojových souborech provedete nějakou změnu, Jekyll sestaví stránky znovu. Pro zobrazení efektu změn stačí obnovit načtenou stránku v prohlížeči (*F5*).

## Sestavení statické verze
Pro sestavení webu slouží tento příkaz.
```
$ make build
```
Statická verze stránek je vygenerovaná do adresáře `_site`. Pro nasazení stačí jeho obsah nahrát na server třeba přes FTP.
