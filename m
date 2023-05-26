Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159F8712797
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbjEZNcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243739AbjEZNcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:32:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C81B12F;
        Fri, 26 May 2023 06:32:29 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q9lYXD023146;
        Fri, 26 May 2023 13:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=yfUJYs71WOQtztQmvAZKCCa86cEIUcYho45xl4bO0mY=;
 b=TGR+4O+FFIe3dyJj8UaWWl42NrujA93h0F7ESrZ/R9cvpDa/UoSMux1PWM8o7UkLmP+e
 HSxC7/he1PFvOb/brgA63jD/2Tt1WZhwiLgH6NdMh7+CNk9kOnYyS3j8Z3LCnMTNNf8c
 Uapn4h70+rLpcjT4P5cG8tfqauWBlw0+0QxjBh2dlEw5gHmLNNdQZqmM1kpBd2+fv4R6
 eAI4oaX+6oEtqJ3LE6qF+LpLCWuLPzCMMN+giIkCIPWE+cgU1RNbqcw4FKtFMLj6kJof
 dZi8COFj9it0G8WXzm6CJhyylQSMBY0NkSzMNQDmqZR4t26TzNPXDLEQ+MyY5/k9TGk6 Xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qttejgdb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 13:32:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QDWOjD022152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 13:32:24 GMT
Received: from hu-shazhuss-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 06:32:21 -0700
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <konrad.dybcio@linaro.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/5] arm64: dts: qcom: sa8775p: add uart5 and uart9 nodes
Date:   Fri, 26 May 2023 19:01:20 +0530
Message-ID: <20230526133122.16443-5-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526133122.16443-1-quic_shazhuss@quicinc.com>
References: <20230526133122.16443-1-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uXUPGgM47kDgSkpruzZppZel_OaH0UOh
X-Proofpoint-ORIG-GUID: uXUPGgM47kDgSkpruzZppZel_OaH0UOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add remaining uart5 and uart9 nodes for UART bus present on sa8775p
SoC.

Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 5c7b838d239a..b130136acffe 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -1083,6 +1083,21 @@
 				power-domains = <&rpmhpd SA8775P_CX>;
 				status = "disabled";
 			};
+
+			uart5: serial@994000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x994000 0x0 0x4000>;
+				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				status = "disabled";
+			};
 		};
 
 		qupv3_id_1: geniqup@ac0000 {
@@ -1223,6 +1238,21 @@
 				status = "disabled";
 			};
 
+			uart9: serial@a88000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0xa88000 0x0 0x4000>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
+						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core", "qup-config";
+				power-domains = <&rpmhpd SA8775P_CX>;
+				status = "disabled";
+			};
+
 			i2c10: i2c@a8c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0xa8c000 0x0 0x4000>;
-- 
2.17.1

