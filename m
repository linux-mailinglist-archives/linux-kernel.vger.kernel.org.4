Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2830673BEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjFWTWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFWTWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:22:23 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A761E7D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:22:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3219B3200954;
        Fri, 23 Jun 2023 15:22:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 23 Jun 2023 15:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687548133; x=1687634533; bh=T7
        6ETiA5jZoYnUGGuCeNzswPkZo4eVvYtKVKMaqu6IE=; b=LMW6WOPtf4iPqpk93e
        Pv148QDdBrHOVpTcH2GwqqPJFX2P8JLV/MYu7MqMoVbL/sOaKqau0rx9TIzXDsX+
        3pu6C4rR2g9jREH8u0oOldcQ3GsPhXUbs3tyv7HxgPmJC+YxxxnpIZG1eWNtDnBN
        i/rByoC5yUMjdjE8hgkUx6vzlBzbYOyxppoERv5W7VMfwDDBauU2b32gtmajluyP
        WyDYSbls6ED27rEF0hkXO5CjbduODcaVa1NDZLYxuYEEFO59ytXOndiZgCvbAz+A
        gP89zCbDs9UXmW4TKL6Qo7VtpjH6lUYBxT9QRt36Nz269E0Bra6NU9A3FY8HMRrp
        QRkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687548133; x=1687634533; bh=T76ETiA5jZoYn
        UGGuCeNzswPkZo4eVvYtKVKMaqu6IE=; b=Pkext42E4udMjEeF6vJEMZ1YRdOds
        c79RuKspFuFhUk89k2RkGWoUXGqmkWYK8KyMDr+z7VA8+fDiXa1dc/XD5oUb7A9p
        x/M0kP1kaEARRjo3+F2hqibwD/yt+aNhzRnK8MECMJCxb0wuzuhPoi1auE+Rrrqk
        OFXEmBvrezDx/6iVXPa0nvqJd6YbjabyJoPS/+Unt1LCbPBmO6adfcBYN9c7ejXX
        eJHfaGWpm6bPVeM9i8LMIGPfa0kwPg+HxdxvSqpBdfydO77UAwZeeaX22cJgKAm5
        lGaseq9arEtmObFOObUrGKl2+sewYFL8JkdWSsoriHU69RRBkRnf1LF4Q==
X-ME-Sender: <xms:5fCVZJo0S0S5mms5VR9uM0Akj6QaAW5wdw5A3Sl2QtCEfCL2INcGYQ>
    <xme:5fCVZLrdNfcFAEmsUepBx7I5IjjF0oJrDWscBQ5NVJ9VhtUZBfS5mxVA5zyZHYIex
    YL9wPZ5KOAixCL6N3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeggedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5fCVZGPc_FHa-6Ef0LxWjxewQf7tmDETngoiLZzF4KpFjl_v9Cy2Ww>
    <xmx:5fCVZE400mAJrQ8knEUFyefd054c4sd4AQXaODMdKVNMj5NIklpUBQ>
    <xmx:5fCVZI4dqixS8hh0ZFxt13KxTP6UcVpF3FzFgk5kX_D8di7XKK7mDw>
    <xmx:5fCVZGkcizyb0bFd4b7UlqFyky_4AiSW1xWlSNZgJKGJLj0JSVLnig>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8314DB60086; Fri, 23 Jun 2023 15:22:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <37e7ef6d-3a92-42ab-a949-59c18bccc510@app.fastmail.com>
In-Reply-To: <CAHk-=wg9p+oJtzC0582vke8whcWPNSC9eq0Z6kdnSqWMEpah7g@mail.gmail.com>
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
 <CAHk-=wg9p+oJtzC0582vke8whcWPNSC9eq0Z6kdnSqWMEpah7g@mail.gmail.com>
Date:   Fri, 23 Jun 2023 21:21:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Dave Airlie" <airlied@gmail.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>
Cc:     "Tejun Heo" <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: arm32 build warnings in workqueue.c
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,LOTS_OF_MONEY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023, at 20:52, Linus Torvalds wrote:
> [ Adding clang people. See this for background:
>
>     
> https://lore.kernel.org/all/CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com/
>
>   where that patch not only cleans things up, but seems to make a
> difference to clang ]
>
> On Fri, 23 Jun 2023 at 11:24, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> So I really think that code needs fixing, and the gcc warning was very valid.
>>
>> Maybe something like the attached. Does this fix the gcc warning?
>> Tejun, comments?
>
> Whee. Inexplicably, that patch also improves code generation with
> clang, with things like this:
>
> -       movabsq $137438953440, %rcx             # imm = 0x1FFFFFFFE0
> -       andq    %rax, %rcx
> -       movabsq $68719476704, %rdx              # imm = 0xFFFFFFFE0
> -       cmpq    %rdx, %rcx
> +       shrq    $5, %rax
> +       cmpl    $2147483647, %eax               # imm = 0x7FFFFFFF
>
> in several places.
>
> Or, even more amusingly, this:
>
> -       movabsq $68719476704, %rax              # imm = 0xFFFFFFFE0
> -       orq     $1, %rax
> +       movabsq $68719476705, %rax              # imm = 0xFFFFFFFE1
>
> where the old code was some truly crazy stuff.
>
> I have *no* idea what drugs clang is on, but clearly clang does some
> really really bad things with large enums, and doesn't simplify things
> correctly.

I sent a fix for the warning earlier this year, and it's been
in linux-next for a while but hasn't made it to your tree yet,
see https://lore.kernel.org/all/20230117164041.1207412-1-arnd@kernel.org/
for the initial submission.

I went with the minimal change there, your more elaborate version
looks fine as well. There were a handful of bugs that came up with
the changed behavior, in other cases they caused the code to actually
misbehave rather than just causing a build warning.

After having looked at all the other instances, I still feel that
the new gcc behavior is the sanest way to handle this, but it was
not communicated well in the gcc-13 release notes, and I would have
preferred to see a warning for source code that had a change in code
generation because of this.

The short explanation of the change is that with the previous
gcc and clang behavior, the type of 'enum foo' would be determined
separately from the type of each individual constant, while the
new behavior in gcc-13 makes them all have the same type.
IIRC with a definition of 

enum {
    A = -1,
    B = UINT_MAX,
} var;

you had 'typeof(A)' as an 'int', 'typeof(B)' as an 'unsigned int'
and 'typeof(var)' as a 'long long', now they are all 'long long'.

     Arnd
