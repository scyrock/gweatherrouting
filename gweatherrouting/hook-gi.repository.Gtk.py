from PyInstaller.utils.hooks import collect_data_files, collect_system_data_files

datas = collect_data_files('gi')

# Add GTK modules
gtk_modules = [
    ('/usr/lib/gtk-3.0/modules/libcolorreload-gtk-module.so', 'gtk-3.0/modules'),
    ('/usr/lib/gtk-3.0/modules/libwindow-decorations-gtk-module.so', 'gtk-3.0/modules'),
    ('/usr/lib/gtk-3.0/modules/libappmenu-gtk-module.so', 'gtk-3.0/modules')
]

# Adjust the paths above based on your find results
datas.extend(gtk_modules)
