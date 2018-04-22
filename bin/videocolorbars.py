#!/usr/bin/python
#-*- coding: utf-8 -*-

# This script computes a the Color Bars of a video.
# Copyright (C) 2011 Benoit Romito

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""
Color Bars Generator

Description:
Author: Benoît Romito (benoit.romito@unicaen.fr)
Script dependencies: Python Imaging Library (PIL), ffmpeg, 
                     totem-video-thumbnailer, ImageMagick
Version: 0.1
TODO: auto upload to flickr
"""

import Image, sys, os.path, shlex, subprocess, re, math, time

TMPDIR = "/tmp/"
TVT = "/usr/bin/totem-video-thumbnailer"
FFMPEG = "/usr/bin/ffmpeg"
TOKEN = str(time.time())


def retry(func):
    """Retry Decorator"""
    def wrapper(*args, **kwargs):
        retry = 0
        while(retry <= 10):
            try:
                return func(*args, **kwargs)
            except Exception:
                retry += 1
    return wrapper

class Video(object):
    """Video Wrapper"""
    def __init__(self, movie_path):
        self._movie = os.path.abspath(movie_path)
        self._infos = self.get_infos()

    def get_infos(self):
        infos = {}
        cmd = "%s -i %s"%(FFMPEG, self._movie)
        args = shlex.split(cmd)
        p = subprocess.Popen(args, stdout=subprocess.PIPE, 
                             stderr=subprocess.PIPE)
        p.wait()

        # Duration: 01:38:50.08,
        regex = re.compile("Duration: (\d+):(\d+):(\d+)\.(\d+)", re.I|re.M)
        h,m,s,ms = (0,0,0,0)
        for i in p.communicate():
            res = regex.findall(i)
            if len(res) != 0:
                h,m,s,ms = map((lambda x : int(x)),res[0])
                break

        infos["duration"] = s + m * 60 + h * 3600
        return infos
        
    @retry
    def get_frame(self, second):
        out_file = os.path.abspath(TMPDIR + "/" + TOKEN + "-barcodes-tmp" + 
                                   str(second) + ".png")
        cmd = "%s -r -t %s %s %s"%(TVT, second, self._movie, out_file)
        args = shlex.split(cmd)
        p = subprocess.Popen(args, stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        p.wait()
        return Image.open(out_file)

    def __repr__(self):
        return "%s : %s"%(self._movie, self._infos)

class Barcode(object):
    """Barcode Object"""
    def __init__(self, movie, bar_width=4000, bar_height=1480, frame_width=15, 
                 frame_height=15, outfile=""):
        if outfile != "":
            self.outfile = os.path.abspath(outfile)
        else:
            self.outfile = os.path.join(TMPDIR + "/" + movie._movie + ".png")
        self.movie = movie
        self.bar_width = bar_width
        self.bar_height = bar_height
        self.frame_width = frame_width
        self.frame_height = frame_height

        self.nframes_by_slice = int(math.ceil(bar_height / float(frame_height)))
        self.duration = self.movie.get_infos()["duration"]

        self.nslices = int(math.ceil(self.duration / self.nframes_by_slice))
        print self.nframes_by_slice, self.nslices

        self._image = Image.new("RGB", (self.nslices*frame_width,
                                        self.nframes_by_slice*frame_height))
        print self._image

    def generate(self):
        xoffset = 0
        start= 1
        end = self.nframes_by_slice + 1
        for i in xrange(self.nslices):
            print "Slice %s on %s..."%(i, self.nslices)
            slice = Slice.generate_vertical_slice(self.movie, start, end, 
                        patch_dimensions=(self.frame_width, self.frame_height))
            Slice.cleanup()
            box = (0,0,slice.size[0],slice.size[1])
            start = end + 1
            end = start + self.nframes_by_slice

            self._image.paste(slice.crop(box), 
                    (xoffset, 0, xoffset + slice.size[0],  slice.size[1]))
            xoffset += slice.size[0]
            self._image.save(self.outfile)
        self._image = self.auto_size()
        self._image.save(self.outfile)

    def apply_blur(self):
        print "Applying Blur. This may take some time..."
        path, fname = os.path.split(self.outfile)
        blured_file = os.path.join(path, "blured-"+fname)
        cmdline = "convert -motion-blur 0x256+90 %s %s"%(self.outfile, blured_file)
        args = shlex.split(cmdline)
        p = subprocess.Popen(args)
        p.wait()

    def auto_size(self):
        return self._image.resize((1305,720))

        
class Slice(object):
    @staticmethod
    def generate_vertical_slice(movie, start, end, patch_dimensions=(15,15)):
        """Generat a vertical slice."""
        frames = []
        for sec in xrange(start, end):
            print "\rThumbnailing Frame %s"%sec,
            sys.stdout.flush()
            frames.append(movie.get_frame(sec).resize(patch_dimensions))
            
        if len(frames) == 0:
            return None

        xsize, ysize = frames[0].size
        box = (0, 0, xsize, ysize)
        n = end - start 
        new = Image.new(frames[0].mode, (xsize, ysize*n))
        cur_y = 0
        print ""

        for idx in xrange(1, len(frames) + 1):
            print "\rMerging Frame %s"%(idx),
            sys.stdout.flush()
            frame = frames[idx-1]
            new.paste(frame.crop(box), (0, cur_y, xsize, idx*ysize))
            cur_y += ysize

        print ""
        return new

    @staticmethod
    def average_color(frame):
        R,G,B = (0,0,0)
        pixels = list(frame.getdata())
        for r,g,b in pixels:
            R+=r
            G+=g
            B+=b
        le = len(pixels)
        return (R/le, G/le, B/le)

    @staticmethod
    def cleanup():
        """Clean the temporary directory"""
        path = os.path.abspath(TMPDIR)
        for f in os.listdir(path):
            if f.startswith(TOKEN+"-barcodes-tmp"):
                os.remove(os.path.join(path,f))

class AutoUpload(object):
    pass        

if __name__ == "__main__":
    movie = Video(sys.argv[1])
    outfile = ""
    if(len(sys.argv)== 3):
        outfile = sys.argv[2]

    b = Barcode(movie,bar_height=720, outfile=outfile)
    b.generate()
    b.apply_blur()


                          
    
    
    
    
    
    
    
