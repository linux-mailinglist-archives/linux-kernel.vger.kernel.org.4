Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82514668E74
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbjAMG4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjAMGzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:55:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B63480AF6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=P7399dbYs0Tw8a+sTJ+KEI7OA4SqtAFmQ3Hydkj1ODQ=; b=nvUNQcqWRe4hfVV2Obyz4zw31C
        o6Wb/RyMiSNy5DxXXsAkZah7S0NKeIm0w/kMvli94hzvAK/UV5PAHfU2zPkQzVlKf/A4x1sYne+hP
        GyY5nOjo/1n3YuDsii3d/qLd7sE3DPNb3U5GgmDybS2cV+nfE9O9FBo5AwOpdPU+8VgWUVJq46dmt
        Q1Lmuh24Vqvbe1yjb7RFMbeiL262iFgsCn/l3R+cVlBLfV8funOY9Y0vt3FKplF0UrzpVcpSBOCrW
        TT1EqsckCp/sh43n/YSF8HlK6EIVgjaPFcaW68HZkU9HWh4ZsqxO9J9+hc1P3i2hyXTmjcaRWKBWQ
        zP80Wocw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDjZ-000qaq-Fq; Fri, 13 Jan 2023 06:40:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] ubi: use correct names in function kernel-doc comments
Date:   Thu, 12 Jan 2023 22:40:12 -0800
Message-Id: <20230113064012.25071-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings by using the correct function names in
their kernel-doc notation:

drivers/mtd/ubi/eba.c:72: warning: expecting prototype for next_sqnum(). Prototype was for ubi_next_sqnum() instead
drivers/mtd/ubi/wl.c:176: warning: expecting prototype for wl_tree_destroy(). Prototype was for wl_entry_destroy() instead
drivers/mtd/ubi/misc.c:24: warning: expecting prototype for calc_data_len(). Prototype was for ubi_calc_data_len() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/ubi/eba.c  |    2 +-
 drivers/mtd/ubi/misc.c |    2 +-
 drivers/mtd/ubi/wl.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -61,7 +61,7 @@ struct ubi_eba_table {
 };
 
 /**
- * next_sqnum - get next sequence number.
+ * ubi_next_sqnum - get next sequence number.
  * @ubi: UBI device description object
  *
  * This function returns next sequence number to use, which is just the current
diff -- a/drivers/mtd/ubi/misc.c b/drivers/mtd/ubi/misc.c
--- a/drivers/mtd/ubi/misc.c
+++ b/drivers/mtd/ubi/misc.c
@@ -10,7 +10,7 @@
 #include "ubi.h"
 
 /**
- * calc_data_len - calculate how much real data is stored in a buffer.
+ * ubi_calc_data_len - calculate how much real data is stored in a buffer.
  * @ubi: UBI device description object
  * @buf: a buffer with the contents of the physical eraseblock
  * @length: the buffer length
diff -- a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -165,7 +165,7 @@ static void wl_tree_add(struct ubi_wl_en
 }
 
 /**
- * wl_tree_destroy - destroy a wear-leveling entry.
+ * wl_entry_destroy - destroy a wear-leveling entry.
  * @ubi: UBI device description object
  * @e: the wear-leveling entry to add
  *
