Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7750F700342
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbjELJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbjELJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:02:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB30D106D1;
        Fri, 12 May 2023 02:02:20 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C8F7Um008053;
        Fri, 12 May 2023 09:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=q+WZoz+DZsgB/7N1UzCMfAS06EPg6+8iO2IO/aD/RSA=;
 b=OZOXcjeXU30vli1/PP7uloDILo0LWXKEy9Hqnv1Ka0UkY3y9dmYh9ptwXQs0Fug1NKiQ
 MFK8hHloq1XM0Foo5ec56C0U/kyu0ZPjVCSfuPhTuOdy8Pa0obOaCr7V9y9RNJ4Ky/WE
 fFXysT0MW91oh/N5JWjkM2pMWfGHsi5+FMZgiNBldaEhN0Ap//zXvETpI+ffIhRmxwYn
 AOKzB3QCBn5rU9jdJVLuGOiBEB8GgGAF6bt+bXMm7/TFcKbPRPAFoB+T9uU9FJGMxxG1
 b8Lry+AiHCgLv4UUHdKDhKk+0oVqzapy3XDCW1PJ+6rV4yxk2dYPH5F8TiDXE6aAfBMr Ug== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhh3905nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 09:02:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34C92Deu001205
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 09:02:13 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 May 2023 02:02:07 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq9574: Enable crypto nodes
Date:   Fri, 12 May 2023 14:31:34 +0530
Message-ID: <20230512090134.9811-3-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230512090134.9811-1-quic_anusha@quicinc.com>
References: <20230512090134.9811-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P2s7Oc3PYeDBxdodIOzt7v02-U30Ooe5
X-Proofpoint-ORIG-GUID: P2s7Oc3PYeDBxdodIOzt7v02-U30Ooe5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=837
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable crypto support for ipq9574.

Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index fea15f3cf910..3cda5aa8d03c 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -123,6 +123,26 @@
 			clock-names = "core";
 		};
 
+		cryptobam: dma-controller@704000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x00704000 0x20000>;
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <1>;
+			qcom,controlled-remotely;
+		};
+
+		crypto: crypto@73a000 {
+			compatible = "qcom,crypto-v5.1";
+			reg = <0x0073a000 0x6000>;
+			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
+				 <&gcc GCC_CRYPTO_AXI_CLK>,
+				 <&gcc GCC_CRYPTO_CLK>;
+			clock-names = "iface", "bus", "core";
+			dmas = <&cryptobam 2>, <&cryptobam 3>;
+			dma-names = "rx", "tx";
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq9574-tlmm";
 			reg = <0x01000000 0x300000>;
-- 
2.17.1

