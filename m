Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE3662B69B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiKPJdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiKPJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:33:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BEF25D1;
        Wed, 16 Nov 2022 01:33:42 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG5tRVP007337;
        Wed, 16 Nov 2022 09:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=nw66B9LNbqDj5SmgApOL3AqR2/tJYCQvQbYXi6fcGAc=;
 b=UZQCL49bV0txTZneGapgij4YjI6o8VKRvtszyhsCKINKEKgyqBE5kUUnNGaVO5/meGAJ
 PACW33VaSe8iJ1DhJp0lXovn4miF4qDglALHKW1uMYOef6g9ffyHBcXxhk+6ocqGpm9l
 DmFTMKKiGHHp+wjD433cSndzS6cs8GoY4XiXjrBwzb12c5wI1srXLWOummnGDbVcEfy6
 XRU+tpZaATPlGFV07IWelrQGBD2UddCX2I0Ru6AviY7QeNBmlBHm4iwLI6aQ+oMh7b52
 oA6h1DJno9CZWmiRkpygcDp8G0mMEnzWWzXPKY+SVcWPIvpt+NTKNsBPHXOKBsOSWAJj fA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kvt508kgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 09:33:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AG9XRKc006715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 09:33:27 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 16 Nov 2022 01:33:20 -0800
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
Subject: [PATCH v2] arm64: dts: qcom: sc7280: Remove unused sleep pin control nodes
Date:   Wed, 16 Nov 2022 15:03:04 +0530
Message-ID: <1668591184-21099-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: plkx8DxGqjsQB5fVCjO3-WOqBp6h9Wmr
X-Proofpoint-GUID: plkx8DxGqjsQB5fVCjO3-WOqBp6h9Wmr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused and redundant sleep pin control entries as they are
not referenced anywhere in sc7280 based platform's device tree variants.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
Chnges Since v1:
    -- Update subject prefixes and commit message.

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

