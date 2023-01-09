Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3924661CFD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbjAIDvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbjAIDux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:50:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A1111D;
        Sun,  8 Jan 2023 19:50:51 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3093WY6u017726;
        Mon, 9 Jan 2023 03:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ooZfUzFJ44IiNEEoXu0Sn748/YFqHWyDd93tAjeCDJ8=;
 b=Z4p1uLf3iiOI3OhAAiBuKCRReYGpmkpIITZUog4TEK3WQxGSh3wI6qrfJeUb8FL6ANe0
 4IirVvCFrseeMxsbKMfOH09tWIRSxJjj3AEQ7QWQeXsftuzPK9bWGDE3xzV6baYa5cWt
 jKLHaKN3I/9Pkw1WwmiEfg1CRSVedWmK6mVy/vNcYgeKlkjp5GjJcLYfz7Nx1PY4JS7Q
 Ul+s1NLSl4VGt1ybBW72b+uqZJ2V/pSMCjyZOXfz/TDP/QP6bBmaSszegxxMb/RW7y8c
 i68ovrm+TmCiP/Ivklyt2wramyvAN+ZOM6OS9s/5+DASbOYmneh8qcLgOsuVIWbjXrpZ uA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mxyrmj90p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 03:50:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3093ocG7031287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 03:50:38 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 8 Jan 2023 19:50:34 -0800
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
Subject: [PATCH V2 07/11] arm64: dts: qcom: msm8996: Add a carveout for modem metadata
Date:   Mon, 9 Jan 2023 09:18:39 +0530
Message-ID: <20230109034843.23759-8-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: YJw79pEQwDzAH96s3ls5umPfx5JYsuXW
X-Proofpoint-ORIG-GUID: YJw79pEQwDzAH96s3ls5umPfx5JYsuXW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=782 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090025
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new carveout for modem metadata on MSM8996 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
 * Split dt/bindings per SoC  [Krzysztof] 

 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi               | 9 +++++++++
 2 files changed, 15 insertions(+)

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
index 87ff66ebde7b..2756ba5841a1 100644
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
@@ -2462,6 +2467,10 @@
 				memory-region = <&mpss_mem>;
 			};
 
+			metadata {
+				memory-region = <&mdata_mem>;
+			};
+
 			smd-edge {
 				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
 
-- 
2.17.1

