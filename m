Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9255E8293
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiIWTbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIWTbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:31:34 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E0F12DEAE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:31:32 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s26so1132453pgv.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=IS4nNAzBPF0uuTNWg/cnPlHg+o/lu3+gLEaK/JvSxp4=;
        b=i6GDjkXToyYmLBN0Br10nKQ+6R7LjfZd0vaTb4adICEFiCGXoNDWYvUPmMHo/6xyjn
         NkXgtTZYnVC5so8hacrWyLRnOUUuANpubWU6NNvhr2Aa/jgGavwy4VhGMXWpaUlqxCre
         3xCNO3VG6uKV/Ff4XtpgrItnzSRckZPZ4kcUpW7HQ+y/db912rJHKtfGj0V3DL8wrVan
         MzqbKL3nOopOquRlGsT9NQ2en64IN+u7KolgLwvOThB+Yk/ZSS5YY7TeHC9TYwYs/ZgX
         uSCOoCl7EUvb8qtTSBWAH1c96PH0pEATwcQkgZdSoSH9jr/UNVUnz2M6wFh3ewHbFAMK
         q4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IS4nNAzBPF0uuTNWg/cnPlHg+o/lu3+gLEaK/JvSxp4=;
        b=1ESTWuUWssc8vwQvKqqSSj4GQD6gVgiVke2P9MCI/KFbo+L8nWAk3HtqZNbKLWCBtJ
         lAYJGtpkvYuwPiSAnMiGueCLYAMuHYpLlWSuwPAru88JcsjZqPut/YZGX39wwnhkKLgh
         iHY9g3sl19rJUDclSGoiSywwVJzTw4JQlpvqewpK0pwpY22sVPjDrtU3SMmFFvmdA57q
         +BhTjw2dwgTy5Tvy6oNs/iLy+li7LqSd5MB+tv1OKWcBTmVqy0IMSbRKXiILDgbKHNHA
         DVL9mJ2oAyqBxs9pTFvOYTmtLnj8+zOMm/2JurxTMoJVtgbht9veN0c52ynKBV0t3sSv
         rMvA==
X-Gm-Message-State: ACrzQf0F4y9DblGoV1gLJshnOaXFV5T92nC+KOwWxKwvT7MSydzeC29g
        Mu0Rf5bMTIL2BOmvYMQS5yQ=
X-Google-Smtp-Source: AMsMyM4+upvKRbK6ZwLtBdh6T9Fe4Ink+s6GkZQeHEs5IY4CNG989Nqe418WXut+EdKaJ9f4d5lz3A==
X-Received: by 2002:a63:5d52:0:b0:439:36bb:c07c with SMTP id o18-20020a635d52000000b0043936bbc07cmr9128555pgm.272.1663961492105;
        Fri, 23 Sep 2022 12:31:32 -0700 (PDT)
Received: from google.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id nh23-20020a17090b365700b00202fbd9c21dsm1944016pjb.48.2022.09.23.12.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:31:31 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 23 Sep 2022 19:31:30 +0000
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Rom Lemarchand <romlem@google.com>, linux-mm@kvack.org
Subject: Re: [RESEND RFC] zram: Allow rw_page when page isn't written back.
Message-ID: <Yy4JkpZ/SnXtrVRf@google.com>
References: <20220908125037.1119114-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908125037.1119114-1-bgeffon@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:50:37AM -0400, Brian Geffon wrote:
> Today when a zram device has a backing device we change the ops to
> a new set which does not expose a rw_page method. This prevents the
> upper layers from trying to issue a synchronous rw. This has the
> downside that we penalize every rw even when it could possibly

Do you mean addiontal bio alloc/free?
Please specify something more detail.

> still be performed as a synchronous rw. By the very nature of

Even though zram go though the block layer in the case, it's still
synchronous operation against on in-memory compressed data. Only
asynchrnous IO happens for the data in backing device.

> zram all writes are synchronous so it's unfortunate to have to
> accept this limitation.
> 
> This change will always expose a rw_page function and if the page
> has been written back it will return -EOPNOTSUPP which will force the
> upper layers to try again with bio.

Sounds a good idea.

> 
> To safely allow a synchronous read to proceed for pages which have not
> yet written back we introduce a new flag ZRAM_NO_WB. On the first
> synchronous read if the page is not written back we will set the
> ZRAM_NO_WB flag. This flag, which is never cleared, prevents writeback
> from ever happening to that page.

Why do we need a addtional flag?
Why couldn't we do?

1. expose the rw_page all the time.
2. If the page was written back, just return an error in rw_page to make
upper layer retry it with bio.

> 
> This approach works because in the case of zram as a swap backing device
> the page is going to be removed from zram shortly thereafter so
> preventing writeback is fine. However, if zram is being used as a
> generic block device then this might prevent writeback of the page.
> 
> This proposal is still very much RFC, feedback would be appreciated.
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  drivers/block/zram/zram_drv.c | 68 +++++++++++++++++++++--------------
>  drivers/block/zram/zram_drv.h |  1 +
>  2 files changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 92cb929a45b7..22b69e8b6042 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -52,9 +52,6 @@ static unsigned int num_devices = 1;
>  static size_t huge_class_size;
>  
>  static const struct block_device_operations zram_devops;
> -#ifdef CONFIG_ZRAM_WRITEBACK
> -static const struct block_device_operations zram_wb_devops;
> -#endif
>  
>  static void zram_free_page(struct zram *zram, size_t index);
>  static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
> @@ -309,7 +306,8 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
>  		 */
>  		zram_slot_lock(zram, index);
>  		if (zram_allocated(zram, index) &&
> -				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> +				!zram_test_flag(zram, index, ZRAM_UNDER_WB) &&
> +				!zram_test_flag(zram, index, ZRAM_NO_WB)) {
>  #ifdef CONFIG_ZRAM_MEMORY_TRACKING
>  			is_idle = !cutoff || ktime_after(cutoff, zram->table[index].ac_time);
>  #endif
> @@ -439,7 +437,6 @@ static void reset_bdev(struct zram *zram)
>  	filp_close(zram->backing_dev, NULL);
>  	zram->backing_dev = NULL;
>  	zram->bdev = NULL;
> -	zram->disk->fops = &zram_devops;
>  	kvfree(zram->bitmap);
>  	zram->bitmap = NULL;
>  }
> @@ -543,17 +540,6 @@ static ssize_t backing_dev_store(struct device *dev,
>  	zram->backing_dev = backing_dev;
>  	zram->bitmap = bitmap;
>  	zram->nr_pages = nr_pages;
> -	/*
> -	 * With writeback feature, zram does asynchronous IO so it's no longer
> -	 * synchronous device so let's remove synchronous io flag. Othewise,
> -	 * upper layer(e.g., swap) could wait IO completion rather than
> -	 * (submit and return), which will cause system sluggish.
> -	 * Furthermore, when the IO function returns(e.g., swap_readpage),
> -	 * upper layer expects IO was done so it could deallocate the page
> -	 * freely but in fact, IO is going on so finally could cause
> -	 * use-after-free when the IO is really done.
> -	 */
> -	zram->disk->fops = &zram_wb_devops;
>  	up_write(&zram->init_lock);
>  
>  	pr_info("setup backing device %s\n", file_name);
> @@ -722,7 +708,8 @@ static ssize_t writeback_store(struct device *dev,
>  
>  		if (zram_test_flag(zram, index, ZRAM_WB) ||
>  				zram_test_flag(zram, index, ZRAM_SAME) ||
> -				zram_test_flag(zram, index, ZRAM_UNDER_WB))
> +				zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
> +				zram_test_flag(zram, index, ZRAM_NO_WB))
>  			goto next;
>  
>  		if (mode & IDLE_WRITEBACK &&
> @@ -1226,6 +1213,10 @@ static void zram_free_page(struct zram *zram, size_t index)
>  		goto out;
>  	}
>  
> +	if (zram_test_flag(zram, index, ZRAM_NO_WB)) {
> +		zram_clear_flag(zram, index, ZRAM_NO_WB);
> +	}
> +
>  	/*
>  	 * No memory is allocated for same element filled pages.
>  	 * Simply clear same page flag.
> @@ -1654,6 +1645,40 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
>  	index = sector >> SECTORS_PER_PAGE_SHIFT;
>  	offset = (sector & (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
>  
> +#ifdef CONFIG_ZRAM_WRITEBACK
> +	/*
> +	 * With writeback feature, zram does asynchronous IO so it's no longer
> +	 * synchronous device so let's remove synchronous io flag. Othewise,
> +	 * upper layer(e.g., swap) could wait IO completion rather than
> +	 * (submit and return), which will cause system sluggish.
> +	 * Furthermore, when the IO function returns(e.g., swap_readpage),
> +	 * upper layer expects IO was done so it could deallocate the page
> +	 * freely but in fact, IO is going on so finally could cause
> +	 * use-after-free when the IO is really done.
> +	 *
> +	 * If the page is not currently written back then we may proceed to
> +	 * read the page synchronously, otherwise, we must fail with
> +	 * -EOPNOTSUPP to force the upper layers to use a normal bio.
> +	 */
> +	zram_slot_lock(zram, index);
> +	if (zram_test_flag(zram, index, ZRAM_WB) ||
> +			zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> +		zram_slot_unlock(zram, index);
> +		/* We cannot proceed with synchronous read */
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * Don't allow the page to be written back while we read it,
> +	 * this flag is never cleared. It shouldn't be a problem that
> +	 * we don't clear this flag because in the case of swap this
> +	 * page will be removed shortly after this read anyway.
> +	 */
> +	if (op == REQ_OP_READ)
> +		zram_set_flag(zram, index, ZRAM_NO_WB);
> +	zram_slot_unlock(zram, index);
> +#endif
> +
>  	bv.bv_page = page;
>  	bv.bv_len = PAGE_SIZE;
>  	bv.bv_offset = 0;
> @@ -1827,15 +1852,6 @@ static const struct block_device_operations zram_devops = {
>  	.owner = THIS_MODULE
>  };
>  
> -#ifdef CONFIG_ZRAM_WRITEBACK
> -static const struct block_device_operations zram_wb_devops = {
> -	.open = zram_open,
> -	.submit_bio = zram_submit_bio,
> -	.swap_slot_free_notify = zram_slot_free_notify,
> -	.owner = THIS_MODULE
> -};
> -#endif
> -
>  static DEVICE_ATTR_WO(compact);
>  static DEVICE_ATTR_RW(disksize);
>  static DEVICE_ATTR_RO(initstate);
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index 158c91e54850..20e4c6a579e0 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -50,6 +50,7 @@ enum zram_pageflags {
>  	ZRAM_UNDER_WB,	/* page is under writeback */
>  	ZRAM_HUGE,	/* Incompressible page */
>  	ZRAM_IDLE,	/* not accessed page since last idle marking */
> +	ZRAM_NO_WB,	/* Do not allow page to be written back */
>  
>  	__NR_ZRAM_PAGEFLAGS,
>  };
> -- 
> 2.37.2.789.g6183377224-goog
> 
> 
