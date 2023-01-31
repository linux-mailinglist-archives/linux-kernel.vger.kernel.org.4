Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950B268322A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjAaQEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjAaQEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:04:47 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFF25140B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:04:26 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id u3so3009161uae.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XGZmY7Tt1HJYqMq5brkkG/QfW9zI5chcAr9ksUNQ6+c=;
        b=SP1ltVq7cdTVCK9AISOW+m93/NhA0++ySLTl9oTijKCpmzXfl+45FboohcIkCKMd1c
         +6IcbFKGUR6Epz5AQZYRHap9aAbzFHCrcLGxXiIEkw/SH8ti93E+rr7ZxkHGE5+3u0FI
         J17JYzE30j9gL8Ia86p3suAjzQ+LEzywr4Kh1xBxP8iEnof+/cjpqzYV/NN45pZUy4t2
         2REso6lCrMYSp4073+0t+xSXxI9ws9QVLceqf7l5KD6cxite+ZZo3O3gmi9agmz9glVf
         AKeKQONzNVzsZbPALGtEm3jcwGeWecbP0iCXvup8jOMT0AWLvMl9DfGAF4V6VTO3d0QK
         jx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGZmY7Tt1HJYqMq5brkkG/QfW9zI5chcAr9ksUNQ6+c=;
        b=SC5WuMy7tk3xV+WYRs9QXfW3kqBNu/XsO3pc/qLa3/Wsr8d/tWxpZ4i5OK5VFUxe4g
         jgRabn0l5XSqtHxnm09oFoYBzx1Oj4MtFN/M4QC8NjhFrTNCgI6zxUc+l8lyJJZAR7Pg
         b9Vw0l9miJKDxIESpwONHVtjWWSfneWmNJBlC2G7rBlREF8Guek0tyLh07Y1aRRmodAS
         GXDra53N9BOlD9VOAruaUqYBZA/xAoAczWf2m+lT/tdMuVD7hxfubt1Cf1g9xaOIAP87
         3NL834clxDNfwEPcQs8Dq/0qsPryIQdyKyqGpQsP7cAQ3UtU1WI47g0Y8Qwz98OCYnVb
         dUsQ==
X-Gm-Message-State: AFqh2krVz4yv+B8nNH5KfKs8+EB2xvbhB1tHOya//tJvwVRA3bLqnoWA
        YRpgKf+uDeaQXHh0d3/s695d4lB/68Zw1KVe65+C4Q==
X-Google-Smtp-Source: AMrXdXuytnhJwA8QUwdq+FsCn5crjUyy7UnTBO8zJNQTiwxf0TwtUWYOPRcufcT39/ORVz7TIu3VrV9RGCZwGkF569w=
X-Received: by 2002:ab0:31d0:0:b0:419:d115:2773 with SMTP id
 e16-20020ab031d0000000b00419d1152773mr6727916uan.29.1675181065076; Tue, 31
 Jan 2023 08:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20230130130739.563628-1-arnd@kernel.org> <Y9fITnjnIuDz8NYw@dhcp22.suse.cz>
 <CAG_fn=UC-zPKfXvhnXO-Hb7Wp3+BJyT4WvotATigigb63N0tdA@mail.gmail.com> <Y9kwTXhAQiEWz0IJ@dhcp22.suse.cz>
In-Reply-To: <Y9kwTXhAQiEWz0IJ@dhcp22.suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 17:03:48 +0100
Message-ID: <CAG_fn=XLRa0hz0R5JpLLWhe62669yGcT_ME5g8hEVo4yuXuOmg@mail.gmail.com>
Subject: Re: [PATCH] mm: extend max struct page size for kmsan
To:     Michal Hocko <mhocko@suse.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Right now KMSAN allocates its metadata at boot time, when tearing down memblock.
> > At that point only a handful of memory ranges exist, and it is pretty
> > easy to carve out some unused pages for the metadata for those ranges,
> > then divide the rest evenly and return 1/3 to the system, spending 2/3
> > to keep the metadata for the returned pages.
> > I tried allocating the memory lazily (at page_alloc(), for example),
> > and it turned out to be very tricky because of fragmentation: for an
> > allocation of a given order, one needs shadow and origin allocations
> > of the same order [1], and alloc_pages() simply started with ripping
> > apart the biggest chunk of memory available.
>
> page_ext allocation happens quite early as well. There shouldn't be any
> real fragmentation that early during the boot.

Assuming we are talking about the early_page_ext_enabled() case, here
are the init functions that are executed between kmsan_init_shadow()
and page_ext_init():

        stack_depot_early_init();
        mem_init();
        mem_init_print_info();
        kmem_cache_init();
        /*
         * page_owner must be initialized after buddy is ready, and also after
         * slab is ready so that stack_depot_init() works properly
         */
        page_ext_init_flatmem_late();
        kmemleak_init();
        pgtable_init();
        debug_objects_mem_init();
        vmalloc_init();

There's yet another problem besides fragmentation: we need to allocate
shadow for every page that was allocated by these functions.
Right now this is done by kmsan_init_shadow, which walks all the
existing memblock ranges, plus the _data segment and the node data for
each node, and grabs memory from the buddy allocator.
If we delay the metadata allocation to the point where memory caches
exist, we'll have to somehow walk every allocated struct page and
allocate the metadata for each of those. Is there an easy way to do
so?

I am unsure if vmalloc_init() creates any virtual mappings (probably
not?), but if it does, we'd also need to call
kmsan_vmap_pages_range_noflush() for them once we set up the metadata.
With the current metadata allocation scheme it's not needed, because
the buddy allocator is torn down before the virtual mappings are
created.

In the ideal world, we'd better place KMSAN shadow/origin pages at
fixed addresses, like this is done for KASAN - that would not require
storing pointers in struct page.
But reserving big chunks of the address space is even harder than
what's currently being done.
