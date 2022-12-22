Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E386542C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiLVOWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiLVOWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:22:07 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC1286F0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:22:05 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g13so2938106lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDd7wGgsS2+0SAKYEIGw8VztMH3gr95vwLLvFognSgs=;
        b=Oqxt1IEWoAUAhvn6kaRaX+EwSjlEDb2kViD+Jq7Pzb80ZQhbTeRASJVyHAdlqk4DDO
         KDFBY3WZ0E8davmCLOOw7wNLE8EDHSBkUPmH5+nAWfBQlOLRLFeCUko1Vt4nfHG+NZDD
         YFQVhPAK6xI3o03fiwfQUu8yfTMOwqWkgDp7axfKHYQBILZZYbJJu0RtFus+xfLLCVLo
         9/SGogEQCweufi6nLirldk0qkKjFDSfV/sr3ZTBMBC4Nl7nkSs/UQKbNZjWNrpSK+qX6
         2QlyaPKRMG34uMOoc2VvOd5yZDAO1XYzdIp9ln7/4166/bubOjChH0fKHwAVfV9G15JT
         H+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDd7wGgsS2+0SAKYEIGw8VztMH3gr95vwLLvFognSgs=;
        b=6N9fR6wYP7BztpAp5v/khwxdBZI4Uw2RRqXtaHNUhAzG/IJ4eUVlu+Bi9yHHPfQ/ic
         KxAm2CyOOBN4+6H615zYDasR1PU0GvHacYuIoEaq44/5xuUPM557BvzeKv1f9yMzCYmR
         /H+DK5nUUVGJ2YdcnDqOZvYl+ROwUEHDynVkDn75ekOITR8Lmb22/kQZTTQ+KF8BwmT1
         hOLhJV8yMxHECAFmpfKmwLH/o1xMmDKgfPzgxMORH5RWVOwR6QZkUOItJzIPXCnv7cRa
         i7fKIDRcvXzTLQgIrn+i6WHuI/UEqZZ76doLLxQPsQtuE4hsHaS/Qewyovu13fzc3KbH
         SAyg==
X-Gm-Message-State: AFqh2kq0jbxy9/RRtWOCPqeehZRInyUQRKQxu19pqUVvewM2tZOLbKE8
        pkDpl94+2++iEp5/qgmAISM=
X-Google-Smtp-Source: AMrXdXtEL69S3W027zNimuG2jPMNkd1i6DxcGUOJOqJa/Z7nHMEwHbuOlU2URBcplUEghBYoQarZkw==
X-Received: by 2002:a05:6512:2393:b0:4a4:68b9:1a00 with SMTP id c19-20020a056512239300b004a468b91a00mr2269494lfv.40.1671718923807;
        Thu, 22 Dec 2022 06:22:03 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id d21-20020ac24c95000000b0049465afdd38sm83755lfl.108.2022.12.22.06.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:22:03 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 22 Dec 2022 15:22:01 +0100
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Avoid of calling __find_vmap_area()
 twise in __vunmap()
Message-ID: <Y6RoCWJxNxkTmHw1@pc636>
References: <20221221174454.1085130-1-urezki@gmail.com>
 <Y6Nabg5g5gbD6J6K@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Nabg5g5gbD6J6K@lucifer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Some pedantic grammar/spelling stuff:-
> 
> (I know it can be a little annoying to get grammatical suggestions so I do hope
> that it isn't too irritating!)
> 
It is absolutely OK :)

>
> For the Subject line:-
> 'mm: vmalloc: Avoid of calling __find_vmap_area() twise in __vunmap()' ->
> 'mm: vmalloc: Avoid calling __find_vmap_area() twice in __vunmap()'
> 
Will fix in the v3.

> On Wed, Dec 21, 2022 at 06:44:52PM +0100, Uladzislau Rezki (Sony) wrote:
> > Currently __vunmap() path calls __find_vmap_area() two times. One on
> > entry to check that area exists, second time inside remove_vm_area()
> > function that also performs a new search of VA.
> 
> Perhaps slightly tweak to:-
> 
> "Currently the __vunmap() path calls __find_vmap_area() twice. Once on entry
>  to check that the area exists, then inside the remove_vm_area() function
>  which also performs a new search for the VA."
> 
Will fix in the v3.

> >
> > In order to improvie it from a performance point of view we split
> > remove_vm_area() into two new parts:
> >   - find_unlink_vmap_area() that does a search and unlink from tree;
> >   - __remove_vm_area() that does a removing but without searching.
> 
> 'that does a removing but without searching' reads better I think as
> 'that removes without searching'.
> 
Will fix in the v3.

> >
> > In this case there is no any functional change for remove_vm_area()
> > whereas vm_remove_mappings(), where a second search happens, switches
> > to the __remove_vm_area() variant where already detached VA is passed
> > as a parameter, so there is no need to find it again.
> >
> 
> 'where already detached VA' -> 'where the already detached VA' as a minor nit
> here!
> 
Will fix it.

> > Performance wise, i use test_vmalloc.sh with 32 threads doing alloc
> > free on a 64-CPUs-x86_64-box:
> >
> > perf without this patch:
> > -   31.41%     0.50%  vmalloc_test/10  [kernel.vmlinux]    [k] __vunmap
> >    - 30.92% __vunmap
> >       - 17.67% _raw_spin_lock
> >            native_queued_spin_lock_slowpath
> >       - 12.33% remove_vm_area
> >          - 11.79% free_vmap_area_noflush
> >             - 11.18% _raw_spin_lock
> >                  native_queued_spin_lock_slowpath
> >         0.76% free_unref_page
> >
> > perf with this patch:
> > -   11.35%     0.13%  vmalloc_test/14  [kernel.vmlinux]    [k] __vunmap
> >    - 11.23% __vunmap
> >       - 8.28% find_unlink_vmap_area
> >          - 7.95% _raw_spin_lock
> >               7.44% native_queued_spin_lock_slowpath
> >       - 1.93% free_vmap_area_noflush
> >          - 0.56% _raw_spin_lock
> >               0.53% native_queued_spin_lock_slowpath
> >         0.60% __vunmap_range_noflush
> >
> > __vunmap() consumes around ~20% less CPU cycles on this test.
> 
> Very nice, amazing work!
> 
Thanks!

> >
> > Reported-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 66 +++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 42 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 9e30f0b39203..28030d2441f1 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1825,9 +1825,11 @@ static void free_vmap_area_noflush(struct vmap_area *va)
> >  	unsigned long va_start = va->va_start;
> >  	unsigned long nr_lazy;
> >
> > -	spin_lock(&vmap_area_lock);
> > -	unlink_va(va, &vmap_area_root);
> > -	spin_unlock(&vmap_area_lock);
> > +	if (!list_empty(&va->list)) {
> > +		spin_lock(&vmap_area_lock);
> > +		unlink_va(va, &vmap_area_root);
> > +		spin_unlock(&vmap_area_lock);
> > +	}
> 
> Do we want to do the same in free_vmap_area()?
> 
The free_vmap_area() is a bit special. It only pairs with alloc_vmap_area(). 
There are two users and both invoke free_vmap_area() in a error path. So probably
it would be good to remove it fully. But it requires some refactoring.

> >
> >  	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
> >  				PAGE_SHIFT, &vmap_lazy_nr);
> > @@ -1871,6 +1873,19 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> >  	return va;
> >  }
> >
> > +static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> > +{
> > +	struct vmap_area *va;
> > +
> > +	spin_lock(&vmap_area_lock);
> > +	va = __find_vmap_area(addr, &vmap_area_root);
> > +	if (va)
> > +		unlink_va(va, &vmap_area_root);
> > +	spin_unlock(&vmap_area_lock);
> > +
> > +	return va;
> > +}
> > +
> >  /*** Per cpu kva allocator ***/
> >
> >  /*
> > @@ -2591,6 +2606,20 @@ struct vm_struct *find_vm_area(const void *addr)
> >  	return va->vm;
> >  }
> >
> > +static struct vm_struct *__remove_vm_area(struct vmap_area *va)
> > +{
> > +	struct vm_struct *vm;
> > +
> > +	if (!va || !va->vm)
> > +		return NULL;
> > +
> > +	vm = va->vm;
> > +	kasan_free_module_shadow(vm);
> > +	free_unmap_vmap_area(va);
> > +
> > +	return vm;
> > +}
> > +
> >  /**
> >   * remove_vm_area - find and remove a continuous kernel virtual area
> >   * @addr:	    base address
> > @@ -2607,22 +2636,8 @@ struct vm_struct *remove_vm_area(const void *addr)
> >
> >  	might_sleep();
> >
> > -	spin_lock(&vmap_area_lock);
> > -	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> > -	if (va && va->vm) {
> > -		struct vm_struct *vm = va->vm;
> > -
> > -		va->vm = NULL;
> > -		spin_unlock(&vmap_area_lock);
> > -
> > -		kasan_free_module_shadow(vm);
> > -		free_unmap_vmap_area(va);
> > -
> > -		return vm;
> > -	}
> > -
> > -	spin_unlock(&vmap_area_lock);
> > -	return NULL;
> > +	va = find_unlink_vmap_area((unsigned long) addr);
> > +	return __remove_vm_area(va);
> >  }
> 
> Really nice separation of concerns and cleanup.
> 
Thanks!

> >
> >  static inline void set_area_direct_map(const struct vm_struct *area,
> > @@ -2637,15 +2652,16 @@ static inline void set_area_direct_map(const struct vm_struct *area,
> >  }
> >
> >  /* Handle removing and resetting vm mappings related to the vm_struct. */
> > -static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
> > +static void vm_remove_mappings(struct vmap_area *va, int deallocate_pages)
> 
> Perhaps rename this to va_remove_mappings() or vmap_area_remove_mappings() since
> it is now explicitly accepting a vmap_area rather than vm_struct?
> 
I agree. There is a discrepancy. I can rename it to the va_remove_mappings()
if there are no any complains from others.

> >  {
> > +	struct vm_struct *area = va->vm;
> >  	unsigned long start = ULONG_MAX, end = 0;
> >  	unsigned int page_order = vm_area_page_order(area);
> >  	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
> >  	int flush_dmap = 0;
> >  	int i;
> >
> > -	remove_vm_area(area->addr);
> > +	__remove_vm_area(va);
> >
> >  	/* If this is not VM_FLUSH_RESET_PERMS memory, no need for the below. */
> >  	if (!flush_reset)
> > @@ -2690,6 +2706,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
> >  static void __vunmap(const void *addr, int deallocate_pages)
> >  {
> >  	struct vm_struct *area;
> 
> Feels like it's getting a bit confusing with 'va' representing vmap_area and
> 'area' which represents... vm_struct (this file has a bunch of naming
> inconsistencies like this actually), perhaps rename this to 'vm'?
> 
We can. I think it should be a separate patch-set for refactoring of
things like: va, vm, area, vmap, etc :)

> > +	struct vmap_area *va;
> >
> >  	if (!addr)
> >  		return;
> > @@ -2698,19 +2715,20 @@ static void __vunmap(const void *addr, int deallocate_pages)
> >  			addr))
> >  		return;
> >
> > -	area = find_vm_area(addr);
> > -	if (unlikely(!area)) {
> > +	va = find_unlink_vmap_area((unsigned long)addr);
> > +	if (unlikely(!va)) {
> >  		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
> >  				addr);
> >  		return;
> >  	}
> >
> > +	area = va->vm;
> >  	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
> >  	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
> >
> >  	kasan_poison_vmalloc(area->addr, get_vm_area_size(area));
> >
> > -	vm_remove_mappings(area, deallocate_pages);
> > +	vm_remove_mappings(va, deallocate_pages);
> >
> >  	if (deallocate_pages) {
> >  		int i;
> > --
> > 2.30.2
> >
> 
> Other than some pendatic points about grammar/naming this looks really good!
>
Thank you for the review!

--
Uladzislau Rezki
