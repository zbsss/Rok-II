# GIT cheatsheet

## git config --global user.name "Jan Nowak"
## git config --global user.email jan.nowak@gmail.com

## git config --unset --global user.email //usuwa

## git config user.name 
zwraca nazwe urzytkownika konktetnego repozytorium

## git init 
zaklada repozytorium tam gdzie uruchamiamy, (mozna podac sciezke)

## git clone https://... 

## git add nazwa_pliku 
dodaje plik do staging area 

## git status

## git commit -m "tresc" 
przenosi ze staging area do repozytorium

## git commit --amend 
edycja ostatniego commita

## git log 
historia commitow 

## git show 
pokazuje szczegolowo co sie zmienilo w danym commicie

## git diff nazwa_pliku 
roznica miedzy plikami miedzy wersja w katalogu roboczym a repozytorium

## git rm nazwa_pliku 
usuwa z katalogu roboczego i wersji z indeksu(najnowszego commitu)

## git rm --cached 
usuwa z indeksu, ale nie z katalogu roboczego

## git mv nazwa_pliku nowa_nazwa 
zmiana nazwy nazwa_pliku

## git checkout -- nazwa_pliku 
w katalogu roboczym przywracamy wersje z ostatniego commitu

## git reset 
przywraca w staging area wersje jaka byla w ostatnim commicie

# zalozyc puste repozytorium na githubie, wtedy mozna do niego wrzucic nasze lokalne ropozytorium za pomoca:
## git remote add origin link_do_repozytorium_na_githubie
## git push -u origin master 
tu powinno pokazac sie logowanie do githuba

