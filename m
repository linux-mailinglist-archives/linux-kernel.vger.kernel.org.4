Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148946A1C94
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBXNAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBXNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:00:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE97F59E4F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:00:51 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x10so53682126edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+/YREqzGdgagWtLRHEBm2pIbAVu4Xz2cjgZW+jRSAw=;
        b=zK0SXweW2qqihsXR+fZEKodBrvirTbzduXIk7LbAfeT+KGjrcHvfQ8kWaBgRtdTLUk
         KjO9GWh496KOFwQTNMLg9v5VBUHwfOk73wCVDji4dQir1H6eTSsp5XABvvIFrk7OpaN5
         Mi0w7q4qoFHRkh948C/IY8/ow9hKmjEHWdtnVRx7HeA82DXefK+/tICESHEAymOT6O9p
         GbXv9FipUtMUyK98G8lby4Ofqfa0EdFXCqTyzltRi3Ych4HMoVSuaqSKOX0Yyi1KDNAq
         bc4FJHZ+kRbvGV0OPqZiuXg1Iln7H8nykDAzB6KVkT+4e10hfwH76tnAieEznckNIlfq
         5Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+/YREqzGdgagWtLRHEBm2pIbAVu4Xz2cjgZW+jRSAw=;
        b=ytKapliddP8etjk5+JH6pP9HiKM+LZ+gtmeLq+O0lFTtMHJ91jKSsALyWnwZ3tpofs
         55fl1OD8vvo4RbOX66d0gzLBa9yX5tDwUd/C3oyObMPTo3NTKV1GTD06CqoGPpN7LpSO
         k+m+IdZP8woiaUoQtZYUEM/JyX4j95gzxCRY3hzpumOuuYFtwb832VsVxprACYET+gNC
         JYILp97J033SrAGFkOqV79DAbFdL0Ewr8cNSXcf62G+E+aTY/NH21CnHx+sSukvZfbzN
         eRfkgqwo/4UB8Gvi95QQ/KHEP3g1Gb/98/sHz6GnIM8P6/XkY9le1xrpvPphJeNooIiP
         Ao/A==
X-Gm-Message-State: AO0yUKV+fQe6VAE8r4PBrf3QnYtQxkLgF14QwCv30oJxzY4aT211XX/+
        yGVZzYk5A77UKzlydGMQnx7D1Q==
X-Google-Smtp-Source: AK7set9q7Xyz/2HXRoMErq/116LT/MKlWUNiCSscazJpKbHf3euHd7Xr0yUWfwND3jrWp3XYiPNe6w==
X-Received: by 2002:a50:ed98:0:b0:4ac:d14a:2ea6 with SMTP id h24-20020a50ed98000000b004acd14a2ea6mr13817302edr.31.1677243650347;
        Fri, 24 Feb 2023 05:00:50 -0800 (PST)
Received: from localhost ([194.62.217.1])
        by smtp.gmail.com with ESMTPSA id n1-20020a50c201000000b004af6e957b22sm1850452edf.6.2023.02.24.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:00:49 -0800 (PST)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     linux-block@vger.kernel.org
Cc:     Andreas Hindborg <nmi@metaspace.dk>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] block: ublk: enable zoned storage support
Date:   Fri, 24 Feb 2023 13:59:50 +0100
Message-Id: <20230224125950.214779-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add zoned storage support to ublk: report_zones and operations:
 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RESET

This allows implementation of zoned storage devices in user space. An
example user space implementation based on ubdsrv is available [1].

[1] https://github.com/metaspace/ubdsrv/commit/14a2b708f74f70cfecb076d92e680dc718cc1f6d

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/ublk_drv.c      | 145 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  18 +++++
 2 files changed, 157 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6368b56eacf1..9741b4b1647b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -20,6 +20,7 @@
 #include <linux/major.h>
 #include <linux/wait.h>
 #include <linux/blkdev.h>
+#include <linux/blkzoned.h>
 #include <linux/init.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
@@ -51,10 +52,12 @@
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
 		| UBLK_F_NEED_GET_DATA \
 		| UBLK_F_USER_RECOVERY \
-		| UBLK_F_USER_RECOVERY_REISSUE)
+		| UBLK_F_USER_RECOVERY_REISSUE \
+		| UBLK_F_ZONED)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
-#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
+#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD \
+			     | UBLK_PARAM_TYPE_ZONED)
 
 struct ublk_rq_data {
 	struct llist_node node;
@@ -212,6 +215,11 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 		set_disk_ro(ub->ub_disk, true);
 
 	set_capacity(ub->ub_disk, p->dev_sectors);
+
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors) {
+		ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
+	}
 }
 
 static void ublk_dev_param_discard_apply(struct ublk_device *ub)
@@ -227,6 +235,19 @@ static void ublk_dev_param_discard_apply(struct ublk_device *ub)
 	blk_queue_max_discard_segments(q, p->max_discard_segments);
 }
 
+static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
+{
+	const struct ublk_param_zoned *p = &ub->params.zoned;
+
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    ub->dev_info.flags & UBLK_F_ZONED) {
+		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
+		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
+		/* We do not support zone append yet */
+		//blk_queue_max_zone_append_sectors(q, zone_size);
+	}
+}
+
 static int ublk_validate_params(const struct ublk_device *ub)
 {
 	/* basic param is the only one which must be set */
@@ -268,6 +289,9 @@ static int ublk_apply_params(struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
 		ublk_dev_param_discard_apply(ub);
 
+	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
+		ublk_dev_param_zoned_apply(ub);
+
 	return 0;
 }
 
@@ -361,9 +385,18 @@ static void ublk_free_disk(struct gendisk *disk)
 	put_device(&ub->cdev_dev);
 }
 
+#if IS_ENABLED(CONFIG_BLK_DEV_ZONED)
+static int ublk_report_zones(struct gendisk *disk, sector_t sector,
+			     unsigned int nr_zones, report_zones_cb cb,
+			     void *data);
+#endif
+
 static const struct block_device_operations ub_fops = {
-	.owner =	THIS_MODULE,
-	.free_disk =	ublk_free_disk,
+	.owner = THIS_MODULE,
+	.free_disk = ublk_free_disk,
+#if IS_ENABLED(CONFIG_BLK_DEV_ZONED)
+	.report_zones = ublk_report_zones,
+#endif
 };
 
 #define UBLK_MAX_PIN_PAGES	32
@@ -499,7 +532,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (req_op(req) == REQ_OP_READ && ublk_rq_has_data(req)) {
+	if ((req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN) && ublk_rq_has_data(req)) {
 		struct ublk_map_data data = {
 			.ubq	=	ubq,
 			.rq	=	req,
@@ -566,6 +599,26 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 	case REQ_OP_WRITE_ZEROES:
 		ublk_op = UBLK_IO_OP_WRITE_ZEROES;
 		break;
+#ifdef CONFIG_BLK_DEV_ZONED
+	case REQ_OP_ZONE_OPEN:
+		ublk_op = UBLK_IO_OP_ZONE_OPEN;
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		ublk_op = UBLK_IO_OP_ZONE_CLOSE;
+		break;
+	case REQ_OP_ZONE_FINISH:
+		ublk_op = UBLK_IO_OP_ZONE_FINISH;
+		break;
+	case REQ_OP_ZONE_RESET:
+		ublk_op = UBLK_IO_OP_ZONE_RESET;
+		break;
+	case REQ_OP_DRV_IN:
+		ublk_op = UBLK_IO_OP_DRV_IN;
+		break;
+	case REQ_OP_ZONE_APPEND:
+		/* We do not support zone append yet */
+		fallthrough;
+#endif
 	default:
 		return BLK_STS_IOERR;
 	}
@@ -612,7 +665,8 @@ static void ublk_complete_rq(struct request *req)
 	 *
 	 * Both the two needn't unmap.
 	 */
-	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE) {
+	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
+	    req_op(req) != REQ_OP_DRV_IN) {
 		blk_mq_end_request(req, BLK_STS_OK);
 		return;
 	}
@@ -1493,6 +1547,73 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
 	return ub;
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static int ublk_report_zones(struct gendisk *disk, sector_t sector,
+			     unsigned int nr_zones, report_zones_cb cb,
+			     void *data)
+{
+	struct ublk_device *ub;
+	unsigned int zone_size;
+	unsigned int first_zone;
+	int ret = 0;
+
+	ub = disk->private_data;
+
+	if (!(ub->dev_info.flags & UBLK_F_ZONED))
+		return -EINVAL;
+
+	zone_size = disk->queue->limits.chunk_sectors;
+	first_zone = sector >> ilog2(zone_size);
+
+	nr_zones = min(ub->ub_disk->nr_zones - first_zone, nr_zones);
+
+	for (unsigned int i = 0; i < nr_zones; i++) {
+
+		struct request *req;
+		blk_status_t status;
+		struct blk_zone info;
+
+		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
+
+		if (IS_ERR(req)) {
+			ret = PTR_ERR(req);
+			goto out;
+		}
+
+		req->__sector = sector;
+
+		ret = blk_rq_map_kern(disk->queue, req, &info, sizeof(info),
+				      GFP_KERNEL);
+
+		if (ret)
+			goto out;
+
+		status = blk_execute_rq(req, 0);
+		ret = blk_status_to_errno(status);
+		if (ret)
+			goto out;
+
+		blk_mq_free_request(req);
+
+		ret = cb(&info, i, data);
+		if (ret)
+			goto out;
+
+		/* A zero length zone means don't ask for more zones */
+		if (!info.len) {
+			nr_zones = i;
+			break;
+		}
+
+		sector += zone_size;
+	}
+	ret = nr_zones;
+
+ out:
+	return ret;
+}
+#endif
+
 static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
@@ -1535,6 +1656,15 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	if (ret)
 		goto out_put_disk;
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    ub->dev_info.flags & UBLK_F_ZONED) {
+		disk_set_zoned(disk, BLK_ZONED_HM);
+		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_WRITE);
+		ret = blk_revalidate_disk_zones(disk, NULL);
+		if (ret)
+			goto out_put_disk;
+	}
+
 	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
@@ -1673,6 +1803,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
 		ub->dev_info.flags |= UBLK_F_URING_CMD_COMP_IN_TASK;
 
+	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		ub->dev_info.flags &= ~UBLK_F_ZONED;
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 8f88e3a29998..074b97821575 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -78,6 +78,10 @@
 #define UBLK_F_USER_RECOVERY	(1UL << 3)
 
 #define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
+/*
+ * Enable zoned device support
+ */
+#define UBLK_F_ZONED (1ULL << 5)
 
 /* device state */
 #define UBLK_S_DEV_DEAD	0
@@ -129,6 +133,12 @@ struct ublksrv_ctrl_dev_info {
 #define		UBLK_IO_OP_DISCARD	3
 #define		UBLK_IO_OP_WRITE_SAME	4
 #define		UBLK_IO_OP_WRITE_ZEROES	5
+#define		UBLK_IO_OP_ZONE_OPEN		10
+#define		UBLK_IO_OP_ZONE_CLOSE		11
+#define		UBLK_IO_OP_ZONE_FINISH		12
+#define		UBLK_IO_OP_ZONE_APPEND		13
+#define		UBLK_IO_OP_ZONE_RESET		15
+#define		UBLK_IO_OP_DRV_IN		34
 
 #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
@@ -214,6 +224,12 @@ struct ublk_param_discard {
 	__u16	reserved0;
 };
 
+struct ublk_param_zoned {
+	__u64	max_open_zones;
+	__u64	max_active_zones;
+	__u64	max_append_size;
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -224,10 +240,12 @@ struct ublk_params {
 	__u32	len;
 #define UBLK_PARAM_TYPE_BASIC           (1 << 0)
 #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
+#define UBLK_PARAM_TYPE_ZONED           (1 << 2)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
 	struct ublk_param_discard	discard;
+	struct ublk_param_zoned		zoned;
 };
 
 #endif
-- 
2.39.2

