Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113226031EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJRSB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJRSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:01:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2A61147;
        Tue, 18 Oct 2022 11:01:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so16750712pjq.4;
        Tue, 18 Oct 2022 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kbVWeBLmoXaL5wT4FGVpRcLjWyd0m50VYE8PAOnnEko=;
        b=a0iG9+gDGzV0/uFEh+xecDTUMLAjs0avyQ2SwEVTlqQ0OWuxIWVvI7+VGzewqEagT7
         5N1mcJO41KbKS7i/17ZW9QV3RoHCd4fgRihwlp6D5/+M0mqFYNoJYrou3tjrqrlTJ8dz
         XbKOlmlgCSm7t4iqfFRIJOMlef9tuCJ85wiUwPbLRtSwyRA1hArJi9oGz7TdQwhuEumS
         xDaJQz404PU7P6NsWFLsZENDAml1aJHAJ3OBdTrq6GH4hjxTkfT6Qmn14UOcrFVPZstD
         4oqbVikV/Ib0yqaGyN6ev3o2wWLK/uUDQCFdWKkr6BcCUVKSR7lOgRAYhE4EsX7u7G0i
         93qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbVWeBLmoXaL5wT4FGVpRcLjWyd0m50VYE8PAOnnEko=;
        b=jKMmG5SrEkiTJQMxBJyt6TocG9csYlZaDf1pGLMVcGkN26fVYXgzg6YYPR5+/JtDBk
         uAiLUABbZElx8UTI+51oUPMha66toqE4yP2RHZ1aATmObpMekhYDOf0E2mPG89a3OqH7
         qJIYfVW7luFimjWIUgQfCHfFy3IJzD11oO1YZbEdurRN/+pZJIh1Q9IDmqaPtb5GNSkE
         5y0LZ+JsqrirgpyqGl7LEUnQZ+3LPh1Jk8w+6EwPAmJYF1hWoi7AU4dYzdnLZ5DVKht+
         pQO6TromTBLQalyuE2j+C+lTsX/iS2LiR09zB2V8WKl+/T25DNcoqS9GOFbuu4YA+JAf
         qfsw==
X-Gm-Message-State: ACrzQf08iiew1kLNqo5RotvAEJSCq5crV4WIp1nWXGSOt0UeLFH7Zozg
        moWryXEgdIOkcKdRBtOQ5lyAz1hVquGHfXIvt9I=
X-Google-Smtp-Source: AMsMyM4dRCMlLxwxpvWPKeEBQqgqTpkBvzI2y4UmcFNFY7lhRcumit+v8Ysop8DlhVkW1Pg4yIXBLJ/OEQVZxMId9tQ=
X-Received: by 2002:a17:902:d512:b0:181:f1f4:fcb4 with SMTP id
 b18-20020a170902d51200b00181f1f4fcb4mr4248525plg.102.1666116103439; Tue, 18
 Oct 2022 11:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221005180341.1738796-1-shy828301@gmail.com> <20221005180341.1738796-3-shy828301@gmail.com>
 <20221013123830.opbulq4qad56kuev@techsingularity.net> <CAHbLzkpc+CAfsYe6gXjh=-3MxMH_aWhPMYhic7ddFZgWttOhng@mail.gmail.com>
 <20221017094132.vnanndrwa2yn7qcw@techsingularity.net>
In-Reply-To: <20221017094132.vnanndrwa2yn7qcw@techsingularity.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 18 Oct 2022 11:01:31 -0700
Message-ID: <CAHbLzkpmbmtOdOsud-VG+wyk18wFAFnan8T55XxxwkHrnhLCmw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: mempool: introduce page bulk allocator
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 2:41 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Oct 13, 2022 at 01:16:31PM -0700, Yang Shi wrote:
> > On Thu, Oct 13, 2022 at 5:38 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Wed, Oct 05, 2022 at 11:03:39AM -0700, Yang Shi wrote:
> > > > Since v5.13 the page bulk allocator was introduced to allocate order-0
> > > > pages in bulk.  There are a few mempool allocator callers which does
> > > > order-0 page allocation in a loop, for example, dm-crypt, f2fs compress,
> > > > etc.  A mempool page bulk allocator seems useful.  So introduce the
> > > > mempool page bulk allocator.
> > > >
> > > > It introduces the below APIs:
> > > >   - mempool_init_pages_bulk()
> > > >   - mempool_create_pages_bulk()
> > > > They initialize the mempool for page bulk allocator.  The pool is filled
> > > > by alloc_page() in a loop.
> > > >
> > > >   - mempool_alloc_pages_bulk_list()
> > > >   - mempool_alloc_pages_bulk_array()
> > > > They do bulk allocation from mempool.
> > > > They do the below conceptually:
> > > >   1. Call bulk page allocator
> > > >   2. If the allocation is fulfilled then return otherwise try to
> > > >      allocate the remaining pages from the mempool
> > > >   3. If it is fulfilled then return otherwise retry from #1 with sleepable
> > > >      gfp
> > > >   4. If it is still failed, sleep for a while to wait for the mempool is
> > > >      refilled, then retry from #1
> > > > The populated pages will stay on the list or array until the callers
> > > > consume them or free them.
> > > > Since mempool allocator is guaranteed to success in the sleepable context,
> > > > so the two APIs return true for success or false for fail.  It is the
> > > > caller's responsibility to handle failure case (partial allocation), just
> > > > like the page bulk allocator.
> > > >
> > > > The mempool typically is an object agnostic allocator, but bulk allocation
> > > > is only supported by pages, so the mempool bulk allocator is for page
> > > > allocation only as well.
> > > >
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > >
> > > Overall, I think it's an ok approach and certainly a good use case for
> > > the bulk allocator.
> > >
> > > The main concern that I have is that the dm-crypt use case doesn't really
> > > want to use lists as such and it's just a means for collecting pages to pass
> > > to bio_add_page(). bio_add_page() is working with arrays but you cannot
> > > use that array directly as any change to how that array is populated will
> > > then explode. Unfortunately, what you have is adding pages to a list to
> > > take them off the list and put them in an array and that is inefficient.
> >
> > Yeah, I didn't think of a better way to pass the pages to dm-crypt.
> >
> > >
> > > How about this
> > >
> > > 1. Add a callback to __alloc_pages_bulk() that takes a page as a
> > >    parameter like bulk_add_page() or whatever.
> > >
> > > 2. For page_list == NULL && page_array == NULL, the callback is used
> > >
> > > 3. Add alloc_pages_bulk_cb() that passes in the name of a callback
> > >    function
> > >
> > > 4. In the dm-crypt case, use the callback to pass the page to bio_add_page
> > >    for the new page allocated.
> >
> > Thank you so much for the suggestion. But I have a hard time
> > understanding how these work together. Do you mean call bio_add_page()
> > in the callback? But bio_add_page() needs other parameters. Or I
> > misunderstood you?
> >
>
> I expected dm-crypt to define the callback. Using bio_add_page
> directly would not work as the bulk allocator has no idea what to pass
> bio_add_page. dm-crypt would likely need to create both a callback and an
> opaque data structure passed as (void *) to track "clone" and "len"

I see. Yeah, we have to pass the "clone" and "len" to the callback via
pool_data. It should not be hard since dm-crypt already uses
crypt_config to maintain a counter for allocated pages, we should just
need to pass the struct to the callback as a parameter.

But I'm wondering whether this is worth it or not? Will it make the
code harder to follow?

>
> --
> Mel Gorman
> SUSE Labs
