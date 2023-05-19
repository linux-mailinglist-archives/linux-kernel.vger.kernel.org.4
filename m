Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32054709BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjESP5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjESP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:57:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67E10FA;
        Fri, 19 May 2023 08:57:24 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JEmff0023732;
        Fri, 19 May 2023 15:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=T1k8rEsc1p0ygsuyJorb2hKKhH5mQ8/ePQuTPCRGSjE=;
 b=WeTPyyWVI4VNgd1gt/7q0JPaHeCeT1tCLd4Z317FNJz9FXCPpmmkaQzWkVjG4HPE0Npy
 HGAsdzF5k2bU1nqV5OqiKpdjGD+eZc40sQOSOc1TIePsNDQjQ78XZPgKWUAwBiRt6oik
 pNVfwd2CfxdmibBXC8FjUCN6Gy43uDLXPVprMloFDza78y7dhH2fTPW4t9qFX3DNdXnP
 AQus54wmfjHSPzw8KgwVoRcjQK5CupnCcj/ogPFpgAjMc6jywhgTTKQ8lI+DhoxT4yZg
 HGRH/qbWO7sqkOlZ/34HkEGK84tWM/IZmkJrQe9GI42520CJS1nk3AA2imxKul5s15D5 Eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp8fm0mt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 15:57:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JFvJw9020438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 15:57:19 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 08:57:15 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH 4/4] arm64: dts: qcom: sm8550: Add camera clock controller
Date:   Fri, 19 May 2023 21:26:02 +0530
Message-ID: <20230519155602.6642-5-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519155602.6642-1-quic_jkona@quicinc.com>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nTh1A7YU-qA1rMkwFmEst8YMYhHPXPsA
X-Proofpoint-GUID: nTh1A7YU-qA1rMkwFmEst8YMYhHPXPsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=995 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for camera clock controller on Qualcomm
SM8550 platform.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index e67e7c69dae6..ac82d3774ed8 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,sm8550-camcc.h>
 #include <dt-bindings/clock/qcom,sm8550-gcc.h>
 #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
 #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
@@ -2397,6 +2398,20 @@ opp-202000000 {
 			};
 		};
 
+		camcc: clock-controller@ade0000 {
+			compatible = "qcom,sm8550-camcc";
+			reg = <0 0xade0000 0 0x20000>;
+			clocks = <&bi_tcxo_div2>,
+				 <&bi_tcxo_ao_div2>,
+				 <&sleep_clk>,
+				 <&gcc GCC_CAMERA_AHB_CLK>;
+			power-domains = <&rpmhpd SM8550_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		mdss: display-subsystem@ae00000 {
 			compatible = "qcom,sm8550-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
-- 
2.40.1

