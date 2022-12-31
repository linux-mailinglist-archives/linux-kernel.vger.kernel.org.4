Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB43A65A838
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiLaXjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiLaXi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:38:59 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8A659F;
        Sat, 31 Dec 2022 15:38:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CC6D15C00AB;
        Sat, 31 Dec 2022 18:38:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 31 Dec 2022 18:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672529937; x=1672616337; bh=1I
        mKfp6mi3k5y3IxQlr3G7vHr9aqIhKTT53gvo+gyWE=; b=XV86o/RF/CRjWqO/eU
        yGsjWW2THBLcCo2wCcmXfr2V2i8L49kMKz96VuVfpe07qo+0S/2XfogXAtbF4okA
        0aD/MFX0fyXJ5G5ROinFGb1sbVkiBa435Bl1xqyk5YsC0QIHIWLuyZ9gB9+EsMk5
        c3+p4i7RAyoCluoRFx5MxHSKJa47J4pFTn0C9S4o5/waBCVx24yrEHhcnKv3bBMo
        KiW0gt8LRfrrdYwQSyHVf+KF2oqhqNKdnkGTW9Ss6ZXCaG+H3yorEbakyMbXgIbE
        HnX/LdEnXxsffuoD+Zgebp5x83Nywu9sQ0JCThqzv5LgLMvB6XEjtTrqwb1nob5I
        LWWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672529937; x=1672616337; bh=1ImKfp6mi3k5y
        3IxQlr3G7vHr9aqIhKTT53gvo+gyWE=; b=D03YZprMyQ9rJBqzs5/KTqhbEgVKk
        w7BasElU3IQmfNHYlvn7oRQ6NK51hVvN6UMoIyzzahs/tSEmHKFWf3JwhVQnRvXJ
        cmLDvikbHtno03CHFr6feWT2Ggw8KoseRqsfhDV6qfZ/Wa89l+TsrsO6g1NPdHWo
        x/PmdX4ycpK5SiRF/tbX/x3ihJj9YwDmwRydNoRNmlFnU6vKbWwc5Y+L2p4Ec+u1
        suY9+CxaP6zSyXfaJ+/7fcnaEvhF3HtzuC7TKcm3+kLjbwIB107cTjxu1TjrypMz
        ZBPHczFK1NE6RHUkiPCtPcKr7PHDoGpaj26JHZVovgPNY+I7Qe0RR99vQ==
X-ME-Sender: <xms:EciwY8SNtMfYn2R8Tc9ho1-MUY4GxhHFtNpH5H3tnC_wKA9qswm1jw>
    <xme:EciwY5yQ5C-c6wMCplE4_5-Qdm-al-4AGcHINOkUUSzqShY3l2FTOUoedIkfD8Q7U
    CRmoIl3sJbdiPQ6qA>
X-ME-Received: <xmr:EciwY50Sbk2SP91XXF5hcMVql_yNs7oXZwcjWnhti_wAcYO6GPL_foT8ch3w_mHpsNm2nJjkrk-cdkqD1r7vrw8XUU88PaUUlFlu5UnxaTi9zEIS1EoyrMBrxKwbbc0PxlxOIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefghfevhffgheejhefgkeehueffgeehffejgeehueduueeffffhhfeu
    iefhueffhfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhho
    lhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:EciwYwBnNnAS2FsK1a2X_rKZ8k2pcGdGot6caADAkw1n3_ghzB_s_w>
    <xmx:EciwY1if99cROLHoFaFMLY3Irhrc-kx7CRMEKH41EMIpdYJbJN288g>
    <xmx:EciwY8qEniPyQ1gP6ZUiw5Z6EuNQY9rAxd7l9uLj_jffVwFybqc2cw>
    <xmx:EciwY-a3zkn7NIvap9tTYKIkeAz_NqtkotoovGi7sGEKniGA4bE-lg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:38:56 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 03/12] dt-bindings: riscv: Add Allwinner D1/D1s board compatibles
Date:   Sat, 31 Dec 2022 17:38:42 -0600
Message-Id: <20221231233851.24923-4-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231233851.24923-1-samuel@sholland.org>
References: <20221231233851.24923-1-samuel@sholland.org>
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

Several SoMs and boards are available that feature the Allwinner D1 or
D1s SoC. Document their compatible strings.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v2)

Changes in v2:
 - Add MangoPi MQ (non-Pro) board

 .../devicetree/bindings/riscv/sunxi.yaml      | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sunxi.yaml b/Documentation/devicetree/bindings/riscv/sunxi.yaml
new file mode 100644
index 000000000000..9edb5e5992b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sunxi.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sunxi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner RISC-V SoC-based boards
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Jernej Skrabec <jernej.skrabec@gmail.com>
+  - Samuel Holland <samuel@sholland.org>
+
+description:
+  Allwinner RISC-V SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Dongshan Nezha STU SoM
+        items:
+          - const: 100ask,dongshan-nezha-stu
+          - const: allwinner,sun20i-d1
+
+      - description: D1 Nezha board
+        items:
+          - const: allwinner,d1-nezha
+          - const: allwinner,sun20i-d1
+
+      - description: ClockworkPi R-01 SoM and v3.14 board
+        items:
+          - const: clockwork,r-01-clockworkpi-v3.14
+          - const: allwinner,sun20i-d1
+
+      - description: ClockworkPi R-01 SoM, v3.14 board, and DevTerm expansion
+        items:
+          - const: clockwork,r-01-devterm-v3.14
+          - const: clockwork,r-01-clockworkpi-v3.14
+          - const: allwinner,sun20i-d1
+
+      - description: Lichee RV SoM
+        items:
+          - const: sipeed,lichee-rv
+          - const: allwinner,sun20i-d1
+
+      - description: Carrier boards for the Lichee RV SoM
+        items:
+          - enum:
+              - sipeed,lichee-rv-86-panel-480p
+              - sipeed,lichee-rv-86-panel-720p
+              - sipeed,lichee-rv-dock
+          - const: sipeed,lichee-rv
+          - const: allwinner,sun20i-d1
+
+      - description: MangoPi MQ board
+        items:
+          - const: widora,mangopi-mq
+          - const: allwinner,sun20i-d1s
+
+      - description: MangoPi MQ Pro board
+        items:
+          - const: widora,mangopi-mq-pro
+          - const: allwinner,sun20i-d1
+
+additionalProperties: true
+
+...
-- 
2.37.4

