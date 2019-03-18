Adapted from the codebase at the below link: 
http://cseweb.ucsd.edu/~viscomp/projects/SIG17HDR/

Initial release implementation by Nima K. Kalantari, 2017.

-------------------------------------------------------------------------
OVERVIEW

This algorithm takes in a set of three low dynamic range images at different
exposures (in .tif format) as well as a text file containing their exposure bias
and produces an HDR image in .hdr format. In our system, the HDR image is always 
aligned to the image with the middle exposure. For the scenes with ground truth 
image we also output a text file containing the PSNR between the estimated and 
ground truth HDR images.

The code was written in MATLAB 2016b, and tested on Windows 10. When we opened
it, we had a lot of problems compiling OpticalFlow and MatConvNet. We hope that
we have resolved these such that you will be able to run it out of the box, but 
we never got it to work on Linux, so we recommend running with a Mac if you have
one available, on which we run the code. The setup will take significant time.

-------------------------------------------------------------------------

1. Follow the MatConvNet installation instruction to set it up properly. 
   From http://www.vlfeat.org/matconvnet/install/:
      - Go to Libraries/matconvnet-1.0-beta25
      - Start Matlab
        > addpath matlab
        > vl_compilenn
        > vl_setupnn

2. In the Libraries/OpticalFlow/mex directory, run this command:

       mex -v -compatibleArrayDims Coarse2FineTwoFrames.cpp OppticalFlow.cpp GaussianPyramid.cpp

   and copy all Coarse2FineTwoFrames files into the Libraries directory.

3. We have included 2 training scenes, 2 development scenes, and 2 test scenes in all of the proper folders.

4. Run "PrepareData.m" before training (this will take awhile to run). Testing should work without running "PrepareData.m".

5. The code is now ready to be executed. Simply run "TRANSFERTest.m" to test (our transfer trained network will be tested) and "TRANSFERTrain.m" to train the images after having ran "PrepareData.m".

6. The results of testing will be in the /Results folder.

Any further questions can be sent to nsgaudio@stanford.edu or sosekows@stanford.edu

Files we wrote:

DatasetFigure.m
ImagePreprocess_TIF.m
PrepareData.m
PSNRFigure.m
ResizeImages.m
SSIMPSNRFigureData.m
StaticHDRBlendingFormation.m
TRANSFERTest.m
TRANSFERTrain.m
TRANSFERCreateNet.mTRANSFEREvaluateNet.mTRANSFEREvaluateSystem.mTRANSFERGenerateHDR.mTRANSFERLoadNetwork.mTRANSFERTestDuringTraining.mTRANSFERTrainSystem.mTRANSFERUpdateNet.m








The UCSD README:

SOURCE CODE FOR "DEEP HIGH DYNAMIC RANGE IMAGING OF DYNAMIC SCENES"

This package is a MATLAB implementation of the learning-based HDR reconstruction
algorithm described in:

N. K. Kalantari, R. Ramamoorthi
"Deep High Dynamic Range Imaging of Dynamic Scenes", 
ACM Transaction on Graphics 36, 4, August 2017. 

More information can also be found on the authors' project webpage:
http://cseweb.ucsd.edu/~viscomp/projects/SIG17HDR/

Initial release implementation by Nima K. Kalantari, 2017.

This material is based upon work supported by the Office of Naval Research
under Grant No. N00014152013 and National Science Foundation under Grant
No. 1617234 and UC San Diego Center for Visual Computing.

-------------------------------------------------------------------------
I. OVERVIEW

This algorithm takes in a set of three low dynamic range images at different
exposures (in .tif format) as well as a text file containing their exposure bias
and produces an HDR image in .hdr format. In our system, the HDR image is always 
aligned to the image with the middle exposure. For the scenes with ground truth 
image we also output a text file containing the PSNR between the estimated and 
ground truth HDR images.

The code was written in MATLAB 2016b, and tested on Windows 10.

-------------------------------------------------------------------------
II. RUNNING TEST CODE

1. Download MatConvNet package from the following link:
http://www.vlfeat.org/matconvnet/

unzip it and copy it to the "Libraries" folder. Then follow the MatConvNet
installation instruction to set it up properly. Please compile MatConvNet
with GPU and Cudnn support to have the best performance. Otherwise, please
set the appropriate flags in the "InitParam.m" file.

2. Download the optical flow code by Ce Liu from the following link:
http://people.csail.mit.edu/celiu/OpticalFlow/OpticalFlow.zip

Compile it and copy the Coarse2FineTwoFrames file in the "Libraries" folder.

3. Download the "Test set" from the project page, unzip it and copy the
desired scenes into the scene folder. The results shown in the paper
can be found in the "PAPER" folder of the test set.

4. The code is now ready to be executed. Simply open "Test.m" in MATLAB and
run it. 

-------------------------------------------------------------------------
III. PREPARING CAMERA RAW IMAGES (.CR2) TO BE USED AS INPUT TO OUR CODE

We now describe our pipeline for preparing the raw .CR2 images taken by 
the camera for input into our algorithm.  In our case we used various
Canon cameras, but this process might work for other kinds of cameras
as well.

1. Download the "dcraw" program available here: 
   https://www.cybercom.net/~dcoffin/dcraw/
  
   This executable converts raw images to .pgm files which are readable by 
   MATLAB.

2. Use the following command to convert your raw images to pgm:
   dcraw.exe -d -4 filename

   This will write a .pgm file with the same name as the original raw image.

3. Open the "ImagePreprocess.m" file from our distribution in MATLAB.

4. Set the parameters on the top of the code to the values desired. The
   "sensorAlignment" variable is the Bayer pattern configuration and might
   be different from the default depending on the camera. To learn more about 
   it, visit the following link:

   http://www.mathworks.com/help/images/ref/demosaic.html

5. Run ImagePreprocess. It will create a .tif file for every one of the .pgm 
   files.  These .tif files are 16-bit so they preserve all of the dynamic 
   range captured in the original raw LDR images.

6. Make sure the images are sorted according to their exposure times.

7. Crate a text file in the same directory as the .tif images and write the 
   exposure bias for each image.  Use one line per exposure bias. Make
   sure the exposure bias of the image with the lowest exposure is 0.

8. Run the code as described in Sec. II.


For demonstration purposes, we provide our raw images for the "LadySitting" 
scene in the test set.

-------------------------------------------------------------------------
IV. RUNNING TRAINING CODE

1. Follow step 1 and 2 of section III to setup the MatConvNet and the optical
flow code.

2. Download the "Training set" and "Test set" from the project page, unzip
them, copy the training scenes in "TrainingData/Training", and copy the
test scenes in the "TrainingData/Test" folder.

3. Run "PrepareData.m" to process the training and test sets. Note that it 
takes a long time for this function to process the training and test data.

4. Run "Train.m" to start the training. Convergence happens after roughly
2,000,000 iterations. This takes around 2 days on an Nvidia Geforce GTX 1080.

The code writes the network in the "TrainingData" folder. Once the converged 
network is obtained, you can copy it from "TrainingData" to "TrainedNetwork"
folder to test the system using the new network.

-------------------------------------------------------------------------
V. VERSION HISTORY

v1.0 - Initial release   (Aug., 2017)

-------------------------------------------------------------------------

If you find any bugs or have comments/questions, please contact 
Nima K. Kalantari at nkhademi@ucsd.edu.

San Diego, California
August, 2017