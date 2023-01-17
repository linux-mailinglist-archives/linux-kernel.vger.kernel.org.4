Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB666D91C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjAQJBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjAQJBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:01:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E72F2FCEB;
        Tue, 17 Jan 2023 01:00:02 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H7fRUE022070;
        Tue, 17 Jan 2023 08:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=iHff1RhK1g1JMbybkAJv5L7n6wkWzPZGUFjfGLVXzsU=;
 b=QMHmwoDg/Zqg06SQyG8QWHo6owtaHA+8c7A32/uzdt95ZL7lte9WZwXj5suLji5pFlJ0
 04IYlAGYxeCYuaM9zeTHo9hFlsn5Vlzu7khPry7J0KuAiUKhR5moLYFwm4U73SxHJ71r
 96y5NrgoZ2Hbo7tcQWj+rNpL8RpK8A/8nNdbfDqmgnkRkb4bm+F5OjDxuuHDZMLefVTe
 fnloFJPN35Y9Pui6/tkqZWLaAXrHULQsoK4LNXIJ/D/HEDZ5Ijt0r5BzyptIRPD3gU0Z
 UiwrF1Ch8HCP/L2o7yj/sTvyWehywZPA8/GL0r9oZ2edEGhPjlKT2NrIpQzyw3GfNHYx ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3kqsw5vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H8xnwe031496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:49 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 00:59:44 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 10/11] arm64: dts: qcom: sc7180: Add a carveout for modem metadata
Date:   Tue, 17 Jan 2023 14:28:39 +0530
Message-ID: <20230117085840.32356-11-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117085840.32356-1-quic_sibis@quicinc.com>
References: <20230117085840.32356-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c2wXknsRU1nFUcA84c3mj-fjYbxXyBTr
X-Proofpoint-ORIG-GUID: c2wXknsRU1nFUcA84c3mj-fjYbxXyBTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170074
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new carveout for modem metadata on SC7180 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v4:
 * Use size/alloc-ranges instead of a specific address [Bjorn]

v2:
 * Split dt/bindings per SoC [Krzysztof]

 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 8 +++++++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index c7a22c7976b7..774f9d45f051 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -80,6 +80,12 @@
 			reg = <0x0 0x94400000 0x0 0x200000>;
 			no-map;
 		};
+
+		mdata_mem: mpss-metadata {
+			alloc-ranges = <0x0 0xa0000000 0x0 0x20000000>;
+			size = <0x0 0x4000>;
+			no-map;
+		};
 	};
 };
 
@@ -382,7 +388,7 @@
 	clock-names = "iface", "bus", "nav", "snoc_axi", "mnoc_axi", "xo";
 
 	iommus = <&apps_smmu 0x461 0x0>, <&apps_smmu 0x444 0x3>;
-	memory-region = <&mba_mem &mpss_mem>;
+	memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
 
 	resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
 		 <&pdc_reset PDC_MODEM_SYNC_RESET>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index edb56c4d55a2..0dc65cfeba07 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -81,6 +81,12 @@
 			reg = <0x0 0x94400000 0x0 0x200000>;
 			no-map;
 		};
+
+		mdata_mem: mpss-metadata {
+			alloc-ranges = <0x0 0xa0000000 0x0 0x20000000>;
+			size = <0x0 0x4000>;
+			no-map;
+		};
 	};
 
 	aliases {
@@ -865,7 +871,7 @@ hp_i2c: &i2c9 {
 	clock-names = "iface", "bus", "nav", "snoc_axi", "mnoc_axi", "xo";
 
 	iommus = <&apps_smmu 0x461 0x0>, <&apps_smmu 0x444 0x3>;
-	memory-region = <&mba_mem &mpss_mem>;
+	memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
 
 	/* This gets overridden for SKUs with LTE support. */
 	firmware-name = "qcom/sc7180-trogdor/modem-nolte/mba.mbn",
-- 
2.17.1

