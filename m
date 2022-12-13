Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8964B85A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiLMP0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiLMP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:26:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BDC2BD9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:26:22 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id q6so5435619lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qq0uorQWqSHSuV/ULmLyUOqP1G8s/X2+rF5AzuYEUHo=;
        b=jNvxbd3tbb+fGqML28PP6ZizN7oMt7Jtey4WigScljn/RGGV+JueC471+RAabQG++h
         m7cc1xBZYWvejrIJqiwNuqSGXtQNfvKeCFQBSmH9P33PrvDRGENIAK7Hsyqgfk7SEVaB
         1RZqMXGmCAe5ygkZL9VPtDH6nDRRZh94YMJoMFWGCEiOSZCq2+oIhBpHH54g3GkOiCeQ
         ZgKLsMKS2Hul1++qj5jWT2x6qCXAKxYJRN7U10ez23fAag+kA7zTHchhk0Hxhv6LrPdY
         3xbH8wB4XTmAvR/E6mMxVtRxuymEpsUJD+EsoeGYtmiaJtVrqTlrEj4InAhPqwS+4Yi7
         kmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qq0uorQWqSHSuV/ULmLyUOqP1G8s/X2+rF5AzuYEUHo=;
        b=eCd+wMxh7/W8TyTAuIZR0esAo5QNQy7KphgvhExBrZ7rIRFJkU1hr/rFrtC2iEaARQ
         PcEMOvqrBR0o7X2KSe52tgQI4G5GcDaw74j7tuernxcrjgNCT3loM3I+QQvFezRCTDvI
         1xS9+5zFhA0fTDkYPQdxVLeN9djVyeHYLvZMun4lJkBtNn3J7WEfQ1gG1QM0oWe5NEbz
         fCsBKFbQiZ7lSNsL+gouR0Niohr2J/0oS5Plbf8JGDLG8Cx8yKi9kLr/WqzjawkokGTp
         R3n6gqLA/Pw/zLoTf07DTzWx+2Z3Ce/mKgCJW9lDR26epeUBedf3XvK8Hclj7aJqjNAW
         q6zg==
X-Gm-Message-State: ANoB5pmoNJXunqK1+Kk8TdHau4IUIsocJApCSov2VQvXR584oY3dCtiF
        ZpNtjlquv9ZfvWNwI/oyratmsw==
X-Google-Smtp-Source: AA0mqf52YnbaC+FzJZHzFO6RQPBRF/Z4ae26J3kUE1fmBn6xbjLdVtRw8kBboimpxnMmRC/t0AIHhQ==
X-Received: by 2002:a19:e051:0:b0:4b5:b7be:136b with SMTP id g17-20020a19e051000000b004b5b7be136bmr4165398lfj.69.1670945181142;
        Tue, 13 Dec 2022 07:26:21 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id s15-20020a056512214f00b004b58f51c7dcsm404149lfr.226.2022.12.13.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:26:20 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: add QCOM SM6350 camera clock bindings
Date:   Tue, 13 Dec 2022 16:26:15 +0100
Message-Id: <20221213152617.296426-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for camera clock controller for
Qualcomm Technology Inc's SM6350 SoC.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/clock/qcom,sm6350-camcc.yaml     |  49 ++++++++
 include/dt-bindings/clock/qcom,sm6350-camcc.h | 109 ++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm6350-camcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
new file mode 100644
index 000000000000..fd6658cb793d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm6350-camcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Camera Clock & Reset Controller on SM6350
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  Qualcomm camera clock control module provides the clocks, resets and  power
+  domains on SM6350.
+
+  See also:: include/dt-bindings/clock/qcom,sm6350-camcc.h
+
+properties:
+  compatible:
+    const: qcom,sm6350-camcc
+
+  clocks:
+    items:
+      - description: Board XO source
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@ad00000 {
+      compatible = "qcom,sm6350-camcc";
+      reg = <0x0ad00000 0x16000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm6350-camcc.h b/include/dt-bindings/clock/qcom,sm6350-camcc.h
new file mode 100644
index 000000000000..c6bcdc8fd485
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6350-camcc.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAMCC_SM6350_H
+#define _DT_BINDINGS_CLK_QCOM_CAMCC_SM6350_H
+
+/* CAMCC clocks */
+#define CAMCC_PLL2_OUT_EARLY		0
+#define CAMCC_PLL0			1
+#define CAMCC_PLL0_OUT_EVEN		2
+#define CAMCC_PLL1			3
+#define CAMCC_PLL1_OUT_EVEN		4
+#define CAMCC_PLL2			5
+#define CAMCC_PLL2_OUT_MAIN		6
+#define CAMCC_PLL3			7
+#define CAMCC_BPS_AHB_CLK		8
+#define CAMCC_BPS_AREG_CLK		9
+#define CAMCC_BPS_AXI_CLK		10
+#define CAMCC_BPS_CLK			11
+#define CAMCC_BPS_CLK_SRC		12
+#define CAMCC_CAMNOC_ATB_CLK		13
+#define CAMCC_CAMNOC_AXI_CLK		14
+#define CAMCC_CCI_0_CLK		15
+#define CAMCC_CCI_0_CLK_SRC		16
+#define CAMCC_CCI_1_CLK		17
+#define CAMCC_CCI_1_CLK_SRC		18
+#define CAMCC_CORE_AHB_CLK		19
+#define CAMCC_CPAS_AHB_CLK		20
+#define CAMCC_CPHY_RX_CLK_SRC		21
+#define CAMCC_CSI0PHYTIMER_CLK		22
+#define CAMCC_CSI0PHYTIMER_CLK_SRC	23
+#define CAMCC_CSI1PHYTIMER_CLK		24
+#define CAMCC_CSI1PHYTIMER_CLK_SRC	25
+#define CAMCC_CSI2PHYTIMER_CLK		26
+#define CAMCC_CSI2PHYTIMER_CLK_SRC	27
+#define CAMCC_CSI3PHYTIMER_CLK		28
+#define CAMCC_CSI3PHYTIMER_CLK_SRC	29
+#define CAMCC_CSIPHY0_CLK		30
+#define CAMCC_CSIPHY1_CLK		31
+#define CAMCC_CSIPHY2_CLK		32
+#define CAMCC_CSIPHY3_CLK		33
+#define CAMCC_FAST_AHB_CLK_SRC		34
+#define CAMCC_ICP_APB_CLK		35
+#define CAMCC_ICP_ATB_CLK		36
+#define CAMCC_ICP_CLK			37
+#define CAMCC_ICP_CLK_SRC		38
+#define CAMCC_ICP_CTI_CLK		39
+#define CAMCC_ICP_TS_CLK		40
+#define CAMCC_IFE_0_AXI_CLK		41
+#define CAMCC_IFE_0_CLK		42
+#define CAMCC_IFE_0_CLK_SRC		43
+#define CAMCC_IFE_0_CPHY_RX_CLK	44
+#define CAMCC_IFE_0_CSID_CLK		45
+#define CAMCC_IFE_0_CSID_CLK_SRC	46
+#define CAMCC_IFE_0_DSP_CLK		47
+#define CAMCC_IFE_1_AXI_CLK		48
+#define CAMCC_IFE_1_CLK		49
+#define CAMCC_IFE_1_CLK_SRC		50
+#define CAMCC_IFE_1_CPHY_RX_CLK	51
+#define CAMCC_IFE_1_CSID_CLK		52
+#define CAMCC_IFE_1_CSID_CLK_SRC	53
+#define CAMCC_IFE_1_DSP_CLK		54
+#define CAMCC_IFE_2_AXI_CLK		55
+#define CAMCC_IFE_2_CLK		56
+#define CAMCC_IFE_2_CLK_SRC		57
+#define CAMCC_IFE_2_CPHY_RX_CLK	58
+#define CAMCC_IFE_2_CSID_CLK		59
+#define CAMCC_IFE_2_CSID_CLK_SRC	60
+#define CAMCC_IFE_2_DSP_CLK		61
+#define CAMCC_IFE_LITE_CLK		62
+#define CAMCC_IFE_LITE_CLK_SRC		63
+#define CAMCC_IFE_LITE_CPHY_RX_CLK	64
+#define CAMCC_IFE_LITE_CSID_CLK	65
+#define CAMCC_IFE_LITE_CSID_CLK_SRC	66
+#define CAMCC_IPE_0_AHB_CLK		67
+#define CAMCC_IPE_0_AREG_CLK		68
+#define CAMCC_IPE_0_AXI_CLK		69
+#define CAMCC_IPE_0_CLK		70
+#define CAMCC_IPE_0_CLK_SRC		71
+#define CAMCC_JPEG_CLK			72
+#define CAMCC_JPEG_CLK_SRC		73
+#define CAMCC_LRME_CLK			74
+#define CAMCC_LRME_CLK_SRC		75
+#define CAMCC_MCLK0_CLK		76
+#define CAMCC_MCLK0_CLK_SRC		77
+#define CAMCC_MCLK1_CLK		78
+#define CAMCC_MCLK1_CLK_SRC		79
+#define CAMCC_MCLK2_CLK		80
+#define CAMCC_MCLK2_CLK_SRC		81
+#define CAMCC_MCLK3_CLK		82
+#define CAMCC_MCLK3_CLK_SRC		83
+#define CAMCC_MCLK4_CLK		84
+#define CAMCC_MCLK4_CLK_SRC		85
+#define CAMCC_SLOW_AHB_CLK_SRC		86
+#define CAMCC_SOC_AHB_CLK		87
+#define CAMCC_SYS_TMR_CLK		88
+
+/* GDSCs */
+#define BPS_GDSC			0
+#define IPE_0_GDSC			1
+#define IFE_0_GDSC			2
+#define IFE_1_GDSC			3
+#define IFE_2_GDSC			4
+#define TITAN_TOP_GDSC			5
+
+#endif
-- 
2.39.0

