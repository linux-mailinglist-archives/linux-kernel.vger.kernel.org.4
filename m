Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57E26C25F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCTXqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCTXqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:46:09 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E0640F0;
        Mon, 20 Mar 2023 16:45:24 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f17-20020a9d7b51000000b00697349ab7e7so7662528oto.9;
        Mon, 20 Mar 2023 16:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjAapmrBoeJvk2vnlclkpzuXnRknVk/UGE5rPGWCZzo=;
        b=qp7035o+O46QBK78NPwsQyn/unzLGzPjLE6MzZUl9zutpDTGp/uzGw8/Neo7tA9guP
         R4r4BECcFAz0scl0CyC6jOvCTe/5kG4QzpHbJkasAKOB2s+KJE1dkpy5mJMqafKeut4I
         R3j4Y9yGlLbEaj6MrRbZPzkZTZwnm8q0nnWIgTiy5wFYJx9lClFyZc2SliWR0rRSJuBx
         uz63Oaq+RTs6VCwhx82pdZ+Q7O6WDK1mCLvxUK8Jhmt/B0gavb1ZSXmyr1EdguDXQwZ+
         scgSIupVf1DKI0aX4gA+ni0iyHocV+RdJQglD4nQETQuJakCNY39xEl4GoTCmAxTDk1v
         BRiA==
X-Gm-Message-State: AO0yUKXH7JQKGyDBtj5Krlen+15JlOKQYWauaWHBlUCvprushOv17IbP
        XatrhAz/ZBS8qzX/OTbaFOw3ShswFg==
X-Google-Smtp-Source: AK7set+yH1biLxvRiR6yVgjcR8FkcuTOROnOYpZqzTSFeN8ZAsDNUX+MdLY949P50nSkRhKhjSe8WQ==
X-Received: by 2002:a9d:6948:0:b0:69f:2dd6:7f00 with SMTP id p8-20020a9d6948000000b0069f2dd67f00mr238775oto.36.1679355549393;
        Mon, 20 Mar 2023 16:39:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j18-20020a9d7392000000b00690e42f0da8sm4520941otk.24.2023.03.20.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:39:09 -0700 (PDT)
Received: (nullmailer pid 2920315 invoked by uid 1000);
        Mon, 20 Mar 2023 23:39:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: Drop unneeded quotes
Date:   Mon, 20 Mar 2023 18:39:02 -0500
Message-Id: <20230320233904.2920197-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml         | 4 ++--
 .../devicetree/bindings/usb/brcm,bcm7445-ehci.yaml        | 2 +-
 Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml    | 4 ++--
 Documentation/devicetree/bindings/usb/generic-ehci.yaml   | 2 +-
 Documentation/devicetree/bindings/usb/generic-xhci.yaml   | 2 +-
 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml   | 4 ++--
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 4 ++--
 .../devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml     | 4 ++--
 .../devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml     | 4 ++--
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml        | 2 +-
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml  | 8 ++++----
 Documentation/devicetree/bindings/usb/mediatek,musb.yaml  | 4 ++--
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml        | 4 ++--
 .../devicetree/bindings/usb/realtek,rts5411.yaml          | 2 +-
 .../devicetree/bindings/usb/richtek,rt1711h.yaml          | 4 ++--
 Documentation/devicetree/bindings/usb/richtek,rt1719.yaml | 4 ++--
 Documentation/devicetree/bindings/usb/st,stusb160x.yaml   | 4 ++--
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml   | 4 ++--
 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml    | 4 ++--
 Documentation/devicetree/bindings/usb/usb-xhci.yaml       | 2 +-
 20 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
index f38a2be07eda..da757c1155d4 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
+++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/amlogic,meson-g12a-usb-ctrl.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/amlogic,meson-g12a-usb-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson G12A DWC3 USB SoC Controller Glue
 
diff --git a/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
index ad075407d85e..1536cbec6334 100644
--- a/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Broadcom STB USB EHCI Controller
 
 allOf:
-  - $ref: "usb-hcd.yaml"
+  - $ref: usb-hcd.yaml
 
 maintainers:
   - Al Cooper <alcooperx@gmail.com>
diff --git a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
index 51120fe90322..f6e7a5c1ff0b 100644
--- a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
+++ b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/fcs,fsa4480.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/fcs,fsa4480.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: ON Semiconductor Analog Audio Switch
 
diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 050cfd5acdaa..9445764bd8de 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 
 allOf:
-  - $ref: "usb-hcd.yaml"
+  - $ref: usb-hcd.yaml
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
index db841589fc33..594ebb3ee432 100644
--- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Mathias Nyman <mathias.nyman@intel.com>
 
 allOf:
-  - $ref: "usb-xhci.yaml#"
+  - $ref: usb-xhci.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
index bf4b1d016e1f..f196beb826d8 100644
--- a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
+++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/gpio-sbu-mux.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/gpio-sbu-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: GPIO-based SBU mux
 
diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 8e513a6af378..beccbd1d4d0e 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/maxim,max33359.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/maxim,max33359.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Maxim TCPCI Type-C PD controller
 
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
index c72257c19220..4f6018aadc8c 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek MT6360 Type-C Port Switch and Power Delivery controller
 
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
index 72f56cc88457..747d0f16d9b6 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/mediatek,mt6370-tcpc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/mediatek,mt6370-tcpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediatTek MT6370 Type-C Port Switch and Power Delivery controller
 
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index c119caa9ad16..556bedb96165 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Chunfeng Yun <chunfeng.yun@mediatek.com>
 
 allOf:
-  - $ref: "usb-xhci.yaml"
+  - $ref: usb-xhci.yaml
 
 description: |
   There are two scenarios:
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index d2655173e108..5b908c457e3d 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Chunfeng Yun <chunfeng.yun@mediatek.com>
 
 allOf:
-  - $ref: "usb-drd.yaml"
+  - $ref: usb-drd.yaml
 
 description: |
   The DRD controller has a glue layer IPPC (IP Port Control), and its host is
@@ -204,9 +204,9 @@ patternProperties:
       example if the host mode is enabled.
 
 dependencies:
-  connector: [ 'usb-role-switch' ]
-  port: [ 'usb-role-switch' ]
-  role-switch-default-mode: [ 'usb-role-switch' ]
+  connector: [ usb-role-switch ]
+  port: [ usb-role-switch ]
+  role-switch-default-mode: [ usb-role-switch ]
   wakeup-source: [ 'mediatek,syscon-wakeup' ]
 
 required:
diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.yaml b/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
index f16ab30a95d2..a39d38db7714 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,musb.yaml
@@ -68,8 +68,8 @@ properties:
     type: object
 
 dependencies:
-  usb-role-switch: [ 'connector' ]
-  connector: [ 'usb-role-switch' ]
+  usb-role-switch: [ connector ]
+  connector: [ usb-role-switch ]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
index e638f77658fc..e2270ce0c56b 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/nvidia,tegra-xudc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/nvidia,tegra-xudc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra XUSB device mode controller (XUDC)
 
diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
index 623d04a88a81..9309f003cd07 100644
--- a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
+++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
@@ -26,7 +26,7 @@ properties:
       phandle to the regulator that provides power to the hub.
 
   peer-hub:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       phandle to the peer hub on the controller.
 
diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
index 1999f614c89b..3bec824ec446 100644
--- a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Richtek RT1711H Type-C Port Switch and Power Delivery controller
 
diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
index e3e87e4d3292..43562041b646 100644
--- a/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/richtek,rt1719.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/richtek,rt1719.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Richtek RT1719 sink-only Type-C PD controller
 
diff --git a/Documentation/devicetree/bindings/usb/st,stusb160x.yaml b/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
index ffcd9897ea38..edfebb813f77 100644
--- a/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
+++ b/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/st,stusb160x.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/st,stusb160x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: STMicroelectronics STUSB160x Type-C controller
 
diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index f81ba3e90297..fd36dd02fe74 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/ti,j721e-usb.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/ti,j721e-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI wrapper module for the Cadence USBSS-DRD controller
 
diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
index 348a715d61f4..7d9c5e786e42 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/usb/ti,tps6598x.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/usb/ti,tps6598x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments 6598x Type-C Port Switch and Power Delivery controller
 
diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
index f2139a9f35fb..180a261c3e8f 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Mathias Nyman <mathias.nyman@intel.com>
 
 allOf:
-  - $ref: "usb-hcd.yaml#"
+  - $ref: usb-hcd.yaml#
 
 properties:
   usb2-lpm-disable:
-- 
2.39.2

