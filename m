Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B225B6D57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiIMMfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiIMMfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:35:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3DCE02A;
        Tue, 13 Sep 2022 05:35:07 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 295EF660201D;
        Tue, 13 Sep 2022 13:35:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663072506;
        bh=pvp7JpbvP2wUE/GSoJ9vSVrGywl5jvUyvOohfAa1vmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgkIiGXPktZRTFsgeevLCHatTdBsOTsNsLS+DnCOZOM8bGhpQ42qIh4ZF4bshM8b9
         PpCyR2WOl+4FS3nCdchM/A0kB2XpB6JzXjXeLkR9IKSxrbYtAbPmRrY55Vw3vFwRux
         J+r77r594sWBV44jg0sTdPpq0Y31PQiPYCNDr9mMyPAT+G756G27L/uNrykbDvpkLx
         eHo32ovusLOv0QjJyty5zJpJTjlSq4AF9h/j3znRB2VsiflOGHN6Zdv+rPJfaAji0S
         AEF5YzRyi/YFrjb0NGU/SNNsVr8wx/ypevJ7sDJB0qmUNs/DTRe0p6Zd44vsSExaSg
         EhbAu/RIcgv4g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/4] dt-bindings: regulator: Add bindings for MT6332 regulator
Date:   Tue, 13 Sep 2022 14:34:55 +0200
Message-Id: <20220913123456.384513-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220913123456.384513-1-angelogioacchino.delregno@collabora.com>
References: <20220913123456.384513-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for the regulators found in the MT6332 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../regulator/mediatek,mt6332-regulator.yaml  | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml
new file mode 100644
index 000000000000..3218f43e6957
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6332-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6332 Regulator from MediaTek Integrated
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description: |
+  The MT6332 Companion PMIC provides 6 BUCK and 4 LDO (Low Dropout)
+  regulators and nodes are named according to the regulator type:
+  buck-<name> and ldo-<name>.
+  MT6332 regulators node should be sub node of the MT6397 MFD node.
+
+patternProperties:
+  "^buck-v(dram|dvfs2|pa|rf18a|rf18b|sbst)$":
+    type: object
+    $ref: "regulator.yaml#"
+
+    properties:
+      regulator-name:
+        pattern: "^v(dram|dvfs2|pa|rf18a|rf18b|sbst)$"
+
+    unevaluatedProperties: false
+
+  "^ldo-v(bif28|dig18|sram|usb33)$":
+    type: object
+    $ref: "regulator.yaml#"
+
+    properties:
+      regulator-name:
+        pattern: "^v(bif28|dig18|sram|usb33)$"
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      regulators {
+        mt6332_vdram_reg: buck-vdram {
+          regulator-name = "vdram";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1493750>;
+          regulator-ramp-delay = <12500>;
+          regulator-allowed-modes = <0 1>;
+          regulator-always-on;
+        };
+        mt6332_vdvfs2_reg: buck-vdvfs2 {
+          regulator-name = "vdvfs2";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1312500>;
+          regulator-ramp-delay = <12500>;
+          regulator-enable-ramp-delay = <1>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6332_vpa_reg: buck-vpa {
+          regulator-name = "vpa";
+          regulator-min-microvolt = <500000>;
+          regulator-max-microvolt = <3400000>;
+        };
+        mt6332_vrf18a_reg: buck-vrf18a {
+          regulator-name = "vrf18a";
+          regulator-min-microvolt = <1050000>;
+          regulator-max-microvolt = <2240625>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6332_vrf18b_reg: buck-vrf18b {
+          regulator-name = "vrf18b";
+          regulator-min-microvolt = <1050000>;
+          regulator-max-microvolt = <2240625>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6332_vsbst_reg: buck-vsbst {
+          regulator-name = "vsbst";
+          regulator-min-microvolt = <3500000>;
+          regulator-max-microvolt = <7468750>;
+        };
+        mt6332_vauxb32_reg: ldo-vauxb32 {
+          regulator-name = "vauxb32";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <3200000>;
+        };
+        mt6332_vbif28_reg: ldo-vbif28 {
+          regulator-name = "vbif28";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+        };
+        mt6332_vdig18_reg: ldo-vdig18 {
+          regulator-name = "vdig18";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-always-on;
+        };
+        mt6332_vsram_reg: ldo-vsram {
+          regulator-name = "vauxa32";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1493750>;
+          regulator-always-on;
+        };
+        mt6332_vusb33_reg: ldo-vusb33 {
+          regulator-name = "vusb33";
+          regulator-min-microvolt = <3300000>;
+          regulator-max-microvolt = <3300000>;
+        };
+      };
+    };
+...
-- 
2.37.2

