Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC9F65A85B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiLaXz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiLaXzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:55:51 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E489C269;
        Sat, 31 Dec 2022 15:55:46 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 424515817C0;
        Sat, 31 Dec 2022 18:55:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 18:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672530945; x=1672538145; bh=UF
        t7Zu53zTl2BvEb0FKbdoPqlh94wIU/2L8iVmAGJ0w=; b=R/9TIWIUfc6fKZ05dK
        gK3un29z//PtV3pksMJcGCPRgpt43Rw5fj90SSx0FkHiIpNi6eXIxW6qCgRJR6ei
        AmD0jE8v5vyPynZMXkAdk/xcVW6G8gLMTllU/b9f7MRWZYlPhp/n8WvG8IG2o5ud
        1r3lbDDYL8WQr8BMsT+6O79uln0g1P9i/Gr7UzRQFxdyS5VbiHfVIClQjMsxjOzb
        PaHOd45WityHUth+gWdugwFXsYFTJ11CkgwFPYB93AL+1nkMujTpgtkQJjsm2rrj
        us3HExKn9DQWgYaBEB4WP7YfbBjNeSsI/v9++EB3YIYkxumkOix08Sqa3CoV9wBJ
        jsHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672530945; x=1672538145; bh=UFt7Zu53zTl2B
        vEb0FKbdoPqlh94wIU/2L8iVmAGJ0w=; b=wk5PmdKcfiLHZTWg8AMugeM2Ry9VB
        f1DFICZnBmpCnNlNyQuHnOsH9GlfK0FKDNttRSbx8UZG1levqTEYxL+k+5Qa6P4u
        15UO8W8bdtdRbK4wLrpWG/01wp1x22WjZdwOGRtjueSMki1dMmfw6LHIxuF9iHca
        1TY1qi7h6UyjsfziY2Zns37Po0+3HMJ7Pp99DYJQIBkB3NCDKjfKV+9MPj6RUuTL
        NO/C43xGAvBmyGeK6R6NC3izcovjGErZMjM+olqFv6Jx+cOkpVk1XCa/5qkR814M
        xUw3d9bC/tByK91gAyyyohNvx8vQgX/R1qyjInrHGl9fDEQulhOjP0UkQ==
X-ME-Sender: <xms:AMywY1W2yb87Zrs34vbwSz1k8gO01H3qet5-UJj94wM0a_tS5Fu2rA>
    <xme:AMywY1kcBff2m_Z2hiuSbHXma5dHVDaj8sh4iRbjokilUxSAl5pLsxzuWurOj8Fzc
    QCGXfMl8Ov1becj9A>
X-ME-Received: <xmr:AMywYxZgEQyZvzywvg7uDxcyIR3Cg1bd_Oh0aCVjbHCdidl3GHjmgnRXF4ISG9RzV-jgD84xjdrWaDG8fxOJwhbwxi3PIerc9zbNbEhJqRUuHosk6iHYUlrel4WyK_s3qP6ksQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefghfevhffgheejhefgkeehueffgeehffejgeehueduueeffffhhfeu
    iefhueffhfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhho
    lhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:AMywY4UZ5ayF8-H-YYGQnpaoPrrEPDsZO3O3o9blWD9AiPXRtJo28A>
    <xmx:AMywY_kfWYv9xbW5ULwzAben-7rwCtfUGX7ZxJRTAXaYSAmURByKzA>
    <xmx:AMywY1fvHlCSpseVNWMibBdOV14e8NCQmtZVjRQYbwh8JepqEwYnPQ>
    <xmx:AcywYxWfidEThcXWUOvMxO5u0gQwoUyC0uvp48k9PxRQIc_E6zTINw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:55:43 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v7 1/5] dt-bindings: leds: Add Allwinner A100 LED controller
Date:   Sat, 31 Dec 2022 17:55:36 -0600
Message-Id: <20221231235541.13568-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231235541.13568-1-samuel@sholland.org>
References: <20221231235541.13568-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.37.4

