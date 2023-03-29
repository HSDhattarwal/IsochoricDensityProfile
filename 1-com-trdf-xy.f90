program tgrdf
  Implicit none
  Integer, Parameter               :: nsite =3200,nframes =100000  !90000 ! maximum
  Real*8, Parameter                :: delr = .05 ,dely=.05 ,pi = 3.141592
  Integer                          :: ii, jj, i, j, k,ibinr,ibiny
  Integer, Parameter               :: maxbinr = 200, maxbiny=200        ! maxbin = maxhop/delhop
  Real*8, allocatable              :: corx(:,:), cory(:,:), corz(:,:)  
  Real*8, allocatable              :: r(:), y(:) 
  Integer                          :: n1,n2
  Integer,allocatable              :: nbin(:,:)
  Real*8,allocatable               :: anbin(:,:)
  Character*5                      :: dum1,dum2
  Real*8                           :: x

!!!!!!!!!!!Allocate***************************************************************************************
allocate (corx(nframes,nsite)); allocate (cory(nframes,nsite)); allocate (corz(nframes,nsite))
allocate (r(maxbinr)); allocate (y(maxbiny)); allocate (nbin(maxbiny,maxbinr))
allocate (anbin(maxbiny,maxbinr))
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  Open(10,file = 'traj-shift.gro') ! file of type 1
!  Open(20,file = 'xyz.dat') ! file of type 2
  Open(30,file = 'x-y-nd.dat')

      corx(:,:)=0.0; cory(:,:)=0.0; corz(:,:)=0.0
   do k = 1, nframes
   Read(10,*)
   Read(10,*)
      do jj = 1, nsite
         Read(10,'(i5,2a5,i5,3F8.3 )')  n1, dum1,dum2, n2, corx(k,jj),cory(k,jj), corz(k,jj)
      enddo 
      Read(10,*) 
   enddo

x=-5.0
do i=1, maxbinr
r(i)=x
x=x+delr
enddo

x=0.0 
do i=1, maxbiny
y(i)=x
x=x+delr
enddo

   ibinr=1 
   ibiny=1 
   nbin(:,:)=0
   anbin(:,:)=0


   do ii=1,nframes
   do j=1,nsite
   do jj=1, maxbiny
            do k=1, maxbinr
if (corx(ii,j) .gt. r(k) .and.corx(ii,j).le.r(k+1).and.(corz(ii,j) .gt.-0.5.and.corz(ii,j).le. 0.5)&
& .and. cory(ii,j) .gt. y(jj) .and. cory(ii,j) .le.y(jj+1)) then
!                  write(20,*)jj,k, corx(ii,j)
  nbin(jj,k)=nbin(jj,k)+1 
               endif
            enddo
         enddo       
      enddo
   enddo

   do jj=1, maxbiny
      do k=1, maxbinr
         anbin(jj,k)=real(nbin(jj,k)/(abs(delr*dely)*nframes))   
         write(30,*) r(k), y(jj), anbin(jj,k)
      enddo
   enddo

close(10)
close(20)
close(30)

!*******************Deallocate*************************************************************
deallocate (corx); deallocate (cory); deallocate (corz)
deallocate (r); deallocate (y); deallocate (nbin)
deallocate (anbin)


  end program tgrdf
