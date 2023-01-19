Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD70674594
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjASWLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjASWK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:10:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C24EDB784;
        Thu, 19 Jan 2023 13:48:05 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JFcsWK014949;
        Thu, 19 Jan 2023 21:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=HXXCRVF2FwY71rw98hwl77+52Lu2DXlFUJQMFapEEcw=;
 b=MunURtuaLBBQyFPCe4Zys3R8SVa5fvz16FcqB5k4w5RXlANzBs5R59Medcgb7LoS9cct
 a03NO+ETAyGyi1pvKgGBXm0NVYZc+6Xupexz1NsRc0BeWlZQ7oyQLPzE+ZtCOnCP9PR9
 KWTyaBxx69sSky6+xbaCfvDoiwW2SRMRLufN+UNLZR0isw9iKpCB5cDDfGYR+SC4vfL2
 XXcVCyNqPVSLtmZ6FpnkACFBMpigW7OI1Io5oH3oDZDDMLxHYAw5F+OKKUKCfB1ph2HM
 l2QAevuNwPlyBsv0et20LWzZ/7wyUgs8mNgcEOg06oIxKK/f9q5jrHB7W+jfbu06PdXz 9w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n75w3h63m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:47:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JLlupr012619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:47:56 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 13:47:55 -0800
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
Subject: [PATCH 4/4] arm64: dts: qcom: sa8295p-adp: Add max20411 on i2c4
Date:   Thu, 19 Jan 2023 13:47:49 -0800
Message-ID: <20230119214749.4048933-5-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119214749.4048933-1-quic_bjorande@quicinc.com>
References: <20230119214749.4048933-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RsohjFyHt0Bl2LQ85x3OS_dgJPh2oqko
X-Proofpoint-GUID: RsohjFyHt0Bl2LQ85x3OS_dgJPh2oqko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=936
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

The SA8295P ADP has a Maxim max20411 step-down converter on i2c4.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 80cb18d9e481..cdb296569d46 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -476,6 +476,31 @@ &pcie4_phy {
 	status = "okay";
 };
 
+&qup1 {
+	status = "okay";
+};
+
+&qup1_i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup1_i2c4_state>;
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
 &qup2 {
 	status = "okay";
 };
@@ -636,6 +661,14 @@ &xo_board_clk {
 
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
 	pcie2a_default: pcie2a-default-state {
 		clkreq-n-pins {
@@ -728,4 +761,12 @@ wake-n-pins {
 			bias-pull-up;
 		};
 	};
+
+	qup1_i2c4_state: qup1-i2c4-state {
+		pins = "gpio0", "gpio1";
+		function = "qup12";
+
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
-- 
2.37.3

