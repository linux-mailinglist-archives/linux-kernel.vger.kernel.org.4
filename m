Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43926A6CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCANAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCANAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:00:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C3B2FCE5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:59:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l1so13269592pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677675574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XAn/70U2KKRnEeCtQ5XFnUlbnR3a/3Bch3Z2vbvSlig=;
        b=lPIG3G15MyTokv80LD68UclxPWFU/RcxnOm8xkfQ6aMTLSfEoxxlhxD1RVcj7ep//a
         CaePRL0ex8iU05sLdiFCH8lugVTXmID9zMyocGEZAaNPclJui3aVOtl9s95TdVzb9czj
         7R4FhxLvdrdiN5OFFxX+hn1hDiC/KntBUsYYey9VY2xbJZ8oA5s5jzXAyCQfQ/tufGLC
         l+u8PBOevZU8DZouyF1FNu6iH4qqZhsrfzW0Qd86h+F4PfRIJiSVv8l9MqXgAv7TKRmS
         wa8CUoO+9GOl9mcIX6wc7umm8FitwjLj166Hwgou63GjNqD9Ei6635pB4+/Kooh/Mk0q
         7HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677675574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAn/70U2KKRnEeCtQ5XFnUlbnR3a/3Bch3Z2vbvSlig=;
        b=lYl95ER8wkIbU+aHdQmeZzskIFVAIvDmAqtmbcW7MgZXdBRma6X2ZNc+LL5is/bbUq
         q+XWRqvDplvGgeY9clRVG0Y5MNFSVAFFOYlCvwiqDMYEgKBLzk4ZPp8A1fqGx07nvNgK
         8Y85MybGN73hoERI0YkZm7N/Z/WLNWaudZt8k3ioks8tgUwP2ByMpLZTU5KaR1Tvqb19
         ZeBzKT/NzlvHHNzYKcdOqkToj2l5RLiUU0/ucxwhhGoo5gAA3oZuOAF4+FgVs7TjJvw0
         nZ3KXEfioW/dBBmEsq+zi4/80oQYIrx4RRGRnSv55YYvtKwLMa1dgV7a2gfXh+gLNTvw
         iyYQ==
X-Gm-Message-State: AO0yUKXopa06eTyZz22WljrO7f1fviB5YOus5cZI32XsHX6y2M29CmhA
        15xQxPYqj/tjVA5A3ACtNwKyew==
X-Google-Smtp-Source: AK7set9ehn75y2XWNkPUpVRaBxTeSU/AIruLsrp991MJbOjiINawskgybpuVPxfn4XXVCiOAFPDYkw==
X-Received: by 2002:a17:902:a606:b0:19c:fa22:e984 with SMTP id u6-20020a170902a60600b0019cfa22e984mr5250803plq.48.1677675574111;
        Wed, 01 Mar 2023 04:59:34 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027d8900b0019e30e3068bsm3374458plm.168.2023.03.01.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 04:59:33 -0800 (PST)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     xiang@kernel.org, chao@kernel.org, gerry@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH V2] erofs: support flattened block device for multi-blob images
Date:   Wed,  1 Mar 2023 20:59:08 +0800
Message-Id: <20230301125908.30879-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support mounting multi-blobs container image as a single
block device, add flattened block device feature for EROFS.

In this mode, all meta/data contents will be mapped into one block
address. User could compose a block device(by nbd/ublk/virtio-blk/
vhost-user-blk) from multiple sources and mount the block device by
EROFS directly. It can reduce the number of block devices used, and
it's also benefits in both VM file passthrough and distributed storage
scenarios.

You can test this using the method mentioned by:
https://github.com/dragonflyoss/image-service/pull/1111
1. Compose a (nbd)block device from multi-blobs.
2. Mount EROFS on mntdir/.
3. Compare the md5sum between source dir and mntdir/.

Later, we could also use it to refer original tar blobs.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
v2:
1. Supplement commit message.
2. Add a bool field in erofs_dev_context to indicate flattened block
   device mode.
---
 fs/erofs/data.c     | 8 ++++++--
 fs/erofs/internal.h | 1 +
 fs/erofs/super.c    | 6 +++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e16545849ea7..818f78ce648c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -197,7 +197,6 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	struct erofs_device_info *dif;
 	int id;
 
-	/* primary device by default */
 	map->m_bdev = sb->s_bdev;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
@@ -210,12 +209,17 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return -ENODEV;
 		}
+		if (devs->flatdev) {
+			map->m_pa += blknr_to_addr(dif->mapped_blkaddr);
+			up_read(&devs->rwsem);
+			return 0;
+		}
 		map->m_bdev = dif->bdev;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
 		up_read(&devs->rwsem);
-	} else if (devs->extra_devices) {
+	} else if (devs->extra_devices && !devs->flatdev) {
 		down_read(&devs->rwsem);
 		idr_for_each_entry(&devs->tree, dif, id) {
 			erofs_off_t startoff, length;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3f3561d37d1b..4fee380a98d9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -81,6 +81,7 @@ struct erofs_dev_context {
 	struct rw_semaphore rwsem;
 
 	unsigned int extra_devices;
+	bool flatdev;
 };
 
 struct erofs_fs_context {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 19b1ae79cec4..307b3d2392cf 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -248,7 +248,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (IS_ERR(fscache))
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
-	} else {
+	} else if (!sbi->devs->flatdev) {
 		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
 					  sb->s_type);
 		if (IS_ERR(bdev))
@@ -281,6 +281,10 @@ static int erofs_scan_devices(struct super_block *sb,
 	else
 		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
 
+	if (!sbi->devs->extra_devices && ondisk_extradevs &&
+		!erofs_is_fscache_mode(sb))
+		sbi->devs->flatdev = true;
+
 	if (sbi->devs->extra_devices &&
 	    ondisk_extradevs != sbi->devs->extra_devices) {
 		erofs_err(sb, "extra devices don't match (ondisk %u, given %u)",
-- 
2.20.1

