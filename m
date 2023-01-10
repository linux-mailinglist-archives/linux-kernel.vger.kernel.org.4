Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F460664033
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbjAJMRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbjAJMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:17:06 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3217E62FE;
        Tue, 10 Jan 2023 04:15:23 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ABUMtv020125;
        Tue, 10 Jan 2023 12:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Ve/KwOvkpo1gbtooy6/NzEsD0L8YXG2aeDa3co1KKZw=;
 b=JX3nLiTgkirINw3ZNTom6kxnU35eV5L4pQwJpJ06tmU4aa5Rf8w31QWn1KzOS94qui/l
 XMgzMoEtPrpBMzX6c34z5diQKlU1jgRqL8IhlUhk/KadDp2zPe+7Cb5Uu6DxohVa9Jm8
 gK1X5kJUslZeriSxu1h3DX4b1cfPGi8+App+xqBRZuNj3/KVba9roTkimJL8TAnN0uk9
 5UELidxIq937gaea3cquFBu72+ke5cvln9xrQ+KpL9vSEdKTlAXuz0T8ETy4ap4HKFqY
 BIVd0BOgH5CrGDPl76agQkgrDrU0LKQUDJ/IP/rmRZpussPrdxa4YrvIyXrmetCH8Ry0 Vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n116pgv39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 12:14:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ACDwG1014865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 12:13:58 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 10 Jan 2023 04:13:50 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 1/7] dt-bindings: arm64: ipq9574: Add binding descriptions for clock and reset
Date:   Tue, 10 Jan 2023 17:43:10 +0530
Message-ID: <20230110121316.24892-2-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110121316.24892-1-quic_devipriy@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BLvuyGqodmFdY1F-aUGT6lZtSSiS5IcW
X-Proofpoint-ORIG-GUID: BLvuyGqodmFdY1F-aUGT6lZtSSiS5IcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100074
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for the global clock controller found on
IPQ9574 based devices

Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
---
 .../bindings/clock/qcom,gcc-other.yaml        |   4 +
 .../devicetree/bindings/clock/qcom,gcc.yaml   |   9 +-
 include/dt-bindings/clock/qcom,gcc-ipq9574.h  | 226 ++++++++++++++++++
 include/dt-bindings/reset/qcom,gcc-ipq9574.h  | 164 +++++++++++++
 4 files changed, 402 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq9574.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq9574.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index 2e8acca64af1..cc563d640336 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -18,6 +18,8 @@ description: |
     include/dt-bindings/clock/qcom,gcc-ipq4019.h
     include/dt-bindings/clock/qcom,gcc-ipq6018.h
     include/dt-bindings/reset/qcom,gcc-ipq6018.h
+    include/dt-bindings/clock/qcom,gcc-ipq9574.h
+    include/dt-bindings/reset/qcom,gcc-ipq9574.h
     include/dt-bindings/clock/qcom,gcc-msm8953.h
     include/dt-bindings/clock/qcom,gcc-mdm9607.h
     include/dt-bindings/clock/qcom,gcc-mdm9615.h
@@ -34,6 +36,8 @@ properties:
       - qcom,gcc-mdm9607
       - qcom,gcc-msm8953
       - qcom,gcc-mdm9615
+      - qcom,gcc-ipq9574
+
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index 7129fbcf2b6c..5a71268538e6 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -24,6 +24,14 @@ properties:
   '#power-domain-cells':
     const: 1
 
+  clocks:
+    minItems: 1
+    maxItems: 8
+
+  clock-names:
+    minItems: 1
+    maxItems: 8
+
   reg:
     maxItems: 1
 
@@ -35,7 +43,6 @@ required:
   - reg
   - '#clock-cells'
   - '#reset-cells'
-  - '#power-domain-cells'
 
 additionalProperties: true
 
diff --git a/include/dt-bindings/clock/qcom,gcc-ipq9574.h b/include/dt-bindings/clock/qcom,gcc-ipq9574.h
new file mode 100644
index 000000000000..312d513305ec
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-ipq9574.h
@@ -0,0 +1,226 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018-2022 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_IPQ_GCC_9048_H
+#define _DT_BINDINGS_CLOCK_IPQ_GCC_9048_H
+
+#define GPLL0_MAIN					0
+#define GPLL0						1
+#define GPLL2_MAIN					2
+#define GPLL2						3
+#define GPLL4_MAIN					4
+#define GPLL4						5
+#define GCC_SLEEP_CLK_SRC				6
+#define APSS_AHB_CLK_SRC				7
+#define APSS_AXI_CLK_SRC				8
+#define BLSP1_QUP1_I2C_APPS_CLK_SRC			9
+#define BLSP1_QUP1_SPI_APPS_CLK_SRC			10
+#define BLSP1_QUP2_I2C_APPS_CLK_SRC			11
+#define BLSP1_QUP2_SPI_APPS_CLK_SRC			12
+#define BLSP1_QUP3_I2C_APPS_CLK_SRC			13
+#define BLSP1_QUP3_SPI_APPS_CLK_SRC			14
+#define BLSP1_QUP4_I2C_APPS_CLK_SRC			15
+#define BLSP1_QUP4_SPI_APPS_CLK_SRC			16
+#define BLSP1_QUP5_I2C_APPS_CLK_SRC			17
+#define BLSP1_QUP5_SPI_APPS_CLK_SRC			18
+#define BLSP1_QUP6_I2C_APPS_CLK_SRC			19
+#define BLSP1_QUP6_SPI_APPS_CLK_SRC			20
+#define BLSP1_UART1_APPS_CLK_SRC			21
+#define BLSP1_UART2_APPS_CLK_SRC			22
+#define BLSP1_UART3_APPS_CLK_SRC			23
+#define BLSP1_UART4_APPS_CLK_SRC			24
+#define BLSP1_UART5_APPS_CLK_SRC			25
+#define BLSP1_UART6_APPS_CLK_SRC			26
+#define GCC_APSS_AHB_CLK				27
+#define GCC_APSS_AXI_CLK				28
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK			29
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK			30
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK			31
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK			32
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK			33
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK			34
+#define GCC_BLSP1_QUP4_I2C_APPS_CLK			35
+#define GCC_BLSP1_QUP4_SPI_APPS_CLK			36
+#define GCC_BLSP1_QUP5_I2C_APPS_CLK			37
+#define GCC_BLSP1_QUP5_SPI_APPS_CLK			38
+#define GCC_BLSP1_QUP6_I2C_APPS_CLK			39
+#define GCC_BLSP1_QUP6_SPI_APPS_CLK			40
+#define GCC_BLSP1_UART1_APPS_CLK			41
+#define GCC_BLSP1_UART2_APPS_CLK			42
+#define GCC_BLSP1_UART3_APPS_CLK			43
+#define GCC_BLSP1_UART4_APPS_CLK			44
+#define GCC_BLSP1_UART5_APPS_CLK			45
+#define GCC_BLSP1_UART6_APPS_CLK			46
+#define PCIE0_AXI_M_CLK_SRC				47
+#define GCC_PCIE0_AXI_M_CLK				48
+#define PCIE1_AXI_M_CLK_SRC				49
+#define GCC_PCIE1_AXI_M_CLK				50
+#define PCIE2_AXI_M_CLK_SRC				51
+#define GCC_PCIE2_AXI_M_CLK				52
+#define PCIE3_AXI_M_CLK_SRC				53
+#define GCC_PCIE3_AXI_M_CLK				54
+#define PCIE0_AXI_S_CLK_SRC				55
+#define GCC_PCIE0_AXI_S_BRIDGE_CLK			56
+#define GCC_PCIE0_AXI_S_CLK				57
+#define PCIE1_AXI_S_CLK_SRC				58
+#define GCC_PCIE1_AXI_S_BRIDGE_CLK			59
+#define GCC_PCIE1_AXI_S_CLK				60
+#define PCIE2_AXI_S_CLK_SRC				61
+#define GCC_PCIE2_AXI_S_BRIDGE_CLK			62
+#define GCC_PCIE2_AXI_S_CLK				63
+#define PCIE3_AXI_S_CLK_SRC				64
+#define GCC_PCIE3_AXI_S_BRIDGE_CLK			65
+#define GCC_PCIE3_AXI_S_CLK				66
+#define PCIE0_PIPE_CLK_SRC				67
+#define PCIE1_PIPE_CLK_SRC				68
+#define PCIE2_PIPE_CLK_SRC				69
+#define PCIE3_PIPE_CLK_SRC				70
+#define PCIE_AUX_CLK_SRC				71
+#define GCC_PCIE0_AUX_CLK				72
+#define GCC_PCIE1_AUX_CLK				73
+#define GCC_PCIE2_AUX_CLK				74
+#define GCC_PCIE3_AUX_CLK				75
+#define PCIE0_RCHNG_CLK_SRC				76
+#define GCC_PCIE0_RCHNG_CLK				77
+#define PCIE1_RCHNG_CLK_SRC				78
+#define GCC_PCIE1_RCHNG_CLK				79
+#define PCIE2_RCHNG_CLK_SRC				80
+#define GCC_PCIE2_RCHNG_CLK				81
+#define PCIE3_RCHNG_CLK_SRC				82
+#define GCC_PCIE3_RCHNG_CLK				83
+#define GCC_PCIE0_AHB_CLK				84
+#define GCC_PCIE1_AHB_CLK				85
+#define GCC_PCIE2_AHB_CLK				86
+#define GCC_PCIE3_AHB_CLK				87
+#define USB0_AUX_CLK_SRC				88
+#define GCC_USB0_AUX_CLK				89
+#define USB0_MASTER_CLK_SRC				90
+#define GCC_USB0_MASTER_CLK				91
+#define GCC_SNOC_USB_CLK				92
+#define GCC_ANOC_USB_AXI_CLK				93
+#define USB0_MOCK_UTMI_CLK_SRC				94
+#define USB0_MOCK_UTMI_DIV_CLK_SRC			95
+#define GCC_USB0_MOCK_UTMI_CLK				96
+#define USB0_PIPE_CLK_SRC				97
+#define GCC_USB0_PHY_CFG_AHB_CLK			98
+#define SDCC1_APPS_CLK_SRC				99
+#define GCC_SDCC1_APPS_CLK				100
+#define SDCC1_ICE_CORE_CLK_SRC				101
+#define GCC_SDCC1_ICE_CORE_CLK				102
+#define GCC_SDCC1_AHB_CLK				103
+#define PCNOC_BFDCD_CLK_SRC				104
+#define GCC_NSSCFG_CLK					105
+#define GCC_NSSNOC_NSSCC_CLK				106
+#define GCC_NSSCC_CLK					107
+#define GCC_NSSNOC_PCNOC_1_CLK				108
+#define GCC_QDSS_DAP_AHB_CLK				109
+#define GCC_QDSS_CFG_AHB_CLK				110
+#define GCC_SNOC_PCNOC_AHB_CLK				111
+#define GCC_ANOC_PCNOC_AHB_CLK				112
+#define GCC_QPIC_AHB_CLK				113
+#define GCC_QPIC_CLK					114
+#define GCC_BLSP1_AHB_CLK				115
+#define GCC_MDIO_AHB_CLK				116
+#define GCC_PRNG_AHB_CLK				117
+#define GCC_UNIPHY0_AHB_CLK				118
+#define GCC_UNIPHY1_AHB_CLK				119
+#define GCC_UNIPHY2_AHB_CLK				120
+#define GCC_CMN_12GPLL_AHB_CLK				121
+#define GCC_CMN_12GPLL_APU_CLK				122
+#define SYSTEM_NOC_BFDCD_CLK_SRC			123
+#define GCC_NSSNOC_SNOC_CLK				124
+#define GCC_NSSNOC_SNOC_1_CLK				125
+#define GCC_QDSS_ETR_USB_CLK				126
+#define GCC_SYS_NOC_AXI_CLK				127
+#define GCC_ANOC0_AXI_CLK				128
+#define GCC_ANOC1_AXI_CLK				129
+#define GCC_ANOC0_TBU_CLK				130
+#define GCC_ANOC1_TBU_CLK				131
+#define GCC_MEM_NOC_SNOC_AXI_CLK			132
+#define GCC_IMEM_AXI_CLK				133
+#define WCSS_AHB_CLK_SRC				134
+#define GCC_Q6_AHB_CLK					135
+#define GCC_Q6_AHB_S_CLK				136
+#define GCC_WCSS_ECAHB_CLK				137
+#define GCC_WCSS_ACMT_CLK				138
+#define GCC_SYS_NOC_WCSS_AHB_CLK			139
+#define WCSS_AXI_M_CLK_SRC				140
+#define GCC_ANOC_WCSS_AXI_M_CLK				141
+#define QDSS_AT_CLK_SRC					142
+#define GCC_Q6SS_ATBM_CLK				143
+#define GCC_WCSS_DBG_IFC_ATB_CLK			144
+#define GCC_NSSNOC_ATB_CLK				145
+#define GCC_QDSS_AT_CLK					146
+#define GCC_SYS_NOC_AT_CLK				147
+#define GCC_PCNOC_AT_CLK				148
+#define GCC_USB0_EUD_AT_CLK				149
+#define GCC_QDSS_EUD_AT_CLK				150
+#define QDSS_STM_CLK_SRC				151
+#define GCC_QDSS_STM_CLK				152
+#define GCC_SYS_NOC_QDSS_STM_AXI_CLK			153
+#define QDSS_TRACECLKIN_CLK_SRC				154
+#define GCC_QDSS_TRACECLKIN_CLK				155
+#define QDSS_TSCTR_CLK_SRC				156
+#define GCC_Q6_TSCTR_1TO2_CLK				157
+#define GCC_WCSS_DBG_IFC_NTS_CLK			158
+#define GCC_QDSS_TSCTR_DIV2_CLK				159
+#define GCC_QDSS_TS_CLK					160
+#define GCC_SNOC_TS_CLK					161
+#define GCC_MEM_NOC_TS_CLK				162
+#define GCC_QDSS_TSCTR_DIV4_CLK				163
+#define GCC_NSS_TS_CLK					164
+#define GCC_QDSS_TSCTR_DIV8_CLK				165
+#define GCC_PCNOC_TS_CLK				166
+#define GCC_QDSS_TSCTR_DIV16_CLK			167
+#define GCC_Q6SS_PCLKDBG_CLK				168
+#define GCC_Q6SS_TRIG_CLK				169
+#define GCC_WCSS_DBG_IFC_APB_CLK			170
+#define GCC_WCSS_DBG_IFC_DAPBUS_CLK			171
+#define GCC_QDSS_DAP_CLK				172
+#define GCC_QDSS_APB2JTAG_CLK				173
+#define GCC_QDSS_TSCTR_DIV3_CLK				174
+#define QPIC_IO_MACRO_CLK_SRC				175
+#define GCC_QPIC_IO_MACRO_CLK				176
+#define Q6_AXI_CLK_SRC					177
+#define GCC_Q6_AXIM_CLK					178
+#define GCC_WCSS_Q6_TBU_CLK				179
+#define GCC_MEM_NOC_Q6_AXI_CLK				180
+#define Q6_AXIM2_CLK_SRC				181
+#define NSSNOC_MEMNOC_BFDCD_CLK_SRC			182
+#define GCC_NSSNOC_MEMNOC_CLK				183
+#define GCC_NSSNOC_MEM_NOC_1_CLK			184
+#define GCC_NSS_TBU_CLK					185
+#define GCC_MEM_NOC_NSSNOC_CLK				186
+#define LPASS_AXIM_CLK_SRC				187
+#define LPASS_SWAY_CLK_SRC				188
+#define ADSS_PWM_CLK_SRC				189
+#define GCC_ADSS_PWM_CLK				190
+#define GP1_CLK_SRC					191
+#define GP2_CLK_SRC					192
+#define GP3_CLK_SRC					193
+#define DDRSS_SMS_SLOW_CLK_SRC				194
+#define GCC_XO_CLK_SRC					195
+#define GCC_XO_CLK					196
+#define GCC_NSSNOC_QOSGEN_REF_CLK			197
+#define GCC_NSSNOC_TIMEOUT_REF_CLK			198
+#define GCC_XO_DIV4_CLK					199
+#define GCC_UNIPHY0_SYS_CLK				200
+#define GCC_UNIPHY1_SYS_CLK				201
+#define GCC_UNIPHY2_SYS_CLK				202
+#define GCC_CMN_12GPLL_SYS_CLK				203
+#define GCC_NSSNOC_XO_DCD_CLK				204
+#define GCC_Q6SS_BOOT_CLK				205
+#define UNIPHY_SYS_CLK_SRC				206
+#define NSS_TS_CLK_SRC					207
+#define GCC_ANOC_PCIE0_1LANE_M_CLK			208
+#define GCC_ANOC_PCIE1_1LANE_M_CLK			209
+#define GCC_ANOC_PCIE2_2LANE_M_CLK			210
+#define GCC_ANOC_PCIE3_2LANE_M_CLK			211
+#define GCC_SNOC_PCIE0_1LANE_S_CLK			212
+#define GCC_SNOC_PCIE1_1LANE_S_CLK			213
+#define GCC_SNOC_PCIE2_2LANE_S_CLK			214
+#define GCC_SNOC_PCIE3_2LANE_S_CLK			215
+#define GCC_PCNOC_DCC_CLK				216
+#endif
diff --git a/include/dt-bindings/reset/qcom,gcc-ipq9574.h b/include/dt-bindings/reset/qcom,gcc-ipq9574.h
new file mode 100644
index 000000000000..18207b577b99
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,gcc-ipq9574.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018-2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_IPQ_GCC_9048_H
+#define _DT_BINDINGS_RESET_IPQ_GCC_9048_H
+
+#define GCC_ADSS_BCR						0
+#define GCC_APC0_VOLTAGE_DROOP_DETECTOR_BCR			1
+#define GCC_BLSP1_BCR						2
+#define GCC_BLSP1_QUP1_BCR					3
+#define GCC_BLSP1_QUP2_BCR					4
+#define GCC_BLSP1_QUP3_BCR					5
+#define GCC_BLSP1_QUP4_BCR					6
+#define GCC_BLSP1_QUP5_BCR					7
+#define GCC_BLSP1_QUP6_BCR					8
+#define GCC_BLSP1_UART1_BCR					9
+#define GCC_BLSP1_UART2_BCR					10
+#define GCC_BLSP1_UART3_BCR					11
+#define GCC_BLSP1_UART4_BCR					12
+#define GCC_BLSP1_UART5_BCR					13
+#define GCC_BLSP1_UART6_BCR					14
+#define GCC_BOOT_ROM_BCR					15
+#define GCC_MDIO_BCR						16
+#define GCC_NSS_BCR						17
+#define GCC_NSS_TBU_BCR						18
+#define GCC_PCIE0_BCR						19
+#define GCC_PCIE0_LINK_DOWN_BCR					20
+#define GCC_PCIE0_PHY_BCR					21
+#define GCC_PCIE0PHY_PHY_BCR					22
+#define GCC_PCIE1_BCR						23
+#define GCC_PCIE1_LINK_DOWN_BCR					24
+#define GCC_PCIE1_PHY_BCR					25
+#define GCC_PCIE1PHY_PHY_BCR					26
+#define GCC_PCIE2_BCR						27
+#define GCC_PCIE2_LINK_DOWN_BCR					28
+#define GCC_PCIE2_PHY_BCR					29
+#define GCC_PCIE2PHY_PHY_BCR					30
+#define GCC_PCIE3_BCR						31
+#define GCC_PCIE3_LINK_DOWN_BCR					32
+#define GCC_PCIE3_PHY_BCR					33
+#define GCC_PCIE3PHY_PHY_BCR					34
+#define GCC_PRNG_BCR						35
+#define GCC_QUSB2_0_PHY_BCR					36
+#define GCC_SDCC_BCR						37
+#define GCC_TLMM_BCR						38
+#define GCC_UNIPHY0_BCR						39
+#define GCC_UNIPHY1_BCR						40
+#define GCC_UNIPHY2_BCR						41
+#define GCC_USB0_PHY_BCR					42
+#define GCC_USB3PHY_0_PHY_BCR					43
+#define GCC_USB_BCR						44
+#define GCC_ANOC0_TBU_BCR					45
+#define GCC_ANOC1_TBU_BCR					46
+#define GCC_ANOC_BCR						47
+#define GCC_APSS_TCU_BCR					48
+#define GCC_CMN_BLK_BCR						49
+#define GCC_CMN_BLK_AHB_ARES					50
+#define GCC_CMN_BLK_SYS_ARES					51
+#define GCC_CMN_BLK_APU_ARES					52
+#define GCC_DCC_BCR						53
+#define GCC_DDRSS_BCR						54
+#define GCC_IMEM_BCR						55
+#define GCC_LPASS_BCR						56
+#define GCC_MPM_BCR						57
+#define GCC_MSG_RAM_BCR						58
+#define GCC_NSSNOC_MEMNOC_1_ARES				59
+#define GCC_NSSNOC_PCNOC_1_ARES					60
+#define GCC_NSSNOC_SNOC_1_ARES					61
+#define GCC_NSSNOC_XO_DCD_ARES					62
+#define GCC_NSSNOC_TS_ARES					63
+#define GCC_NSSCC_ARES						64
+#define GCC_NSSNOC_NSSCC_ARES					65
+#define GCC_NSSNOC_ATB_ARES					66
+#define GCC_NSSNOC_MEMNOC_ARES					67
+#define GCC_NSSNOC_QOSGEN_REF_ARES				68
+#define GCC_NSSNOC_SNOC_ARES					69
+#define GCC_NSSNOC_TIMEOUT_REF_ARES				70
+#define GCC_NSS_CFG_ARES					71
+#define GCC_UBI0_DBG_ARES					72
+#define GCC_PCIE0_AHB_ARES					73
+#define GCC_PCIE0_AUX_ARES					74
+#define GCC_PCIE0_AXI_M_ARES					75
+#define GCC_PCIE0_AXI_M_STICKY_ARES				76
+#define GCC_PCIE0_AXI_S_ARES					77
+#define GCC_PCIE0_AXI_S_STICKY_ARES				78
+#define GCC_PCIE0_CORE_STICKY_ARES				79
+#define GCC_PCIE0_PIPE_ARES					80
+#define GCC_PCIE1_AHB_ARES					81
+#define GCC_PCIE1_AUX_ARES					82
+#define GCC_PCIE1_AXI_M_ARES					83
+#define GCC_PCIE1_AXI_M_STICKY_ARES				84
+#define GCC_PCIE1_AXI_S_ARES					85
+#define GCC_PCIE1_AXI_S_STICKY_ARES				86
+#define GCC_PCIE1_CORE_STICKY_ARES				87
+#define GCC_PCIE1_PIPE_ARES					88
+#define GCC_PCIE2_AHB_ARES					89
+#define GCC_PCIE2_AUX_ARES					90
+#define GCC_PCIE2_AXI_M_ARES					91
+#define GCC_PCIE2_AXI_M_STICKY_ARES				92
+#define GCC_PCIE2_AXI_S_ARES					93
+#define GCC_PCIE2_AXI_S_STICKY_ARES				94
+#define GCC_PCIE2_CORE_STICKY_ARES				95
+#define GCC_PCIE2_PIPE_ARES					96
+#define GCC_PCIE3_AHB_ARES					97
+#define GCC_PCIE3_AUX_ARES					98
+#define GCC_PCIE3_AXI_M_ARES					99
+#define GCC_PCIE3_AXI_M_STICKY_ARES				100
+#define GCC_PCIE3_AXI_S_ARES					101
+#define GCC_PCIE3_AXI_S_STICKY_ARES				102
+#define GCC_PCIE3_CORE_STICKY_ARES				103
+#define GCC_PCIE3_PIPE_ARES					104
+#define GCC_PCNOC_BCR						105
+#define GCC_PCNOC_BUS_TIMEOUT0_BCR				106
+#define GCC_PCNOC_BUS_TIMEOUT1_BCR				107
+#define GCC_PCNOC_BUS_TIMEOUT2_BCR				108
+#define GCC_PCNOC_BUS_TIMEOUT3_BCR				109
+#define GCC_PCNOC_BUS_TIMEOUT4_BCR				110
+#define GCC_PCNOC_BUS_TIMEOUT5_BCR				111
+#define GCC_PCNOC_BUS_TIMEOUT6_BCR				112
+#define GCC_PCNOC_BUS_TIMEOUT7_BCR				113
+#define GCC_PCNOC_BUS_TIMEOUT8_BCR				114
+#define GCC_PCNOC_BUS_TIMEOUT9_BCR				115
+#define GCC_PCNOC_TBU_BCR					116
+#define GCC_Q6SS_DBG_ARES					117
+#define GCC_Q6_AHB_ARES						118
+#define GCC_Q6_AHB_S_ARES					119
+#define GCC_Q6_AXIM2_ARES					120
+#define GCC_Q6_AXIM_ARES					121
+#define GCC_QDSS_BCR						122
+#define GCC_QPIC_BCR						123
+#define GCC_QPIC_AHB_ARES					124
+#define GCC_QPIC_ARES						125
+#define GCC_RBCPR_BCR						126
+#define GCC_RBCPR_MX_BCR					127
+#define GCC_SEC_CTRL_BCR					128
+#define GCC_SMMU_CFG_BCR					129
+#define GCC_SNOC_BCR						130
+#define GCC_SPDM_BCR						131
+#define GCC_TME_BCR						132
+#define GCC_UNIPHY0_SYS_RESET					133
+#define GCC_UNIPHY0_AHB_RESET					134
+#define GCC_UNIPHY0_XPCS_RESET					135
+#define GCC_UNIPHY1_SYS_RESET					136
+#define GCC_UNIPHY1_AHB_RESET					137
+#define GCC_UNIPHY1_XPCS_RESET					138
+#define GCC_UNIPHY2_SYS_RESET					139
+#define GCC_UNIPHY2_AHB_RESET					140
+#define GCC_UNIPHY2_XPCS_RESET					141
+#define GCC_USB_MISC_RESET					142
+#define GCC_WCSSAON_RESET					143
+#define GCC_WCSS_ACMT_ARES					144
+#define GCC_WCSS_AHB_S_ARES					145
+#define GCC_WCSS_AXI_M_ARES					146
+#define GCC_WCSS_BCR						147
+#define GCC_WCSS_DBG_ARES					148
+#define GCC_WCSS_DBG_BDG_ARES					149
+#define GCC_WCSS_ECAHB_ARES					150
+#define GCC_WCSS_Q6_BCR						151
+#define GCC_WCSS_Q6_TBU_BCR					152
+#define GCC_TCSR_BCR						153
+
+#endif
-- 
2.17.1

