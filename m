Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955AD60CDCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiJYNpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJYNpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:45:13 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3E6147056
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:45:12 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id y80so10324051iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KgMDPhJWvWPx+5LJ/Qv7vJHmHiGIhKGLj7RjUESz09M=;
        b=WumVmYJxhniCTmZMefNCEm3UcPRsmZeEHJM8hqvVntpzvgyZGF/jvSU6opR0WzrC9W
         SMegd9e/PZJXVf5poNQdoYE2OTiOVdP8bdUnPOBLSMDR5AhNVe8FeON9n+FAgyMkQV+3
         IIm1RDfijAM52g9K3lWfNrRiYQbJZHEv6hqL9ct7vkYEUrDKjPt8CZm/l979ZaAbtZgZ
         UZvD0cDeYGgcnMddbdLSSuSh+gQe/L8xr+z/7bXLOO7k/DzPLGODC4V2f8paSK39lAKd
         aTKwBy6JpTxFmrEYDWJM1HXyrmhIX5iH6iGt5EuLBCYBQLEYS6nJrXjTRlEaVEgDDitM
         SgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgMDPhJWvWPx+5LJ/Qv7vJHmHiGIhKGLj7RjUESz09M=;
        b=akm1dkHMfMvEGma98KxPzf4nDGr+Xtz4RODB9i/wW0un3FKVMFWuaDFCSj4FC2xrB/
         BHXo+kZFSGpqSnbvEg4EtWYCFPSqMVh5y3FB7KQXICwlF1jr1wMKsJ0dYBba8x2c+SPe
         svtaK8I56dx/iCjb3/nd+cFQXdmYobLwAjXfnsRYD19XMfvEWM0nCr4qQ9w87NbSOma0
         71hV8fN9aRhpd21D6C/m3t54o4k1BGYv0YcgPq6oPCwgtIJWw+8KLDXHmZtlfXMwbudH
         LXpkzUonONFeNCyoY35neQy2ZSla6EL4sa+W9svTOV/vcwIVipRxwQlt3zTUrUblNHIO
         fkgA==
X-Gm-Message-State: ACrzQf3gsVUR27+320dmM0G3GqnOPuBh4rMa+WRmL2P7G8QZcQ7WUPHA
        RjXqO0a0sD+OtfiE1QxcPoMapTYvRbxHKcSoEmv5qw==
X-Google-Smtp-Source: AMsMyM7ZrmQax2xcIXLFfXG6apPiVAukou4+KudnV0Fh3BwBnAb15t7Vd9OEZdU+B06IcvnW44Plgur2XuRcFXBjdAc=
X-Received: by 2002:a05:6638:38a5:b0:363:f688:94dc with SMTP id
 b37-20020a05663838a500b00363f68894dcmr25269301jav.133.1666705511462; Tue, 25
 Oct 2022 06:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <CAHk-=wjoGnHVVp5pcb69C6HtnJ_avqQo_b5NK-X9bgoDDw_XbA@mail.gmail.com>
 <CAG48ez3KMuM2aLpc8SvGiqZvv1KFc7E2DBZ4CLzxQeFhrMN_-w@mail.gmail.com>
 <Y1dWQ+YQyiz3V9Sp@casper.infradead.org> <87fsfcuxu6.fsf@nvidia.com>
In-Reply-To: <87fsfcuxu6.fsf@nvidia.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 25 Oct 2022 15:44:34 +0200
Message-ID: <CAG48ez1Cw6cpjMW+Hq02nHTbW58qJ6TJY2CptMneRN5gmHGyiw@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
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

On Tue, Oct 25, 2022 at 10:11 AM Alistair Popple <apopple@nvidia.com> wrote:
>
>
> Matthew Wilcox <willy@infradead.org> writes:
>
> > On Mon, Oct 24, 2022 at 10:23:51PM +0200, Jann Horn wrote:
> >> """
> >> This guarantees that the page tables that are being walked
> >> aren't freed concurrently, but at the end of the walk, we
> >> have to grab a stable reference to the referenced page.
> >> For this we use the grab-reference-and-revalidate trick
> >> from above again:
> >> First we (locklessly) load the page
> >> table entry, then we grab a reference to the page that it
> >> points to (which can fail if the refcount is zero, in that
> >> case we bail), then we recheck that the page table entry
> >> is still the same, and if it changed in between, we drop the
> >> page reference and bail.
> >> This can, again, grab a reference to a page after it has
> >> already been freed and reallocated. The reason why this is
> >> fine is that the metadata structure that holds this refcount,
> >> `struct folio` (or `struct page`, depending on which kernel
> >> version you're looking at; in current kernels it's `folio`
> >> but `struct page` and `struct folio` are actually aliases for
> >> the same memory, basically, though that is supposed to maybe
> >> change at some point) is never freed; even when a page is
> >> freed and reallocated, the corresponding `struct folio`
> >> stays. This does have the fun consequence that whenever a
> >> page/folio has a non-zero refcount, the refcount can
> >> spuriously go up and then back down for a little bit.
> >> (Also it's technically not as simple as I just described it,
> >> because the `struct page` that the PTE points to might be
> >> a "tail page" of a `struct folio`.
> >> So actually we first read the PTE, the PTE gives us the
> >> `page*`, then from that we go to the `folio*`, then we
> >> try to grab a reference to the `folio`, then if that worked
> >> we check that the `page` still points to the same `folio`,
> >> and then we recheck that the PTE is still the same.)
> >> """
> >
> > Nngh.  In trying to make this description fit all kernels (with
> > both pages and folios), you've complicated it maximally.  Let's
> > try a more simple explanation:
> >
> > First we (locklessly) load the page table entry, then we grab a
> > reference to the folio that contains it (which can fail if the
> > refcount is zero, in that case we bail), then we recheck that the
> > page table entry is still the same, and if it changed in between,
> > we drop the folio reference and bail.
> > This can, again, grab a reference to a folio after it has
> > already been freed and reallocated. The reason why this is
> > fine is that the metadata structure that holds this refcount,
> > `struct folio` is never freed; even when a folio is
> > freed and reallocated, the corresponding `struct folio`
> > stays.

Oh, thanks. You're right, trying to talk about kernels with folios
made it unnecessarily complicated...

> I'm probably missing something obvious but how is that synchronised
> against memory hotplug? AFAICT if it isn't couldn't the pages be freed
> and memory removed? In that case the above would no longer hold because
> (I think) the metadata structure could have been freed.

Hm... that's this codepath?

arch_remove_memory -> __remove_pages -> __remove_section ->
sparse_remove_section -> section_deactivate ->
depopulate_section_memmap -> vmemmap_free -> remove_pagetable

which then walks down the page tables and ends up freeing individual
pages in remove_pte_table() using the confusingly-named
free_pagetable()?

I'm not sure what the synchronization against hotplug is - GUP-fast is
running with IRQs disabled, but other codepaths might not, like
get_ksm_page()? I don't know if that's holding something else for protection...
