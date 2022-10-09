Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02475F8A47
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJIJIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJIJHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:07:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E594131236
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:07:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d10so8439312pfh.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqM9mWTVfbPsXUXKnKUtd3WdYMNua/MWINqYRXykEKs=;
        b=RKbrhKqsTOg+IHSg3cwCrTY4ZG/+LpdneXqRPTBTZgcz5VO3HHb+9AxHDxUZ3Jb2gQ
         W9+FolOVoU5RPYyTNGMx8TF2g/qhCoAGnRJ1xhcEuqFdZ+9luHiMWlVruTmUYFSKhdIu
         PYKfmU+qpJwUkcvfrhZk58dMiWNXxIm3cM5kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqM9mWTVfbPsXUXKnKUtd3WdYMNua/MWINqYRXykEKs=;
        b=nDAAu3H4tDUJ1/3cUX/3wygXs6b6VJ6xm44Nhjx2YSjBv9BBbl33QZRyk4FscoQFMU
         jP5hG4n3YdmsgGHGwdDq+yVdmupg2vum6/CIpQ106mZaY6b2cF+uhbKavneDyrn3ROgF
         TOkxgHx25AF2+000egX5DkhOYQ9brPwyhAQhRB7xxTLfD/c4OiihK6fyepaUnxT74ZB2
         K8RIHB0HjlztpOBqgechZr/A0hLTOwZPi9613+IwOTtowsLjJG6DsKcl5cnZtrIPx0y3
         gz1T7vuqv/NCZbLDtItGtf0tC8jHS0TG4RrUUmD89L7BFWikYWQlsf+XfxYBheKL/ob5
         kDvg==
X-Gm-Message-State: ACrzQf0VurS29ZbiVOAMRHAP6e7hNJxJ8W/m40XuO8dRmj8nMGdUqtCj
        eriI4UiIfzmHXL7PBbAyuZpoFQ==
X-Google-Smtp-Source: AMsMyM67guaiwP/QYUJO3S8X8Xt6xiCerRRailhF+6FA6YUQCxdLbbWRbAwLSAGadIpcgCrGmDFfEA==
X-Received: by 2002:a63:90ca:0:b0:458:f28d:917e with SMTP id a193-20020a6390ca000000b00458f28d917emr11934116pge.201.1665306458975;
        Sun, 09 Oct 2022 02:07:38 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8517:d51e:5fe9:9be7])
        by smtp.gmail.com with ESMTPSA id q194-20020a632acb000000b00439d071c110sm4335148pgq.43.2022.10.09.02.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:07:38 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 5/8] documentation: Add recompression documentation
Date:   Sun,  9 Oct 2022 18:07:17 +0900
Message-Id: <20221009090720.1040633-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221009090720.1040633-1-senozhatsky@chromium.org>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
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
index 12368e773f3d..143c33bd6783 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1623,9 +1623,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
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
@@ -1708,8 +1706,7 @@ static int zram_recompress(struct zram *zram,
 
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

