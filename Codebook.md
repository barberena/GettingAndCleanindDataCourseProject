Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean: Mean value
std: Standard deviation
meanFreq: Weighted average of the frequency components to obtain a mean frequency
angle: Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector for the Human Activity Data Set:
SubjectID
Activity
tBodyAcc-mean-X
tBodyAcc-mean-Y
tBodyAcc-mean-Z
tBodyAcc-std-X
tBodyAcc-std-Y
tBodyAcc-std-Z
tGravityAcc-mean-X
tGravityAcc-mean-Y
tGravityAcc-mean-Z
tGravityAcc-std-X
tGravityAcc-std-Y
tGravityAcc-std-Z
tBodyAccJerk-mean-X
tBodyAccJerk-mean-Y
tBodyAccJerk-mean-Z
tBodyAccJerk-std-X
tBodyAccJerk-std-Y
tBodyAccJerk-std-Z
tBodyGyro-mean-X
tBodyGyro-mean-Y
tBodyGyro-mean-Z
tBodyGyro-std-X
tBodyGyro-std-Y
tBodyGyro-std-Z
tBodyGyroJerk-mean-X
tBodyGyroJerk-mean-Y
tBodyGyroJerk-mean-Z
tBodyGyroJerk-std-X
tBodyGyroJerk-std-Y
tBodyGyroJerk-std-Z
tBodyAccMag-mean
tBodyAccMag-std
tGravityAccMag-mean
tGravityAccMag-std
tBodyAccJerkMag-mean
tBodyAccJerkMag-std
tBodyGyroMag-mean
tBodyGyroMag-std
tBodyGyroJerkMag-mean
tBodyGyroJerkMag-std
fBodyAcc-mean-X
fBodyAcc-mean-Y
fBodyAcc-mean-Z
fBodyAcc-std-X
fBodyAcc-std-Y
fBodyAcc-std-Z
fBodyAcc-meanFreq-X
fBodyAcc-meanFreq-Y
fBodyAcc-meanFreq-Z
fBodyAccJerk-mean-X
fBodyAccJerk-mean-Y
fBodyAccJerk-mean-Z
fBodyAccJerk-std-X
fBodyAccJerk-std-Y
fBodyAccJerk-std-Z
fBodyAccJerk-meanFreq-X
fBodyAccJerk-meanFreq-Y
fBodyAccJerk-meanFreq-Z
fBodyGyro-mean-X
fBodyGyro-mean-Y
fBodyGyro-mean-Z
fBodyGyro-std-X
fBodyGyro-std-Y
fBodyGyro-std-Z
fBodyGyro-meanFreq-X
fBodyGyro-meanFreq-Y
fBodyGyro-meanFreq-Z
fBodyAccMag-mean
fBodyAccMag-std
fBodyAccMag-meanFreq
fBodyBodyAccJerkMag-mean
fBodyBodyAccJerkMag-std
fBodyBodyAccJerkMag-meanFreq
fBodyBodyGyroMag-mean
fBodyBodyGyroMag-std
fBodyBodyGyroMag-meanFreq
fBodyBodyGyroJerkMag-mean
fBodyBodyGyroJerkMag-std
fBodyBodyGyroJerkMag-meanFreq
angle-tBodyAccMean-gravity
angle-tBodyAccJerkMean-gravityMean
angle-tBodyGyroMean-gravityMean
angle-tBodyGyroJerkMean-gravityMean
angle-X-gravityMean
angle-Y-gravityMean
angle-Z-gravityMean

The complete list of variables of each feature vector for the Activity Mean Data Set:
SubjectID
Activity
ActivityMean-tBodyAcc-mean-X
ActivityMean-tBodyAcc-mean-Y
ActivityMean-tBodyAcc-mean-Z
ActivityMean-tBodyAcc-std-X
ActivityMean-tBodyAcc-std-Y
ActivityMean-tBodyAcc-std-Z
ActivityMean-tGravityAcc-mean-X
ActivityMean-tGravityAcc-mean-Y
ActivityMean-tGravityAcc-mean-Z
ActivityMean-tGravityAcc-std-X
ActivityMean-tGravityAcc-std-Y
ActivityMean-tGravityAcc-std-Z
ActivityMean-tBodyAccJerk-mean-X
ActivityMean-tBodyAccJerk-mean-Y
ActivityMean-tBodyAccJerk-mean-Z
ActivityMean-tBodyAccJerk-std-X
ActivityMean-tBodyAccJerk-std-Y
ActivityMean-tBodyAccJerk-std-Z
ActivityMean-tBodyGyro-mean-X
ActivityMean-tBodyGyro-mean-Y
ActivityMean-tBodyGyro-mean-Z
ActivityMean-tBodyGyro-std-X
ActivityMean-tBodyGyro-std-Y
ActivityMean-tBodyGyro-std-Z
ActivityMean-tBodyGyroJerk-mean-X
ActivityMean-tBodyGyroJerk-mean-Y
ActivityMean-tBodyGyroJerk-mean-Z
ActivityMean-tBodyGyroJerk-std-X
ActivityMean-tBodyGyroJerk-std-Y
ActivityMean-tBodyGyroJerk-std-Z
ActivityMean-tBodyAccMag-mean
ActivityMean-tBodyAccMag-std
ActivityMean-tGravityAccMag-mean
ActivityMean-tGravityAccMag-std
ActivityMean-tBodyAccJerkMag-mean
ActivityMean-tBodyAccJerkMag-std
ActivityMean-tBodyGyroMag-mean
ActivityMean-tBodyGyroMag-std
ActivityMean-tBodyGyroJerkMag-mean
ActivityMean-tBodyGyroJerkMag-std
ActivityMean-fBodyAcc-mean-X
ActivityMean-fBodyAcc-mean-Y
ActivityMean-fBodyAcc-mean-Z
ActivityMean-fBodyAcc-std-X
ActivityMean-fBodyAcc-std-Y
ActivityMean-fBodyAcc-std-Z
ActivityMean-fBodyAcc-meanFreq-X
ActivityMean-fBodyAcc-meanFreq-Y
ActivityMean-fBodyAcc-meanFreq-Z
ActivityMean-fBodyAccJerk-mean-X
ActivityMean-fBodyAccJerk-mean-Y
ActivityMean-fBodyAccJerk-mean-Z
ActivityMean-fBodyAccJerk-std-X
ActivityMean-fBodyAccJerk-std-Y
ActivityMean-fBodyAccJerk-std-Z
ActivityMean-fBodyAccJerk-meanFreq-X
ActivityMean-fBodyAccJerk-meanFreq-Y
ActivityMean-fBodyAccJerk-meanFreq-Z
ActivityMean-fBodyGyro-mean-X
ActivityMean-fBodyGyro-mean-Y
ActivityMean-fBodyGyro-mean-Z
ActivityMean-fBodyGyro-std-X
ActivityMean-fBodyGyro-std-Y
ActivityMean-fBodyGyro-std-Z
ActivityMean-fBodyGyro-meanFreq-X
ActivityMean-fBodyGyro-meanFreq-Y
ActivityMean-fBodyGyro-meanFreq-Z
ActivityMean-fBodyAccMag-mean
ActivityMean-fBodyAccMag-std
ActivityMean-fBodyAccMag-meanFreq
ActivityMean-fBodyBodyAccJerkMag-mean
ActivityMean-fBodyBodyAccJerkMag-std
ActivityMean-fBodyBodyAccJerkMag-meanFreq
ActivityMean-fBodyBodyGyroMag-mean
ActivityMean-fBodyBodyGyroMag-std
ActivityMean-fBodyBodyGyroMag-meanFreq
ActivityMean-fBodyBodyGyroJerkMag-mean
ActivityMean-fBodyBodyGyroJerkMag-std
ActivityMean-fBodyBodyGyroJerkMag-meanFreq
ActivityMean-angle-tBodyAccMean-gravity
ActivityMean-angle-tBodyAccJerkMean-gravityMean
ActivityMean-angle-tBodyGyroMean-gravityMean
ActivityMean-angle-tBodyGyroJerkMean-gravityMean
ActivityMean-angle-X-gravityMean
ActivityMean-angle-Y-gravityMean
ActivityMean-angle-Z-gravityMean
