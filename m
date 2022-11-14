Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EE7627403
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiKNBGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiKNBGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:06:42 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C02FAD6;
        Sun, 13 Nov 2022 17:06:41 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C21443200913;
        Sun, 13 Nov 2022 20:06:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 13 Nov 2022 20:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668388000; x=1668474400; bh=XC
        XLV1Fn2JMkCGp5d8/IdzhEV6t432NGJWbrn/bcneo=; b=tRPTBauBUAsIYqdjYW
        OKROEBrCE+vH6zCpWyWO51sN+YE2RyruT1UhJ6U6iEbEBGEri4SN+h3+jhudfsuc
        A76sWCecjHThMrVq9VhkbshNAn2aiukBhwi6oyB2Vv9dZV4d7a4BjfK1ft2Z1mp5
        wXHXvxVLwNa/xeAxk/W2jmrKuphooyKx/RKHFYZiyhgVJ1WQWFz0g7hqlnGXsLwU
        T9kbkThDwm0VSjrhUYPolPtxWEXfvYhrFksBmCGukiP9upUzYDH0fjzO1CDgmfww
        aGogmSRcp6cLOSsDiGfuoN0BBJJcOKfRONxfip+VngJaAR4nwzvOmVYlJq7YvEo/
        nAYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668388000; x=1668474400; bh=XCXLV1Fn2JMkC
        Gp5d8/IdzhEV6t432NGJWbrn/bcneo=; b=u6P6XUjEzXL3DoA3oG48AM8GbljQv
        2F8Gf56nlZzAobGatmGjOZ2uIzQHuE96mwN1N/Ke/uzF0VOaZRZ4iLxyPOxSPrgb
        +BfKYe0u19jc/wTMM/q9PW5XW800MUqE4JZhofkmfo4QV7mwbWCKcx+lGntBLUvg
        8ICV+bsCZwMC8/+IPHqDtUMaJ4tLN4olqgvSUjmpZZ830uCxX3+K80LLlWTHoxNr
        9/cLcWAozjSf2gjtYflWUhalvjJLie22lmx7CCDdCrHe7LzfXXHqak92IMVUMy1L
        Rrw8g02HWI+K6RAqR/HBCYbOc57fT0SASGJ4AqXEW0ekBGaCBEB9seMEg==
X-ME-Sender: <xms:oJRxY4-uceCEXiYU1J03RngiDvCis7qVIRKnR4TK5tuaBsOa85y32Q>
    <xme:oJRxYwvpBekqvLqgB5Qfe_Lr6sJOKWM8eH5V0FFytgRev_MvbOslq0RtlJXZtRuHz
    aF7sc2FxIIWRa_qGg>
X-ME-Received: <xmr:oJRxY-BzaN4JACx3vCOKiEouM_6Xy2StI92odpQk5i6Za-HO_jusqQ3JyyuFKehnVTLYv8XrDeR_R9yyjySzVNWB4RpbriCQzpciyjGIxKmb7YRwPQN_b8AT0nMsx8v6XAjXZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefghfevhffgheejhefgkeehueffgeehffejgeehueduueeffffhhfeu
    iefhueffhfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhho
    lhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:oJRxY4cC-OF-KXRRO7kOF0FoFONP7-Ambid61yz3DAWxAIU0OH_B6A>
    <xmx:oJRxY9MhlquCyOYeHIhuvdj42hpjZcma_4MlBvyK_pwLTbkSTf7Yng>
    <xmx:oJRxYymVuprQSRNH2Jky_e3T4XQIV8nCIcLHSMk0knlTPPmBWMtv-w>
    <xmx:oJRxYwrTPjIQJWm-OmIYCMKGHR0GkORWeB_h_kDfIrmBj34UYgcXVg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:06:39 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/5] dt-bindings: leds: Add Allwinner A100 LED controller
Date:   Sun, 13 Nov 2022 19:06:32 -0600
Message-Id: <20221114010636.33052-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221114010636.33052-1-samuel@sholland.org>
References: <20221114010636.33052-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner A100, R329, and D1 SoCs contain an LED controller designed
to drive a series of RGB LED pixels. It supports PIO and DMA transfers,
and has configurable timing and pixel format. All three implementations
appear to be identical, so use the oldest as the fallback compatible.

Acked-by: Maxime Ripard <maxime@cerno.tech>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v5)

Changes in v5:
 - A100 contains the original implementation, so use that as the base
   compatible string, and rename the binding to match
 - Add "unevaluatedProperties: false" to the child multi-led binding

Changes in v4:
 - Use "default" instead of "maxItems" for timing properties

Changes in v3:
 - Removed quotes from enumeration values
 - Added vendor prefix to timing/format properties
 - Renamed "format" property to "pixel-format" for clarity
 - Dropped "vled-supply" as it is unrelated to the controller hardware

Changes in v2:
 - Fixed typo leading to duplicate t1h-ns property
 - Removed "items" layer in definition of dmas/dma-names
 - Replaced uint32 type reference with maxItems in timing properties

 .../leds/allwinner,sun50i-a100-ledc.yaml      | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml

diff --git a/Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml b/Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
new file mode 100644
index 000000000000..fc8ecf6f91e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/allwinner,sun50i-a100-ledc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A100 LED Controller Bindings
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+description:
+  The LED controller found in Allwinner sunxi SoCs uses a one-wire serial
+  interface to drive up to 1024 RGB LEDs.
+
+properties:
+  compatible:
+    oneOf:
+      - const: allwinner,sun50i-a100-ledc
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-ledc
+              - allwinner,sun50i-r329-ledc
+          - const: allwinner,sun50i-a100-ledc
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus clock
+      - description: Module clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+    description: TX DMA channel
+
+  dma-names:
+    const: tx
+
+  allwinner,pixel-format:
+    description: Pixel format (subpixel transmission order), default is "grb"
+    enum:
+      - bgr
+      - brg
+      - gbr
+      - grb
+      - rbg
+      - rgb
+
+  allwinner,t0h-ns:
+    default: 336
+    description: Length of high pulse when transmitting a "0" bit
+
+  allwinner,t0l-ns:
+    default: 840
+    description: Length of low pulse when transmitting a "0" bit
+
+  allwinner,t1h-ns:
+    default: 882
+    description: Length of high pulse when transmitting a "1" bit
+
+  allwinner,t1l-ns:
+    default: 294
+    description: Length of low pulse when transmitting a "1" bit
+
+  allwinner,treset-ns:
+    default: 300000
+    description: Minimum delay between transmission frames
+
+patternProperties:
+  "^multi-led@[0-9a-f]+$":
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1023
+        description: Index of the LED in the series (must be contiguous)
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+
+    ledc: led-controller@2008000 {
+      compatible = "allwinner,sun20i-d1-ledc",
+                   "allwinner,sun50i-a100-ledc";
+      reg = <0x2008000 0x400>;
+      interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&ccu 12>, <&ccu 34>;
+      clock-names = "bus", "mod";
+      resets = <&ccu 12>;
+      dmas = <&dma 42>;
+      dma-names = "tx";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      multi-led@0 {
+        reg = <0x0>;
+        color = <LED_COLOR_ID_RGB>;
+        function = LED_FUNCTION_INDICATOR;
+      };
+    };
+
+...
-- 
2.37.3

