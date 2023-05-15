Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DBE703121
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbjEOPKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbjEOPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:09:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924172690;
        Mon, 15 May 2023 08:09:37 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FEffb6026948;
        Mon, 15 May 2023 15:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tmBm5azAOb5kbBws6PC7/dIyELMT20nqPNDHR9qtfO0=;
 b=GBtmyJq8nHbHMRuWjKIXT40k+HNrA5mJjOy6Vhh6UCeRF46InSlQoLcydj10LWdI5EtX
 wCPk1pdFBpu2egc8EDHuSVceFTrCgk+pZYfwudypFjf/JinJKq3Dl1xpFly/Y9A1er+m
 Ihfu+HNH6lp25SAz8lRvFcykD6Pq7ZkEwxq0H17BU9smO6Jy7BcGw8AxJvUwyZ2v07y3
 za9ECrxPQXH277fm3sfRv62YwO1F3R/CM/wIqgA3AsSZDdJQscElu4k349t7e3eK5LKE
 XW/ZWAsBcx2YMAqG6nvjjm50ozAj3b5yJLIL5y5fnQ8yckfHKkBWtruzV0519+AXqGxP dg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkjt9gwdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 15:08:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34FF8ei4018951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 15:08:40 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 15 May 2023 08:08:33 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V2 4/4] arm64: dts: qcom: ipq9574: Enable crypto nodes
Date:   Mon, 15 May 2023 20:37:22 +0530
Message-ID: <20230515150722.12196-5-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230515150722.12196-1-quic_anusha@quicinc.com>
References: <20230515150722.12196-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -zgjZTHhgzLvbAZWV46XmRQIeWRWeCmS
X-Proofpoint-ORIG-GUID: -zgjZTHhgzLvbAZWV46XmRQIeWRWeCmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=854
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=1
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable crypto support for ipq9574.

Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
 Changes in V2:
	- Removed the deprecated compatible 'qcom,crypto-v5.1' and
	  added SoC specific compatible string.

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index fea15f3cf910..6e52d35a6a15 100644
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
+			compatible = "qcom,ipq9574-qce", "qcom,ipq4019-qce", "qcom,qce";
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

