Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28465A5A2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLaQEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiLaQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:04:09 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1902FE17;
        Sat, 31 Dec 2022 08:04:08 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 801735C0083;
        Sat, 31 Dec 2022 11:04:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 31 Dec 2022 11:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672502646; x=1672589046; bh=tI
        +Q5IZgCFcUIvi/t4F3MKFC0sVle4pMcTqh7++f2T4=; b=g7/f+8GB/aMIntf4jz
        NQGzPFEqvWdihSBpW8e4NIF/BUIn10iC6UXaJu2Yv3wrbrBFSavuXn3N5sKqWNlh
        JHMn4WVrG6iOEvNPlaPXNa4a6EjAetaEzlfVZAVvEvPMycgF7Xu4XU3nG2Nb0rxG
        PpiswM1XHuCuqpojn8g38GodAuYPgzh4HA2hje6q1WMS/zZ0QUR3Shp/nuqAVZpK
        UW6TvGDfweJ8dLyp8VEwzbhKSE2fktVjTO3cwKQPCiCIw7v2Q6ou6DoptiXBPndp
        mnujfgNO+6BGJ1i7Gp/QfxzCUXcLHsCRW5nbkiDvEA7FZzKhN3KJGqxKq5ZZZbYG
        BqAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672502646; x=1672589046; bh=tI+Q5IZgCFcUI
        vi/t4F3MKFC0sVle4pMcTqh7++f2T4=; b=bzGKFaEI95IzPmZo2pmvSnpAEoCcU
        W6pQpl15OAz9v86M3DOeyvLQjcLtGnzco/Mumrk6iTRohlnKhLEISNmJKXJHgOPF
        mqyy+c3K9wfiRx5md/S+iVzzijkq47XNWynTK1vh7toCD3kNs98Dk/u9yeK7nmcs
        CNfOtwspFdREumQsj40yXcITZ+7PNa8AasKI5hZhoU++UQ5h4aDHk/BsASCGwCPp
        T56UjMCoiKHfzNp3Up+XJn4XUZu1C2M/bHfJP483H7O8fg5o56MD7nFv7z7HFz85
        31yuDwdqMQ14gYrfvJnq756txtEfYvoDjOkSUKZZ8yChmAK7wfGyPjmVA==
X-ME-Sender: <xms:dV2wY78RUukddyOaGB63dqKuNk_IlTllpAD7JPOCuDQSIP0Q0AEALQ>
    <xme:dV2wY3tE7VmAc2DUhf9VDFfRJzuGXevQ1ijALmsJhEzF1O0JInl-R3AD7yq_XCEVR
    Lhyjp8LRkswwJcHNg>
X-ME-Received: <xmr:dV2wY5ACUTjbhRrtJCcL8vTSh_2LGep_ty0JRV2_e62sogwtfWZ8NRJJaP2hOZJ5-z9XEUYdktMclXVvoVquVdYJ76AXaKkjsP8ElhBMIMs4WFlntx7IM3dKQkmTGfDMkVh8vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefghfevhffgheejhefgkeehueffgeehffejgeehueduueeffffhhfeu
    iefhueffhfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhho
    lhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:dV2wY3fjbkSITBc4GBzby7QsInAqDG0onckmSEkstYu9h08YJZc1zw>
    <xmx:dV2wYwOIi-PB7cqgEvjTcqEkzydEx8E6mFJaSGauInpnZgzkRr8opQ>
    <xmx:dV2wY5k3RrwP1E3SQkgz6QHqQ-ULynErSLXY-iC4WPriaT2Rk90_2g>
    <xmx:dl2wYxivhU_mQwiX_cks1IYGr_rIcwfsP7OrTQHHtvzxFgkIAs6gig>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 11:04:05 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 1/2] dt-bindings: power: Add Allwinner D1 PPU
Date:   Sat, 31 Dec 2022 10:04:01 -0600
Message-Id: <20221231160402.16157-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231160402.16157-1-samuel@sholland.org>
References: <20221231160402.16157-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner D1 family of SoCs contain a "PPU" power domain controller
separate from the PRCM. It can power down the video engine and DSP, and
it contains special logic for hardware-assisted CPU idle. Other recent
Allwinner SoCs (e.g. TV303) have a PPU with a different set of domains.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../power/allwinner,sun20i-d1-ppu.yaml        | 54 +++++++++++++++++++
 .../power/allwinner,sun20i-d1-ppu.h           | 10 ++++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
 create mode 100644 include/dt-bindings/power/allwinner,sun20i-d1-ppu.h

diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
new file mode 100644
index 000000000000..64c9a9f398a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/allwinner,sun20i-d1-ppu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner SoCs "PPU" power domain controller
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
+            compatible = "allwinner,sun20i-d1-ppu";
+            reg = <0x7001000 0x1000>;
+            clocks = <&r_ccu CLK_BUS_R_PPU>;
+            resets = <&r_ccu RST_BUS_R_PPU>;
+            #power-domain-cells = <1>;
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

