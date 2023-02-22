Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BFA69FEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjBVWpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjBVWpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:45:44 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FAC2717
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:45:43 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id ff4so9874731qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDbwsmSxaP2+DDyTyoVb/EVVl6ji5RjVuFgBzOOAhyI=;
        b=ATZFC5qA6tDDCTWRPjJVX2WNbDFBDEFO3ziY0JJ6wzeXlLijEcSvOBqEoe1IO44n18
         tAE4CP1wCZNLzLI1p6XAe/MyJLiEd1/wm0Hw79WL9Z36SS1HH9zo8ztcLAALsRQ63fxz
         BG3aWLP0zsjfr9Kmkp25r200hiQCbk5TIroq2CDNaPosdwxoqfwP2seLbLt28fMDCyVZ
         LmEUkYnyi7b+N5L/8hvss1pvzLVTWfTMvSwbRApTKqecJ9zIHLhLg5H1qA5CwCcHdBDa
         siinHCBcqi741RFX9jiLKAwmzgV+TPl6+glRzMv3MsRm3OKq2aTQFHIzplVOOCwYPLEo
         7cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDbwsmSxaP2+DDyTyoVb/EVVl6ji5RjVuFgBzOOAhyI=;
        b=MeyU8470IP2ZcZgFGlBXjUf20xBH5ONKTXps5GHhjdTpEDKDEq+T3vGdi2et3A4YLq
         o3ReDft/aekAesEELda/Vue/zT5e6DvtVQLsPgeIvw4F3C40OgxbPVfNGmz14UyNlIMy
         c7gT2vOfrGAZNVUQmh+ZoVoi3DZVqos8GuRViqegCK+S2PULaHw5YTFTcxpMEL7xJ+0H
         IGAVuEzPBoQgnzs/2ygvYUSD+UZcFU/NplIRhUjy1iA+UeTImMa70ynOuKb/y4JJ/vxS
         zFHocEoFDhlfhAz+d3fBUH3o5NDj7tvBSfs7NnbQR3cjjQ/nCnOB9Qexw0R7rc9eEn7B
         2H9Q==
X-Gm-Message-State: AO0yUKVMWhYfTxklGuu0NE9clVnCuZwADNqT+tiEm1ZqIcdlHZcvmwy0
        tTKzeGWmNddaR7YXE90gOwrcBSCwlvADXGRv
X-Google-Smtp-Source: AK7set9yHsQjkRIt8K+Bm48r+HZ5VDpLn2AxTJ3ildERWjm4EtI1+meEh74X4VeNaloWY3NtBqvA3Q==
X-Received: by 2002:a05:6e02:1487:b0:316:e39f:1212 with SMTP id n7-20020a056e02148700b00316e39f1212mr5085457ilk.4.1677105529098;
        Wed, 22 Feb 2023 14:38:49 -0800 (PST)
Received: from [172.16.32.78] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id g2-20020a0566380c4200b003c4f55da7easm1539182jal.45.2023.02.22.14.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:38:48 -0800 (PST)
Message-ID: <668a287b-7c21-7f97-5703-67dcfe021006@landley.net>
Date:   Wed, 22 Feb 2023 16:52:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/5] Replace timeconst.bc with mktimeconst.c
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <9b8ce4db-9e1b-32b6-f749-94e4decc032e@landley.net> <87ttzemv8i.ffs@tglx>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <87ttzemv8i.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 17:53, Thomas Gleixner wrote:
> Rob!

Yup.

> On Tue, Feb 21 2023 at 15:00, Rob Landley wrote:
> 
> See my previous comment about Documentation. This time you even failed
> to CC the maintainer of this code.

$ git show
commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c (HEAD, tag: v6.2)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Feb 19 14:24:22 2023 -0800

    Linux 6.2
...
$ scripts/get_maintainer.pl 0004-*.patch
Masahiro Yamada <masahiroy@kernel.org>
(commit_signer:3/3=100%,authored:3/3=100%,added_lines:61/61=100%,removed_lines:22/22=100%)
Nicolas Schier <nicolas@fjasle.eu> (commit_signer:1/3=33%)
linux-kernel@vger.kernel.org (open list)

I cc'd who scripts/get_maintainer.pl told me to cc, when run in a 6.2 checkout.

>> Update of my decade-old patch replacing timeconst.pl with mktimeconst.c,
>> still removing the only user of "bc" from the build.
> 
> How is 'decade-old patch' relevant changelog information?

I posted these patches on
https://landley.net/toybox/downloads/binaries/mkroot/0.8.9/linux-patches/ and
https://github.com/landley/linux/commits/mkroot-6.1 when I did the toybox
release where the mkroot binary system images were built from this stuff. The
descriptions mostly come from there. None of the people I interact with
regularly bothers to talk to linux-kernel anymore, they think you're too toxic
to ever contact. I'm weird for tolerating you.

Posting it here involved retesting all the targets against 6.2 and digging up a
thunderbird plugin to get it to stop wrapping lines (old one bit-rotted and is
no longer maintained) and silencing various check_patch.pl complaints about
curly bracket placement and so on. But not a lot of rewriting the descriptions.
It wouldn't help.

This particular patch is coming up on 15 years of ancestry
(https://lore.kernel.org/all/200912080319.30679.rob@landley.net/) so I really
don't expect linux-kernel to merge... anything anymore?

I'd have thought the "$ARCH-cross-cc toolchains just work whether they're gcc or
llvm without needing to tell make LLVM=1 but not GCC=1" patch was a no-brainer,
or the one that fixes an obvious bug in my own code from 10 years ago which
multiple people have poked me about and I finally bothered to do something
about, or the one where "hey, you have a CONFIG_DEVTMPFS_MOUNT and it doesn't
work for initramfs, that seems like a bug".

But that just shows I'm out of step with this community. I remember when posting
a simple patch would give someone the idea and they'd write their own as often
as merge mine because it was just easy to do. Hasn't been the case here in quite
a while.

>> All that's changed since the 2015 version at:
>> https://github.com/landley/aboriginal/blob/master/sources/patches/linux-noperl-timeconst.patch
> 
> That's neither interesting.

"This area of the existing linux code is not regularly updated, replacing it
does not imply a large future maintenance burden."

>> Is one extra iteration of the loop for nanoseconds and different
>> makefile plumbing calling it. In theory this could calculate the values
>> at runtime in a small _init function and eliminate the header or even
>> allow HZ to change at runtime.
> 
> In theory we can also build a compiler into the decompressor which
> compiles and bootstraps the kernel itself, right?

Fabrice Bellard did that in 2004:

https://bellard.org/tcc/tccboot.html

I maintained a fork of tinycc for ~3 years in hopes of extending it to build an
unmodified vanilla kernel, but was stretched too thin between too many projects:

https://landley.net/hg/tinycc

My proposed sequel project was gluing qemu's tcg (tiny code generator) to tcc's
front-end to get a maybe 150k line C compiler that could target every hardware
platform qemu supports:

https://landley.net/qcc/

But again, stretched too thin between too many other projects, didn't have the
spoons.

By the way, part of my motivation for all that was "countering trusting trust":

http://lists.landley.net/pipermail/toybox-landley.net/2020-July/011898.html

And part is minix and xv6 are restricted systems which explicitly reject
anything that would make them load bearing for real world usage (the patch
backlog on comp.os.minix from people who TRIED and couldn't get their patches
merged is how Linux went from 0.0.1 to 0.9.5 so fast).

It would be nice if people could study the base for real world usage in an
isolated reproducible context with minimal circular dependencies. (If you can't
reproduce it from first principles in a laboratory environment, what you're
doing isn't science.)

There was a time where Linux straddled that divide, but these days it seems more
likely that https://www.youtube.com/watch?v=Ce1pMlZO_mI or similar will "grow
legs" and become load bearing than that linux-kernel will get taught in high
schools.

>> See https://lkml.iu.edu/hypermail/linux/kernel/2211.0/02589.html
> 
> I haven't seen a changelog in a while, which provides so much useless
> information and lacks any content which justifies and documents the
> proposed change.

You should get out more.

You guys didn't consider "reduce gratuitous build dependencies" to be inherently
useful back when it was perl removal either. That's why I maintain my own
patches. I expect I'll probably switch to a simpler kernel when you finally make
it so nobody can build the linux without C _and_ rust compilers, which doesn't
seem far off. But we'll see...

>>  Kbuild                    |   7 ++-
>>  kernel/time/mktimeconst.c | 111 ++++++++++++++++++++++++++++++++++++
>>  kernel/time/timeconst.bc  | 117 --------------------------------------
> 
> Clearly you provided evidence that the output of both tools is identical

I checked that way back when, but producing exactly identical output didn't get
it merged.

This time I think I just read through the changelog on the bc tool and made the
minimal changes necessary to produce identical kernel binaries on all the
https://landley.net/toybox/downloads/binaries/mkroot/0.8.9/ targets but it was a
while ago now...

> and because you decided to reorder the defines it's not even verifyable
> with diff.
> 
> But I don't even need diff to figure out that the results are not
> identical:
> 
> # grep -c '#define' orig.h
> 25
> 
> # grep -c '#define' patched.h
> 31
> 
> Which means this adds 6 more unused defines to the already 8 unused
> defines of today.

It produces consistent output for each of the units. I wasn't trying to
determine why the existing code was producing unused defines, or why it
reordered the defines since I wrote the first version. That's social context I
don't have, I'm not a full-time member of the kernel clique.

> You clearly spent a lot of time to make this palatable to the people who
> are responsible for this code.

After 14 years? Not so much. Various people pick things up from linux-kernel...
and then email me privately. Sigh.

> That said, I'm not completely opposed to get rid of the bc dependency,
> but if you want to sell this, then follow the documented process and
> present it in a form which is acceptable.

I've been maintaining this particular patch on and off long enough it'll be
eligible to vote soon. Posting it to linux-kernel means other people with their
own dirty trees can pick it up, and where lawyers and/or a judge who want to
give me grief can be easily shown "I delivered it to the kernel community in the
community's official channel, not just once but multiple times, collated and run
through their get_maintainer.pl and check_patch.pl, and _they_ chose not to
merge it for their own reasons"...

Getting it merged, so I could stop, would be nice. So would winning the lottery.
I'm happy to make changes if you think they'll accomplish anything? But I've
done that before. Here's v4 of the DEVTMPFS_MOUNT patch, for example:

https://lkml.iu.edu/hypermail/linux/kernel/2005.1/09399.html

Rinse repeat, same old same old...

> Thanks,
> 
>         tglx

Rob
