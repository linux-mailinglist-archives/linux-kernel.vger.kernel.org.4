Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DCF741117
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjF1MiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:38:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:63716 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231821AbjF1Mgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SB2tG3012176;
        Wed, 28 Jun 2023 12:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=P2QBL+7zGMKDj1s/OV57kLVSn1SCcUja5763zLo1cZM=;
 b=d9tPUeWHLHRKTfxZHWo6EMSVNoJA21gzQQKvkikc5/i8hxvN0fk38LK8oZLeX7bOovnD
 OwRtaDyoVhj0OSEIwjk4naLKtRaI+LpwjySwbcRkItMc/cLOB2ihwZUQW2vGhOip3hAe
 9cS15yWyV00EiH5mtq1fbz8PGF2uFr9nMDyA6RyV2VkLH52ysfnYHCeAJzmiKpIpgPe1
 DKGM1tOiKhZPo4/Cx+9Zue7I0ElwpGI5C3vsKFiWiPAmmz1IxNf9/0lLfX8tO+kZf19o
 RtoTE3uE5YDuc0N8Y1eEDmXeE2yH7rDp3mo6iknjgYp9fgSSgC9XTCPnWf2BjE0XQH90 mA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgetpgw5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:17 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCaGEs024716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:36:16 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:36:10 -0700
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
Subject: [PATCH v4 09/21] pstore/ram : Export ramoops_parse_dt() symbol
Date:   Wed, 28 Jun 2023 18:04:36 +0530
Message-ID: <1687955688-20809-10-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZoEjWss5MTUTidHK6qRrwbz1QzIG9cbn
X-Proofpoint-GUID: ZoEjWss5MTUTidHK6qRrwbz1QzIG9cbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible if some driver do not want ramoops region to
be static instead it sets up the mem_address and mem_size
and use everything what this driver has to offer. To offer
this convenience export ramoops_parse_dt() function.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 fs/pstore/ram.c            | 26 ++++++++++++++++++--------
 include/linux/pstore_ram.h |  2 ++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ade66dbe5f39..6bb66d044bef 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -638,7 +638,7 @@ static int ramoops_parse_dt_u32(struct platform_device *pdev,
 	return 0;
 }
 
-static int ramoops_parse_dt(struct platform_device *pdev,
+int ramoops_parse_dt(struct platform_device *pdev,
 			    struct ramoops_platform_data *pdata)
 {
 	struct device_node *of_node = pdev->dev.of_node;
@@ -649,15 +649,24 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 
 	dev_dbg(&pdev->dev, "using Device Tree\n");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev,
-			"failed to locate DT /reserved-memory resource\n");
-		return -EINVAL;
+	/*
+	 * It is possible if some driver do not want ramoops
+	 * region to be static instead it sets up the mem_address
+	 * and mem_size and use everything what this driver has
+	 * to offer.
+	 */
+	if (!pdata->mem_address && !pdata->mem_size) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res) {
+			dev_err(&pdev->dev,
+				"failed to locate DT /reserved-memory resource\n");
+			return -EINVAL;
+		}
+
+		pdata->mem_size = resource_size(res);
+		pdata->mem_address = res->start;
 	}
 
-	pdata->mem_size = resource_size(res);
-	pdata->mem_address = res->start;
 	/*
 	 * Setting "unbuffered" is deprecated and will be ignored if
 	 * "mem_type" is also specified.
@@ -713,6 +722,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ramoops_parse_dt);
 
 static int ramoops_probe(struct platform_device *pdev)
 {
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 9d65ff94e216..55df4e631a25 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -8,6 +8,7 @@
 #ifndef __LINUX_PSTORE_RAM_H__
 #define __LINUX_PSTORE_RAM_H__
 
+#include <linux/platform_device.h>
 #include <linux/pstore.h>
 
 struct persistent_ram_ecc_info {
@@ -39,4 +40,5 @@ struct ramoops_platform_data {
 	struct persistent_ram_ecc_info ecc_info;
 };
 
+int ramoops_parse_dt(struct platform_device *, struct ramoops_platform_data *);
 #endif
-- 
2.7.4

