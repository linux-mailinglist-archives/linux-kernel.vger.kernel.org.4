Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661BE663E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbjAJKpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjAJKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:45:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B45BA21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TjVHre6LdoOndqEHjLrK+qihKkTdcFZKI6AZWZ34mR0=; b=k3tQygqvCUDVb84gJ2I/HrprVN
        GtRPlitqskloTVHL5lN97qTdP97uLBJNUmfJboWY2Ag5HEeOrL7x/5CGKTLavMSNMjc8VcCOMjXWV
        kk8aCyzoYLMfBZvUwFKBh1LewDPDKRmzVyRFSKAFMD+dcQ82IbsyYxNQcuodQydenSEnNR6YJNtdj
        rTMCas91d83njpKrYB+wYmDBi1dCby+Fz6EpgmZOPF1y/MXEW/0wgSC+aDoNOee75lGfA1sdUhznb
        yneM8SbXQqQJ+WFw034bEw23F+E519M900fJmKsMV9OztgV5H/iTiUZeDAuCOSgy5Nk1hKwq4ITyB
        fv7wFctQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFC7u-0038SO-9d; Tue, 10 Jan 2023 10:45:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1D19300327;
        Tue, 10 Jan 2023 11:44:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9293B201ABB61; Tue, 10 Jan 2023 11:44:51 +0100 (CET)
Date:   Tue, 10 Jan 2023 11:44:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <kees@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dalias@libc.org
Subject: Re: Linux 6.2-rc3
Message-ID: <Y71Bo3yKcLJhe/om@hirez.programming.kicks-ass.net>
References: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
 <20230109174742.GA1191249@roeck-us.net>
 <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 04:18:02PM -0600, Linus Torvalds wrote:

> > In file included from <command-line>:
> > In function 'follow_pmd_mask',
> >     inlined from 'follow_pud_mask' at mm/gup.c:735:9,
> >     inlined from 'follow_p4d_mask' at mm/gup.c:752:9,
> >     inlined from 'follow_page_mask' at mm/gup.c:809:9:
> > include/linux/compiler_types.h:358:45: error: call to '__compiletime_assert_263' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
> >   358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >
> > Bisect points to commit 0862ff059c9e ("sh/mm: Make pmd_t similar to pte_t").
> > This commit introduces
> >
> > -typedef struct { unsigned long long pmd; } pmd_t;
> > +typedef struct {
> > +       struct {
> > +               unsigned long pmd_low;
> > +               unsigned long pmd_high;
> > +       };
> > +       unsigned long long pmd;
> > +} pmd_t;
> >
> > That should probably be "typedef union", not "typedef struct".
> 
> Ok, PeterZ has been off due to the holidays, but seems back. I agree,

Yup, nearly 2 weeks of no email what so ever.. glorious!

> that outer 'struct' should obviously be 'union', but let's make the
> guilty party (ie Peter) fix it up.

Urgh.. yes. How did the robots not yell at me before.

So the original patch came in through x86/mm, but this is very much a SH
only fix how do we route this? Linus you want to take this directly or
Rich do you have an urgent queue for the next -rc somewhere?

---
Subject: sh/mm: Fix pmd_t for real

Because typing is hard...

Fixes: 0862ff059c9e ("sh/mm: Make pmd_t similar to pte_t")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index a889a3a938ba..d1ce73f3bd85 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -28,7 +28,7 @@
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
 
-typedef struct {
+typedef union {
 	struct {
 		unsigned long pmd_low;
 		unsigned long pmd_high;
