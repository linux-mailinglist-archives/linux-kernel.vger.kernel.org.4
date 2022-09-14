Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3E5B819E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiINGqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiINGqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:46:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA05661726;
        Tue, 13 Sep 2022 23:46:51 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E5Srxg027254;
        Wed, 14 Sep 2022 06:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=AuScgmf+yQRTkwCCiVpiVM6yswtDLALs1OxjrZvXMT0=;
 b=iLaL5UMBxIMHBRG5K97Eqfz9PXYMFSalx+z14jumepRe2h6O6KBUxLg93wQR1zWE+gjM
 1gL2XCTf99kfE7WMaOl+Wiq3DoKRkvMCEAU3EEgEyUQ2oL4jBjao1YzgRheDMYTP0NCH
 N5TqPSt5OCVE++k2/eZy8qnci3buoW1oXbEJ1NrM9ckfODR1b6LF4re/UKHLTZdnMcca
 sgGkzEcNMwilE8xXdRCdFvt3qrYwiF4JZTWHo+NU2+Svo+Ru2wS3Hl40Sr5H6byucPvy
 zFjGapCtxaGT7OkvLlgvPYpskv2MtWjuCJI29m1lYS3spvxo/+H0E/085X39hY/IalNb nw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxymhkcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 06:46:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E6fiBj028769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 06:41:44 GMT
Received: from hyiwei-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 23:41:41 -0700
From:   Huang Yiwei <quic_hyiwei@quicinc.com>
To:     <djakov@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@somainline.org>
CC:     <dmitry.baryshkov@linaro.org>, <leo.yan@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Huang Yiwei <quic_hyiwei@quicinc.com>
Subject: [PATCH v2] interconnect: qcom: Kconfig: Make INTERCONNECT_QCOM tristate
Date:   Wed, 14 Sep 2022 14:41:22 +0800
Message-ID: <20220914064122.16222-1-quic_hyiwei@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DDcETp6igTbk_BHTxGnJanqr0GuayL-p
X-Proofpoint-GUID: DDcETp6igTbk_BHTxGnJanqr0GuayL-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_02,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=800 lowpriorityscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140032
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make INTERCONNECT_QCOM tristate so that icc-common.c can be
compiled as a module.

Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
---
 drivers/interconnect/qcom/Kconfig      | 2 +-
 drivers/interconnect/qcom/icc-common.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 25d5b4baf6f6..1a1c941635a2 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INTERCONNECT_QCOM
-	bool "Qualcomm Network-on-Chip interconnect drivers"
+	tristate "Qualcomm Network-on-Chip interconnect drivers"
 	depends on ARCH_QCOM
 	help
 	  Support for Qualcomm's Network-on-Chip interconnect hardware.
diff --git a/drivers/interconnect/qcom/icc-common.c b/drivers/interconnect/qcom/icc-common.c
index 0822ce207b5d..f27f4fdc4531 100644
--- a/drivers/interconnect/qcom/icc-common.c
+++ b/drivers/interconnect/qcom/icc-common.c
@@ -5,6 +5,7 @@
 
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include "icc-common.h"
 
@@ -32,3 +33,5 @@ struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void
 	return ndata;
 }
 EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
+
+MODULE_LICENSE("GPL");
-- 
2.17.1

