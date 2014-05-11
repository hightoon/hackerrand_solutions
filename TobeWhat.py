''' TobeWhat.py for to-be-what contest
    https://www.hackerrank.com/contests/april-real-data/challenges/to-be-what
'''
class ToBeWhat:
  sentence_ends = ['.', '!', '?']
  ToBes = ['am', 'is', 'are', 'was', 'were', 'been']
  present_keywords = ['is', 'are', 'am', 'will', 'Don\'t', 'don\'t', 'do',
                      'does', 'Does', 'Do', 'Will', 'Are', 'Is']
  def __init__(self, parag, nob=0):
    self._nob = nob
    self._parag = parag
    self._sentences = []
    self._quotes = []
    self._tobes = []

  def _parse_sentence(self, sentence, past=False):
    if sentence[0] == '"' and sentence[-1] == '"':
      past = False
    words = sentence.split(' ')
    for w in words:
      if w.strip(',') in ToBeWhat.present_keywords:
        past = False
        break
    for i in range(len(words)):
      if words[i] == '----':
        if sentence[-1] != '?':
          if words[i-1] in ['has', 'have', 'had']:
            self._tobes.append('been')
          elif words[i-1] in \
               ['should', 'could', 'would', 'shall', 'must', 'to', 'need',
                'may', 'might', 'can', 'will']:
            self._tobes.append('be')
          elif words[i-1][-1] != 's':
            # further check if nouns not close to be
            if past:
              self._tobes.append('was')
            else:
              if words[i-1] == 'I':
                self._tobes.append('am')
              else:
                self._tobes.append('is')
          else:
            if past:
              self._tobes.append('were')
            else:
              self._tobes.append('are')
        else:
          if words[i+1][-1] != 's':
            if past:
              self._tobes.append('was')
            else:
              if words[i+1] == 'I':
                self._tobes.append('am')
              else:
                self._tobes.append('is')
          else:
            if past:
              self._tobes.append('were')
            else:
              self._tobes.append('are')

  def _fill_blank(self):
    past = False
    for s in self._sentences:
      ws = s.split(' ')
      if 'was' in ws or 'were' in ws:
        past = True
        break
      for i in range(len(ws)):
        if 'ed' in ws[i] and i > 0:
          if ws[i-1] not in ToBeWhat.ToBes:
            past = True

    for sentence in self._sentences:
      self._parse_sentence(sentence, past)

  def _read_sentence(self):
    sentence = ''
    quote = ''
    for ch in self._parag:
      if len(quote):
        if ch != '"':
          quote = ''.join([quote, ch])
        else:
          sentence = ''.join([sentence, ch])
          quote = ''.join([quote, ch])
          self._sentences.append(quote)
          #print self._sentences
          quote = ''
      elif ch in ToBeWhat.sentence_ends:
        sentence = ''.join([sentence, ch])
        self._sentences.append(sentence)
        #print self._sentences
        sentence = ''
      elif ch == '"':
        quote = ''.join([quote, ch])
        sentence = ''.join([sentence, ch])
      else:
        sentence = ''.join([sentence, ch])

  def parse(self):
    self._read_sentence()
    self._fill_blank()

  def print_tobes(self):
    for tobe in self._tobes:
      print tobe

  @property
  def tobes(self):
    return self._tobes

def fill_tobe(sentence):
  print sentence

if __name__ == '__main__':
  num_of_blanks = int(raw_input(""))
  paragraph = raw_input("")
  my_tbw = ToBeWhat(paragraph)
  my_tbw.parse()
  my_tbw.print_tobes()
