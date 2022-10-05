Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10C95F4DD6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJECk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJECkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:40:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB0F71BF9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:40:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w2so14741606pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OE2FzWZV+eK+0K5lMxD8PaF7VIaG8/7NL+uSrdg3shk=;
        b=IYWm7+uiUJMlmGAxYUFbJ3Y2TQXm4KOiJQvfkQpRrYYY3E7rL+drqW7q86flsucQI+
         D8O0A24NGkLEjU7Vsd2djdz6g1zvo8xNuVRfcW6JgcdLJYXBh+qzuLi/CKtYYlXQ74Qk
         zYPJZeeH/rjb4G2p0RPHLBjM5kFPujSiPtVF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OE2FzWZV+eK+0K5lMxD8PaF7VIaG8/7NL+uSrdg3shk=;
        b=7i2hP4cAkjQKnIjesJvOil8DtMSKs3Pi+z4KVmVdu96BagXGT5I3oxZVv3LJ8PWMYB
         397FtJSdAuOLARYO0xS5JsPV9FuJ/jqDXzXXmaDZ8nI/wcVni+w28weT5yV22eLH7Twt
         NIavIZQLKI9cVT7Fbz3LHwMslJuDreCVrCpyRGim8h9Co+2HwNGgryRUQop7C6W48Uk9
         Dfgm8/tvvAIDI+tK+pnKpkx++oFbmaUFa49sTndg/qqOppPhFEPLrveTh8kqoTrNVGU7
         lAjbR5xwkvSB4CwdRAEgMPnpnkZKJnRzS8H28t8njbedzNwSaf1c7mbCUzaaxLRUs64g
         TmNw==
X-Gm-Message-State: ACrzQf2+ib8evBVaIcu97vg5vGLmVYarUnHhwLp/JYYEASOtP7LPcg9i
        afAhZF91SPN+267VUMMYPSJI9g==
X-Google-Smtp-Source: AMsMyM7LvfXGCUBNVeyayt3p5M2B1olhIPbKqEPWsqDdIwx3njBFDBv51oEjFvZ0UTnMdcsvzhllhQ==
X-Received: by 2002:a65:6908:0:b0:44e:1349:1108 with SMTP id s8-20020a656908000000b0044e13491108mr11473463pgq.180.1664937634586;
        Tue, 04 Oct 2022 19:40:34 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:a9d9:6396:ee12:8be8])
        by smtp.gmail.com with ESMTPSA id a14-20020aa794ae000000b00561e010a309sm1673579pfl.19.2022.10.04.19.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 19:40:34 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 5/8] documentation: Add recompression documentation
Date:   Wed,  5 Oct 2022 11:40:11 +0900
Message-Id: <20221005024014.22914-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221005024014.22914-1-senozhatsky@chromium.org>
References: <20221005024014.22914-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document user-space visible device attributes that
are enabled by ZRAM_MULTI_COMP.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 55 +++++++++++++++++++++
 drivers/block/zram/zram_drv.c               |  7 +--
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index c73b16930449..88957fcb6ad7 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -401,6 +401,61 @@ budget in next setting is user's job.
 If admin wants to measure writeback count in a certain period, they could
 know it via /sys/block/zram0/bd_stat's 3rd column.
 
+recompression
+-------------
+
+With CONFIG_ZRAM_MULTI_COMP, zram can recompress idle/huge pages using
+alternative (secondary) compression algorithm. The basic idea is that
+alternative compression algorithm can provide better compression ratio
+at a price of (potentially) slower compression/decompression speeds.
+Alternative compression algorithm can, for example, be more successful
+compressing huge pages (those that default algorithm failed to compress).
+Another application is idle pages recompression - pages that are cold and
+sit in the memory can be recompressed using more effective algorithm and,
+hence, reduce zsmalloc memory usage.
+
+With CONFIG_ZRAM_MULTI_COMP, zram will setup two compression algorithms
+per-CPU: primary and secondary ones. Primary zram compressor is explained
+in "3) Select compression algorithm", the secondary algorithm is configured
+in a similar way, using recomp_algorithm device attribute:
+
+Examples::
+
+	#show supported recompression algorithms
+	cat /sys/block/zramX/recomp_algorithm
+	zstd [lzo]
+
+	#select zstd recompression algorithm
+	echo zstd > /sys/block/zramX/recomp_algorithm
+
+Another device attribute that CONFIG_ZRAM_MULTI_COMP enables is recompress,
+which controls recompression:
+
+Examples::
+
+	#IDLE pages recompression is activated by `idle` mode
+	echo idle > /sys/block/zramX/recompress
+
+	#HUGE pages recompression is activated by `huge` mode
+	echo huge > /sys/block/zram0/recompress
+
+	#HUGE_IDLE pages recompression is activated by `huge_idle` mode
+	echo huge_idle > /sys/block/zramX/recompress
+
+The number of idle pages can be significant, so user-space can pass a size
+watermark value to the recompress knob, to filter out idle pages for
+recompression: zram will recompress only idle pages of equal or greater
+size:::
+
+	#recompress idle pages larger than 3000 bytes
+	echo 3000 > /sys/block/zramX/recompress
+
+	#recompress idle pages larger than 2000 bytes
+	echo 2000 > /sys/block/zramX/recompress
+
+Recompression is mostly focused on idle pages (except for huge pages
+recompression), so it works better in conjunction with memory tracking.
+
 memory tracking
 ===============
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aacabaefb0c7..077a0bc60b8d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1622,9 +1622,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
  *
  * Corresponding ZRAM slot should be locked.
  */
-static int zram_recompress(struct zram *zram,
-			   u32 index,
-			   struct page *page,
+static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 			   int size_watermark)
 {
 	unsigned long handle_prev;
@@ -1707,8 +1705,7 @@ static int zram_recompress(struct zram *zram,
 
 static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
-				const char *buf,
-				size_t len)
+				const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

