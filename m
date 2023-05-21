Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7FE70B1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjEUWbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjEUWb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:31:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E719D;
        Sun, 21 May 2023 15:31:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMKMAd008663;
        Sun, 21 May 2023 22:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0Ohj/c0pwNjTWAj1F0YqcMHYb9dDbpYymK6fWTSiUH8=;
 b=pGr8mX6gv9kkfcLMBN37iJEayS4NGw5ATMuYn8Bkn7/M/d98SNL+8+vlpcPETUBEs5lt
 0RMr63pnKQSbeHMSl302sjfug1EYbeIVqzjGksUC8SZQNCrRalA1UByDS0R60+76tnXQ
 /J9Lm3Uiq5N0veXtw6eOGgEfPCd0pxjri/lMQ+LFHLcpWahbX+KhQuly3yuvcCDZ+ChI
 tvpM/vUgAqWlcOJKnNA5oA/d8JryhKWxw2I9+3wYdxl5Q9lGFVUXsFRPnSwxi93pZGQL
 KTaMMDJFQh8VRP73PNSCFAxqxxWGY4W+KcBBvo/Y4/G+xtVWgweybYaPU2ZxE+eIbMB+ gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppypa6cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:30:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LMUiuH026839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:30:44 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 21 May 2023 15:30:37 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <quic_mmanikan@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V2 12/13] arm64: dts: qcom: ipq5018: Add RDP432-c1 board support
Date:   Mon, 22 May 2023 03:58:51 +0530
Message-ID: <20230521222852.5740-13-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SbYtfswi2Bra9PUdrD-uffKZG38reukA
X-Proofpoint-GUID: SbYtfswi2Bra9PUdrD-uffKZG38reukA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_17,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210203
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree support for the RDP432-C1 board.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V2:
	- Renamed mp03.5-c1 to RDP432-c1
	- Removed boot-args
	- Resolved dt-binding error's

 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts | 49 +++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 259bd57c6064..bb9164de75b0 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts
new file mode 100644
index 000000000000..7fe28d9859b0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+/*
+ * IPQ5018 RDP432-C1 board device tree source
+ *
+ * Copyright (c) 2023, The Linux Foundation. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq5018.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ5018/AP-RDP432.1-C1";
+	compatible = "qcom,ipq5018-rdp432-c1", "qcom,ipq5018";
+
+	aliases {
+		serial0 = &blsp1_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&blsp1_uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&q6v5_wcss {
+	pd-2 {
+		firmware-name = "IPQ5018/q6_fw.mdt";
+		status = "okay";
+	};
+
+	pd-3 {
+		firmware-name = "IPQ5018/q6_fw.mdt";
+		status = "okay";
+	};
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&xo_board_clk {
+	clock-frequency = <24000000>;
+};
--
2.17.1

