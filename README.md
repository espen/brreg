# Søk i Enhetsregisteret i Brønnøysundregisteret

Søk i Enhetsregisteret basert på firmanavn, organisasjonsnummer eller ved oppslag på norske domener hos Norid.

## Installasjon

```shell
$ gem install brreg
$ brreg -h
```

## I bruk

```shell
brreg [options]
-n, --orgnr ORGNR                Organisasjonsnummer
-q, --query QUERY                Firmanavn
-d, --domain DOMAIN              Domenenavn (kun .no)
-v, --version                    Versjon
```

## Eksempel

```shell
~ brreg inspired
Søker etter 'inspired'
...............
994502085 GET INSPIRED AS
996617742 INSPIRED BY ADELINA GRENMAR
992842318 INDIGO INSPIRED INITIATIVE STENSRUD
999205224 UNGDOMSBEDRIFTEN INSPIRED
999309755 INSPIRED UNGDOMSBEDRIFT
994317318 INSPIRED THINKING Wenche A Buchman
990610924 INSPIRED AS

~ brreg 990610924
Viser oppføring for orgnr 990610924
...............
INSPIRED AS
Sverdrups gate 26B
0559 OSLO
Postadresse:
Postboks 218 Sentrum
0103 OSLO

~ brreg makeplans.no
Viser oppføring for orgnr 817201342
...............
MAKEPLANS AS
Sverdrups gate 26B
0559 OSLO
Postadresse:
c/o Inspired AS Postboks 218 Sentrum
0103 OSLO

Basert på Whois fra domenet makeplans.no
```