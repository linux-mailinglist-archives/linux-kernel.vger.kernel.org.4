Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E416DAFF5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjDGP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjDGP6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:58:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF446EB8;
        Fri,  7 Apr 2023 08:58:07 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337EMlO2029818;
        Fri, 7 Apr 2023 15:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=J/PAJLZyHK4/8iCjH7cAWkmm0zmFPNYmpA8/KQydMpY=;
 b=Nz/7V28xR9k6xsRfcoFwSkS4Ci/zRJro6CpYezx5rNBfebWp+aYwqXP/kqApmAHDd+Mq
 FZS+5V5DrwhULJzeKAl/623rA0gGhf5bFLUG2sBap65dUTdfuc/S5ntj84hjjUwu0G7I
 eK7+YgIBL0zFgBmcLfvgI3LbDhL2dxC83cRAnPRnc9wkC6sItMfJm/9xGV8KYk1fXuxb
 kmDCQ5Jx6d6PACugpeCWp/bNvlyYp72p2NgjIV4ko1m1XdcZb0QB9mJlykp6UBZz15oq
 9wHc4Gd2lfcP2nXtZpBLurpjSRKJ1F0bwTr31R6XrpqpOsgbwSmL47K0eju5IOdA2ZAB tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptmvq87js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 15:58:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337Fw2Y2029906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 15:58:02 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 08:57:57 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH V4 3/5] arm64: dts: qcom: ipq9574: Add RPM related nodes
Date:   Fri, 7 Apr 2023 21:27:25 +0530
Message-ID: <20230407155727.20615-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230407155727.20615-1-quic_devipriy@quicinc.com>
References: <20230407155727.20615-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XJK3O_Qyt7PyK23Zw1A2HEHCklUKGrme
X-Proofpoint-ORIG-GUID: XJK3O_Qyt7PyK23Zw1A2HEHCklUKGrme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=835 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070146
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 Changes in V4:
	- Picked up the R-b tag

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7c820463a79d..1f9b7529e7ed 100644
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
 		pcie0_phy: phy@84000 {
 			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
 			reg = <0x00084000 0x1000>;
-- 
2.17.1

