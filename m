Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2298864B6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbiLMOI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiLMOIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:08:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183651C92A;
        Tue, 13 Dec 2022 06:08:11 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDDvv5a027930;
        Tue, 13 Dec 2022 14:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xisdxIEj3MrtrOa4Wpfi4t5TkqxZFjV/s9j/ArEptIY=;
 b=mHMgvsGxZvYE2rpFSWUCt2huQ3Ya1ZcdWrEkjl9K/P7KMRTj3WzGJJLX8Alln/yRx7G3
 dB2IQ1y+FiA1rqlPcXxXaKFYjdSewJzXPTK9K3Z9W0Z8CI7ThNuonMLeC8iLTaKDMBjo
 Ql8RqXdauFjRFwssdcD6baw/LooeJTmaphTBzDfRMcgw/eGuvIVTPn7BtKpd6EIAPgjx
 UdYn9cPnzdYvk5eLFwtb2H709sKQts0OzYurfQzUd306ENws7Y5USwjRbaYVMHj2X7M0
 8uQK5VBOPyiUz6vgwr3hKkjvjFqlzS8VPFa8gkkA5U+02v5YzL0JQSIWczq5CUpZA/mK 1A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3medypa8jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:07:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDE7qEd014743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:07:52 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 13 Dec 2022 06:07:47 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 1/4] arm64: dts: qcom: Introduce a carveout for modem metadata
Date:   Tue, 13 Dec 2022 19:37:21 +0530
Message-ID: <20221213140724.8612-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221213140724.8612-1-quic_sibis@quicinc.com>
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K9IpgvKj7_0Ohp3fPRrIoPHH8AKIHhwO
X-Proofpoint-GUID: K9IpgvKj7_0Ohp3fPRrIoPHH8AKIHhwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new carveout for modem metadata. This will serve as a
replacement for the memory region used by MSA to authenticate modem
ELF headers.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi    | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi                  | 9 +++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi                  | 9 +++++++++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts                | 7 ++++++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi           | 7 ++++++-
 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 7 ++++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi                   | 9 +++++++++
 7 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 5b47b8de69da..4242f8587c19 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -127,6 +127,12 @@
 			reg = <0x0 0xf6f00000 0x0 0x100000>;
 			no-map;
 		};
+
+		/delete-node/ memory@91700000;
+		mdata_mem: memory@f7100000 {
+			reg = <0x0 0xf7100000 0x0 0x4000>;
+			no-map;
+		};
 	};
 
 	vph_pwr: vph-pwr-regulator {
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index cc65f52bb80f..3f5fb08e2341 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -462,6 +462,11 @@
 			reg = <0x0 0x91500000 0x0 0x200000>;
 			no-map;
 		};
+
+		mdata_mem: memory@91700000 {
+			reg = <0x0 0x91700000 0x0 0x4000>;
+			no-map;
+		};
 	};
 
 	rpm-glink {
@@ -2458,6 +2463,10 @@
 				memory-region = <&mpss_mem>;
 			};
 
+			metadata {
+				memory-region = <&mdata_mem>;
+			};
+
 			smd-edge {
 				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 539382dab0ad..02e81fd5702d 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -59,6 +59,11 @@
 			qcom,vmid = <15>;
 		};
 
+		mdata_mem: memory@89100000 {
+			reg = <0x0 0x89100000 0x0 0x4000>;
+			no-map;
+		};
+
 		spss_mem: memory@8ab00000 {
 			reg = <0x0 0x8ab00000 0x0 0x700000>;
 			no-map;
@@ -1357,6 +1362,10 @@
 				memory-region = <&mpss_mem>;
 			};
 
+			metadata {
+				memory-region = <&mdata_mem>;
+			};
+
 			glink-edge {
 				interrupts = <GIC_SPI 452 IRQ_TYPE_EDGE_RISING>;
 				label = "modem";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index b27b5f0e2b6b..ff0ef8bcba2f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -80,6 +80,11 @@
 			reg = <0x0 0x94400000 0x0 0x200000>;
 			no-map;
 		};
+
+		mdata_mem: memory@94e00000 {
+			reg = <0x0 0x94e00000 0x0 0x4000>;
+			no-map;
+		};
 	};
 };
 
@@ -382,7 +387,7 @@
 	clock-names = "iface", "bus", "nav", "snoc_axi", "mnoc_axi", "xo";
 
 	iommus = <&apps_smmu 0x461 0x0>, <&apps_smmu 0x444 0x3>;
-	memory-region = <&mba_mem &mpss_mem>;
+	memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
 
 	resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
 		 <&pdc_reset PDC_MODEM_SYNC_RESET>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index d134d172a3c5..3f2e7175afd8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -81,6 +81,11 @@
 			reg = <0x0 0x94400000 0x0 0x200000>;
 			no-map;
 		};
+
+		mdata_mem: memory@94e00000 {
+			reg = <0x0 0x94e00000 0x0 0x4000>;
+			no-map;
+		};
 	};
 
 	aliases {
@@ -865,7 +870,7 @@ hp_i2c: &i2c9 {
 	clock-names = "iface", "bus", "nav", "snoc_axi", "mnoc_axi", "xo";
 
 	iommus = <&apps_smmu 0x461 0x0>, <&apps_smmu 0x444 0x3>;
-	memory-region = <&mba_mem &mpss_mem>;
+	memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
 
 	/* This gets overridden for SKUs with LTE support. */
 	firmware-name = "qcom/sc7180-trogdor/modem-nolte/mba.mbn",
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
index bf522a64b172..bda0495aa0b5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -17,6 +17,11 @@
 			reg = <0x0 0x9c700000 0x0 0x200000>;
 			no-map;
 		};
+
+		mdata_mem: memory@9d100000 {
+			reg = <0x0 0x9d100000 0x0 0x4000>;
+			no-map;
+		};
 	};
 };
 
@@ -32,7 +37,7 @@
 
 	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
 	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
-	memory-region = <&mba_mem>, <&mpss_mem>;
+	memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
 	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
 			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 65032b94b46d..56050f35c232 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -122,6 +122,11 @@
 			qcom,vmid = <15>;
 		};
 
+		mdata_mem: memory@89700000 {
+			reg = <0 0x89700000 0 0x4000>;
+			no-map;
+		};
+
 		qseecom_mem: qseecom@8ab00000 {
 			reg = <0 0x8ab00000 0 0x1400000>;
 			no-map;
@@ -3283,6 +3288,10 @@
 				memory-region = <&mpss_region>;
 			};
 
+			metadata {
+				memory-region = <&mdata_mem>;
+			};
+
 			glink-edge {
 				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
 				label = "modem";
-- 
2.17.1

