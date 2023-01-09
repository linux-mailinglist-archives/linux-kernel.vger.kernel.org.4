Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D1D661D06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbjAIDwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbjAIDvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:51:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FFF11C1B;
        Sun,  8 Jan 2023 19:51:05 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3093hwci020240;
        Mon, 9 Jan 2023 03:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/IJJnqCCeQTzO3/tnx62D2NGd+2w4ScRu7KPEDGUH4g=;
 b=hG+1YM20wZIpYzYQfbJ2iZLA6056tIdW0QqNdpMjbiSYJdnW4h6pYRda03LidJvl25CB
 qgtdauREKATFo6qCiB6v1DuhWJuE0bA7DpxQN8tHu0tdQdmxtchS1QVzMr9CxAU8OkXn
 i+nrVsHkfpzQ1sLwqXegoDGvMI6XyzoZaZPiM7yLcrm/5M0qlZr5bKxmTxQCjcj0lprP
 kTGmOJQunYBmHTuR4++Exuas0PNMQ8y/fo+qI4oxbaD/9AvFXkTNvZtmpiRAQ6QoZRHj
 f9zz8DbTAaoi9VydSeIJjl2ms3pNufLoJ07Z/QZrCGA5wSjdOimzPZBa1nS4ftxc1FZw fQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mxxeqteb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 03:50:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3093or40031847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 03:50:53 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 8 Jan 2023 19:50:48 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <robin.murphy@arm.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 10/11] arm64: dts: qcom: sc7180: Add a carveout for modem metadata
Date:   Mon, 9 Jan 2023 09:18:42 +0530
Message-ID: <20230109034843.23759-11-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230109034843.23759-1-quic_sibis@quicinc.com>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xGz4YkhFi-MNl9mtq4dlrJa7y1SImGFu
X-Proofpoint-GUID: xGz4YkhFi-MNl9mtq4dlrJa7y1SImGFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301090025
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new carveout for modem metadata on SC7180 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
 * Split dt/bindings per SoC  [Krzysztof] 

 arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 7 ++++++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index c7a22c7976b7..9b8b023577ca 100644
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
index edb56c4d55a2..8b7652a94628 100644
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
-- 
2.17.1

