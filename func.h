float factorial(float n) 
{
	float x; float f=1;
	
	for (x=1; x<=n; x++) { 
		f *= x; 
	}
	return f;
}
