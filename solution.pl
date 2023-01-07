% kadir gökhan sezer
% 2018400xxx
% compiling: yes
% complete: yes




% include the knowledge base
:- encoding(utf8).
:- ['load.pro'].

% 3.1 glanian_distance(Name1, Name2, Distance) 5 points

% 3.2 weighted_glanian_distance(Name1, Name2, Distance) 10 points

% 3.3 find_possible_cities(Name, CityList) 5 points

% 3.4 merge_possible_cities(Name1, Name2, MergedCities) 5 points

% 3.5 find_mutual_activities(Name1, Name2, MutualActivities) 5 points

% 3.6 find_possible_targets(Name, Distances, TargetList) 10 points

% 3.7 find_weighted_targets(Name, Distances, TargetList) 15 points

% 3.8 find_my_best_target(Name, Distances, Activities, Cities, Targets) 20 points

% 3.9 find_my_best_match(Name, Distances, Activities, Cities, Targets) 25 points

% FİRST QUERY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


abs(Num1,Result):- Num1<0, Result is Num1*(-1).  %calculate absolute value

subtract(Num1,Num2,R):-   

      Num1<0 ->  R is 0,!
    ;
      Num1>=0->  
    
      R is abs(Num1-Num2).

      
toplanacak([], [], []).    %   calculating (x-y)'2
toplanacak([H1|T1], [H2|T2], [Head|TailResult]) :-
    toplanacak(T1, T2, TailResult),
      	subtract(H1,H2,R1),
      	Head is (R1*R1). %square of difference

sumlist([], 0).             %sum of list
sumlist([H|T], Sum) :-
   sumlist(T, Rest),
   Sum is H + Rest.



glanian_distance(Name1,Name2,D) :-
	expects(Name1,_,X),
	glanian(Name2,_,Y),
    toplanacak(X,Y,R),
    print(R),
    sumlist(R,Toplam),
    D is sqrt(Toplam).

% SECOND QUERY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


multiply([], [], []).  %multiplyLists
multiply([H1|T1], [H2|T2], [Head|TailResult]) :-
    multiply(T1, T2, TailResult),
    Head is H1*H2.

weighted_glanian_distance(Name1,Name2,D) :-
	expects(Name1,_,X),
	glanian(Name2,_,Y),
	weight(Name1,WList),
    toplanacak(X,Y,R),
	multiply(R,WList,K),
    sumlist(K,Toplam),
    D is sqrt(Toplam).
	
 % THIRD QUERY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
mymember(X,[X|_]):-!.       %ismemberornot
mymember(X,[_|T]):-
    mymember(X,T).

myappend([],List,List).
myappend([H|L1],L2,[H|L3]):-myappend(L1,L2,L3).

find_possible_cities(Name, CityList):-
   
	city(CityName,HabitantList,_),
	mymember(Name,HabitantList),
	likes(Name,_,LikedCities),
	Alist=[CityName],
	myappend(Alist,LikedCities,CityListY),!,
	list_to_set(CityListY,CityList).
	
	                            %%false dönmesin diye
	
 % FOURTH QUERY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 

merge_possible_cities(Name1, Name2, CityList):-                   %%bu - + lar ıkontrol et vm de aynen yaz
   Name1=Name2-> 
		find_possible_cities(Name1,List1),
		CityList=List1,!
		;
   find_possible_cities(Name1,List1),
   find_possible_cities(Name2,List2),
   myappend(List1,List2,CityListY),
   list_to_set(CityListY,CityList).
   
   % FIFTH QUERY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   
   mutual([], _, []).   
		mutual([Head|L1], L2, L3) :-
        memberchk(Head, L2),
        !,
        L3 = [Head|L4],
        mutual(L1, L2, L4).
		mutual([_|L1], L2, L3) :-
        mutual(L1, L2, L3).

   
   find_mutual_activities(Name1,Name2,ActivityList):-
		likes(Name1,X,_),
		likes(Name2,Y,_),
		mutual(X,Y,ActivityList).

      % SIXTH QUERY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	  twin(X,Y,D):-glanian_distance(X,Y,D).   %same as glanianDistance i wrote it to understand meaninng of the code  easily
	  	sort2(List, Sorted):- sort(0,  @<, List,  Sorted).
	  
	divide_dashed_list([], [], []).
      divide_dashed_list([Head|Tail], [HeadFirst|TailFirst], [HeadSecond|TailSecond]) :-
    HeadFirst-HeadSecond = Head,
    divide_dashed_list(Tail, TailFirst, TailSecond).
	


	  
	  
	  
	 find_possible_targets(Name,Distances,TargetList):-
	 
	  
	 findall(X-Y, ( 
	    glanian(Y,Gender,_),
		not(Name=Y),
	    expects(Name,ExpectedGender,_),
		member(Gender,ExpectedGender),
		twin(Name,Y,X) %glanian_distance(Name,Y,X)

		), R),
	    sort2(R,K),
		divide_dashed_list(K,Distances,TargetList).
		
		
		
      % SEVENTH QUERY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		
		wtwin(X,Y,D):-weighted_glanian_distance(X,Y,D).  %same as before
		
find_weighted_targets(Name,Distances,TargetList):-
	 
	
	  
	  
	 findall(X-Y, ( 
	    glanian(Y,Gender,_),
		not(Name=Y),
	    expects(Name,ExpectedGender,_),
		member(Gender,ExpectedGender),
		wtwin(Name,Y,X) %glanian_distance(Name,Y,X)

		), R),
	    sort2(R,K),
		divide_dashed_list(K,Distances,TargetList).
		
		  % EIGHTTH QUERY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		  
    okey(Features,Limits):-   %it is checking features satisfy limits
    glanian(Features,_,FeatureList),
    dislikes(Limits,_,_,DislikeList),
    FeatureList=[Q,W,E,R,T,Y,U,I,O,P],
    DislikeList=[A,B,C,D,F,G,H,J,K,L],
     (    A\=[]-> A = [A1,A2],  Q>A1,Q=<A2;A=[] ), 
     (    B\=[]-> B=[B1,B2],  W>B1,W<B2;B=[] ) ,
      (   C\=[]-> C=[C1,C2],  E>C1,E<C2;C=[] ),
      (   D\=[]-> D=[D1,D2],  R>D1,R<D2;D=[] ),
      (   F\=[]-> F=[F1,F2],  T>F1,T<F2; F=[] ),
      (   G\=[]-> G=[G1,G2],  Y>G1,Y<G2;G=[] ),
    (   H\=[]-> H=[H1,H2],  U>H1,U<H2;H=[]),
    (   J\=[]-> J=[J1,J2],  I>J1,I<J2;J=[]),
    (   K\=[]-> K=[K1,K2],  O>K1,O<K2;K=[]),
    (   L\=[]-> L=[L1,L2],  P>L1,P<L2;L=[]).
    
   
   
   	threeDash([], [], [],[],[]).
      threeDash([Head|Tail], [HeadFirst|TailFirst], [HeadSecond|TailSecond],[HeadThird|TailThird],[HeadFourth|TailFourth]) :-
    HeadFirst-HeadSecond-HeadThird-HeadFourth = Head,
    threeDash(Tail, TailFirst, TailSecond,TailThird,TailFourth).
	


   
   
   
   
   
   
   okeyforActivities1(_,DislikedActivities,LikedActivitiesG,_):-  %checking activities 3 or more
    findall(Y,
            (
              member(Y,LikedActivitiesG),member(Y,DislikedActivities)
            )
            ,RG),
    
   
	length(RG,B),

	B<3.
		  
		  
		  find_my_best_target(Name, Distances, ActivityList, CityList, TargetList):-
		  
		  findall(Distance-Activity-City-GlanianName,
		  (
		      
		  	   glanian(GlanianName,GlanianGender,_),                   %For Name and GlanianName all the predicates should be satisfied.
		       expects(Name,ExpectedGenders,_),                
			   not(GlanianName=Name),
			   likes(Name,LikedActivities,LikedCities) ,  
			   dislikes(Name, DislikedActivities, DislikedCities, _),
			   weighted_glanian_distance(Name,GlanianName,Distance),
			   	   not( ( old_relation([Name, GlanianName])  ;  old_relation([GlanianName, Name]) ) ),   %you can check the number from the pdf,
			       member(GlanianGender,ExpectedGenders),	               	    %  1 ve 6  Gender
			       okey(GlanianName,Name),                                 		%  7  Limits
				   
               city(City,HabitantList,ActivityList),
			   member(Activity,ActivityList),
			   not(member(City,DislikedCities)),                                %  4 Disliked citylerde olmicak
			   merge_possible_cities(Name,GlanianName,CityList),                %  5  MergeList
               member(City,CityList),                                           %  2  city activity
			 
(member(Name,HabitantList) ; member(City,LikedCities) ; ( member(Activity,LikedActivities),member(Activity,ActivityList) ) ),
			   
			 not(member(Activity,DislikedActivities)),                           %  3 disliked activity
			 
			 
			 
			           
         likes(GlanianName,LikedActivitiesG1,_),  
         dislikes(GlanianName, DislikedActivitiesG1, _, _),
		 okeyforActivities1(LikedActivities,DislikedActivities,LikedActivitiesG1,DislikedActivitiesG1)   %activities are good ?
		 
              
			   
					
	
			
			
			)

		  ,Final),
		  
				sort2(Final,Sorted),
		  		threeDash(Sorted,Distances,ActivityList,CityList,TargetList).
		  
		  
		  % NINTH @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		  
		  
   okeyforActivities(LikedActivities,DislikedActivities,LikedActivitiesG,DislikedActivitiesG):-   %checkk activities are good for two-sided ones
    findall(X,
        (
        member(X,LikedActivities),member(X,DislikedActivitiesG)
        )
        ,R),

    findall(Y,
            (
              member(Y,LikedActivitiesG),member(Y,DislikedActivities)
            )
            ,RG),
    
    length(R,A),
	length(RG,B),
    A<3,
	B<3.

		  find_my_best_match(Name, Distances, ActivityList, CityList, TargetList):-
		  
		  findall(Distance-Activity-City-GlanianName,
		  (
		      
		  	   glanian(GlanianName,GlanianGender,_),           %again the numbers represent which rule they satisfy
			   glanian(Name,NameGender,_),
			    not(GlanianName=Name),
		        expects(Name,ExpectedGenders,_),                        %7 8
			   expects(GlanianName,ExpectedGendersG,_),
			   likes(Name,LikedActivities,LikedCities) ,  
			   likes(GlanianName,LikedActivitiesG,LikedCitiesG),  
			   dislikes(Name, DislikedActivities, DislikedCities, _),
			   dislikes(GlanianName, DislikedActivitiesG, DislikedCitiesG, _), 
			   weighted_glanian_distance(Name,GlanianName,X),
			   weighted_glanian_distance(GlanianName,Name,Y),
			   	   not( ( old_relation([Name, GlanianName])  ;  old_relation([GlanianName, Name]) ) ),   %1
			       member(GlanianGender,ExpectedGenders),                    %8
				   member(NameGender,ExpectedGendersG),	                  %7
			       okey(GlanianName,Name),                        %9           
				   okey(Name,GlanianName),                        %10
				   
               city(City,HabitantList,ActivityList),
			   member(Activity,ActivityList),
			   not(member(City,DislikedCities)),        
			   not(member(City,DislikedCitiesG)),    		   
			   merge_possible_cities(Name,GlanianName,CityList),               
              member(City,CityList),     
			  
		  (member(Name,HabitantList) ; member(City,LikedCities) ; ( member(Activity,LikedActivities),member(Activity,ActivityList) ) ),           
          (member(GlanianName,HabitantList) ; member(City,LikedCitiesG) ; ( member(Activity,LikedActivitiesG),member(Activity,ActivityList) ) ),     %2 3
			   
         

			  
			 not(member(Activity,DislikedActivities)),               %4            
			 not(member(Activity,DislikedActivitiesG)),              %4
			 
			     
		 okeyforActivities(LikedActivities,DislikedActivities,LikedActivitiesG,DislikedActivitiesG),    %11 12
		 Distance is (X+Y)/2                               %distance

			)

		  ,Final),
		  
				sort2(Final,Sorted),
		  		threeDash(Sorted,Distances,ActivityList,CityList,TargetList).
		  
% TENTH @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	
	ten_best_matches(LSon):-
	
	findall(Distance-Name-GlanianName,
		  (
		      
		  	   glanian(GlanianName,GlanianGender,_),
			   glanian(Name,NameGender,_),
			    not(GlanianName=Name),
				not( ( old_relation([Name, GlanianName])  ;  old_relation([GlanianName, Name]) ) ),
		       expects(Name,ExpectedGenders,_),
			   expects(GlanianName,ExpectedGendersG,_),
			   member(GlanianGender,ExpectedGenders),
			   member(NameGender,ExpectedGendersG),	  
			   likes(Name,LikedActivities,LikedCities) ,  
			   likes(GlanianName,LikedActivitiesG,LikedCitiesG),  
			   dislikes(Name, DislikedActivities, DislikedCities, _),
			   dislikes(GlanianName, DislikedActivitiesG, DislikedCitiesG, _), 
			    city(City,HabitantList,ActivityList),
			   member(Activity,ActivityList),
			   not(member(City,DislikedCities)),        
			   not(member(City,DislikedCitiesG)),   
			   weighted_glanian_distance(Name,GlanianName,X),
			   weighted_glanian_distance(GlanianName,Name,Y),

		      (member(Name,HabitantList) ; member(City,LikedCities) ; ( member(Activity,LikedActivities),member(Activity,ActivityList) ) ),           
              (member(GlanianName,HabitantList) ; member(City,LikedCitiesG) ; ( member(Activity,LikedActivitiesG),member(Activity,ActivityList) ) ),
			   
			  
			 not(member(Activity,DislikedActivities)),                          
			 not(member(Activity,DislikedActivitiesG)),       
			 
			   
			   
			       okey(GlanianName,Name),                         
				  okey(Name,GlanianName),
				   
 		   
			    merge_possible_cities(Name,GlanianName,CityList),               
                 member(City,CityList),     
		


			    
		     okeyforActivities(LikedActivities,DislikedActivities,LikedActivitiesG,DislikedActivitiesG),
		    Distance is (X+Y)/2

			 )

		  ,Final),
		 sort2(Final,L),
		
    findall(Dashed,              
            (
            
                 (member(X-First-Second,L),member(X-Second-First,L)),
                 ( (   First@<Second,Smaller = First,Bigger = Second);(Second@<First, Smaller = Second,Bigger = First)), 
            Dashed= Smaller-Bigger
            ),L1),
           list_to_set(L1,LSon),
		   
	  open('top10.txt',write, Stream),
    findall(A,(member(A,LSon), write(Stream,A),write(Stream,"\n")),L),
    close(Stream).
	
		  
	
