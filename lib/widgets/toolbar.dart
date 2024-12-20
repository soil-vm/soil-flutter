import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../vm_state.dart';

class Toolbar extends StatelessWidget {
  const Toolbar(this.state, {super.key});

  final VMState state;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<_ToolbarAction>(
      segments: [
        if (state.isRunning)
          const ButtonSegment(
            value: _ToolbarAction.pause,
            icon: Icon(Symbols.pause),
            tooltip: 'Pause',
          )
        else
          ButtonSegment(
            value: _ToolbarAction.play,
            enabled: state.vm.status.isRunning,
            icon: const Icon(Symbols.play_arrow),
            tooltip: 'Continue',
          ),
        ButtonSegment(
          value: _ToolbarAction.step,
          enabled: !state.isRunning && state.vm.status.isRunning,
          tooltip: 'Run Single Instruction',
          icon: const Icon(Symbols.step),
        ),
        const ButtonSegment(
          value: _ToolbarAction.restart,
          tooltip: 'Restart',
          icon: Icon(Symbols.refresh),
        ),
      ],
      emptySelectionAllowed: true,
      selected: const {},
      onSelectionChanged: (it) => _handleSelection(it.single),
    );
  }

  void _handleSelection(_ToolbarAction action) {
    switch (action) {
      case _ToolbarAction.play:
        state.play();
      case _ToolbarAction.pause:
        state.pause();
      case _ToolbarAction.step:
        state.step();
      case _ToolbarAction.restart:
        state.restart();
    }
  }
}

enum _ToolbarAction { play, pause, step, restart }
