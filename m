Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E363864A3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiLLPBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiLLPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:01:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157D11829;
        Mon, 12 Dec 2022 07:01:12 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCBSa0V027425;
        Mon, 12 Dec 2022 15:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=s+ZErhGp9bZxI8C5QmN4cSgS/TS+P71At378mJe/veU=;
 b=m5GSVIQHg+ZLCJl3mCCGnkaAXUJWaDVNBGhHUdAxT4Z/bPpCP7asd1tH7NQ8ZREJviP2
 KNuFNEqcP70ZaaJEaLmDLzMxicgbvurwfvCIM8EbaZUROnDm+MOaHNuk1m0B1eKUgiWf
 Xbqo6GFEiJO9+ncUq9K6PfkbWsk5gU/4NrneeYu3y3sj2wVqK7BqBEI8zjlF8HieQGRw
 ypHLLh2FINVMc01fgMpxSb4H8Ifq4k057r/zlCZHH2OwpAD9YMMiZ63Br2nupTgsJA1I
 uIsDrKD4n42hSWDSPnxUNGNwnLHagxswBlyhUWIbPS5CxQ9QVZPfFTc4oUJwVtmyp82N /g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mcjb94a7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 15:01:07 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BCF15jl005341
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 15:01:06 GMT
Received: from shazhuss-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 12 Dec 2022 07:01:02 -0800
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <andersson@kernel.org>, <johan@kernel.org>
CC:     <bmasney@redhat.com>, Shazad Hussain <quic_shazhuss@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
Date:   Mon, 12 Dec 2022 20:30:45 +0530
Message-ID: <20221212150045.4252-1-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F1HSG6CHEEyz17_UT045Di2q08S1LRy5
X-Proofpoint-ORIG-GUID: F1HSG6CHEEyz17_UT045Di2q08S1LRy5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120137
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
Changes since v2:
- Discard below patch as v3 is merged in qcom tree
  [v4] arm64: dts: qcom: sa8540p-ride: enable PCIe support
  https://lore.kernel.org/all/20221206161916.315640-1-bmasney@redhat.com/
- Move tlmm PINCTRL to the end and add R-b (Brian)

Changes since v1:
- Fix ranges property indentation (Konrad)

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 96 +++++++++++++++++------
 1 file changed, 71 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 6c547f1b13dc..19b411175202 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -146,6 +146,27 @@ vreg_l8g: ldo8 {
 	};
 };
 
+&pcie2a {
+	ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
+		 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>,
+		 <0x03000000 0x5 0x00000000 0x5 0x00000000 0x1 0x00000000>;
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
@@ -186,31 +207,6 @@ &remoteproc_nsp1 {
 	status = "okay";
 };
 
-&tlmm {
-	pcie3a_default: pcie3a-default-state {
-		perst-pins {
-			pins = "gpio151";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
-
-		clkreq-pins {
-			pins = "gpio150";
-			function = "pcie3a_clkreq";
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-
-		wake-pins {
-			pins = "gpio56";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-	};
-};
-
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
 
@@ -268,3 +264,52 @@ &usb_2_qmpphy0 {
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };
+
+/* PINCTRL */
+
+&tlmm {
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
+	pcie3a_default: pcie3a-default-state {
+		perst-pins {
+			pins = "gpio151";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		clkreq-pins {
+			pins = "gpio150";
+			function = "pcie3a_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio56";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
-- 
2.38.0

