Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD7666264
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjAKSAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjAKSA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:00:28 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464BA13F7D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:00:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so14998054wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=st+rBfXe657tktuM+VC62FoufdfMZ6foNZG+N8Yy0J4=;
        b=Z2VFQQvScbNOgpYADSIjXCaR031NtVBvEhLSqtA1ZWt1AYcUONDha6jpfpwQejZeFG
         Scj3GxKPZKJYColGxugCLFRnl4mwOqe1Vijvnotfs41GlUo9ClpK4vH9P3ql9J//bYo9
         nHnfgE/qdbUYLVMkQN47Q0S2UgntwmN0tn8iGbM78Egrfq7WbH1HGw4+7xXefu4u25xA
         vqd76h2vsw0Z5Zpt77Ijx57KeVSU7jH4jhXvgWYfDTWIeTosPeZ+jzW74mfVXhCqASTS
         4fpQHfn6EfRBGHSB+1w135Dvf2JK4X4I4NWoaoZqkd6+TXuYIbudXCfT2D44P3pGpAMV
         xUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=st+rBfXe657tktuM+VC62FoufdfMZ6foNZG+N8Yy0J4=;
        b=EwmLOdq6znEbsu2UnUPRVv6+cgZiNVyeaiCJjxt3togPgMRmBZ/hS76M/3Cau4eFno
         bZbwvV2s0DTgh7e/5+3/MRGbFcfgAD5gaY0l2xib7YHzz2mR2xbT02/4meurdh4iAotv
         YvtGjA0L5Oj1kozDT55Gv/iDU4bmYVGqEQcC60FWK3yENkCkvBuBVKpn87Cmnz9tvkCN
         7xSfWoyZpxCyZcxNAzeKd0za0OE3OsJ2KvGzjfBOIHLWMP11YNdXEikb5VHGcY4lPvz3
         77TMi0axMIw3gAhefh4Bg3AUIuvf17BFF+3LVq+gui652kJz6aFAyaBy9T5Hh/Q2ljYx
         MvcA==
X-Gm-Message-State: AFqh2kpAjXZgv+vlKrGs7smoHQgz1dxoWumOnwlVvCoSHbY1rj9YvNFR
        hl0MOse6FyqqGCS3oWm+MRb31lY29FH+n0XDcW0=
X-Google-Smtp-Source: AMrXdXu4ANeLrh0mXoN96h38xoOI20kDaWI2yGU5iz/RkxOKrLUUP0joFd8pz/CIRKVE+9pTwQiD3W29jq3fb7iTksg=
X-Received: by 2002:a05:600c:1c90:b0:3d2:1d51:2476 with SMTP id
 k16-20020a05600c1c9000b003d21d512476mr3468587wms.77.1673460025717; Wed, 11
 Jan 2023 10:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20221216192149.3902877-1-nphamcs@gmail.com> <20221216192149.3902877-4-nphamcs@gmail.com>
 <20221216134814.61c8d5119ceb4179c68e1cd7@linux-foundation.org> <CAKEwX=Pw72ZRLFo-VuZ_B=AR26J4XtNynWk1dzDBoFDzpe1QDQ@mail.gmail.com>
In-Reply-To: <CAKEwX=Pw72ZRLFo-VuZ_B=AR26J4XtNynWk1dzDBoFDzpe1QDQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 11 Jan 2023 10:00:14 -0800
Message-ID: <CAKEwX=Ppf=WbOuV2Rh3+V8ohOYXo=CnfSu9qqSh-DpVvfy2nhA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] cachestat: implement cachestat syscall
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 4:37 PM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Fri, Dec 16, 2022 at 1:48 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 16 Dec 2022 11:21:48 -0800 Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > > Implement a new syscall that queries cache state of a file and
> > > summarizes the number of cached pages, number of dirty pages, number of
> > > pages marked for writeback, number of (recently) evicted pages, etc. in
> > > a given range.
> > >
> > > NAME
> > >     cachestat - query the page cache status of a file.
> > >
> > > SYNOPSIS
> > >     #include <sys/mman.h>
> > >
> > >     struct cachestat {
> > >         __u64 nr_cache;
> > >         __u64 nr_dirty;
> > >         __u64 nr_writeback;
> > >         __u64 nr_evicted;
> > >         __u64 nr_recently_evicted;
> > >     };
> > >
> > >     int cachestat(unsigned int fd, off_t off, size_t len,
> > >           size_t cstat_size, struct cachestat *cstat,
> > >           unsigned int flags);
> > >
> > > DESCRIPTION
> > >     cachestat() queries the number of cached pages, number of dirty
> > >     pages, number of pages marked for writeback, number of (recently)
> > >     evicted pages, in the bytes range given by `off` and `len`.
> >
> > I suggest this be spelled out better: "number of evicted and number or
> > recently evicted pages".
> >
> > I suggest this clearly tell readers what an "evicted" page is - they
> > aren't kernel programmers!
>
> Valid points - I'll try to explain this more clearly in the future
> versions of this patch series, especially in the draft man page.
>
> >
> > What is the benefit of the "recently evicted" pages?  "recently" seems
> > very vague - what use is this to anyone?
>
> This eviction recency semantics comes from the LRU's refault
> computation. Users of cachestat might be interested in two very
> different questions:
>
> 1. How many pages are not resident in the page cache.
> 2. How many pages are recently evicted (recently enough that
>     their refault will be construed as memory pressure).
>
> The first question is answered with nr_evicted, whereas the second
> is answered with nr_recently_evicted.
>
> I will figure out a way to explain this better in the next version. Users
> definitely do not need to know the nitty gritty details of LRU logic,
> but they should know the general idea of each field at least.
>
> >
> > >     These values are returned in a cachestat struct, whose address is
> > >     given by the `cstat` argument.
> > >
> > >     The `off` and `len` arguments must be non-negative integers. If
> > >     `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
> > >     0, we will query in the range from `off` to the end of the file.
> > >
> > >     `cstat_size` allows users to obtain partial results. The syscall
> > >     will copy the first `csstat_size` bytes to the specified userspace
> > >     memory. `cstat_size` must be a non-negative value that is no larger
> > >     than the current size of the cachestat struct.
> > >
> > >     The `flags` argument is unused for now, but is included for future
> > >     extensibility. User should pass 0 (i.e no flag specified).
> >
> > Why is `flags' here?  We could add an unused flags arg to any syscall,
> > but we don't.  What's the plan?
>
> I included this field to ensure that cachestat can be extended safely,
> especially when different users might want different things out of it.
>
> For instance, in the future there might be new fields/computations
> that are too heavy for certain use cases - a flag could be used to
> disable/skip such fields/computations.
>
> Another thing it might be used for is the huge page counting -
> we have not implemented this in this version yet, but it might
> introduce murky semantics to new/existing fields in struct
> cachestat. Or maybe not - but worst case scenario we can
> leave this decision to the users to decide through flags.
>
> I'm sure there are more potential pitfalls that the flags could
> save us from, but these are the two on top of my head.
>
> >
> > Are there security implications?  If I know that some process has a
> > file open, I can use cachestat() to infer which parts of that file
> > they're looking at (like mincore(), I guess).  And I can infer which
> > parts they're writing to, unlike mincore().
>
> This one, I'm not 100% sure, but it is a valid concern. Let me think
> about it and discuss with more security-oriented minds before
> responding to this.

Hmm I've given it some more thought. The syscall does not seem to
expose any extra security issue, given that the user already has
read permission to the file itself (since they have an fd to that file).
This means that the user can already know the underlying data in its
entirety, which seems like much more information (and as a result,
security risk) than the cache status itself.

Do you have something concrete in mind that I might have missed?

>
> >
> > I suggest the [patch 1/4] fixup be separated from this series.
>
> Sounds good! I'll loop Johannes in about this breakup as well.
