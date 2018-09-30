# Sentences-Similarity #  
A project written in Assembly x86 that calculates the similarity between two sentences

# How it works #  
1. Read the first  sentence from "DATA1.txt" and save it in s1  
2. Read the second sentence from "DATA2.txt" and save it in s2  
3. Remove punctuation marks in s1 and s2 which are 14  
	a. /  
	2. .  
	3. ?  
	4. !  
	5. :  
	6. ;  
	7. -  
	8. —  
	9. ( )  
	10. [ ]  
	11. . . .   
	12. ’  
	13. “ ”  
	14. ,  

** for [] and () we will remove the opening parantheses then the closing.  

4. Make all characters in s1 and s2 small letters  

5. Remove stop words from s1 and s2  
	1. I  
	2. a  
	3. an  
	4. as  
	5. at  
	6. the  
	7. by  
	8. in  
	9. for  
 	10. of  
	11. on  
	12. that  
6. Remove duplicate words from s1 and s2  
7. Calculate the similarity  

	Similarity = (𝑆1 ∩ 𝑆2) / (𝑆1 ∪ 𝑆2)  

(𝑆1 ∩ 𝑆2) : the size of the intersection of words between s1 and s2 "length(s3 = (𝑆1 ∩ 𝑆2))"   
(𝑆1 ∪ 𝑆2) : the size of the union        of words between s1 and s2  

