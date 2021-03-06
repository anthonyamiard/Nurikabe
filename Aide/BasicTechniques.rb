require_relative '../Grille/CaseJouable.rb'
require_relative '../Grille/CaseNumero.rb'

##
# Techniques d'aides basiques
#
# On suppose que les "StartingTechniques" ont été appliquées

class BasicTechniques

  ##
  # Techique de la case vide entourée
  #
  # Surrounded square
  # Since these squares are surrounded by walls horizontally and vertically they cannot belong to an island and must therefore be shaded to be part of a wall
  #
  # Paramètres :
  # [+grille+] Case courante sur laquelle est associé une aide
	# [+tab+] Tableau contenant les aides (pour la grille du joueur courant)
  def BasicTechniques.caseVideEntoure(grille, tab)
    taille_colonne = grille.solution().taille_colonne()
    taille_ligne = grille.solution().taille_ligne()
    tabJeu = grille.grille().grille() # Array

    (0..(taille_colonne - 2)).each { |i| # Parcours ligne

      (0..(taille_ligne - 2)).each { |j| # Parcours colonne

        if (tabJeu[i][j].class == Grille::CaseJouable) && (tabJeu[i][j].etatCase() == :BLANC)

          # ***** Tests existences des voisins *****

          nbVoisins = 0

          if ((i - 1) >= 0) && (tabJeu[i - 1][j].class == Grille::CaseJouable)
            nbVoisins += 1
            bCaseSup = true
          else
            bCaseSup = false
          end

          if ((i + 1) < taille_colonne) && (tabJeu[i + 1][j].class == Grille::CaseJouable)
            nbVoisins += 1
            bCaseInf = true
          else
            bCaseInf = false
          end

          if ((j + 1) < taille_ligne) && (tabJeu[i][j + 1].class == Grille::CaseJouable)
            nbVoisins += 1
            bCaseD = true
          else
            bCaseD = false
          end

          if ((j - 1) >= 0) && (tabJeu[i][j - 1].class == Grille::CaseJouable)
            nbVoisins += 1
            bCaseG = true
          else
            bCaseG = false
          end

          # ***** Tests couleur des voisins *****

          nbVoisinsNoir = 0

          if (bCaseSup) && (tabJeu[i - 1][j].etatCase() == :NOIR)
            nbVoisinsNoir += 1
          end

          if (bCaseInf) && (tabJeu[i + 1][j].etatCase() == :NOIR)
            nbVoisinsNoir += 1
          end

          if (bCaseD) && (tabJeu[i][j + 1].etatCase() == :NOIR)
            nbVoisinsNoir += 1
          end

          if (bCaseG) && (tabJeu[i][j - 1].etatCase() == :NOIR)
            nbVoisinsNoir += 1
          end

          # ***** Test final *****

          if (nbVoisins == nbVoisinsNoir)
            tab.push(Aide.creer(tabJeu[i][j], "Surrounded square"))
          end

        end

      }
    }

  end


  ##
  # Technique pour le calcul de la largeur du mur
  #
  # Avoiding wall area of 2x2
  # According to the rules it is not allowed to have wall areas of 2x2 or larger.
  #
  # Paramètres :
  # [+grille+] Case courante sur laquelle est associé une aide
	# [+tab+] Tableau contenant les aides (pour la grille du joueur courant)
  def BasicTechniques.largeurMur(grille, tab)
    taille_colonne = grille.solution().taille_colonne()
    taille_ligne = grille.solution().taille_ligne()
    tabJeu = grille.grille().grille() # Array

    (0..(taille_colonne - 2)).each { |i| # Parcours ligne
      (0..(taille_ligne - 2)).each { |j| # Parcours colonne
        if (tabJeu[i][j].class == Grille::CaseJouable) && (tabJeu[i+1][j+1].class == Grille::CaseJouable) && (tabJeu[i][j+1].class == Grille::CaseJouable) && (tabJeu[i+1][j].class == Grille::CaseJouable)
          if (tabJeu[i][j].etatCase() == :NOIR) && (tabJeu[i+1][j+1].etatCase() == :NOIR) && (tabJeu[i][j+1].etatCase() == :NOIR) && (tabJeu[i+1][j].etatCase() == :NOIR)
            tab.push(Aide.creer(tabJeu[i][j], "Mur trop large >= 2x2"))
          end
        end
      }
    }

  end

end
