Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A26C9C42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjC0HhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjC0HhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:37:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C339558F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:36:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t11so10091999lfr.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679902593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=318LEVgLs5GfKsnkbXBEtpfsZyH32RaLTzfh7r4/RNc=;
        b=k9RZeIZm6jX+wZAPakN7BrSHARjyDQ8sTq75Lb0m8HhmOvFKrmfLVk8pBm97+4h5VO
         djUkbqeci8MwKkfXoXbqt544fwD45Fita/BajeCokf+7AX+B2/AYBp7FQhfHp+I7NNeb
         FqXi9yVgnUnv2y6BUDhk7JT+x7WtNpCQzgKhejJfTBnLpBbfwGKcmLhtD3bGBfUi+QKE
         fddjl7bzPFkHm+2lmj7OncwWwg4Ui1OfOtSCOk5b6rYymOQ8FzpReaLGE85hJqe1NnVG
         xf78IDDnpiqrOXBvD9b6gb5r/Qc8Cgpnb7xw3lj50MiQEdopV6absmPdKfpFzrXKltRl
         nAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=318LEVgLs5GfKsnkbXBEtpfsZyH32RaLTzfh7r4/RNc=;
        b=or/OwW3BUBdFPCmik5rRmxUYpjbtne4J1ZCi8lNHBUIyKqVde+MOPMnEoJbIdmoqK4
         PD18kzFda+ckUGGrTglRA5QynAosPEkEyEEfkycvAN5KJvLG/MlHLYEhNl2SRHNgFx0s
         u9qoTcAL4AEZtDmXYKTd3h7m3J1RYGHL7V57Gsh76eC6vpVpVfr8FeJ6GOytpKu/oUSX
         KAx732vrdPU44shViLrGFYNmeVAWivS7FPeklPmZRbYXFEuR4F38/n/1SnoS0wLH0nrC
         PTJAR1Jd8CB69/mpAM5mC1BD+DVghMiQ2kc8JpCl5kBy/AsUqsTIvfnpRWwxL64wGaOg
         Hamg==
X-Gm-Message-State: AAQBX9e+dTrYUrw6/nfnFTJfuEWqE3IehYQWlFSysGHVBq3+ph+vDzoR
        M+f4ZG6SrFxvYUS/FC2hGZw=
X-Google-Smtp-Source: AKy350aUFHBQkeJQFArJroOFt5AEe0B6M3bNqBWvmTIuXvld60QcaDR1S5Y0oVnWqa7UgVXqh1VKTg==
X-Received: by 2002:ac2:4434:0:b0:4eb:dd2:f3d2 with SMTP id w20-20020ac24434000000b004eb0dd2f3d2mr1026818lfl.43.1679902592632;
        Mon, 27 Mar 2023 00:36:32 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id x19-20020a19f613000000b004eb0e8e414bsm453118lfe.47.2023.03.27.00.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 00:36:32 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 27 Mar 2023 09:36:29 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCFHfRZ4P6ZvCUSV@pc636>
References: <20230323192111.1501308-1-urezki@gmail.com>
 <9ef9690d-cd79-4024-b7f1-eae2916cf5a2@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef9690d-cd79-4024-b7f1-eae2916cf5a2@lucifer.local>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:46:00PM +0000, Lorenzo Stoakes wrote:
> On Thu, Mar 23, 2023 at 08:21:11PM +0100, Uladzislau Rezki (Sony) wrote:
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
> 
> Nice! Really good to see contention reduced, but in addition I'm a huge fan
> of us removing the global state in vmalloc and this is a good start.
> 
> I've noticed a small perf regression after 3 runs of ./test_vmalloc.sh
> performance from an average of 119356136169 cycles to 120404645782 or +0.9%
> but this doesn't seem especially egregious.
> 
We are lack of extra vm_map_ram()/vm_unmap_ram() tests in the test_vmalloc.sh.
It would be good to add them to the test-suite.

> > This patch does not fix vmap_area_lock/free_vmap_area_lock and
> > purge_vmap_area_lock bottle-necks, it is rather a separate rework.
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 50 ++++++++++++++++++++++++++------------------------
> >  1 file changed, 26 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 978194dc2bb8..13b5342bed9a 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1911,6 +1911,7 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> >  struct vmap_block_queue {
> >  	spinlock_t lock;
> >  	struct list_head free;
> > +	struct xarray vmap_blocks;
> >  };
> >
> >  struct vmap_block {
> > @@ -1927,25 +1928,18 @@ struct vmap_block {
> >  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> >  static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> >
> > -/*
> > - * XArray of vmap blocks, indexed by address, to quickly find a vmap block
> > - * in the free path. Could get rid of this if we change the API to return a
> > - * "cookie" from alloc, to be passed to free. But no big deal yet.
> > - */
> 
> Doesn't this comment still apply? Or is the idea of returning the "cookie"
> not really viable?
> 
Since a vmap_block_queue is a per-cpu thing, though it is not fully
serialized in terms of per-cpu classical meaning, IMHO, it is not a
big issue.

If we return a cookie then, indeed, we do not need to find a vmap_block
and performance wise it should be better. For how much, i do not know, it
requires data. From the other hand an API has to be changed accordingly.

But i can leave the comment!

> > -static DEFINE_XARRAY(vmap_blocks);
> > -
> > -/*
> > - * We should probably have a fallback mechanism to allocate virtual memory
> > - * out of partially filled vmap blocks. However vmap block sizing should be
> > - * fairly reasonable according to the vmalloc size, so it shouldn't be a
> > - * big problem.
> > - */
> 
> Again, is this comment no longer relevant?
> 
Looks like yes :) But i am not sure i understand correctly what author meant.
It looks like this:

<snip>
void *vm_map_ram(struct page **pages, unsigned int count, int node)
{
	unsigned long size = (unsigned long)count << PAGE_SHIFT;
	unsigned long addr;
	void *mem;

	if (likely(count <= VMAP_MAX_ALLOC)) {
		mem = vb_alloc(size, GFP_KERNEL);
		if (IS_ERR(mem))
			return NULL;
...
<snip>

instead of returning NULL, go directly with a fall-back, that is:
<snip>
	struct vmap_area *va;
	va = alloc_vmap_area(size, PAGE_SIZE,
			VMALLOC_START, VMALLOC_END,
			node, GFP_KERNEL, VMAP_RAM);
	if (IS_ERR(va))
		return NULL;

	addr = va->va_start;
	mem = (void *)addr;
<snip>

> > +static struct vmap_block_queue *
> > +addr_to_vbq(unsigned long addr)
> > +{
> > +	int cpu = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > +	return &per_cpu(vmap_block_queue, cpu);
> > +}
> 
> Andrew's already commented on this, so I won't dwell but it does seem odd
> to subdivide by number of possible CPUs rather than just use the actual
> CPU. I guess your response to his question will also answer mine :)
> 
I will upload a v2 where i try to explain in detail as much as i can,
after that we can see if there are extra comments or questions and
discuss if so.

> >
> > -static unsigned long addr_to_vb_idx(unsigned long addr)
> > +static unsigned long
> > +addr_to_vb_va_start(unsigned long addr)
> >  {
> > -	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
> > -	addr /= VMAP_BLOCK_SIZE;
> > -	return addr;
> > +	/* A start address of block an address belongs to. */
> 
> A nit, but might be worth referring to the assert in vmap_block_vaddr(), as
> this comment seems a bit redundant otherwise as it is implied by the code
> it comments.
> 
OK. I can remove that comment.

> > +	return rounddown(addr, VMAP_BLOCK_SIZE);
> >  }
> >
> >  static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> > @@ -1953,7 +1947,7 @@ static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
> >  	unsigned long addr;
> >
> >  	addr = va_start + (pages_off << PAGE_SHIFT);
> > -	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
> > +	BUG_ON(addr_to_vb_va_start(addr) != addr_to_vb_va_start(va_start));
> 
> Maybe nitty, but perhaps better to WARN_ON() here to avoid BUG_ON proliferation?
> 
Indeed, it is better to go with WARN_ON() or even WARN_ON_ONCE().

> And can't this be the below?
> 
> WARN_ON(addr_to_vb_va_start(addr) != va_start);
> 
Yep, it can be. Thanks for it!

> >  	return (void *)addr;
> >  }
> >
> > @@ -1970,7 +1964,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  	struct vmap_block_queue *vbq;
> >  	struct vmap_block *vb;
> >  	struct vmap_area *va;
> > -	unsigned long vb_idx;
> >  	int node, err;
> >  	void *vaddr;
> >
> > @@ -2003,8 +1996,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  	bitmap_set(vb->used_map, 0, (1UL << order));
> >  	INIT_LIST_HEAD(&vb->free_list);
> >
> > -	vb_idx = addr_to_vb_idx(va->va_start);
> > -	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
> > +	vbq = addr_to_vbq(va->va_start);
> > +	err = xa_insert(&vbq->vmap_blocks, va->va_start, vb, gfp_mask);
> 
> This seems actually like a nice subtle improvement in that we are now
> indexing always on va_start explicitly and will always load using
> addr_to_vb_va_start().
>
Yep, because we already have an index, it is a va->va_start.

> 
> >  	if (err) {
> >  		kfree(vb);
> >  		free_vmap_area(va);
> > @@ -2021,9 +2014,11 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >
> >  static void free_vmap_block(struct vmap_block *vb)
> >  {
> > +	struct vmap_block_queue *vbq;
> >  	struct vmap_block *tmp;
> >
> > -	tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
> > +	vbq = addr_to_vbq(vb->va->va_start);
> > +	tmp = xa_erase(&vbq->vmap_blocks, vb->va->va_start);
> >  	BUG_ON(tmp != vb);
> >
> >  	spin_lock(&vmap_area_lock);
> > @@ -2135,6 +2130,7 @@ static void vb_free(unsigned long addr, unsigned long size)
> >  	unsigned long offset;
> >  	unsigned int order;
> >  	struct vmap_block *vb;
> > +	struct vmap_block_queue *vbq;
> >
> >  	BUG_ON(offset_in_page(size));
> >  	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
> > @@ -2143,7 +2139,10 @@ static void vb_free(unsigned long addr, unsigned long size)
> >
> >  	order = get_order(size);
> >  	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
> > -	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
> > +
> > +	vbq = addr_to_vbq(addr);
> > +	vb = xa_load(&vbq->vmap_blocks, addr_to_vb_va_start(addr));
> > +
> >  	spin_lock(&vb->lock);
> >  	bitmap_clear(vb->used_map, offset, (1UL << order));
> >  	spin_unlock(&vb->lock);
> > @@ -3486,6 +3485,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
> >  {
> >  	char *start;
> >  	struct vmap_block *vb;
> > +	struct vmap_block_queue *vbq;
> >  	unsigned long offset;
> >  	unsigned int rs, re, n;
> >
> > @@ -3503,7 +3503,8 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
> >  	 * Area is split into regions and tracked with vmap_block, read out
> >  	 * each region and zero fill the hole between regions.
> >  	 */
> > -	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> > +	vbq = addr_to_vbq((unsigned long) addr);
> > +	vb = xa_load(&vbq->vmap_blocks, addr_to_vb_va_start((unsigned long) addr));
> >  	if (!vb)
> >  		goto finished;
> >
> > @@ -4272,6 +4273,7 @@ void __init vmalloc_init(void)
> >  		p = &per_cpu(vfree_deferred, i);
> >  		init_llist_head(&p->list);
> >  		INIT_WORK(&p->wq, delayed_vfree_work);
> > +		xa_init(&vbq->vmap_blocks);
> >  	}
> >
> >  	/* Import existing vmlist entries. */
> > --
> > 2.30.2
> >
