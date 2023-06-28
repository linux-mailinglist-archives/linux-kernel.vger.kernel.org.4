Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E43741151
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjF1MjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:39:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:35192 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232001AbjF1MhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:37:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SAmFnQ002193;
        Wed, 28 Jun 2023 12:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=XLYT34qEjQ6HYGUoTlDKe0dodFK4dwkxLz1rB6s8Nxo=;
 b=ZGh7DURWPbXgzTB2X8Mo8jnHLKshi1d9e4v1QwvYltciCsgU7NIo5UidbwqNj4sjv7R3
 uMK2Fy/Xj2ZyiFyH6Pl8PFKMYLlPSqKRH9T5wUZxAfDHknD8qYNbbbF65lrwZVYml2cE
 egTvAH1rTGtH7dd9A3DSlNX1d+/Kmfhv2qJcjiWEcTWGABQEqsCBKXFBc/mAczIHmGDX
 Y/mkBKYOrU0Bbmw5HOceFBh246kUZa1C97PoWBht/onenvqlh2aYtq1MM/Tqh8FMnelL
 CfTP5I4EkqTU7yVYnjljgC8wKRWPC0BWbPyeX10fNGAgyI2FAIXsUXFgJyFYZHGQCFTA KA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgemk0x7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:52 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCapLE025340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:51 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:36:44 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 14/21] MAINTAINERS: Add entry for minidump driver related support
Date:   Wed, 28 Jun 2023 18:04:41 +0530
Message-ID: <1687955688-20809-15-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K4JMMEe9pinGGLQoI6BjoAoext74H8Hs
X-Proofpoint-ORIG-GUID: K4JMMEe9pinGGLQoI6BjoAoext74H8Hs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxlogscore=977 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the entries for all the files added as a part qualcomm
minidump driver support.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a82795114ad4..8cbbe3e662e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17551,6 +17551,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
 F:	drivers/regulator/vqmmc-ipq4019-regulator.c
 
+QUALCOMM MINIDUMP DRIVER
+M:	Mukesh Ojha <quic_mojha@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/admin-guide/qcom_minidump.rst
+F:	drivers/soc/qcom/qcom_minidump.c
+F:	drivers/soc/qcom/qcom_minidump_smem.c
+
 QUALCOMM NAND CONTROLLER DRIVER
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-mtd@lists.infradead.org
@@ -17559,6 +17567,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 F:	drivers/mtd/nand/raw/qcom_nandc.c
 
+QUALCOMM PSTORE MINIDUMP DRIVER
+M:	Mukesh Ojha <quic_mojha@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/soc/qcom/qcom_pstore_minidump.c
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
 M:	Sean Tranchetti <quic_stranche@quicinc.com>
-- 
2.7.4

