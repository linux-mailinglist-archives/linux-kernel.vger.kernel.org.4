Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84140750636
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjGLLgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjGLLgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:36:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77D08F;
        Wed, 12 Jul 2023 04:36:40 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C9MJXc018622;
        Wed, 12 Jul 2023 11:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+5ll8N5nisOelq+O5c28bK5meH5+cr1mfj4UoH6tXAw=;
 b=PEtQDn9rYi3qKFJ3NxbuE4bU0sPIjNCgtg+MT828G46+OkEC7kwS00h9NY/LotcYdPph
 sa2gxLBrh9drTBemNhtbwrGo3H3Yxj4kbsztvSTLXnucrhv5C2O7gNkoUoAzJBxvmfRM
 hlbDAVBKJ9D9Y9E7yaFFFTrNlVndFuRRoY96EQ2kfuNeAODCcli6dLaUBWNQFNY/n3YO
 oI7KaYO4qXBxzj283hB8PiYBHkwoFp5Q6uahrHPxYxlzOJ2EngAE/wQ5MXkxzZbAGmjI
 X1UJGotEIg0tKh17nNOCd5fPBXw2QJSdRQf1vT67J0tbYBz8XtZbO2fmV+TVBCxjMCdb zw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rser0scc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:36:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CBaWpl007983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:36:32 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 04:36:12 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH v2 3/5] arm64: dts: qcom: ipq5332: Add tsens node
Date:   Wed, 12 Jul 2023 17:05:37 +0530
Message-ID: <20230712113539.4029941-4-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
References: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mRJ593EmXTnqxdu5xLYW48zdpZxQvTk0
X-Proofpoint-ORIG-GUID: mRJ593EmXTnqxdu5xLYW48zdpZxQvTk0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=720
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
node with nvmem cells for calibration data.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
[v2]:
	Included qfprom nodes only for available sensors and removed
	the offset suffix.

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 8bfc2db44624..0eef77e36609 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -150,6 +150,46 @@ qfprom: efuse@a4000 {
 			reg = <0x000a4000 0x721>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			tsens_mode: mode@3e1 {
+				reg = <0x3e1 0x1>;
+				bits = <0 3>;
+			};
+
+			tsens_base0: base0@3e1 {
+				reg = <0x3e1 0x2>;
+				bits = <3 10>;
+			};
+
+			tsens_base1: base1@3e2 {
+				reg = <0x3e2 0x2>;
+				bits = <5 10>;
+			};
+
+			s11: s11@3a5 {
+				reg = <0x3a5 0x1>;
+				bits = <4 4>;
+			};
+
+			s12: s12@3a6 {
+				reg = <0x3a6 0x1>;
+				bits = <0 4>;
+			};
+
+			s13: s13@3a6 {
+				reg = <0x3a6 0x1>;
+				bits = <4 4>;
+			};
+
+			s14: s14@3ad {
+				reg = <0x3ad 0x2>;
+				bits = <7 4>;
+			};
+
+			s15: s15@3ae {
+				reg = <0x3ae 0x1>;
+				bits = <3 4>;
+			};
 		};
 
 		rng: rng@e3000 {
@@ -159,6 +199,32 @@ rng: rng@e3000 {
 			clock-names = "core";
 		};
 
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq5332-tsens";
+			reg = <0x4a9000 0x1000>,
+			      <0x4a8000 0x1000>;
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base0>,
+				      <&tsens_base1>,
+				      <&s11>,
+				      <&s12>,
+				      <&s13>,
+				      <&s14>,
+				      <&s15>;
+			nvmem-cell-names = "mode",
+					   "base0",
+					   "base1",
+					   "s11",
+					   "s12",
+					   "s13",
+					   "s14",
+					   "s15";
+			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "combined";
+			#qcom,sensors = <5>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5332-tlmm";
 			reg = <0x01000000 0x300000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

