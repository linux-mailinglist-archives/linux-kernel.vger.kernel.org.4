Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3FB63B19A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiK1SsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiK1Srt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:47:49 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1DB1403E;
        Mon, 28 Nov 2022 10:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=4Fpzg/r7Nlj+z1PQflqBj9rgdK6sLYVVCPbweKR8DMg=; b=OI8zH4EE3KjDJsLnBmSVvyHfVg
        /fwhI9IObx8xNMfW4OWvClHdLFF7l1fKr+uqDf0ALnQMWm9FO6CAKoY6wUPx5+/LZC/bZj2zahfqA
        XgduWrVdKxQVUKCdsf2VbNWCmtO8Sthd7YW5XF/73ytdrYu21YRNMsk9ducxf7Bb3LWPeKkuP/50L
        /E9qofunJWdAxkJ9e6zN1VDbXJuCQ8G0fdKzGcr8Q6WIfkvCtWKAdHrx0Yjvg8DsZzkmu8Q23DYWE
        0YeCifaFtLi80Cn49canEJigheRQ7IV+HUFVGoWpUznax9PYPzrAqm1Xz95GAVZtvCPE9YrfXPupn
        m/3ak0jQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ozjA2-006BV8-Ii; Mon, 28 Nov 2022 19:47:22 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ozjA1-008Elo-1x;
        Mon, 28 Nov 2022 19:47:21 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>
Cc:     linux-crypto@vger.kernel.org (open list:HARDWARE RANDOM NUMBER
        GENERATOR CORE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list),
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 1/3] dt-bindings: RNG: Add Rockchip RNG bindings
Date:   Mon, 28 Nov 2022 19:47:16 +0100
Message-Id: <20221128184718.1963353-2-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128184718.1963353-1-aurelien@aurel32.net>
References: <20221128184718.1963353-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the RNG bindings for the RK3568 SoC from Rockchip

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 .../bindings/rng/rockchip,rk3568-rng.yaml     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml

diff --git a/Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml b/Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml
new file mode 100644
index 000000000000..c2f5ef69cf07
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/rockchip,rk3568-rng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip TRNG
+
+description: True Random Number Generator for some Rockchip SoCs
+
+maintainers:
+  - Aurelien Jarno <aurelien@aurel32.net>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-rng
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: TRNG clock
+      - description: TRNG AHB clock
+
+  clock-names:
+    items:
+      - const: trng_clk
+      - const: trng_hclk
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      rng@fe388000 {
+        compatible = "rockchip,rk3568-rng";
+        reg = <0x0 0xfe388000 0x0 0x4000>;
+        clocks = <&cru CLK_TRNG_NS>, <&cru HCLK_TRNG_NS>;
+        clock-names = "trng_clk", "trng_hclk";
+        resets = <&cru SRST_TRNG_NS>;
+      };
+    };
+
+...
-- 
2.35.1

