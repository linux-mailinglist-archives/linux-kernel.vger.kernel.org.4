Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158E260BD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiJXWLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiJXWLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:11:17 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A580E303793
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:26:32 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p16so8714386iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWJJT1TbetrgXh8LaP+V41BI35KOobAqjN/1cjCvQ6Y=;
        b=YqtVmCFnXy6dVSw/gZfv/XbLi1AIW2GKTCvb0aBrPsCszaiErxFfVsDGxdOF1bgy+D
         MOf07/TYO0NBs311k+m+HssmaFH6E2bv8x4PxdOeH+gxsqbtcod7RbNHo2LJq0gmvlUN
         jZuS8vEM04KA6DBXMz5E+0WsSaW/l3bR80kflo63ssw79la9+tRI4sD0SFXMJjcCYLsF
         AcsElQvWcYP1NHV9rnCjBB+h0rhvN8lCxHybkwBd9KE7KH7AQiUGefPMYcuZxHy2vs7l
         5uxFGEO/+eI6YOLkVNHb7FnQqgLrI3WUuCHYQqUuVKf6H98+KUJaGeKYcR5iGjGnw6zh
         GM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWJJT1TbetrgXh8LaP+V41BI35KOobAqjN/1cjCvQ6Y=;
        b=qjKV/KCp9HUowYjMIa//9afjJrxzbSblPTkul7TQdcmeBb3k/JTfalTfUoNuU98v8R
         hkc2F3sVf1SrxE/Quo+KHISPtELYbUmOLVw8MVk5ZhoNxWg9Z3bCeZjhC1l3YVXZY+q3
         pvmZP/+2qs7IjjAsJ2ELepr7BU+GD7mO1L/40D//J3BnbegApJWbnm+g6k6wSvkW3k2w
         JhooyV6+B/QeLfepVKHjEEgvP7qwMmFVffVl32y7zF9AdzTac4hDn01dmMXx+HNSU3Jq
         7Sw70Gk0vwA2tcoh/8lJpD+85CyYN4TCFcQanvuQETvSVCN74ACxzrhtxfRRwV3egbve
         cNyA==
X-Gm-Message-State: ACrzQf2CBe4PFdD1qVCgC4Jwd2a96aF2q1RtzwXW1bXnPPij0LZiYLCK
        pWfX/5Qlsd0WKjsb6cApbFpo84O+kY3VMhs4vAt5Gg==
X-Google-Smtp-Source: AMsMyM4L7sglsDXubAy5K92w/Pv13hQCsq4zboaNJTdLpeihlBxYzSeBnty51VtSL1fY4Bh7wbvtUzVRETPgSXEBD48=
X-Received: by 2002:a05:6638:ce:b0:373:fccb:63e3 with SMTP id
 w14-20020a05663800ce00b00373fccb63e3mr3960966jao.66.1666643067486; Mon, 24
 Oct 2022 13:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com> <CAHk-=wjoGnHVVp5pcb69C6HtnJ_avqQo_b5NK-X9bgoDDw_XbA@mail.gmail.com>
In-Reply-To: <CAHk-=wjoGnHVVp5pcb69C6HtnJ_avqQo_b5NK-X9bgoDDw_XbA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 24 Oct 2022 22:23:51 +0200
Message-ID: <CAG48ez3KMuM2aLpc8SvGiqZvv1KFc7E2DBZ4CLzxQeFhrMN_-w@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
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

On Mon, Oct 24, 2022 at 10:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Oct 24, 2022 at 12:58 PM Jann Horn <jannh@google.com> wrote:
> >
> > Unless I'm completely misunderstanding what's going on here, the whole
> > "remove_table" thing only happens when you "remove a table", meaning
> > you free an entire *pagetable*. Just zapping PTEs doesn't trigger that
> > logic.
>
> I do have to admit that I'd be happier if this code - and the GUP code
> that also relies on "interrupts off" behavior - would just use a
> sequence counter instead.
>
> Relying on blocking IPI's is clever, but also clearly very subtle and
> somewhat dangerous.
>
> I think our GUP code is a *lot* more important than some "legacy
> x86-32 has problems in case you have an incredibly unlikely race that
> re-populates the page table with a different page that just happens to
> be exactly the same MOD-4GB", so honestly, I don't think the
> load-tearing is even worth worrying about - if you have hardware that
> is good enough at virtualizing things, it's almost certainly already
> 64-bit, and running 32-bit virtual machines with PAE you really only
> have yourself to blame.
>
> So I can't find it in myself to care about the 32-bit tearing thing,
> but this discussion makes me worried about Fast GUP.
>
> Note that even with proper atomic
>
>                 pte_t pte = ptep_get_lockless(ptep);
>
> in gup_pte_range(), and even if the page tables are RCU-free'd, that
> just means that the 'ptep' access itself is safe.
>
> But then you have the whole "the lookup of the page pointer is not
> atomic" wrt that. And right now that GUP code does rely on the "block
> IPI" to make it basically valid.
>
> I don't think it matters if GUP races with munmap or madvise() or
> something like that - if you get the old page, that's still a valid
> page, and the user only has himself to blame.
>
> But if we have memory pressure that causes vmscan to push out a page,
> and it gets replaced with a new page, and GUP gets the old page with
> no serialization, that sounds like a possible source of data
> inconsistency.
>
> I don't know if this can happen, but the whole "interrupts disabled
> doesn't actually block IPI's and synchronize with TLB flushes" really
> sounds like it would affect GUP too. And be much more serious there
> than on some x86-32 platform that nobody should be using anyway.

That's why GUP-fast re-checks the PTE after it has grabbed a reference
to the page. Pasting from a longer writeup that I plan to publish
soon, describing how gup_pte_range() works:

"""
This guarantees that the page tables that are being walked
aren't freed concurrently, but at the end of the walk, we
have to grab a stable reference to the referenced page.
For this we use the grab-reference-and-revalidate trick
from above again: First we (locklessly) load the page
table entry, then we grab a reference to the page that it
points to (which can fail if the refcount is zero, in that
case we bail), then we recheck that the page table entry
is still the same, and if it changed in between, we drop the
page reference and bail.
This can, again, grab a reference to a page after it has
already been freed and reallocated. The reason why this is
fine is that the metadata structure that holds this refcount,
`struct folio` (or `struct page`, depending on which kernel
version you're looking at; in current kernels it's `folio`
but `struct page` and `struct folio` are actually aliases for
the same memory, basically, though that is supposed to maybe
change at some point) is never freed; even when a page is
freed and reallocated, the corresponding `struct folio`
stays. This does have the fun consequence that whenever a
page/folio has a non-zero refcount, the refcount can
spuriously go up and then back down for a little bit.
(Also it's technically not as simple as I just described it,
because the `struct page` that the PTE points to might be
a "tail page" of a `struct folio`.
So actually we first read the PTE, the PTE gives us the
`page*`, then from that we go to the `folio*`, then we
try to grab a reference to the `folio`, then if that worked
we check that the `page` still points to the same `folio`,
and then we recheck that the PTE is still the same.)
"""
