Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C825C01E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIUPmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiIUPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:42:19 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB26426C9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:42:13 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r22-20020a9d7516000000b00659ef017e34so4183026otk.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=I0fSDhuSIAYb58A0bxYinMYKDF5504dZb9BZT2Lq62M=;
        b=qoGY2XDB5R/3CRkKcAWGJFUsnFs8hUSEFlqDSljzngkB+SlnvPu2vTteeBNnnRuz10
         9xv8wYRH3QGnG8ln8l9ytSLaqwSM1jH5AIZ+w/OUXutg3N5RCjXkTV7POwj2awOlQHd5
         fFbq2hNF49LtvgonWA2lWowrdO02sj59mlUtNFysqt0NRR2kYn4YfNgRfqZyq+zUTDTZ
         7u5qQ4Ufjm8EpihHMkzgmiTx+S1W2Z/XJH2X9JHZTKzQu23jVxhfTCn4h0vMBFKIbU8b
         o7WsF/c8nWksDhmrneD5DD1vQ15XXUPaRODvgzvJ0c52M0Eb9Co/8sV5lawyYYf4RQHn
         igzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=I0fSDhuSIAYb58A0bxYinMYKDF5504dZb9BZT2Lq62M=;
        b=fpp2XTjXp/fI5sVyh6gSeUQldLjvip48w7ARRB+VktZR2LmAsJVnYX5Ejgt/SR2aLt
         RTE8Bmq0Hticve1MZdq2P2jksjhqVu8YUPGs6FAP1Vby+1tkCvy0nAL/W283ZkIt9G8c
         4vYI8TGCz4qBP5nRbUvKW0M7o8SoQwu+BtqmD9o2oq+f4oU8BkvQLhDyYON1kR8KjUHd
         cLO+ItmDEQroLwA2PVukTcrSqRalK8FK3vPQCrva6lSuznPsgxOsK/RCo79YZ8JXY6i9
         fySuZ99ll36sU8+nl+Mx9SGBXEVc2TsppHdEk6y48FznTy4LeEtVetQCYU2SiCPjpoXE
         sTMw==
X-Gm-Message-State: ACrzQf1hiPmmyuYmslZHd8mPrFodDlXBcnMP06dAOyJSnrvfRybXkO8X
        KTWntkO20ewckWGdRZcR9zM=
X-Google-Smtp-Source: AMsMyM7oSQz3SPx7yZe/Htb5tFDOXe5H3/p0aTNzHE7zmkGDJOdBF1NlzFc6v5GNCZFuQ58UN5pXrQ==
X-Received: by 2002:a05:6830:6387:b0:651:30e9:c47f with SMTP id ch7-20020a056830638700b0065130e9c47fmr12532760otb.188.1663774932624;
        Wed, 21 Sep 2022 08:42:12 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id o83-20020acaf056000000b0034f684ca159sm1333457oih.29.2022.09.21.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:42:12 -0700 (PDT)
Date:   Wed, 21 Sep 2022 08:40:00 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v4 0/4] lib: optimize find_bit() functions
Message-ID: <YyswUKLcRiuRoUrn@yury-laptop>
References: <20220915020730.852234-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915020730.852234-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no other comments, I'll address Andy's comments on formatting and
move it in bitmap-for-next.

Thanks,
Yury

On Wed, Sep 14, 2022 at 07:07:26PM -0700, Yury Norov wrote:
> In the recent discussion, it was noticed that find_next_bit() functions may
> be improved by adding wrappers around common __find_next_bit() in .c file.
> 
> As suggested by Linus, I tried the meta-programming trick with the
> EXPRESSION macro, which is passed from wrapper into find_bit()
> helpers:
> 
>   #define BIT_FIND_BODY(addr, size, start, EXPRESSION)          \
>         BIT_FIND_SETUP(addr, size, start)                       \
>         BIT_FIND_FIRST_WORD(addr, size, start, EXPRESSION)      \
>         BIT_WORD_LOOP(addr, size, idx, val, EXPRESSION)         \
>         return size;                                            \
>   found:        BIT_WORD_SWAB(val);                             \
>         return min((idx)*BITS_PER_LONG + __ffs(val), size)
> 
>   unsigned long _find_next_and_bit(const unsigned long *addr1,
>                                  const unsigned long *addr2,
>                                  unsigned long size,
>                                  unsigned long start)
>   { BIT_FIND_BODY(addr, size, start, addr1[idx] & addr2[idx]); }
> 
> I appreciated the potential of how the EXPRESSION works, but I don't like
> that the resulting macro is constructed from pieces because it makes it
> harder to understand what happens behind the ifdefery. Checkpatch isn't
> happy as well because the final macro contains 'return' statement; and I
> would agree that it's better to avoid it.
> 
> I spun the idea one more time, trying to make FIND helper a more or
> less standard looking macro.
> 
> This new approach saves 10-11K of Image size, and is 15% faster in the
> performance benchmark. See the 3rd patch for some statistics.
> 
> v1: https://lore.kernel.org/all/20220728161208.865420-2-yury.norov@gmail.com/T/
> v2: https://lore.kernel.org/lkml/YwaXvphVpy5A7fSs@yury-laptop/t/
> v3: https://lore.kernel.org/all/xhsmhedwnb15r.mognet@vschneid.remote.csb/T/
> v4:
>  - fix for-loop break condition in FIND_NEXT_BIT;
>  - add review tags from Valentin Schneider.
> 
> Yury Norov (4):
>   lib/find_bit: introduce FIND_FIRST_BIT() macro
>   lib/find_bit: create find_first_zero_bit_le()
>   lib/find_bit: optimize find_next_bit() functions
>   tools: sync find_bit() implementation
> 
>  include/linux/find.h       |  46 +++++++---
>  lib/find_bit.c             | 178 ++++++++++++++++++++++---------------
>  tools/include/linux/find.h |  61 +++----------
>  tools/lib/find_bit.c       | 149 ++++++++++++++-----------------
>  4 files changed, 220 insertions(+), 214 deletions(-)
> 
> -- 
> 2.34.1
