Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069D0618A68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiKCVQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiKCVQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:16:34 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD511C407
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:16:32 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id s204so1400574vkb.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GxbgKpNvpuctBcOXC1/QJiEugMRbnIx1ObQ8fGyth64=;
        b=PqOcRVz6qevyHCxuYwmIGiqE5J/GeuXURfakrJoQJhlQiujI8nCDJnYKgbT5mh0E6I
         MbJbng6TeaKpO2IVBOQr+EStRIAKdnRSC+RwCKcV2fO7r2jXNEiO5MOVwENrWKLAwV9y
         PnPYhRyUJJRmMjpsdHZjK+57kvV7/ZDESZuK8MZ0HSEfeMVs6KaJ0eAMA+AMenPASf9c
         AO/wVPoz8bv7zNJKeGkcs9UExbw8gsJQbVAz3z6XLs4BAAgPlD150x5/dg/UkHgRX/6q
         PVjXRNLlxw34vUU9bCfF4kPnbiAKqNVLg9YIP+PzYQibYrxVCU282uwPg+hEOwT7jkl2
         K8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxbgKpNvpuctBcOXC1/QJiEugMRbnIx1ObQ8fGyth64=;
        b=f9zO259hbKYucY5aZiiyXiEJh4Pb8bLIkduvsXijpn4Vjb32u8Q7yeHGitdIahYTYd
         295fOvpnIjvwhXyCsLqat3OWen4XMkSVoj2Ndlxr5LmAAiAi+qLyzYdV/JFkBHCGRCUa
         3ZoJPBYdYDskwDinflZ8qp+DLW8mEd55uPF8zGeSko8HBEEJ1kiydavZxC6zbsb/Gsi0
         AzynL3VYMIw40OuMa+Mlzsjn0qdXW7MejqlkkCblpKeiR95PbSLruhVCZDONH0JTFQYV
         TZIFHXouXzQk4M2MGC4HQwZxKv7cGQcX/t2UZsj9dAmKzUxrtpjQCxT9FSv7Fgimb5gx
         YBZw==
X-Gm-Message-State: ACrzQf30CV+TbpDG62YjBHJT/DKw0zLIO3I1PEOhiZj6g9AOISdKDNGF
        HSj1hCepZKQ3W5Jz06TORrseJ2v8gWCFtbBlGYBurtGilPk=
X-Google-Smtp-Source: AMsMyM4DJXy05TsZ0QglIDE9fh/bXHzldYn3jsQWcwgUyjNgVxinvOUrfS2qc22acztbfTShrIuNHQhQQ5085Ln1M7k=
X-Received: by 2002:ac5:c969:0:b0:3b6:2a34:a26b with SMTP id
 t9-20020ac5c969000000b003b62a34a26bmr18888318vkm.30.1667510190960; Thu, 03
 Nov 2022 14:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221026200613.1031261-1-nphamcs@gmail.com> <20221026200613.1031261-3-nphamcs@gmail.com>
 <Y2Hj+H4VzlN/fcmR@google.com> <Y2Li412OGB6g8ARA@google.com>
 <Y2PbrOqRMLDsYev0@cmpxchg.org> <Y2Pj+fuON8lTMcmn@google.com>
 <Y2QDgSAc7FcIaNBh@cmpxchg.org> <CAJD7tkZ6VDnX3ACVS-iKCJfS4CrLdnZWzLD9T1-yqqDDhMrk_Q@mail.gmail.com>
 <Y2QmcdEJXB50TnQF@google.com> <CAJD7tkYFTQHn4vgNVt8k-aNsXE2Ahi82yprHU=nAZqRpLqQSNg@mail.gmail.com>
In-Reply-To: <CAJD7tkYFTQHn4vgNVt8k-aNsXE2Ahi82yprHU=nAZqRpLqQSNg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 3 Nov 2022 15:15:54 -0600
Message-ID: <CAOUHufafNVTEGd63bfVCiZ9NidJJ8RU7V0z5Fcqk56pseVQAvw@mail.gmail.com>
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
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

On Thu, Nov 3, 2022 at 2:47 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Thu, Nov 3, 2022 at 1:37 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Thu, Nov 03, 2022 at 11:10:47AM -0700, Yosry Ahmed wrote:
> > < snip >
> >
> > > > > > > I am also worry about that LRU stuff should be part of allocator
> > > > > > > instead of higher level.
> > > > > >
> > > > > > I'm sorry, but that's not a reasonable objection.
> > > > > >
> > > > > > These patches implement a core feature of being a zswap backend, using
> > > > > > standard LRU and locking techniques established by the other backends.
> > > > > >
> > > > > > I don't disagree that it would nicer if zswap had a strong abstraction
> > > > > > for backend pages and a generalized LRU. But that is major surgery on
> > > > > > a codebase of over 6,500 lines. It's not a reasonable ask to change
> > > > > > all that first before implementing a basic feature that's useful now.
> > > > >
> > > > > With same logic, folks added the LRU logic into their allocators
> > > > > without the effort considering moving the LRU into upper layer.
> > > > >
> > > > > And then trend is still going on since I have seen multiple times
> > > > > people are trying to add more allocators. So if it's not a reasonable
> > > > > ask to consier, we couldn't stop the trend in the end.
> > > >
> > > > So there is actually an ongoing effort to do that. Yosry and I have
> > > > spent quite some time on coming up with an LRU design that's
> > > > independent from compression policy over email and at Plumbers.
> > > >
> > > > My concern is more about the order of doing things:
> > > >
> > > > 1. The missing writeback support is a gaping hole in zsmalloc, which
> > > >    affects production systems. A generalized LRU list is a good idea,
> > > >    but it's a huge task that from a user pov really is not
> > > >    critical. Even from a kernel dev / maintainer POV, there are bigger
> > > >    fish to fry in the zswap code base and the backends than this.
> > > >
> > > > 2. Refactoring existing functionality is much easier than writing
> > > >    generalized code that simultaneously enables new behavior. zsmalloc
> > > >    is the most complex of our backends. To make its LRU writeback work
> > > >    we had to patch zswap's ->map ordering to accomodate it, e.g. Such
> > > >    tricky changes are easier to make and test incrementally.
> > > >
> > > >    The generalized LRU project will hugely benefit from already having
> > > >    a proven writeback implementation in zsmalloc, because then all the
> > > >    requirements in zswap and zsmalloc will be in black and white.
> > > >
> > > > > > I get that your main interest is zram, and so this feature isn't of
> > > > > > interest to you. But zram isn't the only user, nor is it the primary
> > > > >
> > > > > I am interest to the feature but my interest is more of general swap
> > > > > layer to manage the LRU so that it could support any hierarchy among
> > > > > swap devices, not only zswap.
> > > >
> > > > I think we're on the same page about the longer term goals.
> > > >
> > >
> > > Yeah. As Johannes said, I was also recently looking into this. This
> > > can also help solve other problems than consolidating implementations.
> > > Currently if zswap rejects a page, it goes into swap, which is
> > > more-or-less a violation of page LRUs since hotter pages that are more
> > > recently reclaimed end up in swap (slow), while colder pages that were
> > > reclaimed before are in zswap. Having a separate layer managing the
> > > LRU of swap pages can also make sure this doesn't happen.
> >
> > True.
> >
> > >
> > > More broadly, making zswap a separate layer from swap enables other
> > > improvements such as using zswap regardless of the presence of a
> > > backend swapfile and not consuming space in swapfiles if a page is in
> > > zswap. Of course, this is a much larger surgery.
> >
> > If we could decouple the LRU writeback from zswap and supports
> > compression without backing swapfile, sounds like becoming more of
> > zram. ;-)
>
> That's a little bit grey. Maybe we can consolidate them one day :)
>
> We have been using zswap without swapfile at Google for a while

We do require swapfiles for zswap -- they can be truncated.

> this
> gives us the ability to reject pages that do not compress well enough
> for us, which I suspect zram would not support given that it is
> designed to be the final destination of the page. Also, having the
> same configuration and code running on machines whether or not they
> have a swapfile is nice, otherwise one would need to use zram if there
> is no swapfile and switch to zswap if there is one.
>
> >
> > >
> > > I am intending to spend more time looking further into this, but other
> > > things keep popping up :)
> >
> > Same with me. Thanks for looking it, Yosry!
>
