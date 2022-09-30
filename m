Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60ED5F14A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiI3VS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiI3VS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:18:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CB816F84E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:18:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bj12so11489292ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=f9/RYw7uL/Ytrr3YvawMlFxPSoq04wqzD0xQGZhQqWw=;
        b=C9JGnTTq7kyAtYVKqyG2eVWedSL1hIa90lvqeLy3b53OcIHMB1mKc53NpNLqdtSrFC
         XTaiKHrMz1JLK0J58JjJIcV1VuycriLAPqsK/Z5aJao991fy/tQYbDF83XsRJaUDPoEN
         b0IsG/DPDZ8IsWFZyuzkhpspiEx18SJscZc60T97kWUI7fRWUKUgcQ42PK8UWWsuchj/
         eV0iLZu56xRZZQLRo3n9mEo1pg17UORTEj+NLKw3rvAW/Avgs8BQBwaUab6rBHG2W3nU
         +FHmtw5kENVAQcKXf5hyBd/9ED7ne+W4f+N97hNZa0zUUJkidiDqbAk7Fw/BKR5MRmyD
         GJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=f9/RYw7uL/Ytrr3YvawMlFxPSoq04wqzD0xQGZhQqWw=;
        b=nQ5BOZd9DBX5o1YgDjyf2g56AszHjw1oLO51r3SnhSGIyliHaQhnbL2jQPUwYSlHMb
         6vpXa0UsA0ZuA8N4h40fW19k6uMUz8kGAoWmgM+u8xuWNy7HHvLn9/5sBA8CjkYBgYTc
         YVORsnyOVIvxG7SIb7Rq7i0lgCLuGkV6Es6tMLnqZ5xZQdTVEziJsDN6SARB4bz2ik/s
         72kyGbV/wHSSZXFLmwvhXOCmyhC2NZQCpvoObCg4zlULo/c2ETla7WFitR0PZllJbMlj
         uzqksIbuKi0zb89fR3EhsO795uKSdX6Vfuoj6KB38MRQX5B0Deqo2rMM5BF5xKBlo2R6
         V0uw==
X-Gm-Message-State: ACrzQf0588VEC97FN2kkhcdhAf9/R3RhFmUp8U2YwyS9EN7KYIYFtGcF
        80qNEdCw30FNCfDrurpwlek=
X-Google-Smtp-Source: AMsMyM4cdNNUQrHYDHeSOk2CVDCgPz2wGrd3+TGDAHO1c2i7i0yz7cnLIsZU1P32RPcwYGULeKKNKw==
X-Received: by 2002:a17:907:8691:b0:783:645d:a4aa with SMTP id qa17-20020a170907869100b00783645da4aamr7817537ejc.473.1664572733008;
        Fri, 30 Sep 2022 14:18:53 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:3f69:b27e:c860:ea20? (2a02-a466-68ed-1-3f69-b27e-c860-ea20.fixed6.kpn.net. [2a02:a466:68ed:1:3f69:b27e:c860:ea20])
        by smtp.gmail.com with ESMTPSA id u7-20020a056402064700b0044e7d69091asm2241698edx.85.2022.09.30.14.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 14:18:52 -0700 (PDT)
Message-ID: <d1f76ef7-2d91-2be2-285c-8dbd208239a2@gmail.com>
Date:   Fri, 30 Sep 2022 23:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/2] x86/stackprotector/32: Make the canary into a
 regular percpu variable
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brian Gerst <brgerst@gmail.com>, Joerg Roedel <jroedel@suse.de>
References: <cover.1613243844.git.luto@kernel.org>
 <c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org>
 <YzWj9zjTJI3RCDf2@smile.fi.intel.com> <YzWpob6MOf1SJr5I@smile.fi.intel.com>
 <c554f363-05db-b185-1a7d-ce8ae27890da@gmail.com>
In-Reply-To: <c554f363-05db-b185-1a7d-ce8ae27890da@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Op 30-09-2022 om 22:30 schreef Ferry Toth:
> Hi,
>
> Op 29-09-2022 om 16:20 schreef Andy Shevchenko:
>> On Thu, Sep 29, 2022 at 04:56:07PM +0300, Andy Shevchenko wrote:
>>> +Cc: Ferry
>>>
>>> On Sat, Feb 13, 2021 at 11:19:44AM -0800, Andy Lutomirski wrote:
>>>> On 32-bit kernels, the stackprotector canary is quite nasty -- it is
>>>> stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
>>>> percpu storage.  It's even nastier because it means that whether %gs
>>>> contains userspace state or kernel state while running kernel code
>>>> depends on whether stackprotector is enabled (this is
>>>> CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
>>>> that segment selectors work.  Supporting both variants is a
>>>> maintenance and testing mess.
>>>>
>>>> Merely rearranging so that percpu and the stack canary
>>>> share the same segment would be messy as the 32-bit percpu address
>>>> layout isn't currently compatible with putting a variable at a fixed
>>>> offset.
>>>>
>>>> Fortunately, GCC 8.1 added options that allow the stack canary to be
>>>> accessed as %fs:__stack_chk_guard, effectively turning it into an 
>>>> ordinary
>>>> percpu variable.  This lets us get rid of all of the code to manage 
>>>> the
>>>> stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.
>>>>
>>>> (That name is special.  We could use any symbol we want for the
>>>>   %fs-relative mode, but for CONFIG_SMP=n, gcc refuses to let us 
>>>> use any
>>>>   name other than __stack_chk_guard.)
>>>>
>>>> This patch forcibly disables stackprotector on older compilers that
>>>> don't support the new options and makes the stack canary into a
>>>> percpu variable.  The "lazy GS" approach is now used for all 32-bit
>>>> configurations.
>>>>
>>>> This patch also makes load_gs_index() work on 32-bit kernels.  On
>>>> 64-bit kernels, it loads the GS selector and updates the user
>>>> GSBASE accordingly.  (This is unchanged.)  On 32-bit kernels,
>>>> it loads the GS selector and updates GSBASE, which is now
>>>> always the user base.  This means that the overall effect is
>>>> the same on 32-bit and 64-bit, which avoids some ifdeffery.
>>> This patch broke 32-bit boot on Intel Merrifield
>>>
>>> git bisect start
>>> # good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
>>> git bisect good 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
>>> # bad: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
>>> git bisect bad 62fb9874f5da54fdb243003b386128037319b219
>>> # bad: [85f3f17b5db2dd9f8a094a0ddc665555135afd22] Merge branch 
>>> 'md-fixes' of 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.13
>>> git bisect bad 85f3f17b5db2dd9f8a094a0ddc665555135afd22
>>> # good: [ca62e9090d229926f43f20291bb44d67897baab7] Merge tag 
>>> 'regulator-v5.13' of 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
>>> git bisect good ca62e9090d229926f43f20291bb44d67897baab7
>>> # bad: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag 
>>> 'drm-next-2021-04-28' of git://anongit.freedesktop.org/drm/drm
>>> git bisect bad 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
>>> # good: [49c70ece54b0d1c51bc31b2b0c1070777c992c26] drm/amd/display: 
>>> Change input parameter for set_drr
>>> git bisect good 49c70ece54b0d1c51bc31b2b0c1070777c992c26
>>> # good: [0b276e470a4d43e1365d3eb53c608a3d208cabd4] media: coda: fix 
>>> macroblocks count control usage
>>> git bisect good 0b276e470a4d43e1365d3eb53c608a3d208cabd4
>>> # bad: [c6536676c7fe3f572ba55842e59c3c71c01e7fb3] Merge tag 
>>> 'x86_core_for_v5.13' of 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>> git bisect bad c6536676c7fe3f572ba55842e59c3c71c01e7fb3
>>> # good: [d1466bc583a81830cef2399a4b8a514398351b40] Merge branch 
>>> 'work.inode-type-fixes' of 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
>>> git bisect good d1466bc583a81830cef2399a4b8a514398351b40
>>> # good: [fafe1e39ed213221c0bce6b0b31669334368dc97] Merge tag 
>>> 'afs-netfs-lib-20210426' of 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
>>> git bisect good fafe1e39ed213221c0bce6b0b31669334368dc97
>>> # bad: [b1f480bc0686e65d5413c035bd13af2ea4888784] Merge branch 
>>> 'x86/cpu' into WIP.x86/core, to merge the NOP changes & resolve a 
>>> semantic conflict
>>> git bisect bad b1f480bc0686e65d5413c035bd13af2ea4888784
>>> # bad: [0c925c61dae18ee3cb93a61cc9dd9562a066034d] 
>>> x86/tools/insn_decoder_test: Convert to insn_decode()
>>> git bisect bad 0c925c61dae18ee3cb93a61cc9dd9562a066034d
>>> # bad: [514ef77607b9ff184c11b88e8f100bc27f07460d] 
>>> x86/boot/compressed/sev-es: Convert to insn_decode()
>>> git bisect bad 514ef77607b9ff184c11b88e8f100bc27f07460d
>>> # bad: [9e761296c52dcdb1aaa151b65bd39accb05740d9] x86/insn: Rename 
>>> insn_decode() to insn_decode_from_regs()
>>> git bisect bad 9e761296c52dcdb1aaa151b65bd39accb05740d9
>>> # bad: [d0962f2b24c99889a386f0658c71535f56358f77] x86/entry/32: 
>>> Remove leftover macros after stackprotector cleanups
>>> git bisect bad d0962f2b24c99889a386f0658c71535f56358f77
>>> # bad: [3fb0fdb3bbe7aed495109b3296b06c2409734023] 
>>> x86/stackprotector/32: Make the canary into a regular percpu variable
>>> git bisect bad 3fb0fdb3bbe7aed495109b3296b06c2409734023
>>> # first bad commit: [3fb0fdb3bbe7aed495109b3296b06c2409734023] 
>>> x86/stackprotector/32: Make the canary into a regular percpu variable
>
> With the bad commit the last words in dmesg are:
>
> mem auto-init: stack:off, heap alloc:off, heap free:off
> Initializing HighMem for node 0 (00036ffe:0003f500)
> Initializing Movable for node 0 (00000000:00000000)
> Checking if this processor honours the WP bit even in supervisor 
> mode...Ok.
> Memory: 948444K/1004124K available (12430K kernel code, 2167K rwdata, 
> 4948K rodata, 716K init, 716K bss, 55680K reserved, 0K cma-reserved, 
> 136200K highmem)
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> trace event string verifier disabled
> Dynamic Preempt: voluntary
> rcu: Preemptible hierarchical RCU implementation.
> rcu:     RCU event tracing is enabled.
> rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
>  Trampoline variant of Tasks RCU enabled.
>  Tracing variant of Tasks RCU enabled.
> rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> NR_IRQS: 2304, nr_irqs: 512, preallocated irqs: 0
>
> without the bad commit dmesg continues:
>
> random: get_random_bytes called from start_kernel+0x492/0x65a with 
> crng_init=0
> Console: colour dummy device 80x25
> printk: console [tty0] enabled
> printk: bootconsole [uart0] disabled
>
> ....
>
>>> Any suggestions how to fix are welcome!
>>>
Interesting. I added the following fragment to the kernel config:

# CONFIG_STACKPROTECTOR is not set

And this resolves the boot issue (tested with v5.17 i686 on Intel 
Merrifield)

>>> Configuration is based on in-tree i386_defconfig with some drivers 
>>> enabled
>>> on top (no core stuff was altered, but if you wish to check, it's here:
>>> https://github.com/andy-shev/linux/blob/eds-acpi/arch/x86/configs/i386_defconfig). 
>>>
>> For the record (and preventing some questions) the v6.0-rc7 still has 
>> this issue.
>>
>> I can't test reverts, because it's huge pile of changes in that area 
>> happened
>> for the last year or so.
>>
> I just tested this by reverting 3fb0fdb3 "x86/stackprotector/32: Make 
> the canary into a regular percpu variable" and it's prerequisite 
> d0962f2b "x86/entry/32: Remove leftover macros after stackprotector 
> cleanups" on top of v5.13 and indeed this resolves the boot issue.
>
> I can also confirm the 2 reverts will not apply on top of v6.0-rc7.
>
