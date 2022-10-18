Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C22602171
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJRCvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiJRCuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:50:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0A876770
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:50:38 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-131dda37dddso15495695fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=slMDEqnbpFnTUvP2AfkwYXb6IrKIh9E+X/5e6tGK6FI=;
        b=Lvrit6Zx0/wIGgadBd1fD/KvSKmD0D2Pn/xdG8fSuAPis2TrCd00K4K6G8MtoD4BQK
         G80T1ubUkaq67cDR0oKvG0kHfa4I7CXBDaQnnbIZsInbVpfbcMJ4FFthLgOv9G8KAtuW
         6fhf6ju9oZdjDI2SLJ8nxNI3eVaQjj18+Wzw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slMDEqnbpFnTUvP2AfkwYXb6IrKIh9E+X/5e6tGK6FI=;
        b=6SwPGBUX8/kashGX2jSJGzV7CR+8DGugkz1sVDXXVSuvaBU0XXZ4cH7yeWXTPeePCO
         MK7QrC051PK7GBdWx+/4W5a4ga2FUhkPC4r7S2xerSA7uUGo+HOdWcufjpZ9w9PZIcHQ
         Os1LpEmqHU4DDuP/s7RGy53v8T0BJ9eqi+0Ps5zDOVOEJ6QOMVXyCcWnhSH1U6GVKS+l
         tOL+vw4j5YYQurEWhMlQaTDEJv/aKbiE3Z0t4jkBAz5ju4TujoYxogiHyhHXHPwtQR8M
         6mpMWAm7h8Q4+jeBsRL8rcm2gqLv+5t1bAmzCt+dARtqUc4x6AmMm8IM+cLupIZOIyEd
         tR0w==
X-Gm-Message-State: ACrzQf3Vsce2rRrnWfc86u8bdmRvE2rj+sAGZbV7kL0mR8NOkSdL/AcP
        hn+8gTINf7OtexX9+LMJMtXT2t9Xv01IsA==
X-Google-Smtp-Source: AMsMyM4xC4bK7U0RLuMWnAn5CmABJYFfIeHjIKIYhQKAGqnhAK7lfQZcKc4XVtnBsV1GueqCkGMLtQ==
X-Received: by 2002:a17:90b:3ec4:b0:20d:93bc:32fb with SMTP id rm4-20020a17090b3ec400b0020d93bc32fbmr32880671pjb.124.1666061426063;
        Mon, 17 Oct 2022 19:50:26 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:58b4:95a3:4654:2a9f])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b00183ba0fd54dsm7296482pln.262.2022.10.17.19.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:50:25 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:50:21 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv3 5/8] documentation: Add recompression documentation
Message-ID: <Y04UbTZh3fJYPhvJ@google.com>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
 <20221009090720.1040633-6-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009090720.1040633-6-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 1 file changed, 55 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index c73b16930449..f09e778bc3dc 100644
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
+watermark (in bytes) value to the recompress knob, to filter out idle pages
+for recompression: zram will recompress only idle pages of equal or greater
+size (bytes):::
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
 
-- 
2.38.0.413.g74048e4d9e-goog

