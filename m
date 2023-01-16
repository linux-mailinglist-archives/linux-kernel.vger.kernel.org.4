Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD49266CE68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjAPSKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjAPSJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:09:50 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380F73F28E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:54:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o20so11775918lfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1jdt3zqp8+vihNO8d83ajsiCC9GXXQBkXGpmuLk4Zs4=;
        b=BnfVX22PJyTU2rnUz4ScLrN5Xta5JGIECsQySefTlhElXrgfPgQhCGw6rQCAmXyTPA
         f8tYMnEgM1mUQGLejD/7si8pxGnGTczlNGjQhQT+aMLN3alhdMPAYtQEEH+GebZaebe7
         W80xnODpbRvmTD0EJHojm3dXOqsbMVzkGRmOwjw4CiI1xBfJOqMBifr+eVKUqQ/UMKzg
         I228f0UHNB8+XzvF63AP1bm7pPkDK0WMChKPAMsz4y7aCVMN10JM+pslFu7SSacMtymI
         H3wHWTLc3OZVh15Ac/thDDtD12uHW0wQ/ZFR8Xavx3xq6D2Mx3pPtNTh1NlOKKaKyRMD
         yYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jdt3zqp8+vihNO8d83ajsiCC9GXXQBkXGpmuLk4Zs4=;
        b=x5sTbL3yWK15vP3Y4C76YP85+ifNe8/u7FVXy6Wq1kTPzjscqY05A5ZH7wXfNotzjx
         PH3cNJv6h+idyykhw7BoYtmJ0A7XOOnAiG3reACm9zaeoRwCKlCqvSSntiRmEafK0JLR
         94HKy1zGK8cVaiqdd+is1FEGFQz9cnn3pXwZ37y/bUcdZleOErZYZe43eBzQzZI/vxaj
         sxLAayRDMulhlp0lKF1B8PYDDK+YT4vFRY5d6ggxSZdC3b9w4ijXczFtt/jg+Cgx/tAj
         xhLG/sdCX1wHM6TLRJHbyRn7L2nMkyHHyPCr66gVmVwXBbt2eLqmH8eWa2TTOUK5wOy0
         wE/A==
X-Gm-Message-State: AFqh2ko2Re7oh3SgLlyw4AhYjVX9wSzosYwMtgNWj1JmKu0o9/XL2dki
        cV/6PKzNpKYDKRXAaWrEDbQ=
X-Google-Smtp-Source: AMrXdXs6k2eZUQ2G3TgxS7FwNXHILZ/IkSJDqimGBmu65SYdVuiLs+NUp0U1G5Mp+TbOj/wm6GgOfg==
X-Received: by 2002:a05:6512:3410:b0:4a4:68b8:f4db with SMTP id i16-20020a056512341000b004a468b8f4dbmr24974979lfr.33.1673891677491;
        Mon, 16 Jan 2023 09:54:37 -0800 (PST)
Received: from pc636 (host-90-235-24-7.mobileonline.telia.com. [90.235.24.7])
        by smtp.gmail.com with ESMTPSA id k14-20020a05651239ce00b004d4ead86cb2sm1034761lfu.20.2023.01.16.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 09:54:37 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Jan 2023 18:54:34 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y8WPWngsci0QPY0Y@pc636>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
 <Y6HpGayyQZH7U7Fd@pc636>
 <Y6UrPGMVYUMttKD3@MiWiFi-R3L-srv>
 <Y8DWG+OHV6E4cR8p@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8DWG+OHV6E4cR8p@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:55:07AM +0800, Baoquan He wrote:
> Hi Uladzislau Rezki，
> 
> On 12/23/22 at 12:14pm, Baoquan He wrote:
> > On 12/20/22 at 05:55pm, Uladzislau Rezki wrote:
> ......
>  > >  	spin_lock(&vmap_area_lock);
> > > >  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> > > > @@ -1887,6 +1889,10 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> > > >  
> > > >  #define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
> > > >  
> > > > +#define VMAP_RAM		0x1
> > > > +#define VMAP_BLOCK		0x2
> > > > +#define VMAP_FLAGS_MASK		0x3
> > > > 
> > > Maybe to rename a VMAP_BLOCK to something like VMAP_BLOCK_RESERVED or
> > > VMAP_PER_CPU_BLOCK?
> > 
> > Both VMAP_BLOCK or VMAP_PER_CPU_BLOCK look good to me, please see my
> > explanation at below.
> > 
> > > 
> > > >  struct vmap_block_queue {
> > > >  	spinlock_t lock;
> > > >  	struct list_head free;
> > > > @@ -1962,7 +1968,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> > > >  
> > > >  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
> > > >  					VMALLOC_START, VMALLOC_END,
> > > > -					node, gfp_mask);
> > > > +					node, gfp_mask,
> > > > +					VMAP_RAM|VMAP_BLOCK);
> > > >
> > > A new_vmap_block() is for a per-cpu path. As far as i see the VMAP_BLOCK
> > > flag is used to mark a VA that corresponds to a reserved per-cpu free area.
> > > 
> > > Whereas a VMAP_RAM is for VA that was obtained over per-cpu path but
> > > over alloc_vmap_area() thus a VA should be read out over "busy" tree
> > > directly.
> 
> Rethinking about the vmap->flags and the bit0->VMAP_RAM,
> bit1->VMAP_BLOCK correspondence, it looks better to use bit0->VMAP_RAM
> to indicate the vm_map_ram area, no matter how it's handled inside
> vm_map_ram() interface; and use bit1->VMAP_BLOCK to mark out the special
> vm_map_ram area which is further subdivided and managed by struct
> vmap_block. With these, you can see that we can identify vm_map_ram area
> and treat it as one type of vmalloc area, e.g in vread(), s_show().
> 
> Means when we are talking about vm_map_ram areas, we use
> (vmap->flags & VMAP_RAM) to recognize them; when we need to
> differentiate and handle vm_map_ram areas respectively, we use
> (vmap->flags & VMAP_BLOCK) to pick out the area which is further managed
> by vmap_block. Please help check if this is OK to you.
> 
> > > 
> > > Why do you need to set here both VMAP_RAM and VMAP_BLOCK?
> > 
> > My understanding is that the vm_map_ram area has two types, one is
> > the vb percpu area via vb_alloc(), the other is allocated via
> > alloc_vmap_area(). While both of them is got from vm_map_ram()
> > interface, this is the main point that distinguishes the vm_map_ram area
> > than the normal vmalloc area, and this makes vm_map_ram area not owning
> > va->vm pointer. So here, I use flag VMAP_RAM to mark the vm_map_ram
> > area, including the two types; meanwhile, I add VMAP_BLOCK to mark out
> > the vb percpu area. 
> > 
> > I understand people could have different view about them, e.g as you
> > said, use VMAP_RAM to mark the type of vm_map_ram area allocated through
> > alloc_vmap_area(), while use VMAP_PER_CPU_BLOCK to mark vb percpu area
> > from vb_alloc. In this way, we may need to rename VMAP_RAM to reflect
> > the area allocated from alloc_vmap_area() only. Both is fine to me.
> > 
> > > 
> > > >  	if (IS_ERR(va)) {
> > > >  		kfree(vb);
> > > >  		return ERR_CAST(va);
> > > > @@ -2229,8 +2236,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
> > > >  		return;
> > > >  	}
> > > >  
> > > > -	va = find_vmap_area(addr);
> > > > +	spin_lock(&vmap_area_lock);
> > > > +	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> > > >  	BUG_ON(!va);
> > > > +	if (va)
> > > > +		va->flags &= ~VMAP_RAM;
> > > > +	spin_unlock(&vmap_area_lock);
> > > >  	debug_check_no_locks_freed((void *)va->va_start,
> > > >
> > > Agree with Lorenzo. BUG_ON() should be out of spinlock(). Furthermore
> > > i think it makes sense to go with WARN_ON_ONCE() and do not kill a system.
> > > Instead emit a warning and bailout.
> > > 
> > > What do you think? Maybe separate patch for it?
> > 
> > Agree, your patch looks great to me. Thanks.
> > 
> > > 
> > > >  				    (va->va_end - va->va_start));
> > > >  	free_unmap_vmap_area(va);
> > > > @@ -2265,7 +2276,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
> > > >  	} else {
> > > >  		struct vmap_area *va;
> > > >  		va = alloc_vmap_area(size, PAGE_SIZE,
> > > > -				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> > > > +				VMALLOC_START, VMALLOC_END,
> > > > +				node, GFP_KERNEL, VMAP_RAM);
> > > >  		if (IS_ERR(va))
> > > >  			return NULL;
> > > >  
> > > > @@ -2505,7 +2517,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
> > > >  	if (!(flags & VM_NO_GUARD))
> > > >  		size += PAGE_SIZE;
> > > >  
> > > > -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask);
> > > > +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
> > > >  	if (IS_ERR(va)) {
> > > >  		kfree(area);
> > > >  		return NULL;
> > > >
> > > I know we have already discussed the new parameter. But what if we just
> > > use atomic_set operation to mark VA as either vmap-ram or vmap-block?
> 
> As I replied at above, I take the vm_map_ram as one kind of vmalloc
> area, and mark out the percpu vmap block handling of vm_map_ram area.
> Seems the passing in the flags through function parameter is better. Not
> sure if I got your suggestion correctly, and my code change is
> appropriate. I have sent v3 according to your and Lorenzo's comments and
> suggestion, and my rethinking after reading your words. I make some
> adjustment to try to remove misundersanding or confusion when reading
> patch and code. Please help check if it's OK.
> 
OK, if we decided to go with a parameter it is OK, it is not a big deal
and complexity. If needed it can be adjusted later on if there is a
need.

Thanks!

--
Uladzislau Rezki
