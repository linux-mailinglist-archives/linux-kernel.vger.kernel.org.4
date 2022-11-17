Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79B62E863
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbiKQW0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbiKQWZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:25:56 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2793784313
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:25:55 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id b62so3428807pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgr+e8ZyUoyDeyQ+E1fecvyvQ3W2gshFUSz2h8pvtJo=;
        b=DSg1++mVGWTTs7HfqbyCCT1RM+HQcQfLF37N/1OsrGl29ndKcrswsXH85YfT5n3j6U
         5FeMN6xIWV2gDbdsV+uwPpP78AvaGvtc5ezIVRGPWwjYinE4FHanGwaJXmxJnwmDZkVC
         +YoOUjS36Rwmv/Jp3G4T/DT4sazBl+QThyz17uQjFB/4g4wv8Vb9mwIO1KbJkYt0sq0K
         UrHI5Qs4fht+UlFZFUQLDMQ+pycLVg04zv3VTKamGabTNtFOSd6w75hkrR1vqon/EAWZ
         qyq0pEprtGELFzQ86y9i1aWNnW9Lggog846qYgk9lmWLvfzn/eg7Cf6mzDhAOXKI40e0
         pfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgr+e8ZyUoyDeyQ+E1fecvyvQ3W2gshFUSz2h8pvtJo=;
        b=RLHm5G2BwsZ1Ww1NrQBM2r9eRFPoiveLxZ2TM3984xw+z/ArIqnNolScjNyTXHulcI
         NyG/JBPWpKH7gQY8TngODNTqZAJOd86o7WdyuIELbP9B3W3FMqDYLdR+KgVdhCV26Sib
         iT+YDk8NMr/E+3k9sxq8S8Hn2TrjjDaEg7BKftJh2v/UVCJ3rYgU5Yz/IceC/SrlCsKK
         wtYNumrLLYyCQlvCzaQ/OZAbzuPk9SrD9bQSFGgf8YL8vp42Hy6zbH6YuxK4YkkhXFtG
         NVQhhh//ke6VXDFfbSsixYo7t6luUQM+oeDgbetp0hNkxbNwXzGSIRa3o39KUXPbZpwU
         o1eA==
X-Gm-Message-State: ANoB5plx4/wxWgemnycLtecpzYc88DQXfbBIgZYgIcmXJVuFKprszFWY
        Nt0DTjp2FbmceUs3iTHMeVQ=
X-Google-Smtp-Source: AA0mqf7Z65fj1NYronMx4tvVIgXpfTk0PfmABsMsNxgksLL4eZYFqj9gERnwE5cFmcG759Xa+4GpXA==
X-Received: by 2002:a63:c65:0:b0:476:db6f:d436 with SMTP id 37-20020a630c65000000b00476db6fd436mr4003107pgm.394.1668723954609;
        Thu, 17 Nov 2022 14:25:54 -0800 (PST)
Received: from google.com ([2620:15c:211:201:6bbc:b70a:8f80:710d])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e80f00b001869581f7ecsm1963826plg.116.2022.11.17.14.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:25:54 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 17 Nov 2022 14:25:52 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH v4 4/5] zsmalloc: Add ops fields to zs_pool to store
 evict handlers
Message-ID: <Y3a08ElhlyLN+0rG@google.com>
References: <20221117163839.230900-1-nphamcs@gmail.com>
 <20221117163839.230900-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117163839.230900-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:38:38AM -0800, Nhat Pham wrote:
> This adds fields to zs_pool to store evict handlers for writeback,
> analogous to the zbud allocator.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zsmalloc.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 2557b55ec767..776d0e15a401 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -225,6 +225,12 @@ struct link_free {
>  	};
>  };
> 
> +struct zs_pool;
> +
> +struct zs_ops {
> +	int (*evict)(struct zs_pool *pool, unsigned long handle);
> +};
> +
>  struct zs_pool {
>  	const char *name;
> 
> @@ -242,6 +248,9 @@ struct zs_pool {
>  #ifdef CONFIG_ZPOOL
>  	/* List tracking the zspages in LRU order by most recently added object */
>  	struct list_head lru;
> +	const struct zs_ops *ops;
> +	struct zpool *zpool;
> +	const struct zpool_ops *zpool_ops;
>  #endif
> 
>  #ifdef CONFIG_ZSMALLOC_STAT
> @@ -385,6 +394,18 @@ static void record_obj(unsigned long handle, unsigned long obj)
> 
>  #ifdef CONFIG_ZPOOL
> 
> +static int zs_zpool_evict(struct zs_pool *pool, unsigned long handle)
> +{
> +	if (pool->zpool && pool->zpool_ops && pool->zpool_ops->evict)
> +		return pool->zpool_ops->evict(pool->zpool, handle);
> +	else
> +		return -ENOENT;
> +}
> +
> +static const struct zs_ops zs_zpool_ops = {
> +	.evict =	zs_zpool_evict
> +};
> +
>  static void *zs_zpool_create(const char *name, gfp_t gfp,
>  			     const struct zpool_ops *zpool_ops,
>  			     struct zpool *zpool)
> @@ -394,7 +415,19 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
>  	 * different contexts and its caller must provide a valid
>  	 * gfp mask.
>  	 */
> -	return zs_create_pool(name);
> +	struct zs_pool *pool = zs_create_pool(name);
> +
> +	if (pool) {
> +		pool->zpool = zpool;
> +		pool->zpool_ops = zpool_ops;
> +
> +		if (zpool_ops)

I lost. When do we have zpool_ops as NULL?
