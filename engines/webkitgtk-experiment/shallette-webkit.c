/* Shallette second-engine experiment: WebKitGTK shell with a Zen-style sidebar.
 *
 * Status: source committed, not yet compiled on this host — openSUSE needs
 *   sudo zypper in webkit2gtk3-devel gtk3-devel
 * after which:
 *   make && ./shallette-webkit https://example.com
 *
 * Layout goal (per docs/ARCHITECTURE.md): the engine renders CONTENT only;
 * the Zen-look chrome (vertical tab strip, compact mode, theme palette) is ours.
 */
#include <gtk/gtk.h>
#include <webkit2/webkit2.h>

static void on_destroy(GtkWidget *w, gpointer data) { gtk_main_quit(); }

int main(int argc, char **argv) {
    const char *url = argc > 1 ? argv[1] : "https://example.com";

    gtk_init(&argc, &argv);

    GtkWidget *win = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title(GTK_WINDOW(win), "Shallette (WebKitGTK)");
    gtk_window_set_default_size(GTK_WINDOW(win), 1024, 700);
    g_signal_connect(win, "destroy", G_CALLBACK(on_destroy), NULL);

    /* Zen-style geometry: fixed-width sidebar left, engine view right. */
    GtkWidget *paned = gtk_paned_new(GTK_ORIENTATION_HORIZONTAL);
    GtkWidget *sidebar = gtk_box_new(GTK_ORIENTATION_VERTICAL, 4);
    gtk_widget_set_size_request(sidebar, 220, -1);
    GtkWidget *label = gtk_label_new("Shallette");
    gtk_widget_set_margin_top(label, 12);
    GtkWidget *view = webkit_web_view_new();

    gtk_box_pack_start(GTK_BOX(sidebar), label, FALSE, FALSE, 4);
    gtk_paned_pack1(GTK_PANED(paned), sidebar, FALSE, FALSE);
    gtk_paned_pack2(GTK_PANED(paned), view, TRUE, FALSE);
    gtk_container_add(GTK_CONTAINER(win), paned);

    webkit_web_view_load_uri(WEBKIT_WEB_VIEW(view), url);
    gtk_widget_show_all(win);
    gtk_main();
    return 0;
}
