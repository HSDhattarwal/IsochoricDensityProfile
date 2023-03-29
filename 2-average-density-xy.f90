program average_density
  Implicit none
  Integer, Parameter                :: nbin=100000
  Integer                          :: k, sum
  Real*8                            :: r, y, den, aden
  
  Open(10,file = 'fort-xy.dat') ! file of type 1
  Open(20,file = 'avg-den-xy.dat') ! file of type 2

   aden=0
   sum=0
   do k = 1, nbin
         r=0; y=0 ; den=0
         Read(10,*) r, y , den
         if (r.eq.0.) exit
         sum=sum+1
         aden=aden+den
   enddo

   aden=aden/sum 

   write(20,*) aden

close(10)
close(20)
  end program average_density           
