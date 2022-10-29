Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A66124D2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 20:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ2SFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2SFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 14:05:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339965972D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:05:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso12583333pjg.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnIesWyzgkP1beLu0wv1uoWqrkOzbsPNcoQRzCjbCb4=;
        b=aLnMTMbaObzfBmNbzgXJVZXOaL1AxngryjGDYj8RIA2BREsOX0sB3JPeo4JAhgVGnn
         1eIjcFmRichJlhHMqzWyLQKziGgfzEytwHjTx0q2pAhLTC3GnvAyKRX2fRFDyYyW/JaN
         4mcJJO8m+qbZsWFfrtHUhZnWk1JtvV0vQY8sX8tk9v4/q5pHWim2zII2cBT9Ltz+ZGWm
         u4o5s14bofcuceHOMb6pJ/lDJLBmSJd9nOvi4Oafrlqo7LUjw5AD6HRDEa0/eLLmPqWu
         Y7wuPDE+ZUBov6s/076Tb1FyolulkfhFqSth1jNF/TA0c3sDTfA0pD+QkAf/S90kS5ig
         axTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnIesWyzgkP1beLu0wv1uoWqrkOzbsPNcoQRzCjbCb4=;
        b=pMvS9bWOKwzeONHa7NNzFZcQFEk9KPtzUDFKj89XIavnBwlIkAk3lSQHI0XyY9Hbzk
         HW7TCjv87ucccIbY6N9ZusCpGqlh1wpPWVyXd/yTXxjxvYLNwXVL4IZx8zookVuJFSnX
         ge9i86IQOFJibtF9tmyoVzQXUwEgNws5R9KslgWCFJ+ABUrOqVVCDJlNdIz4IZwW2A/f
         A3pXwFN7/4UXk/jXXyDnV96gXmKJXrTxI3xCx55S47SJpQvfzK63JF/m5WJfLPQc2pnM
         OUoxF6qYt7HHuh2PAufZ7HxhnRrOoqWVKZWW3omU80RaYesNHNbQjVBMNofgn6/PR5TZ
         bjJg==
X-Gm-Message-State: ACrzQf3nA4/pPAQs8w6YYbfwjlCWSPMtLMvKYyFCTJO12WdGiwWMz7Oq
        UDLxPXRjQj4u/O0B40YGHgA=
X-Google-Smtp-Source: AMsMyM5lj4q3vK9rT7mEglcTCN/A6U/+zbMwkMB7cJNYfvLLypMP4BvWT7lIGHKabsSmDMcvs4+/vg==
X-Received: by 2002:a17:902:e74a:b0:186:a094:1d3 with SMTP id p10-20020a170902e74a00b00186a09401d3mr5374456plf.153.1667066714270;
        Sat, 29 Oct 2022 11:05:14 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id b7-20020a170903228700b0017f5ad327casm736401plh.103.2022.10.29.11.05.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2022 11:05:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
Date:   Sat, 29 Oct 2022 11:05:12 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
 <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
 <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
 <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 28, 2022, at 5:42 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> I think the proper fix (or at least _a_ proper fix) would be to
> actually carry the dirty bit along to the __tlb_remove_page() point,
> and actually treat it exactly the same way as the page pointer itself
> - set the page dirty after the TLB flush, the same way we can free the
> page after the TLB flush.
>=20
> We could easiy hide said dirty bit in the low bits of the
> "batch->pages[]" array or something like that. We'd just have to add
> the 'dirty' argument to __tlb_remove_page_size() and friends.

Thank you for your quick response. I was slow to respond due to a jet =
lag.

Anyhow, I am not sure whether the solution that you propose would work.
Please let me know if my understanding makes sense.

Let=E2=80=99s assume that we do not call set_page_dirty() before we =
remove the rmap
but only after we invalidate the page [*]. Let=E2=80=99s assume that
shrink_page_list() is called after the page=E2=80=99s rmap is removed =
and the page
is no longer mapped, but before set_page_dirty() was actually called.

In such a case, shrink_page_list() would consider the page clean, and =
would
indeed keep the page (since __remove_mapping() would find elevated page
refcount), which appears to give us a chance to mark the page as dirty
later.

However, IIUC, in this case shrink_page_list() might still call
filemap_release_folio() and release the buffers, so calling =
set_page_dirty()
afterwards - after the actual TLB invalidation took place - would fail.

> Your idea of "do the page_remove_rmap() late instead" would also work,
> but the reason I think just squirrelling away the dirty bit is the
> "proper" fix is that it would get rid of the whole need for
> 'force_flush' in this area entirely. So we'd not only fix that race
> you noticed, we'd actually do so and reduce the number of TLB flushes
> too.

I=E2=80=99m all for reducing the number of TLB flushes, and your =
solution does sound
better in general. I proposed something that I considered having the =
path of
least resistance (i.e., least chance of breaking something). I can do =
what
you propsosed, but I am not sure how to deal with the buffers being =
removed.

One more note: This issue, I think, also affects =
migrate_vma_collect_pmd().
Alistair recently addressed an issue there, but in my prior feedback to =
him
I missed this issue.


[*] Note that this would be for our scenario pretty much the same if we =
also
called set_page_dirty() before removing the rmap, but the page was =
cleaned
while the TLB invalidation has still not been performed.

