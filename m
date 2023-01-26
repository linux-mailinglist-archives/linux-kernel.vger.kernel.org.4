Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4185467C47C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 07:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjAZGe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 01:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjAZGeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 01:34:25 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1814A239;
        Wed, 25 Jan 2023 22:34:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C629B3200A55;
        Thu, 26 Jan 2023 01:34:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jan 2023 01:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674714862; x=1674801262; bh=/7
        vsQYAZ7pK41UhsKZMQw8k1y0lXknyA0ndIUdSSThU=; b=YRdE1aYjlmPbAzQKcw
        5XOLVCKMfzQbClQZxL9hbHJx7wCKNed1PQM5O69JtGFVRC5vrCb08p6umTk7CW4n
        7AEFSHUthPIRwlrnGdg8HSxTJlbLQnUYPcsbp2gra8m3wcMRG3X67pRHnR2AALgs
        TA9UAlHJ0yKv55Wj+8zAQCnDjk6GzzQShesqMZfab0IN1Ruc+yfjFowh8QvCaPzu
        lIhKMzyzuTuyT7PbDXqqcrq/Zw9jB6cOSNVV5qAIHF+bmdHXV2VhIke3+Rlc/zdG
        OAN18iT0cM9i6rbHa6maVTQgM+WcMBDryUtT76tqiRGGOJ+dJZg4Mvw5vLV5AYz3
        e2fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674714862; x=1674801262; bh=/7vsQYAZ7pK41
        UhsKZMQw8k1y0lXknyA0ndIUdSSThU=; b=XTqE0yaDz+fq9y/ph43kOJaeOQtFd
        Z3OyJ96m7AsMrA27OhXj+DDE1G3F0yhJbBPUUICDdg5O7lC/RWbj809ngbqA5uzO
        fVGUIKREaXfySaR2VdNVqEbtqR/HaaW1B5cB89w11Rw7EnUHtCx4qPx7Zb7bMs5M
        MfjXIYbdI9f8SrcFDFWx8dAw4O8vZjLgOcEqUs80dE3xHhUvNatd81WoG9hfAkZL
        qLscCDkiKLUV+6sekHsyTJpPCFQKVmlURQRajByBtD/JSZgcUOmj3XAjy0v4IMEP
        4+eF0lkGgvedEcA3U2moFFbryxCrDTnnIAIkKvduYeI6Gsrl8Q9rsQt2g==
X-ME-Sender: <xms:7h7SY1CXRaEjiLF8IWTHZ8eUaLkZCjPz5k80ToatCn6Oi1zzwWXTEg>
    <xme:7h7SYzhpSVbwvYqM7FtikAyYoV14uPvYSdECtJIILulf73OfYr7ILjiXGNAxrQ5Gm
    kZS5L0tCbYmRYZg_A>
X-ME-Received: <xmr:7h7SYwl1yjiWpEKXEdA_ogKk1lJQsYFB3xmE6KjYGdRRyGkSO_5tINvP7b3GpSp1OdIMwrHekQ3wNa1bpb5swgWiAMpnxQhuL_7ZeRyCWa7TKs-5xcA52q403nbxFKDcLMmNWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgffhvefhgfehjeehgfekheeuffegheffjeegheeuudeufeffhffh
    ueeihfeufffhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhh
    ohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:7h7SY_xWiQpANZeCadbgfS1AMHlZddz5H7cU-psynjsSvmFuHfbbwQ>
    <xmx:7h7SY6Q1NNVxT_P6JABmqCdwMx4Wv2cQtH4Ufj9ZXV3go3Paeyeo4g>
    <xmx:7h7SYybLgtv-9uHvBWwObFgXwN4Wg_tXCymkCHFpkGJ2RELTiF2WYA>
    <xmx:7h7SY2p5R4t5Zvz_-MUtUWd5jU1V45I9fGFiJPwF9p_OQcD75R98ug>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 01:34:21 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: power: Add Allwinner D1 PPU
Date:   Thu, 26 Jan 2023 00:34:17 -0600
Message-Id: <20230126063419.15971-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230126063419.15971-1-samuel@sholland.org>
References: <20230126063419.15971-1-samuel@sholland.org>
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

The Allwinner D1 family of SoCs contain a PPU power domain controller
separate from the PRCM. It can power down the video engine and DSP, and
it contains special logic for hardware-assisted CPU idle. Other recent
Allwinner SoCs (e.g. TV303) have a PPU with a different set of domains.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Removed quotes from "PPU"
 - Fixed indentation in binding example

 .../power/allwinner,sun20i-d1-ppu.yaml        | 54 +++++++++++++++++++
 .../power/allwinner,sun20i-d1-ppu.h           | 10 ++++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
 create mode 100644 include/dt-bindings/power/allwinner,sun20i-d1-ppu.h

diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
new file mode 100644
index 000000000000..46e2647a5d72
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/allwinner,sun20i-d1-ppu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner SoCs PPU power domain controller
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+description:
+  D1 and related SoCs contain a power domain controller for the CPUs, GPU, and
+  video-related hardware.
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun20i-d1-ppu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: Bus Clock
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sun20i-d1-r-ccu.h>
+    #include <dt-bindings/reset/sun20i-d1-r-ccu.h>
+
+    ppu: power-controller@7001000 {
+        compatible = "allwinner,sun20i-d1-ppu";
+        reg = <0x7001000 0x1000>;
+        clocks = <&r_ccu CLK_BUS_R_PPU>;
+        resets = <&r_ccu RST_BUS_R_PPU>;
+        #power-domain-cells = <1>;
+    };
diff --git a/include/dt-bindings/power/allwinner,sun20i-d1-ppu.h b/include/dt-bindings/power/allwinner,sun20i-d1-ppu.h
new file mode 100644
index 000000000000..23cfb57256d6
--- /dev/null
+++ b/include/dt-bindings/power/allwinner,sun20i-d1-ppu.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_POWER_SUN20I_D1_PPU_H_
+#define _DT_BINDINGS_POWER_SUN20I_D1_PPU_H_
+
+#define PD_CPU			0
+#define PD_VE			1
+#define PD_DSP			2
+
+#endif /* _DT_BINDINGS_POWER_SUN20I_D1_PPU_H_ */
-- 
2.37.4

