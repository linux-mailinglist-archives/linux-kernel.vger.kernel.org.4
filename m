Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425B35B2EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiIIG0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiIIG0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:26:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A645C12519F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:26:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso4716505pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 23:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qtjHXgBD9/OnG3oahRLo2zpObrPNyAlnYWRTg6DVoSc=;
        b=BD6vwE4UNXDlWpnSSrdWAALMMs8g5dggAhb11NnWmroBlG1/ogdkeyDw9xegVV5bgk
         VCueNwNfiMpQMikfdq5x5G/kye+i4tTwcoNnH/ZqrfExz5J4JY5v0Kcb/Yc8se/bqpAR
         FkXI75dpse8r3GY6/lqViyR0RJLGoYYPBmJ5VrOjiCTx3ZyfvKRoYGyGEv/qFJ3v4aOK
         NifMjPK2VIA8lljtP/IAQkE54HpsIQX3l4OgEOT0EERjVr7CrNP3RkQjN93O0O4hsD7w
         RX7S1KXR4Tz6gIjyeubAMSjKX2fs9fqtKBCZ18TjlUWwyxYfg/Lhb8V1+LN+A6advjCA
         vgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qtjHXgBD9/OnG3oahRLo2zpObrPNyAlnYWRTg6DVoSc=;
        b=0gYRJw1FgTqWBQcsTFSt0yI/gh1hY8sI9phxAnGFhgpaLpKP2CLW/fX2evPWs3CnDe
         YRybpTZr/XnxJMaKy7bGqtx41SkFMAc85DTeFs2k9B0anNXnFVoCXohpszbmC09ucBuf
         RjRB3rXVNeAUsjJ1TN66Dlc8LEPvFdlf2UnTI+TmpD14e5ir2Ja7SypIi2HC596z1fUm
         FJYRCzUD1e6v07AUy5mqh/cLABZIONXimVvN4ejsa7jFj4Lx/y/TUbFZ12DVfkJBKmV8
         ERuNgBmombwrmZu5wuTrvCDo18ZUcLTWUxi/WXYGU9bI1nKm9by+DECMNrKGeSdC5xMa
         iW1Q==
X-Gm-Message-State: ACgBeo34VXSWLEr7FYGzAZg+K5xC8nu+RRK23ItA/GNXvlgD2SU4kaNQ
        X4PNpDMjwUql1gIrz2HUOEU=
X-Google-Smtp-Source: AA6agR7MXvRvt31/L+ppjYNP945+4l8Hcd5zp/Rsxao7FqSqpTXH6WMtJM8b9HJoUmvq2DdKY6tgzw==
X-Received: by 2002:a17:902:f7d2:b0:176:ca6b:eadb with SMTP id h18-20020a170902f7d200b00176ca6beadbmr12523610plw.173.1662704801103;
        Thu, 08 Sep 2022 23:26:41 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 63-20020a620542000000b005367c28fd32sm741728pff.185.2022.09.08.23.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 23:26:40 -0700 (PDT)
Date:   Fri, 9 Sep 2022 15:26:34 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 4/4] mm/slub: extend redzone check to extra allocated
 kmalloc space than requested
Message-ID: <Yxrcmk6hSvHBCGNo@hyeyoo>
References: <20220907071023.3838692-1-feng.tang@intel.com>
 <20220907071023.3838692-5-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907071023.3838692-5-feng.tang@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 03:10:23PM +0800, Feng Tang wrote:
> kmalloc will round up the request size to a fixed size (mostly power
> of 2), so there could be a extra space than what is requested, whose
> size is the actual buffer size minus original request size.
> 
> To better detect out of bound access or abuse of this space, add
> redzone sanity check for it.
> 
> And in current kernel, some kmalloc user already knows the existence
> of the space and utilizes it after calling 'ksize()' to know the real
> size of the allocated buffer. So we skip the sanity check for objects
> which have been called with ksize(), as treating them as legitimate
> users.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/slab.h        |  4 ++++
>  mm/slab_common.c |  4 ++++
>  mm/slub.c        | 57 +++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 20f9e2a9814f..0bc91b30b031 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -885,4 +885,8 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  }
>  #endif
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +void skip_orig_size_check(struct kmem_cache *s, const void *object);
> +#endif
> +
>  #endif /* MM_SLAB_H */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8e13e3aac53f..5106667d6adb 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1001,6 +1001,10 @@ size_t __ksize(const void *object)
>  		return folio_size(folio);
>  	}
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +	skip_orig_size_check(folio_slab(folio)->slab_cache, object);
> +#endif
> +
>  	return slab_ksize(folio_slab(folio)->slab_cache);
>  }
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index f523601d3fcf..2f0302136604 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -812,12 +812,27 @@ static inline void set_orig_size(struct kmem_cache *s,
>  	if (!slub_debug_orig_size(s))
>  		return;
>  
> +#ifdef CONFIG_KASAN_GENERIC
> +	/*
> +	 * KASAN could save its free meta data in the start part of object
> +	 * area, so skip the redzone check if kasan's meta data size is
> +	 * bigger enough to possibly overlap with kmalloc redzone
> +	 */
> +	if (s->kasan_info.free_meta_size_in_object * 2 >= s->object_size)
> +		orig_size = s->object_size;
> +#endif
> +
>  	p += get_info_end(s);
>  	p += sizeof(struct track) * 2;
>  
>  	*(unsigned int *)p = orig_size;
>  }
>  
> +void skip_orig_size_check(struct kmem_cache *s, const void *object)
> +{
> +	set_orig_size(s, (void *)object, s->object_size);
> +}
> +
>  static unsigned int get_orig_size(struct kmem_cache *s, void *object)
>  {
>  	void *p = kasan_reset_tag(object);
> @@ -949,13 +964,34 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
>  static void init_object(struct kmem_cache *s, void *object, u8 val)
>  {
>  	u8 *p = kasan_reset_tag(object);
> +	unsigned int orig_size = s->object_size;
>  
> -	if (s->flags & SLAB_RED_ZONE)
> +	if (s->flags & SLAB_RED_ZONE) {
>  		memset(p - s->red_left_pad, val, s->red_left_pad);
>  
> +		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> +			unsigned int zone_start;
> +
> +			orig_size = get_orig_size(s, object);
> +			zone_start = orig_size;
> +
> +			if (!freeptr_outside_object(s))
> +				zone_start = max_t(unsigned int, orig_size,
> +						s->offset + sizeof(void *));
> +
> +			/*
> +			 * Redzone the extra allocated space by kmalloc
> +			 * than requested.
> +			 */
> +			if (zone_start < s->object_size)
> +				memset(p + zone_start, val,
> +					s->object_size - zone_start);
> +		}
> +	}
> +
>  	if (s->flags & __OBJECT_POISON) {
> -		memset(p, POISON_FREE, s->object_size - 1);
> -		p[s->object_size - 1] = POISON_END;
> +		memset(p, POISON_FREE, orig_size - 1);
> +		p[orig_size - 1] = POISON_END;
>  	}
>  
>  	if (s->flags & SLAB_RED_ZONE)
> @@ -1103,6 +1139,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  {
>  	u8 *p = object;
>  	u8 *endobject = object + s->object_size;
> +	unsigned int orig_size;
>  
>  	if (s->flags & SLAB_RED_ZONE) {
>  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> @@ -1112,6 +1149,20 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
>  			endobject, val, s->inuse - s->object_size))
>  			return 0;
> +
> +		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> +			orig_size = get_orig_size(s, object);
> +
> +			if (!freeptr_outside_object(s))
> +				orig_size = max_t(unsigned int, orig_size,
> +						s->offset + sizeof(void *));
> +			if (s->object_size > orig_size  &&
> +				!check_bytes_and_report(s, slab, object,
> +					"kmalloc Redzone", p + orig_size,
> +					val, s->object_size - orig_size)) {
> +				return 0;
> +			}
> +		}
>  	} else {
>  		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
>  			check_bytes_and_report(s, slab, p, "Alignment padding",
> -- 
> 2.34.1
> 

Looks good, but what about putting
free pointer outside object when slub_debug_orig_size(s)?

diff --git a/mm/slub.c b/mm/slub.c
index 9d1a985c9ede..7e57d9f718d1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -970,22 +970,15 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 		memset(p - s->red_left_pad, val, s->red_left_pad);
 
 		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
-			unsigned int zone_start;
-
 			orig_size = get_orig_size(s, object);
-			zone_start = orig_size;
-
-			if (!freeptr_outside_object(s))
-				zone_start = max_t(unsigned int, orig_size,
-						s->offset + sizeof(void *));
 
 			/*
 			 * Redzone the extra allocated space by kmalloc
 			 * than requested.
 			 */
-			if (zone_start < s->object_size)
-				memset(p + zone_start, val,
-					s->object_size - zone_start);
+			if (orig_size < s->object_size)
+				memset(p + orig_size, val,
+				       s->object_size - orig_size);
 		}
 	}
 
@@ -1153,9 +1146,6 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
 			orig_size = get_orig_size(s, object);
 
-			if (!freeptr_outside_object(s))
-				orig_size = max_t(unsigned int, orig_size,
-						s->offset + sizeof(void *));
 			if (s->object_size > orig_size  &&
 				!check_bytes_and_report(s, slab, object,
 					"kmalloc Redzone", p + orig_size,
@@ -4234,7 +4224,8 @@ static int calculate_sizes(struct kmem_cache *s)
 	 */
 	s->inuse = size;
 
-	if ((flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
+	if (slub_debug_orig_size(s) ||
+	    (flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
 	    ((flags & SLAB_RED_ZONE) && s->object_size < sizeof(void *)) ||
 	    s->ctor) {
 		/*

-- 
Thanks,
Hyeonggon
