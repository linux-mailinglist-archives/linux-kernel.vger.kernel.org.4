Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB472F85D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbjFNIvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbjFNIv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:51:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD171BE3;
        Wed, 14 Jun 2023 01:51:24 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E4sXcD005173;
        Wed, 14 Jun 2023 08:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sUddKoBZU8PLlhROte9ETd8sGO/K/B+J/irUo1pqDwQ=;
 b=ZS/StfxKmjLWd0Aa7nrdZ2r9tLhDZQlOREmacs878J49dV9PnKVQm0OFxS81T6ps8zAB
 wHa0Tjtm2Ajm+o7ZqzrG+ih3LcLauL1VFIRFSKua8Vk55jMxpvk4vD4SLldO8K5UgbJx
 QJNpslpjcXgOzH8AVcKQbMdaqH3x3PWt/+ZT4hkcha8jyhmGMwuntsHeaKMDOa9vq92j
 Hmq7GolhSGf0lFXx2516iIyhz8PFl00WcjOxN+eUTdDRVaeJUUMxhJLtPTReFhC6l2wi
 tYZq4F18dZ3sLPE8oa8v9rnYGE8ngDYO7EP+SCsAj42RF+YkaiUXkGmdjlK8bgXqNdTv cQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6t0bt25e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 08:51:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35E8pELk024885
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 08:51:14 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 14 Jun 2023 01:51:09 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq9574: Enable WPS buttons
Date:   Wed, 14 Jun 2023 14:20:40 +0530
Message-ID: <20230614085040.22071-3-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230614085040.22071-1-quic_anusha@quicinc.com>
References: <20230614085040.22071-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kfxdbGiaFRgg6_ZemYoax_rfGMoQjQTs
X-Proofpoint-ORIG-GUID: kfxdbGiaFRgg6_ZemYoax_rfGMoQjQTs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_05,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=928 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for wps buttons on GPIO 37.

Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
 .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
index 999902bc70bd..fd5326dc1773 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
@@ -8,6 +8,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "ipq9574.dtsi"
 
 / {
@@ -18,6 +20,20 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+
+		button-wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			debounce-interval = <60>;
+		};
+	};
 };
 
 &blsp1_spi0 {
@@ -114,6 +130,13 @@
 		drive-strength = <8>;
 		bias-disable;
 	};
+
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio37";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
 };
 
 &xo_board_clk {
-- 
2.17.1

