Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648E4615F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiKBJXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKBJV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A1101DD;
        Wed,  2 Nov 2022 02:20:39 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A297ufa013949;
        Wed, 2 Nov 2022 09:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Kqwmw8Di1jxJG4NhZDwoiD/cwAWmU6HA2uK3Ku6PLQ8=;
 b=Vpnfx/2uzS8obzxprONXYjjHpzZ+np2LkqhaQILeMDBYb/aU5EPmI8HOrgE3w1CgvEgI
 9IeuK5eOu3A5AM8C6Exv/DkbMK/jdDIP7afa8J3lsncWLoSKFzu3fH7ozCv86vQwBiSf
 UEYCpVPzIn4E1Q11G5doeabdKeL6dQaYqyYrPwM/Mnr4UCIvqRixZXwRttsfPzQriyrq
 bdiutjNd5WO3ij91SLCgD3sOPmpoe40MOEWJhmAvacLU3xW9IYdNNPvtEnYo1takNegJ
 pd5ASPVsNuqSkY8CJxa9L5SDizWYxXGCLrcQh63Y/oLp5/4TcH2a7MPEvBQdHDTn5Zsw cQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkm40067v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:20:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A29KH0E014697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 09:20:17 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 02:20:12 -0700
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
Subject: [PATCH v14 9/9] arm64: dts: qcom: sm8250: Add tpdm mm/prng
Date:   Wed, 2 Nov 2022 17:19:15 +0800
Message-ID: <20221102091915.15281-10-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221102091915.15281-1-quic_jinlmao@quicinc.com>
References: <20221102091915.15281-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lXt7saVbqtRhvxHWBz2KDI9DUtVuYq51
X-Proofpoint-ORIG-GUID: lXt7saVbqtRhvxHWBz2KDI9DUtVuYq51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 mlxlogscore=831 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 173 +++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 80193bb3c478..0914b4b9c862 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2746,6 +2746,76 @@
 			};
 		};
 
+		tpda@6004000 {
+			compatible = "arm,primecell";
+			reg = <0 0x06004000 0 0x1000>;
+			reg-names = "tpda-base";
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
+			compatible = "arm,primecell";
+
+			reg = <0 0x06005000 0 0x1000>;
+			reg-names = "funnel-base";
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
@@ -2765,6 +2835,13 @@
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
@@ -2883,6 +2960,23 @@
 			};
 		};
 
+		tpdm@684c000 {
+			compatible = "arm,primecell";
+			reg = <0 0x0684c000 0 0x1000>;
+			reg-names = "tpdm-base";
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
@@ -2967,6 +3061,85 @@
 			};
 		};
 
+		tpdm@6c08000 {
+			compatible = "arm,primecell";
+			reg = <0 0x06c08000 0 0x1000>;
+			reg-names = "tpdm-base";
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
+
+			reg = <0 0x06c0b000 0 0x1000>;
+			reg-names = "funnel-base";
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
+
+			reg = <0 0x06c2d000 0 0x1000>;
+			reg-names = "funnel-base";
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
2.17.1

