Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5DE686597
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjBALwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjBALwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:52:31 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BFA61D63
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:52:23 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id k6so19400007vsk.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 03:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CGX+681ImZAUmW/DwliVbohDwG+nNs9QfeFZlVbxCEk=;
        b=W8qEklfTrWX96TewMwl8GC/2u13qs1I9jTtak2GycjcA4JDJa6RlNrVneZc5nGQhrv
         ZsYNeIFJYjok6EmDFcHCSNgwGcP+GAC5GX87CVCGL3VFHJ0m+lr5LSBGkjdRI8ZckvPa
         f+OiPxWobmYw9mOwC8JuqpR/kLjO6zNgir0iwLWM6zb4mpYQpgAwtbkywDewlKC56Xc7
         YZrv34UFIZSv+YKlkUcApCvpXaZ8rwLQzJc3UWXggj6rasGeTbrSzpY6zlEFzuJKs0Mb
         LZHj20J5JZYOZ2QfoOHlHKPkpYN6Xl4Hj3YQXCVj8s0ugi+Oe2rDCKZgh4cusYCNjMus
         YY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGX+681ImZAUmW/DwliVbohDwG+nNs9QfeFZlVbxCEk=;
        b=7fN2fCONs7LSQ+BaL48OUDWVoHoySnc6Qlw3PeVOrnWvSVXBeyntDfNPgJDj8IAs8Y
         nsJZMdIyUy1JbvqFww+BixsFDEI4y0ruPlko0CqD+//+P8shH28UIefEMwSqs1R2xx14
         ybNTzFe6gWmuRYlVGMugXEN0mBi+Fvg4EleFtrn3qd7vEoUdX1A2dsaLLpq0VVlmU5vg
         JtgzgL8ttHN1/06JXSKC4oh3bRd9vGyRc/QGTmMzh9XbLi1B+UHQKcbXvl9iSjlmR5uJ
         tXRN52N6uWT+YYNN2vs/5y416/wlp/ZeuEwWikLu7JYyHf3c4zH8QoAId7k5azIq5Tz0
         qDxA==
X-Gm-Message-State: AO0yUKUXo8wuoV8kUTZ91otD82p2/SReFgb8DBDmDP1ssdRmMaliUXN7
        mRo/0JxLOW+vy4bmVBw7L3KiHxaOPach7rDsOoaQzg==
X-Google-Smtp-Source: AK7set864i65WxHv4OQgPJLlENsVtavNpE3DblYHjn+EfSI2ght8LjtN9yiVHEHXrJMLlpI8YG+AZ8pMfPGzKQ+k478=
X-Received: by 2002:a67:fa01:0:b0:3d0:a896:51da with SMTP id
 i1-20020a67fa01000000b003d0a89651damr382789vsq.44.1675252341983; Wed, 01 Feb
 2023 03:52:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <9fbb4d2bf9b2676a29b120980b5ffbda8e2304ee.1675111415.git.andreyknvl@google.com>
 <CAG_fn=VO0iO4+EuwDR0bKP-4om9_Afir3fY6CExKGRNad+uPLA@mail.gmail.com> <CA+fCnZfjbHaS9So6gO_3ZkgLazJXYAtw-PNV5C0xhAjzVE3p-Q@mail.gmail.com>
In-Reply-To: <CA+fCnZfjbHaS9So6gO_3ZkgLazJXYAtw-PNV5C0xhAjzVE3p-Q@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 1 Feb 2023 12:51:45 +0100
Message-ID: <CAG_fn=U-r7Pb8356Uio69zmy5FDQp6nCs6eM2TXcnXaaR4_hMQ@mail.gmail.com>
Subject: Re: [PATCH 01/18] lib/stackdepot: fix setting next_slab_inited in init_stack_slab
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Jan 31, 2023 at 8:00 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Tue, Jan 31, 2023 at 10:30 AM Alexander Potapenko <glider@google.com> wrote:
> >
> > Wait, I think there's a problem here.
> >
> > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > index 79e894cf8406..0eed9bbcf23e 100644
> > > --- a/lib/stackdepot.c
> > > +++ b/lib/stackdepot.c
> > > @@ -105,12 +105,13 @@ static bool init_stack_slab(void **prealloc)
> > >                 if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) {
> > If we get to this branch, but the condition is false, this means that:
> >  - next_slab_inited == 0
> >  - depot_index == STACK_ALLOC_MAX_SLABS+1
> >  - stack_slabs[depot_index] != NULL.
> >
> > So stack_slabs[] is at full capacity, but upon leaving
> > init_stack_slab() we'll always keep next_slab_inited==0.
> >
> > Now every time __stack_depot_save() is called for a known stack trace,
> > it will preallocate 1<<STACK_ALLOC_ORDER pages (because
> > next_slab_inited==0), then find the stack trace id in the hash, then
> > pass the preallocated pages to init_stack_slab(), which will not
> > change the value of next_slab_inited.
> > Then the preallocated pages will be freed, and next time
> > __stack_depot_save() is called they'll be allocated again.
>
> Ah, right, missed that.
>
> What do you think about renaming next_slab_inited to
> next_slab_required and inverting the used values (0/1 -> 1/0)? This
> would make this part of code less confusing.

"Required" as in "requires a preallocated buffer, but does not have one yet"?
Yes, that's probably better.
(In any case we'll need to add a comment to that variable explaining
the circumstances under which one or another value is possible).
