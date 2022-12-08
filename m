Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC47646AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLHIl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:41:36 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4B261BA5;
        Thu,  8 Dec 2022 00:41:35 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id F3F1A3200583;
        Thu,  8 Dec 2022 03:41:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 08 Dec 2022 03:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670488893; x=1670575293; bh=Tk
        CT8U+X3N1U6fotPxSufI3kcQezGdSYmJTP5FLzjnU=; b=JuRmQzN8OIcihpugbq
        8WDUaOV3eHgPKYMWi0eo501/oyB2x2kSVJFHtAdc/3eIKTfLvew1PriAmMKHPZ0z
        yxUBG3AXIooAnsmSzrpGHq7Flyt2BLsuhOvSoWdNyGpG/aUdfPLhsMU3mhHZhhwQ
        0+p9oCX1Jh8vmj7iqRwscc53LjDkQ6MPN935fEN8zYA75tkUkutV3oI/cHiNGEpV
        wNodbQ5InvFWPjvuM1RP+FfvpILmMPAHyRH5aL0qDu1k2LAccsBZGPJ9jkysqEdf
        B9pfQKzllCgCw1R64FXf6wcaee/UZgMPQB0kRjpPNgpDJIwgX6qxucS37Bovrd/x
        8APQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670488893; x=1670575293; bh=TkCT8U+X3N1U6
        fotPxSufI3kcQezGdSYmJTP5FLzjnU=; b=MLAmBnAjs4Ab3z2xcLd0i1Xnfhad9
        KGws1d0FhVKJhgBr30zYDM7cmQ0zn8XH75nLqxC8tEZz6rvKmCbqi31+sK2ga/iX
        RMcdhyan+SfSKNB/bXlp5xXXFIux/DMIz7iQqthIBAJXCNfV2Hdh20YqnLjXHiEO
        86/CVVAkR9mGRKUpRxqvtDYz/N+LYWaapWKvjPvgj2+3JQRxZNN3lVtkAPVxbMXY
        2jFW7JkWUlQegh0LfxroRmhooU085TK+I1Hin8NtYEHwb60ogUiky1zeu4fGe761
        91m2EKGsYNriJa2I+8/IUgCuIH9ra9dsoyVXzE1F1bl0w9dEwy5jX62Wg==
X-ME-Sender: <xms:PaORYzroUei0TCjfPwNDDYJtEl0JnKEc4dDFxAXmjyhr9afK260R-A>
    <xme:PaORY9oY8iqcfaht3c7OCUSf1QtuMrw5zEvW2qrw2AhiFjS-pRDw-QMMnZxF6kMAZ
    KF3VBIQOms_hkrNJQ>
X-ME-Received: <xmr:PaORYwPJwLe1ACG0LzH_a2sFa0WZ7F25NYpR4VuCoYi-xL_KbgIhFvjM00uk99mO1c3k7Ov1otEqwSNv_51IuzuANAesKEgDP4sygmiriY3h6DfAEl5ob0o1u1gdSc5GrK29oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgffhvefhgfehjeehgfekheeuffegheffjeegheeuudeufeffhffh
    ueeihfeufffhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhh
    ohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:PaORY260VZ8yvfk43PO3VcTU90n7KqJAnihF_HbWNSBwYDyfgIn6Ew>
    <xmx:PaORYy5rRM1WihtHzqU08sTQn44b7_t5nyka6rF6w3RD640vjJe-ZA>
    <xmx:PaORY-iSuxHJzdTgciBmfFPrlMQfT5Gqo63kpuTM-d2_sVVIudfWgw>
    <xmx:PaORYxSc8gIz0loOp4jBqy9Vudt53nJq-NCeeI_fNPw0tN65ta_0tg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 03:41:32 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/4] regulator: dt-bindings: Add Allwinner D1 system LDOs
Date:   Thu,  8 Dec 2022 02:41:24 -0600
Message-Id: <20221208084127.17443-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221208084127.17443-1-samuel@sholland.org>
References: <20221208084127.17443-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner D1 SoC contains two pairs of in-package LDOs. The pair of
"system" LDOs is for general purpose use. LDOA generally powers the
board's 1.8 V rail. LDOB powers the in-package DRAM, where applicable.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v4)

Changes in v4:
 - Fix the order of the maintainer/description sections
 - Replace unevaluatedProperties with "additionalProperties: false"
 - Drop the analog LDOs until the codec binding is ready

Changes in v3:
 - Add "reg" property to bindings
 - Add "unevaluatedProperties: true" to regulator nodes
 - Minor changes to regulator node name patterns
 - Remove system-ldos example (now added in the parent binding)

Changes in v2:
 - Remove syscon property from bindings
 - Update binding examples to fix warnings and provide context

 .../allwinner,sun20i-d1-system-ldos.yaml      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml

diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
new file mode 100644
index 000000000000..ec6695c8d2e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner D1 System LDOs
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+description:
+  Allwinner D1 contains a pair of general-purpose LDOs which are designed to
+  supply power inside and outside the SoC. They are controlled by a register
+  within the system control MMIO space.
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun20i-d1-system-ldos
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^ldo[ab]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+...
-- 
2.37.4

