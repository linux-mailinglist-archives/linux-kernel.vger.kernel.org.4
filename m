Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46666D7BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbjDELnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbjDELnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:43:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E725FD8;
        Wed,  5 Apr 2023 04:43:20 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335BQKMt015464;
        Wed, 5 Apr 2023 11:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2u1bt7sISW7gYR56t/sEB8xayuIhGFjBWFB7FY5nIho=;
 b=kRIHBKevPXWIgKQZLuz0h0Tk05ns77bzHnDwj6AwZFGKWel+YUG40bITSkY/jjDdFk11
 1MjmGUGTmJd36f141wMuYweHn74wZy8N/L2OxX1sKxgGYMpYcaYz0ONsCn2pJOg6Awed
 quv1tMLPvIAihDr/UUKOEIHqTeXo4qAj8wtYknUpAXcqV9cjUoB61P04pYol9qWS81Ux
 PM9KTPGRZXpFMlvDFl86Du6ymqujptR+0ijwskZljtBHQ8Dp0kEAx6/VybVJ0nvcey4q
 dmGLOrqrUP246pxQ3SwmtdWJAr/SOFtNrlaNb7Wj5s+q9Cz1yggiJ9JkQ66TPiPDJ84E Ng== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prwc79bx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 11:42:27 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335BgRh1027969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 11:42:27 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 04:42:21 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v8 8/8] arm64: dts: qcom: ipq9574: Enable USB
Date:   Wed, 5 Apr 2023 17:11:27 +0530
Message-ID: <a1d3329d53af5d0abb978e71c1cde1ed3b9c91df.1680693149.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1680693149.git.quic_varada@quicinc.com>
References: <cover.1680693149.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ePSz6AGMWaSZfUlPeFFpaRYyLraPuMsB
X-Proofpoint-ORIG-GUID: ePSz6AGMWaSZfUlPeFFpaRYyLraPuMsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_07,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=668
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050106
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn on USB related nodes

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Changes in v5:
	- Move "host" mode specification to board dts
	- Due to dependency with earlier patches board dts
	  filename changed ipq9574-al02-c7.dts -> ipq9574-rdp433.dts

 Changes in v2:
	- Fix node placement and coding style
	- "ok" -> "okay"
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 859973b..92ff7ee 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -44,6 +44,10 @@
 	};
 };
 
+&dwc_0 {
+	dr_mode = "host";
+};
+
 &pcie1_phy {
 	status = "okay";
 };
@@ -107,6 +111,14 @@
 	clock-frequency = <32000>;
 };
 
+&usb_0_qmpphy {
+	status = "okay";
+};
+
+&usb_0_qusbphy {
+	status = "okay";
+};
+
 &tlmm {
 
 	pcie_1_pin: pcie-1-state {
@@ -173,6 +185,10 @@
 	};
 };
 
+&usb3 {
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <24000000>;
 };
-- 
2.7.4

