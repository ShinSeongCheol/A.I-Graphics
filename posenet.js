let classifier;
let dropBox;
let img = 0;
let img1, img2;
let size=0;
let poseNet;
let poses=[];
let keypointX=[];
let keypointY=[];
let skeletons=[];

function preload() {
  classifier = ml5.imageClassifier('MobileNet');
  img1 = loadImage('');
}

function setup() {
  dropBox = createCanvas(1280, 800);
  background(100);
  dropBox.drop(afterDrop);
}

function afterDrop(file){
  img = loadImage(file.data,imageReady);
  classifier.classify(img, gotResult);
}

function imageReady(){
  resizeCanvas(img.width, img.height+60);
  background(100);
  image(img,0,0);
    poseNet = ml5.poseNet(modelReady);
  poseNet.on('pose', gotResult);
}

function modelReady(){
  poseNet.singlePose(img);
  console.log('model OK');
}

function gotResult(results){
  poses = results[0].pose.keypoints;
  skeletons = results[0].skeleton;
  fill('#FFFF00');
  stroke('#FF0000');
  strokeWeight(3);
  for(let i = 0; i < poses.length; i++){
    keypointX[i]=round(poses[i].position.x);
    keypointY[i]=round(poses[i].position.y);
    ellipse(keypointX[i], keypointY[i],10);
  }
  stroke('#FFFF00');
  strokeWeight(2);
  for(let i=0; i< skeletons.length; i++){
    line(round(skeletons[i][0].position.x), round(skeletons[i][0].position.y), round(skeletons[i][1].position.x), round(skeletons[i][1].position.y));
  }
  size = dist(keypointX[0],keypointY[0],keypointX[3],keypointY[3]);
  imageMode(CENTER);
  fill(255, 255, 0, 200);
  ellipse(keypointX[0], keypointY[0]-20, 80, 100);
  image(img1,keypointX[0]-3,keypointY[0]-13,size*1.8,size*1.8);
  console.log(poses);
}
