#!/usr/bin/env ruby

require 'gtk3'
require_relative 'GGrille.rb'
require_relative '../Grille/GrilleJouable.rb'

module Gui
    
    ##
    # Application de test pour Gui::GGrille.
    #
    # Représente une fenêtre contenant une Gui::GGrille.
	#
	# Pour lancer le script : <tt>./GUI/GrilleTest.rb</tt> depuis la racine
	# du dépôt.
    class GrilleTest < Gtk::Window
        
        private_class_method :new
        
        ##
        # Crée une fenêtre contenant une Gui::GGrille représentant la Grille
        # donnée.
        #
        # Paramètres :
        # [+grille+]  Grille
        def GrilleTest.creer(grille)
            f = new
            
            f.set_title("Nurikabe")
            
            f.signal_connect("destroy") { Gtk.main_quit }
            
            f.set_window_position(Gtk::WindowPosition::CENTER)
            
            f.add(GGrille.creer(grille))
            
            f.show
            
            return f
        end
        
    end
  
end

Gtk.init if Gtk.respond_to?(:init)
	provider = Gtk::CssProvider.new
	screen = Gdk::Display.default.default_screen
	Gtk::StyleContext.add_provider_for_screen(screen, provider, 20000)
	provider.load(path: "GUI/grille.css")
    fenetre = Gui::GrilleTest.creer(GrilleJouable.creer(1))
Gtk.main
