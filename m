Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27706EDAC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjDYDk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjDYDk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:40:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7697AA8;
        Mon, 24 Apr 2023 20:40:25 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P3Pj6A000756;
        Tue, 25 Apr 2023 03:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ZLYPvSeQr3Tg2IaIDunQUSVRvAmXPI3fsbmQUToA1V8=;
 b=MEmToFlqHwZglNNDqUJGdOcgy3ORrx3xKyP2zYNj3SEJ0K2+u5LQUOAWOqt0y8Mdh0yq
 vOpFFvJBqUrM2cpwPrR9X+P1cBe8EPpXVsNe4AIORQPfX+cu+naikqQDphiNsZi2zVJO
 CcrweNUXQV5DgEMrKHDxXsL6s8UbxuLoHwYeUXwuBTvr6zXOLrLPrmZFhczOK6VTybDJ
 9SBjLqxNNZMz99xyyG8jB/fnqQWTygNUWMZt+1E0qoXPdCe6Iu/G/fZLb8ngywRglf2z
 EeYYVUJ756/Yeg4sbZBD20rU6Llm/JXrcfAgJsC9A7DhGpy0tutldluPoE2rjurr4NkZ YQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5uwj1d7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 03:40:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33P3eI0J028539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 03:40:18 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 24 Apr 2023 20:40:17 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] arm64: dts: qcom: sc8280xp-x13s: Add QMP to SuperSpeed graph
Date:   Mon, 24 Apr 2023 20:40:10 -0700
Message-ID: <20230425034010.3789376-8-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fqcO8NGRT-IF1vzzOgL8aH3iBx-f8XFL
X-Proofpoint-GUID: fqcO8NGRT-IF1vzzOgL8aH3iBx-f8XFL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250032
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the CRD, connect the two QMP phys inbetween the USB Type-C
connectors and the DisplayPort controller, to handle orientation
switching.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 5ef3f4c07d75..382f27946468 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -106,7 +106,7 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_con0_ss: endpoint {
-						remote-endpoint = <&mdss0_dp0_out>;
+						remote-endpoint = <&usb_0_qmpphy_out>;
 					};
 				};
 
@@ -141,7 +141,7 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_con1_ss: endpoint {
-						remote-endpoint = <&mdss0_dp1_out>;
+						remote-endpoint = <&usb_1_qmpphy_out>;
 					};
 				};
 
@@ -554,7 +554,7 @@ &mdss0_dp0 {
 
 &mdss0_dp0_out {
 	data-lanes = <0 1>;
-	remote-endpoint = <&pmic_glink_con0_ss>;
+	remote-endpoint = <&usb_0_qmpphy_dp_in>;
 };
 
 &mdss0_dp1 {
@@ -563,7 +563,7 @@ &mdss0_dp1 {
 
 &mdss0_dp1_out {
 	data-lanes = <0 1>;
-	remote-endpoint = <&pmic_glink_con1_ss>;
+	remote-endpoint = <&usb_1_qmpphy_dp_in>;
 };
 
 &mdss0_dp3 {
@@ -1140,9 +1140,19 @@ &usb_0_qmpphy {
 	vdda-phy-supply = <&vreg_l9d>;
 	vdda-pll-supply = <&vreg_l4d>;
 
+	orientation-switch;
+
 	status = "okay";
 };
 
+&usb_0_qmpphy_dp_in {
+	remote-endpoint = <&mdss0_dp0_out>;
+};
+
+&usb_0_qmpphy_out {
+	remote-endpoint = <&pmic_glink_con0_ss>;
+};
+
 &usb_0_role_switch {
 	remote-endpoint = <&pmic_glink_con0_hs>;
 };
@@ -1167,9 +1177,19 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l4b>;
 	vdda-pll-supply = <&vreg_l3b>;
 
+	orientation-switch;
+
 	status = "okay";
 };
 
+&usb_1_qmpphy_dp_in {
+	remote-endpoint = <&mdss0_dp1_out>;
+};
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_con1_ss>;
+};
+
 &usb_1_role_switch {
 	remote-endpoint = <&pmic_glink_con1_hs>;
 };
-- 
2.39.2

