Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA0624D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiKJWZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKJWZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:25:37 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348531E725
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:25:37 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so2779546pli.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W47FD2a5xAe7nFqoz3Hz5sg2zfn+k9i0H3yNcGRFzH0=;
        b=fDROxbevb7z5jJz0NSNvAnBoNC1ZqC8s11YTdaOtbMg16ItiORRyT9i2n/pxJmdec/
         gf+LwJgxGlV/ePtI6PCnJdVK0zWT2xd28cNmllkF9p/U4//MfEwWg4PZEWUeZtUMyEpx
         UnoHLjYUsM8WgOAHfnj9OPLFJfCJF/n/kB13nir+CDFoDdlCm8vtGQDvMmeLEK8GJ7jx
         qdIqyjen7XluJkO0DaYzWSY/WvfCQHjXK3mhY0cgP1kNg/UC/dkhRlkfI3h5QxyEg8+i
         nFhKinzVJ5qvfi7aECKEYgz7S0yshUOIzD/0kuI21fNDNeZEojPv17hzDvrp+YeZs4CL
         1ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W47FD2a5xAe7nFqoz3Hz5sg2zfn+k9i0H3yNcGRFzH0=;
        b=208kQldDuoIzlGYPW58zzXEgclaAjFW1xkwHuljXsYiCGA207kA7etiKHLcS5AYmlR
         GCszjBc+DdpEjY63DHZukkwR0gTDX4+2oqPy9azzCxTa20yrlvYvaNza0wD1FQc1Hm+q
         WBV+t+T+BehA35HzfTEvtOctPnN4muckTXqe3pu7Q11F8LFTR+Uzoi/Tee1F/MqiidJz
         LVXUWe+4fpuwzjZVmiqfMXQ33bt0lE37wi7U4g9E6EkDE5+7ljuE5PGMP6HU+ZNwobiG
         hmePKTB3jRGH0rtR7vcFD4cfPdXh5EWYULgFvhDxKUk5ViAWSwOzi+TDXvyfJfkBBHDp
         mB/Q==
X-Gm-Message-State: ACrzQf3r9qzkmgmkJUDt5/nHlwH2STCMq5rCd6n51SmjcJoxY5Xg2WBe
        FfFd/k3oJ6k7vVdcADJUJyQ=
X-Google-Smtp-Source: AMsMyM70GK/pwQgFUBDgUO0VohqQWUqOs0IfJFQpXfFaPhdMxW6ffuk/Byzir7EVuLff3Bi/bWoZAA==
X-Received: by 2002:a17:902:cf09:b0:172:7a15:9a61 with SMTP id i9-20020a170902cf0900b001727a159a61mr2313024plg.71.1668119136626;
        Thu, 10 Nov 2022 14:25:36 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8c0b:3260:c81c:119d])
        by smtp.gmail.com with ESMTPSA id nm13-20020a17090b19cd00b0020087d7e778sm3562899pjb.37.2022.11.10.14.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:25:36 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Nov 2022 14:25:34 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zsmalloc: make huge class watermark zs_pool member
Message-ID: <Y216Xq8V8InFQyms@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-5-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031054108.541190-5-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:41:03PM +0900, Sergey Senozhatsky wrote:
> We will permit per-pool configuration of pages per-zspage value,
> which changes characteristics of the classes and moves around
> huge class size watermark. Thus huge class size needs to be
> a per-pool variable.

I think part of code in previous patch should move here since
you are creating the feature in this patch:

BTW, I am wondering we really need to jump the per-pool config
option over global general golden ratio and/or smarter approach
to optimize transparently depending on how much memory we have
wasted.

> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/zsmalloc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 5f79223e7bfe..d329bd673baa 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -178,7 +178,6 @@ static struct dentry *zs_stat_root;
>   * (see: fix_fullness_group())
>   */
>  static const int fullness_threshold_frac = 4;
> -static size_t huge_class_size;
>  
>  struct size_class {
>  	spinlock_t lock;
> @@ -227,6 +226,7 @@ struct zs_pool {
>  
>  	u32 num_size_classes;
>  	u32 min_alloc_size;
> +	size_t huge_class_size;
>  
>  	struct zs_pool_stats stats;
>  
> @@ -1350,7 +1350,7 @@ EXPORT_SYMBOL_GPL(zs_unmap_object);
>   */
>  size_t zs_huge_class_size(struct zs_pool *pool)
>  {
> -	return huge_class_size;
> +	return pool->huge_class_size;
>  }
>  EXPORT_SYMBOL_GPL(zs_huge_class_size);
>  
> @@ -2262,8 +2262,8 @@ struct zs_pool *zs_create_pool(const char *name)
>  		 * endup in the huge class.
>  		 */
>  		if (pages_per_zspage != 1 && objs_per_zspage != 1 &&
> -				!huge_class_size) {
> -			huge_class_size = size;
> +				!pool->huge_class_size) {
> +			pool->huge_class_size = size;
>  			/*
>  			 * The object uses ZS_HANDLE_SIZE bytes to store the
>  			 * handle. We need to subtract it, because zs_malloc()
> @@ -2273,7 +2273,7 @@ struct zs_pool *zs_create_pool(const char *name)
>  			 * class because it grows by ZS_HANDLE_SIZE extra bytes
>  			 * right before class lookup.
>  			 */
> -			huge_class_size -= (ZS_HANDLE_SIZE - 1);
> +			pool->huge_class_size -= (ZS_HANDLE_SIZE - 1);
>  		}
>  
>  		/*
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
