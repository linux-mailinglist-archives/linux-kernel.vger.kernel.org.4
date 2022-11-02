Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6FF616F5C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiKBVGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKBVGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:06:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70389DF31
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:06:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 4so81210pli.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyBR8q6vPJ8uwnbMvvYJLoaYg4ZughhH660zkN1uyNk=;
        b=pYTjrSMBeB2o9VgbRz34nvpJQZx8zl/Nn9DkPH/7IxSunSt4jM4z2TnUGnRXGfS47O
         j5G7DR1+G9giscYOgsQhpWtJ6aiuXAj0GHaWVukcWGx12YIxLpY9HSTYn3tE0fFDAmax
         ocYPOXWPOrni9CNb00GAgubL0AtkaN47zHqzQe36OIjSkDaw9tToNdMmFYJ6DVmNkv3H
         OlLcQCVx0EO3LE5naQaLnISpb6g/I/W/ACO+fQIEunqgrE8jZoh7nx4ZMLDwTm4AdU05
         SO3J/GM5msnAv8zWgQXbNLb7EAee8Ul1/SFSxp0Kyz3e380CeDLA83wVs15e4uDCkziP
         oT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyBR8q6vPJ8uwnbMvvYJLoaYg4ZughhH660zkN1uyNk=;
        b=l8hgpef4wITTzH8VT5XEdvMC3Ylg4oIjBeYmP0wsaFZnFtcnIW36Z6qMtr2TXUZKwA
         /GgtsDYLRPA3TM0rO1lSTSP8vmfQUxJI42pnj3EduONfXk/8b2fZfSK67kwrcTtxGEUT
         /uRffRo/jRxdhFwGCM3TDKejxKrPinaL229h4AuiZg8xJE72vTBDxPS2rBvm8YeTk4jB
         G5bsVjXa475PoK/xiG59QGUWEfIM9rwNDo02f9VN+h3x9wCI7qVqCcc+9uVcxomWGqz9
         ijOmllGS+FNGcG8YS335iiZOwRc9uXMP/YNLFEgha5pop/aAROzrF4/VTKmlf/mBd/eZ
         L3uA==
X-Gm-Message-State: ACrzQf2XUJWMueyLXDNzqNtIwguLtwS9tfGo5nKbzk8NnfY/4o29ot8I
        nyXwY+Lm59OeNRLn7sg3wvI=
X-Google-Smtp-Source: AMsMyM4ElanxJccFkhGPLPJkPGkzGWTkhu1f+vIvL/xFCfvTWHImEh8Wul2MzHofkwGf/bdPRmTygQ==
X-Received: by 2002:a17:90a:4bca:b0:212:e3df:abfc with SMTP id u10-20020a17090a4bca00b00212e3dfabfcmr27733620pjl.242.1667423176797;
        Wed, 02 Nov 2022 14:06:16 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3fd5:8614:6eb0:846b])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902f60e00b0018696c5d61esm8748746plg.151.2022.11.02.14.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:06:16 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 2 Nov 2022 14:06:14 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2Lbxp6to4QNYyGe@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018045533.2396670-5-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:55:28PM +0900, Sergey Senozhatsky wrote:
> Allow zram to recompress (using secondary compression streams)
> pages. We support three modes:
> 
> 1) IDLE pages recompression is activated by `idle` mode
> 
> 	echo idle > /sys/block/zram0/recompress
> 
> 2) Since there may be many idle pages user-space may pass a size
> watermark value (in bytes) and we will recompress IDLE pages only
> of equal or greater size:
> 
> 	echo 888 > /sys/block/zram0/recompress

Hmm, how about having seperate knob for threshold?

recompress_threshold

With that, we could make rescompress 888 and idle/huge
as well as only 888.

  echo 888 > /sys/block/zram0/recompress_threshold
  echo 1 > /sys/block/zram0/recompress

  or

  echo 888 > /sys/block/zram0/recompress_threshold
  echo idle > /sys/block/zram0/recompress

or we can introduce the threshold with action item.
  
  echo "idle 888" > /sys/block/zram0/recompress
  echo "huge 888" > /sys/block/zram0/recompress
  echo "normal 888" > /sys/block/zram0/recompress

> 
> 3) HUGE pages recompression is activated by `huge` mode
> 
> 	echo huge > /sys/block/zram0/recompress
> 
> 4) HUGE_IDLE pages recompression is activated by `huge_idle` mode
> 
> 	echo huge_idle > /sys/block/zram0/recompress
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/Kconfig    |  15 +++
>  drivers/block/zram/zram_drv.c | 196 +++++++++++++++++++++++++++++++++-
>  drivers/block/zram/zram_drv.h |   2 +
>  3 files changed, 210 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index d4100b0c083e..3e00656a6f8a 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -78,3 +78,18 @@ config ZRAM_MEMORY_TRACKING
>  	  /sys/kernel/debug/zram/zramX/block_state.
>  
>  	  See Documentation/admin-guide/blockdev/zram.rst for more information.
> +
> +config ZRAM_MULTI_COMP
> +	bool "Enable multiple per-CPU compression streams"

per-CPU is implementation detail. Let's do not mention it.

> +	depends on ZRAM
> +	help
> +	This will enable per-CPU multi-compression streams, so that ZRAM

      indentation

> +	can re-compress IDLE/huge pages, using a potentially slower but
> +	more effective compression algorithm. Note, that IDLE page support
> +	requires ZRAM_MEMORY_TRACKING.
> +
> +          echo TIMEOUT > /sys/block/zramX/idle
> +          echo SIZE > /sys/block/zramX/recompress
> +
> +	SIZE (in bytes) parameter sets the object size watermark: idle
> +	objects that are of a smaller size will not get recompressed.
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 94c62d7ea818..da11560ecf70 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1282,6 +1282,12 @@ static void zram_free_page(struct zram *zram, size_t index)
>  		atomic64_dec(&zram->stats.huge_pages);
>  	}
>  
> +	if (zram_test_flag(zram, index, ZRAM_RECOMP))
> +		zram_clear_flag(zram, index, ZRAM_RECOMP);
> +
> +	if (zram_test_flag(zram, index, ZRAM_RECOMP_SKIP))
> +		zram_clear_flag(zram, index, ZRAM_RECOMP_SKIP);

Let's squeeze the comp algo index into meta area since we have
some rooms for the bits. Then can we could remove the specific
recomp two flags?

I am thinking the feature to work incoming pages on the fly,
not only for recompress manual knob so it would be good
if we could make the interface abstract to work something
like this(I may miss something why we couldn't. I need more
time to look into then)

zram_bvec_write:

    for (i = 0; i < MAX_COMP_ALGO; i++) {
        zstrm = zcomp_stream_get(i);
        zcomp_compress(src, &comp_len);
        if (comp_len > threshold) {
            zcomp_stream_put(i);
            continue;
        }
        break;
    }

zram_bvec_read:
    algo_idx = zram_get_algo_idx(zram, index);
    zstrm = zcomp_stream_get(zram, algo_idx);
    zcomp_decompress(zstrm);
    zcomp_stream_put(zram, algo_idx);


> +
>  	if (zram_test_flag(zram, index, ZRAM_WB)) {
>  		zram_clear_flag(zram, index, ZRAM_WB);
>  		free_block_bdev(zram, zram_get_element(zram, index));
> @@ -1343,6 +1349,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>  	unsigned long handle;
>  	unsigned int size;
>  	void *src, *dst;
> +	u32 idx;
>  	int ret;
>  
>  	handle = zram_get_handle(zram, index);
> @@ -1359,8 +1366,13 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>  
>  	size = zram_get_obj_size(zram, index);
>  
> -	if (size != PAGE_SIZE)
> -		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP]);
> +	if (size != PAGE_SIZE) {
> +		idx = ZRAM_PRIMARY_ZCOMP;
> +		if (zram_test_flag(zram, index, ZRAM_RECOMP))
> +			idx = ZRAM_SECONDARY_ZCOMP;
> +
> +		zstrm = zcomp_stream_get(zram->comps[idx]);
> +	}
>  
>  	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
>  	if (size == PAGE_SIZE) {
> @@ -1372,7 +1384,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>  		dst = kmap_atomic(page);
>  		ret = zcomp_decompress(zstrm, src, size, dst);
>  		kunmap_atomic(dst);
> -		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
> +		zcomp_stream_put(zram->comps[idx]);
>  	}
>  	zs_unmap_object(zram->mem_pool, handle);
>  	return ret;
> @@ -1603,6 +1615,182 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_ZRAM_MULTI_COMP
> +/*
> + * This function will decompress (unless it's ZRAM_HUGE) the page and then
> + * attempt to compress it using secondary compression algorithm (which is
> + * potentially more effective).
> + *
> + * Corresponding ZRAM slot should be locked.
> + */
> +static int zram_recompress(struct zram *zram, u32 index, struct page *page,
> +			   int size_watermark)
> +{
> +	unsigned long handle_prev;
> +	unsigned long handle_next;
> +	unsigned int comp_len_next;
> +	unsigned int comp_len_prev;

How about orig_handle and new_nandle with orig_comp_len and new_comp_len?

> +	struct zcomp_strm *zstrm;
> +	void *src, *dst;
> +	int ret;
> +
> +	handle_prev = zram_get_handle(zram, index);
> +	if (!handle_prev)
> +		return -EINVAL;
> +
> +	comp_len_prev = zram_get_obj_size(zram, index);
> +	/*
> +	 * Do not recompress objects that are already "small enough".
> +	 */
> +	if (comp_len_prev < size_watermark)
> +		return 0;
> +
> +	ret = zram_read_from_zspool(zram, page, index);
> +	if (ret)
> +		return ret;
> +
> +	zstrm = zcomp_stream_get(zram->comps[ZRAM_SECONDARY_ZCOMP]);
> +	src = kmap_atomic(page);
> +	ret = zcomp_compress(zstrm, src, &comp_len_next);
> +	kunmap_atomic(src);
> +
> +	/*
> +	 * Either a compression error or we failed to compressed the object
> +	 * in a way that will save us memory. Mark the object so that we
> +	 * don't attempt to re-compress it again (RECOMP_SKIP).
> +	 */
> +	if (comp_len_next >= huge_class_size ||
> +	    comp_len_next >= comp_len_prev ||
> +	    ret) {
> +		zram_set_flag(zram, index, ZRAM_RECOMP_SKIP);
> +		zram_clear_flag(zram, index, ZRAM_IDLE);
> +		zcomp_stream_put(zram->comps[ZRAM_SECONDARY_ZCOMP]);
> +		return ret;
> +	}
> +
> +	/*
> +	 * No direct reclaim (slow path) for handle allocation and no
> +	 * re-compression attempt (unlike in __zram_bvec_write()) since
> +	 * we already have stored that object in zsmalloc. If we cannot
> +	 * alloc memory for recompressed object then we bail out and
> +	 * simply keep the old (existing) object in zsmalloc.
> +	 */
> +	handle_next = zs_malloc(zram->mem_pool, comp_len_next,
> +				__GFP_KSWAPD_RECLAIM |
> +				__GFP_NOWARN |
> +				__GFP_HIGHMEM |
> +				__GFP_MOVABLE);
> +	if (IS_ERR((void *)handle_next)) {
> +		zcomp_stream_put(zram->comps[ZRAM_SECONDARY_ZCOMP]);
> +		return PTR_ERR((void *)handle_next);
> +	}
> +
> +	dst = zs_map_object(zram->mem_pool, handle_next, ZS_MM_WO);
> +	memcpy(dst, zstrm->buffer, comp_len_next);
> +	zcomp_stream_put(zram->comps[ZRAM_SECONDARY_ZCOMP]);
> +
> +	zs_unmap_object(zram->mem_pool, handle_next);
> +
> +	zram_free_page(zram, index);
> +	zram_set_handle(zram, index, handle_next);
> +	zram_set_obj_size(zram, index, comp_len_next);
> +
> +	zram_set_flag(zram, index, ZRAM_RECOMP);
> +	atomic64_add(comp_len_next, &zram->stats.compr_data_size);
> +	atomic64_inc(&zram->stats.pages_stored);
> +
> +	return 0;
> +}
> +
> +#define RECOMPRESS_IDLE		(1 << 0)
> +#define RECOMPRESS_HUGE		(1 << 1)
> +
> +static ssize_t recompress_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
> +	unsigned long index;
> +	struct page *page;
> +	ssize_t ret;
> +	int mode, size_watermark = 0;
> +
> +	if (sysfs_streq(buf, "idle")) {
> +		mode = RECOMPRESS_IDLE;
> +	} else if (sysfs_streq(buf, "huge")) {
> +		mode = RECOMPRESS_HUGE;
> +	} else if (sysfs_streq(buf, "huge_idle")) {
> +		mode = RECOMPRESS_IDLE | RECOMPRESS_HUGE;
> +	} else {
> +		/*
> +		 * We will re-compress only idle objects equal or greater
> +		 * in size than watermark.
> +		 */
> +		ret = kstrtoint(buf, 10, &size_watermark);
> +		if (ret)
> +			return ret;
> +		mode = RECOMPRESS_IDLE;
> +	}
> +
> +	if (size_watermark > PAGE_SIZE)

nit: How about threshold instead of watermark? 

> +		return -EINVAL;
> +
> +	down_read(&zram->init_lock);
> +	if (!init_done(zram)) {
> +		ret = -EINVAL;
> +		goto release_init_lock;
> +	}
> +
> +	page = alloc_page(GFP_KERNEL);
> +	if (!page) {
> +		ret = -ENOMEM;
> +		goto release_init_lock;
> +	}
> +
> +	ret = len;
> +	for (index = 0; index < nr_pages; index++) {
> +		int err = 0;
> +
> +		zram_slot_lock(zram, index);
> +
> +		if (!zram_allocated(zram, index))
> +			goto next;
> +
> +		if (mode & RECOMPRESS_IDLE &&
> +		    !zram_test_flag(zram, index, ZRAM_IDLE))
> +			goto next;
> +
> +		if (mode & RECOMPRESS_HUGE &&
> +		    !zram_test_flag(zram, index, ZRAM_HUGE))
> +			goto next;
> +
> +		if (zram_test_flag(zram, index, ZRAM_WB) ||
> +		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
> +		    zram_test_flag(zram, index, ZRAM_SAME) ||
> +		    zram_test_flag(zram, index, ZRAM_RECOMP) ||
> +		    zram_test_flag(zram, index, ZRAM_RECOMP_SKIP))
> +			goto next;
> +
> +		err = zram_recompress(zram, index, page, size_watermark);
> +next:
> +		zram_slot_unlock(zram, index);
> +		if (err) {
> +			ret = err;
> +			break;
> +		}
> +
> +		cond_resched();
> +	}
> +
> +	__free_page(page);
> +
> +release_init_lock:
> +	up_read(&zram->init_lock);
> +	return ret;
> +}
> +#endif
> +
>  /*
>   * zram_bio_discard - handler on discard request
>   * @index: physical block index in PAGE_SIZE units
> @@ -1983,6 +2171,7 @@ static DEVICE_ATTR_RW(writeback_limit_enable);
>  #endif
>  #ifdef CONFIG_ZRAM_MULTI_COMP
>  static DEVICE_ATTR_RW(recomp_algorithm);
> +static DEVICE_ATTR_WO(recompress);
>  #endif
>  
>  static struct attribute *zram_disk_attrs[] = {
> @@ -2009,6 +2198,7 @@ static struct attribute *zram_disk_attrs[] = {
>  	&dev_attr_debug_stat.attr,
>  #ifdef CONFIG_ZRAM_MULTI_COMP
>  	&dev_attr_recomp_algorithm.attr,
> +	&dev_attr_recompress.attr,
>  #endif
>  	NULL,
>  };
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index 4044ddbb2326..09b9ceb5dfa3 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -49,6 +49,8 @@ enum zram_pageflags {
>  	ZRAM_UNDER_WB,	/* page is under writeback */
>  	ZRAM_HUGE,	/* Incompressible page */
>  	ZRAM_IDLE,	/* not accessed page since last idle marking */
> +	ZRAM_RECOMP,	/* page was recompressed */
> +	ZRAM_RECOMP_SKIP, /* secondary algorithm cannot compress this page */
>  
>  	__NR_ZRAM_PAGEFLAGS,
>  };
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
> 
