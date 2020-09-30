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
  static const Color barColor = Colors.white;

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

    double appbarHeight = 0.0;
    if (widget.hasAppbar) {
      appbarHeight = AppBar().preferredSize.height;
    }

    return Row(
      children: [
        widget.leftChild == null
            ? Container()
            : SizedBox(
                width: leftWidth,
                child: this.widget.leftChild,
              ),
        (widget.leftChild == null || (widget.topRightChild == null && widget.bottomRightChild == null)) ? Container() : horBar(appbarHeight),
        Expanded(
          child: Column(
            children: [
              this.widget.topRightChild == null
                  ? Container()
                  : SizedBox(
                      height: topHeight,
                      child: this.widget.topRightChild,
                    ),
              (widget.topRightChild == null || widget.bottomRightChild == null) ? Container() : verBar(appbarHeight),
              Expanded(
                child: this.widget.bottomRightChild == null ? Container() : this.widget.bottomRightChild,
              ),
            ],
          ),
        ),
      ],
    );
  }

  horBar(double appbarHeight) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: Draggable(
        axis: Axis.horizontal,
        affinity: Axis.horizontal,
        onDragEnd: (detail) {
          print('offset:${detail.offset}');
          setState(() {
            double startOffset = leftWidth;
            double newW = leftWidth + detail.offset.dx - startOffset;
            print('newW:$newW');
            if (newW > 0) {
              leftWidth = newW;
            }
          });
        },
        child: horBarChild(appbarHeight),
        feedback: horBarChild(appbarHeight),
        childWhenDragging: horBarChildMask(appbarHeight),
      ),
    );
  }

  horBarChild(double appbarHeight) {
    return Container(
      color: barColor,
      width: barWeight,
      height: MediaQuery.of(context).size.height - appbarHeight,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDot(),
          SizedBox(height: 2),
          buildDot(),
          SizedBox(height: 2),
          buildDot(),
        ],
      ),
    );
  }

  horBarChildMask(double appbarHeight) {
    return Stack(
      children: [
        Container(
          color: barColor,
          width: barWeight,
          height: MediaQuery.of(context).size.height - appbarHeight,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDot(),
              SizedBox(height: 2),
              buildDot(),
              SizedBox(height: 2),
              buildDot(),
            ],
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.2),
          width: barWeight,
          height: MediaQuery.of(context).size.height - appbarHeight,
        ),
      ],
    );
  }

  verBar(double appbarHeight) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeRow,
      child: Draggable(
        axis: Axis.vertical,
        affinity: Axis.vertical,
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
        child: verBarChild(),
        feedback: verBarChild(),
        childWhenDragging: verBarChildWithMask(),
      ),
    );
  }

  verBarChild() {
    return Container(
      color: barColor,
      height: barWeight,
      width: MediaQuery.of(context).size.width - leftWidth - barWeight,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDot(),
          SizedBox(width: 2),
          buildDot(),
          SizedBox(width: 2),
          buildDot(),
        ],
      ),
    );
  }

  verBarChildWithMask() {
    return Stack(
      children: [
        Container(
          color: barColor,
          height: barWeight,
          width: MediaQuery.of(context).size.width - leftWidth - barWeight,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDot(),
              SizedBox(width: 2),
              buildDot(),
              SizedBox(width: 2),
              buildDot(),
            ],
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.2),
          height: barWeight,
          width: MediaQuery.of(context).size.width - leftWidth - barWeight,
        ),
      ],
    );
  }

  buildDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Color(0xff999999),
      ),
    );
  }
}
