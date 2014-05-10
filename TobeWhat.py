''' TobeWhat.py for to-be-what content
    https://www.hackerrank.com/contests/april-real-data/challenges/to-be-what
'''

import re

sentence_ends = ['.', '!', '?']

class ToBeWhat:
  def __init__(self, parag, nob=0):
    self._nob = nob
    self._parag = parag
    self._sentences = []
    self._quotes = []
    self._tobes = []

  def read_sentence(self):
    sentence = ''
    quote = ''
    for ch in self._parag:
      if len(quote):
        if ch != '"':
          quote = ''.join([quote, ch])
        else:
          sentence = ''.join([sentence, ch])
          quote = ''.join([quote, ch])
          self._quotes.append(quote)
          fill_tobe(quote)
          quote = ''
      elif ch in sentence_ends:
        self._sentences.append(sentence)
        fill_tobe(sentence)
        sentence = ''
      elif ch == '"':
        quote = ''.join([quote, ch])
        sentence = ''.join([sentence, ch])
      else:
        sentence = ''.join([sentence, ch])

  @property
  def tobes(self):
    return self._tobes

def fill_tobe(sentence):
  print sentence

if __name__ == '__main__':
  num_of_blanks = int(raw_input(""))
  paragraph = raw_input("")
  my_tbw = ToBeWhat(paragraph)
  my_tbw.read_sentence()
