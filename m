Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC93867F013
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjA0VCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjA0VCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:02:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901BD78AC7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:02:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j17so4317676wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ9VD42UJx69eknftpXX6RdpNul/NwkIopoYX82hUnE=;
        b=STutomE6QbnMg9BRuOshCbkA33xoKYjYOD6zV+8g0CrO8O4J++ls51gbTYckGVxbVx
         k8Z4rieomHdVPxcdQpVCgiat/6iGe+MbNLsFrXsJ+CVY4YJl0zv5/Fehmzy9tGmrF5Ng
         tVmj/L5tbilfg5sg/OZ4Ot3NBWjYrS7gmFj3A4BTzpQJN4X5lTW3cS0nqSgM+x1BZDLy
         lKuVEfvKeo6F0YG2z1k+A+S9maamfWKqeFi/aZo8OOKB0rqchBQad9UIHhmfKLD7XS89
         VS2j9jtS3aApjRTbXQZSy0i1wfig/CcJDcvd0s2B/hJElkMaRJ838zQVw36T1v7O927m
         qNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJ9VD42UJx69eknftpXX6RdpNul/NwkIopoYX82hUnE=;
        b=3nD6QVn2QrHb6LweOvVGTDPdcY/bIy2ubMvQ7Jv9NdZcDk6RRCSV1nftk9y8B3x8ur
         peGrEwlHNgKhdFWF4jClz9fI5Wez5nbo7FvkWdPz9oJFaHVwTK3NP08EgAAuVB/cEbPA
         cpQk5rW2E/jyX9e/WsPBtSBuCSURik58MW4JTM7UwiLsprcvxDi74as8A1Ew9rQ+7OrE
         dlI/vMqiyNEvC7q+Zid5zIrcl/aiQNRIsC5LdWiTFwjqmqZUEn1+HAZanp8BYc4gaiVV
         Y5dmVsA2NDFa831upxpcSkEbpdYCyOZLMnNEJ53W5b4M0M/ehat1IrwtxHLNbYhX9+4y
         zhQg==
X-Gm-Message-State: AFqh2ko3R6NR9RIMGiaP5Mf0enAK9/awikYEraYHxgCNxkHUY7aIelj2
        Fgq25tHswKWjJ7S6iTfMux6y2AOZ8pw6zwvsDlOehQ==
X-Google-Smtp-Source: AMrXdXvd5aXgip5Qzac3nnS4UJh41q1WH7DpBV8Y177SVJ9L+IRjPYscACsdX6w/p31TMB4jchpss74qO3nAuW0unDA=
X-Received: by 2002:a05:600c:ad5:b0:3da:1b37:8ff5 with SMTP id
 c21-20020a05600c0ad500b003da1b378ff5mr2331389wmr.166.1674853359019; Fri, 27
 Jan 2023 13:02:39 -0800 (PST)
MIME-Version: 1.0
References: <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com> <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey> <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey> <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com> <Y9Li93O6Ffwcr+vn@x1n>
In-Reply-To: <Y9Li93O6Ffwcr+vn@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Fri, 27 Jan 2023 13:02:02 -0800
Message-ID: <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Thu, Jan 26, 2023 at 12:31 PM Peter Xu <peterx@redhat.com> wrote:
>
> James,
>
> On Thu, Jan 26, 2023 at 08:58:51AM -0800, James Houghton wrote:
> > It turns out that the THP-like scheme significantly slows down
> > MADV_COLLAPSE: decrementing the mapcounts for the 4K subpages becomes
> > the vast majority of the time spent in MADV_COLLAPSE when collapsing
> > 1G mappings. It is doing 262k atomic decrements, so this makes sense.
> >
> > This is only really a problem because this is done between
> > mmu_notifier_invalidate_range_start() and
> > mmu_notifier_invalidate_range_end(), so KVM won't allow vCPUs to
> > access any of the 1G page while we're doing this (and it can take like
> > ~1 second for each 1G, at least on the x86 server I was testing on).
>
> Did you try to measure the time, or it's a quick observation from perf?

I put some ktime_get()s in.

>
> IIRC I used to measure some atomic ops, it is not as drastic as I thought.
> But maybe it depends on many things.
>
> I'm curious how the 1sec is provisioned between the procedures.  E.g., I
> would expect mmu_notifier_invalidate_range_start() to also take some time
> too as it should walk the smally mapped EPT pgtables.

Somehow this doesn't take all that long (only like 10-30ms when
collapsing from 4K -> 1G) compared to hugetlb_collapse().

>
> Since we'll still keep the intermediate levels around - from application
> POV, one other thing to remedy this is further shrink the size of COLLAPSE
> so potentially for a very large page we can start with building 2M layers.
> But then collapse will need to be run at least two rounds.

That's exactly what I thought to do. :) I realized, too, that this is
actually how userspace *should* collapse things to avoid holding up
vCPUs too long. I think this is a good reason to keep intermediate
page sizes.

When collapsing 4K -> 1G, the mapcount scheme doesn't actually make a
huge difference: the THP-like scheme is about 30% slower overall.

When collapsing 4K -> 2M -> 1G, the mapcount scheme makes a HUGE
difference. For the THP-like scheme, collapsing 4K -> 2M requires
decrementing and then re-incrementing subpage->_mapcount, and then
from 2M -> 1G, we have to decrement all 262k subpages->_mapcount. For
the head-only scheme, for each 2M in the 4K -> 2M collapse, we
decrement the compound_mapcount 512 times (once per PTE), then
increment it once. And then for 2M -> 1G, for each 1G, we decrement
mapcount again by 512 (once per PMD), incrementing it once.

The mapcount decrements are about on par with how long it takes to do
other things, like updating page tables. The main problem is, with the
THP-like scheme (implemented like this [1]), there isn't a way to
avoid the 262k decrements when collapsing 1G. So if we want
MADV_COLLAPSE to be fast and we want a THP-like page_mapcount() API,
then I think something more clever needs to be implemented.

[1]: https://github.com/48ca/linux/blob/hgmv2-jan24/mm/hugetlb.c#L127-L178


- James
