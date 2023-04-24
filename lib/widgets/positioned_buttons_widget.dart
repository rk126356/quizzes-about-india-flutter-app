import 'package:flutter/material.dart';

class PositionedButtons extends StatelessWidget {
  final VoidCallback? onSkipPressed;
  final VoidCallback? onHintPressed;
  final VoidCallback? onViewPressed;
  final VoidCallback? onCompletedViewPressed;
  final VoidCallback? onCompletedSkipPressed;
  final bool isCompleted;
  final bool isHintShowed;
  final bool isAnswerShowed;
  final bool isSkipped;

  const PositionedButtons(
      {Key? key,
      this.onSkipPressed,
      this.onHintPressed,
      this.onViewPressed,
      required this.isAnswerShowed,
      required this.isHintShowed,
      required this.isCompleted,
      required this.isSkipped,
      this.onCompletedSkipPressed,
      this.onCompletedViewPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isCompleted)
                _CompletedBtn(
                  onPressed: onCompletedViewPressed,
                  title: "See Answer",
                  iconName: Icons.visibility,
                )
              else
                _PositionedBtn(
                  onPressed: onSkipPressed,
                  title: isSkipped ? "Next" : "Skip",
                  iconName: Icons.skip_next,
                  cost: isSkipped ? "0" : "10",
                ),
              if (isCompleted)
                _CompletedBtn(
                    onPressed: onCompletedSkipPressed,
                    title: "Next Question",
                    iconName: Icons.skip_next)
              else
                _PositionedBtn(
                  onPressed: onHintPressed,
                  title: "Hint",
                  iconName: Icons.help_outline,
                  cost: isHintShowed ? "FREE" : "20",
                ),
              if (!isCompleted)
                _PositionedBtn(
                  onPressed: onViewPressed,
                  title: "View",
                  iconName: Icons.visibility_outlined,
                  cost: isAnswerShowed ? "FREE" : "30",
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PositionedBtn extends StatelessWidget {
  const _PositionedBtn({
    required this.onPressed,
    required this.title,
    required this.iconName,
    required this.cost,
  });

  final VoidCallback? onPressed;
  final String title;
  final IconData iconName;
  final String cost;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 18.0),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Column(
            children: [
              Row(children: [
                const Icon(Icons.attach_money),
                Text(cost),
              ]),
              Row(children: [
                Icon(iconName),
                const SizedBox(width: 5),
                Text(title),
              ]),
            ],
          )
        ],
      ),
    );
  }
}

class _CompletedBtn extends StatelessWidget {
  const _CompletedBtn({
    required this.onPressed,
    required this.title,
    required this.iconName,
  });

  final VoidCallback? onPressed;
  final String title;
  final IconData iconName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 18.0),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Column(
            children: [
              Row(children: [
                Icon(iconName),
                const SizedBox(width: 5),
                Text(title),
              ]),
            ],
          )
        ],
      ),
    );
  }
}
