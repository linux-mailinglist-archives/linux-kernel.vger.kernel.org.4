Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB35EB254
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiIZUit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiIZUi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:38:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248F3A8CDD;
        Mon, 26 Sep 2022 13:38:16 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QKc9Af005657;
        Mon, 26 Sep 2022 20:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FZixfa402jGxcpjinXpTQ42aFEDeiWFGk7a44Ga1Lzw=;
 b=IOYkt7lG0DxdOX9TSR3KiK4XOb2wFHbAVxTMJW6PLCU5OROyxDL4tfdRJy1a6fod4Tgw
 xKkG5IeNOW/s+T0O1ioZK3DSQwCLHPQdxIobUtCRVJsKCj5l7nqLBRx7+Rs1S6/Q29Mh
 +ilfameHnILUtHtR6a/hP+2s/JZZoQlQYoBFeLzISYZPr0qC7Z3F6d3qNJ37T8pt+V/Q
 nZpglF2dPlJXmxw63TbCESoZ33QyU29mYv/RKELS4gXqDIYUPTyZj57OJwJrZsvQGq6v
 wjtwL/fY25SoM3Bpij4sxMAWI9aP4G1AW0rjI58CJbphsTAuWr3BHpTnZYguSZGe/ZVM mA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jsrwfmm1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 20:38:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28QKc6mS011761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 20:38:07 GMT
Received: from core-thresher1.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 13:38:06 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SC8280XP display clock bindings
Date:   Mon, 26 Sep 2022 13:37:59 -0700
Message-ID: <20220926203800.16771-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926203800.16771-1-quic_bjorande@quicinc.com>
References: <20220926203800.16771-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VQH5bLtJrPS16Tm9GjdHcWzo8njzknCq
X-Proofpoint-GUID: VQH5bLtJrPS16Tm9GjdHcWzo8njzknCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

The Qualcomm SC8280XP platform has two display clock controllers, add a
binding for these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Add missing 'p' in compatibles.
- Reworked power-domains definition

 .../bindings/clock/qcom,dispcc-sc8280xp.yaml  |  97 +++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sc8280xp.h  | 100 ++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc8280xp.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
new file mode 100644
index 000000000000..28c13237059f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,dispcc-sc8280xp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller Binding for SC8280XP
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  Qualcomm display clock control module which supports the clocks, resets and
+  power domains for the two MDSS instances on SC8280XP.
+
+  See also:
+    include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8280xp-dispcc0
+      - qcom,sc8280xp-dispcc1
+
+  clocks:
+    items:
+      - description: AHB interface clock,
+      - description: SoC CXO clock
+      - description: SoC sleep clock
+      - description: DisplayPort 0 link clock
+      - description: DisplayPort 0 VCO div clock
+      - description: DisplayPort 1 link clock
+      - description: DisplayPort 1 VCO div clock
+      - description: DisplayPort 2 link clock
+      - description: DisplayPort 2 VCO div clock
+      - description: DisplayPort 3 link clock
+      - description: DisplayPort 3 VCO div clock
+      - description: DSI 0 PLL byte clock
+      - description: DSI 0 PLL DSI clock
+      - description: DSI 1 PLL byte clock
+      - description: DSI 1 PLL DSI clock
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    items:
+      - description: MMCX power domain
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    clock-controller@af00000 {
+      compatible = "qcom,sc8280xp-dispcc0";
+      reg = <0x0af00000 0x20000>;
+      clocks = <&gcc GCC_DISP_AHB_CLK>,
+               <&rpmhcc RPMH_CXO_CLK>,
+               <&sleep_clk>,
+               <&mdss0_dp_phy0 0>,
+               <&mdss0_dp_phy0 1>,
+               <&mdss0_dp_phy1 0>,
+               <&mdss0_dp_phy1 1>,
+               <&mdss0_dp_phy2 0>,
+               <&mdss0_dp_phy2 1>,
+               <&mdss0_dp_phy3 0>,
+               <&mdss0_dp_phy3 1>,
+               <&mdss0_dsi0_phy 0>,
+               <&mdss0_dsi0_phy 1>,
+               <&mdss0_dsi1_phy 0>,
+               <&mdss0_dsi1_phy 1>;
+      power-domains = <&rpmhpd SC8280XP_MMCX>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,dispcc-sc8280xp.h b/include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
new file mode 100644
index 000000000000..2831c61fa979
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sc8280xp.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SC8280XP_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SC8280XP_H
+
+/* DISPCC clocks */
+#define DISP_CC_PLL0					0
+#define DISP_CC_PLL1					1
+#define DISP_CC_PLL1_OUT_EVEN				2
+#define DISP_CC_PLL2					3
+#define DISP_CC_MDSS_AHB1_CLK				4
+#define DISP_CC_MDSS_AHB_CLK				5
+#define DISP_CC_MDSS_AHB_CLK_SRC			6
+#define DISP_CC_MDSS_BYTE0_CLK				7
+#define DISP_CC_MDSS_BYTE0_CLK_SRC			8
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC			9
+#define DISP_CC_MDSS_BYTE0_INTF_CLK			10
+#define DISP_CC_MDSS_BYTE1_CLK				11
+#define DISP_CC_MDSS_BYTE1_CLK_SRC			12
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC			13
+#define DISP_CC_MDSS_BYTE1_INTF_CLK			14
+#define DISP_CC_MDSS_DPTX0_AUX_CLK			15
+#define DISP_CC_MDSS_DPTX0_AUX_CLK_SRC			16
+#define DISP_CC_MDSS_DPTX0_LINK_CLK			17
+#define DISP_CC_MDSS_DPTX0_LINK_CLK_SRC			18
+#define DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC		19
+#define DISP_CC_MDSS_DPTX0_LINK_INTF_CLK		20
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK			21
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC		22
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK			23
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC		24
+#define DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK	25
+#define DISP_CC_MDSS_DPTX1_AUX_CLK			26
+#define DISP_CC_MDSS_DPTX1_AUX_CLK_SRC			27
+#define DISP_CC_MDSS_DPTX1_LINK_CLK			28
+#define DISP_CC_MDSS_DPTX1_LINK_CLK_SRC			29
+#define DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC		30
+#define DISP_CC_MDSS_DPTX1_LINK_INTF_CLK		31
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK			32
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC		33
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK			34
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC		35
+#define DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK	36
+#define DISP_CC_MDSS_DPTX2_AUX_CLK			37
+#define DISP_CC_MDSS_DPTX2_AUX_CLK_SRC			38
+#define DISP_CC_MDSS_DPTX2_LINK_CLK			39
+#define DISP_CC_MDSS_DPTX2_LINK_CLK_SRC			40
+#define DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC		41
+#define DISP_CC_MDSS_DPTX2_LINK_INTF_CLK		42
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK			43
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC		44
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK			45
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC		46
+#define DISP_CC_MDSS_DPTX3_AUX_CLK			47
+#define DISP_CC_MDSS_DPTX3_AUX_CLK_SRC			48
+#define DISP_CC_MDSS_DPTX3_LINK_CLK			49
+#define DISP_CC_MDSS_DPTX3_LINK_CLK_SRC			50
+#define DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC		51
+#define DISP_CC_MDSS_DPTX3_LINK_INTF_CLK		52
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK			53
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC		54
+#define DISP_CC_MDSS_ESC0_CLK				55
+#define DISP_CC_MDSS_ESC0_CLK_SRC			56
+#define DISP_CC_MDSS_ESC1_CLK				57
+#define DISP_CC_MDSS_ESC1_CLK_SRC			58
+#define DISP_CC_MDSS_MDP1_CLK				59
+#define DISP_CC_MDSS_MDP_CLK				60
+#define DISP_CC_MDSS_MDP_CLK_SRC			61
+#define DISP_CC_MDSS_MDP_LUT1_CLK			62
+#define DISP_CC_MDSS_MDP_LUT_CLK			63
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK			64
+#define DISP_CC_MDSS_PCLK0_CLK				65
+#define DISP_CC_MDSS_PCLK0_CLK_SRC			66
+#define DISP_CC_MDSS_PCLK1_CLK				67
+#define DISP_CC_MDSS_PCLK1_CLK_SRC			68
+#define DISP_CC_MDSS_ROT1_CLK				69
+#define DISP_CC_MDSS_ROT_CLK				70
+#define DISP_CC_MDSS_ROT_CLK_SRC			71
+#define DISP_CC_MDSS_RSCC_AHB_CLK			72
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK			73
+#define DISP_CC_MDSS_VSYNC1_CLK				74
+#define DISP_CC_MDSS_VSYNC_CLK				75
+#define DISP_CC_MDSS_VSYNC_CLK_SRC			76
+#define DISP_CC_SLEEP_CLK				77
+#define DISP_CC_SLEEP_CLK_SRC				78
+#define DISP_CC_XO_CLK					79
+#define DISP_CC_XO_CLK_SRC				80
+
+/* DISPCC resets */
+#define DISP_CC_MDSS_CORE_BCR				0
+#define DISP_CC_MDSS_RSCC_BCR				1
+
+/* DISPCC GDSCs */
+#define MDSS_GDSC					0
+#define MDSS_INT2_GDSC					1
+
+#endif
-- 
2.17.1

