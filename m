Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85533615FA1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiKBJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiKBJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5349765E;
        Wed,  2 Nov 2022 02:20:26 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A299XfP017581;
        Wed, 2 Nov 2022 09:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=3PynDyf8dfvrOGliKw0TsE/8jsSmkuwI399UrbVjh9k=;
 b=MyHXBIWf2rXdMJyJR5kxIQrodEN8oBWiXDSZ5fbJ3P5SUTFi7SUrkGirZt9EFopXRbGy
 OegptQLKSmQtxvOBqPPsFSHHwCq0vklDqX8Sf/7Idn34oPleyJa6rq2eOPe3JAcgH7bG
 XcxRAa00ml2uvzAsXuHlXTBDUtqc4uOU7iYZ1FJ03roQAeb2jwdlvG5+NvZX2fP4to8z
 kXVZBRPPfWGrfTGkKrx/of8CREQUAWBv5mg0lFRMd2cSGW/wqYNEXOLtzxR36KL87iV4
 ymYcgHbfKYwx0hZiT62ZfV6nmeWQGoxKtdDk4Pyr265qjtXaVmxeXxefGZY34IxljIkF gA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkm40067p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:20:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A29KCsU013858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 09:20:12 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 02:20:07 -0700
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
Subject: [PATCH v14 8/9] arm64: dts: qcom: sm8250: Add coresight components
Date:   Wed, 2 Nov 2022 17:19:14 +0800
Message-ID: <20221102091915.15281-9-quic_jinlmao@quicinc.com>
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
X-Proofpoint-GUID: barI-XeCZ3w5rTbwJkNuRaXXbxhaSntb
X-Proofpoint-ORIG-GUID: barI-XeCZ3w5rTbwJkNuRaXXbxhaSntb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=1
 clxscore=1015 mlxlogscore=865 impostorscore=0 malwarescore=0
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

Add coresight components for sm8250. STM/ETM are added.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 498 +++++++++++++++++++++++++++
 1 file changed, 498 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a5b62cadb129..80193bb3c478 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2729,6 +2729,504 @@
 			};
 		};
 
+		stm@6002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0 0x06002000 0 0x1000>, <0 0x16280000 0 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint = <&funnel0_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@6041000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x06041000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_in0_out_funnel_merg: endpoint {
+						remote-endpoint = <&funnel_merg_in_funnel_in0>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@7 {
+					reg = <7>;
+					funnel0_in7: endpoint {
+						remote-endpoint = <&stm_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6042000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x06042000 0 0x1000>;
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
+					funnel_in1_out_funnel_merg: endpoint {
+						remote-endpoint = <&funnel_merg_in_funnel_in1>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@4 {
+					reg = <4>;
+					funnel_in1_in_funnel_apss_merg: endpoint {
+					remote-endpoint = <&funnel_apss_merg_out_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@6045000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x06045000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_merg_out_funnel_swao: endpoint {
+					remote-endpoint = <&funnel_swao_in_funnel_merg>;
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
+					funnel_merg_in_funnel_in0: endpoint {
+					remote-endpoint = <&funnel_in0_out_funnel_merg>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel_merg_in_funnel_in1: endpoint {
+					remote-endpoint = <&funnel_in1_out_funnel_merg>;
+					};
+				};
+			};
+		};
+
+		replicator@6046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0 0x06046000 0 0x1000>;
+
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					replicator_out: endpoint {
+						remote-endpoint = <&etr_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					replicator_cx_in_swao_out: endpoint {
+						remote-endpoint = <&replicator_swao_out_cx_in>;
+					};
+				};
+			};
+		};
+
+		etr@6048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x06048000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint = <&replicator_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6b04000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			arm,primecell-periphid = <0x000bb908>;
+
+			reg = <0 0x06b04000 0 0x1000>;
+			reg-names = "funnel-base";
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_swao_out_etf: endpoint {
+						remote-endpoint = <&etf_in_funnel_swao_out>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@7 {
+					reg = <7>;
+					funnel_swao_in_funnel_merg: endpoint {
+						remote-endpoint= <&funnel_merg_out_funnel_swao>;
+					};
+				};
+			};
+
+		};
+
+		etf@6b05000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x06b05000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint = <&replicator_in>;
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
+					etf_in_funnel_swao_out: endpoint {
+						remote-endpoint = <&funnel_swao_out_etf>;
+					};
+				};
+			};
+		};
+
+		replicator@6b06000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0 0x06b06000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					replicator_swao_out_cx_in: endpoint {
+						remote-endpoint = <&replicator_cx_in_swao_out>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint = <&etf_out>;
+					};
+				};
+			};
+		};
+
+		etm@7040000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07040000 0 0x1000>;
+
+			cpu = <&CPU0>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint = <&apss_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		etm@7140000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07140000 0 0x1000>;
+
+			cpu = <&CPU1>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint = <&apss_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		etm@7240000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07240000 0 0x1000>;
+
+			cpu = <&CPU2>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint = <&apss_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		etm@7340000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07340000 0 0x1000>;
+
+			cpu = <&CPU3>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint = <&apss_funnel_in3>;
+					};
+				};
+			};
+		};
+
+		etm@7440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07440000 0 0x1000>;
+
+			cpu = <&CPU4>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint = <&apss_funnel_in4>;
+					};
+				};
+			};
+		};
+
+		etm@7540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07540000 0 0x1000>;
+
+			cpu = <&CPU5>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint = <&apss_funnel_in5>;
+					};
+				};
+			};
+		};
+
+		etm@7640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07640000 0 0x1000>;
+
+			cpu = <&CPU6>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint = <&apss_funnel_in6>;
+					};
+				};
+			};
+		};
+
+		etm@7740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x07740000 0 0x1000>;
+
+			cpu = <&CPU7>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint = <&apss_funnel_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@7800000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x07800000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_apss_out_funnel_apss_merg: endpoint {
+					remote-endpoint = <&funnel_apss_merg_in_funnel_apss>;
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
+					apss_funnel_in0: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_funnel_in1: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					apss_funnel_in2: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					apss_funnel_in3: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+
+				port@4 {
+					reg = <4>;
+					apss_funnel_in4: endpoint {
+						remote-endpoint = <&etm4_out>;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					apss_funnel_in5: endpoint {
+						remote-endpoint = <&etm5_out>;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					apss_funnel_in6: endpoint {
+						remote-endpoint = <&etm6_out>;
+					};
+				};
+
+				port@7 {
+					reg = <7>;
+					apss_funnel_in7: endpoint {
+						remote-endpoint = <&etm7_out>;
+					};
+				};
+			};
+		};
+
+		funnel@7810000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x07810000 0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port {
+					funnel_apss_merg_out_funnel_in1: endpoint {
+					remote-endpoint = <&funnel_in1_in_funnel_apss_merg>;
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
+					funnel_apss_merg_in_funnel_apss: endpoint {
+					remote-endpoint = <&funnel_apss_out_funnel_apss_merg>;
+					};
+				};
+			};
+		};
+
 		cdsp: remoteproc@8300000 {
 			compatible = "qcom,sm8250-cdsp-pas";
 			reg = <0 0x08300000 0 0x10000>;
-- 
2.17.1

