# Tumor Detection using Watershed Segmentation Algorithm

This Matlab project implements tumor detection using the Watershed segmentation algorithm. The algorithm segments a grayscale medical image to detect and highlight potential tumor regions based on morphological operations and gradient analysis.

## Description

The `watershedsegmentation.m` script performs the following steps:

1. **Preprocessing**:
   - Reads an input image (path needs to be specified).
   - Converts the image to grayscale and double precision.
   
2. **Gradient Calculation**:
   - Computes the gradient magnitude of the image using Sobel filters for edge detection.
   
3. **Watershed Transformation**:
   - Applies the watershed transform on the gradient magnitude to segment the image into regions.
   - Labels the segmented regions for visualization.

4. **Morphological Operations**:
   - Performs morphological opening, erosion, closing, and dilation to enhance the segmentation:
     - Opening (`Io`)
     - Opening by reconstruction (`Iobr`)
     - Opening-closing (`Ioc`)
     - Opening-closing by reconstruction (`Iobrcbr`)
   
5. **Region of Interest Detection**:
   - Detects regional maxima in the reconstructed image (`fgm`) to identify potential tumor areas.
   - Superimposes the detected maxima on the original image (`I2`).

6. **Post-processing**:
   - Performs additional morphological operations (`fgm2`, `fgm3`, `fgm4`) to refine the detected regions and remove small objects.

## Usage

To run the script:

1. Open Matlab.
2. Set the path of your input image in the `imread` function call within the script.
3. Execute the `watershedsegmentation` function.

Ensure you have Matlab's Image Processing Toolbox installed as it is required for some functions used in this script.

## Example Output

The script displays multiple subplots showing each stage of the segmentation process:

- Original Image
- Gradient magnitude
- Watershed transform result
- Morphological operations results
- Detected regional maxima
- Final segmented image with tumor regions highlighted

## Contributors

- **Sai Naresh Padakanti** - Developer and Tester

Feel free to modify and adapt this script according to your specific image dataset and application needs.
