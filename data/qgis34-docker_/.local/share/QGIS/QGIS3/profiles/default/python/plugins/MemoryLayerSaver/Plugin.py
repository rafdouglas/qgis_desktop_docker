from PyQt5.QtGui import *
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
from qgis.core import *
import sys

# import Resources

from .MemoryLayerSaver import MemoryLayerSaver
from . import Resources


class Plugin:

    _MemoryWarningSetting="askToSaveMemoryLayers"
    _MemorySavedSetting="MemoryLayerSaver/memoryLayerSaveSetting"

    def __init__( self, iface ):
        self._iface = iface
        self._saver = MemoryLayerSaver(iface)
        self._saveSetting=True

    def initGui(self):
        self._saver.attachToProject()
        self._infoAction = QAction(QIcon(":plugins/MemoryLayerSaver/plugin.png"),
                                   "Display memory layer information",
                                   self._iface.mainWindow())
        self._infoAction.triggered.connect(self._saver.showInfo)
        self._iface.addPluginToMenu("&Memory layer saver", self._infoAction)
        # Save the current warning setting.
        # Also save the value in a MLS plugin specific setting, in case QGIS
        # crashes and saved setting is lost.
        # MLS setting is removed  on unload, so existing value should be used if present.
        settings=QgsSettings()
        saveSetting=settings.value(self._MemoryWarningSetting, True, section=QgsSettings.App )
        saveSetting=settings.value(self._MemorySavedSetting, saveSetting, section=QgsSettings.Plugins )
        settings.setValue(self._MemoryWarningSetting, False, section=QgsSettings.App )
        settings.setValue(self._MemorySavedSetting, saveSetting, section=QgsSettings.Plugins )
        self._saveSetting

    def unload( self ):
        self._iface.removePluginMenu("&Memory layer saver",self._infoAction)
        self._saver.detachFromProject()
        settings=QgsSettings()
        settings.setValue(self._MemoryWarningSetting, self._saveSetting, section=QgsSettings.App )
        settings.remove(self._MemorySavedSetting, section=QgsSettings.Plugins )
