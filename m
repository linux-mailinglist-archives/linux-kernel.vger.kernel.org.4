Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7FE6251A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiKKD0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKDZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:25:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6324059867;
        Thu, 10 Nov 2022 19:25:37 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB2pi4c017396;
        Fri, 11 Nov 2022 03:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=lD86X0OQ5dCB6O6o1/+iPAtT36dAVPEgdmKBPA9o/3w=;
 b=Dpvs6HDN2w0rzcCJiepfxs560b/+lSwRdbLQecVL7Zvr5N7Ak0tpjTbrG10papF6Oc5G
 xLx27F5eJzw4qgmnB1adDr3QtqnAtPOgw4P0sv6ODIdP7nlTrTSadE7bpWZhqJyFUmCU
 kBM/3lDxmkuMH/GAkxePO1pg4tR/8B/8EMCx4h21QxPvDUjc0YpmqH2m+cVdGCfzFcc0
 GnnWm9WiPWQG7O1l6BvG9xt0jQJ8QJIm9cV6tICRRCZYDIGa/DrSN3gLJwP260gp4n8l
 fwBdjZdOoNcRmuqFXuSddEVFuYtLS+mg8m1+hDtjP8unv7Su95J1W9uSIai4ep4Ok1qp Sg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksa89rg6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AB3PQFV027175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:26 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 10 Nov 2022 19:25:25 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/10] arm64: dts: qcom: sc8280xp: Add bwmon instances
Date:   Thu, 10 Nov 2022 19:25:15 -0800
Message-ID: <20221111032515.3460-11-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111032515.3460-1-quic_bjorande@quicinc.com>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wMUIszZGM2dNCQetFurm7Nnz8up4nFKa
X-Proofpoint-GUID: wMUIszZGM2dNCQetFurm7Nnz8up4nFKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211110021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two bwmon instances and define votes for CPU -> LLCC and LLCC ->
DDR, with bandwidth values based on the downstream DeviceTree.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
---

Changes since v1:
- Added "cpu" to compatible for the CPU-subsystem bwmon instance

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 91 ++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 2ac8f5204905..62e9dd8a2f07 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1287,6 +1287,97 @@
 			};
 		};
 
+		pmu@9091000 {
+			compatible = "qcom,sc8280xp-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0 0x9091000 0 0x1000>;
+
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <762000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <1720000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <2086000>;
+				};
+				opp-3 {
+					opp-peak-kBps = <2597000>;
+				};
+				opp-4 {
+					opp-peak-kBps = <2929000>;
+				};
+				opp-5 {
+					opp-peak-kBps = <3879000>;
+				};
+				opp-6 {
+					opp-peak-kBps = <5161000>;
+				};
+				opp-7 {
+					opp-peak-kBps = <5931000>;
+				};
+				opp-8 {
+					opp-peak-kBps = <6515000>;
+				};
+				opp-9 {
+					opp-peak-kBps = <7980000>;
+				};
+				opp-10 {
+					opp-peak-kBps = <8136000>;
+				};
+				opp-11 {
+					opp-peak-kBps = <10437000>;
+				};
+				opp-12 {
+					opp-peak-kBps = <12191000>;
+				};
+			};
+		};
+
+		pmu@90b6400 {
+			compatible = "qcom,sc8280xp-cpu-bwmon", "qcom,msm8998-bwmon";
+			reg = <0 0x090b6400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <2288000>;
+				};
+				opp-1 {
+					opp-peak-kBps = <4577000>;
+				};
+				opp-2 {
+					opp-peak-kBps = <7110000>;
+				};
+				opp-3 {
+					opp-peak-kBps = <9155000>;
+				};
+				opp-4 {
+					opp-peak-kBps = <12298000>;
+				};
+				opp-5 {
+					opp-peak-kBps = <14236000>;
+				};
+				opp-6 {
+					opp-peak-kBps = <15258001>;
+				};
+			};
+		};
+
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc8280xp-llcc";
 			reg = <0 0x09200000 0 0x58000>, <0 0x09600000 0 0x58000>;
-- 
2.17.1

