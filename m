Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE4639148
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 23:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKYWJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 17:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYWJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:09:06 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C413230F62;
        Fri, 25 Nov 2022 14:09:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 39F325C00BB;
        Fri, 25 Nov 2022 17:09:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 25 Nov 2022 17:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1669414145; x=1669500545; bh=4cM7oNUdfCrlaSJutCnkmr2DS
        EvNa89l2bj+Gk9Ktgs=; b=s+lO9y6IgAxAoQATpo319Vik09JCjdzjRLrVMaR1k
        xBK5BVySFXV1Yb8z/yFCqh5wYMOtJ25nfqmgixBxaw5MUUzIlLAIvGIMQdS6WBVG
        j81xPq1JfwJeGLt1fTQdm3aquX8PhavOu+9rsJdecBYgwnLJJh0Fk8uGeVnP1ytS
        +r/x7NBBJr4vm3IkPkTNzVDKemWzmgvkoVsp/q95B8KqG3BEJoqCdN1Ni1N/Actp
        LG58R+kzjp8fE2aAz8NI2l/AXg2uRLUuVI/N01EJ4ZHiJjztZe/Fyyi/ZVsz0FoW
        19PeW9IWINS2dGtXsYyU8ypr1S6exs0HjAbz3OvHl3RcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1669414145; x=1669500545; bh=4cM7oNUdfCrlaSJutCnkmr2DSEvNa89l2bj
        +Gk9Ktgs=; b=umPjCECfK0vyccZOO8bYUymxE1owvvdzLy1lIJ9l1Hay4l0WGLl
        RR9kriJ6iQ0VqwKd9GwmoF1UwCCezK7WWGfcjmFlwp+/2PtrHSGUGw9vo0gpB7Fj
        N6EOWLZKtpykRW2Ks84nNn7RFZnjHP+56FPNyRHWmvP/Nim1jsg5MYHWOL+HLwxC
        xq9B5T4IMokHdTa2gpROJ+J7pjvzsw6QDwhrVgVqFykzHqjM0cd2YhBRwBce5V72
        GvJwvbEJr8ZjO1wNtUq3oA9oKkQW8EPWPgPERKFOrenpZJTfYxZUjFlAtRtoveir
        WbokxlrBr6eBYHODXqBfhyKWMbgmwsq43Mg==
X-ME-Sender: <xms:AD2BY0JTU6omxzpP6sx6hBl5No1dMDnQXvoJfWVO4r9eLfRpnmEsEw>
    <xme:AD2BY0LbFad5cs34sCzfK3bu5Tz6UATmaWYL0-1jqPtWHEcC5TkLoghoZWHftMnxT
    8EN7Hdx7FgCJpqzVA>
X-ME-Received: <xmr:AD2BY0v_gxu97xqmrhrO2sWPQ_6O8cRvb-xX2d6X44XvyAA3RmG_3CZtzrR1I91Xk8EkQhfA_SY0ST18yz_PNAYcehUYw-A7Xf23IJYMpHyYWkVDnH-h2v5-WweRH5MGlZ9ssw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieehgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepfeduffffueetveefudehueelgefgvdfffeelledtjeegudeiudehffdt
    jefhgefhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:AT2BYxaBmPZQTLwvqAa8Ke1sl2cMmTjVVWygheylE_E0wdi4Uq5AAw>
    <xmx:AT2BY7Z-dFPDXQUkN6y-ZlfzAW_pRI08_IRs1ALZjr8YMuTreDiftw>
    <xmx:AT2BY9ATIFdM0QRZ988gbyjXBzhfyTBp4WSKGKtV74OhpDgrsYmsYA>
    <xmx:AT2BYwMNJAsMm5ZR8YdE9lLYoZQMvzW9x0NvhGjrJLfihooMjUTUNw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 17:09:04 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: adc: ti,adc081c: Document the binding
Date:   Fri, 25 Nov 2022 16:09:03 -0600
Message-Id: <20221125220903.8632-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
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

Linux has a driver for these ADCs at drivers/iio/adc/ti-adc081c.c, but
the compatible strings were undocumented. Add a binding for them. The
hardware has an alert interrupt output, but existing ti,adc081c users
do not provide the 'interrupts' property, so leave it as optional.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../bindings/iio/adc/ti,adc081c.yaml          | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
new file mode 100644
index 000000000000..caaad777580c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,adc081c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI Single-channel I2C ADCs
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+  - Lars-Peter Clausen <lars@metafoo.de>
+
+description: |
+  Single-channel ADC supporting 8, 10, or 12-bit samples and high/low alerts.
+
+properties:
+  compatible:
+    enum:
+      - ti,adc081c
+      - ti,adc101c
+      - ti,adc121c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Regulator for the combined power supply and voltage reference
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@52 {
+            compatible = "ti,adc081c";
+            reg = <0x52>;
+            vref-supply = <&reg_2p5v>;
+        };
+    };
+...
-- 
2.37.4

