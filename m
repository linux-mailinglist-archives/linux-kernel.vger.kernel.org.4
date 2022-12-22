Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7BB653A25
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiLVAh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiLVAhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:37:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB62C248DE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:37:36 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so2783790wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hAdnUtu9qRVSKqpWG/Tpt14Jak70xwbh8SQrM071rQ8=;
        b=eVNjqgBwN0FXeAH2HzMCRHRF2VZdFv0VA8YCVCQ9nHtRIukFXj5Fl0Mcs20QSrNlp6
         9EWl211IiNbDFr9fLXFuam2ae+DZ0dws07t4QSSW1rQCj0boCFB/Q+/xbtxcDX49QeHX
         QV7a/bSbLwPloA7YwT4KpT8NC0CHnkQ/Px2B436AOQBQEOiHQUahLYwyepUPVRgTY0nZ
         PYintlSl3MpeFUPSKZSU0Fd9QGl3lcSgVc140rg5We/KF+S0hlYOatBxTDiFIUa3V7xi
         13ky7GKjofowgYpQYvM0OwyR/LxIIOJowSOsnsaNGZfp1vtbzZokMBXaojtDSjJVfLWE
         4sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAdnUtu9qRVSKqpWG/Tpt14Jak70xwbh8SQrM071rQ8=;
        b=B3FHR+E9Ao0fCxuenztPgi5CnGSIlueCkr/BQA5yQ+vibG+MqP/G4KwQjZV8STemIA
         c2P/x+ocU3SISzS8cX8MVuZWCJ/XIyN7qtPzN1iFBDIfpShhUQJlFec94/VLS/1AtOeu
         WVmuSJqIRkBKf97gwRcKiaI+lKTK3OQsxtSo7PrBywpT/aEY2LkIwB5uVkPOOBMP/Ylv
         b+YEE5+myBIgMC7yU8R+sJwlcsF0eMHOa6NVEDyOvL8vJoTi9rqfO4tiL3X+k8eeuqxw
         VtlLNgHFsSyh/eavu43C+lrbT8qxM45sbglGzeoF/R1rQ6Hmv7WLrd2pP4H+lFpBxlp0
         CiBA==
X-Gm-Message-State: AFqh2koylp7zmtpTx74PIBxhpCP5V30tWxwebrfLS8kEiJZf7+k4TkIh
        fMz6m+7iYKJH6LxIAQ7NQ8TUxbfGhB1kugZlZRI=
X-Google-Smtp-Source: AMrXdXsHgbK7EGFRNLH2qL0IwC1ZPob5Eily2pO2/NmLNbq+3gB8VvkaJs6e5gqPacWJ2EltX6R79Q3pO7xGpcXHd3o=
X-Received: by 2002:a7b:c7cb:0:b0:3cf:a511:3217 with SMTP id
 z11-20020a7bc7cb000000b003cfa5113217mr206730wmk.205.1671669455260; Wed, 21
 Dec 2022 16:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20221216192149.3902877-1-nphamcs@gmail.com> <20221216192149.3902877-4-nphamcs@gmail.com>
 <20221216134814.61c8d5119ceb4179c68e1cd7@linux-foundation.org>
In-Reply-To: <20221216134814.61c8d5119ceb4179c68e1cd7@linux-foundation.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 21 Dec 2022 16:37:23 -0800
Message-ID: <CAKEwX=Pw72ZRLFo-VuZ_B=AR26J4XtNynWk1dzDBoFDzpe1QDQ@mail.gmail.com>
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

On Fri, Dec 16, 2022 at 1:48 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 16 Dec 2022 11:21:48 -0800 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > Implement a new syscall that queries cache state of a file and
> > summarizes the number of cached pages, number of dirty pages, number of
> > pages marked for writeback, number of (recently) evicted pages, etc. in
> > a given range.
> >
> > NAME
> >     cachestat - query the page cache status of a file.
> >
> > SYNOPSIS
> >     #include <sys/mman.h>
> >
> >     struct cachestat {
> >         __u64 nr_cache;
> >         __u64 nr_dirty;
> >         __u64 nr_writeback;
> >         __u64 nr_evicted;
> >         __u64 nr_recently_evicted;
> >     };
> >
> >     int cachestat(unsigned int fd, off_t off, size_t len,
> >           size_t cstat_size, struct cachestat *cstat,
> >           unsigned int flags);
> >
> > DESCRIPTION
> >     cachestat() queries the number of cached pages, number of dirty
> >     pages, number of pages marked for writeback, number of (recently)
> >     evicted pages, in the bytes range given by `off` and `len`.
>
> I suggest this be spelled out better: "number of evicted and number or
> recently evicted pages".
>
> I suggest this clearly tell readers what an "evicted" page is - they
> aren't kernel programmers!

Valid points - I'll try to explain this more clearly in the future
versions of this patch series, especially in the draft man page.

>
> What is the benefit of the "recently evicted" pages?  "recently" seems
> very vague - what use is this to anyone?

This eviction recency semantics comes from the LRU's refault
computation. Users of cachestat might be interested in two very
different questions:

1. How many pages are not resident in the page cache.
2. How many pages are recently evicted (recently enough that
    their refault will be construed as memory pressure).

The first question is answered with nr_evicted, whereas the second
is answered with nr_recently_evicted.

I will figure out a way to explain this better in the next version. Users
definitely do not need to know the nitty gritty details of LRU logic,
but they should know the general idea of each field at least.

>
> >     These values are returned in a cachestat struct, whose address is
> >     given by the `cstat` argument.
> >
> >     The `off` and `len` arguments must be non-negative integers. If
> >     `len` > 0, the queried range is [`off`, `off` + `len`]. If `len` ==
> >     0, we will query in the range from `off` to the end of the file.
> >
> >     `cstat_size` allows users to obtain partial results. The syscall
> >     will copy the first `csstat_size` bytes to the specified userspace
> >     memory. `cstat_size` must be a non-negative value that is no larger
> >     than the current size of the cachestat struct.
> >
> >     The `flags` argument is unused for now, but is included for future
> >     extensibility. User should pass 0 (i.e no flag specified).
>
> Why is `flags' here?  We could add an unused flags arg to any syscall,
> but we don't.  What's the plan?

I included this field to ensure that cachestat can be extended safely,
especially when different users might want different things out of it.

For instance, in the future there might be new fields/computations
that are too heavy for certain use cases - a flag could be used to
disable/skip such fields/computations.

Another thing it might be used for is the huge page counting -
we have not implemented this in this version yet, but it might
introduce murky semantics to new/existing fields in struct
cachestat. Or maybe not - but worst case scenario we can
leave this decision to the users to decide through flags.

I'm sure there are more potential pitfalls that the flags could
save us from, but these are the two on top of my head.

>
> Are there security implications?  If I know that some process has a
> file open, I can use cachestat() to infer which parts of that file
> they're looking at (like mincore(), I guess).  And I can infer which
> parts they're writing to, unlike mincore().

This one, I'm not 100% sure, but it is a valid concern. Let me think
about it and discuss with more security-oriented minds before
responding to this.

>
> I suggest the [patch 1/4] fixup be separated from this series.

Sounds good! I'll loop Johannes in about this breakup as well.
