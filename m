Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19235B80C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiINFUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiINFUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:20:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9F6050B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:20:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso17797046pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6v08NZDq4S2abgqJ+JFEfe9abxWScFKlQnsatRobtY4=;
        b=W50Z+vmA8bHvPa3uCwVRHlUm2kPzrN4qdMPdlmiNRxKs7xJk5v3DkT87xl1RtfH/Nv
         RW45c7VC8VNtuLaUijxZRjAqM2cd+sDSiFN08AVqxp9zsixOZaz0x551JQvRsADJp5sU
         lS/efD+w5+sagJ6DRhGVaMbiVzi1goAM93Uzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6v08NZDq4S2abgqJ+JFEfe9abxWScFKlQnsatRobtY4=;
        b=mgWUVVzACNW9hTxwP7XhsiSjpTMt3Cz3NrCOk2Nt4UL3Ex72t1J3rKC+DrptegsQ2n
         TUUpaqULOuHRTC0XUbcBIKep1TBEd4EVVdHvtlMo1ri6Z6eIbyskzYBXzdKzn0J5l3Jt
         5ecCUnerj7q/oLgedz2Rs8Ks3/R/2TeXGpZ11YOaST8Xw/cNoS4rP7XIJZ5RfVA9dPlo
         /HHZuv1R//N3jLhvwtqOIaJhTs/CGmClUX5QbbMCkQSfa7oFPtQSZ+Y4qTXqT+H7ix0x
         bvvRp9PNZnsf6tz/ExQq5AbPRkTzhWl7/4GQR8KOwnW5+U+4jI8XOiX+TY5fiV46/zhW
         TRzQ==
X-Gm-Message-State: ACrzQf05e53aGMVkdSUn0xvpgbzWcXu1geGm4iv5jCmpcJRBI8t94buC
        3wRLJz20F9DdXgCsuU0+F4AzEQy4gijFGA==
X-Google-Smtp-Source: AMsMyM5yRJuL017yZAB37mUExDw1x3yFk+iAAudvMT91NvFSRxEO1vSgDfkM9jZCoT3q0eIeJW+koA==
X-Received: by 2002:a17:90b:4a85:b0:202:4f3f:1f65 with SMTP id lp5-20020a17090b4a8500b002024f3f1f65mr2849847pjb.241.1663132843117;
        Tue, 13 Sep 2022 22:20:43 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:2a3e:eafc:89ff:5c3e])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0017849a2b56asm2910203plf.46.2022.09.13.22.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 22:20:42 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: keep comments within 80-columns limit
Date:   Wed, 14 Sep 2022 14:20:33 +0900
Message-Id: <20220914052033.838050-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several trivial fixups (that I should have spotted during review).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index eb021db21ddf..43eeef2b9fbe 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -329,8 +329,8 @@ static ssize_t idle_store(struct device *dev,
 
 	if (!sysfs_streq(buf, "all")) {
 		/*
-		 * If it did not parse as 'all' try to treat it as an integer when
-		 * we have memory tracking enabled.
+		 * If it did not parse as 'all' try to treat it as an integer
+		 * when we have memory tracking enabled.
 		 */
 		u64 age_sec;
 
@@ -345,7 +345,10 @@ static ssize_t idle_store(struct device *dev,
 	if (!init_done(zram))
 		goto out_unlock;
 
-	/* A cutoff_time of 0 marks everything as idle, this is the "all" behavior */
+	/*
+	 * A cutoff_time of 0 marks everything as idle, this is the
+	 * "all" behavior.
+	 */
 	mark_idle(zram, cutoff_time);
 	rv = len;
 
@@ -1416,11 +1419,11 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		if (comp_len != PAGE_SIZE)
 			goto compress_again;
 		/*
-		 * If the page is not compressible, you need to acquire the lock and
-		 * execute the code below. The zcomp_stream_get() call is needed to
-		 * disable the cpu hotplug and grab the zstrm buffer back.
-		 * It is necessary that the dereferencing of the zstrm variable below
-		 * occurs correctly.
+		 * If the page is not compressible, you need to acquire the
+		 * lock and execute the code below. The zcomp_stream_get()
+		 * call is needed to disable the cpu hotplug and grab the
+		 * zstrm buffer back. It is necessary that the dereferencing
+		 * of the zstrm variable below occurs correctly.
 		 */
 		zstrm = zcomp_stream_get(zram->comp);
 	}
-- 
2.37.2.789.g6183377224-goog

