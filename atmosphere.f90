MODULE atmosphere
    IMPLICIT NONE
    
    INTEGER :: numSpecPoints, maxNumComponents, maxNumLevels ! number of scpectral points in stepV interval, maximum number of components in atmosphere
    PARAMETER (numSpecPoints=20481, maxNumComponents=10, maxNumLevels=200)
    
    CHARACTER(LEN=80) :: atmosphereTitle   ! title or description of the atmosphere profile file
    CHARACTER(LEN=5) :: molecName(maxNumComponents) ! array of molecule names presented in atmosphere profile
    INTEGER :: numComponents, numLevels   ! number of components, number of atmospheric levels
    REAL(KIND=4) :: height(maxNumLevels), pressure(maxNumLevels), temp(maxNumLevels)   ! gas profile data from file
    REAL(KIND=4) :: conc(maxNumComponents, maxNumLevels) ! components concentrations
    
    CONTAINS 
    SUBROUTINE read_profile(atmosphereFile)
        CHARACTER(LEN=20) atmosphereFile   ! name of a file with atmospheric data
        INTEGER :: i, j ! loop variables
        OPEN(11, FILE='./Control/check_atmosphere.txt')
        OPEN(12, FILE='./Atmospheres/'//atmosphereFile)
        READ(12, '(A)') atmosphereTitle
        WRITE(11, *) atmosphereTitle
        READ(12, *) numComponents, numLevels
        WRITE(11, *) 'The number of gases: ', numComponents
        WRITE(11, *) 'The number of atmospheric levels: ', numLevels

        DO i = 1, numComponents
            READ(12, '(A)') molecName(i)
        END DO
        WRITE(11, *) "Atmospheric components: ", (molecName(i), i=1,numComponents)

        height = 0. ; pressure = 0. ; temp = 0. ; conc = 0.
        DO j=1, numLevels
            READ(12, *)  height(j), pressure(j), temp(j), (conc(i,j), i=1,numComponents) 
            WRITE(11, *) height(j), pressure(j), temp(j), (conc(i,j), i=1,numComponents)
        END DO

        CLOSE(11)
        CLOSE(12)
    END SUBROUTINE
END MODULE