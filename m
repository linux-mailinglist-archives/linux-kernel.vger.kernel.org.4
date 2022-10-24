Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E26860AF2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJXPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiJXPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:38:41 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F78113DEB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:27:39 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id w10so326209qvr.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71eY0kkxWRwBjV2G3scfnzcrcRhO3rXFbeUg0pv3GQg=;
        b=SbZB0SzKD6Kfk9toYCVYMMukZREinAmvmWVRwReClqYqhZ7XS+/jdZsB5JSJcIOOf6
         VCBoighcYhc9+zC4y4yZ/QIDTkcwrlHACa/rpGqjjl3zdn6WKoEijhrimqiVinXLfEwH
         tB77iv9eLdW+aUM9ZPDSW9pU7aTWQ5oSuoHI+XeVP9/0ZWNwo4aTGn/6P0+E1k4bwOzC
         L0IIGZzpTrVk2hvDEAlWwuKMloGTX9Rh1GRJuKPXmDB76AiDqYtWsoijQmJgJ4U3P4yJ
         TR1emGGyyhsf6irfJii9HvPO+Di0grFDve7+eGDi5HSwriz4LeLKOcR/c1+eDoCcZgip
         M0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71eY0kkxWRwBjV2G3scfnzcrcRhO3rXFbeUg0pv3GQg=;
        b=17xZPQxIVTFQ5Lqi3VbfecMWcQq1NBmQWKCsmJcCdwz4/qE4tNkpAZFP/6TgZt7/Xa
         up0aNxlwRE4PVzQvKiMSzsHiqprLNW907nuxCyXVKOoa+E060CSsoeeINGkGWQXANFsj
         5pd+clp4/Iz3ak5tIS+NJIrH4s3BJ5FQn6xjCzHAdpFf7vP/LDlqkIJhgH+0QCdW2vQD
         0i/AehDKpa6SnNGrIn6AhvWcfOW+RJCZiNT3Z06iQVPQrl8rBecH3sPvjpxzamQyeaXz
         Drl2pXhp701OMg2tyCFGFlpbhIOSw3yFBl2NtaRCtMPGsqh0SFyWyvvDfjcDV2I7tgl8
         d5SA==
X-Gm-Message-State: ACrzQf3RWI1ZVnOPVmwkslwKncxFDxm0Q2AIGU3AoYp6hGHi2yAJNpM7
        zgyfG6yQuqkdJ3vDdBFWZT9PxyhcqSo=
X-Google-Smtp-Source: AMsMyM4XzOkhn23VCSvDXrXHuE00G3jtZo/xodA4l2djBrYJleMmDynchUo2uqkPLx2yltT5YcXDgQ==
X-Received: by 2002:a17:903:1381:b0:186:8bdb:6865 with SMTP id jx1-20020a170903138100b001868bdb6865mr11686619plb.166.1666619564779;
        Mon, 24 Oct 2022 06:52:44 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090a748c00b0020aacde1964sm4011403pjk.32.2022.10.24.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:52:43 -0700 (PDT)
Date:   Mon, 24 Oct 2022 22:52:38 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 8/8] mm/slub, percpu: correct the calculation of early
 percpu allocation size
Message-ID: <Y1aYpohk42r6tm5K@hyeyoo>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-9-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-9-bhe@redhat.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:14:35PM +0800, Baoquan He wrote:
> SLUB allocator relies on percpu allocator to initialize its ->cpu_slab
> during early boot. For that, the dynamic chunk of percpu which serves
> the early allocation need be large enough to satisfy the kmalloc
> creation.
> 
> However, the current BUILD_BUG_ON() in alloc_kmem_cache_cpus() doesn't
> consider the kmalloc array with NR_KMALLOC_TYPES length. Fix that
> with correct calculation.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 157527d7101b..8ac3bb9a122a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4017,7 +4017,8 @@ init_kmem_cache_node(struct kmem_cache_node *n)
>  static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
>  {
>  	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
> -			KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu));
> +			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
> +			sizeof(struct kmem_cache_cpu));
>  
>  	/*
>  	 * Must align to double word boundary for the double cmpxchg

Looks good to me.

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> -- 
> 2.34.1
> 

-- 
Thanks,
Hyeonggon
