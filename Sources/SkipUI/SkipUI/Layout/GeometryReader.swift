// Copyright 2023–2026 Skip
// SPDX-License-Identifier: MPL-2.0
#if !SKIP_BRIDGE
#if SKIP
import androidx.compose.foundation.layout.Box
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.layout.LayoutCoordinates
import androidx.compose.ui.layout.boundsInParent
import androidx.compose.ui.layout.boundsInRoot
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.IntSize
#endif

// SKIP @bridge
public struct GeometryReader : View, Renderable {
    public let content: (GeometryProxy) -> any View

    // SKIP @bridge
    public init(@ViewBuilder content: @escaping (GeometryProxy) -> any View) {
        self.content = content
    }

    #if SKIP
    @Composable override func Render(context: ComposeContext) {
        let rememberedGlobalFramePx = remember { mutableStateOf<Rect?>(nil) }
        let rememberedSizePx = remember { mutableStateOf(IntSize.Zero) }
        Box(modifier: context.modifier.fillSize().onGloballyPositionedInRootWithSize { bounds, sizePx in
            rememberedGlobalFramePx.value = bounds
            rememberedSizePx.value = sizePx
        }) {
            if let globalFramePx = rememberedGlobalFramePx.value {
                let proxy = GeometryProxy(globalFramePx: globalFramePx, sizePx: rememberedSizePx.value, density: LocalDensity.current, safeArea: EnvironmentValues.shared._safeArea)
                content(proxy).Compose(context.content())
            }
        }
    }
    #else
    public var body: some View {
        stubView()
    }
    #endif
}

#endif
