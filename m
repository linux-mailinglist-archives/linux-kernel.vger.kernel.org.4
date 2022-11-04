Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A5E61999F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiKDOYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiKDOXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:23:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77131340;
        Fri,  4 Nov 2022 07:22:18 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF3236600012;
        Fri,  4 Nov 2022 14:22:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667571731;
        bh=qq6t8J/Ig42IfaE17J6TD3ULijHyJbRhy0OgubwHt8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dp9gbgxEE+SHXO+zz8iYwlnpnlblfS333c17CMM3wi2zQfOO5Le+UizE8cDwEr+4A
         JfCjec8JvSurLNZ939kZ12ISE+o8tJQ6cvLQ/mq+nHrthIi8u6Bwr7oTYvHnf5zs3v
         ReRKjnNyPTL0555DjreRG5fSkcfq61Fc87SFizzvYM++SnI54Hcpv9XpJbzGslCrPf
         i0EYRfl2yNYdIKhpTfWEYGhueZXjZXFyzqbgX4fpNoqdtZNCkIYrPGH9sKYd+HngMo
         1KwRoOkuXV4psuSl2srspQgNPDGW0RD8UM/lwCpSrv686ES56OdFkTqLqhxmp5pE8o
         rmy+YP2YOJ5TA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
Subject: [PATCH v2 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm Ramp Controller
Date:   Fri,  4 Nov 2022 15:22:03 +0100
Message-Id: <20221104142204.156333-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221104142204.156333-1-angelogioacchino.delregno@collabora.com>
References: <20221104142204.156333-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for the Qualcomm Ramp Controller, found on various
legacy Qualcomm SoCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../qcom/qcom,msm8976-ramp-controller.yaml    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
new file mode 100644
index 000000000000..67f0bdf7d2da
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,msm8976-ramp-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Ramp Controller
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  The Ramp Controller is used to program the sequence ID for pulse
+  swallowing, enable sequences and link Sequence IDs (SIDs) for the
+  CPU cores on some Qualcomm SoCs.
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8976-ramp-controller
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    power-controller@b014000 {
+        compatible = "qcom,msm8976-ramp-controller";
+        reg = <0x0b014000 0x68>;
+    };
+
-- 
2.37.2

