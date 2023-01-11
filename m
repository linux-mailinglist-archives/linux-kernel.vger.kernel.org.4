Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC32A6655EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjAKIWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjAKIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:22:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9845364ED;
        Wed, 11 Jan 2023 00:22:26 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B7Wn9j006570;
        Wed, 11 Jan 2023 08:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=X4kMJ7lGqg4ERoxmcSf1cIw1DJKzOZ4Ph7v10sowEmc=;
 b=MRBrzyIa6WEeC0OsKqeHRfeXiJ7oVa3QKsZWFNiAS1aJc2pJ+Rq0T3nEjtvnqECelmr8
 0+WeR/ZsT+5zSZUWIGR1eYJUjJgEs4xABxFGV+5smD/7UoAUZ+u54Ejhd3oRlRht8pcg
 24k1KoihIvtfYAngNhDzK3uQQGbusGNtmrf7lOLquK38pyzCruJ4o/xDYSCgv3UbnVCc
 Iz8yTeuB3F1zY5ghV+YBcr5i0fr1P0qZoD0G4fVwaardWZ+WHSpwDicjTGwCJkfaiSqw
 HOudm4uWiWh4gCYqBfBA5foKOntp5Nms/AVt+a/QTaq5Te5mMxRkdwgnK5S811Yh40kW dg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k7qrqy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 08:22:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30B8MDAq021340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 08:22:13 GMT
Received: from hu-namajain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 00:22:10 -0800
From:   Naman Jain <quic_namajain@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     Naman Jain <quic_namajain@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>
Subject: [PATCH 1/2] soc: qcom: socinfo: Change socinfo variable name and scope
Date:   Wed, 11 Jan 2023 13:51:40 +0530
Message-ID: <20230111082141.18109-2-quic_namajain@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230111082141.18109-1-quic_namajain@quicinc.com>
References: <20230111082141.18109-1-quic_namajain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IH2hRJKsGfRYSu6-8ddV1l5FiWjnFDUF
X-Proofpoint-ORIG-GUID: IH2hRJKsGfRYSu6-8ddV1l5FiWjnFDUF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change socinfo structure variable scope from function to file
to make it easy to support custom attributes for sysfs. Also,
change variable name to make it more descriptive.

Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 80 ++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 10efdbcfdf05..251c0fd94962 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -175,6 +175,7 @@ struct socinfo {
 	__le32  npartnamemap_offset;
 	__le32  nnum_partname_mapping;
 };
+static struct socinfo *soc_info;
 
 #ifdef CONFIG_DEBUG_FS
 struct socinfo_params {
@@ -502,7 +503,7 @@ DEFINE_IMAGE_OPS(variant);
 DEFINE_IMAGE_OPS(oem);
 
 static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
-				 struct socinfo *info, size_t info_size)
+				 size_t info_size)
 {
 	struct smem_image_version *versions;
 	struct dentry *dentry;
@@ -513,15 +514,15 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 
 	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
 
-	qcom_socinfo->info.fmt = __le32_to_cpu(info->fmt);
+	qcom_socinfo->info.fmt = __le32_to_cpu(soc_info->fmt);
 
 	debugfs_create_x32("info_fmt", 0444, qcom_socinfo->dbg_root,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
 	case SOCINFO_VERSION(0, 16):
-		qcom_socinfo->info.feature_code = __le32_to_cpu(info->feature_code);
-		qcom_socinfo->info.pcode = __le32_to_cpu(info->pcode);
+		qcom_socinfo->info.feature_code = __le32_to_cpu(soc_info->feature_code);
+		qcom_socinfo->info.pcode = __le32_to_cpu(soc_info->pcode);
 
 		debugfs_create_u32("feature_code", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.feature_code);
@@ -529,16 +530,20 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 				   &qcom_socinfo->info.pcode);
 		fallthrough;
 	case SOCINFO_VERSION(0, 15):
-		qcom_socinfo->info.nmodem_supported = __le32_to_cpu(info->nmodem_supported);
+		qcom_socinfo->info.nmodem_supported = __le32_to_cpu(soc_info->nmodem_supported);
 
 		debugfs_create_u32("nmodem_supported", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.nmodem_supported);
 		fallthrough;
 	case SOCINFO_VERSION(0, 14):
-		qcom_socinfo->info.num_clusters = __le32_to_cpu(info->num_clusters);
-		qcom_socinfo->info.ncluster_array_offset = __le32_to_cpu(info->ncluster_array_offset);
-		qcom_socinfo->info.num_defective_parts = __le32_to_cpu(info->num_defective_parts);
-		qcom_socinfo->info.ndefective_parts_array_offset = __le32_to_cpu(info->ndefective_parts_array_offset);
+		qcom_socinfo->info.num_clusters =
+			__le32_to_cpu(soc_info->num_clusters);
+		qcom_socinfo->info.ncluster_array_offset =
+			__le32_to_cpu(soc_info->ncluster_array_offset);
+		qcom_socinfo->info.num_defective_parts =
+			__le32_to_cpu(soc_info->num_defective_parts);
+		qcom_socinfo->info.ndefective_parts_array_offset =
+			__le32_to_cpu(soc_info->ndefective_parts_array_offset);
 
 		debugfs_create_u32("num_clusters", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.num_clusters);
@@ -550,19 +555,19 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 				   &qcom_socinfo->info.ndefective_parts_array_offset);
 		fallthrough;
 	case SOCINFO_VERSION(0, 13):
-		qcom_socinfo->info.nproduct_id = __le32_to_cpu(info->nproduct_id);
+		qcom_socinfo->info.nproduct_id = __le32_to_cpu(soc_info->nproduct_id);
 
 		debugfs_create_u32("nproduct_id", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.nproduct_id);
-		DEBUGFS_ADD(info, chip_id);
+		DEBUGFS_ADD(soc_info, chip_id);
 		fallthrough;
 	case SOCINFO_VERSION(0, 12):
 		qcom_socinfo->info.chip_family =
-			__le32_to_cpu(info->chip_family);
+			__le32_to_cpu(soc_info->chip_family);
 		qcom_socinfo->info.raw_device_family =
-			__le32_to_cpu(info->raw_device_family);
+			__le32_to_cpu(soc_info->raw_device_family);
 		qcom_socinfo->info.raw_device_num =
-			__le32_to_cpu(info->raw_device_num);
+			__le32_to_cpu(soc_info->raw_device_num);
 
 		debugfs_create_x32("chip_family", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.chip_family);
@@ -574,26 +579,26 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 				   &qcom_socinfo->info.raw_device_num);
 		fallthrough;
 	case SOCINFO_VERSION(0, 11):
-		num_pmics = le32_to_cpu(info->num_pmics);
-		pmic_array_offset = le32_to_cpu(info->pmic_array_offset);
+		num_pmics = le32_to_cpu(soc_info->num_pmics);
+		pmic_array_offset = le32_to_cpu(soc_info->pmic_array_offset);
 		if (pmic_array_offset + 2 * num_pmics * sizeof(u32) <= info_size)
-			DEBUGFS_ADD(info, pmic_model_array);
+			DEBUGFS_ADD(soc_info, pmic_model_array);
 		fallthrough;
 	case SOCINFO_VERSION(0, 10):
 	case SOCINFO_VERSION(0, 9):
-		qcom_socinfo->info.foundry_id = __le32_to_cpu(info->foundry_id);
+		qcom_socinfo->info.foundry_id = __le32_to_cpu(soc_info->foundry_id);
 
 		debugfs_create_u32("foundry_id", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.foundry_id);
 		fallthrough;
 	case SOCINFO_VERSION(0, 8):
 	case SOCINFO_VERSION(0, 7):
-		DEBUGFS_ADD(info, pmic_model);
-		DEBUGFS_ADD(info, pmic_die_rev);
+		DEBUGFS_ADD(soc_info, pmic_model);
+		DEBUGFS_ADD(soc_info, pmic_die_rev);
 		fallthrough;
 	case SOCINFO_VERSION(0, 6):
 		qcom_socinfo->info.hw_plat_subtype =
-			__le32_to_cpu(info->hw_plat_subtype);
+			__le32_to_cpu(soc_info->hw_plat_subtype);
 
 		debugfs_create_u32("hardware_platform_subtype", 0444,
 				   qcom_socinfo->dbg_root,
@@ -601,34 +606,34 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		fallthrough;
 	case SOCINFO_VERSION(0, 5):
 		qcom_socinfo->info.accessory_chip =
-			__le32_to_cpu(info->accessory_chip);
+			__le32_to_cpu(soc_info->accessory_chip);
 
 		debugfs_create_u32("accessory_chip", 0444,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.accessory_chip);
 		fallthrough;
 	case SOCINFO_VERSION(0, 4):
-		qcom_socinfo->info.plat_ver = __le32_to_cpu(info->plat_ver);
+		qcom_socinfo->info.plat_ver = __le32_to_cpu(soc_info->plat_ver);
 
 		debugfs_create_u32("platform_version", 0444,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.plat_ver);
 		fallthrough;
 	case SOCINFO_VERSION(0, 3):
-		qcom_socinfo->info.hw_plat = __le32_to_cpu(info->hw_plat);
+		qcom_socinfo->info.hw_plat = __le32_to_cpu(soc_info->hw_plat);
 
 		debugfs_create_u32("hardware_platform", 0444,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.hw_plat);
 		fallthrough;
 	case SOCINFO_VERSION(0, 2):
-		qcom_socinfo->info.raw_ver  = __le32_to_cpu(info->raw_ver);
+		qcom_socinfo->info.raw_ver  = __le32_to_cpu(soc_info->raw_ver);
 
 		debugfs_create_u32("raw_version", 0444, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.raw_ver);
 		fallthrough;
 	case SOCINFO_VERSION(0, 1):
-		DEBUGFS_ADD(info, build_id);
+		DEBUGFS_ADD(soc_info, build_id);
 		break;
 	}
 
@@ -656,7 +661,7 @@ static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
 }
 #else
 static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
-				 struct socinfo *info, size_t info_size)
+				 size_t info_size)
 {
 }
 static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo) {  }
@@ -665,14 +670,13 @@ static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo) {  }
 static int qcom_socinfo_probe(struct platform_device *pdev)
 {
 	struct qcom_socinfo *qs;
-	struct socinfo *info;
 	size_t item_size;
 
-	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID,
+	soc_info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID,
 			      &item_size);
-	if (IS_ERR(info)) {
+	if (IS_ERR(soc_info)) {
 		dev_err(&pdev->dev, "Couldn't find socinfo\n");
-		return PTR_ERR(info);
+		return PTR_ERR(soc_info);
 	}
 
 	qs = devm_kzalloc(&pdev->dev, sizeof(*qs), GFP_KERNEL);
@@ -681,25 +685,25 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
 
 	qs->attr.family = "Snapdragon";
 	qs->attr.machine = socinfo_machine(&pdev->dev,
-					   le32_to_cpu(info->id));
+					   le32_to_cpu(soc_info->id));
 	qs->attr.soc_id = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u",
-					 le32_to_cpu(info->id));
+					 le32_to_cpu(soc_info->id));
 	qs->attr.revision = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u.%u",
-					   SOCINFO_MAJOR(le32_to_cpu(info->ver)),
-					   SOCINFO_MINOR(le32_to_cpu(info->ver)));
+					   SOCINFO_MAJOR(le32_to_cpu(soc_info->ver)),
+					   SOCINFO_MINOR(le32_to_cpu(soc_info->ver)));
 	if (offsetof(struct socinfo, serial_num) <= item_size)
 		qs->attr.serial_number = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"%u",
-							le32_to_cpu(info->serial_num));
+							le32_to_cpu(soc_info->serial_num));
 
 	qs->soc_dev = soc_device_register(&qs->attr);
 	if (IS_ERR(qs->soc_dev))
 		return PTR_ERR(qs->soc_dev);
 
-	socinfo_debugfs_init(qs, info, item_size);
+	socinfo_debugfs_init(qs, item_size);
 
 	/* Feed the soc specific unique data into entropy pool */
-	add_device_randomness(info, item_size);
+	add_device_randomness(soc_info, item_size);
 
 	platform_set_drvdata(pdev, qs);
 
-- 
2.17.1

