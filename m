Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38E36476D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLHTw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHTw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:52:56 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C7851329
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:52:54 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so6462085ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 11:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbt5AP/opVLc7mMBSSuU1JbLyeELh40EDgvhnoHJP70=;
        b=fyYeafmB6c2C0PZNOSzG2fMQws/DAdxSprCidbNS2n7zzH+51oGt5mYtwqlYLChtjL
         qVVXu91amMPeax6kKa92akWxT5LhsFZGvSX4Xz1PO8P+IDUvvDFABVjLIPeUNtwtFNzh
         F+MZcmx/zC4R5K4KpKUrI2RaY+NWyjbHDmL17PlzTCc6fK1OPn01iv2arCi+T0mQoRaF
         fqerH8kKZbr/8IXsfEx33JPsNzXs+LPbMKMNa+D7tKeXys58dqdX0w8dlky17dPeLbk0
         iEFS4eS9sEYxp/yPVhFA7X0GiYIakCXNNrXdAFqA5QOZe4cNJ+7GoWTEXBJoak0BRn8B
         xB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cbt5AP/opVLc7mMBSSuU1JbLyeELh40EDgvhnoHJP70=;
        b=jEaA410nrsmzq7dkQUQ9vKcV+zMx7oLq0X7W/jIjpjkoACl9QPAKYM4dH8zxKp/jfx
         C0GOXT0cMtdeOvxMDSEYRL0fUvRB7IyBQYJcLcHPoy9VTGY2bYPV2REtVnzMmrIk8Zi6
         ncILT6qs5gJ2YoZBSOWMXgpPsHr+oa03bBWBUe5f1UZfbkFfAKmsRGF0pnu3an8ERZ9J
         sEY7F6WZjLH5UcGZn/kuOEZNjcsQ/ryaxFdbjyYuDKswWHQC+Vt1W93kg00HjA897xey
         UcFzXCj++HkgxCou/68FzvVHlgRnUJYsydDE2uAm+8+uaoIt9stMnNu+Z7M2+ZTvUQXt
         scWg==
X-Gm-Message-State: ANoB5pnQveEcdJtxYEAO3eMQfqlJukA6SdpSmeZRhP/3+zSVHQIyFxap
        PnYSnMTp6LKQuqiQK2mbjk/FtggPJ4M=
X-Google-Smtp-Source: AA0mqf5ptS1ysFEt5E9ddx06NKu6/xOtdByMq9Zr7XTuRascFI3VgS0SzOtgCo3B5td0KRXiqPfQCg==
X-Received: by 2002:a17:906:37d5:b0:7c0:a961:8aad with SMTP id o21-20020a17090637d500b007c0a9618aadmr3213884ejc.34.1670529172683;
        Thu, 08 Dec 2022 11:52:52 -0800 (PST)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o17-20020a170906769100b00782fbb7f5f7sm10009703ejm.113.2022.12.08.11.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 11:52:52 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 8 Dec 2022 20:52:50 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v1 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y5JAkqeecvNwPcRf@pc636>
References: <20221204013046.154960-1-bhe@redhat.com>
 <20221204013046.154960-3-bhe@redhat.com>
 <Y43qfdseyq0zizJO@pc636>
 <Y5BI3Sp8QCyweXwt@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5BI3Sp8QCyweXwt@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:03:41PM +0800, Baoquan He wrote:
> On 12/05/22 at 01:56pm, Uladzislau Rezki wrote:
> > > Through vmalloc API, a virtual kernel area is reserved for physical
> > > address mapping. And vmap_area is used to track them, while vm_struct
> > > is allocated to associate with the vmap_area to store more information
> > > and passed out.
> > > 
> > > However, area reserved via vm_map_ram() is an exception. It doesn't have
> > > vm_struct to associate with vmap_area. And we can't recognize the
> > > vmap_area with '->vm == NULL' as a vm_map_ram() area because the normal
> > > freeing path will set va->vm = NULL before unmapping, please see
> > > function remove_vm_area().
> > > 
> > > Meanwhile, there are two types of vm_map_ram area. One is the whole
> > > vmap_area being reserved and mapped at one time; the other is the
> > > whole vmap_area with VMAP_BLOCK_SIZE size being reserved, while mapped
> > > into split regions with smaller size several times via vb_alloc().
> > > 
> > > To mark the area reserved through vm_map_ram(), add flags field into
> > > struct vmap_area. Bit 0 indicates whether it's a vm_map_ram area,
> > > while bit 1 indicates whether it's a vmap_block type of vm_map_ram
> > > area.
> > > 
> > > This is a preparatoin for later use.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  include/linux/vmalloc.h |  1 +
> > >  mm/vmalloc.c            | 18 +++++++++++++++++-
> > >  2 files changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > > index 096d48aa3437..69250efa03d1 100644
> > > --- a/include/linux/vmalloc.h
> > > +++ b/include/linux/vmalloc.h
> > > @@ -76,6 +76,7 @@ struct vmap_area {
> > >  		unsigned long subtree_max_size; /* in "free" tree */
> > >  		struct vm_struct *vm;           /* in "busy" tree */
> > >  	};
> > > +	unsigned long flags; /* mark type of vm_map_ram area */
> > >  };
> > >  
> > >  /* archs that select HAVE_ARCH_HUGE_VMAP should override one or more of these */
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 5d3fd3e6fe09..d6f376060d83 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -1815,6 +1815,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
> > >  
> > >  	spin_lock(&vmap_area_lock);
> > >  	unlink_va(va, &vmap_area_root);
> > > +	va->flags = 0;
> > >  	spin_unlock(&vmap_area_lock);
> > >  
> > This is not a good place to set flags to zero. It looks to me like
> > corner and kind of specific.
> 
> Thanks for reviewing.
> 
> Here, I thought to clear VMAP_RAM|VMAP_BLOCK on vmap->flags when free
> the vmap_block. I didn't find a good place to do the clearing. When we
> call free_vmap_block(), we either come from purge_fragmented_blocks(),
> or from vb_free(). In vb_free(), it will call free_vmap_block() when
> the whole vmap_block is dirty. In purge_fragmented_blocks(), it will
> try to purge all vmap_block which only has dirty or free regions.
> For both of above functions, they will call free_vmap_block() when
> there's no being used region in the vmap_block.
> 
>   purge_fragmented_blocks()
>   vb_free()
>     -->free_vmap_block()
> 
> So seems we don't need to clear the VMAP_RAM|VMAP_BLOCK on vmap->flags
> because there's no mapping existed in the vmap_block. The consequent
> free_vmap_block() will remove the relevant vmap_area from vmap_area_list
> and vmap_area_root tree.
> 
> So I plan to remove code change in this place.
> > 
> > 
> > >  	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
> > > @@ -1887,6 +1888,10 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> > >  
> > >  #define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
> > >  
> > > +#define VMAP_RAM		0x1
> > > +#define VMAP_BLOCK		0x2
> > > +#define VMAP_FLAGS_MASK		0x3
> > > +
> > >  struct vmap_block_queue {
> > >  	spinlock_t lock;
> > >  	struct list_head free;
> > > @@ -1967,6 +1972,9 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> > >  		kfree(vb);
> > >  		return ERR_CAST(va);
> > >  	}
> > > +	spin_lock(&vmap_area_lock);
> > > +	va->flags = VMAP_RAM|VMAP_BLOCK;
> > > +	spin_unlock(&vmap_area_lock);
> > >
> > The per-cpu code was created as a fast per-cpu allocator because of high
> > vmalloc lock contention. If possible we should avoid of locking of the
> > vmap_area_lock. Because it has a high contention.
> 
> Fair enough. I made below draft patch to address the concern. By
> adding argument va_flags to alloc_vmap_area(), we can pass the 
> vm_map_ram flags into alloc_vmap_area and filled into vmap_area->flags.
> With this, we don't need add extra action to acquire vmap_area_root lock
> and do the flags setting. Is it OK to you?
> 
> From 115f6080b339d0cf9dd20c5f6c0d3121f6b22274 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Wed, 7 Dec 2022 11:08:14 +0800
> Subject: [PATCH] mm/vmalloc: change alloc_vmap_area() to pass in va_flags
> 
> With this change, we can pass and set vmap_area->flags for vm_map_ram area
> in alloc_vmap_area(). Then no extra action need be added to acquire
> vmap_area_lock when doing the vmap_area->flags setting.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ccaa461998f3..d74eddec352f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1586,7 +1586,9 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
>  static struct vmap_area *alloc_vmap_area(unsigned long size,
>  				unsigned long align,
>  				unsigned long vstart, unsigned long vend,
> -				int node, gfp_t gfp_mask)
> +				int node, gfp_t gfp_mask,
> +				unsigned long va_flags)
> +)
>  {
>  	struct vmap_area *va;
>  	unsigned long freed;
> @@ -1630,6 +1632,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->va_start = addr;
>  	va->va_end = addr + size;
>  	va->vm = NULL;
> +	va->flags = va_flags;
>  
>  	spin_lock(&vmap_area_lock);
>  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> @@ -1961,7 +1964,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  
>  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
>  					VMALLOC_START, VMALLOC_END,
> -					node, gfp_mask);
> +					node, gfp_mask,
> +					VMAP_RAM|VMAP_BLOCK);
>  	if (IS_ERR(va)) {
>  		kfree(vb);
>  		return ERR_CAST(va);
> @@ -2258,7 +2262,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  	} else {
>  		struct vmap_area *va;
>  		va = alloc_vmap_area(size, PAGE_SIZE,
> -				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> +				VMALLOC_START, VMALLOC_END,
> +				node, GFP_KERNEL, VMAP_RAM|VMAP_BLOCK);
>  		if (IS_ERR(va))
>  			return NULL;
>  
> @@ -2498,7 +2503,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  	if (!(flags & VM_NO_GUARD))
>  		size += PAGE_SIZE;
>  
> -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask);
> +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
>  	if (IS_ERR(va)) {
>  		kfree(area);
>  		return NULL;
> -- 
> 2.34.1
> 
Yes, this is better than it was before. Adding an extra parameter makes
it more valid and logical.

--
Uladzislau Rezki
