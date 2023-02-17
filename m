Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AAA69ADEC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBQOVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjBQOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:21:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761B6C00B;
        Fri, 17 Feb 2023 06:21:27 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HAPdMR005954;
        Fri, 17 Feb 2023 14:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=d+3ac4bmVhBFN8G4VXfF3+9hoCNEBlInf57L6+vTdFE=;
 b=hlujN1gAOYO5mLQKjHuBM4akfzGaVO3qhGndmQNvNRR0r+niOJ49h/rdgat2VH+AcKjM
 0cEvw5Hru0yqkDjDJOH5Q8rdoyrjkDihvLZno5z0C76yvti2XQfQpeFdmFfeocgBvWfC
 MLvQV+34WrK32x8dJ67f3BO9t34yOhXCJxzVYoRZMnzzr33ZgVtbSn2Wai8u3NgbmMLZ
 V6M7VMJsNeamJq4l0aiJIa+hSmyYE6bppP2DrwtV1lfhYsvKYrfCId3liYwFOeW5ByAn
 LLySsJ/gFTKoksDhyWn54y8JGRSOMwPZtRwgMsUPaVlXD/HmAjensTBBSbkmmEOjnxBQ sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt5kurshb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:21:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HELIbH016545
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:21:18 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 06:21:12 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
Subject: [PATCH V2 5/6] arm64: dts: qcom: ipq9574: Add RPM related nodes
Date:   Fri, 17 Feb 2023 19:50:29 +0530
Message-ID: <20230217142030.16012-6-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230217142030.16012-1-quic_devipriy@quicinc.com>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WX0OXenROOkgcD37HACQIQoxMxPKsBaZ
X-Proofpoint-ORIG-GUID: WX0OXenROOkgcD37HACQIQoxMxPKsBaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_09,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxlogscore=947 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPM Glink, RPM message RAM and SMPA1 regulator
nodes to support frequency scaling on IPQ9574

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V2:
	- Splitted the RPM and CPU Freq changes to individual patches
	- Moved the regulators node to Board DT
	- Dropped the regulator-always-on property
	- Updated the compatible in regulators node with the existing
	  mp5496 compatible

 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts | 11 +++++++++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
index 21b53f34ce84..8a6caaeb0c4b 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
@@ -57,6 +57,17 @@
 	status = "okay";
 };
 
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-mp5496-regulators";
+
+		ipq9574_s1: s1 {
+			regulator-min-microvolt = <587500>;
+			regulator-max-microvolt = <1075000>;
+		};
+	};
+};
+
 &sdhc_1 {
 	pinctrl-0 = <&sdc_default_state>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index d20f3c7383f5..2f300cbab93e 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -133,6 +133,11 @@
 		#size-cells = <2>;
 		ranges;
 
+		rpm_msg_ram: rpm@60000 {
+			reg = <0x0 0x00060000 0x0 0x6000>;
+			no-map;
+		};
+
 		tz_region: tz@4a600000 {
 			reg = <0x0 0x4a600000 0x0 0x400000>;
 			no-map;
@@ -768,6 +773,18 @@
 		};
 	};
 
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		mboxes = <&apcs_glb 0>;
+
+		rpm_requests: glink-channel {
+			compatible = "qcom,rpm-ipq9574";
+			qcom,glink-channels = "rpm_requests";
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.17.1

