Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D050068F868
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBHTxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjBHTxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:53:45 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784AC2820D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:53:41 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A2997320098A;
        Wed,  8 Feb 2023 14:53:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 08 Feb 2023 14:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675886019; x=1675972419; bh=u4mIBboc8z
        WkVAoo7l0sKl4cPdzol3dChcE/QdBcfSY=; b=EqZkBQ5ki/wyY8FKj1KNj3g0fm
        mt5zkuYks9zwcaj7WBArl0WHkp122SjlTkVt5Q807nkOWlYOR3tc83/DSNZzJN1G
        9zeG/YBhRzRtdXEUvzXWTidSL8PKcXPOIqCOcF//spBrhTJJpGufF0BUYuBoAWq3
        uwBf+6cXTUXQCOzMJ79qoN0n+AWMg1K+I8q1Gp0NlIPpibF3LFyDK+ce5Tq4an1c
        Cuy+TaFduWq521icDuejcvDT4pbRLfW+arzF2M+TT0JlkOx/UCi1AQUW25Vxxmhy
        xLo+rVQ5miPS+vOSmdybn8eJmhd2EgNHcMK54Gj0EV8jkPhCyfvRRvGtjO9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1675886019; x=1675972419; bh=u4mIBboc8zWkVAoo7l0sKl4cPdzo
        l3dChcE/QdBcfSY=; b=Ls/Hk45PYP0MYEHS0rbhxfpa4Q7KI/Kme0n7lpoqOWBL
        spc3Ys0uw8H6KY3y6RrxzxclICSYcgSITgASNxriFgDnlzdaQXCEer+TzvdhIEiX
        UFZ8zPnM+8WYyMlh3JXF0gJeejIk/IYXkO8/rmWqx6miZ22F9zZQ/FtHwOpnEE7+
        W2XvuPkXIAnoVPkiVSJiiZ1/ROyFIg6cSpi57A+1tqyXrgN2C+0HEZ1PAZxzuTbW
        j0gWuBsvOS6yFI43C7jPqicEGamigFUmbLSVY27j68OLv49JgZZPBg9KJlMFWFkD
        pS/MXlhyWWMyqeviiYsoFZtv9SB4qSq1OcvKJLzTDw==
X-ME-Sender: <xms:wv3jY8N74LfwHiBdx5827_MStVTm3iYxY13gmkkXxNsd9cQyMZT1pg>
    <xme:wv3jYy8AgHOZSNrr1eFwJ32ZuopMy25wbUyBqWz7f_BqBESV47z8Xj1jVbdtmiaef
    lhqJfLAXNngWnQr-rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehmtderreerredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepieejhfekgfegffdvtdfgleeuvedtueegleffkeevjeeitdeikeduvefhgefg
    geevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wv3jYzSmXhJvzQbM6ZiauJsIiZlCNohiJaFOCKhHY47-n0TAHnBhlw>
    <xmx:wv3jY0vocnBK-Cm5RqW7O4f2L8ysexcR7G5xOoKS9x8Nnk9l7tBxIA>
    <xmx:wv3jY0cOCImVkFHedISpt1nMAXG0ttg0JUgmMeIVJxT4rl_B3xCfwg>
    <xmx:w_3jY_3zlHjXgVZsIRb3aXu-ijv5boCfx_NuWT-fxO97_nFg5BmnFg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ADAA5B60089; Wed,  8 Feb 2023 14:53:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <c3da32e0-bfa9-415c-9970-e5506abb1a71@app.fastmail.com>
In-Reply-To: <CANpmjNN1nmjavBhj=xMMqAD1VScPySkdZbm2sTpWnKN1ZvmJcQ@mail.gmail.com>
References: <20230208164011.2287122-1-arnd@kernel.org>
 <20230208164011.2287122-4-arnd@kernel.org>
 <CANpmjNN1nmjavBhj=xMMqAD1VScPySkdZbm2sTpWnKN1ZvmJcQ@mail.gmail.com>
Date:   Wed, 08 Feb 2023 20:53:20 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Marco Elver" <elver@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Borislav Petkov" <bp@suse.de>, "Will Deacon" <will@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, kasan-dev@googlegroups.com,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Miroslav Benes" <mbenes@suse.cz>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Sathvika Vasireddy" <sv@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] objtool: add UACCESS exceptions for __tsan_volatile_read/write
Content-Type: multipart/mixed;
 boundary=346ff4ea0b8748439f2a9b6b76fd3d22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--346ff4ea0b8748439f2a9b6b76fd3d22
Content-Type: text/plain

On Wed, Feb 8, 2023, at 17:59, Marco Elver wrote:
> On Wed, 8 Feb 2023 at 17:40, Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> A lot of the tsan helpers are already excempt from the UACCESS warnings,
>> but some more functions were added that need the same thing:
>>
>> kernel/kcsan/core.o: warning: objtool: __tsan_volatile_read16+0x0: call to __tsan_unaligned_read16() with UACCESS enabled
>> kernel/kcsan/core.o: warning: objtool: __tsan_volatile_write16+0x0: call to __tsan_unaligned_write16() with UACCESS enabled
>> vmlinux.o: warning: objtool: __tsan_unaligned_volatile_read16+0x4: call to __tsan_unaligned_read16() with UACCESS enabled
>> vmlinux.o: warning: objtool: __tsan_unaligned_volatile_write16+0x4: call to __tsan_unaligned_write16() with UACCESS enabled
>
> That's odd - this has never been needed, because all __tsan_unaligned
> are aliases for the non-unaligned functions. And all those are in the
> uaccess_safe_builtin list already.
>
> So if suddenly the alias name becomes the symbol that objtool sees, we
> might need to add all the other functions as well.
>
> Is this a special build with a new compiler?

I see this with gcc-12 and gcc-13 but not with clang-{14,15,16}, have
not tried any older versions recently.

What I see in the .s file for one of the affected configs is

        .globl  __tsan_unaligned_read16
        .set    __tsan_unaligned_read16,__tsan_read16
        .p2align 6
        .globl  __tsan_volatile_read16
        .type   __tsan_volatile_read16, @function
__tsan_volatile_read16:
        endbr64 
        jmp     __tsan_read16   # 
        .size   __tsan_volatile_read16, .-__tsan_volatile_read16
        .globl  __tsan_unaligned_volatile_read16
        .set    __tsan_unaligned_volatile_read16,__tsan_volatile_read16
...
        .set    __tsan_unaligned_write16,__tsan_write16
        .p2align 6
        .globl  __tsan_volatile_write16
        .type   __tsan_volatile_write16, @function
__tsan_volatile_write16:
        endbr64 
        jmp     __tsan_write16  # 
        .size   __tsan_volatile_write16, .-__tsan_volatile_write16
        .globl  __tsan_unaligned_volatile_write16
        .set    __tsan_unaligned_volatile_write16,__tsan_volatile_write16


In the object file that turns into:

0000000000004e80 <__tsan_unaligned_volatile_read16>:
    4e80:       f3 0f 1e fa             endbr64
    4e84:       e9 b7 fe ff ff          jmp    4d40 <__tsan_read16>
...
0000000000005000 <__tsan_unaligned_volatile_write16>:
    5000:       f3 0f 1e fa             endbr64
    5004:       e9 b7 fe ff ff          jmp    4ec0 <__tsan_unaligned_write16>


It appears like it picks randomly between the original name
and the alias here, no idea why. Using the clang integrated assembler
to build the .o file from the gcc generated .s file shows the same
code as

0000000000004e80 <__tsan_unaligned_volatile_read16>:
    4e80:       f3 0f 1e fa             endbr64
    4e84:       e9 00 00 00 00          jmp    4e89 <__tsan_unaligned_volatile_read16+0x9>
                        4e85: R_X86_64_PLT32    __tsan_read16-0x4
...
0000000000005000 <__tsan_unaligned_volatile_write16>:
    5000:       f3 0f 1e fa             endbr64
    5004:       e9 00 00 00 00          jmp    5009 <__tsan_unaligned_volatile_write16+0x9>
                        5005: R_X86_64_PLT32    __tsan_write16-0x4


Attaching the object file for reference.

      Arnd
--346ff4ea0b8748439f2a9b6b76fd3d22
Content-Disposition: attachment; filename="core.o.gz"
Content-Type: application/gzip; name="core.o.gz"
Content-Transfer-Encoding: BASE64

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
FyaBZWVo5gEA

--346ff4ea0b8748439f2a9b6b76fd3d22--
