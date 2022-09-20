Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1C5BE54B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiITMKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiITMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:09:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40E2D1FD;
        Tue, 20 Sep 2022 05:09:47 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KBiTbB028124;
        Tue, 20 Sep 2022 12:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Zn/4GVoXtRPuVHgbd6uc1gFCOtVIB/KS/vNyd0DGjuA=;
 b=Bhykg45qNSIlBbWDJlpXEdKl9A7MjpC8r5qbnTKvxRok6nzHY7FsoKFOO16RHmwuGcGg
 xw6WXIpnnnXvwmVCyqThljTmQAzoQIYMCnS08pKwkIjbrvY5w+xEF6FaBTL4a0LJ4Qj7
 D7ex+YH5Phqe33SwjiACGbsGp+sFjHlNtO7HldeKAVTg6jytseVbcVEjZ0LQOl8d1Jqb
 ipJeELENQvVWhJys0rKc2bcBmlNSd3fcBI0NCvvCO9C2aYdOELWNTHRmXkAipBaux5MY
 dKBD14H4D+kbIMDDzkSd+jSGKqjPovcgf4g8JEnMPMTozMo1xP5OA/lsX/0sOzRWF3Zt jQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jptw33db3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 12:09:41 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28KC9eVD009092;
        Tue, 20 Sep 2022 12:09:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3jnqp911sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 12:09:40 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KC9d5R009084;
        Tue, 20 Sep 2022 12:09:39 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 28KC9d4R009083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 12:09:39 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 05:09:36 -0700
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Shazad Hussain" <quic_shazhuss@quicinc.com>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH v4 3/3] arm64: dts: qcom: introduce sa8540p-ride dts
Date:   Tue, 20 Sep 2022 17:38:02 +0530
Message-ID: <20220920120802.14321-4-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920120802.14321-1-quic_ppareek@quicinc.com>
References: <20220920120802.14321-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q66kCn14RRW2Nok-6tCVfcnNtaokjFKa
X-Proofpoint-GUID: q66kCn14RRW2Nok-6tCVfcnNtaokjFKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_04,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=678 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new dts file specific for Qdrive board based on sa8540p chipset.
Introduce common dtsi file sa8295p-adp.dtsi, to be included for adp and
Qdrive board.

This is quite similar to sa8295 ADP development board. Main differences
are related to connectors, and interface cards, like USB external ports,
ethernet-switch, and PCIe switch etc.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Reported-by: Shazad Hussain <quic_shazhuss@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts | 31 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 68a172c4c748..e30d2a958937 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-adp-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
diff --git a/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
new file mode 100644
index 000000000000..bd79866b80e1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "sa8540p-adp.dtsi"
+
+/ {
+	model = "Qualcomm SA8540 ADP";
+	compatible = "qcom,sa8540p-adp-ride", "qcom,sa8540p";
+};
+
+&ufs_card_hc {
+	status = "disabled";
+};
+
+&usb_1 {
+	status = "disabled";
+};
+
+&usb_1_hsphy {
+	status = "disabled";
+};
+
+&usb_1_qmpphy {
+	status = "disabled";
+};
-- 
2.17.1

