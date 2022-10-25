Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B971360CD96
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiJYNeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiJYNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:34:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC9191886
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/0LrqpBKoT14DLc9iF9kREM8XNEtSFkQdKsz+ozJdig=; b=EplYQi+2FgRyy0nKXiWzha1VVW
        h6QzijZ/jUs57waHQY33Dsvn+kKDJxKDyKJs/6kaDtoBfnwR+M+QIq7gjyzIyWrLSdPKyTtICxAO0
        JLraK5zEuXwVhgmoXt5SYLsPlceM2WnSy1vKvITeZGo/kGYkJqNvuLP49m1UpWIrq39Ghm/lEetFX
        XhuJ8Nv4ncszPCvUPalhXcKygzRcQvJth3QPXjvhPMw0EU9SGSEUZvDA9XAUhI444x0c2vT6H5eFR
        AZLVZlL4tMOgUc3s8E/Xu1zlP6sKRZ4t83EVE8WoyGHT9kDcBJv0/34l0LKztZp9aK91lODkZfbhM
        icqb7BVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onK4B-00GIRC-Rm; Tue, 25 Oct 2022 13:34:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74F313000DD;
        Tue, 25 Oct 2022 15:33:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 502E22C22E2E2; Tue, 25 Oct 2022 15:33:58 +0200 (CEST)
Date:   Tue, 25 Oct 2022 15:33:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Message-ID: <Y1flxpxFAadLSiBY@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <CAHk-=wjoGnHVVp5pcb69C6HtnJ_avqQo_b5NK-X9bgoDDw_XbA@mail.gmail.com>
 <CAG48ez3KMuM2aLpc8SvGiqZvv1KFc7E2DBZ4CLzxQeFhrMN_-w@mail.gmail.com>
 <Y1dWQ+YQyiz3V9Sp@casper.infradead.org>
 <87fsfcuxu6.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsfcuxu6.fsf@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 06:54:10PM +1100, Alistair Popple wrote:

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
> 
> I'm probably missing something obvious but how is that synchronised
> against memory hotplug? AFAICT if it isn't couldn't the pages be freed
> and memory removed? In that case the above would no longer hold because
> (I think) the metadata structure could have been freed.

Note, this scheme is older than memory hot-plug, so if anybody is to
blame it's the memory hotplug code.

Anyway, since all that is done with IRQs disabled, all the hotplug stuff
needs to do is rcu_synchronize() in order to ensure all active
IRQ-disabled regions are finshed (between ensuring the memory is unused
and taking out the struct page).
