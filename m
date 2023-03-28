Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2776CBF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjC1MgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjC1MgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:36:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5443A243
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:35:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z42so12340965ljq.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680006858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gvgN3DG+Vt2c71BXTWQsXRITKpPi7yyeQJ22Vh4BLvk=;
        b=UHjN4FGLf/NbvtVQ0GVXdo9eU/u1kFfW+B2fgTeJvWoFJaqA+6bRLY+YzILmv9bFRb
         c+C1u5SRZ5BUaNLyVtHiz3oGddTeYZiIVBJKRag1xvmZEYswRcjyRnQKVtOu34CZQelh
         QKK3oKkjh8Eup9tz1kiqPsRXdWc6PyXfBI3HN0x4hEFQcLFetlsdODkaW6nU/Qx17c5B
         EjjuwSJyn054SevEkv/hhQGBKmvRTgUuKA0dHtI4MXWQvMkx+CifEHfcY7aK2A7xLSFE
         xZgziLyaK8SUJxJMX0AlVQRHOj1qU/3TZdPR5IKL2BGrCi5SdCrtoKQcsD61pvuYKvYj
         nfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680006858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvgN3DG+Vt2c71BXTWQsXRITKpPi7yyeQJ22Vh4BLvk=;
        b=l41f51w65ZzBrTzioLfINse82VfWnqci4VA+yqHOakTRU/S/UggLV98bbv+WvgPtK8
         TR90iHuru5FvR1B8zuJbwvSTP79aJ9DX5G5mDx5I/mGNhB4Gy63SFbsbcBoSPXh3VtRn
         YYaXG8lpNY+XZ/6rHUezVDr06f/khxqe8Fk9dAmyNi/b24tE+7rSq5Xs0Alhs1uykB1K
         jfbaX/M7qK3gWr62NuBsnRQjjz75Ya5TezHXeu81WBldPQjcR/oMjm/OAu02C+tExiHN
         OaT8/0SXb/JzDwm/8B3q4JB+DBZu623G6FGY0xJr+lyD/JEgcwWLLaF1v91lO7UYByOo
         23lA==
X-Gm-Message-State: AAQBX9erUXbx4UB1iVnrajW+fZ6FtwZbjezXcb0H50bDlYLcIsWpS60L
        sj5K4u4reuo3iAYF+6EANprxMKrjaY1RwQ==
X-Google-Smtp-Source: AKy350YH5LZkZudztmXURkXj9UQNwobEz57ljDoz1TGEBrGdnbpJiPkBajP68MeDDBE6mcL6ljrqaw==
X-Received: by 2002:a05:651c:224:b0:295:c3cf:e81e with SMTP id z4-20020a05651c022400b00295c3cfe81emr4994443ljn.19.1680006858177;
        Tue, 28 Mar 2023 05:34:18 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id s13-20020a2e2c0d000000b0029a63256410sm4947064ljs.52.2023.03.28.05.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:34:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 28 Mar 2023 14:34:15 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCLex4BPPtosouvd@pc636>
References: <20230327170126.406044-1-urezki@gmail.com>
 <ZCJd//IM6FGkbVTJ@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCJd//IM6FGkbVTJ@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:25:54AM +0800, Baoquan He wrote:
> On 03/27/23 at 07:01pm, Uladzislau Rezki (Sony) wrote:
> > A global vmap_blocks-xarray array can be contented under
> > heavy usage of the vm_map_ram()/vm_unmap_ram() APIs. The
> > lock_stat shows that a "vmap_blocks.xa_lock" lock is a
> > second in a top-list when it comes to contentions:
> > 
> > <snip>
> > ----------------------------------------
> > class name con-bounces contentions ...
> > ----------------------------------------
> > vmap_area_lock:         2554079 2554276 ...
> >   --------------
> >   vmap_area_lock        1297948  [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
> >   vmap_area_lock        1256330  [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
> >   vmap_area_lock              1  [<00000000c95c05a7>] find_vm_area+0x16/0x70
> >   --------------
> >   vmap_area_lock        1738590  [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
> >   vmap_area_lock         815688  [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
> >   vmap_area_lock              1  [<00000000c1d619d7>] __get_vm_area_node+0xd2/0x170
> > 
> > vmap_blocks.xa_lock:    862689  862698 ...
> >   -------------------
> >   vmap_blocks.xa_lock   378418    [<00000000625a5626>] vm_map_ram+0x359/0x4a0
> >   vmap_blocks.xa_lock   484280    [<00000000caa2ef03>] xa_erase+0xe/0x30
> >   -------------------
> >   vmap_blocks.xa_lock   576226    [<00000000caa2ef03>] xa_erase+0xe/0x30
> >   vmap_blocks.xa_lock   286472    [<00000000625a5626>] vm_map_ram+0x359/0x4a0
> > ...
> > <snip>
> > 
> > that is a result of running vm_map_ram()/vm_unmap_ram() in
> > a loop. The test creates 64(on 64 CPUs system) threads and
> > each one maps/unmaps 1 page.
> 
> With my understanding, the xarray will take more time when calling
> xa_insert() or xa_erase() because these two will cause xa_expand() and
> xa_shrink() if the index is sparse. xa_load() should be low cost to
> finish. Wondering if in your testing code, the mapping address is close
> or too far.
> 
> 1 mm/vmalloc.c <<new_vmap_block>>
>   err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
> 2 mm/vmalloc.c <<free_vmap_block>>
>   tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
> 3 mm/vmalloc.c <<vb_free>>
>   vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
> 4 mm/vmalloc.c <<vmap_ram_vread_iter>>
>   vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long )addr));
> 
> > 
> > After this change the "xa_lock" can be considered as a noise
> > in the same test condition:
> > 
> > <snip>
> > ...
> > &xa->xa_lock#1:         10333 10394 ...
> >   --------------
> >   &xa->xa_lock#1        5349      [<00000000bbbc9751>] xa_erase+0xe/0x30
> >   &xa->xa_lock#1        5045      [<0000000018def45d>] vm_map_ram+0x3a4/0x4f0
> >   --------------
> >   &xa->xa_lock#1        7326      [<0000000018def45d>] vm_map_ram+0x3a4/0x4f0
> >   &xa->xa_lock#1        3068      [<00000000bbbc9751>] xa_erase+0xe/0x30
> > ...
> > <snip>
> > 
> > This patch does not fix vmap_area_lock/free_vmap_area_lock and
> > purge_vmap_area_lock bottle-necks, it is rather a separate rework.
> > 
> > v1 - v2:
> >    - Add more comments(Andrew Morton req.)
> >    - Switch to WARN_ON_ONCE(Lorenzo Stoakes req.)
> > 
> > v2 -> v3:
> >    - Fix a kernel-doc complain(Matthew Wilcox)
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 85 +++++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 64 insertions(+), 21 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 978194dc2bb8..821256ecf81c 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1908,9 +1908,22 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> >  #define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
> >  #define VMAP_FLAGS_MASK		0x3
> >  
> > +/*
> > + * We should probably have a fallback mechanism to allocate virtual memory
> > + * out of partially filled vmap blocks. However vmap block sizing should be
> > + * fairly reasonable according to the vmalloc size, so it shouldn't be a
> > + * big problem.
> > + */
> >  struct vmap_block_queue {
> >  	spinlock_t lock;
> >  	struct list_head free;
> > +
> > +	/*
> > +	 * An xarray requires an extra memory dynamically to
> > +	 * be allocated. If it is an issue, we can use rb-tree
> > +	 * instead.
> > +	 */
> > +	struct xarray vmap_blocks;
> >  };
> >  
> >  struct vmap_block {
> > @@ -1928,24 +1941,46 @@ struct vmap_block {
> >  static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> >  
> >  /*
> > - * XArray of vmap blocks, indexed by address, to quickly find a vmap block
> > - * in the free path. Could get rid of this if we change the API to return a
> > - * "cookie" from alloc, to be passed to free. But no big deal yet.
> > + * In order to fast access to any "vmap_block" associated with a
> > + * specific address, we store them into a per-cpu xarray. A hash
> > + * function is addr_to_vbq() whereas a key is a vb->va->va_start
> > + * value.
> > + *
> > + * Please note, a vmap_block_queue, which is a per-cpu, is not
> > + * serialized by a raw_smp_processor_id() current CPU, instead
> > + * it is chosen based on a CPU-index it belongs to, i.e. it is
> > + * a hash-table.
> > + *
> > + * An example:
> > + *
> > + *  CPU_1  CPU_2  CPU_0
> > + *    |      |      |
> > + *    V      V      V
> > + * 0     10     20     30     40     50     60
> > + * |------|------|------|------|------|------|...<vmap address space>
> > + *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
> > + *
> > + * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
> > + *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
> > + *
> > + * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
> > + *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
> > + *
> > + * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
> > + *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
> >   */
> > -static DEFINE_XARRAY(vmap_blocks);
> > +static struct vmap_block_queue *
> > +addr_to_vbq(unsigned long addr)
> > +{
> > +	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> >  
> > -/*
> > - * We should probably have a fallback mechanism to allocate virtual memory
> > - * out of partially filled vmap blocks. However vmap block sizing should be
> > - * fairly reasonable according to the vmalloc size, so it shouldn't be a
> > - * big problem.
> > - */
> > +	return &per_cpu(vmap_block_queue, index);
> > +}
> >  
> > -static unsigned long addr_to_vb_idx(unsigned long addr)
> > +static unsigned long
> > +addr_to_vb_va_start(unsigned long addr)
> >  {
> > -	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
> > -	addr /= VMAP_BLOCK_SIZE;
> > -	return addr;
> > +	return rounddown(addr, VMAP_BLOCK_SIZE);
> >  }
> >  
> >  static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> > @@ -1953,7 +1988,7 @@ static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> >  	unsigned long addr;
> >  
> >  	addr = va_start + (pages_off << PAGE_SHIFT);
> > -	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
> > +	WARN_ON_ONCE(addr_to_vb_va_start(addr) != va_start);
> >  	return (void *)addr;
> >  }
> >  
> > @@ -1970,7 +2005,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  	struct vmap_block_queue *vbq;
> >  	struct vmap_block *vb;
> >  	struct vmap_area *va;
> > -	unsigned long vb_idx;
> >  	int node, err;
> >  	void *vaddr;
> >  
> > @@ -2003,8 +2037,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  	bitmap_set(vb->used_map, 0, (1UL << order));
> >  	INIT_LIST_HEAD(&vb->free_list);
> >  
> > -	vb_idx = addr_to_vb_idx(va->va_start);
> > -	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
> > +	vbq = addr_to_vbq(va->va_start);
> > +	err = xa_insert(&vbq->vmap_blocks, va->va_start, vb, gfp_mask);
> 
> Using va->va_start as index to access xarray may cost extra memory.
> Imagine we got a virtual address at VMALLOC_START, its region is
> [VMALLOC_START, VMALLOC_START+4095]. In the xarray, its sequence order
> is 0. While with va->va_start, it's 0xffffc90000000000UL on x86_64 with
> level4 paging mode. That means for the first page size vmalloc area,
> storing it into xarray need about 10 levels of xa_node, just for the one
> page size. With the old addr_to_vb_idx(), its index is 0. Only one level
> height is needed. One xa_node is about 72bytes, it could take more time
> and memory to access va->va_start. Not sure if my understanding is correct.
> 
> static unsigned long addr_to_vb_idx(unsigned long addr)
> {
>         addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
>         addr /= VMAP_BLOCK_SIZE;
>         return addr;
> }
> 
If the size of array depends on index "length", then, indeed it will require
more memory. From the other hand we can keep the old addr_to_vb_idx() function 
in order to "cut" a va->va_start index.

--
Uladzislau Rezki
