Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817AE6382FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiKYECQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYEBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:01:20 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910E52C649;
        Thu, 24 Nov 2022 20:01:19 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 081C15C0118;
        Thu, 24 Nov 2022 23:01:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 24 Nov 2022 23:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669348879; x=1669435279; bh=mj
        3Gov5wKiQnQuD89ZZReDiiaf0nPdNccfQhMNfEqG8=; b=ItEin8pqsM13pA2zZh
        W4wIeOd4FOuJf6cBV4DkjLtegSyIFfBFapj1mM0geaoAznlISlXX9zkrRJpJGGhY
        akRCZ6NrGFnQSdLZ9Ihnf7HvTeE57Mr0Y0BQgSQxn20o536J1QwSdUkJG2ZWBGEI
        06vx/nxbA2r6otro8b9whbxyK7gcquTVtpg1+Lz2+NZ2uL9OO63q6xNph0iW28XX
        HC3su8FOfLYjybwllQ6nyCGtwYHFYzVz+ptKCYps2x451CY+CASdD7RcsiwBkp/P
        id0M1cZc6vH31KnSlRqGsfRf4Q4rYXVPpru5/Av07PRXpKhkrYAAUajipRBqXgKs
        zkWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669348879; x=1669435279; bh=mj3Gov5wKiQnQ
        uD89ZZReDiiaf0nPdNccfQhMNfEqG8=; b=GLUc3ZmcAe6E9lb10iXixwo7/q7Nj
        RHbdF8WbUaI6nrtCUYFNXSVrn+0i9xB8408XQoq/ury1ecNxMPR0MwN9/v6PskDF
        vPMwH9y6M23LcQUGlcthbg9IZQ+1TqHKodAjGWJbMXRHZY3s0SPByNzdrVMlh9bK
        0Fupv3SBUTLR79dywlI0bKPUyrTTTrFiknP6bdqeDAZAkAbyeDZKq2wE4geU2K8Q
        a0XyiUWFoTJl+M5rZuPhb3LY4/qnmuhsNY5GCuBKYd3BORX+Q9DQrUeftzl0RprY
        vEL7vFQAY5x8Wmio/SyA0S6/YUtEs4k8MHfUs6dw+hw0+XFlkOPz2dlDQ==
X-ME-Sender: <xms:Dj6AY25ZvBrJMk0IjCteQkNhxI3GIqZMUdoqrX-Xsu_HdV3V7HrZXQ>
    <xme:Dj6AY_4D6bf4lvN-ha5YxDGf_BAfKW69dsDIQcRfz638GzAP3AHcfLO_sgLXnQ56M
    mTEjP6p0qAKSnOVEg>
X-ME-Received: <xmr:Dj6AY1c_VZGNT4faTWKxkGontusoICBu1ORWhug2-Dsi-lr4bR0hyTcVmYtGEoxIXQ898y1UrPhQoa1Es_T2edZYZNvUcR75L1jO6NqBRyne5wczEKPKFbGJR4q78bwHqWdBbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeggdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Dj6AYzKOS5OGzZnjDlxaghOrztDTgUDllbEdmedynPaZc7mMDHXGLw>
    <xmx:Dj6AY6I7SEcNHPUAIvIsRvS5JnKET8cL9D3TDGSgYgsUnS1i0fvaqg>
    <xmx:Dj6AY0yMkzX4y5ODomva5ewOxjCmcd8TzPRBXGO_ygtHeb7lWnjbOw>
    <xmx:Dz6AY8DS8Z3wzCSil75DitSdnu5zT7lvbWL1Srv5DbR6hSWyuIDYOA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Nov 2022 23:01:18 -0500 (EST)
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
Subject: [PATCH v4 3/4] dt-bindings: sram: sunxi-sram: Add regulators child
Date:   Thu, 24 Nov 2022 22:01:11 -0600
Message-Id: <20221125040112.18160-4-samuel@sholland.org>
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

Some sunxi SoCs have in-package regulators controlled by a register in
the system control MMIO block. Allow a child node for this regulator
device in addition to SRAM child nodes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v4:
 - Remove unevaluatedProperties from regulators schema reference

Changes in v3:
 - Require the regulators node to have a unit address
 - Reference the regulator schema from the SRAM controller schema
 - Move the system LDOs example to the SRAM controller schema
 - Reorder the patches so the example passes validation

Changes in v2:
 - New patch for v2

 .../allwinner,sun4i-a10-system-control.yaml   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index 98a7dc7f467d..c487ac9521e9 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -56,6 +56,9 @@ properties:
   ranges: true
 
 patternProperties:
+  "^regulators@[0-9a-f]+$":
+    $ref: /schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
+
   "^sram@[a-z0-9]+":
     type: object
 
@@ -130,3 +133,28 @@ examples:
         };
       };
     };
+
+  - |
+    syscon@3000000 {
+      compatible = "allwinner,sun20i-d1-system-control";
+      reg = <0x3000000 0x1000>;
+      ranges;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      regulators@3000150 {
+        compatible = "allwinner,sun20i-d1-system-ldos";
+        reg = <0x3000150 0x4>;
+
+        reg_ldoa: ldoa {
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+        };
+
+        reg_ldob: ldob {
+          regulator-name = "vcc-dram";
+          regulator-min-microvolt = <1500000>;
+          regulator-max-microvolt = <1500000>;
+        };
+      };
+    };
-- 
2.37.4

