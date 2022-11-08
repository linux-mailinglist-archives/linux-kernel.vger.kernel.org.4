Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63704621740
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiKHOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiKHOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:47:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6311A00;
        Tue,  8 Nov 2022 06:47:05 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8E366u016290;
        Tue, 8 Nov 2022 14:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=9oo/c7vbak5qvm3xU8HIY45Y3ri83dVLbjW4JEiXagQ=;
 b=J4z3cGMvgOXLV4fmE5hfCE9cjSFxX3T1w9gV7iyDcbHE0fIjOSbB0vCDDkWIsIW2zHwP
 c+7n13rDA/3aQjDSKKig0vCCdzBTE4vE0cbeMTffPxk39PBXEmCkVfvGwzF2Zv4UW9la
 FmfiBo+YEZBxPK5RcjUVv4oly+YkV3lMFRksnw6vnj1HEe1BkTnWisVQiqCoud0nv+Hf
 JQyHTQh3EfHgErhaHSuUwwx+xEEOq5+581E+aHoPvmN5HiUSO6bovPgSTRGDSX8wpZhb
 Y6PFvnvX5IUJk0tadSO5yXDUDgCijqorONAn8kA3RQupNZaout17NUEUDL0LqvpIC8wd 2Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhmgh6ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 14:46:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8EkpGl008093
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 14:46:51 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 8 Nov 2022 06:46:45 -0800
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
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Ratna Deepthi Kudaravalli" <quic_rkudarav@quicinc.com>
Subject: [PATCH v6 1/4] arm64: dts: qcom: Update soundwire secondary node names
Date:   Tue, 8 Nov 2022 20:16:00 +0530
Message-ID: <1667918763-32445-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667918763-32445-1-git-send-email-quic_srivasam@quicinc.com>
References: <1667918763-32445-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D4dfnVhg_fY1HgW6_oSFVTq-LMDcLUls
X-Proofpoint-ORIG-GUID: D4dfnVhg_fY1HgW6_oSFVTq-LMDcLUls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update soundwire secondary nodes of WSA speaker to match with
dt-bindings pattern properties regular expression.

This modification is required to avoid dtbs-check errors
occurred with qcom,soundwire.yaml.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts             | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts           | 4 ++--
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 4 ++--
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts     | 4 ++--
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts              | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 2c08500..4c39cec 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1007,7 +1007,7 @@
 };
 
 &swr0 {
-	left_spkr: wsa8810-left {
+	left_spkr: speaker@0,3 {
 		compatible = "sdw10217211000";
 		reg = <0 3>;
 		powerdown-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
@@ -1016,7 +1016,7 @@
 		#sound-dai-cells = <0>;
 	};
 
-	right_spkr: wsa8810-right {
+	right_spkr: speaker@0,4 {
 		compatible = "sdw10217211000";
 		reg = <0 4>;
 		powerdown-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 8ba3188..df61526 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -1091,7 +1091,7 @@
 	vdd-io-supply = <&vreg_s4a_1p8>;
 
 	swm: swm@c85 {
-		left_spkr: wsa8810-left {
+		left_spkr: speaker@0,1 {
 			compatible = "sdw10217201000";
 			reg = <0 1>;
 			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
@@ -1100,7 +1100,7 @@
 			#sound-dai-cells = <0>;
 		};
 
-		right_spkr: wsa8810-right {
+		right_spkr: speaker@0,2 {
 			compatible = "sdw10217201000";
 			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
 			reg = <0 2>;
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 0c375ec..f32b744 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -785,7 +785,7 @@
 	qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
 
 	swm: swm@c85 {
-		left_spkr: wsa8810-left {
+		left_spkr: speaker@0,3 {
 			compatible = "sdw10217211000";
 			reg = <0 3>;
 			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
@@ -794,7 +794,7 @@
 			#sound-dai-cells = <0>;
 		};
 
-		right_spkr: wsa8810-right {
+		right_spkr: speaker@0,4 {
 			compatible = "sdw10217211000";
 			powerdown-gpios = <&wcdgpio 2 GPIO_ACTIVE_HIGH>;
 			reg = <0 4>;
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index f93d748..aa06a4a 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -717,7 +717,7 @@
 	qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
 
 	swm: swm@c85 {
-		left_spkr: wsa8810-left {
+		left_spkr: speaker@0,3 {
 			compatible = "sdw10217211000";
 			reg = <0 3>;
 			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
@@ -726,7 +726,7 @@
 			#sound-dai-cells = <0>;
 		};
 
-		right_spkr: wsa8810-right {
+		right_spkr: speaker@0,4 {
 			compatible = "sdw10217211000";
 			powerdown-gpios = <&wcdgpio 2 GPIO_ACTIVE_HIGH>;
 			reg = <0 4>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 9db6136..532a77f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -757,7 +757,7 @@
 };
 
 &swr0 {
-	left_spkr: wsa8810-right@0,3{
+	left_spkr: speaker@0,3 {
 		compatible = "sdw10217211000";
 		reg = <0 3>;
 		powerdown-gpios = <&tlmm 26 GPIO_ACTIVE_HIGH>;
@@ -766,7 +766,7 @@
 		#sound-dai-cells = <0>;
 	};
 
-	right_spkr: wsa8810-left@0,4{
+	right_spkr: speaker@0,4 {
 		compatible = "sdw10217211000";
 		reg = <0 4>;
 		powerdown-gpios = <&tlmm 127 GPIO_ACTIVE_HIGH>;
-- 
2.7.4

