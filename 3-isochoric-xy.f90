program isochoric_density
  Implicit none
  Integer, Parameter                :: nbin=100000
  Integer                          :: k, sum
  Real*8                            :: r, y, den, aden
  
  Open(10,file = 'fort-xy.dat') ! file of type 1
  Open(20,file = 'avg-den-xy.dat') ! file of type 2
  Open(30,file = 'iso-den-xy.dat') ! file of type 2

   Read(20,*) aden
   aden=aden/2  
   write(*,*)aden
   do k = 1, nbin
         r=0; y=0 ; den=0
         Read(10,*) r, y , den
         if (den.le.(aden+0.8 ).and.den.ge.(aden-0.8 )) then
         write(30,*) r, y, den
         endif
         if(r.eq.0) exit
   enddo

close(10)
close(30)
close(20)
  end program isochoric_density         
