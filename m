Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B0A70F4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjEXLTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjEXLTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:19:50 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640F0A3;
        Wed, 24 May 2023 04:19:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 311495C0269;
        Wed, 24 May 2023 07:19:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 07:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684927188; x=1685013588; bh=94
        udbzVTGqNaMGw/zUgvdZI97Kq4XPISqem/Xsupn/8=; b=w6r7T/7qs8AGLDufOJ
        0LyYeUmOuYZ0wEDKLwv7v2MwNIz5BGj1WvSmcYZROWapiIqaJrF/LJpRnIQPoFhj
        MTROX/VVKYUfabxXWxrbGjFOQJ34KM4RXRmx8mzLgVaVt71wXgdmmjKO+LIImrvU
        JGX2W4uqfnrvKlwSaiOjQnzC7KAxIs4AyyOLLAx34OgEisEnuTEZ/pZWC9k2Sqb/
        zD7tB4cegxf0U1QRdkQ8IELBw4e/QWJPTrtUCZad6dupzeGcdVs4x4A9c1WMsjpu
        +2+zGUu0Cci90pH/omI/OcJLZftD0QBGyFupTHvaVf1ZutgAUn8LGzsknrip+4hj
        XcfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684927188; x=1685013588; bh=94udbzVTGqNaM
        Gw/zUgvdZI97Kq4XPISqem/Xsupn/8=; b=D7cZxt9rKuLyVChV7PUxn2n6ulSBC
        Ce+DRoNJCe7nj+fjCnsuLudpb0FtdNxZF1sivWkpqDN4RiYweBpJjuKbFBIjyQOw
        O6DZjmTTsJ5mPTmI/p5Xk3LzW5XWfi//nq8GBOjIJmhjqQx3FFcn/a8lgUq4sRny
        zlDTzN64LDZOtNxshc6Ieo1xHstJcVtZYfY/Jg4Bx+0//Xl4bhExYWoGM9bywKas
        YqMItPmggzEdmFhC3UDgZSTiZ2ZjadSYvdkVv0itI0JLY8h7+cdXuBkev8W8Qy/1
        dHf6q+NmhFyhBCNyE4g6+CBRz/8pIoe1f57M3ETm6CX8MwR3WVBWEPRfw==
X-ME-Sender: <xms:0_JtZMTQndnCYvagsowQkfi4onmlIDQ5AKD4i0JHdGfw2XvUqZwP6w>
    <xme:0_JtZJwXaCZ2YDhi5pbLX4dMsx8-MVH-Q0TGqklcIOva212ryMIlBGEZM8Aax5UWN
    FUvX8_-SKofzlGBc-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1PJtZJ2NuOJuSuFE6AYdIV2r1uqzjcZhVxu5oBEp26l7pKz99R16Fw>
    <xmx:1PJtZADGbk9yTUFlgmhj6n65osecvIL0txe0N1fhdVIIO-FqwDH1kg>
    <xmx:1PJtZFgSUhzui-6BLqus14DFAQYZG7o3HEZlIdaYW1OEDD8GZOoG_A>
    <xmx:1PJtZAoVaN93tzZy_zgXJnjaW68eUIdNkf59Wr-g_5OHG8M3n1aPaw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E4DA2B60086; Wed, 24 May 2023 07:19:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <3a055da0-fd88-4ec0-b006-9ccd382e9cc6@app.fastmail.com>
In-Reply-To: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
Date:   Wed, 24 May 2023 13:18:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, "LTP List" <ltp@lists.linux.it>,
        lkft-triage@lists.linaro.org, "X86 ML" <x86@kernel.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        "Anders Roxell" <anders.roxell@linaro.org>
Subject: Re: qemu-x86_64 compat: LTP: controllers: RIP: 0010:__alloc_pages
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023, at 11:02, Naresh Kamboju wrote:
> While running LTP controllers following kernel crash noticed on qemu-x86_64
> compat mode with stable-rc 6.3.4-rc2.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
>  Linux version 6.3.4-rc2 (tuxmake@tuxmake) (x86_64-linux-gnu-gcc
> (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1
> SMP PREEMPT_DYNAMIC @1684862676
> ..
> ./runltp -f controllers
> ...
> cpuset_inherit 11 TPASS: cpus: Inherited information is right!
> cpuset_inherit 13 TPASS: mems: Inherited information is right!
> <4>[ 1130.117922] int3: 0000 [#1] PREEMPT SMP PTI
> <4>[ 1130.118132] CPU: 0 PID: 32748 Comm: cpuset_inherit_ Not tainted
> 6.3.4-rc2 #1
> <4>[ 1130.118216] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.14.0-2 04/01/2014
> <4>[ 1130.118320] RIP: 0010:__alloc_pages+0xeb/0x340
> <4>[ 1130.118605] Code: 48 c1 e0 04 48 8d 84 01 00 13 00 00 48 89 45
> a8 8b 05 d9 31 cf 01 85 c0 0f 85 05 02 00 00 89 d8 c1 e8 03 83 e0 03
> 89 45 c0 66 <90> 41 89 df 41 be 01 00 00 00 f6 c7 04 75 66 44 89 e6 89
> df e8 ec

I haven't figured out what is going on here, but I tracked down
the trapping instruction <90> to the middle of the 'xchg   %ax,%ax'
two-byte nop in:

ffffffff814218f4:       83 e0 03                and    $0x3,%eax
ffffffff814218f7:       89 45 c0                mov    %eax,-0x40(%rbp)
ffffffff814218fa:       66 90                   xchg   %ax,%ax
ffffffff814218fc:       41 89 df                mov    %ebx,%r15d
ffffffff814218ff:       41 be 01 00 00 00       mov    $0x1,%r14d

which in turn is the cpusets_enabled() check in prepare_alloc_pages().

static inline bool cpusets_enabled(void)
{       
        return static_branch_unlikely(&cpusets_enabled_key);
}

static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
{
        asm_volatile_goto("1:"
                "jmp %l[l_yes] # objtool NOPs this \n\t"
                JUMP_TABLE_ENTRY
                : :  "i" (key), "i" (2 | branch) : : l_yes);

        return false;
l_yes:
        return true;
}

I don't see any changes related to this between 6.3.3 and 6.3.4-rc2.

       Arnd
