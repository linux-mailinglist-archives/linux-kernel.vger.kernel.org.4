Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74AE71F8EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjFBD0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjFBD0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:26:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610E0107;
        Thu,  1 Jun 2023 20:26:32 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3520wOcA021915;
        Fri, 2 Jun 2023 03:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vDWbJ7HDaCubY9wkl48RoAc7jy9aTsxfSYjQMdr7mM4=;
 b=D0gXV/KQn5rfANCO/YJqs2MlhkM5AYzJvSuB5vVluz7V6xOnDNdHahmDKCpRTrbXDS++
 H5+YjNWoOkwnQ1fvcczZ85Ose/GGkETJAgSfxiPYJO7u7yCC5vVbnjdx40LhloiOf6SO
 NGjvYgY+FDbB4q6QR1KbgKyOtzqRUdsHgXUYe+UIbB/m//6SHssuSnw8BBDlDDQcoZ7w
 V/WnhENoq2TQAaGwl6nquZ6j33gNM9cAE/XM3Y3DpF7x2xh5a4KkOdUODYi4WR3SAloQ
 +fCmQQ42nc+L/FyJItINQEvtsSbqpVMC8jDeH/KDKBUVE1JO/JWThalk3pcx8KLxFwaj mQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qy2v10gkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 03:26:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3523QQ8d017143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 03:26:26 GMT
Received: from hu-namajain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 20:26:23 -0700
From:   Naman Jain <quic_namajain@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Naman Jain <quic_namajain@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_kaushalk@quicinc.com>
Subject: [PATCH 2/2] soc: qcom: socinfo: Add support for new fields in revision 19
Date:   Fri, 2 Jun 2023 08:56:00 +0530
Message-ID: <20230602032600.14790-2-quic_namajain@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230602032600.14790-1-quic_namajain@quicinc.com>
References: <20230602032600.14790-1-quic_namajain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eAcIqrFboGBddE-IRpjN7nfbG7Bo8uCN
X-Proofpoint-GUID: eAcIqrFboGBddE-IRpjN7nfbG7Bo8uCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_01,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for below fields coming in socinfo structure under v19:
* num_func_clusters: number of clusters with at least one functional core
* boot_cluster: cluster selected as boot cluster
* boot_core: core selected as boot core
While at it, rename some variables to align them with their
functionalities.

Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 40 ++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index a76006ea8a37..745afada508b 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -170,8 +170,8 @@ struct socinfo {
 	/* Version 14 */
 	__le32 num_clusters;
 	__le32 ncluster_array_offset;
-	__le32 num_defective_parts;
-	__le32 ndefective_parts_array_offset;
+	__le32 num_subset_parts;
+	__le32 nsubset_parts_array_offset;
 	/* Version 15 */
 	__le32 nmodem_supported;
 	/* Version 16 */
@@ -184,6 +184,10 @@ struct socinfo {
 	/* Version 18 */
 	__le32 num_kvps;
 	__le32 kvps_offset;
+	/* Version 19 */
+	__le32 num_func_clusters;
+	__le32 boot_cluster;
+	__le32 boot_core;
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -201,12 +205,15 @@ struct socinfo_params {
 	u32 nproduct_id;
 	u32 num_clusters;
 	u32 ncluster_array_offset;
-	u32 num_defective_parts;
-	u32 ndefective_parts_array_offset;
+	u32 num_subset_parts;
+	u32 nsubset_parts_array_offset;
 	u32 nmodem_supported;
 	u32 feature_code;
 	u32 pcode;
 	u32 oem_variant;
+	u32 num_func_clusters;
+	u32 boot_cluster;
+	u32 boot_core;
 };
 
 struct smem_image_version {
@@ -623,6 +630,18 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
+	case SOCINFO_VERSION(0, 19):
+		qcom_socinfo->info.num_func_clusters = __le32_to_cpu(info->num_func_clusters);
+		qcom_socinfo->info.boot_cluster = __le32_to_cpu(info->boot_cluster);
+		qcom_socinfo->info.boot_core = __le32_to_cpu(info->boot_core);
+
+		debugfs_create_u32("num_func_clusters", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.num_func_clusters);
+		debugfs_create_u32("boot_cluster", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.boot_cluster);
+		debugfs_create_u32("boot_core", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.boot_core);
+		fallthrough;
 	case SOCINFO_VERSION(0, 18):
 	case SOCINFO_VERSION(0, 17):
 		qcom_socinfo->info.oem_variant = __le32_to_cpu(info->oem_variant);
@@ -647,17 +666,18 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 	case SOCINFO_VERSION(0, 14):
 		qcom_socinfo->info.num_clusters = __le32_to_cpu(info->num_clusters);
 		qcom_socinfo->info.ncluster_array_offset = __le32_to_cpu(info->ncluster_array_offset);
-		qcom_socinfo->info.num_defective_parts = __le32_to_cpu(info->num_defective_parts);
-		qcom_socinfo->info.ndefective_parts_array_offset = __le32_to_cpu(info->ndefective_parts_array_offset);
+		qcom_socinfo->info.num_subset_parts = __le32_to_cpu(info->num_subset_parts);
+		qcom_socinfo->info.nsubset_parts_array_offset =
+			__le32_to_cpu(info->nsubset_parts_array_offset);
 
 		debugfs_create_u32("num_clusters", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.num_clusters);
 		debugfs_create_u32("ncluster_array_offset", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.ncluster_array_offset);
-		debugfs_create_u32("num_defective_parts", 0444, qcom_socinfo->dbg_root,
-				   &qcom_socinfo->info.num_defective_parts);
-		debugfs_create_u32("ndefective_parts_array_offset", 0444, qcom_socinfo->dbg_root,
-				   &qcom_socinfo->info.ndefective_parts_array_offset);
+		debugfs_create_u32("num_subset_parts", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.num_subset_parts);
+		debugfs_create_u32("nsubset_parts_array_offset", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.nsubset_parts_array_offset);
 		fallthrough;
 	case SOCINFO_VERSION(0, 13):
 		qcom_socinfo->info.nproduct_id = __le32_to_cpu(info->nproduct_id);
-- 
2.17.1

