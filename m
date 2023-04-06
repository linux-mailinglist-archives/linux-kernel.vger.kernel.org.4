Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722766D8F30
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjDFGO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjDFGOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:14:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE78A4D;
        Wed,  5 Apr 2023 23:14:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3366DaN8014290;
        Thu, 6 Apr 2023 06:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SMGGMQsGfAM1J08a7as535Yu+zk26rbV9EElLwKY1lU=;
 b=j6/yKD4uizyQcSVPmQVAfr+C7xH82Qq+MykBdXrRZ4OHNNCqgSARNXiJwp/wJZGTdEkZ
 S4AIqAWORJGBBLrYLEpsh+1ZhBDlYupZvFCaaWqm2+zB5Mt19LNDgQP3GtHORta3eO1j
 gjKY1MUV1+tW4I6G1wQXEtaSkCnxTvr7pmUFrtNyXfLtrWWxwTDrddareMDKjKCBRUPU
 vRg9ejw3ZDmv1XKP7tCMv+12pZpRB5luUM5rWZ5TseakYkGocvx57p+LdkHp74vHwzrt
 UDln2f01eXH1OWwDp85bKtKbfDlwG/m4lE/J24Yw+zWiR5qpdQ9PHOSwq0bPCVWSYi93 Ug== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psr26029m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 06:14:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3366ECPI019302
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 06:14:12 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 23:14:04 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 4/5] arm64: dts: qcom: ipq9574: Add support for APSS clock controller
Date:   Thu, 6 Apr 2023 11:43:13 +0530
Message-ID: <20230406061314.10916-5-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406061314.10916-1-quic_devipriy@quicinc.com>
References: <20230406061314.10916-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: voyiCmBaSKyTMdJdsHci2moMYqEP-VJz
X-Proofpoint-ORIG-GUID: voyiCmBaSKyTMdJdsHci2moMYqEP-VJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060054
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the APCS & A73 PLL nodes to support CPU frequency scaling.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- No change

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 068c3950dcec..7c820463a79d 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -525,6 +525,24 @@
 			timeout-sec = <30>;
 		};
 
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq9574-apcs-apps-global",
+				     "qcom,ipq6018-apcs-apps-global";
+			reg = <0x0b111000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&a73pll>, <&xo_board_clk>;
+			clock-names = "pll", "xo";
+			#mbox-cells = <1>;
+		};
+
+		a73pll: clock@b116000 {
+			compatible = "qcom,ipq9574-a73pll";
+			reg = <0x0b116000 0x40>;
+			#clock-cells = <0>;
+			clocks = <&xo_board_clk>;
+			clock-names = "xo";
+		};
+
 		timer@b120000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0b120000 0x1000>;
-- 
2.17.1

