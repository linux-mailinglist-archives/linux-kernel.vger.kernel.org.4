Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEEB628BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbiKNWRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbiKNWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:17:10 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0DC17428
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:16:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n12so31734619eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H138E2sjPyDIFkhECrponhBdoScvcXvy7KP75MGfWR0=;
        b=e5SFkDDJH4Rn2mBbVf4SYq+7c+A2qurn3vkEH+g3qRyJ76V/s4ZugIP4MzUVXFeqqj
         h3AnWLCGQQd7PuAXcWPUSrCYMl5gS+92Dm7j8lGKMr9uBkUm4QlE9NTX+Eh9+OiOk5pz
         Yi8FK2SCTK2nBzR957iFa4MR0DCyp70qYO+x5FgcwPxiYdbThvzgd0QGrTKxHjoLWQ54
         oYPRVuEHBfh6t67E3d8zmimC7+99OqP02dbD7ufos8ocR0kUis43p35I/OKvVOVmwp5q
         tToRPiDkarki/leB+SoxbyB/CPFGMOiVVFozOjgdBAKpxSXi37kQk2DtkhRRCf2AeWcn
         segA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H138E2sjPyDIFkhECrponhBdoScvcXvy7KP75MGfWR0=;
        b=2kUfMmEReApe2oTjOcwomr6zHXf2nWprCVh0a3udRR61MqrcwafAGHuOk/byVZ+OTo
         OaeIyWSQf58Q82VUErefEK96a6N+8pPEG7r6QmfH236Edci3rX8+1t2d1Uby4T2Kwwiz
         1HmvIvND/FXmNRQR8mAJTwd9BJmCNit70mQckncKI4YcRxRmuncUdsRYEQg0zJelMaRa
         zl8VcGS2WZty5j3rXLQlTECBvRdAk5BygOluM6LowRExcIihZYgrBTlNpfQne15YAJvs
         L85cOlTTCL7lC2f7xjGrJ40L8VEkhiVm0ZNcNjOrgdr8OjByCOSSwX06AW3MESG88Ths
         xbCA==
X-Gm-Message-State: ANoB5pm8Iut8Pk9fPo39L/vHzfVORs6BekK1iF51V87LYx2fYF7AicHd
        TBAT3ILBZC72a3mt4B/eWl0=
X-Google-Smtp-Source: AA0mqf4dd9pviksDpNyQ7A0XPxDp4qP5oZk/TW1pGSayrmyBGOLHs/1Og3M+HjE9j1BPbclh8JSQcA==
X-Received: by 2002:a17:906:1441:b0:7ad:b97e:283a with SMTP id q1-20020a170906144100b007adb97e283amr11438591ejc.567.1668464216574;
        Mon, 14 Nov 2022 14:16:56 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:dc32:99d6:97a8:f82? (2a02-a466-68ed-1-dc32-99d6-97a8-f82.fixed6.kpn.net. [2a02:a466:68ed:1:dc32:99d6:97a8:f82])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709067d9100b0074134543f82sm4734522ejo.90.2022.11.14.14.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 14:16:56 -0800 (PST)
Message-ID: <1dbe4ea5-837f-e1a6-6415-bdc0aee96fc4@gmail.com>
Date:   Mon, 14 Nov 2022 23:16:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] x86/stackprotector/32: Make the canary into a
 regular percpu variable
Content-Language: en-US
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>
References: <cover.1613243844.git.luto@kernel.org>
 <c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org>
 <YzWj9zjTJI3RCDf2@smile.fi.intel.com> <YzWpob6MOf1SJr5I@smile.fi.intel.com>
 <c554f363-05db-b185-1a7d-ce8ae27890da@gmail.com>
 <d1f76ef7-2d91-2be2-285c-8dbd208239a2@gmail.com>
 <Y2u+J5EEyxRuusSr@smile.fi.intel.com>
 <CAMzpN2iEQVQWsPX58ONxaH=gkUACtq1t2OpozZ55+f=Ub+AwyQ@mail.gmail.com>
 <d0d8d5ea-a752-d082-d8fe-68ff888afb59@gmail.com>
 <CAMzpN2gYdwLmeqh+=MAkA2ALaB1PK_YD_5tpZMA09M6NCrvOjg@mail.gmail.com>
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <CAMzpN2gYdwLmeqh+=MAkA2ALaB1PK_YD_5tpZMA09M6NCrvOjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Op 14-11-2022 om 22:43 schreef Brian Gerst:
> On Thu, Nov 10, 2022 at 2:36 PM Ferry Toth <fntoth@gmail.com> wrote:
>> Hi,
>>
>> Op 09-11-2022 om 23:33 schreef Brian Gerst:
>>> On Wed, Nov 9, 2022 at 9:50 AM Andy Shevchenko
>>> <andriy.shevchenko@intel.com> wrote:
>>>> On Fri, Sep 30, 2022 at 11:18:51PM +0200, Ferry Toth wrote:
>>>>> Op 30-09-2022 om 22:30 schreef Ferry Toth:
>>>>>> Op 29-09-2022 om 16:20 schreef Andy Shevchenko:
>>>>>>> On Thu, Sep 29, 2022 at 04:56:07PM +0300, Andy Shevchenko wrote:
>>>>>>>> On Sat, Feb 13, 2021 at 11:19:44AM -0800, Andy Lutomirski wrote:
>>>>>>>>> On 32-bit kernels, the stackprotector canary is quite nasty -- it is
>>>>>>>>> stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
>>>>>>>>> percpu storage.  It's even nastier because it means that whether %gs
>>>>>>>>> contains userspace state or kernel state while running kernel code
>>>>>>>>> depends on whether stackprotector is enabled (this is
>>>>>>>>> CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
>>>>>>>>> that segment selectors work.  Supporting both variants is a
>>>>>>>>> maintenance and testing mess.
>>>>>>>>>
>>>>>>>>> Merely rearranging so that percpu and the stack canary
>>>>>>>>> share the same segment would be messy as the 32-bit percpu address
>>>>>>>>> layout isn't currently compatible with putting a variable at a fixed
>>>>>>>>> offset.
>>>>>>>>>
>>>>>>>>> Fortunately, GCC 8.1 added options that allow the stack canary to be
>>>>>>>>> accessed as %fs:__stack_chk_guard, effectively turning it
>>>>>>>>> into an ordinary
>>>>>>>>> percpu variable.  This lets us get rid of all of the code to
>>>>>>>>> manage the
>>>>>>>>> stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.
>>>>>>>>>
>>>>>>>>> (That name is special.  We could use any symbol we want for the
>>>>>>>>>     %fs-relative mode, but for CONFIG_SMP=n, gcc refuses to
>>>>>>>>> let us use any
>>>>>>>>>     name other than __stack_chk_guard.)
>>>>>>>>>
>>>>>>>>> This patch forcibly disables stackprotector on older compilers that
>>>>>>>>> don't support the new options and makes the stack canary into a
>>>>>>>>> percpu variable.  The "lazy GS" approach is now used for all 32-bit
>>>>>>>>> configurations.
>>>>>>>>>
>>>>>>>>> This patch also makes load_gs_index() work on 32-bit kernels.  On
>>>>>>>>> 64-bit kernels, it loads the GS selector and updates the user
>>>>>>>>> GSBASE accordingly.  (This is unchanged.)  On 32-bit kernels,
>>>>>>>>> it loads the GS selector and updates GSBASE, which is now
>>>>>>>>> always the user base.  This means that the overall effect is
>>>>>>>>> the same on 32-bit and 64-bit, which avoids some ifdeffery.
>>>>>>>> This patch broke 32-bit boot on Intel Merrifield
>>>>>>>>
>>>>>>>> git bisect start
>>>>>>>> # good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
>>>>>>>> git bisect good 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
>>>>>>>> # bad: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
>>>>>>>> git bisect bad 62fb9874f5da54fdb243003b386128037319b219
>>>>>>>> # bad: [85f3f17b5db2dd9f8a094a0ddc665555135afd22] Merge branch
>>>>>>>> 'md-fixes' of
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/song/md into
>>>>>>>> block-5.13
>>>>>>>> git bisect bad 85f3f17b5db2dd9f8a094a0ddc665555135afd22
>>>>>>>> # good: [ca62e9090d229926f43f20291bb44d67897baab7] Merge tag
>>>>>>>> 'regulator-v5.13' of
>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
>>>>>>>> git bisect good ca62e9090d229926f43f20291bb44d67897baab7
>>>>>>>> # bad: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag
>>>>>>>> 'drm-next-2021-04-28' of git://anongit.freedesktop.org/drm/drm
>>>>>>>> git bisect bad 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
>>>>>>>> # good: [49c70ece54b0d1c51bc31b2b0c1070777c992c26]
>>>>>>>> drm/amd/display: Change input parameter for set_drr
>>>>>>>> git bisect good 49c70ece54b0d1c51bc31b2b0c1070777c992c26
>>>>>>>> # good: [0b276e470a4d43e1365d3eb53c608a3d208cabd4] media: coda:
>>>>>>>> fix macroblocks count control usage
>>>>>>>> git bisect good 0b276e470a4d43e1365d3eb53c608a3d208cabd4
>>>>>>>> # bad: [c6536676c7fe3f572ba55842e59c3c71c01e7fb3] Merge tag
>>>>>>>> 'x86_core_for_v5.13' of
>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>>>> git bisect bad c6536676c7fe3f572ba55842e59c3c71c01e7fb3
>>>>>>>> # good: [d1466bc583a81830cef2399a4b8a514398351b40] Merge branch
>>>>>>>> 'work.inode-type-fixes' of
>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
>>>>>>>> git bisect good d1466bc583a81830cef2399a4b8a514398351b40
>>>>>>>> # good: [fafe1e39ed213221c0bce6b0b31669334368dc97] Merge tag
>>>>>>>> 'afs-netfs-lib-20210426' of
>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
>>>>>>>> git bisect good fafe1e39ed213221c0bce6b0b31669334368dc97
>>>>>>>> # bad: [b1f480bc0686e65d5413c035bd13af2ea4888784] Merge branch
>>>>>>>> 'x86/cpu' into WIP.x86/core, to merge the NOP changes & resolve
>>>>>>>> a semantic conflict
>>>>>>>> git bisect bad b1f480bc0686e65d5413c035bd13af2ea4888784
>>>>>>>> # bad: [0c925c61dae18ee3cb93a61cc9dd9562a066034d]
>>>>>>>> x86/tools/insn_decoder_test: Convert to insn_decode()
>>>>>>>> git bisect bad 0c925c61dae18ee3cb93a61cc9dd9562a066034d
>>>>>>>> # bad: [514ef77607b9ff184c11b88e8f100bc27f07460d]
>>>>>>>> x86/boot/compressed/sev-es: Convert to insn_decode()
>>>>>>>> git bisect bad 514ef77607b9ff184c11b88e8f100bc27f07460d
>>>>>>>> # bad: [9e761296c52dcdb1aaa151b65bd39accb05740d9] x86/insn:
>>>>>>>> Rename insn_decode() to insn_decode_from_regs()
>>>>>>>> git bisect bad 9e761296c52dcdb1aaa151b65bd39accb05740d9
>>>>>>>> # bad: [d0962f2b24c99889a386f0658c71535f56358f77] x86/entry/32:
>>>>>>>> Remove leftover macros after stackprotector cleanups
>>>>>>>> git bisect bad d0962f2b24c99889a386f0658c71535f56358f77
>>>>>>>> # bad: [3fb0fdb3bbe7aed495109b3296b06c2409734023]
>>>>>>>> x86/stackprotector/32: Make the canary into a regular percpu
>>>>>>>> variable
>>>>>>>> git bisect bad 3fb0fdb3bbe7aed495109b3296b06c2409734023
>>>>>>>> # first bad commit: [3fb0fdb3bbe7aed495109b3296b06c2409734023]
>>>>>>>> x86/stackprotector/32: Make the canary into a regular percpu
>>>>>>>> variable
>>>>>> With the bad commit the last words in dmesg are:
>>>>>>
>>>>>> mem auto-init: stack:off, heap alloc:off, heap free:off
>>>>>> Initializing HighMem for node 0 (00036ffe:0003f500)
>>>>>> Initializing Movable for node 0 (00000000:00000000)
>>>>>> Checking if this processor honours the WP bit even in supervisor
>>>>>> mode...Ok.
>>>>>> Memory: 948444K/1004124K available (12430K kernel code, 2167K rwdata,
>>>>>> 4948K rodata, 716K init, 716K bss, 55680K reserved, 0K cma-reserved,
>>>>>> 136200K highmem)
>>>>>> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
>>>>>> trace event string verifier disabled
>>>>>> Dynamic Preempt: voluntary
>>>>>> rcu: Preemptible hierarchical RCU implementation.
>>>>>> rcu:     RCU event tracing is enabled.
>>>>>> rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
>>>>>>    Trampoline variant of Tasks RCU enabled.
>>>>>>    Tracing variant of Tasks RCU enabled.
>>>>>> rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
>>>>>> rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
>>>>>> NR_IRQS: 2304, nr_irqs: 512, preallocated irqs: 0
>>>>>>
>>>>>> without the bad commit dmesg continues:
>>>>>>
>>>>>> random: get_random_bytes called from start_kernel+0x492/0x65a with
>>>>>> crng_init=0
>>>>>> Console: colour dummy device 80x25
>>>>>> printk: console [tty0] enabled
>>>>>> printk: bootconsole [uart0] disabled
>>>>>>
>>>>>> ....
>>>>>>
>>>>>>>> Any suggestions how to fix are welcome!
>>>>>>>>
>>>>> Interesting. I added the following fragment to the kernel config:
>>>>>
>>>>> # CONFIG_STACKPROTECTOR is not set
>>>>>
>>>>> And this resolves the boot issue (tested with v5.17 i686 on Intel
>>>>> Merrifield)
>>>> I'm not sure that's the correct approach.
>> I didn't intend as a resolution, merely as a workaround. And since
>> revert was not possible, as proof issue is localized in stack protector.
>>>> Any answer from the Andy Lutomirski?
>>>>
>>>> And in general to x86 maintainers, do we support all features on x86 32-bit? If
>>>> no, can it be said explicitly, please?
>>> What compiler version are you using?
>> I built with Yocto Honister which builds it's own cross-compiler gcc
>> 11.2. For completeness:
>>
>> root@yuna:~# uname -a
>> Linux yuna 5.17.0-edison-acpi-standard #1 SMP PREEMPT Sun Mar 20
>> 20:14:17 UTC 2022 i686 i686 i386 GNU/Linux
>>
>> root@yuna:~# cat /proc/version
>> Linux version 5.17.0-edison-acpi-standard (oe-user@oe-host)
>> (i686-poky-linux-gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.37.20210721)
>> #1 SMP PREEMPT Sun Mar 20 20:14:17 UTC 2022
>>
>> root@yuna:~# cat /etc/os-release
>> ID=poky-edison
>> NAME="Poky (Yocto Project Reference Distro)"
>> VERSION="3.4.4 (honister)"
>> VERSION_ID=3.4.4
>> PRETTY_NAME="Poky (Yocto Project Reference Distro) 3.4.4 (honister)"
>>
>>> --
>>> Brian Gerst
> What exactly happens when it fails (hang/reboot/oops)?

It just hangs. Rebooting into another kernel with CONFIG_STACKPROTECTOR 
not set and displaying journal of the failed boot show the last words 
mentioned above.

> Does removing the call to boot_init_stack_canary() in init/main.c fix
> the problem?
I will try tomorrow.
> --
> Brian Gerst
