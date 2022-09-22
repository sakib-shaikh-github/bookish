String resizingTxt(String txt) {
  if (txt.length <= 25) {
    return txt;
  } else {
    txt = '${txt.substring(0, 26)}..';
    return txt;
  }
}
