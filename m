Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6860DED1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiJZKXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJZKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:23:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5EA89ADF;
        Wed, 26 Oct 2022 03:23:27 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QABTN8020474;
        Wed, 26 Oct 2022 10:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Bhn5uKSIGqfgXgcbX5tTZcEKSxbaiKo2K12VdbAd00I=;
 b=Xe3w3Yk6fnk2KSc/pGc0fJEkEuUsL7ayPJQevF6HEn/RQjTHV64IgthBh3g64ZYwUCcy
 Rxp1kR6JEzf5m+L3VuV5LMXFFxLZ4h18w85+iXxXKW60KByqX66ZM++ZE9kdi/HB/bLh
 pg1CbxqEC86rF0yWPvCavLtr8WkMz+ksH4+YjIe7w8NvGy9Uz3fGXD/Eh8J0BGJTbkRX
 F/zT/2Lv7t4ddY4rfCpL07QA64NWz8zVp+9EufX0WdMDluTb9Fpxi2gL1ltdcZLH+1Ek
 oFmmln81bxYu65cpIYUZTrvIDl3scml3+ZPBvLnbHkTvkNAQMceiEmFWe/EBDiKicepn 4g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kebkdjyb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 10:23:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QANKQl015663
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 10:23:20 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 03:23:18 -0700
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH] wifi: ath10k: Add WLAN firmware image version info into smem
Date:   Wed, 26 Oct 2022 15:52:57 +0530
Message-ID: <20221026102257.19919-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vG8EtwYAp2uOXlm1qTZ-L2AnEdDsC6aE
X-Proofpoint-ORIG-GUID: vG8EtwYAp2uOXlm1qTZ-L2AnEdDsC6aE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_05,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210260058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a SoC based solution, it would be useful to know the versions of the
various binary firmware blobs the system is running on. On a QCOM based
SoC, this info can be obtained from socinfo debugfs infrastructure. For
this to work, respective subsystem drivers have to export the firmware
version information to an SMEM based version information table.

Having firmware version information at one place will help quickly
figure out the firmware versions of various subsystems on the device
instead of going through builds/logs in an event of a system crash.

Fill WLAN firmware version information in SMEM version table to be
printed as part of socinfo debugfs infrastructure on a Qualcomm based
SoC.

This change is applicable only for WCN399X targets.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/qmi.c | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 66cb7a1e628a..e88bcfd96859 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -14,6 +14,7 @@
 #include <linux/net.h>
 #include <linux/platform_device.h>
 #include <linux/qcom_scm.h>
+#include <linux/soc/qcom/smem.h>
 #include <linux/string.h>
 #include <net/sock.h>
 
@@ -22,6 +23,8 @@
 
 #define ATH10K_QMI_CLIENT_ID		0x4b4e454c
 #define ATH10K_QMI_TIMEOUT		30
+#define ATH10K_SMEM_IMAGE_VERSION_TABLE       469
+#define ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX     13
 
 static int ath10k_qmi_map_msa_permission(struct ath10k_qmi *qmi,
 					 struct ath10k_msa_mem_info *mem_info)
@@ -536,6 +539,29 @@ int ath10k_qmi_wlan_disable(struct ath10k *ar)
 	return ath10k_qmi_mode_send_sync_msg(ar, QMI_WLFW_OFF_V01);
 }
 
+static void ath10k_qmi_add_wlan_ver_smem(struct ath10k *ar, char *fw_build_id)
+{
+	u8 *smem_table_ptr;
+	size_t smem_block_size;
+	const u32 version_string_size = 128;
+	const u32 smem_img_idx_wlan = ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX * 128;
+
+	smem_table_ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY,
+				       ATH10K_SMEM_IMAGE_VERSION_TABLE,
+				       &smem_block_size);
+	if (IS_ERR(smem_table_ptr)) {
+		ath10k_dbg(ar, ATH10K_DBG_QMI, "smem image version table not found");
+		return;
+	}
+	if (smem_img_idx_wlan + version_string_size > smem_block_size) {
+		ath10k_dbg(ar, ATH10K_DBG_QMI, "smem block size too small: %i",
+			   smem_block_size);
+		return;
+	}
+	memcpy(smem_table_ptr + smem_img_idx_wlan, fw_build_id,
+	       version_string_size);
+}
+
 static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
 {
 	struct wlfw_cap_resp_msg_v01 *resp;
@@ -606,6 +632,8 @@ static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
 			    qmi->fw_version, qmi->fw_build_timestamp, qmi->fw_build_id);
 	}
 
+	ath10k_qmi_add_wlan_ver_smem(ar, qmi->fw_build_id);
+
 	kfree(resp);
 	return 0;
 
-- 
2.38.0

