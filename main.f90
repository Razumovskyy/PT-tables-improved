PROGRAM main
    USE atmosphere
    IMPLICIT NONE
    DOUBLE PRECISION :: v1, v2   ! input wavenumber boundaries
    DOUBLE PRECISION :: startV, endV, stepV   ! wavenumbers for loops
    CHARACTER(LEN=20) :: inputFile   ! filename with input data
    INTEGER :: i   ! loop variables
    PARAMETER (stepV = 10.D0)   ! step for the loop for calculation of absorption coefficient

    OPEN(1, FILE='input.txt') ! input file with wavenumber boundaries and filename with atmospheric profile
    WRITE(*,*) "Input wavenumber boundaries are:"
    READ(1,*) v1, v2
    WRITE(*,'(A6, 5F6.2)') ' v1 = ', v1
    WRITE(*,'(A6, 5F6.2)') ' v2 = ', v2
    WRITE(*,*) "Atmospheric profile filename:"
    READ(1,'(A)') inputFile
    WRITE(*,*) inputFile
    CLOSE(1)

    CALL read_profile(inputFile)  ! read data from atmospheric profile located in ./Atmospheres/

    startV = v1
    DO i = 1, INT((v2-v1+1)/10)
        endV = startV + stepV
        WRITE(*,'(5F8.2, 5F8.2)') startV, endV
!        CALL coeff_calc(startV)    ! calculating synthetic spectra from HITRAN database files
        startV = startV + stepV
    END DO

    WRITE(*,*) "PT-tables are ready!"
END PROGRAM