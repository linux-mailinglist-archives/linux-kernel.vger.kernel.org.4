Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2456296E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiKOLL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiKOLKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:10:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01EC6144;
        Tue, 15 Nov 2022 03:10:34 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF8EuhR011105;
        Tue, 15 Nov 2022 11:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ux+pIj4J8u2AB3oZXzjE6ixSJU2P58VaQgWwbDZxfqY=;
 b=YmfFwV4kTrItT9OQuORsfrtn2HnYC38oYElnwaLmrzOu+1vBTkMHhiEbPzY/vTphnuIw
 HqQWJ0zo/2V+6fczRfKBbkGqFeZVxhM0jYbFAne9QnAhwl/20FbuhUSyN+hO5Ae87NV2
 dKjr+mMJoV3jeJAMNrXoptE7ldKp3W/q4Ezy9nAfrwnwCC+iYfXdgxmhM/Po0wa+BP2b
 9FK67pPXujnOAmyW2tLdzptNKEYXt9+Fep7TGoD30h3D4EuY0iBDIq7JsyxC6VJPyur6
 vPq/IZimQnzGUF5jyRF8A+q3R8e6T0ldiGsDsiC5pYbMIkvcw7TiUy3f+9XSnko3Xul1 yw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kus8cjgcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 11:10:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AFBAL5h012826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 11:10:21 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 15 Nov 2022 03:10:13 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <vkoul@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <quic_rjendra@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mka@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH] arm64: dts: SC7280: Remove unused sleep pin control nodes
Date:   Tue, 15 Nov 2022 16:39:58 +0530
Message-ID: <1668510598-19535-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Uivtg_eFNELx7njJnO5dzKwbJ95UqyBL
X-Proofpoint-ORIG-GUID: Uivtg_eFNELx7njJnO5dzKwbJ95UqyBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_06,2022-11-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=958 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Unused and redundant sleep pin control entries
in herobrine device tree variants.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 .../qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi   |  8 -----
 .../dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi   | 20 -----------
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 20 -----------
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 40 ----------------------
 4 files changed, 88 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
index cf34334..1ca11a1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
@@ -148,10 +148,6 @@ hp_i2c: &i2c2 {
 	bias-disable;
 };
 
-&lpass_dmic01_clk_sleep {
-	drive-strength = <2>;
-};
-
 &lpass_dmic01_data {
 	bias-pull-down;
 };
@@ -161,10 +157,6 @@ hp_i2c: &i2c2 {
 	bias-disable;
 };
 
-&lpass_dmic23_clk_sleep {
-	drive-strength = <2>;
-};
-
 &lpass_dmic23_data {
 	bias-pull-down;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
index c72e53a..ae25520 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
@@ -167,10 +167,6 @@
 	bias-disable;
 };
 
-&lpass_dmic01_clk_sleep {
-	drive-strength = <2>;
-};
-
 &lpass_dmic01_data {
 	bias-pull-down;
 };
@@ -180,10 +176,6 @@
 	bias-disable;
 };
 
-&lpass_dmic23_clk_sleep {
-	drive-strength = <2>;
-};
-
 &lpass_dmic23_data {
 	bias-pull-down;
 };
@@ -194,30 +186,18 @@
 	bias-disable;
 };
 
-&lpass_rx_swr_clk_sleep {
-	bias-pull-down;
-};
-
 &lpass_rx_swr_data {
 	drive-strength = <2>;
 	slew-rate = <1>;
 	bias-bus-hold;
 };
 
-&lpass_rx_swr_data_sleep {
-	bias-pull-down;
-};
-
 &lpass_tx_swr_clk {
 	drive-strength = <2>;
 	slew-rate = <1>;
 	bias-disable;
 };
 
-&lpass_tx_swr_clk_sleep {
-	bias-pull-down;
-};
-
 &lpass_tx_swr_data {
 	drive-strength = <2>;
 	slew-rate = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 8ca2281..f7efb99 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -576,10 +576,6 @@
 	bias-disable;
 };
 
-&lpass_dmic01_clk_sleep {
-	drive-strength = <2>;
-};
-
 &lpass_dmic01_data {
 	bias-pull-down;
 };
@@ -589,10 +585,6 @@
 	bias-disable;
 };
 
-&lpass_dmic23_clk_sleep {
-	drive-strength = <2>;
-};
-
 &lpass_dmic23_data {
 	bias-pull-down;
 };
@@ -603,30 +595,18 @@
 	bias-disable;
 };
 
-&lpass_rx_swr_clk_sleep {
-	bias-pull-down;
-};
-
 &lpass_rx_swr_data {
 	drive-strength = <2>;
 	slew-rate = <1>;
 	bias-bus-hold;
 };
 
-&lpass_rx_swr_data_sleep {
-	bias-pull-down;
-};
-
 &lpass_tx_swr_clk {
 	drive-strength = <2>;
 	slew-rate = <1>;
 	bias-disable;
 };
 
-&lpass_tx_swr_clk_sleep {
-	bias-pull-down;
-};
-
 &lpass_tx_swr_data {
 	drive-strength = <2>;
 	slew-rate = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 448879d..4970864 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2483,80 +2483,40 @@
 				function = "dmic1_clk";
 			};
 
-			lpass_dmic01_clk_sleep: dmic01-clk-sleep-state {
-				pins = "gpio6";
-				function = "dmic1_clk";
-			};
-
 			lpass_dmic01_data: dmic01-data-state {
 				pins = "gpio7";
 				function = "dmic1_data";
 			};
 
-			lpass_dmic01_data_sleep: dmic01-data-sleep-state {
-				pins = "gpio7";
-				function = "dmic1_data";
-			};
-
 			lpass_dmic23_clk: dmic23-clk-state {
 				pins = "gpio8";
 				function = "dmic2_clk";
 			};
 
-			lpass_dmic23_clk_sleep: dmic23-clk-sleep-state {
-				pins = "gpio8";
-				function = "dmic2_clk";
-			};
-
 			lpass_dmic23_data: dmic23-data-state {
 				pins = "gpio9";
 				function = "dmic2_data";
 			};
 
-			lpass_dmic23_data_sleep: dmic23-data-sleep-state {
-				pins = "gpio9";
-				function = "dmic2_data";
-			};
-
 			lpass_rx_swr_clk: rx-swr-clk-state {
 				pins = "gpio3";
 				function = "swr_rx_clk";
 			};
 
-			lpass_rx_swr_clk_sleep: rx-swr-clk-sleep-state {
-				pins = "gpio3";
-				function = "swr_rx_clk";
-			};
-
 			lpass_rx_swr_data: rx-swr-data-state {
 				pins = "gpio4", "gpio5";
 				function = "swr_rx_data";
 			};
 
-			lpass_rx_swr_data_sleep: rx-swr-data-sleep-state {
-				pins = "gpio4", "gpio5";
-				function = "swr_rx_data";
-			};
-
 			lpass_tx_swr_clk: tx-swr-clk-state {
 				pins = "gpio0";
 				function = "swr_tx_clk";
 			};
 
-			lpass_tx_swr_clk_sleep: tx-swr-clk-sleep-state {
-				pins = "gpio0";
-				function = "swr_tx_clk";
-			};
-
 			lpass_tx_swr_data: tx-swr-data-state {
 				pins = "gpio1", "gpio2", "gpio14";
 				function = "swr_tx_data";
 			};
-
-			lpass_tx_swr_data_sleep: tx-swr-data-sleep-state {
-				pins = "gpio1", "gpio2", "gpio14";
-				function = "swr_tx_data";
-			};
 		};
 
 		gpu: gpu@3d00000 {
-- 
2.7.4

