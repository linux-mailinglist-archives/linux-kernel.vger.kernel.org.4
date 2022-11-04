Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3DE619834
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiKDNf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiKDNfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:35:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A662EF05;
        Fri,  4 Nov 2022 06:35:13 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 982006602988;
        Fri,  4 Nov 2022 13:35:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667568912;
        bh=Z7unUtH1iL4beg4GCp+BMWAkfQq1Ey6XiGH7wc3J2F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfMEWTK6aou8C8XtM5bzG3hAV7R9lyyvW8E6/v6KqRqL/KHbSY4bND8vf4pEj6nWY
         Z657DnqMtyy79lfqjJ1q6zyTHCEoFdbB3uvR6hSN0sRIJw1UgZb/fYQY3+hj6IO8Oo
         VRFGeekDx8j0wNcjqFj6rD91DUmzA6gbzaYrLsjSPs5asD2FxPMzoBUMkCZRWgoNiK
         be+ngFjMIZFZHwS+gb2zPBc/vlwOP0CER9J4uiIJvdrzFW2kbemss+GNv1abi5AxvL
         25yJBBbtLugOl8LXjor39OncWqs+8LmgM13AdPeJCi4BJ1LZzEWfZXHDvKDgcmA3RP
         vsNsQStBnjjAQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
Subject: [PATCH 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm Ramp Controller
Date:   Fri,  4 Nov 2022 14:35:05 +0100
Message-Id: <20221104133506.131316-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221104133506.131316-1-angelogioacchino.delregno@collabora.com>
References: <20221104133506.131316-1-angelogioacchino.delregno@collabora.com>
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
 .../soc/qcom/qcom,ramp-controller.yaml        | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml
new file mode 100644
index 000000000000..95ce48cfca4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,ramp-controller.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Ramp Controller
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  The Ramp Controller is used to program the sequence ID for pulse
+  swallowing, enable sequences and linking Sequence IDs (SIDs) for
+  the CPU cores on some Qualcomm SoCs.
+
+properties:
+  compatible:
+    items:
+      enum:
+        - qcom,msm8976-ramp-controller
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
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        power-controller@b014000 {
+            compatible = "qcom,msm8976-ramp-controller";
+            reg = <0x0b014000 0x68>;
+        };
+    };
-- 
2.37.2

