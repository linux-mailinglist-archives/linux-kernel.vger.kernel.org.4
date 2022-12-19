Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E541A650918
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiLSJJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiLSJJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:09:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B0CD118
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:09:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y16so7947377wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPuIlazdNa8bEEQAv8f+ot8Iw/x3w5Arb8nwBFAXtxQ=;
        b=e603OMaaJGtgZrkEAXZi/CD/C9PkfwuC4uUsxJInKU/DhNwOSQlMu282cxpkbUHPAD
         bhcSHmxHAffCTgc+DiwNcBGC+nSmLmBnIkYco6Zernntd5HLPXGUfk5Ep7e4YhJGpCNd
         PeLTubNyxsP5eh26h31HyYFcK3Z+7h6V7QhYjJO+56JS0OIZ8fAUuo0iue5Q27Hm9DTo
         d7lQBnRXPHGgA4EwA5JvLYqVdc44ILdQ/jTStsFFO+s4ErMF9uIIS+Ki9/A4Dt1XHmp+
         mYxC2DRYzq7ohtFoxSWHe8fkZY+8FDqgYq6SpeFCznW+/bgftIPSw+009nhZXbMTgc2v
         0FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPuIlazdNa8bEEQAv8f+ot8Iw/x3w5Arb8nwBFAXtxQ=;
        b=b9bpRf2A0pv2lQ77OXR5CXhQ7239189cwGen5yjJeeIQB+0ol8zAfG4zj19bTDdIMZ
         SWy5QJcuSNMdJvjxu03Nazv08YMeUO7rPQ8m3sgEfJ/wvhJ8nTMVP9yDxXThj7vJ39nM
         qgPUbPWyY/DcBc05hOK/eoywgMw3W9ujoS8p78vOEpmv0WyMhRjweDOVYoW4rvxtjG92
         WiXONZr56Z7yOs0myGijz/iT2McXifpkLUxdaVisbmFH4EsrGVGHlGS97IdxWRFPfega
         eWZ4xNZScBfdULO6G9g2ZgDT5LlfG1OaNH8/+ZlGh2DJ/sYj6OdTyWHUyn5YdZg3HIXn
         IGIQ==
X-Gm-Message-State: ANoB5plkZ+zFIsamjLdDJE0SOsFrtBqzUG4Ti7Bj5naEMbKUGT9r+lKn
        JbUa/jx2PcbM+5R4RmQjV14=
X-Google-Smtp-Source: AA0mqf48gx6nM8+DueCd8yUWxuVBhHrh5VUYD64cb8pBNeaCVVyWNvX4Y0wJLm2nVA+r6bxOnYnp9A==
X-Received: by 2002:a5d:4ac3:0:b0:242:31bc:e009 with SMTP id y3-20020a5d4ac3000000b0024231bce009mr23234923wrs.2.1671440966714;
        Mon, 19 Dec 2022 01:09:26 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d5104000000b0024207ed4ce0sm9290164wrt.58.2022.12.19.01.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 01:09:25 -0800 (PST)
Date:   Mon, 19 Dec 2022 09:09:25 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y6AqRauq6wEYK0n5@lucifer>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
 <Y52rllbXHMwbpJ8K@lucifer>
 <Y6AaPKT7mdVxdHRl@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6AaPKT7mdVxdHRl@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:01:00PM +0800, Baoquan He wrote:
> On 12/17/22 at 11:44am, Lorenzo Stoakes wrote:
> > On Sat, Dec 17, 2022 at 09:54:30AM +0800, Baoquan He wrote:
> > > @@ -2229,8 +2236,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
> > >  		return;
> > >  	}
> > >
> > > -	va = find_vmap_area(addr);
> > > +	spin_lock(&vmap_area_lock);
> > > +	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> > >  	BUG_ON(!va);
> > > +	if (va)
> > > +		va->flags &= ~VMAP_RAM;
> > > +	spin_unlock(&vmap_area_lock);
> > >  	debug_check_no_locks_freed((void *)va->va_start,
> > >  				    (va->va_end - va->va_start));
> > >  	free_unmap_vmap_area(va);
> >
> > Would it be better to perform the BUG_ON() after the lock is released? You
> > already check if va exists before unmasking so it's safe.
>
> It's a little unclear to me why we care BUG_ON() is performed before or
> after the lock released. We won't have a stable kernel after BUG_ON()(),
> right?

BUG_ON()'s can be recoverable in user context and it would be a very simple
change that would not fundamentally alter anything to simply place the added
lines prior to the BUG_ON().

The code as-is doesn't really make sense anyway, you BUG_ON(!va) then check if
va is non-null, then immediately the function afterwards passes va around as if
it were not null, so I think it'd also be an aesthetic and logical improvement
:)

> >
> > Also, do we want to clear VMAP_BLOCK here?
>
> I do, but I don't find a good place to clear VMAP_BLOCK.
>
> In v1, I tried to clear it in free_vmap_area_noflush() as below,
> Uladzislau dislikes it. So I remove it. My thinking is when we unmap and
> free the vmap area, the vmap_area is moved from vmap_area_root into
> &free_vmap_area_root. When we allocate a new vmap_area via
> alloc_vmap_area(), we will allocate a new va by kmem_cache_alloc_node(),
> the va->flags must be 0. Seems not initializing it to 0 won't impact
> thing.
>

You are at this point clearing the VMAP_RAM flag though, so if it is unimportant
what the flags are after this call, why are you clearing this one?

It is just a little confusing, I wonder whether the VMAP_BLOCK flag is necessary
at all, is it possible to just treat a non-VMAP_BLOCK VMAP_RAM area as if it
were simply a fully occupied block? Do we gain much by the distinction?

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5d3fd3e6fe09..d6f376060d83 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1815,6 +1815,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>
>         spin_lock(&vmap_area_lock);
>         unlink_va(va, &vmap_area_root);
> +       va->flags = 0;
>         spin_unlock(&vmap_area_lock);
>
>         nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
>
> >
>
