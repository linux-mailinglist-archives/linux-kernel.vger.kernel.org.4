Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D6F6269C8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiKLOLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKLOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:11:41 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9191116E;
        Sat, 12 Nov 2022 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=hFw4qvAwGyTitVnpTQTBIT/SjfI1ORlSUFAPYzi73m8=; b=uiAX67alqU6y2zCjLaObhkyGtJ
        NTLOHjdL2HXcGSnrwGz9kFs2zlNZ1EjUqS4xLSX4xFMQDnGO8RtQa9KAdsG9sLTMTz1PCwZblJx6p
        vB7u6IZv7h+SZaGu5OaLog+M54BmDuO5DsP8iae2hndF1n2xfE5AkLaovwZgabEkzg92D5PAnU/dD
        Yi9kC9Us250TobhK5qYnji7N7hKwLPz+CQtrUb5JlutUr4EeYLgw1dLAs1to5KUZHNN8q4OoAMUk1
        qd43WPYEKk2yo0/4AaQcnfZpt3u/8AehCiZmYsDR+HcKNDzsYHc1kyMqLPgYLQkHs7oa+soSdunU9
        R9smvjGQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1otrE5-00AbQz-GB; Sat, 12 Nov 2022 15:11:17 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1otrE4-00FxDh-2N;
        Sat, 12 Nov 2022 15:11:16 +0100
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
Subject: [PATCH v1 1/3] dt-bindings: RNG: Add Rockchip RNG bindings
Date:   Sat, 12 Nov 2022 15:10:57 +0100
Message-Id: <20221112141059.3802506-2-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221112141059.3802506-1-aurelien@aurel32.net>
References: <20221112141059.3802506-1-aurelien@aurel32.net>
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
 .../devicetree/bindings/rng/rockchip-rng.yaml | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/rockchip-rng.yaml

diff --git a/Documentation/devicetree/bindings/rng/rockchip-rng.yaml b/Documentation/devicetree/bindings/rng/rockchip-rng.yaml
new file mode 100644
index 000000000000..87d80e8ff7f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/rockchip-rng.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/rockchip,rk-rng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip TRNG bindings
+
+description:
+  This driver interface with the True Random Number Generator present in some
+  Rockchip SoCs.
+
+maintainers:
+  - Aurelien Jarno <aurelien@aurel32.net>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3568-rng
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: clk
+      - const: hclk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: reset
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    rng@fe388000 {
+      compatible = "rockchip,rk3568-rng";
+      reg = <0x0 0xfe388000 0x0 0x4000>;
+      clocks = <&cru CLK_TRNG_NS>, <&cru HCLK_TRNG_NS>;
+      clock-names = "trng_clk", "trng_hclk";
+      resets = <&cru SRST_TRNG_NS>;
+      reset-names = "reset";
+    };
+
+...
-- 
2.35.1

