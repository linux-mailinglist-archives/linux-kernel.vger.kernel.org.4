Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1C6D8FFF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjDFHCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjDFHCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:02:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C18D9EFB;
        Thu,  6 Apr 2023 00:01:15 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3365hpZF031840;
        Thu, 6 Apr 2023 07:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=MJTnvT4dZT7GqFxblF5CDsTiIHcOdefKF4YqXGgrW7g=;
 b=nQswFuCKiImZCG0v8r8iz9s7kV+9DtHlPjbp/ZWwLVWZcMEaeVhwRNjNGm05046u/v96
 poYXhJtODwCYqaOgZphaG9ctWsNxo4UT9aE3e8yi1sryv72GAPNn3EE5Nx/HuMo9yTfv
 xBydzios7oWeWXHAWvHzY+nZ3fDknocWJG5/chUPOQLBlv9cNmbBVGOY83SMPCrREvmv
 Qg9f9zogDTmJTkRfGg73VkQMgrpDnhzwyYIzRXxroba3/+DGpZbcFOLf8UOXfx9nvrYU
 0VFu7J1bIfyr4O5PDo0BKsyS4lFc0c9LeDzbVdWdCZqo52WwHqjvB9h0hQnV2EVVcJqk FA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psgehh24j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 07:01:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 336719C6028669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 07:01:09 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 6 Apr 2023 00:01:03 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 3/5] arm64: dts: qcom: ipq9574: Add RPM related nodes
Date:   Thu, 6 Apr 2023 12:30:30 +0530
Message-ID: <20230406070032.22243-4-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406070032.22243-1-quic_devipriy@quicinc.com>
References: <20230406070032.22243-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y0jwOiC_nEFHOKj7D8Tg1Xrz0ZzsIrZq
X-Proofpoint-ORIG-GUID: Y0jwOiC_nEFHOKj7D8Tg1Xrz0ZzsIrZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=773 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060061
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPM Glink & RPM message RAM nodes to support frequency scaling
on IPQ9574.

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- Moved rpm_msg_ram node under /soc and updated the node name to sram@
	- Moved rpm-glink node such that the nodes are sorted alphabetically

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

