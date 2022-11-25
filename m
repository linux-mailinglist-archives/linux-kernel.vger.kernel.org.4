Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E686382F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKYEB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKYEBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:01:19 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35137275DA;
        Thu, 24 Nov 2022 20:01:17 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A063B5C007D;
        Thu, 24 Nov 2022 23:01:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 24 Nov 2022 23:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669348876; x=1669435276; bh=JC
        uy5R1bmezvRsKKC80yVJZVXQr04HtEota8U0NbJjg=; b=pV3mAWbOCg93trlgZx
        /1h3cuCuOMY9zXfkAP4NGNzAxC+255BVmIcwlVSvREpiPvEqicLzMLR74ZYaqVqX
        QwvlCr0t9pUMdbo+HFwjKA7kzlsQR+XykVknon45ePQpaqYeUZXILTAqDlOM9kKW
        4Nl6BvrsENNMOH8ysAV2s68uUx39BWvWruxBeB+3hR4tomoyeapeXdFVHhjv/xKy
        3Y8lQDWTHG+Q1WnX2EL4EzAoM5SufLJAU9FKBkuHgkT/sGIKusx0Cd6YcYgwnD1l
        IaS/QsTXBBziCUWnfBuFRKMKkBr64MQsadxAADjBCBUQqRr1jEf0pZGSpj1yu+RF
        7Zhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669348876; x=1669435276; bh=JCuy5R1bmezvR
        sKKC80yVJZVXQr04HtEota8U0NbJjg=; b=XMZoSQxWq82mXpjImbElp9zPLsjuK
        KyS9+K0U1PY0yWlzK1O0jaantcgGnImgv7neH5k+TObfowod4EtTUrYhVtjZcuVW
        IieU87B05wzlMeAHHXJdtamOPcOEvl66VJ03sYUZB7rx05W4w8n0m4yRa+ibqDUz
        kvjjIP3xKF11wnPyufWBz8T3TOYNV5BtD+vyf2lV64C2Xr/hgkAYhKPByMezTmUi
        fKZdiTq1tuSX59HTudt7/TPGi248TZ+32sYnm6cZTbAEMuyh5W6hyeAq7sz9PXfq
        qxGZFpz4cyTgQe0fZuHeBfeF9ybU75SHJVv52DzuWyuX9r7Gv/80OiDAw==
X-ME-Sender: <xms:DD6AY2AlPh2TkDR-KJavv8IddtP73Hs02LDdZK9QP0mKcFoZlerx0Q>
    <xme:DD6AYwhGgEXiONvnMTEoRjRJO7tnXnZprV2XS530j7uF4gT3JbrcxzZevHRtw06QB
    72bhkQXULgi1He9qw>
X-ME-Received: <xmr:DD6AY5lZSU0MkybDuFBlUpuAv6StPx4WzJa-lAiVpycU5O79WCfBtIrxYSGN8klsJoVc7qvcuT35sj8vpDH9wWTUpkX1jxz4z3LNP_hvS0GUIA_WFe5CQnyA5cPV6hyR4Xww-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeggdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefghfevhffgheejhefgkeehueffgeehffejgeehueduueeffffhhfeu
    iefhueffhfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhho
    lhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:DD6AY0wIqlrRaYDQzxjzuBJ3YdfKSM5BINIAZoL06RoF5FgyfHCnog>
    <xmx:DD6AY7SULSjM3UNZ2Mzn6MP-U7scByDX-Cz-NykCMgpb3Ee9HqwcYg>
    <xmx:DD6AY_ak2L2PCVVrK981SYkFHlOOZ-vyh6iG7mWuOgsYuZNR4rjMTg>
    <xmx:DD6AY6LrLSgeDtun68TF8HRoe-PrESa8q-PMUepNEvCDAln-Z6iUTw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Nov 2022 23:01:15 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v4 1/4] regulator: dt-bindings: Add Allwinner D1 system LDOs
Date:   Thu, 24 Nov 2022 22:01:09 -0600
Message-Id: <20221125040112.18160-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221125040112.18160-1-samuel@sholland.org>
References: <20221125040112.18160-1-samuel@sholland.org>
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

The Allwinner D1 SoC contains two pairs of in-package LDOs. The pair of
"system" LDOs is for general purpose use. LDOA generally powers the
board's 1.8 V rail. LDOB powers the in-package DRAM, where applicable.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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

