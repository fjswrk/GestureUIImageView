# GestureUIImageView

When you display a UIImageView,
You can not enlarge the image in a pinch, there are things you want to move by dragging.
Also, bring to center by dragging the good look like part,
Sometimes you want to display by expanding.

But, because in UIImageView of these functions does not have,
Create a subclass of UIImageView, you add the function.

Function is the default on the properties of the
If false the gestureEnabled, you can turn off the feature.

[Function]
- Pinch-scaling of the pinch-out image
Drag image movement of
Tap the original I return to the display

UIImageViewを表示させるときに、
ピンチで画像を拡大させたり、ドラッグして移動させたいことがある。
また、よく見たい部分をドラッグして中心に持ってきて、
拡大させて表示させたいことがある。

でも、UIImageViewではこれらの機能は付いてないので、
UIImageViewのサブクラスを作成し、機能を追加した。

機能はデフォルトオンであり、プロパティの
gestureEnabledをfalseにすると、機能をオフにできる。

【機能】
・ピンチイン・ピンチアウト　画像の拡大・縮小
・ドラッグ　画像の移動
・タップ　元の表示に戻る
