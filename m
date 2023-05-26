Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C0B71279A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbjEZNc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243722AbjEZNc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:32:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E5A194;
        Fri, 26 May 2023 06:32:34 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QBmEAf029350;
        Fri, 26 May 2023 13:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VSVVcA3UWTFx99cnnj2ecn2APXXTbw+x7Nd1w9DzUNU=;
 b=Btq4GyADrWK7cZIQKhsrnRh7c69G8x2mNUKH7q/l8jMzk1L3S1mPAAQYxM2UHeb1MS7u
 Qe7mJgrKNwGlbVDaUQjH1LPDSrVqQvzXAZGhkg04kp6UuMUb6RaLiYjYk3qTT42RcEDE
 PAQDOVz86nfjWhq4uB56qj/R0q6+o44lvJ+5luXqYM1kLMSpG86WtxSOmQi2QVxtiR76
 IpWxPUOmQosEVFoiGdMZXABiA9Ta68xAqv52OjoSMd+D18QZYjmhFOn9Q3PqAj7JsO4p
 jxwax8Uks8GegsBmZjgYwD4DPUtuFykZgRSJ3auR/eTR+PI/YoU06ifFomL+hawmb/Ya dQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtpsp8wk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 13:32:31 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QDWVk6006374
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 13:32:31 GMT
Received: from hu-shazhuss-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 06:32:27 -0700
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <konrad.dybcio@linaro.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 5/5] arm64: dts: qcom: sa8775p-ride: enable i2c11
Date:   Fri, 26 May 2023 19:01:21 +0530
Message-ID: <20230526133122.16443-6-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526133122.16443-1-quic_shazhuss@quicinc.com>
References: <20230526133122.16443-1-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AgdW1uKOA-wunjIC5mfJrgcF5h4JAaMe
X-Proofpoint-GUID: AgdW1uKOA-wunjIC5mfJrgcF5h4JAaMe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxlogscore=951
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the i2c11 node on sa8775p-ride board for A2B controller
and audio port expander.

Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 4c000a5cb3c4..ab767cfa51ff 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -19,6 +19,7 @@
 		serial0 = &uart10;
 		serial1 = &uart12;
 		serial2 = &uart17;
+		i2c11 = &i2c11;
 		i2c18 = &i2c18;
 		spi16 = &spi16;
 		ufshc1 = &ufs_mem_hc;
@@ -260,6 +261,13 @@
 	};
 };
 
+&i2c11 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&qup_i2c11_default>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &i2c18 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&qup_i2c18_default>;
@@ -370,6 +378,13 @@
 		bias-disable;
 	};
 
+	qup_i2c11_default: qup-i2c11-state {
+		pins = "gpio48", "gpio49";
+		function = "qup1_se4";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	qup_i2c18_default: qup-i2c18-state {
 		pins = "gpio95", "gpio96";
 		function = "qup2_se4";
-- 
2.17.1

