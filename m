Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE59862DCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbiKQNaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiKQNaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:30:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8370A3A;
        Thu, 17 Nov 2022 05:30:05 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 15F056602A9E;
        Thu, 17 Nov 2022 13:30:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668691804;
        bh=diKrpCWyppPm84t0hqsBG/0u3xN/nvNnHoXQJMzv5rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPHeMtgna+xOb2ygzAk91/sNjmie3s3oanUdmb1/RG/uW7Unb4D5BKfKwvsXzU0Kq
         x+NRBpvZmOeu74ftHldfGoi2CVsxZSgh/HhZAWjB4UBnLXqEeWRA4xO5XtWgh9Axba
         kCzRZZm9qrl+nfDOJKm8OiFVcw13OtDLy/NlUh3gLsrisWGPv9EDt3HbrMsgSE5iLR
         1zdfzKPWvK76ESxUMAcbC6svfu13ugaL4v7iOMkcXkikY+UaEx8PQBLDqn3/U9t9rF
         ddEEQicK5mpa3d3CGwixpiwTuzyjRWXkWU0l+IvKLs4pNVD3yMaLxVo6puJq9lPZRm
         orLUfvyj2776g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm Ramp Controller
Date:   Thu, 17 Nov 2022 14:29:55 +0100
Message-Id: <20221117132956.169432-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117132956.169432-1-angelogioacchino.delregno@collabora.com>
References: <20221117132956.169432-1-angelogioacchino.delregno@collabora.com>
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

Document the Qualcomm Ramp Controller, found on various legacy
Qualcomm SoCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../qcom/qcom,msm8976-ramp-controller.yaml    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
new file mode 100644
index 000000000000..aae9cf7b8caf
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
@@ -0,0 +1,36 @@
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
+    cpu-power-controller@b014000 {
+        compatible = "qcom,msm8976-ramp-controller";
+        reg = <0x0b014000 0x68>;
+    };
-- 
2.38.1

