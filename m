Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143AA5BFC92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIUKrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIUKq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:46:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987A98B2F8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:46:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y136so5531071pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qPdyqdgroowolFN4GRnR79RabeBW8kqO40WJAOflFYI=;
        b=O81iPm+KUz5n9Y8uAC2zjGZla7XVQmkzEOm+8edHWalNrZUz2eZdWyF7bBpZmuJZli
         3v4Wus4yyKi5JVSuqwCBkmdFzb0dhMvdJDCdmmeup8WVa7jHBcCyNwgZPFPIp93UVhse
         Tg4fSHP5CX/FREA0YFM29slTnoaqB8ljpXeAl6J+GhgjPEMoV1RSIs7Y4A4H5qvj3kXL
         OgnxvoaOUOBOZZmf+483h5p6A1s8JMqm3q0rVId2I9T7aBEAKyAGZ2BsUo+sToN97gSB
         +QHR3PXnHlxrGIlWA8ZrP00n9e6WsmvfqPBROvlilmHpqbdXJR6rh6BFc5cDtqzfqKkP
         77Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qPdyqdgroowolFN4GRnR79RabeBW8kqO40WJAOflFYI=;
        b=pBsMJeKN48v8oiNHoP4ilUyZq2lJvraBh4OkRwbpTj8NqUg3VJvdMch/D7lW320EF4
         POAQt4f7Tb7fnvTDyLvlPzPvnfMJ2s2/JpAEJ53B9kjZcmH8zrbtZ32B1BjX/t9xwY7P
         zHcOh17bqdoEkGH7bSB4fDz+EtFv0cDBPKCv7/Z6esNO7Y+4GVcWNlCOXTKRZx+FnV3B
         zSI+KAcc8s6AlJU27erk9DOUf2GGxkZ/6/A6n7xF0mmBD+imX2P6pNreQbgkHmdW8Ace
         Sk9p48maUEGcdBVgZMwsUfqnS8GrWhHNHBlH4/OItcnogsOp8kIQLmFEuIBElECzxsMj
         GJ7w==
X-Gm-Message-State: ACrzQf1lKSQ8I7nQ3KTolE119aTOorqr5qOfAVQ1c4NBgYBh55RRhCVV
        EOgaPEsHZa40+KE2eHSHumQ=
X-Google-Smtp-Source: AMsMyM5PgkdRETKfeQYop/FfeIm9ozcKgocuNzZIpq6wic1DXkSB0dNse0+PMswlU4hqJshmP24ZvQ==
X-Received: by 2002:a65:6544:0:b0:439:b319:2422 with SMTP id a4-20020a656544000000b00439b3192422mr24100903pgw.114.1663757206906;
        Wed, 21 Sep 2022 03:46:46 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b00174c235e1fdsm1677504plg.199.2022.09.21.03.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 03:46:45 -0700 (PDT)
Date:   Wed, 21 Sep 2022 19:46:39 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hugh Dickins <hugh@veritas.com>, Chao Yu <chao.yu@oppo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: clean up create_unique_id()
Message-ID: <YyrrjzBLF6nNNYEd@hyeyoo>
References: <20220918092146.4060783-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918092146.4060783-1-chao@kernel.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 05:21:46PM +0800, Chao Yu wrote:
> From: Chao Yu <chao.yu@oppo.com>
> 
> As Christophe JAILLET suggested:
> 
> In create_unique_id(),
> 
> "looks that ID_STR_LENGTH could even be reduced to 32 or 16.
> 
> The 2nd BUG_ON at the end of the function could certainly be just
> removed as well or remplaced by a:
>         if (p > name + ID_STR_LENGTH - 1) {
>                 kfree(name);
>                 return -E<something>;
>         }
> "
> 
> According to above suggestion, let's do below cleanups:
> 1. reduce ID_STR_LENGTH to 32, as the buffer size should be enough;
> 2. remove BUG_ON() and return error if check condition is true.
> 
> Link: https://lore.kernel.org/linux-mm/2025305d-16db-abdf-6cd3-1fb93371c2b4@wanadoo.fr/
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Fixes: 81819f0fc828 ("SLUB core")
> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---
>  mm/slub.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 5ba6db62a5ab..a045c1ca8772 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5883,7 +5883,7 @@ static inline struct kset *cache_kset(struct kmem_cache *s)
>  	return slab_kset;
>  }
>  
> -#define ID_STR_LENGTH 64
> +#define ID_STR_LENGTH 32
>  
>  /* Create a unique string id for a slab cache:
>   *
> @@ -5919,7 +5919,10 @@ static char *create_unique_id(struct kmem_cache *s)
>  		*p++ = '-';
>  	p += sprintf(p, "%07u", s->size);
>  
> -	BUG_ON(p > name + ID_STR_LENGTH - 1);
> +	if (p > name + ID_STR_LENGTH - 1) {
> +		kfree(name);
> +		return ERR_PTR(-EINVAL);
> +	}
>  	return name;

IIUC 16 bytes will be still safe ;)

Anyway, for either size:

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

>  }
>  
> -- 
> 2.25.1
> 

-- 
Thanks,
Hyeonggon
