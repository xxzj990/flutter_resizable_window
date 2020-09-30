import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResizableWindowView extends StatefulWidget {
  const ResizableWindowView({
    Key key,
    this.leftChild,
    this.topRightChild,
    this.bottomRightChild,
    this.hasAppbar = false,
  })  : assert(leftChild != null || topRightChild != null || bottomRightChild != null),
        super(key: key);

  final Widget leftChild;
  final Widget topRightChild;
  final Widget bottomRightChild;
  final bool hasAppbar;

  @override
  State<StatefulWidget> createState() {
    return _ResizableWindowViewState();
  }
}

class _ResizableWindowViewState extends State<ResizableWindowView> {
  static const double barWeight = 10.0;

  double leftWidth = 200.0;
  double topHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    if (this.widget.leftChild != null && this.widget.topRightChild == null && this.widget.bottomRightChild == null) {
      return this.widget.leftChild;
    } else if (this.widget.leftChild == null && this.widget.topRightChild != null && this.widget.bottomRightChild == null) {
      return this.widget.topRightChild;
    } else if (this.widget.leftChild == null && this.widget.topRightChild == null && this.widget.bottomRightChild != null) {
      return this.widget.bottomRightChild;
    }
    return buildWindow(this.widget.leftChild, this.widget.topRightChild, this.widget.bottomRightChild);
  }

  buildWindow(Widget left, Widget topRIght, Widget bottomRight) {
    if (widget.leftChild == null) {
      leftWidth = 0.0;
    } else if (widget.topRightChild == null) {
      topHeight = 0.0;
    } else if (widget.bottomRightChild == null) {
      topHeight = MediaQuery.of(context).size.height;
      if (widget.hasAppbar) {
        topHeight -= AppBar().preferredSize.height;
      }
    }

    return Row(
      children: [
        this.widget.leftChild == null ? Container() : this.widget.leftChild,
        Column(
          children: [
            this.widget.topRightChild == null
                ? Container()
                : SizedBox(
                    height: topHeight,
                    width: MediaQuery.of(context).size.width - leftWidth,
                    child: this.widget.topRightChild,
                  ),
            (widget.topRightChild == null || widget.bottomRightChild == null)
                ? Container()
                : SizedBox(
                    width: MediaQuery.of(context).size.width - leftWidth,
                    height: barWeight,
                    child: verBar(widget.hasAppbar ? AppBar().preferredSize.height : 0),
                  ),
            this.widget.bottomRightChild == null
                ? Container()
                : SizedBox(
                    height: MediaQuery.of(context).size.height - topHeight - barWeight - AppBar().preferredSize.height,
                    width: MediaQuery.of(context).size.width - leftWidth,
                    child: this.widget.bottomRightChild,
                  ),
          ],
        ),
      ],
    );
  }

  verBar(double appbarHeight) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeRow,
      child: Draggable(
        axis: Axis.vertical,
        onDragStarted: () {},
        onDragEnd: (detail) {
          print('offset:${detail.offset}');
          setState(() {
            double startOffset = topHeight + appbarHeight;
            double newH = topHeight + detail.offset.dy - startOffset;
            print('newH:$newH');
            if (newH > 0) {
              topHeight = newH;
            }
          });
        },
        child: Container(
          color: Colors.grey,
          height: barWeight,
        ),
        feedback: Container(
          color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: barWeight,
        ),
      ),
    );
  }
}
