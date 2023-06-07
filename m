Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67315725C0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbjFGKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbjFGKuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:50:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A501FDA;
        Wed,  7 Jun 2023 03:49:53 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3575r88w011164;
        Wed, 7 Jun 2023 10:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=9xYUqSDdaqKyZf2bkU9l323N2VvyCRyqyZVBZ3mBeks=;
 b=AbeCaNmk2clh7Sa7DsGozlD0a/USTwTBXfHDNGgmhBJG2F/pbxW4DKkCzl4b415GdL4N
 KDqPdWpJprLf6K9EC+g9fUoAf7hRI4WJYA1M8KOqkkDfGrh/V87D1N7Xfqjkw1k/VGnC
 MdP6sU470zF1eruPPcaY37t+JJ5V6nYKp2xAaovsqJdKG7AhEkAk8LbQiOqJK1epzK/f
 nE80iMDaOUwrQwVUWexnOGxshTIftHgNrZp7jE1PUIRiepXv4+MkJdGtAIm7AG4UcCne
 zMOFXSxctzjKqUmVEqRvR9j1bTiE0oe5EAT82R6IvEqfoZq4PJ39/PjJQsu7ERjF9NqV Iw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a9t9kmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 10:49:23 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357AnMFo024651
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 10:49:22 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 03:49:16 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v12 5/5] arm64: dts: qcom: ipq9574: Enable USB
Date:   Wed, 7 Jun 2023 16:18:43 +0530
Message-ID: <d8573819ba32497360d1c520539952d01b9e18f2.1686045347.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1686045347.git.quic_varada@quicinc.com>
References: <cover.1686045347.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i0NiyGlRPPbQ8xkm5OEECJ15kRObNNrf
X-Proofpoint-GUID: i0NiyGlRPPbQ8xkm5OEECJ15kRObNNrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=680 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn on USB related nodes
Provide vdd info

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Changes in v11:
	- Rename dwc_0 -> usb_0_dwc3
	- Maintain sorted order for the usb nodes

 Changes in v10:
	- Provide vdd info

 Changes in v5:
	- Move "host" mode specification to board dts
	- Due to dependency with earlier patches board dts
	  filename changed ipq9574-al02-c7.dts -> ipq9574-rdp433.dts

 Changes in v2:
	- Fix node placement and coding style
	- "ok" -> "okay"
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 42d45e1..58e937c 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -105,6 +105,29 @@
 	};
 };
 
+&usb_0_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_0_qmpphy {
+	vdda-pll-supply = <&mp5496_l2>;
+	vdda-phy-supply = <&fixed_0p925>;
+
+	status = "okay";
+};
+
+&usb_0_qusbphy {
+	vdd-supply = <&fixed_0p925>;
+	vdda-pll-supply = <&mp5496_l2>;
+	vdda-phy-dpdm-supply = <&fixed_3p3>;
+
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <24000000>;
 };
-- 
2.7.4

