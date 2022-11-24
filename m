Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C326E6377C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKXLjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiKXLjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:39:05 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25AA4876A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:39:02 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 136so1376809pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5EcPqvErNguuUSXQjM4Gsm5NRO9cAbvO2IWMkYz6pI=;
        b=SOJw3pGmknQGOs+cKA4lwYKRAW23GcKLpXI9bEcqXWNIZQmj6qZgdaeAgW05Rnk5dc
         WhjgRoHta5X4f1roJmi0k+NF6085ffRp8wWbmxxYvuOoIjK9sr5+LvgZzdqjfMl6yIg+
         Xf8hDCmBAfcJ209YFFw0LR09iN2AQ+/+2K4/BuHnK7hymbqFRZa3aCGBW+KbAGkgX8Ir
         7TYe9cW84y2OSlc6te7WF3uPvtw/VwhP5V+eJ1+34SQ12F9m5BlSCk24SXS/howNODnc
         5pUXdgbG4YKP8ViGGHEvYP69ji6BO1ElS1MW+4CXwbAxFUxPUpVdRmQiSzEjQn+UuitS
         sxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5EcPqvErNguuUSXQjM4Gsm5NRO9cAbvO2IWMkYz6pI=;
        b=Ko0MOyGGBu0kQNZ+1KnY119AGhzaXwmNkh22uy20s355EPaTmPV/s8eIaATTs61AJo
         yaK0AEQPmhbFTgmYjD9yt2VCc68Yo/mwi46bRi9eyBv+yWktbRK6kvaj5nG19w04TZpV
         P5oi3nEtXI0CrSKEn540I1ON+BxkisrAnuSaO66dVpcpQgo2h9CWKkWF3bLmrdMlbqFx
         8cudvWk/uKDTNu3YCxSm+Of9u9hirZyfnq23pDUqq+AN5XpgpBqTOIYau9d8cv8xJVnd
         zopdX5krIdet4DqZXRySX/QD/YzbSf62qyB35Czuz5vHQG7RfvY1jWnmZYRsaBMjTflk
         GZdQ==
X-Gm-Message-State: ANoB5pkdiPn8ejiRyID79pr+TiQ9yBHYPU+XDsMt7ljp9TdPIg5fBPis
        Z20R77/DtZjEV7eC54FGlOoQ2QFZkt7IL+VU
X-Google-Smtp-Source: AA0mqf6DoxIbI42ZFR91whRSV72DkyTzPOXE08yKJHXysCt+s0YkgN8Huvbe8ojyWrwoVjgC2BICdA==
X-Received: by 2002:a62:6083:0:b0:56d:3180:c7fc with SMTP id u125-20020a626083000000b0056d3180c7fcmr16238203pfb.41.1669289942391;
        Thu, 24 Nov 2022 03:39:02 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b00177e5d83d3esm1098955pln.88.2022.11.24.03.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:39:01 -0800 (PST)
Date:   Thu, 24 Nov 2022 20:38:55 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] mm, slub: retain no free slabs on partial list
 with CONFIG_SLUB_TINY
Message-ID: <Y39Xz9VbI2A8+bfe@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-5-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171202.22080-5-vbabka@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:11:54PM +0100, Vlastimil Babka wrote:
> SLUB will leave a number of slabs on the partial list even if they are
> empty, to avoid some slab freeing and reallocation. The goal of
> CONFIG_SLUB_TINY is to minimize memory overhead, so set the limits to 0
> for immediate slab page freeing.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ab085aa2f1f0..917b79278bad 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -241,6 +241,7 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>  /* Enable to log cmpxchg failures */
>  #undef SLUB_DEBUG_CMPXCHG
>  
> +#ifndef CONFIG_SLUB_TINY
>  /*
>   * Minimum number of partial slabs. These will be left on the partial
>   * lists even if they are empty. kmem_cache_shrink may reclaim them.
> @@ -253,6 +254,10 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>   * sort the partial list by the number of objects in use.
>   */
>  #define MAX_PARTIAL 10
> +#else
> +#define MIN_PARTIAL 0
> +#define MAX_PARTIAL 0
> +#endif
>  
>  #define DEBUG_DEFAULT_FLAGS (SLAB_CONSISTENCY_CHECKS | SLAB_RED_ZONE | \
>  				SLAB_POISON | SLAB_STORE_USER)
> -- 
> 2.38.1
> 

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
