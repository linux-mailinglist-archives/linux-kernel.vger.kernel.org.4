Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B835BD995
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiITBoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiITBnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:43:39 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955E85073C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:43:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id m81so1914363oia.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=74d7oXrgzFnbsbNRa8Cu3QvRmG8E5YtnNRFaXJLincQ=;
        b=GLRly3LCDQPKWSrm7OfBuU5KtOm2/mMqvwnve4eqv0J5hU5tDiJOd76QeAKeQqfYrc
         8k7pFmqKROa3V7nJPewkXewfiW4C6CcjxAzhKEcJ8GOejezcozDxAfVWStZQTfiXmiV7
         e2fhSsyERH0fODiqVqFFWyDZcv/SXZ0fTEw3oMt4iUmPxc8W2q/5eoCJqWJSGyIYVMC5
         mN4nRXgpot3Dm6PfWta6OvECVNT9wtl0arsuVZtw7KA8P/E3IK/PAqft4gdrBb0YdJ99
         ZeL6Ak6WMsI15J8VRorHtlAlmIxNoK7KSbiejAOoOAiVRE0DYlMyd3t/Tq5uBbQ80gjB
         5RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=74d7oXrgzFnbsbNRa8Cu3QvRmG8E5YtnNRFaXJLincQ=;
        b=3JNaaDrp7i5MAerpdbmCi8l+JsgXFQ2RL3cKRYlZ5Fz6ad6rtO7vqFHaPybZAB/mWm
         hyJ6q2bsfkEYJyk8kdBOApIhY26vDH/vEJ+MzLPrBAV6I8YvW9ORnhpgXnNYpD8ff024
         51cKqA4+NbEjtLSq6jjN3y/PsPTclcvlkzH9uunDCUCGM7gvor6GqooYd7NiFqj3w6Pw
         zubLHtiMcuRkuHlF/N9qkEOVJde6p9SH486oXITriQTOcbwh75SrIYhMzxY7IWckbTeh
         y2b9Rhm9oqmAetdjQiBkWepi8+5fDw3ZWTv9BID8uOS7M/hMDwUG9vCvQ3PodQhJGXjM
         89+g==
X-Gm-Message-State: ACrzQf2zyqQGw2Ng+UCHSIJlwPjvW03CG+ZVT1wwu69h1ySv1HeM+yLD
        CmfxyE2w4HHDyYt8If0cJDU=
X-Google-Smtp-Source: AMsMyM4BuAM78s/IKfglr+RQpT2jPXqx9j6VV1pNnl7q1x33VbNYf+sMGFt/XMAhQy9h0Lmkyp77jA==
X-Received: by 2002:a54:4482:0:b0:34f:b980:e74a with SMTP id v2-20020a544482000000b0034fb980e74amr511028oiv.32.1663638215848;
        Mon, 19 Sep 2022 18:43:35 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id z20-20020a056871015400b0012784cb563dsm261175oab.22.2022.09.19.18.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:43:35 -0700 (PDT)
Date:   Mon, 19 Sep 2022 18:41:25 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Valentin Schneider <vschneid@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 3/4] lib/find_bit: optimize find_next_bit() functions
Message-ID: <YykaRYstXwJGqwvB@yury-laptop>
References: <20220915020730.852234-1-yury.norov@gmail.com>
 <20220915020730.852234-4-yury.norov@gmail.com>
 <YyhykvFCOskPAp59@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyhykvFCOskPAp59@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 04:45:54PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 14, 2022 at 07:07:29PM -0700, Yury Norov wrote:
> > Over the past couple years, the function _find_next_bit() was extended
> > with parameters that modify its behavior to implement and- zero- and le-
> > flavors. The parameters are passed at compile time, but current design
> > prevents a compiler from optimizing out the conditionals.
> > 
> > As find_next_bit() API grows, I expect that more parameters will be added.
> > Current design would require more conditional code in _find_next_bit(),
> > which would bloat the helper even more and make it barely readable.
> > 
> > This patch replaces _find_next_bit() with a macro FIND_NEXT_BIT, and adds
> > a set of wrappers, so that the compile-time optimizations become possible.
> > 
> > The common logic is moved to the new macro, and all flavors may be
> > generated by providing a FETCH macro parameter, like in this example:
> > 
> >   #define FIND_NEXT_BIT(FETCH, MUNGE, size, start) ...
> > 
> >   find_next_xornot_and_bit(addr1, addr2, addr3, size, start)
> >   {
> > 	return FIND_NEXT_BIT(addr1[idx] ^ ~addr2[idx] & addr3[idx],
> > 				/* nop */, size, start);
> >   }
> > 
> > The FETCH may be of any complexity, as soon as it only refers the bitmap(s)
> > and an iterator idx.
> > 
> > MUNGE is here to support _le code generation for BE builds. May be
> > empty.
> > 
> > I ran find_bit_benchmark 16 times on top of 6.0-rc2 and 16 times on top
> > of 6.0-rc2 + this series. The results for kvm/x86_64 are:
> > 
> >                       v6.0-rc2  Optimized       Difference  Z-score
> > Random dense bitmap         ns         ns        ns      %
> > find_next_bit:          787735     670546    117189   14.9     3.97
> > find_next_zero_bit:     777492     664208    113284   14.6    10.51
> > find_last_bit:          830925     687573    143352   17.3     2.35
> > find_first_bit:        3874366    3306635    567731   14.7     1.84
> > find_first_and_bit:   40677125   37739887   2937238    7.2     1.36
> > find_next_and_bit:      347865     304456     43409   12.5     1.35
> > 
> > Random sparse bitmap
> > find_next_bit:           19816      14021      5795   29.2     6.10
> > find_next_zero_bit:    1318901    1223794     95107    7.2     1.41
> > find_last_bit:           14573      13514      1059    7.3     6.92
> > find_first_bit:        1313321    1249024     64297    4.9     1.53
> > find_first_and_bit:       8921       8098       823    9.2     4.56
> > find_next_and_bit:        9796       7176      2620   26.7     5.39
> > 
> > Where the statistics is significant (z-score > 3), the improvement
> > is ~15%.
> > 
> > According to the bloat-o-meter, the Image size is 10-11K less:
> > 
> > x86_64/defconfig:
> > add/remove: 32/14 grow/shrink: 61/782 up/down: 6344/-16521 (-10177)
> > 
> > arm64/defconfig:
> > add/remove: 3/2 grow/shrink: 50/714 up/down: 608/-11556 (-10948)
> 
> ...
> 
> >  /*
> 
> Seems like you wanted this to be a kernel doc, but it isn't right now.

No, I didn't. I can remove '@' below, if that concerns you.
 
> > - * This is a common helper function for find_next_bit, find_next_zero_bit, and
> > - * find_next_and_bit. The differences are:
> > - *  - The "invert" argument, which is XORed with each fetched word before
> > - *    searching it for one bits.
> > - *  - The optional "addr2", which is anded with "addr1" if present.
> > + * Common helper for find_next_bit() function family
> 
> In such case this should start with a name of the macro
> 
>  * FIND_NEXT_BIT - ...
> 
> > + * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
> > + * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
> > + * @size: The bitmap size in bits
> > + * @start: The bitnumber to start searching at
> >   */
> 
> ...
> 
> > +#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
> > +({										\
> > +	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
> > +										\
> > +	if (unlikely(__start >= sz))						\
> > +		goto out;							\
> > +										\
> > +	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
> > +	idx = __start / BITS_PER_LONG;						\
> > +										\
> > +	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
> > +		if ((idx + 1) * BITS_PER_LONG >= sz)				\
> > +			goto out;						\
> > +		idx++;								\
> > +	}									\
> > +										\
> > +	sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(tmp)), sz);			\
> > +out:										\
> 
> I dunno if GCC expression limits the scope of goto labels, but on the safe side
> you can add a prefix to it, so it becomes:
> 
> FIND_NEXT_BIT_out:
> 
> (or alike).

As Linus already said, the 'out' is function-scope. We can make it a
block-scope with __label__, but this would make an impression that we
are OK with stacking many FIND macros in a single function.

I spend some time trying to figure out a legitimate usecase for it, but
nothing came in mind. There are many real cases when we need 2 or more
find functions at once but all that cases would work with regular
wrappers around FIND_BIT(). Check this, for example:

https://lore.kernel.org/lkml/20220919210559.1509179-6-yury.norov@gmail.com/

I don't know how FIND_BIT() machinery will evolve with time. For now
it's a clean and neat local helper with a very straightforward usage.
Lets keep it simple now? If someone will decide to call FIND_BIT()
twice and fail, it would be a good hint that he's doing something
wrong.

> > +	sz;									\
> > +})
> 
> ...
> 
> > +unsigned long _find_next_zero_bit_le(const unsigned long *addr, unsigned
> > +		long size, unsigned long offset)
> 
> Usually we don't split parameters between lines.

Ok

Thanks,
Yury
