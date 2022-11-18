Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21A862F3AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiKRL3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRL3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:29:16 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF3FFCDF;
        Fri, 18 Nov 2022 03:29:15 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso8023620pjg.5;
        Fri, 18 Nov 2022 03:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6pa+0i/2gW0CZzxA4RT9DmS5V0eY1vqhUMm1tY+xHk=;
        b=W4rtUd3eoC1VUscW3kwcMKIkY/VkxFLjhZVPX/KGdSZd+FgtiMNU7qkYplQPT+11Pf
         RGdFyMXj6V5ypIkOxZPWq61sTZlPnNLl3PKu50X/+2InRbcjETZbGg0LT6dmibMpR5Qj
         dnr7UfrJk2fTY7XmIqWyHCZYVp4kFZeW+P7oNKhzBqgwJBawzuO01O6KgGoHJMoSFF3T
         HdOW00SLudrOrld6I0J2niFcBJDxvXVfueRIQHW3ulAJql8Uoc8FcQxTjONl83I3F7lK
         LsG/rlisIOShHkw8P0FxxFtbY9A952iZGb5OD3pGWcif7LghFBNQGAlcyM+aBYHvTwu2
         fy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6pa+0i/2gW0CZzxA4RT9DmS5V0eY1vqhUMm1tY+xHk=;
        b=vxXJCHYt07/sAPb3BA7C+OV+1yZFCq5sJf9hG+PCQKiHRZBqH5F408DmGVQfjxOX39
         d86pCrErJVEyaOZohTD7DAJP/EMLZG5bK0ivIs1CTfg0i+kvkVu1MZYFoKKA4K3uDn+C
         CYUlotmDh6o1Ibz98YyB7TFkth5q8zVYHkbgv2kUzj0fqLszM1SvESA6w+eYMNB0yxNH
         n63KlyiDAK/teGih0Ru8RDI08nvVFuuee9WVaTufEhb5CD+RXzgVwcMrvG5Ws0kyQIaw
         uBzOc2c8wObL6qesx0GvRl5dY23Y/1KcQNdj7I6MahwpUFXBzM3XsTCnMbu4ad60l02F
         ifMA==
X-Gm-Message-State: ANoB5pkQ34DJh2NrMpOt10INdosmCDKRrBXSI7BIc2YqU4nkiVgBpk+0
        vf6lziZSzH0odGd5m2zw/5c=
X-Google-Smtp-Source: AA0mqf78hu8u0LtNBUUNRLEiEQqHEpYKlWC5OU0vCGq6wlyjoqxy+zKllm3Jn1VAuDnPQfKHpdhtrg==
X-Received: by 2002:a17:90a:9e7:b0:213:68c5:5579 with SMTP id 94-20020a17090a09e700b0021368c55579mr13453872pjo.150.1668770954692;
        Fri, 18 Nov 2022 03:29:14 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b0017f756563bcsm3475044plg.47.2022.11.18.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:29:13 -0800 (PST)
Date:   Fri, 18 Nov 2022 20:29:08 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] slab: Clean up SLOB vs kmalloc() definition
Message-ID: <Y3dshBYUwubvZ6le@hyeyoo>
References: <20221118034713.gonna.754-kees@kernel.org>
 <20221118035200.1269184-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118035200.1269184-1-keescook@chromium.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:51:58PM -0800, Kees Cook wrote:
> As already done for kmalloc_node(), clean up the #ifdef usage in the
> definition of kmalloc() so that the SLOB-only version is an entirely
> separate and much more readable function.
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/slab.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 1c670c16c737..9033937c758e 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -558,15 +558,15 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
>   *	Try really hard to succeed the allocation but fail
>   *	eventually.
>   */
> +#ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  {
>  	if (__builtin_constant_p(size)) {
> -#ifndef CONFIG_SLOB
>  		unsigned int index;
> -#endif
> +
>  		if (size > KMALLOC_MAX_CACHE_SIZE)
>  			return kmalloc_large(size, flags);
> -#ifndef CONFIG_SLOB
> +
>  		index = kmalloc_index(size);
>  
>  		if (!index)
> @@ -575,10 +575,18 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  		return kmalloc_trace(
>  				kmalloc_caches[kmalloc_type(flags)][index],
>  				flags, size);
> -#endif
>  	}
>  	return __kmalloc(size, flags);
>  }
> +#else
> +static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
> +{
> +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> +		return kmalloc_large(size, flags);
> +
> +	return __kmalloc(size, flags);
> +}
> +#endif
>  
>  #ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> -- 
> 2.34.1

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
