Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C435629DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiKOPqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbiKOPqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:46:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF872CCAD;
        Tue, 15 Nov 2022 07:46:01 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B92D56602A2D;
        Tue, 15 Nov 2022 15:45:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668527160;
        bh=diKrpCWyppPm84t0hqsBG/0u3xN/nvNnHoXQJMzv5rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mw7bUZK8HJNS7KCvBxQuJJGEmtpPWgbcat2Liv3YGr9bV439fYCkzUBUcQalCVzHL
         WlAzba/TUuDggKpTIEjO3otW4yNKUcdLM6BNQMNHyRQWmVYSLZgawSIZaxCh59b3p8
         0vL1rROwZV57nrIxAUpQq9UjZ5zemHXrBU7Tf7uQSFvjzANScJkxPwjvtWwMFjHJwg
         dTvwECTvwIOMIK9AqSw71NSNLQzmrU4x64NvOoghmE2ed0gDz5pBg9wINZyMosghJG
         ZaZzjiGbmV7NAk3h80Ziz7oKLvpxDJO5rt3jYZXDmm0V9YylKU/hJqv6Wplsvt5PZZ
         sGFG1bgB1TEQg==
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
Subject: [PATCH v3 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm Ramp Controller
Date:   Tue, 15 Nov 2022 16:45:54 +0100
Message-Id: <20221115154555.324437-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115154555.324437-1-angelogioacchino.delregno@collabora.com>
References: <20221115154555.324437-1-angelogioacchino.delregno@collabora.com>
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

