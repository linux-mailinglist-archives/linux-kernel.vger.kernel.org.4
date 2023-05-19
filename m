Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562087097A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjESMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjESMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:54:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031A0106;
        Fri, 19 May 2023 05:54:57 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JBnpXd029815;
        Fri, 19 May 2023 12:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gE9b2a+dv2A+vkdn9oCpVEKpsiTa0elzbEdpiYZX5/E=;
 b=dGSr4kzTgQlZ/EPNbZ3eOij8UvDwiTcp0dfw6YxjCCWLewOsSNoFSuUYV6dn3Bvcda4m
 yVsdTyOfXIs80xtFxGb6cXbolVX566Dpk/En/u4rckDHwXdBOVj2A+cd4Hp+AuJL0K4h
 GacbYWrpEWx41QDnnas2gLPqeZ+AxbUTiKGlJ0t82KzTIQfKNb2Gfn8dSc3Ajp79baPr
 J1ew+W8l2FSNfoUkqy5EUfCMQ5mgb/+0wLjJh7OdntRUgmWAxfjztLQOI79qh/Aqri9D
 suyGzXYkuiC7grN+TaP9TPlPFs251VATl8qS9Tq5kgW8TgRZ3TJ9tlOpOhMieFLZ1xQW hw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp69u0bwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:54:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JCseRd005455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:54:41 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 05:54:30 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>,
        <andy.shevchenko@gmail.com>, <quic_srichara@quicinc.com>
Subject: [PATCH V7 1/8] dt-bindings: arm64: Add IPQ5018 clock and reset
Date:   Fri, 19 May 2023 18:24:02 +0530
Message-ID: <20230519125409.497439-2-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519125409.497439-1-quic_srichara@quicinc.com>
References: <20230519125409.497439-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8BIyaUB3PFrmjHar6yoIuFV3vSHcIu4D
X-Proofpoint-GUID: 8BIyaUB3PFrmjHar6yoIuFV3vSHcIu4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the global clock controller found on
the IPQ5018 based devices.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v7]  No change

 .../bindings/clock/qcom,ipq5018-gcc.yaml      |  63 ++++++
 include/dt-bindings/clock/qcom,gcc-ipq5018.h  | 183 ++++++++++++++++++
 include/dt-bindings/reset/qcom,gcc-ipq5018.h  | 122 ++++++++++++
 3 files changed, 368 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq5018.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq5018.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
new file mode 100644
index 000000000000..ef84a0c95f7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,ipq5018-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on IPQ5018
+
+maintainers:
+  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on IPQ5018
+
+  See also::
+    include/dt-bindings/clock/qcom,ipq5018-gcc.h
+    include/dt-bindings/reset/qcom,ipq5018-gcc.h
+
+properties:
+  compatible:
+    const: qcom,gcc-ipq5018
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+      - description: PCIE20 PHY0 pipe clock source
+      - description: PCIE20 PHY1 pipe clock source
+      - description: USB3 PHY pipe clock source
+      - description: GEPHY RX clock source
+      - description: GEPHY TX clock source
+      - description: UNIPHY RX clock source
+      - description: UNIPHY TX clk source
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
+    clock-controller@1800000 {
+      compatible = "qcom,gcc-ipq5018";
+      reg = <0x01800000 0x80000>;
+      clocks = <&xo_board_clk>,
+               <&sleep_clk>,
+               <&pcie20_phy0_pipe_clk>,
+               <&pcie20_phy1_pipe_clk>,
+               <&usb3_phy0_pipe_clk>,
+               <&gephy_rx_clk>,
+               <&gephy_tx_clk>,
+               <&uniphy_rx_clk>,
+               <&uniphy_tx_clk>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,gcc-ipq5018.h b/include/dt-bindings/clock/qcom,gcc-ipq5018.h
new file mode 100644
index 000000000000..f3de2fdfeea1
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-ipq5018.h
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_IPQ_GCC_5018_H
+#define _DT_BINDINGS_CLOCK_IPQ_GCC_5018_H
+
+#define GPLL0_MAIN					0
+#define GPLL0						1
+#define GPLL2_MAIN					2
+#define GPLL2						3
+#define GPLL4_MAIN					4
+#define GPLL4						5
+#define UBI32_PLL_MAIN					6
+#define UBI32_PLL					7
+#define ADSS_PWM_CLK_SRC				8
+#define BLSP1_QUP1_I2C_APPS_CLK_SRC			9
+#define BLSP1_QUP1_SPI_APPS_CLK_SRC			10
+#define BLSP1_QUP2_I2C_APPS_CLK_SRC			11
+#define BLSP1_QUP2_SPI_APPS_CLK_SRC			12
+#define BLSP1_QUP3_I2C_APPS_CLK_SRC			13
+#define BLSP1_QUP3_SPI_APPS_CLK_SRC			14
+#define BLSP1_UART1_APPS_CLK_SRC			15
+#define BLSP1_UART2_APPS_CLK_SRC			16
+#define CRYPTO_CLK_SRC					17
+#define GCC_ADSS_PWM_CLK				18
+#define GCC_BLSP1_AHB_CLK				19
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK			20
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK			21
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK			22
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK			23
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK			24
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK			25
+#define GCC_BLSP1_UART1_APPS_CLK			26
+#define GCC_BLSP1_UART2_APPS_CLK			27
+#define GCC_BTSS_LPO_CLK				28
+#define GCC_CMN_BLK_AHB_CLK				29
+#define GCC_CMN_BLK_SYS_CLK				30
+#define GCC_CRYPTO_AHB_CLK				31
+#define GCC_CRYPTO_AXI_CLK				32
+#define GCC_CRYPTO_CLK					33
+#define GCC_CRYPTO_PPE_CLK				34
+#define GCC_DCC_CLK					35
+#define GCC_GEPHY_RX_CLK				36
+#define GCC_GEPHY_TX_CLK				37
+#define GCC_GMAC0_CFG_CLK				38
+#define GCC_GMAC0_PTP_CLK				39
+#define GCC_GMAC0_RX_CLK				40
+#define GCC_GMAC0_SYS_CLK				41
+#define GCC_GMAC0_TX_CLK				42
+#define GCC_GMAC1_CFG_CLK				43
+#define GCC_GMAC1_PTP_CLK				44
+#define GCC_GMAC1_RX_CLK				45
+#define GCC_GMAC1_SYS_CLK				46
+#define GCC_GMAC1_TX_CLK				47
+#define GCC_GP1_CLK					48
+#define GCC_GP2_CLK					49
+#define GCC_GP3_CLK					50
+#define GCC_LPASS_CORE_AXIM_CLK				51
+#define GCC_LPASS_SWAY_CLK				52
+#define GCC_MDIO0_AHB_CLK				53
+#define GCC_MDIO1_AHB_CLK				54
+#define GCC_PCIE0_AHB_CLK				55
+#define GCC_PCIE0_AUX_CLK				56
+#define GCC_PCIE0_AXI_M_CLK				57
+#define GCC_PCIE0_AXI_S_BRIDGE_CLK			58
+#define GCC_PCIE0_AXI_S_CLK				59
+#define GCC_PCIE0_PIPE_CLK				60
+#define GCC_PCIE1_AHB_CLK				61
+#define GCC_PCIE1_AUX_CLK				62
+#define GCC_PCIE1_AXI_M_CLK				63
+#define GCC_PCIE1_AXI_S_BRIDGE_CLK			64
+#define GCC_PCIE1_AXI_S_CLK				65
+#define GCC_PCIE1_PIPE_CLK				66
+#define GCC_PRNG_AHB_CLK				67
+#define GCC_Q6_AXIM_CLK					68
+#define GCC_Q6_AXIM2_CLK				69
+#define GCC_Q6_AXIS_CLK					70
+#define GCC_Q6_AHB_CLK					71
+#define GCC_Q6_AHB_S_CLK				72
+#define GCC_Q6_TSCTR_1TO2_CLK				73
+#define GCC_Q6SS_ATBM_CLK				74
+#define GCC_Q6SS_PCLKDBG_CLK				75
+#define GCC_Q6SS_TRIG_CLK				76
+#define GCC_QDSS_AT_CLK					77
+#define GCC_QDSS_CFG_AHB_CLK				78
+#define GCC_QDSS_DAP_AHB_CLK				79
+#define GCC_QDSS_DAP_CLK				80
+#define GCC_QDSS_ETR_USB_CLK				81
+#define GCC_QDSS_EUD_AT_CLK				82
+#define GCC_QDSS_STM_CLK				83
+#define GCC_QDSS_TRACECLKIN_CLK				84
+#define GCC_QDSS_TSCTR_DIV8_CLK				85
+#define GCC_QPIC_AHB_CLK				86
+#define GCC_QPIC_CLK					87
+#define GCC_QPIC_IO_MACRO_CLK				88
+#define GCC_SDCC1_AHB_CLK				89
+#define GCC_SDCC1_APPS_CLK				90
+#define GCC_SLEEP_CLK_SRC				91
+#define GCC_SNOC_GMAC0_AHB_CLK				92
+#define GCC_SNOC_GMAC0_AXI_CLK				93
+#define GCC_SNOC_GMAC1_AHB_CLK				94
+#define GCC_SNOC_GMAC1_AXI_CLK				95
+#define GCC_SNOC_LPASS_AXIM_CLK				96
+#define GCC_SNOC_LPASS_SWAY_CLK				97
+#define GCC_SNOC_UBI0_AXI_CLK				98
+#define GCC_SYS_NOC_PCIE0_AXI_CLK			99
+#define GCC_SYS_NOC_PCIE1_AXI_CLK			100
+#define GCC_SYS_NOC_QDSS_STM_AXI_CLK			101
+#define GCC_SYS_NOC_USB0_AXI_CLK			102
+#define GCC_SYS_NOC_WCSS_AHB_CLK			103
+#define GCC_UBI0_AXI_CLK				104
+#define GCC_UBI0_CFG_CLK				105
+#define GCC_UBI0_CORE_CLK				106
+#define GCC_UBI0_DBG_CLK				107
+#define GCC_UBI0_NC_AXI_CLK				108
+#define GCC_UBI0_UTCM_CLK				109
+#define GCC_UNIPHY_AHB_CLK				110
+#define GCC_UNIPHY_RX_CLK				111
+#define GCC_UNIPHY_SYS_CLK				112
+#define GCC_UNIPHY_TX_CLK				113
+#define GCC_USB0_AUX_CLK				114
+#define GCC_USB0_EUD_AT_CLK				115
+#define GCC_USB0_LFPS_CLK				116
+#define GCC_USB0_MASTER_CLK				117
+#define GCC_USB0_MOCK_UTMI_CLK				118
+#define GCC_USB0_PHY_CFG_AHB_CLK			119
+#define GCC_USB0_SLEEP_CLK				120
+#define GCC_WCSS_ACMT_CLK				121
+#define GCC_WCSS_AHB_S_CLK				122
+#define GCC_WCSS_AXI_M_CLK				123
+#define GCC_WCSS_AXI_S_CLK				124
+#define GCC_WCSS_DBG_IFC_APB_BDG_CLK			125
+#define GCC_WCSS_DBG_IFC_APB_CLK			126
+#define GCC_WCSS_DBG_IFC_ATB_BDG_CLK			127
+#define GCC_WCSS_DBG_IFC_ATB_CLK			128
+#define GCC_WCSS_DBG_IFC_DAPBUS_BDG_CLK			129
+#define GCC_WCSS_DBG_IFC_DAPBUS_CLK			130
+#define GCC_WCSS_DBG_IFC_NTS_BDG_CLK			131
+#define GCC_WCSS_DBG_IFC_NTS_CLK			132
+#define GCC_WCSS_ECAHB_CLK				133
+#define GCC_XO_CLK					134
+#define GCC_XO_CLK_SRC					135
+#define GMAC0_RX_CLK_SRC				136
+#define GMAC0_TX_CLK_SRC				137
+#define GMAC1_RX_CLK_SRC				138
+#define GMAC1_TX_CLK_SRC				139
+#define GMAC_CLK_SRC					140
+#define GP1_CLK_SRC					141
+#define GP2_CLK_SRC					142
+#define GP3_CLK_SRC					143
+#define LPASS_AXIM_CLK_SRC				144
+#define LPASS_SWAY_CLK_SRC				145
+#define PCIE0_AUX_CLK_SRC				146
+#define PCIE0_AXI_CLK_SRC				147
+#define PCIE1_AUX_CLK_SRC				148
+#define PCIE1_AXI_CLK_SRC				149
+#define PCNOC_BFDCD_CLK_SRC				150
+#define Q6_AXI_CLK_SRC					151
+#define QDSS_AT_CLK_SRC					152
+#define QDSS_STM_CLK_SRC				153
+#define QDSS_TSCTR_CLK_SRC				154
+#define QDSS_TRACECLKIN_CLK_SRC				155
+#define QPIC_IO_MACRO_CLK_SRC				156
+#define SDCC1_APPS_CLK_SRC				157
+#define SYSTEM_NOC_BFDCD_CLK_SRC			158
+#define UBI0_AXI_CLK_SRC				159
+#define UBI0_CORE_CLK_SRC				160
+#define USB0_AUX_CLK_SRC				161
+#define USB0_LFPS_CLK_SRC				162
+#define USB0_MASTER_CLK_SRC				163
+#define USB0_MOCK_UTMI_CLK_SRC				164
+#define WCSS_AHB_CLK_SRC				165
+#define PCIE0_PIPE_CLK_SRC				166
+#define PCIE1_PIPE_CLK_SRC				167
+#define USB0_PIPE_CLK_SRC				168
+#define GCC_USB0_PIPE_CLK				169
+#define GMAC0_RX_DIV_CLK_SRC				170
+#define GMAC0_TX_DIV_CLK_SRC				171
+#define GMAC1_RX_DIV_CLK_SRC				172
+#define GMAC1_TX_DIV_CLK_SRC				173
+#endif
diff --git a/include/dt-bindings/reset/qcom,gcc-ipq5018.h b/include/dt-bindings/reset/qcom,gcc-ipq5018.h
new file mode 100644
index 000000000000..8f03c92fc23b
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,gcc-ipq5018.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_IPQ_GCC_5018_H
+#define _DT_BINDINGS_RESET_IPQ_GCC_5018_H
+
+#define GCC_APC0_VOLTAGE_DROOP_DETECTOR_BCR	0
+#define GCC_BLSP1_BCR				1
+#define GCC_BLSP1_QUP1_BCR			2
+#define GCC_BLSP1_QUP2_BCR			3
+#define GCC_BLSP1_QUP3_BCR			4
+#define GCC_BLSP1_UART1_BCR			5
+#define GCC_BLSP1_UART2_BCR			6
+#define GCC_BOOT_ROM_BCR			7
+#define GCC_BTSS_BCR				8
+#define GCC_CMN_BLK_BCR				9
+#define GCC_CMN_LDO_BCR				10
+#define GCC_CE_BCR				11
+#define GCC_CRYPTO_BCR				12
+#define GCC_DCC_BCR				13
+#define GCC_DCD_BCR				14
+#define GCC_DDRSS_BCR				15
+#define GCC_EDPD_BCR				16
+#define GCC_GEPHY_BCR				17
+#define GCC_GEPHY_MDC_SW_ARES			18
+#define GCC_GEPHY_DSP_HW_ARES			19
+#define GCC_GEPHY_RX_ARES			20
+#define GCC_GEPHY_TX_ARES			21
+#define GCC_GMAC0_BCR				22
+#define GCC_GMAC0_CFG_ARES			23
+#define GCC_GMAC0_SYS_ARES			24
+#define GCC_GMAC1_BCR				25
+#define GCC_GMAC1_CFG_ARES			26
+#define GCC_GMAC1_SYS_ARES			27
+#define GCC_IMEM_BCR				28
+#define GCC_LPASS_BCR				29
+#define GCC_MDIO0_BCR				30
+#define GCC_MDIO1_BCR				31
+#define GCC_MPM_BCR				32
+#define GCC_PCIE0_BCR				33
+#define GCC_PCIE0_LINK_DOWN_BCR			34
+#define GCC_PCIE0_PHY_BCR			35
+#define GCC_PCIE0PHY_PHY_BCR			36
+#define GCC_PCIE0_PIPE_ARES			37
+#define GCC_PCIE0_SLEEP_ARES			38
+#define GCC_PCIE0_CORE_STICKY_ARES		39
+#define GCC_PCIE0_AXI_MASTER_ARES		40
+#define GCC_PCIE0_AXI_SLAVE_ARES		41
+#define GCC_PCIE0_AHB_ARES			42
+#define GCC_PCIE0_AXI_MASTER_STICKY_ARES	43
+#define GCC_PCIE0_AXI_SLAVE_STICKY_ARES		44
+#define GCC_PCIE1_BCR				45
+#define GCC_PCIE1_LINK_DOWN_BCR			46
+#define GCC_PCIE1_PHY_BCR			47
+#define GCC_PCIE1PHY_PHY_BCR			48
+#define GCC_PCIE1_PIPE_ARES			49
+#define GCC_PCIE1_SLEEP_ARES			50
+#define GCC_PCIE1_CORE_STICKY_ARES		51
+#define GCC_PCIE1_AXI_MASTER_ARES		52
+#define GCC_PCIE1_AXI_SLAVE_ARES		53
+#define GCC_PCIE1_AHB_ARES			54
+#define GCC_PCIE1_AXI_MASTER_STICKY_ARES	55
+#define GCC_PCIE1_AXI_SLAVE_STICKY_ARES		56
+#define GCC_PCNOC_BCR				57
+#define GCC_PCNOC_BUS_TIMEOUT0_BCR		58
+#define GCC_PCNOC_BUS_TIMEOUT1_BCR		59
+#define GCC_PCNOC_BUS_TIMEOUT2_BCR		60
+#define GCC_PCNOC_BUS_TIMEOUT3_BCR		61
+#define GCC_PCNOC_BUS_TIMEOUT4_BCR		62
+#define GCC_PCNOC_BUS_TIMEOUT5_BCR		63
+#define GCC_PCNOC_BUS_TIMEOUT6_BCR		64
+#define GCC_PCNOC_BUS_TIMEOUT7_BCR		65
+#define GCC_PCNOC_BUS_TIMEOUT8_BCR		66
+#define GCC_PCNOC_BUS_TIMEOUT9_BCR		67
+#define GCC_PCNOC_BUS_TIMEOUT10_BCR		68
+#define GCC_PCNOC_BUS_TIMEOUT11_BCR		69
+#define GCC_PRNG_BCR				70
+#define GCC_Q6SS_DBG_ARES			71
+#define GCC_Q6_AHB_S_ARES			72
+#define GCC_Q6_AHB_ARES				73
+#define GCC_Q6_AXIM2_ARES			74
+#define GCC_Q6_AXIM_ARES			75
+#define GCC_Q6_AXIS_ARES			76
+#define GCC_QDSS_BCR				77
+#define GCC_QPIC_BCR				78
+#define GCC_QUSB2_0_PHY_BCR			79
+#define GCC_SDCC1_BCR				80
+#define GCC_SEC_CTRL_BCR			81
+#define GCC_SPDM_BCR				82
+#define GCC_SYSTEM_NOC_BCR			83
+#define GCC_TCSR_BCR				84
+#define GCC_TLMM_BCR				85
+#define GCC_UBI0_AXI_ARES			86
+#define GCC_UBI0_AHB_ARES			87
+#define GCC_UBI0_NC_AXI_ARES			88
+#define GCC_UBI0_DBG_ARES			89
+#define GCC_UBI0_UTCM_ARES			90
+#define GCC_UBI0_CORE_ARES			91
+#define GCC_UBI32_BCR				92
+#define GCC_UNIPHY_BCR				93
+#define GCC_UNIPHY_AHB_ARES			94
+#define GCC_UNIPHY_SYS_ARES			95
+#define GCC_UNIPHY_RX_ARES			96
+#define GCC_UNIPHY_TX_ARES			97
+#define GCC_USB0_BCR				98
+#define GCC_USB0_PHY_BCR			99
+#define GCC_WCSS_BCR				100
+#define GCC_WCSS_DBG_ARES			101
+#define GCC_WCSS_ECAHB_ARES			102
+#define GCC_WCSS_ACMT_ARES			103
+#define GCC_WCSS_DBG_BDG_ARES			104
+#define GCC_WCSS_AHB_S_ARES			105
+#define GCC_WCSS_AXI_M_ARES			106
+#define GCC_WCSS_AXI_S_ARES			107
+#define GCC_WCSS_Q6_BCR				108
+#define GCC_WCSSAON_RESET			109
+#define GCC_UNIPHY_SOFT_RESET			110
+#define GCC_GEPHY_MISC_ARES			111
+
+#endif
-- 
2.34.1

