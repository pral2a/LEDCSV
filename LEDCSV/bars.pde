class Bars {


  int totalColumns, totalBars, totalRows;

  ArrayList<Bar> bars = new ArrayList<Bar>();

  Table table;

  Bars(String myTable, long waitTime, long riseTime, color[][]myTimeColor) {

    table = loadTable(myTable, "header");

    println(table.getColumnCount() + " total rows in Table"); 

    table.removeColumn(0);  

    totalColumns = table.getColumnCount();
    totalBars = totalColumns-1;
    totalRows = table.getRowCount();

    int[][][]data = new int[totalColumns-1][totalRows][2];

    for (int n = 0; n < totalRows; n++) {

      TableRow row = table.getRow(n);

      for (int i = 0; i < totalBars; i++) {

        int dataPoint[] = new int[2];

        dataPoint[0] = (row.getString(totalColumns-1).equals("Day")) ? 0 : 1;
        dataPoint[1] = row.getInt(i);

        data[i][n] = dataPoint;
      }
    }

    int barsWidth = width/totalBars;

    for (int f = 0; f < totalBars; f++) {
      int barPosition = f*barsWidth;
      bars.add(new Bar(data[f], barPosition, riseTime, waitTime, myTimeColor, barsWidth));
    }
  }


  void update(boolean testMode) {
    background(0);
    for (int i = 0; i < bars.size(); i++) {
      int step = bars.get(i).update(testMode);
      println("[", i, "] > ", step, "/", totalRows);
    }
  }
}
