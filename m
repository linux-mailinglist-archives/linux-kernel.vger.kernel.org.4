Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE12463EA19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLAHDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiLAHDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:03:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BBE87C85;
        Wed, 30 Nov 2022 23:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aL3Yz2hAwe0+hwM7my9v/xKV7aioeozADAd4sMrcP+I=; b=Llp8bU0LERX1OZ+AvZZVRp+fTy
        b4YZ+HD7ddl779OegdEuUoOWVx6Fx92KcC5ZmwySvYwU8p3R7HX7SVAtsYhJ6EOmp/kfb/2uwhlEd
        50gAK1Y0RD/YGn76IseNMpxlCGGDYfLnDwj/dEhQi0ILYBZZzaFDHQCQ6BZwJSz5KCEtniXXNzqO6
        in331cahNPs1VVUiYV8bJc5BcQTQg6PWzQGRtobtIuYDYCuX7hzXtsAducoe3JzotMzK3T22gasmu
        OJGag367jYs4xDxCNvxauewbZNh0c7/UXVVcJrNItlrXUgloQEVGToUg0+XggQQKL/oZWiOImZTRE
        6jAnJ4CQ==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0dbj-00FioH-1y; Thu, 01 Dec 2022 07:03:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH] block: bdev & blktrace: use consistent function doc. notation
Date:   Wed, 30 Nov 2022 23:03:31 -0800
Message-Id: <20221201070331.25685-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
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

Use only one hyphen in kernel-doc notation between the function name
and its short description.

The is the documented kerenl-doc format. It also fixes the HTML
presentation to be consistent with other functions.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/bdev.c            |    4 ++--
 kernel/trace/blktrace.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -- a/block/bdev.c b/block/bdev.c
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -224,7 +224,7 @@ int fsync_bdev(struct block_device *bdev
 EXPORT_SYMBOL(fsync_bdev);
 
 /**
- * freeze_bdev  --  lock a filesystem and force it into a consistent state
+ * freeze_bdev - lock a filesystem and force it into a consistent state
  * @bdev:	blockdevice to lock
  *
  * If a superblock is found on this device, we take the s_umount semaphore
@@ -268,7 +268,7 @@ done:
 EXPORT_SYMBOL(freeze_bdev);
 
 /**
- * thaw_bdev  -- unlock filesystem
+ * thaw_bdev - unlock filesystem
  * @bdev:	blockdevice to unlock
  *
  * Unlocks the filesystem and marks it writeable again after freeze_bdev().
diff -- a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -721,7 +721,7 @@ EXPORT_SYMBOL_GPL(blk_trace_startstop);
  */
 
 /**
- * blk_trace_ioctl: - handle the ioctls associated with tracing
+ * blk_trace_ioctl - handle the ioctls associated with tracing
  * @bdev:	the block device
  * @cmd:	the ioctl cmd
  * @arg:	the argument data, if any
@@ -769,7 +769,7 @@ int blk_trace_ioctl(struct block_device
 }
 
 /**
- * blk_trace_shutdown: - stop and cleanup trace structures
+ * blk_trace_shutdown - stop and cleanup trace structures
  * @q:    the request queue associated with the device
  *
  **/
