Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744DB649E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiLLLp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiLLLp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:45:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9EF20A;
        Mon, 12 Dec 2022 03:45:55 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BC7gLEm022097;
        Mon, 12 Dec 2022 11:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=9Dx7Im/qaVVIn1kDzXWEbUeo27z30INpqHCiA9IegNQ=;
 b=ENnIGJ5u4F9B2q0H1JBoY1/fE9l7yWXpEsKesOYfmPgaAiYSdD4YFg+XQRfa7n2e7GIt
 kmBN85KvkZ7nVqnCJkqgDZ+BYWubJR2CLVx6n/eND7yWfguPlEK1r4Vc83t64faXb30W
 AKkDaodP4m8rJCmDgCj0EGVIjOz6QbAb3B9Bcjg4b8xm0tYqw/fnbV631A4MjjCbZdC1
 n6SydAFg5E7+FDBLLpdEaySc5C6vDRc3PIWJ+uyHz7M0eNzwh7BReAGO0t0Dd2nKefyu
 +sINyvm4n7xSWxNlLvoikEARXJXmo6x2NwxuTLp3H/Pcti+WNl1JQjUFL1pBVNY0vEkb EQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mcj723xrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 11:45:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BCBjigR016419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 11:45:44 GMT
Received: from shazhuss-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 12 Dec 2022 03:45:40 -0800
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <andersson@kernel.org>, <johan@kernel.org>
CC:     <bmasney@redhat.com>, Shazad Hussain <quic_shazhuss@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
Date:   Mon, 12 Dec 2022 17:15:01 +0530
Message-ID: <20221212114502.1616-1-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GFf6ibYlAR1lDAvAy5L0nYw7nbVJ_jK5
X-Proofpoint-ORIG-GUID: GFf6ibYlAR1lDAvAy5L0nYw7nbVJ_jK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=938 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pcie2a, pcie2a_phy, and respective tlmm
nodes that are needed to get pcie 2a controller
enabled on Qdrive3.

This patch enables 4GB 64bit memory space for
PCIE_2A to have BAR allocations of 64bit pref mem
needed on this Qdrive3 platform with dual SoCs
for root port and switch NT-EP. Hence this ranges
property is overridden in sa8540p-ride.dts only.

Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
---
This patch depends on below patch series for vreg_l11a.

[v4] arm64: dts: qcom: sa8540p-ride: enable PCIe support
https://lore.kernel.org/all/20221206161916.315640-1-bmasney@redhat.com/

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index bb4afd3a9632..ed20423ec8ac 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -146,6 +146,27 @@ vreg_l8g: ldo8 {
 	};
 };
 
+&pcie2a {
+	ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
+			 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>,
+			 <0x03000000 0x5 0x00000000 0x5 0x00000000 0x1 0x00000000>;
+
+	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 145 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2a_default>;
+
+	status = "okay";
+};
+
+&pcie2a_phy {
+	vdda-phy-supply = <&vreg_l11a>;
+	vdda-pll-supply = <&vreg_l3a>;
+
+	status = "okay";
+};
+
 &pcie3a {
 	ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
 	         <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x20000000>,
@@ -247,6 +268,29 @@ &xo_board_clk {
 /* PINCTRL */
 
 &tlmm {
+	pcie2a_default: pcie2a-default-state {
+		perst-pins {
+			pins = "gpio143";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		clkreq-pins {
+			pins = "gpio142";
+			function = "pcie2a_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio145";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
 	pcie3a_default: pcie3a-default-state {
 		perst-pins {
 			pins = "gpio151";
-- 
2.38.0

