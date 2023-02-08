Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B520468F89C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjBHULU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjBHULS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:11:18 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8ECE38C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:11:17 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-52bfa3dfd95so18973727b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ppZKTlZsbVsBTD7XLFZBK3GUbz0ywmkpoflVXVXaA8=;
        b=YRhnWSY5ik7rOYzZAlRyYpyGomzImudArMSwPCy42MiS7RHScRHsk41ikrlIZQY2Dr
         BtIEoK95G7IqxlGnsILwRKeGvCEIcy6SFcnK1cgp7PPe2zlPmDvC/GWrgNN6oLZe2j9n
         xTM7HtjXZnGcu6FKNpy/MnZQ/0WsUXvS14gpHjb20SFLpxjhwQfROejL+eyaMY2OQ0Vs
         iy+oIgE/rt2UhZmqaF7Ew9o/JYn1UyaudKnh3dcxRb+3iq1VOm/hKyIwlfPtw2zl9reX
         vyiF1juZfuHzLve8kPTzsqYapyIG8MmzB6Zobt2ICi7dZdd1tLDE9rsj8kIUmBTwzjzl
         rRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ppZKTlZsbVsBTD7XLFZBK3GUbz0ywmkpoflVXVXaA8=;
        b=M1fqWiAyjoeqCI0IQhsfFTnFK7QDnDnJtaqwVpv7gtnPxRtf3GA1X8O3NxLQLFt469
         Us5UREHGRXvO0XsVyHPz6io0PKPCSEf7aHXoljNTgAZlnFlhelOsm6N5LZKJ6rUICQU5
         35FZCziTL5+JtnHI04PN1wudwUaZWA5KkzUPtnRCDunbCy1UHyyrI8RCog5/Rwd/0Rfr
         kB9CH04ALpl3Eg6Gorx5KdIVdgWB899SdXk5jI5dlmD/JPv0oNfpWXmTnvl3HAnDX615
         GnC/r1Jv2Z7yTDyI49XbuRrz7Y+yb++dvq/SkjJzySTaeCs0UTXZzSDl6VOCbQH21Dw+
         0E+w==
X-Gm-Message-State: AO0yUKUTN3162SYz+FMfCnt2alq0nTvpziYngKJJwfMnVlHpSTjqRnvV
        1Y7kN+i15r1E15PdqCR3Aq5UqbI2Ab5nPBgV4R+/4w==
X-Google-Smtp-Source: AK7set83lygrhoj7tvT8KENhQnVIYsh51KhZkjHqki0rcvQsRXY+/+uvewzRsnqeweVX0QrPQiS1m28HNu6srflINms=
X-Received: by 2002:a81:600a:0:b0:527:acf6:e0bf with SMTP id
 u10-20020a81600a000000b00527acf6e0bfmr1087733ywb.109.1675887076968; Wed, 08
 Feb 2023 12:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20230208164011.2287122-1-arnd@kernel.org> <20230208164011.2287122-4-arnd@kernel.org>
 <CANpmjNN1nmjavBhj=xMMqAD1VScPySkdZbm2sTpWnKN1ZvmJcQ@mail.gmail.com> <c3da32e0-bfa9-415c-9970-e5506abb1a71@app.fastmail.com>
In-Reply-To: <c3da32e0-bfa9-415c-9970-e5506abb1a71@app.fastmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 8 Feb 2023 21:10:39 +0100
Message-ID: <CANpmjNNTUOfdjK_e5xWheqJgGBkD5e9_F15Vn0DECwtCwppDkw@mail.gmail.com>
Subject: Re: [PATCH 4/4] objtool: add UACCESS exceptions for __tsan_volatile_read/write
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        linux-kernel@vger.kernel.org
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

On Wed, 8 Feb 2023 at 20:53, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 8, 2023, at 17:59, Marco Elver wrote:
> > On Wed, 8 Feb 2023 at 17:40, Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> A lot of the tsan helpers are already excempt from the UACCESS warnings,
> >> but some more functions were added that need the same thing:
> >>
> >> kernel/kcsan/core.o: warning: objtool: __tsan_volatile_read16+0x0: call to __tsan_unaligned_read16() with UACCESS enabled
> >> kernel/kcsan/core.o: warning: objtool: __tsan_volatile_write16+0x0: call to __tsan_unaligned_write16() with UACCESS enabled
> >> vmlinux.o: warning: objtool: __tsan_unaligned_volatile_read16+0x4: call to __tsan_unaligned_read16() with UACCESS enabled
> >> vmlinux.o: warning: objtool: __tsan_unaligned_volatile_write16+0x4: call to __tsan_unaligned_write16() with UACCESS enabled
> >
> > That's odd - this has never been needed, because all __tsan_unaligned
> > are aliases for the non-unaligned functions. And all those are in the
> > uaccess_safe_builtin list already.
> >
> > So if suddenly the alias name becomes the symbol that objtool sees, we
> > might need to add all the other functions as well.
> >
> > Is this a special build with a new compiler?
>
> I see this with gcc-12 and gcc-13 but not with clang-{14,15,16}, have
> not tried any older versions recently.
>
> What I see in the .s file for one of the affected configs is
>
>         .globl  __tsan_unaligned_read16
>         .set    __tsan_unaligned_read16,__tsan_read16
>         .p2align 6
>         .globl  __tsan_volatile_read16
>         .type   __tsan_volatile_read16, @function
> __tsan_volatile_read16:
>         endbr64
>         jmp     __tsan_read16   #
>         .size   __tsan_volatile_read16, .-__tsan_volatile_read16
>         .globl  __tsan_unaligned_volatile_read16
>         .set    __tsan_unaligned_volatile_read16,__tsan_volatile_read16
> ...
>         .set    __tsan_unaligned_write16,__tsan_write16
>         .p2align 6
>         .globl  __tsan_volatile_write16
>         .type   __tsan_volatile_write16, @function
> __tsan_volatile_write16:
>         endbr64
>         jmp     __tsan_write16  #
>         .size   __tsan_volatile_write16, .-__tsan_volatile_write16
>         .globl  __tsan_unaligned_volatile_write16
>         .set    __tsan_unaligned_volatile_write16,__tsan_volatile_write16
>
>
> In the object file that turns into:
>
> 0000000000004e80 <__tsan_unaligned_volatile_read16>:
>     4e80:       f3 0f 1e fa             endbr64
>     4e84:       e9 b7 fe ff ff          jmp    4d40 <__tsan_read16>
> ...
> 0000000000005000 <__tsan_unaligned_volatile_write16>:
>     5000:       f3 0f 1e fa             endbr64
>     5004:       e9 b7 fe ff ff          jmp    4ec0 <__tsan_unaligned_write16>
>
>
> It appears like it picks randomly between the original name
> and the alias here, no idea why. Using the clang integrated assembler
> to build the .o file from the gcc generated .s file shows the same
> code as
>
> 0000000000004e80 <__tsan_unaligned_volatile_read16>:
>     4e80:       f3 0f 1e fa             endbr64
>     4e84:       e9 00 00 00 00          jmp    4e89 <__tsan_unaligned_volatile_read16+0x9>
>                         4e85: R_X86_64_PLT32    __tsan_read16-0x4
> ...
> 0000000000005000 <__tsan_unaligned_volatile_write16>:
>     5000:       f3 0f 1e fa             endbr64
>     5004:       e9 00 00 00 00          jmp    5009 <__tsan_unaligned_volatile_write16+0x9>
>                         5005: R_X86_64_PLT32    __tsan_write16-0x4

Interesting - also note that in kernel/kcsan/core.c, these functions
don't even call each other explicitly. Although because sizeof(long) <
16 everywhere, the code for the volatile and non-volatile 16-byte
variants ends up the same. So the optimizer seems to think it's ok to
just "call" the other equivalent function, even though we didn't tell
it to do so - check_access() is __always_inline.

Whatever happens here isn't completely wrong, so if you just want to
silence the warning:

  Acked-by: Marco Elver <elver@google.com>

But I have a feeling the compiler is being a bit too clever here.
