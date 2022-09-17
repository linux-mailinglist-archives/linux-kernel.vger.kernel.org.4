Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B05BB5D5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 05:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIQDMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 23:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIQDMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 23:12:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE453BD138;
        Fri, 16 Sep 2022 20:11:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28H32DEH010261;
        Sat, 17 Sep 2022 03:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=wA3CSxfnFM+7ww/Tf3VjyrpLCkdwP55gYervGsDanu8=;
 b=AF2DvCzpLLyojbcUuqZ8NOtIslISp92YOxpMsaP7GaYO7L5o7XPPe14EunJRptxy6NiW
 HVvXTII9fohtF4D8fWLu9MFISCLlvycZghQv1JWCW8qor6oHe7ILDRCyC7lV1m7RKMhU
 C5wL6jlmqNYsnJSgFHa6SGPiGkC7Qx8PK530rM2I9Bt7ooF59ZdJoTMWOzhqek0Qkm+4
 5n06d9Oro5lfx9EPpjSUPAoU0lFqyJ51LKLtp2LE902LtG3fObB0jYZkEGhF+gknGuO1
 dzNiy4keNlcqaaWp9r6+DbMUn7czkcknQtVDZvMUvR8S6QnEdt0QbGfO2suM7AmDUqxy Fw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm8ymc2d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Sep 2022 03:11:49 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28H36mWY006868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Sep 2022 03:06:48 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 16 Sep 2022 20:06:48 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
Subject: [PATCH 1/1] soc: qcom: llcc: Move struct llcc_slice_config to header
Date:   Fri, 16 Sep 2022 20:06:40 -0700
Message-ID: <1663384000-8097-1-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 80-vygY7YJxTzCqRHZmAhejYYU7JpalF
X-Proofpoint-GUID: 80-vygY7YJxTzCqRHZmAhejYYU7JpalF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_14,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209170014
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move struct llcc_slice_config to header so that it can be reused by
other kernel modules.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c       | 44 --------------------------------------
 include/linux/soc/qcom/llcc-qcom.h | 44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 38d7296..3e7326f 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -55,50 +55,6 @@
 #define LLCC_VERSION_2_0_0_0          0x02000000
 #define LLCC_VERSION_2_1_0_0          0x02010000
 
-/**
- * struct llcc_slice_config - Data associated with the llcc slice
- * @usecase_id: Unique id for the client's use case
- * @slice_id: llcc slice id for each client
- * @max_cap: The maximum capacity of the cache slice provided in KB
- * @priority: Priority of the client used to select victim line for replacement
- * @fixed_size: Boolean indicating if the slice has a fixed capacity
- * @bonus_ways: Bonus ways are additional ways to be used for any slice,
- *		if client ends up using more than reserved cache ways. Bonus
- *		ways are allocated only if they are not reserved for some
- *		other client.
- * @res_ways: Reserved ways for the cache slice, the reserved ways cannot
- *		be used by any other client than the one its assigned to.
- * @cache_mode: Each slice operates as a cache, this controls the mode of the
- *             slice: normal or TCM(Tightly Coupled Memory)
- * @probe_target_ways: Determines what ways to probe for access hit. When
- *                    configured to 1 only bonus and reserved ways are probed.
- *                    When configured to 0 all ways in llcc are probed.
- * @dis_cap_alloc: Disable capacity based allocation for a client
- * @retain_on_pc: If this bit is set and client has maintained active vote
- *               then the ways assigned to this client are not flushed on power
- *               collapse.
- * @activate_on_init: Activate the slice immediately after it is programmed
- * @write_scid_en: Bit enables write cache support for a given scid.
- * @write_scid_cacheable_en: Enables write cache cacheable support for a
- *			     given scid (not supported on v2 or older hardware).
- */
-struct llcc_slice_config {
-	u32 usecase_id;
-	u32 slice_id;
-	u32 max_cap;
-	u32 priority;
-	bool fixed_size;
-	u32 bonus_ways;
-	u32 res_ways;
-	u32 cache_mode;
-	u32 probe_target_ways;
-	bool dis_cap_alloc;
-	bool retain_on_pc;
-	bool activate_on_init;
-	bool write_scid_en;
-	bool write_scid_cacheable_en;
-};
-
 struct qcom_llcc_config {
 	const struct llcc_slice_config *sct_data;
 	int size;
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 9ed5384..e84cd87 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -106,6 +106,50 @@ struct llcc_drv_data {
 	u32 version;
 };
 
+/**
+ * struct llcc_slice_config - Data associated with the llcc slice
+ * @usecase_id: Unique id for the client's use case
+ * @slice_id: llcc slice id for each client
+ * @max_cap: The maximum capacity of the cache slice provided in KB
+ * @priority: Priority of the client used to select victim line for replacement
+ * @fixed_size: Boolean indicating if the slice has a fixed capacity
+ * @bonus_ways: Bonus ways are additional ways to be used for any slice,
+ *		if client ends up using more than reserved cache ways. Bonus
+ *		ways are allocated only if they are not reserved for some
+ *		other client.
+ * @res_ways: Reserved ways for the cache slice, the reserved ways cannot
+ *		be used by any other client than the one its assigned to.
+ * @cache_mode: Each slice operates as a cache, this controls the mode of the
+ *             slice: normal or TCM(Tightly Coupled Memory)
+ * @probe_target_ways: Determines what ways to probe for access hit. When
+ *                    configured to 1 only bonus and reserved ways are probed.
+ *                    When configured to 0 all ways in llcc are probed.
+ * @dis_cap_alloc: Disable capacity based allocation for a client
+ * @retain_on_pc: If this bit is set and client has maintained active vote
+ *               then the ways assigned to this client are not flushed on power
+ *               collapse.
+ * @activate_on_init: Activate the slice immediately after it is programmed
+ * @write_scid_en: Bit enables write cache support for a given scid.
+ * @write_scid_cacheable_en: Enables write cache cacheable support for a
+ *			     given scid (not supported on v2 or older hardware).
+ */
+struct llcc_slice_config {
+	u32 usecase_id;
+	u32 slice_id;
+	u32 max_cap;
+	u32 priority;
+	bool fixed_size;
+	u32 bonus_ways;
+	u32 res_ways;
+	u32 cache_mode;
+	u32 probe_target_ways;
+	bool dis_cap_alloc;
+	bool retain_on_pc;
+	bool activate_on_init;
+	bool write_scid_en;
+	bool write_scid_cacheable_en;
+};
+
 #if IS_ENABLED(CONFIG_QCOM_LLCC)
 /**
  * llcc_slice_getd - get llcc slice descriptor
-- 
2.7.4

