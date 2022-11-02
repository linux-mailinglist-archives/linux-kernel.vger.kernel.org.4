Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50710616E65
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiKBUPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKBUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:15:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01BE2C6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:15:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h193so8495605pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xu7JflOd18uGlMiTdvvw/mz+tn0m6/gi7ydt7neKoTc=;
        b=MWMtjndavn3QxXSUaUcJYPyjqf2FodmBvzIobjY6w6Bg57MKF5ae0dFBpFtB+vSy5C
         gPaK6auHX1Fd7LCqCmQsBw+uZhIQIOXx2QDMpXy+WKEo1fRCk2nWppA9jHEpKcMLccPR
         dJFlH+qQ2btNQ6lpe1LItZB1WiKvEwFBwNCFqtiRcyFRwwZilTA8TZ5kEw34isnYRFB6
         RgeMxXorS2IxaukabILqimydlc2HKJay0PV+RBZSvSmcp8xzxglHYbLb9R1FFJ43UNhN
         dp360GF4/v64+7+R4aDkBhjmQh0gUxNT+pvAZ6+iV7Tv+Kb+eHr3DbSUem4WHY7fb//a
         zxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xu7JflOd18uGlMiTdvvw/mz+tn0m6/gi7ydt7neKoTc=;
        b=Ci2+dsavOajA6p0K4BgElMmgWNA6USHgmb9PpbN0X5dK1POLiJ6WW1jAyqWVhXMObZ
         +ecTbXUl5Z9G0YhY+ZLEgrZY/kmhiLs/SB50ZPxoMytDieHLx6Ng+fFuX9KkrwC6JoT+
         k34B4si3DoO2+aZRGQozh0lhrNoniJIoM3jD0Zz1JL9nwLK7GjZU9p/ESDpbd6QG636d
         haMHfxg7gElspUTn1RJLbtSdQO6ieJK8BXLwP02fiwbxGpST7Wc8x7BEZaRPtukXXdbc
         6ub/GbujVhOx2BZnlIg0xc0jbEqHW6nXs4zaZDj63OwKxRq4KApQuqztZEyQZpLcSkv7
         wN5A==
X-Gm-Message-State: ACrzQf1LS2QTcXtIw1ipKjn5Sy87whHn8mykwaC//oXOifPj0+FmxKEi
        b0mw+a4PJD+oMp8Wond2+os=
X-Google-Smtp-Source: AMsMyM4w8CbxnYpzSXIDM4TP/oqX0GNAfC6NOkMMQWCSa/qHZG8Z3N2oZ/PSPuCVlYEyxWg1fcX33Q==
X-Received: by 2002:a63:18f:0:b0:43c:24d2:c0f7 with SMTP id 137-20020a63018f000000b0043c24d2c0f7mr23165262pgb.470.1667420114900;
        Wed, 02 Nov 2022 13:15:14 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3fd5:8614:6eb0:846b])
        by smtp.gmail.com with ESMTPSA id 77-20020a621750000000b0056c2e497ad6sm9087723pfx.93.2022.11.02.13.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:15:14 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 2 Nov 2022 13:15:12 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2LP0OWF/WTnkSne@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018045533.2396670-3-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:55:26PM +0900, Sergey Senozhatsky wrote:
> Introduce recomp_algorithm sysfs knob that controls
> secondary algorithm selection used for recompression.
> This device attribute works in a similar way with
> comp_algorithm attribute.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 111 +++++++++++++++++++++++++++-------
>  1 file changed, 90 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 770ea3489eb6..a8ef3c0c3dae 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -41,7 +41,12 @@ static DEFINE_IDR(zram_index_idr);
>  static DEFINE_MUTEX(zram_index_mutex);
>  
>  static int zram_major;
> -static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
> +static const char *default_comp_algs[ZRAM_MAX_ZCOMPS] = {
> +	CONFIG_ZRAM_DEF_COMP,
> +#ifdef CONFIG_ZRAM_MULTI_COMP
> +	"zstd",
> +#endif
> +};
>  
>  /* Module params (documentation at end) */
>  static unsigned int num_devices = 1;
> @@ -1000,31 +1005,37 @@ static ssize_t max_comp_streams_store(struct device *dev,
>  	return len;
>  }
>  
> -static ssize_t comp_algorithm_show(struct device *dev,
> -		struct device_attribute *attr, char *buf)

Do you have any reason to change show and set placement? Otherwise,
please keep the function order to reduce unnecesssary churns.

> +static void comp_algorithm_set(struct zram *zram, u32 idx, const char *alg)
>  {
> -	size_t sz;
> -	struct zram *zram = dev_to_zram(dev);
> +	bool default_alg = false;
> +	int i;
>  
> -	down_read(&zram->init_lock);
> -	sz = zcomp_available_show(zram->comp_algs[ZRAM_PRIMARY_ZCOMP], buf);
> -	up_read(&zram->init_lock);
> +	/* Do not kfree() algs that we didn't allocate, IOW the default ones */
> +	for (i = 0; i < ZRAM_MAX_ZCOMPS; i++) {
> +		if (zram->comp_algs[idx] == default_comp_algs[i]) {
> +			default_alg = true;
> +			break;
> +		}
> +	}
>  
> -	return sz;
> +	if (!default_alg)
> +		kfree(zram->comp_algs[idx]);
> +	zram->comp_algs[idx] = alg;
>  }
>  
> -static void comp_algorithm_set(struct zram *zram, u32 idx, const char *alg)
> +static ssize_t __comp_algorithm_show(struct zram *zram, u32 idx, char *buf)
>  {
> -	/* Do not kfree() algs that we didn't allocate, IOW the default ones */
> -	if (zram->comp_algs[idx] != default_compressor)
> -		kfree(zram->comp_algs[idx]);
> -	zram->comp_algs[idx] = alg;
> +	ssize_t sz;
> +
> +	down_read(&zram->init_lock);
> +	sz = zcomp_available_show(zram->comp_algs[idx], buf);
> +	up_read(&zram->init_lock);
> +
> +	return sz;
>  }
>  
> -static ssize_t comp_algorithm_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t len)
> +static int __comp_algorithm_store(struct zram *zram, u32 idx, const char *buf)
>  {
> -	struct zram *zram = dev_to_zram(dev);
>  	char *compressor;
>  	size_t sz;
>  
> @@ -1053,11 +1064,55 @@ static ssize_t comp_algorithm_store(struct device *dev,
>  		return -EBUSY;
>  	}
>  
> -	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP, compressor);
> +	comp_algorithm_set(zram, idx, compressor);
>  	up_write(&zram->init_lock);
> -	return len;
> +	return 0;
> +}
> +
> +static ssize_t comp_algorithm_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +
> +	return __comp_algorithm_show(zram, ZRAM_PRIMARY_ZCOMP, buf);
> +}
> +
> +static ssize_t comp_algorithm_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf,
> +				    size_t len)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	int ret;
> +
> +	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_ZCOMP, buf);
> +	return ret ? ret : len;
>  }
>  
> +#ifdef CONFIG_ZRAM_MULTI_COMP
> +static ssize_t recomp_algorithm_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +
> +	return __comp_algorithm_show(zram, ZRAM_SECONDARY_ZCOMP, buf);
> +}

Just open question(I might be too paranoid?)

I am thinking someone want to add third comp algorithm in future
to balance decompression and memory efficiency.

If it's not too crazy idea, let's think about the interface.
Maybe, could we make the recomp knobs works like list?

# A primary comp
echo "A" > /zram/comp_algo

# Multiple secondary comps
echo "B threshold" > /zram/add_recomp_algo
echo "C threshold" > /zram/add_recomp_algo
echo "D threshold" > /zram/add_recomp_algo

"cat /zram/recomp_algo" shows the list

echo "C" > /zram/remove_recomp_algo
will remove the C algorithm in stack.

My point is that we don't need to implement it atm but makes the
interface to open the possibility for future extension.

What do you think?

> +
> +static ssize_t recomp_algorithm_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t len)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	int ret;
> +
> +	ret = __comp_algorithm_store(zram, ZRAM_SECONDARY_ZCOMP, buf);
> +	return ret ? ret : len;
> +}
> +#endif
> +
>  static ssize_t compact_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
>  {
> @@ -1762,7 +1817,11 @@ static void zram_reset_device(struct zram *zram)
>  	memset(&zram->stats, 0, sizeof(zram->stats));
>  	reset_bdev(zram);
>  
> -	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP, default_compressor);
> +	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP,
> +			   default_comp_algs[ZRAM_PRIMARY_ZCOMP]);
> +	if (IS_ENABLED(CONFIG_ZRAM_MULTI_COMP))

Dumb question:

Why do you use IS_ENABLED instead of ifdef?


> +		comp_algorithm_set(zram, ZRAM_SECONDARY_ZCOMP,
> +				   default_comp_algs[ZRAM_SECONDARY_ZCOMP]);
>  	up_write(&zram->init_lock);
>  }
>  
> @@ -1895,6 +1954,9 @@ static DEVICE_ATTR_WO(writeback);
>  static DEVICE_ATTR_RW(writeback_limit);
>  static DEVICE_ATTR_RW(writeback_limit_enable);
>  #endif
> +#ifdef CONFIG_ZRAM_MULTI_COMP
> +static DEVICE_ATTR_RW(recomp_algorithm);
> +#endif
>  
>  static struct attribute *zram_disk_attrs[] = {
>  	&dev_attr_disksize.attr,
> @@ -1918,6 +1980,9 @@ static struct attribute *zram_disk_attrs[] = {
>  	&dev_attr_bd_stat.attr,
>  #endif
>  	&dev_attr_debug_stat.attr,
> +#ifdef CONFIG_ZRAM_MULTI_COMP
> +	&dev_attr_recomp_algorithm.attr,
> +#endif
>  	NULL,
>  };
>  
> @@ -1997,7 +2062,11 @@ static int zram_add(void)
>  	if (ret)
>  		goto out_cleanup_disk;
>  
> -	zram->comp_algs[ZRAM_PRIMARY_ZCOMP] = default_compressor;
> +	zram->comp_algs[ZRAM_PRIMARY_ZCOMP] =
> +		default_comp_algs[ZRAM_PRIMARY_ZCOMP];
> +	if (IS_ENABLED(CONFIG_ZRAM_MULTI_COMP))
> +		zram->comp_algs[ZRAM_SECONDARY_ZCOMP] =
> +			default_comp_algs[ZRAM_SECONDARY_ZCOMP];
>  
>  	zram_debugfs_register(zram);
>  	pr_info("Added device: %s\n", zram->disk->disk_name);
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
