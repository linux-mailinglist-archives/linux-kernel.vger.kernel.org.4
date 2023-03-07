Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7636AD67E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCGEoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCGEoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:44:09 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A334E5DE;
        Mon,  6 Mar 2023 20:43:37 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3274Vdcq031416;
        Tue, 7 Mar 2023 04:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=r0Lhsr+RpFlNMbivYbzkQWWbPt0DRzvihP3FJBFh3L0=;
 b=DyHY9ZnG0rPwLPDNSSmzfxdVgvV6Wu+1C6CstB0O7JIZD+Vwmowdw4TKNQM5NK8c4KRM
 AfiRxMv2B7EZO7jAWoesHUe2vv+HX+mJmx6nqOa+yrE8vD/v3LejrEg/VbbdYvSAIoPi
 PzbWencBmkTXx0dBALVJL+Wvmi6EuOQg5o7PJ2BdBqQ7JFEXXfhaNCri7Q9Lh4IFHcDO
 I7CZTA9sTIUMGEVU1cParCpqmhNqG3O932VMb1yHOTQHdypuxpm1yvQRM0r9+7VQNueH
 d1qzWOFwqxhhl4WXVQmXhBCGwNkqYfzKm3Sf9fKniRLIrWRCf+ZHUXgrEPKYSgwtg+xy 3A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p419d6v6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 04:43:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3274hBhk001297
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 04:43:11 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 20:43:03 -0800
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_mmanikan@quicinc.com>,
        <quic_gurus@quicinc.com>, <loic.poulain@linaro.org>,
        <quic_eberman@quicinc.com>, <robimarko@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 10/11] arm64: dts: qcom: ipq5018: Add MP03.5-c1 board support
Date:   Tue, 7 Mar 2023 10:11:36 +0530
Message-ID: <1678164097-13247-11-git-send-email-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rRJWM63lxOYuyoqSDftPibPW5n_HN8jd
X-Proofpoint-GUID: rRJWM63lxOYuyoqSDftPibPW5n_HN8jd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070041
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree support for the MP03.5-C1 board.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts | 64 +++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b77a95e97a56..10d1eafe57e4 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-mp03.1-c2.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-mp03.5-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
diff --git a/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts b/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
new file mode 100644
index 000000000000..51ddd7367ac6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+/*
+ * IPQ5018 CP01 board device tree source
+ *
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq5018.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03.5-C1";
+	compatible = "qcom,ipq5018-mp03.5-c1", "qcom,ipq5018";
+
+	aliases {
+		serial0 = &blsp1_uart1;
+	};
+
+	chosen {
+		bootargs = "console=ttyMSM0,115200,n8 rw init=/init swiotlb=1 coherent_pool=2M";
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&tlmm {
+	blsp0_uart_pins: uart_pins {
+		pins = "gpio20", "gpio21";
+		function = "blsp0_uart0";
+		bias-disable;
+	};
+};
+
+&blsp1_uart1 {
+	pinctrl-0 = <&blsp0_uart_pins>;
+	pinctrl-names = "default";
+	status = "ok";
+};
+
+&q6v5_wcss {
+	q6_wcss_pd1: remoteproc_pd1 {
+		interrupts-extended = <&wcss_smp2p_in 8 0>,
+				<&wcss_smp2p_in 9 0>,
+				<&wcss_smp2p_in 12 0>,
+				<&wcss_smp2p_in 11 0>;
+		interrupt-names = "fatal",
+				"ready",
+				"spawn-ack",
+				"stop-ack";
+		qcom,smem-states = <&wcss_smp2p_out 8>,
+				<&wcss_smp2p_out 9>,
+				<&wcss_smp2p_out 10>;
+		qcom,smem-state-names = "shutdown",
+					"stop",
+					"spawn";
+	};
+	q6_wcss_pd2: remoteproc_pd2 {
+		status = "okay";
+	};
+
+	q6_wcss_pd3: remoteproc_pd3 {
+		status = "okay";
+	};
+};
-- 
2.34.1

