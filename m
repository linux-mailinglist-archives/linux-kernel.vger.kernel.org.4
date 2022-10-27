Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7FF6101BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiJ0Tfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ0Tfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:35:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C0731216
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9oJTJnyopwqJiGG3+HjHBUrRsMJkOVWsIsyY4HzDMIQ=; b=B/SFOQ/HTgB4tzepuLj9syllXK
        nzbunSooLRSQV84MEW8hz+xJC6vSrMssCwsUvuKzUdgGatr2WM+vWDCjAfhQ5U5d0uAju0znz5wpO
        RY+LRYkwgptnRaX0eI0GhAsg72vayQoU3gD4QMr19tsYSyM/T8/lzCIKdXQ+65XMl40ysmdpCZ3y2
        NPGkdkTDmD9/hM5M9F6nNhP66uRJcUMhafu7+0Rhd8hf3e1ngIwDxNun8Bu1rLEWzOBmyICZAP1y9
        MzSd4mukxVaK5Z9wS/kbhY5L4tHU9iSHv8foYbjhMDlbxxgl3kXLeshicGHUZEeBiCRnSACzyIRRg
        psA1syrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oo8f0-000XMl-MG; Thu, 27 Oct 2022 19:35:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05B2530017F;
        Thu, 27 Oct 2022 21:35:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB64F2C65BF63; Thu, 27 Oct 2022 21:35:20 +0200 (CEST)
Date:   Thu, 27 Oct 2022 21:35:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>,
        x86@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Message-ID: <Y1rdeFdYSBXOvTXz@hirez.programming.kicks-ass.net>
References: <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
 <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just two quick remarks; it's far to late to really think :-)

On Thu, Oct 27, 2022 at 11:13:55AM -0700, Linus Torvalds wrote:

> But "fullmm" is probably even stronger than "mmap write-lock" in that
> it should also mean "no other CPU can be actively using this" - either
> for hardware page table walking, or for GUP.

IIRC fullmm is really: this is the last user and we're taking the whole
mm down -- IOW exit().

> For example, MADV_DONTNEED does this all with just the mmap lock held
> for reading, so we *unless* we have that 'force_flush', we can
> 
>  (a) have another CPU continue to use the old stale TLB entry for quite a while
> 
>  (b) yet another CPU (that didn't have a TLB entry, or wanted to write
> to a read-only one ) could take a page fault, and install a *new* PTE
> entry in the same slot, all at the same time.
> 
> Now, that's clearly *very* confusing. But being confusing may not mean
> "wrong" - we're still delaying the free of the old entry, so there's
> no use-after-free.

Do we worry about CPU errata where things go side-ways if multiple CPUs
have inconsistent TLB state?
