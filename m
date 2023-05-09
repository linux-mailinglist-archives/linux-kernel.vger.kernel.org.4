Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562976FCAEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjEIQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbjEIQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:13:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59322448B;
        Tue,  9 May 2023 09:13:52 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349Ee9Q8000503;
        Tue, 9 May 2023 16:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=qjNE64Bl6aXfoRPaPrhlt1v4v0jOcC6u62TQgiuFuZM=;
 b=kf2l9Py2y4xh0vl2/J2hxjAtGq4O11z+JDXXD6QLBl+/O8C9GAmWKb6/wkS9vP6qaaP4
 NnhqloCvI64YEQenJccMnpvcbk/1AsUPjcBl6GV4pFoStlcxBtv3Za1W+znPBNrvLu2c
 abyfCkSMQ72Wz1M9PA5u+82uqpa2IbqdWF+FbMrQEnkKKrCnsRQOR0ht0kCCGdiel1q/
 bh8w7ImKkZ61zZ0xT2TztChiSXdYVNatcfb/unVVg8+U0Ea52OPqE+A6xl9CNxDqk4Zl
 hVjr8SN/I0ZQgqC4vwTlmtg73XP7xiO4eEejux9Fa8nQPuQQ7N/cW17w3Xsz1CaZfSgJ TA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfr5089h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 16:13:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349GDj1a016620
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 16:13:46 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 09:13:19 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Taniya Das" <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sm8550: Add video clock controller
Date:   Tue, 9 May 2023 21:42:18 +0530
Message-ID: <20230509161218.11979-5-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509161218.11979-1-quic_jkona@quicinc.com>
References: <20230509161218.11979-1-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u7Wvl67a3Xab0en4E0GvXQ7oB8c6a-BO
X-Proofpoint-ORIG-GUID: u7Wvl67a3Xab0en4E0GvXQ7oB8c6a-BO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=816 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for video clock controller on Qualcomm SM8550 platform.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6e9bad8f6f33..e67e7c69dae6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/qcom,sm8550-gcc.h>
 #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
 #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
+#include <dt-bindings/clock/qcom,sm8550-videocc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -759,6 +760,17 @@ gcc: clock-controller@100000 {
 				 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 		};
 
+		videocc: clock-controller@aaf0000 {
+			compatible = "qcom,sm8550-videocc";
+			reg = <0 0x0aaf0000 0 0x10000>;
+			clocks = <&bi_tcxo_div2>, <&gcc GCC_VIDEO_AHB_CLK>;
+			power-domains = <&rpmhpd SM8550_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		ipcc: mailbox@408000 {
 			compatible = "qcom,sm8550-ipcc", "qcom,ipcc";
 			reg = <0 0x00408000 0 0x1000>;
-- 
2.25.1

