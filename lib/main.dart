import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main()
{
  runApp(Calcultor());
}

class Calcultor extends StatefulWidget {
  @override
  _CalcultorState createState() => _CalcultorState();
}

class _CalcultorState extends State<Calcultor> {
 String output ='';
  String input ='';
  List<String> buttons= ['C','Del','%','/',
    '9','8','7','*'
    ,'6','5','4','-'
    ,'3','2','1','+',
    '0','.','Ans','='
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 60,),
            Expanded(child: Container(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(input)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(output,style: TextStyle(fontSize: 35,color: Colors.green),)),
                  ),
                  SizedBox(height: 10,width: 250,
                    child: Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                  )
                ],
              ),
            )),

            Expanded(
                flex: 2,
                child: Container(

                  child: GridView.builder(itemCount: 20,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,childAspectRatio: 1.3
                      ), itemBuilder: (context ,index)
                      {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: GestureDetector(
                            onTap: (){
                              if(buttons[index] == 'C')
                              {
                                setState(() {
                                  input ='';
                                  output ='';
                                });
                              }else if(buttons[index]=='Del')
                              {
                                setState(() {
                                  input =input.substring(0,input.length-1);
                                });
                              }
                              else if(buttons[index]== '=')
                              {
                                        equalbutton();
                              }
                              else if(buttons[index]=='Ans')
                              {
                                setState(() {
                                  input =output;
                                });
                              }
                              else if(buttons[index]=='*'||buttons[index]=='/'||buttons[index]=='%'||
                                  buttons[index]=='-'||buttons[index]=='+')
                              {
                                setState(() {

                                  input.endsWith('/')||input.endsWith('*')
                                      ||input.endsWith('-')||input.endsWith('+')||input.endsWith('%')?null:input+=buttons[index];
                                });
                              }

                              else
                              {
                                setState(() {
                                  input+=buttons[index];
                                });
                              }

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: containercolor(buttons[index])

                              ),
                              child:
                              Center(child: Text(buttons[index].toString(),style: TextStyle(fontSize: 20),)),
                            ),
                          ),
                        );
                      }),

                ))
          ],
        ),
      ),
    );
  }
bool isoperater(String x)
{
  if(x=='+'||x=='-'||x=='%'||x=='*'||x=='/'||x =='=')
  {
    return true;
  }
  else
    {
      return false;
    }
}
Color containercolor(String c)
{
 if (isoperater(c) == true)
 {
   return Colors.deepPurple;
 }
 else if(c =="C")
 {
   return Colors.green;
 }
 else if(c == 'Del')
 {
   return Colors.red;
 }
 else
   {
     return Colors.white;
   }
}
void equalbutton()
{
  Expression expression =Parser().parse(input);
  double endoutput =expression.evaluate(EvaluationType.REAL, ContextModel());
  setState(() {
    output =endoutput.toString();
  });

}

}