Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7C869FAAD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjBVSBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjBVSBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:01:37 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4673741B63
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:01:23 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id bf15so3920702iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQaxwkGu19zmG1oPaifd/2cU8eOnGHG3LsAaYpWY8WI=;
        b=x3Bnnkrch7R+fasmAk2g3UWj7eHzJpoh0LKROHA1hkaLZbgBtD1X3sZ6GgUe8UT178
         Wa8lXgs7al7aAH8x18ktLvvyvD7TVWdcDebUB2D80Hp88V1fGb896//9Rr63c+3dEv/y
         QE7UMvvzYUgMvQZkK09XaIxTiR86qPxl/UKK6qr27gX8Wx9OtmV+J49BiR5sf/b/BZkP
         IIhsZg74119mXCRuZRhCNu+Bcxkh1mxOFMbNXCSQQBNbl2VAwtgmhCoweMPYvZAFTkeT
         zX0B3464DzPJL6WCcVQBiAa/tuoc976jDqaZTTRZTNdHrQC4Ci039Y4k581O56HfKDcW
         6wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQaxwkGu19zmG1oPaifd/2cU8eOnGHG3LsAaYpWY8WI=;
        b=VizZYrQ1OrAaxpjby7nhflnDN5HE/IKh4vuvO7/ajGtH1XXWXMvfKSwAaniFJWpTZD
         gcnBryrJ+ULsFRWc4oE9hgoPgjFbXkbK6vuT0UTYAQSM90xOIDcjnufh6urC8Y2kPI1+
         +rYKSU7RytfwG60hdX8QoBlPYjeUGVBPCFbtDqp7RTlUzIqdYBYqw/kWHgMcuacq+XDF
         ETS6+4HT4JdcizcZuZv8rXBcwzIDUmf/7gG/S2DLDV2/tqxKSecN2wq8ACGLRy4t76oy
         +nVF1rdcCwbQjZWPkf6kIA28RkIGdlYxFvLbYEBoqpcxrpJJQZzcig0GpciiLE5dB6VH
         xFdg==
X-Gm-Message-State: AO0yUKVVl9idXtHdcC6NVXLdhvzY4eQAFUziiSlkRxTuCovFWKHoIN6C
        aawnJk/QL8Y7XCIcXqd1rNXceg==
X-Google-Smtp-Source: AK7set+SMqFmi66tovIROdq9i+VlUY2fAVI4/xHK+2PfXY1lkVh+l1xxP6iV9F/JFZDpBChCP0mzTw==
X-Received: by 2002:a6b:db10:0:b0:74c:9d31:3190 with SMTP id t16-20020a6bdb10000000b0074c9d313190mr283263ioc.4.1677088882200;
        Wed, 22 Feb 2023 10:01:22 -0800 (PST)
Received: from [172.16.32.78] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id t11-20020a02ccab000000b003c2bca015d8sm2518851jap.140.2023.02.22.10.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 10:01:21 -0800 (PST)
Message-ID: <aee2c147-2993-c35e-436e-0d89a0e5aa8b@landley.net>
Date:   Wed, 22 Feb 2023 12:14:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/5] X86-64 should not uniquely require a third ELF
 package to build.
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <e184ece9-2779-675e-0c84-f0a62413c7fd@landley.net> <87wn4amx45.ffs@tglx>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <87wn4amx45.ffs@tglx>
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

On 2/21/23 17:12, Thomas Gleixner wrote:
> Rob!

Thomas!

> On Tue, Feb 21 2023 at 14:56, Rob Landley wrote:
> 
> The subject line is not compliant to documentation. Please read and
> follow Documentation/process/* especially submitting-patches.rst and
> maintainer-tip.rst

I've read them multiple times over the years, but I'm not good at remembering
extensive bureaucracy over long periods. Let's see...

Are you complaining it doesn't have "RESEND"? These apply to 6.2, not 6.1, and a
couple things got tweaked. What's the "RESEND" threshold?

Or is this a "subsystem:" prefix thing where I have to guess what subsystem the
top level makefile or mktimeconst fall under? Is "init" a subsystem?

$ grep -i subsystem MAINTAINERS  | wc
     85     286    2216
$ grep -i subsystem MAINTAINERS  | grep -i init
$

Apparently not. I would have thought get_maintainer.pl would emit this sort of
info if it's important, but I guess I'm remembering back when Linux had
hobbyists who worked on things that didn't require justifying the time on a
spreadsheet to their boss in a budget allocation meeting before modifying any
code...

>> x86-64 is the only architecture that can't compile without an extra
>> ELF library installed on the host. (The kernel already has multiple ELF
>> parse implementations built-in, so requiring another one is questionable
>> at best.)
> 
> How are ELF parsers in the kernel itself related to a build requirement
> for a tool, which is part of the kernel build process?

The project already has multiple instances of code that traverses ELF data
structures. A definition of "code reuse" that pulls in an additional build
dependency which the project was not already using is just "code use" without a
"re".

My response was "this doesn't need to be done at all, it's just being used for
an optional stack unwinder, and even if you _want_ a stack unwinder there are
multiple other implementations without this dependency".

They just tangled up the kconfig plubmbing so even when nothing uses it, it
still tries to build the tool it won't run. If I'd tried to FIX the tool,
factoring out existing ELF code so it could be built on the host and used at
build time might have made sense. But the thing it's being used to do is not a
thing I need on the systems I'm building.

> Next time you ask for removal of perl, python or whatever the kernel
> requires to build.

Kernel doesn't require python to build, my perl removal series got merged 10
years ago, and other people have sent follow-up perl removal patches since.

>> You can switch it back on in menuconfig if you want to, this
>> just stops it being mandatory.
> 
> How do you switch on CONFIG_HAVE_OBJTOOL in menuconfig?
> 
> config HAVE_OBJTOOL
>         bool
> 
> There is no knob.

Sigh, I traced through all this stuff at one point. It's been a few releases
since then (and the symbol got renamed), and it looks like it's developed some
more dependencies off of it in kernel/trace/Kconfig.

Alright, how about this:

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..70923305d596 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -243,7 +243,8 @@ config X86
        select HAVE_NOINSTR_HACK                if HAVE_OBJTOOL
        select HAVE_NMI
        select HAVE_NOINSTR_VALIDATION          if HAVE_OBJTOOL
-       select HAVE_OBJTOOL                     if X86_64
+       select HAVE_OBJTOOL                     if X86_64 && \
+         $(success,echo "#include <gelf.h>" | $(HOSTCC) -xc -o /dev/null -c -)
        select HAVE_OPTPROBES
        select HAVE_PCSPKR_PLATFORM
        select HAVE_PERF_EVENTS

Actually TEST if the build environment has it, and set the symbol appropriately.

Would that with "test for optional build dependency" work? I'm aware people want
to use this plumbing for more thorough spectre/meltdown style mitigations, but
Linux has CONFIG_MULTIUSER which can remove support for non-root users. (I'm off
at the embedded end of things: we're weird.)

>> See https://lkml.iu.edu/hypermail/linux/kernel/2110.3/00402.html
>> and https://lkml.iu.edu/hypermail/linux/kernel/2110.3/00278.html
> 
> Please use https://lore.kernel.org/lkml/ links.

Yeah, check_patch.pl complained about that too. Google's getting unreliable
enough it's not always easy to map between them, but I'll put it on the todo
list for the 6.3 repost of the series...

>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 3604074a878b..b63510d79baf 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -243,7 +243,6 @@ config X86
>>  	select HAVE_NOINSTR_HACK		if HAVE_OBJTOOL
>>  	select HAVE_NMI
>>  	select HAVE_NOINSTR_VALIDATION		if HAVE_OBJTOOL
>> -	select HAVE_OBJTOOL			if X86_64
> 
> This prevents runtime features, optimizations, mitigations and build
> time validations rom being selected as you can see from your patch
> context.
> 
> Just to be clear: objtool is mandatory for x86_64 builds.

Because without this patch it's forced on, yes. Works fine without it in my testing?

The llvm guys built a whole compiler to get away from GPLv3 and
https://sourceware.org/elfutils is GPLv3, which is not _my_ motivation for
trying to avoid it, but I can see it being "of interest". (If the goal is to
push people away from x86-64 faster...)

No other architecture I tested had this requirement. I admit I'm only building
arm, arm64, x86, x86-64, m68k, mips, ppc32, ppc64, s390x, and superh kernels at
the moment. I'm only doing a userspace version of hexagon because they didn't
have qemu-system-hexagon working last I poked Taylor Simpson so I'd have nothing
to test the kernel on. Musl-libc's xtensa support is not just an out of tree
fork but _very_stale_ (the one I have, anyway). Musl doesn't support
alpha/arc/csky/itanic/mips-looongarch/nios2/parisc/sparc yet. Microblaze
binaries segfault in the ELF _start code for some reason (I should track down
why). I'm halfway to a working cortex-m qemu config and need to get back to that
(qemu SHOULD have a decent board, there's like 5 options now). Building or1k is
on the todo list...

> git grep 'select HAVE_OBJTOOL' will tell you that your claim about
> x86_64 being the only architecture is slightly wrong.

There's two hits, and the other is PPC32, which was building fine for me without
this patch last I checked?

Ah, commit e52ec98c5ab1 from 3 months ago. So 6.1 built fine without it but 6.2
also requires... no, hang on, I test built 6.2 with this patch series more than
once, and my patches don't modify the arch/powerpc directory? I still have the
binaries:

$ ./run-qemu.sh
...
Kernel memory protection not selected by kernel config.
Run /init as init process
Type exit when done.
# cat /proc/version
Linux version 6.2.0 (landley@driftwood) (powerpc-linux-musl-cc (GCC) 9.4.0, GNU
ld (GNU Binutils) 2.33.1) #1 Tue Feb 21 14:07:21 CST 2023
# cat /proc/cpuinfo
processor	: 0
cpu		: 740/750
clock		: 266.000000MHz
revision	: 3.1 (pvr 0008 0301)
bogomips	: 33.20

timebase	: 16603616
platform	: PowerMac
model		: Power Macintosh
machine		: Power Macintosh
motherboard	: AAPL,PowerMac G3 MacRISC
detected as	: 49 (PowerMac G3 (Silk))
pmac flags	: 00000000
pmac-generation	: OldWorld
Memory		: 256 MB
# file /bin/toybox
/bin/toybox: ELF executable, 32-bit MSB ppc, static, stripped


That's 6.2, G3 was 7xx series which is 32 bit... Yup, powerpc 32 bit built and
ran fine without this. I haven't got libelf-dev installed on my laptop, so it
CAN'T have required it,the build would break if it tried...

Which other architecture build breaks for you without libelf-dev installed?

> Thanks,
> 
>         tglx

Rob
