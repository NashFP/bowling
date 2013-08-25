/*
  Developed using a worksheet in typesafe
*/ 

object bowling {
       
  //use a pattern match to score the current frame
  def scoreFrame(frames:List[Int]):Int = frames match {
      				       case Nil => 0
      case 10 :: b :: c :: _ => 10 + b + c
      case 10 :: b :: _ => 10 + b
      case a :: b :: c :: _ if ((a + b) == 10) => 10 + c
      case a :: b :: _ if ((a + b) <= 10) => a + b
      case _ => frames.head
  }                                               
  
  //score a set of frames
  def score(frames:List[List[Int]]): Int = frames match {
      case Nil => 0
      case head :: tail => scoreFrame(List.flatten(frames)) + score(tail)
  }                                               
  
  // some expected values and some data (ugh, lists are wordy in scala)
  val tests =
      List(
          (0,   List()),
	  (0,   List(List())),
	  (6,   List(List(5,0),List(1))),
	  (10,  List(List(10))),
	  (12,  List(List(10),List(1))),
	  (14,  List(List(10),List(1,1))),
	  (10,  List(List(5,5))),
	  (20,  List(List(5,5),List(5))),
	  (25,  List(List(5,5),List(5,5))),
	  (0,   List(List(0,0),List(0,0),List(0,0),List(0,0),List(0,0),List(0,0),List(0,0),List(0,0),List(0,0),List(0,0))),
	  (20,  List(List(1,1),List(1,1),List(1,1),List(1,1),List(1,1),List(1,1),List(1,1),List(1,1),List(1,1),List(1,1))),
	  (110, List(List(0,10),List(0,10),List(0,10),List(0,10),List(0,10),List(0,10),List(0,10),List(0,10),List(0,10),List(0,10,10))),
	  (300, List(List(10),List(10),List(10),List(10),List(10),List(10),List(10),List(10),List(10),List(10,10,10)))
	  )                                     

// go through the test tuples calculating scores and print them all out.
tests.map((test:(Int,List[List[Int]])) => (test._1, score(test._2))).foreach(println)

}