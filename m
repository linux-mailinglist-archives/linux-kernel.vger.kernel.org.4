Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C8624770
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiKJQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiKJQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:48:28 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222EC47305
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:47:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 140so1236208pfz.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GceMGOT23bDdO1sSROQwcwP69H1ZqtgPMLAw5MYkScc=;
        b=APGWSySH0nQ+8O7iWRU1RBBRPkDJD4BGBlNNvOVv2ZH8wyvRuICxAHt2mCA78hzuWr
         a5V6f0KCzdxdcNRV+nHFWc2/hzROgVtbZ4repKZJTuhbyTJ1NoKMR/gHKFSE3NRcShEP
         5NO7lcrAB4okpWmVROknBLQM60yTAB9q7TBwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GceMGOT23bDdO1sSROQwcwP69H1ZqtgPMLAw5MYkScc=;
        b=RLN3VZXD1uIusulElA9veSViNMOWmgb5YNfGd/QfX8iTL9lThfQiHONlnR8Tl7c92s
         194ib+YPH5nMMoY9lGqazH8jCc+pWyxNazmHm0aS4MJBAcMxlDHRaJNANOMRaH6h+L73
         HCareZXXQ02LZJ1InZULXOEJRKVTbYT5OBEZVURsnc8aGl8Pwi7HHw9nr5wB5CffvCfT
         JKmki7saeNrX3lMKop+qiEMhFKfPu6mI5joJFf5cAFaTPJLzettKuGGq9vZeseq1jenP
         hIrHtu5IK8YsctbNfBmvThvlb02+mP6l41orvBWGA9F8FIgiGLDO+a04g63Ji2Cn0qGj
         EDAA==
X-Gm-Message-State: ACrzQf10aTfo3rxpQssre6zDMUZLdLwJSY8/NhxJbx2zJiR7JFRbDjXr
        W0BzsdVNhxqalZdxlc6cJEyFRg==
X-Google-Smtp-Source: AMsMyM7q8wtqwy/hkh/glFOXuhiV3wodhFZXacYSxWn6EtsbfrHYW6QjhuJ8/1DJMeN7KpH68ghfPw==
X-Received: by 2002:aa7:93ae:0:b0:56b:ac5c:f3dc with SMTP id x14-20020aa793ae000000b0056bac5cf3dcmr2934151pff.77.1668098833554;
        Thu, 10 Nov 2022 08:47:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r23-20020a17090b051700b001ef8ab65052sm45974pjz.11.2022.11.10.08.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:47:13 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:47:12 -0800
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Alexey Romanov <avromanov@sberdevices.ru>,
        linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: zram_recompress(): OVERRUN
Message-ID: <202211100847.388C61B3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221110 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Nov 9 20:33:48 2022 -0800
    03e6c729aa64 ("zram: introduce recompress sysfs knob")

Coverity reported the following:

*** CID 1527270:    (OVERRUN)
drivers/block/zram/zram_drv.c:1727 in zram_recompress()
1721     		zstrm = zcomp_stream_get(zram->comps[prio]);
1722     		src = kmap_atomic(page);
1723     		ret = zcomp_compress(zstrm, src, &comp_len_new);
1724     		kunmap_atomic(src);
1725
1726     		if (ret) {
vvv     CID 1527270:    (OVERRUN)
vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
1727     			zcomp_stream_put(zram->comps[prio]);
1728     			return ret;
1729     		}
1730
1731     		class_index_new = zs_lookup_class_index(zram->mem_pool,
1732     							comp_len_new);
drivers/block/zram/zram_drv.c:1786 in zram_recompress()
1780     	handle_new = zs_malloc(zram->mem_pool, comp_len_new,
1781     			       __GFP_KSWAPD_RECLAIM |
1782     			       __GFP_NOWARN |
1783     			       __GFP_HIGHMEM |
1784     			       __GFP_MOVABLE);
1785     	if (IS_ERR_VALUE(handle_new)) {
vvv     CID 1527270:    (OVERRUN)
vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
1786     		zcomp_stream_put(zram->comps[prio]);
1787     		return PTR_ERR((void *)handle_new);
1788     	}
1789
1790     	dst = zs_map_object(zram->mem_pool, handle_new, ZS_MM_WO);
1791     	memcpy(dst, zstrm->buffer, comp_len_new);
drivers/block/zram/zram_drv.c:1737 in zram_recompress()
1731     		class_index_new = zs_lookup_class_index(zram->mem_pool,
1732     							comp_len_new);
1733
1734     		/* Continue until we make progress */
1735     		if (class_index_new >= class_index_old ||
1736     		    (threshold && comp_len_new >= threshold)) {
vvv     CID 1527270:    (OVERRUN)
vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
1737     			zcomp_stream_put(zram->comps[prio]);
1738     			continue;
1739     		}
1740
1741     		/* Recompression was successful so break out */
1742     		break;
drivers/block/zram/zram_drv.c:1721 in zram_recompress()
1715     		 * priority algorithm (or same algorithm).
1716     		 */
1717     		if (prio <= zram_get_priority(zram, index))
1718     			continue;
1719
1720     		num_recomps++;
vvv     CID 1527270:    (OVERRUN)
vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
1721     		zstrm = zcomp_stream_get(zram->comps[prio]);
1722     		src = kmap_atomic(page);
1723     		ret = zcomp_compress(zstrm, src, &comp_len_new);
1724     		kunmap_atomic(src);
1725
1726     		if (ret) {
drivers/block/zram/zram_drv.c:1710 in zram_recompress()
1704     	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
1705     	/*
1706     	 * Iterate the secondary comp algorithms list (in order of priority)
1707     	 * and try to recompress the page.
1708     	 */
1709     	for (; prio < prio_max; prio++) {
vvv     CID 1527270:    (OVERRUN)
vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
1710     		if (!zram->comps[prio])
1711     			continue;
1712
1713     		/*
1714     		 * Skip if the object is already re-compressed with a higher
1715     		 * priority algorithm (or same algorithm).

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527270 ("OVERRUN")
Fixes: 03e6c729aa64 ("zram: introduce recompress sysfs knob")

Thanks for your attention!

-- 
Coverity-bot
