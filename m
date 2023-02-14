Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD769586C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjBNFRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjBNFRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:17:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE31F924;
        Mon, 13 Feb 2023 21:16:14 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E2mRgB030258;
        Tue, 14 Feb 2023 05:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=jPR7mgs1EkkcQmA3HRo5sXUD+X9OyIrhw2n3X+AActw=;
 b=cFQDPBIRFOlrLEKUua0fDMzj8WOL9VEgAH/qk3FSgHbiHuXDrXND1KghqVp8mZaG2waK
 nZ3CuNRvA2oHN181hr8RwQg2Sa+QivuoU+JR3J2dTTlwUg6/3GRRYB3eY5W9tw7e906g
 O/BYcwSGMXbYs8bm14KPCebkMs/J+A24yd7Rh5faWmOuJzR3E0AYXjbwBeMei4oaP0R4
 pHRVpYgu63zUABp/2A0VVMXjmDk4hoDkahFShJo5FlqFMiHipYhJ+ZafAsac1YVsR41O
 PyywwFrRu5kO5BFCiRWU6LI9ILyfgxQ3u0UOOewG1ifIVolTZJoLpsCMnm32ybASG6Ry RQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv0942r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 05:15:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31E5FK8C009564
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 05:15:20 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 21:15:08 -0800
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jassisinghbrar@gmail.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V4 4/5] arm64: dts: qcom: ipq9574: Add SMEM support
Date:   Tue, 14 Feb 2023 10:44:13 +0530
Message-ID: <20230214051414.10740-5-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214051414.10740-1-quic_poovendh@quicinc.com>
References: <20230214051414.10740-1-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AQ_BrKaEG8gTO1aLg5gZw3eAWAc4DN3j
X-Proofpoint-ORIG-GUID: AQ_BrKaEG8gTO1aLg5gZw3eAWAc4DN3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_02,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=828 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required nodes to support SMEM

 Changes in V4:
	- Added required nodes for smem support

Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 898d7ce3f28d..2b41416d7f91 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -102,11 +102,17 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-
 		tz_region: tz@4a600000 {
 			reg = <0x0 0x4a600000 0x0 0x400000>;
 			no-map;
 		};
+
+		smem@4aa00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x4aa00000 0x0 0x00100000>;
+			hwlocks = <&tcsr_mutex 0>;
+			no-map;
+		};
 	};
 
 	soc: soc@0 {
@@ -157,6 +163,12 @@
 			#power-domain-cells = <1>;
 		};
 
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01905000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
 		tcsr: syscon@1937000 {
 			compatible = "qcom,tcsr-ipq9574", "syscon";
 			reg = <0x01937000 0x21000>;
-- 
2.17.1

