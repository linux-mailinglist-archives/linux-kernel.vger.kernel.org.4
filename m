Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB7A6C2D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCUI6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjCUI6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:58:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876B18A4F;
        Tue, 21 Mar 2023 01:56:43 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L6GYJc026631;
        Tue, 21 Mar 2023 08:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8GfmwM+Ld4SniaKlRdRLeMoHyqiSWdMDLgeYkQditrE=;
 b=DNbGTGJHk1KhQYJX4HZgWRuGlYqrqVs8G8VAttTxO485nMz0ctKG+SakPEy5QFuFp0hJ
 LfUwQeZC6Lss67TC6MzgYHsmWpuEE8HLrCgb8+xifO4rFjZPd8PBu2+fBanc8qMsmY7F
 k/WNoc5cNNAKRTYhPylcg5ixLtAK7JboMqeZEJcQCpDlvmaAXvBjKC6lfw9A8/oiQTWI
 927PqHSJ05silBHS/2f4m8USUTDTYwLMhnu4HwDZYkkJSjqfxz8MLSn5pkNc9oi3q1qX
 9YrOQSd/9Gf+hPTfRuD/Oc7tg3NdQfEVbudyVZII8tPF0zxGTmwNMwSpcjSenoxzD9tZ cw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3perc3agr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 08:55:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32L8tuI7002715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 08:55:56 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Mar 2023 01:55:51 -0700
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
Subject: [PATCH v2 8/8] arm64: dts: qcom: ipq9574: Enable USB
Date:   Tue, 21 Mar 2023 14:24:26 +0530
Message-ID: <3ba630fdf4c3e8d66910cb2c3990725795be66a6.1679388632.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1679388632.git.quic_varada@quicinc.com>
References: <cover.1677749625.git.quic_varada@quicinc.com> <cover.1679388632.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L9Xl1lj-siaETbqoCrwLG-m81T6oL3pN
X-Proofpoint-ORIG-GUID: L9Xl1lj-siaETbqoCrwLG-m81T6oL3pN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_06,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=953
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn on USB related nodes

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

---
 Changes in v2:
	- Fix node placement and coding style
	- "ok" -> "okay"
---
 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
index 8a6caae..d0d18e5 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
@@ -57,6 +57,10 @@
 	status = "okay";
 };
 
+&qusb_phy_0 {
+	status = "okay";
+};
+
 &rpm_requests {
 	regulators {
 		compatible = "qcom,rpm-mp5496-regulators";
@@ -84,6 +88,10 @@
 	clock-frequency = <32000>;
 };
 
+&ssphy_0 {
+	status = "okay";
+};
+
 &tlmm {
 	sdc_default_state: sdc-default-state {
 		clk-pins {
@@ -118,6 +126,10 @@
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

