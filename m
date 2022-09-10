Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216CC5B4A9D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIJWf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiIJWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:35:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C474507B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:33:15 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h21so3826225qta.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rkBnb2K/p/J8hLmaT99r7CzCPZNFhjTvaKUvRHmeOhU=;
        b=i5yv2hh6Fa+6IoYmAkb8iQ4y7spBmLCby+cfpYHSZ95RM0n25zR3hbcu1XNCFCHKGs
         voOQS5W4q25ZULvtDeBuxOdfKA3YFo5iQPQPMP25D+/qDhrh/UxGeVUfKxuOgzZ5WtYb
         BI1qjjzMe5/y6pV8/2QvKSe0E6fqQfLNK1RzE9AJWxUsnIesSnmh5NrH6sJQpIXzlY/R
         gMVTIVpOCRhnI8sSGaN0C1WilTWpacfeGXxIPUhbxUDqJzKqWPlPUSfUoqxc/cxpyIDF
         tbHsWL1g6BuuETXBOo68pEXGwlWLr0s0k/VGgZybINwMWpcVa4+nTEhs/m9b0CBh2ZSP
         p9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rkBnb2K/p/J8hLmaT99r7CzCPZNFhjTvaKUvRHmeOhU=;
        b=0FUJTb3MevEv9YhgmH8cu2hnP4Z1xOr28RIcDXfk9ZRzkllosbGsoISlfNdtN7ft1u
         WNbqu3NPQpsh+bbxmH5cMoMqtXukvQHhZyRfxXClDcG/jeY2GLDUj+qskhMrFKxP9Q3N
         k/eJn9czE5rNYRhSg1MGHBlDxyWUw2OPm+DFiUGiM91NgFGzyHxze50qkNtR/6WGOTXY
         zvYn9hszPEYfjafrMeE1MBfZg2PFdYKVsWnpRzqLFzxb8iBibNrfmpXuh4/pYoIUQ7LA
         e3Uf94zd+KHcpVAV9XRQ2QaR0I2XSNj/0W6MmQjIzRZZiz6R6dB/R5opw+c96XzkZwls
         zFCQ==
X-Gm-Message-State: ACgBeo2XZyYBcHyTQoodFez56theGgQ5KCzq2nh5CsyBEzzv84QvKoaE
        Ch82ZJyACveb3U6A/cI4/j2PH7BJ6E00o8S7GVM=
X-Google-Smtp-Source: AA6agR5eevjcxDiCy+zzWvZj0jIteNlsUHkvQd/bGmyXqLn5cv4oqgVEwYP+KRrK85MA54RklmDHxAXGRBo4blZzE2g=
X-Received: by 2002:a05:622a:11cf:b0:35b:a369:cc3 with SMTP id
 n15-20020a05622a11cf00b0035ba3690cc3mr7027882qtk.11.1662849194344; Sat, 10
 Sep 2022 15:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220905031012.4450-1-osalvador@suse.de> <20220905031012.4450-2-osalvador@suse.de>
 <CA+fCnZcNr2JeCkTF=uCxjPCJKFi_d1chv0tjubvMisUdQtCeRw@mail.gmail.com> <YxbEi7A3e+y5qNwY@localhost.localdomain>
In-Reply-To: <YxbEi7A3e+y5qNwY@localhost.localdomain>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 11 Sep 2022 00:33:03 +0200
Message-ID: <CA+fCnZcxDoUVewkv8PeSybXYy2Qf3wv7tOtvXBmJiF0rAvyPtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] lib/stackdepot: Add a refcount field in stack_record
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 5:54 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Sep 05, 2022 at 10:57:20PM +0200, Andrey Konovalov wrote:
> > On Mon, Sep 5, 2022 at 5:10 AM Oscar Salvador <osalvador@suse.de> wrote:
> > > +enum stack_depot_action {
> > > +       STACK_DEPOT_ACTION_NONE,
> > > +       STACK_DEPOT_ACTION_COUNT,
> > > +};
> >
> > Hi Oscar,
>
> Hi Andrey
>
> > Why do we need these actions? Why not just increment the refcount on
> > each stack trace save?
>
> Let me try to explain it.
>
> Back in RFC, there were no actions and the refcount
> was incremented/decremented in __set_page_ownwer()
> and __reset_page_owner() functions.
>
> This lead to a performance "problem", where you would
> look for the stack twice, one when save it
> and one when increment it.

I don't get this. If you increment the refcount at the same moment
when you save a stack trace, why do you need to do the lookup twice?

> We figured we could do better and, at least, for the __set_page_owner()
> we could look just once for the stacktrace when calling __stack_depot_save,
> and increment it directly there.

Exactly.

> We cannot do that for __reset_page_owner(), because the stack we are
> saving is the freeing stacktrace, and we are not interested in that.
> That is why __reset_page_owner() does:
>
>  <---
>  depot_stack_handle_t alloc_handle;
>
>  ...
>  alloc_handle = page_owner->handle;
>  handle = save_stack(GFP_NOWAIT | __GFP_NOWARN, STACK_DEPOT_ACTION_NONE);
>  page_owner->free_handle = handle
>  stack_depot_dec_count(alloc_handle);
>  --->
>
> alloc_handle contains the handle for the allocation stacktrace, which was set
> in __set_page_owner(), and page_owner->free handle contains the handle for the
> freeing stacktrace.
> But we are only interested in the allocation stack and we only want to increment/decrement
> that on allocation/free.

But what is the problem with incrementing the refcount for free
stacktrace in __reset_page_owner? You save the stack there anyway.

Or is this because you don't want to see free stack traces when
filtering for bigger refcounts? I would argue that this is not a thing
stack depot should care about. If there's a refcount, it should
reflect the true number of references.

Perhaps, what you need is some kind of per-stack trace user metadata.
And the details of what format this metadata takes shouldn't be
present in the stack depot code.

> > Could you split out the stack depot and the page_owner changes into
> > separate patches?
>
> I could, I am not sure if it would make the review any easier though,
> as you could not match stackdepot <-> page_owner changes.
>
> And we should be adding a bunch of code that would not be used till later on.
> But I can try it out if there is a strong opinion.

Yes, splitting would be quite useful. It allows backporting stack
depot changes without having to backport any page_owner code. As long
as there are not breaking interface changes, of course.

Thanks!
