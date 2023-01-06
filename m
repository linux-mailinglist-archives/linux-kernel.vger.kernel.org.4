Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0BB65FDF7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjAFJ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjAFJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:25:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14646718B4;
        Fri,  6 Jan 2023 01:22:06 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3064K7Uk004166;
        Fri, 6 Jan 2023 09:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=seTHc2EvtHTcMCsOiyOX3LGrepcCE5Xw4JutTZEv6e0=;
 b=STLp2Bszj10y7O53Mqlm0pPoi66Z/6BgHJ/I27l79/Lfd57wfV7qLUTFJJTWb3WJzNSf
 QwUmk9HmYguRs3fBzOLYQs/r8YAVM5BlujwAUOItEhGH82hJN+bcwJ8lRDxI4NRxIAmB
 H50fxWkC6cWtu1uRxSCRiDFC8BbdjL5FC9JCurETKu0ySMvkmAtGpDeSDeT6dkZlWsxB
 gZM7AvOBrR8RfZcPvNieaRoyGerH0pAWkYA35Ip99J43DHwyS4f87eKn4XD3qQcDie6e
 FenErYNB8ZB/2NXfB1s28UvRZ3VCobBO/9NjganPFiYmBqpnPahuky2MXbfkV1+zQ6I0 VA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwuuutq8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 09:21:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3069LcaT022775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Jan 2023 09:21:38 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 6 Jan 2023 01:21:38 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v16 8/8] arm64: dts: qcom: sm8250: Add tpdm mm/prng
Date:   Fri, 6 Jan 2023 01:21:19 -0800
Message-ID: <20230106092119.20449-9-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106092119.20449-1-quic_jinlmao@quicinc.com>
References: <20230106092119.20449-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SQr5ULAies88irEmmtjHRosA0QTxoeBg
X-Proofpoint-ORIG-GUID: SQr5ULAies88irEmmtjHRosA0QTxoeBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_05,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 mlxscore=0 phishscore=0 mlxlogscore=934 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tpdm mm and tpdm prng for sm8250.

+---------------+                +-------------+
|  tpdm@6c08000 |                |tpdm@684C000 |
+-------|-------+                +------|------+
        |                               |
+-------|-------+                       |
| funnel@6c0b000|                       |
+-------|-------+                       |
        |                               |
+-------|-------+                       |
|funnel@6c2d000 |                       |
+-------|-------+                       |
        |                               |
        |    +---------------+          |
        +----- tpda@6004000  -----------+
             +-------|-------+
                     |
             +-------|-------+
             |funnel@6005000 |
             +---------------+

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 164 +++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index dab5579946f3..221fcbdb47a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2746,6 +2746,73 @@ stm_out: endpoint {
 			};
 		};
 
+		tpda@6004000 {
+			compatible = "qcom,coresight-tpda", "arm,primecell";
+			reg = <0 0x06004000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					tpda_out_funnel_qatb: endpoint {
+						remote-endpoint = <&funnel_qatb_in_tpda>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@9 {
+					reg = <9>;
+					tpda_9_in_tpdm_mm: endpoint {
+						remote-endpoint = <&tpdm_mm_out_tpda9>;
+					};
+				};
+
+				port@17 {
+					reg = <23>;
+					tpda_23_in_tpdm_prng: endpoint {
+						remote-endpoint = <&tpdm_prng_out_tpda_23>;
+					};
+				};
+			};
+		};
+
+		funnel@6005000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x06005000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_qatb_out_funnel_in0: endpoint {
+						remote-endpoint = <&funnel_in0_in_funnel_qatb>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_qatb_in_tpda: endpoint {
+						remote-endpoint = <&tpda_out_funnel_qatb>;
+					};
+				};
+			};
+		};
+
 		funnel@6041000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0 0x06041000 0 0x1000>;
@@ -2765,6 +2832,13 @@ in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
+				port@6 {
+					reg = <6>;
+					funnel_in0_in_funnel_qatb: endpoint {
+						remote-endpoint = <&funnel_qatb_out_funnel_in0>;
+					};
+				};
+
 				port@7 {
 					reg = <7>;
 					funnel0_in7: endpoint {
@@ -2882,6 +2956,22 @@ etr_in: endpoint {
 			};
 		};
 
+		tpdm@684c000 {
+			compatible = "qcom,coresight-tpdm", "arm,primecell";
+			reg = <0 0x0684c000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					tpdm_prng_out_tpda_23: endpoint {
+						remote-endpoint = <&tpda_23_in_tpdm_prng>;
+					};
+				};
+			};
+		};
+
 		funnel@6b04000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			arm,primecell-periphid = <0x000bb908>;
@@ -2966,6 +3056,80 @@ replicator_in: endpoint {
 			};
 		};
 
+		tpdm@6c08000 {
+			compatible = "qcom,coresight-tpdm", "arm,primecell";
+			reg = <0 0x06c08000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					tpdm_mm_out_funnel_dl_mm: endpoint {
+						remote-endpoint = <&funnel_dl_mm_in_tpdm_mm>;
+					};
+				};
+			};
+		};
+
+		funnel@6c0b000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x06c0b000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_dl_mm_out_funnel_dl_center: endpoint {
+					remote-endpoint = <&funnel_dl_center_in_funnel_dl_mm>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@3 {
+					reg = <3>;
+					funnel_dl_mm_in_tpdm_mm: endpoint {
+						remote-endpoint = <&tpdm_mm_out_funnel_dl_mm>;
+					};
+				};
+			};
+		};
+
+		funnel@6c2d000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x06c2d000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port {
+					tpdm_mm_out_tpda9: endpoint {
+						remote-endpoint = <&tpda_9_in_tpdm_mm>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@2 {
+					reg = <2>;
+					funnel_dl_center_in_funnel_dl_mm: endpoint {
+					remote-endpoint = <&funnel_dl_mm_out_funnel_dl_center>;
+					};
+				};
+			};
+		};
+
 		etm@7040000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0 0x07040000 0 0x1000>;
-- 
2.39.0

