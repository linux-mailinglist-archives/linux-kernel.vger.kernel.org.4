Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA86C6AE5F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCGQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCGQHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:07:47 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A761094F72;
        Tue,  7 Mar 2023 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678205188; x=1709741188;
  h=from:to:cc:subject:date:message-id;
  bh=d5GAJhIsi3DI0tkGTO78oNl30k1j8FBMs55HQWPy1d4=;
  b=AZJkiTBRUHFE8J5quYt/4q5Zo7EjSdm0/oEbvWwVcNEZe24CqDxcI2PX
   uGNKfhAlJMz2e6XItq7xMzWRPe2FBVSdh2fX6pZsRPxIjBLsdxXhJ30XQ
   /HQjsDHr3+AiI41mhrCfqn/vBwdk1zN1Muf2MnGlbHBXXn4P4VgFNWVhT
   kuQ1eoq9I1b/Dn9H+EMRq8c7vPiGHDQiH7dk8Oy4xcCgtdE0v5BHMtIVT
   3xh4Biow/LDl26888Fg9K+K3OX61rve437QCVPOPlqiIqvXgVZ3jvNKqL
   i3uethYxLCAJ7shWPtJVP0kpH7kUJXL1HBqKIVzcKe7HVHYmscjj2V6UR
   g==;
X-IronPort-AV: E=Sophos;i="5.98,241,1673884800"; 
   d="scan'208";a="223307386"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 00:06:27 +0800
IronPort-SDR: ZypTryLPrxJVs9u7A5yNXY7ea+aLwtW5Gijc6QgdUWNkczze+JcRalZCbj2bpCYCBrZedET53U
 JmVwzITWMtF1rkqV6opRkiLy7Gy4rY4ISkubTSIoM9enFBrh2BN3/a96U6dR8FV4709Tk7uK79
 B5N1KF8/YkMmJ35iCtgJnd+WwJuIzYPztA123rZWORQqEj6tN8jaHbEpLQNsbEsufFTvpjm/ua
 NKAgzGKntsRbsVP2Sq8iSZUt0dCvGDeFfasjZ0r/nNEUFEEhC2f6a1ZmVAWoA1wj/5UXvpPmsY
 CcA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 07:23:07 -0800
IronPort-SDR: Yf+ZyGK4UmlJoIelPxc38vMDhF/EuR/c3yLmswPnh5DD7lxon1FltAbOuGy8honcZ3ouhuMYPX
 VwVNrU1GGIR+iT++5DkfU5QIqePemln3OpZWCHqYJCR4/CcLLPqkDOUTSIkqoUh21BnrB+kj/k
 U2lNrFXgVw7qRJKkj1TSxkUpBSpvd0hfZpPYmxWNZF3HW/COiOhdFexAgofA8emp4mqmfOg+Tp
 tOFx98Rv+Dl3FZ/s7UbvrNKsEarNHXVJENUxpU5UUb9vNcQPG1gvFoq+rgTP1c9/tfxt3H5WWx
 9aM=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Mar 2023 08:06:25 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com, bvanassche@acm.org
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v1] ufs: core: Add support for qTimestamp attribute
Date:   Tue,  7 Mar 2023 18:06:22 +0200
Message-Id: <1678205182-13943-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new qTimestamp attribute was added to UFS 4.0 spec, in order to
synchronize timestamp between device logs and the host.The spec recommend
to send this attribute upon device power-on Reset/HW reset or when
switching to Active state (using SSU command). Due to this attribute,
the attribute's max value was extended to 8 bytes. As a result,
the new definition of struct utp_upiu_query_v4_0 was added.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>

--
Changes to v1:
- Add missed response variable to ufshcd_set_timestamp_attr
---
 drivers/ufs/core/ufshcd.c        | 38 ++++++++++++++++++++++++++++++++++++++
 include/uapi/scsi/scsi_bsg_ufs.h | 25 +++++++++++++++++++++++++
 include/ufs/ufs.h                |  1 +
 3 files changed, 64 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 172d25f..cba9ef1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8386,6 +8386,41 @@ static int ufshcd_device_params_init(struct ufs_hba *hba)
 	return ret;
 }
 
+static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
+{
+	int err;
+	struct ufs_query_req *request = NULL;
+	struct ufs_query_res *response = NULL;
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	struct utp_upiu_query_v4_0 *upiu_data;
+
+	if (dev_info->wspecversion < 0x400)
+		return;
+
+	ufshcd_hold(hba, false);
+
+	mutex_lock(&hba->dev_cmd.lock);
+
+	ufshcd_init_query(hba, &request, &response,
+			  UPIU_QUERY_OPCODE_WRITE_ATTR,
+			  QUERY_ATTR_IDN_TIMESTAMP, 0, 0);
+
+	request->query_func = UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST;
+
+	upiu_data = (struct utp_upiu_query_v4_0 *)&request->upiu_req;
+
+	put_unaligned_be64(ktime_get_real_ns(), &upiu_data->osf3);
+
+	err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_QUERY, QUERY_REQ_TIMEOUT);
+
+	if (err)
+		dev_err(hba->dev, "%s: failed to set timestamp %d\n",
+			__func__, err);
+
+	mutex_unlock(&hba->dev_cmd.lock);
+	ufshcd_release(hba);
+}
+
 /**
  * ufshcd_add_lus - probe and add UFS logical units
  * @hba: per-adapter instance
@@ -8555,6 +8590,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_set_ufs_dev_active(hba);
 	ufshcd_force_reset_auto_bkops(hba);
 
+	ufshcd_set_timestamp_attr(hba);
+
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
 		/*
@@ -9592,6 +9629,7 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		ret = ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE);
 		if (ret)
 			goto set_old_link_state;
+		ufshcd_set_timestamp_attr(hba);
 	}
 
 	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
index 2801b65..fd3f9e5e 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -71,6 +71,31 @@ struct utp_upiu_query {
 };
 
 /**
+ * struct utp_upiu_query_v4_0 - upiu request buffer structure for
+ * query request >= UFS 4.0 spec.
+ * @opcode: command to perform B-0
+ * @idn: a value that indicates the particular type of data B-1
+ * @index: Index to further identify data B-2
+ * @selector: Index to further identify data B-3
+ * @osf4: spec field B-5
+ * @osf5: spec field B 6,7
+ * @osf6: spec field DW 8,9
+ * @osf7: spec field DW 10,11
+ */
+struct utp_upiu_query_v4_0 {
+	__u8 opcode;
+	__u8 idn;
+	__u8 index;
+	__u8 selector;
+	__u8 osf3;
+	__u8 osf4;
+	__be16 osf5;
+	__be32 osf6;
+	__be32 osf7;
+	__be32 reserved;
+};
+
+/**
  * struct utp_upiu_cmd - Command UPIU structure
  * @data_transfer_len: Data Transfer Length DW-3
  * @cdb: Command Descriptor Block CDB DW-4 to DW-7
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 4e8d624..198cb39 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -170,6 +170,7 @@ enum attr_idn {
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
 	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
+	QUERY_ATTR_IDN_TIMESTAMP		= 0x30
 };
 
 /* Descriptor idn for Query requests */
-- 
2.7.4

