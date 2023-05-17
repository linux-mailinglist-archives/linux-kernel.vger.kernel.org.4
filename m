Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08EA706F57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjEQR0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEQR0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:26:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4116AD32;
        Wed, 17 May 2023 10:26:00 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HCMd3d000598;
        Wed, 17 May 2023 17:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ys2fXjZ24AvMfPFDJDm3810C1FynvBCTYKTwEZncifs=;
 b=Gi0uHnxyRvqL0MtAF4Ze5B1XLW8RPzlNVdKLaklP6sHjx1fycwPl1RQGY8movHc2tBwJ
 S3DK6XYegBBLOf8BrERGXoIJ2/HvUXaog/fH3SNDMys2Qdi8jblnGhEp/BhMJSJHF/Uh
 jK4rOpXMEf0uBdB3w2m49UQ+SGuXPjrUoAJjUs+Bp8E8LLN4DXQUe6Z8lZjXnNgUZPZP
 JARpW6ZmhsfH+qVdbHYDzJC+vCPB75tUfbGSkXh/JPFOi2n40I/arRRi06fCpohOM4RB
 4PHxN1yxVq8S96iwmylM2/Y7YyTXpwCyfrD0NWnTnjR9bjzuLypab+on7yuIbGyqGCM7 gw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmcc62xg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 17:25:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HHPn7W024609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 17:25:49 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 10:25:45 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
Subject: [PATCH V5 1/3] arm64: dts: qcom: ipq9574: Add RPM related nodes
Date:   Wed, 17 May 2023 22:55:25 +0530
Message-ID: <20230517172527.1968-2-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230517172527.1968-1-quic_devipriy@quicinc.com>
References: <20230517172527.1968-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t9iYCLWP8lLly2y9RnOsgfHBtQu_pR1L
X-Proofpoint-ORIG-GUID: t9iYCLWP8lLly2y9RnOsgfHBtQu_pR1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=861 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPM Glink & RPM message RAM nodes to support frequency scaling
on IPQ9574.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V5:
	- No change

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index adc3fefcb469..31244b1d8c25 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -110,12 +110,29 @@
 		};
 	};
 
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		mboxes = <&apcs_glb 0>;
+
+		rpm_requests: rpm-requests {
+			compatible = "qcom,rpm-ipq9574";
+			qcom,glink-channels = "rpm_requests";
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		rpm_msg_ram: sram@60000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x00060000 0x6000>;
+		};
+
 		rng: rng@e3000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x000e3000 0x1000>;
-- 
2.17.1

