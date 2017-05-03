# -*- coding: utf-8 -*-
# Copyright (C) 2017 Davide Gessa
'''
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

For detail about GNU see <http://www.gnu.org/licenses/>.
'''

from .. import config
from .track import Track
from .simulation import Simulation
from .boat import Boat
from .grib import Grib

class Core:
    def __init__ (self):
        self.track = Track ()
        self.grib = Grib ()
        self.grib.parse ('/home/dakk/testgrib.grb')

    # Simulation
    def createSimulation (self, boatModel):
        boat = Boat (boatModel)
        sim = Simulation (boat, self.track)
        return sim

    # Track ans save/load
    def getTrack (self):
        return self.track

    def load (self, path):
        return self.track.load (path)

    def save (self, path):
        return self.track.save (path)