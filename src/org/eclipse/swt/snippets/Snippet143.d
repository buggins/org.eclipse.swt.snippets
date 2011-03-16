/*******************************************************************************
 * Copyright (c) 2000, 2005 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - initial API and implementation
 * Port to the D programming language
 *     Frank Benoit <benoit@tionex.de>
 *******************************************************************************/
module org.eclipse.swt.snippets.Snippet143;

/*
 * Tray example snippet: place an icon with a popup menu on the system tray
 *
 * For a list of all SWT example snippets see
 * http://www.eclipse.org/swt/snippets/
 *
 * @since 3.0
 */
import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.widgets.MenuItem;
import org.eclipse.swt.widgets.Tray;
import org.eclipse.swt.widgets.TrayItem;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Event;
import java.lang.all;
version(Tango){
    import tango.io.Stdout;
    import tango.text.convert.Format;
} else { // Phobos
    import std.stdio;
    import std.string;
}

TrayItem item;
Menu menu;

void main(String[] args) {
    Display display = new Display ();
    Shell shell = new Shell (display);
    Image image = new Image (display, 16, 16);
    Tray tray = display.getSystemTray ();
    if (tray is null) {
        version(Tango){
            Stdout.formatln ("The system tray is not available");
        } else { // Phobos
            writefln("The system tray is not available");
        }
    } else {
        item = new TrayItem (tray, SWT.NONE);
        item.setToolTipText("SWT TrayItem");
        item.addListener (SWT.Show, new class() Listener {
            public void handleEvent (Event event) {
                version(Tango){
                    Stdout.formatln("show");
                } else { // Phobos
                    writefln("show");
                }
            }
        });
        item.addListener (SWT.Hide, new class() Listener {
            public void handleEvent (Event event) {
                version(Tango){
                    Stdout.formatln("hide");
                } else { // Phobos
                    writefln("hide");
                }
            }
        });
        item.addListener (SWT.Selection, new class() Listener {
            public void handleEvent (Event event) {
                version(Tango){
                    Stdout.formatln("selection");
                } else { // Phobos
                    writefln("selection");
                }
            }
        });
        item.addListener (SWT.DefaultSelection, new class() Listener {
            public void handleEvent (Event event) {
                version(Tango){
                    Stdout.formatln("default selection");
                } else { // Phobos
                    writefln("default selection");
                }
            }
        });
        menu = new Menu (shell, SWT.POP_UP);
        for (int i = 0; i < 8; i++) {
            MenuItem mi = new MenuItem (menu, SWT.PUSH);
            version(Tango){
                mi.setText ( Format( "Item{}", i ));
            } else { // Phobos
                mi.setText ( format( "Item%s", i ));
            }
            mi.addListener (SWT.Selection, new class() Listener {
                public void handleEvent (Event event) {
                    version(Tango){
                        Stdout.formatln("selection {}", event.widget);
                    } else { // Phobos
                        writefln("selection %s", event.widget);
                    }
                }
            });
            if (i == 0) menu.setDefaultItem(mi);
        }
        item.addListener (SWT.MenuDetect, new class() Listener {
            public void handleEvent (Event event) {
                menu.setVisible (true);
            }
        });
        item.setImage (image);
    }
    shell.setBounds(50, 50, 300, 200);
    shell.open ();
    while (!shell.isDisposed ()) {
        if (!display.readAndDispatch ()) display.sleep ();
    }
    image.dispose ();
    display.dispose ();
}

