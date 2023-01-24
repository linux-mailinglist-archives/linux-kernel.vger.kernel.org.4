Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05DF67A1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjAXSpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjAXSo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:44:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062AC3ABD;
        Tue, 24 Jan 2023 10:44:58 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OFDxYl030407;
        Tue, 24 Jan 2023 18:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=an6GQ7C4x8r1owOs4PWQW974MIIzzFEe9T+hV8d3vd0=;
 b=ftJrR9MnAI3cjWYuXAvyz4iMIRVJiDhyCgLJqosP/WP3P/RsqaAIh38snMOLgkyqiWVp
 wb0dSRTXy/8ilQDAnfMoOKrQnXc/3TqblWZeFO0wWlG5fdpPM2vQYwLJyh9KqSB7cYrY
 z/lZUI/DA0vjyGCz/Hep3tbqubQNUc1FYiXN4tRnTsZPxt8kO7+rdoTvCRI8hXYbAFUR
 38a6QszHqhJWKHMshrdZSRBrAowLMmWcMOi9WPwYDQd0MpX4ymMTgI0cnHh4fV3blv7c
 z1onsJshGA9t3r7gWvGlsO2Cv7phgprWWOYSo5Uwvw8hS9dWFammvJUrnuzbcu8z+Kmb Jw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89dr5n9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 18:44:48 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30OIildc013441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 18:44:47 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 10:44:47 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sa8295p-adp: Add max20411 on i2c12
Date:   Tue, 24 Jan 2023 10:44:40 -0800
Message-ID: <20230124184440.1421074-4-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124184440.1421074-1-quic_bjorande@quicinc.com>
References: <20230124184440.1421074-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2IjXJ8kt_I3qudQasyWyp_hAF0BYR0Vw
X-Proofpoint-ORIG-GUID: 2IjXJ8kt_I3qudQasyWyp_hAF0BYR0Vw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=945 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240171
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

The SA8295P ADP has a Maxim max20411 step-down converter on i2c12.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- i2c node had changed name

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index bb4270e8f551..642000d95812 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -266,6 +266,27 @@ &dispcc1 {
 	status = "okay";
 };
 
+&i2c12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c12_state>;
+
+	status = "okay";
+
+	vdd_gfx: regulator@39 {
+		compatible = "maxim,max20411";
+		reg = <0x39>;
+
+		regulator-name = "vdd_gfx";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <968750>;
+
+		enable-gpios = <&pmm8540a_gpios 2 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_gfx_enable_state>;
+	};
+};
+
 &mdss0 {
 	status = "okay";
 };
@@ -476,6 +497,10 @@ &pcie4_phy {
 	status = "okay";
 };
 
+&qup1 {
+	status = "okay";
+};
+
 &qup2 {
 	status = "okay";
 };
@@ -636,7 +661,23 @@ &xo_board_clk {
 
 /* PINCTRL */
 
+&pmm8540a_gpios {
+	vdd_gfx_enable_state: vdd-gfx-enable-state {
+		pins = "gpio2";
+		function = "normal";
+		output-enable;
+	};
+};
+
 &tlmm {
+	i2c12_state: i2c12-state {
+		pins = "gpio0", "gpio1";
+		function = "qup12";
+
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	pcie2a_default: pcie2a-default-state {
 		clkreq-n-pins {
 			pins = "gpio142";
-- 
2.25.1

