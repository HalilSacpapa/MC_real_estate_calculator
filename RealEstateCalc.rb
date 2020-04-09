require 'gtk2'

s_int = 0
s_ext = 0
s_pool = 0
s_all = 0
s_coef = 0
s_ret = 0
s_opp = 0
s_c, s_c2, s_c3, s_c4, s_c5, s_c6, res = false

Gtk.init
window = Gtk::Window.new
window.set_title('Real Estate Calculator')
window.signal_connect('destroy') { Gtk.main_quit }

vb = Gtk::VBox.new(true, 6)
#Define house surface
    hb = Gtk::HBox.new(false, 6)
    hb.pack_start(Gtk::Label.new('Surface (intérieur)'), false, true, 6)
    interior = Gtk::Entry.new
    interior.signal_connect('activate') {
        s_all -= (s_int * 5)
        s_int = 0
        s_int = interior.text.to_f
        s_all += (s_int * 5)
    }
    hb.pack_start(interior, true, true)
    vb.pack_start(hb)

    hb = Gtk::HBox.new(false, 6)
    hb.pack_start(Gtk::Label.new('Surface (balcon & jardin)'), false, true, 6)
    exterior = Gtk::Entry.new
    exterior.signal_connect('activate') {
        s_all -= (s_ext * 10)
        s_ext = 0
        s_ext = exterior.text.to_f
        s_all += (s_ext * 10)
    }
    hb.pack_start(exterior, true, true)
    vb.pack_start(hb)

    hb = Gtk::HBox.new(false, 6)
    hb.pack_start(Gtk::Label.new('Surface (piscine)'), false, true, 6)
    pool = Gtk::Entry.new
    pool.signal_connect('activate') {
        s_all -= (s_pool * 25)
        s_pool = 0
        s_pool = pool.text.to_f
        s_all += (s_pool * 25)
    }
    hb.pack_start(pool, true, true)
    vb.pack_start(hb)

# Define price coeficient
    b = Gtk::CheckButton.new('Vue bâtiment (< 10b)') # -20%
    b.signal_connect('clicked') {
        if s_c == true
            s_coef += 20
            s_c = false
        else
            s_coef -= 20
            s_c = true
        end
    }
    vb.pack_start(b)

    hb = Gtk::VBox.new(true, 6) # vis à vis
        b = Gtk::RadioButton.new('Pas de vis-à-vis')
        b.signal_connect('clicked') { s_opp = 0 }
        vb.pack_start(b)

        b2 = Gtk::RadioButton.new(b, 'Vis-à-vis (< 20b)') # -10%
        b2.signal_connect('clicked') { s_opp = 10 }
        vb.pack_start(b2)

        b3 = Gtk::RadioButton.new(b2, 'Vis-à-vis (< 10b)') # -15%
        b3.signal_connect('clicked') { s_opp = 15 }
        vb.pack_start(b3)

        b4 = Gtk::RadioButton.new(b3, 'Vis-à-vis sur lit (< 10b)') # -25%
        b4.signal_connect('clicked') { s_opp = 25 }
        vb.pack_start(b4)

    b2 = Gtk::CheckButton.new('Vue nature') # +20%
    b2.signal_connect('clicked') {
        if s_c2 == true
            s_coef -= 20
            s_c2 = false
        else
            s_coef += 20
            s_c2 = true
        end
    }
    vb.pack_start(b2)

    b3 = Gtk::CheckButton.new('Loisir (max 3 rues)') # +5%
    b3.signal_connect('clicked') {
        if s_c3 == true
            s_coef -= 5
            s_c3 = false
        else
            s_coef += 5
            s_c3 = true
        end
    }
    vb.pack_start(b3)

    hb = Gtk::VBox.new(true, 50) # commerce
        b = Gtk::RadioButton.new('Pas de commerce')
        b.signal_connect('clicked') { s_ret = 0 }
        vb.pack_start(b)

        b2 = Gtk::RadioButton.new(b, 'Commerce') # +10%
        b2.signal_connect('clicked') { s_ret = 10 }
        vb.pack_start(b2)

        b3 = Gtk::RadioButton.new(b2, 'Commerce (max 3 rues)') # +5%
        b3.signal_connect('clicked') { s_ret = 5 }
        vb.pack_start(b3)

    b4 = Gtk::CheckButton.new('Nuisance sonore') # -5%
    b4.signal_connect('clicked') {
        if s_c4 == true
            s_coef += 5
            s_c4 = false
        else
            s_coef -= 5
            s_c4 = true
        end
    }
    vb.pack_start(b4)

    b5 = Gtk::CheckButton.new('Douche') # +10%
    b5.signal_connect('clicked') {
        if s_c5 == true
            s_coef -= 10
            s_c5 = false
        else
            s_coef += 10
            s_c5 = true
        end
    }
    vb.pack_start(b5)

    b6 = Gtk::CheckButton.new('Maison') # +25%
    b6.signal_connect('clicked') {
        if s_c6 == true
            s_coef -= 25
            s_c6 = false
        else
            s_coef += 25
            s_c6 = true
        end
    }
    vb.pack_start(b6)

    submit = Gtk::Button.new(Gtk::Stock::OK)
    submit.signal_connect('clicked') {
        res = true
        s_coef -= s_opp
        s_coef += s_ret
        Gtk.main_quit
    }
    vb.pack_start(submit)
    close = Gtk::Button.new(Gtk::Stock::CANCEL)
    close.signal_connect('clicked') { Gtk.main_quit }
    vb.pack_start(close)

window.add(vb)
window.show_all

Gtk.main

if res == true
    Gtk.init
    window2 = Gtk::Window.new
    window2.set_title('Result')
    window2.signal_connect('destroy') { Gtk.main_quit }

# display result
    vb = Gtk::VBox.new(true, 6)
        result = Gtk::Label.new("Prix actuel : #{(((s_coef.to_f / 100.0) * s_all.to_f) + s_all.to_f)} Emrd");
        result.set_size_request(250, 50);
        vb.pack_start(result);
        close = Gtk::Button.new(Gtk::Stock::CLOSE)
        close.signal_connect('clicked') { Gtk.main_quit }
        vb.pack_start(close)

    window2.add(vb)
    window2.show_all

    Gtk.main
end