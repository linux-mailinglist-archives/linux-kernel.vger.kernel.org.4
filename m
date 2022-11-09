Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97862369F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiKIWdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiKIWdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:33:39 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF23DEE9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:33:37 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a7-20020a056830008700b0066c82848060so198024oto.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 14:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vpeEubiWwwNFwQcrSeC6yw0yz3CnQygIJZgUJJVLPqE=;
        b=pDUxjGZK9WpyUnsVoHhHXBL6/CPgXb76h2ghmJxhJyfAZYEo22G9m0x6meGSs5qR0F
         nJqwKmOsbZHrIalNK70w+tY9OMZNjTtCbDwVYCxiskekuZk99hlBQzjRKP0TLF/EBxXi
         zkSpma+Pl+yjUO0hXvFrwHKgdd+xq+911sZCAo13G1ZR91X5YbER33MU55g7nQdQSV8C
         YCqhTt7ZP7dYONEyXk5LOMWcR60OjWWABExp6cJGW4mLFy+k2edixo06rfjw6shvsWl0
         q6pf/8WiPUM0KgWe0ArTFgL3dW625xAqz+12LBvo3o99exgNwPHHhWW0x4XpkGLJqf2+
         SXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpeEubiWwwNFwQcrSeC6yw0yz3CnQygIJZgUJJVLPqE=;
        b=06yRNVQBku6JghbZTd7yz2M6ZTqjKi0SLsJpGKpF9F2HQ5JoFpOx8SVPh5xK7o8IX0
         nvp9z0F0jBhLgbYYEUWSXTclXHw8lMaXLdOMPNpVdv4vJWOQ95d0ULFb8AtdP2rwC0Vi
         Uez6FufFpMuWWRaJGoVOX5MjJxDKrnUZAxG4fMV6QaTCnSD+VwyfLyD2KX7C7CE1oR4J
         rpOnNlr8Zh7iEUs6+GK5p5Kt6ybtLvGX9XGIxWfG7uKzmnBhUbXtl02Tm9+U99O+Vy2y
         LHyH9YvrS78Vp/FBFucsjyd7DKUd+fgj2zAHdnMpEBY+fARddX70+z4PsabbUSczHsH+
         qCPQ==
X-Gm-Message-State: ACrzQf0mXUWxWOUZwlQdnl/koOOYrVVPvfgkpjBAdyzYkx8ikRPySzP3
        757ceSbUveF+Eaxwa57Iu+ufKSyBm/YOhzyG0A==
X-Google-Smtp-Source: AMsMyM44GqWSFC/S74ZVs39/H2If6zP7zPhn0/KPMEkFROTIH/YSErOusLL0F+PW8v1mvG/n6qychz19Gw5th+Cx/0E=
X-Received: by 2002:a05:6830:148a:b0:66c:7b8c:4598 with SMTP id
 s10-20020a056830148a00b0066c7b8c4598mr19061890otq.81.1668033216883; Wed, 09
 Nov 2022 14:33:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613243844.git.luto@kernel.org> <c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org>
 <YzWj9zjTJI3RCDf2@smile.fi.intel.com> <YzWpob6MOf1SJr5I@smile.fi.intel.com>
 <c554f363-05db-b185-1a7d-ce8ae27890da@gmail.com> <d1f76ef7-2d91-2be2-285c-8dbd208239a2@gmail.com>
 <Y2u+J5EEyxRuusSr@smile.fi.intel.com>
In-Reply-To: <Y2u+J5EEyxRuusSr@smile.fi.intel.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 9 Nov 2022 17:33:24 -0500
Message-ID: <CAMzpN2iEQVQWsPX58ONxaH=gkUACtq1t2OpozZ55+f=Ub+AwyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/stackprotector/32: Make the canary into a
 regular percpu variable
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Ferry Toth <fntoth@gmail.com>, Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 9:50 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Sep 30, 2022 at 11:18:51PM +0200, Ferry Toth wrote:
> > Op 30-09-2022 om 22:30 schreef Ferry Toth:
> > > Op 29-09-2022 om 16:20 schreef Andy Shevchenko:
> > > > On Thu, Sep 29, 2022 at 04:56:07PM +0300, Andy Shevchenko wrote:
> > > > > On Sat, Feb 13, 2021 at 11:19:44AM -0800, Andy Lutomirski wrote:
> > > > > > On 32-bit kernels, the stackprotector canary is quite nasty -- it is
> > > > > > stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
> > > > > > percpu storage.  It's even nastier because it means that whether %gs
> > > > > > contains userspace state or kernel state while running kernel code
> > > > > > depends on whether stackprotector is enabled (this is
> > > > > > CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
> > > > > > that segment selectors work.  Supporting both variants is a
> > > > > > maintenance and testing mess.
> > > > > >
> > > > > > Merely rearranging so that percpu and the stack canary
> > > > > > share the same segment would be messy as the 32-bit percpu address
> > > > > > layout isn't currently compatible with putting a variable at a fixed
> > > > > > offset.
> > > > > >
> > > > > > Fortunately, GCC 8.1 added options that allow the stack canary to be
> > > > > > accessed as %fs:__stack_chk_guard, effectively turning it
> > > > > > into an ordinary
> > > > > > percpu variable.  This lets us get rid of all of the code to
> > > > > > manage the
> > > > > > stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.
> > > > > >
> > > > > > (That name is special.  We could use any symbol we want for the
> > > > > >   %fs-relative mode, but for CONFIG_SMP=n, gcc refuses to
> > > > > > let us use any
> > > > > >   name other than __stack_chk_guard.)
> > > > > >
> > > > > > This patch forcibly disables stackprotector on older compilers that
> > > > > > don't support the new options and makes the stack canary into a
> > > > > > percpu variable.  The "lazy GS" approach is now used for all 32-bit
> > > > > > configurations.
> > > > > >
> > > > > > This patch also makes load_gs_index() work on 32-bit kernels.  On
> > > > > > 64-bit kernels, it loads the GS selector and updates the user
> > > > > > GSBASE accordingly.  (This is unchanged.)  On 32-bit kernels,
> > > > > > it loads the GS selector and updates GSBASE, which is now
> > > > > > always the user base.  This means that the overall effect is
> > > > > > the same on 32-bit and 64-bit, which avoids some ifdeffery.
> > > > > This patch broke 32-bit boot on Intel Merrifield
> > > > >
> > > > > git bisect start
> > > > > # good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
> > > > > git bisect good 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
> > > > > # bad: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
> > > > > git bisect bad 62fb9874f5da54fdb243003b386128037319b219
> > > > > # bad: [85f3f17b5db2dd9f8a094a0ddc665555135afd22] Merge branch
> > > > > 'md-fixes' of
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/song/md into
> > > > > block-5.13
> > > > > git bisect bad 85f3f17b5db2dd9f8a094a0ddc665555135afd22
> > > > > # good: [ca62e9090d229926f43f20291bb44d67897baab7] Merge tag
> > > > > 'regulator-v5.13' of
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
> > > > > git bisect good ca62e9090d229926f43f20291bb44d67897baab7
> > > > > # bad: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag
> > > > > 'drm-next-2021-04-28' of git://anongit.freedesktop.org/drm/drm
> > > > > git bisect bad 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
> > > > > # good: [49c70ece54b0d1c51bc31b2b0c1070777c992c26]
> > > > > drm/amd/display: Change input parameter for set_drr
> > > > > git bisect good 49c70ece54b0d1c51bc31b2b0c1070777c992c26
> > > > > # good: [0b276e470a4d43e1365d3eb53c608a3d208cabd4] media: coda:
> > > > > fix macroblocks count control usage
> > > > > git bisect good 0b276e470a4d43e1365d3eb53c608a3d208cabd4
> > > > > # bad: [c6536676c7fe3f572ba55842e59c3c71c01e7fb3] Merge tag
> > > > > 'x86_core_for_v5.13' of
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > > > > git bisect bad c6536676c7fe3f572ba55842e59c3c71c01e7fb3
> > > > > # good: [d1466bc583a81830cef2399a4b8a514398351b40] Merge branch
> > > > > 'work.inode-type-fixes' of
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> > > > > git bisect good d1466bc583a81830cef2399a4b8a514398351b40
> > > > > # good: [fafe1e39ed213221c0bce6b0b31669334368dc97] Merge tag
> > > > > 'afs-netfs-lib-20210426' of
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
> > > > > git bisect good fafe1e39ed213221c0bce6b0b31669334368dc97
> > > > > # bad: [b1f480bc0686e65d5413c035bd13af2ea4888784] Merge branch
> > > > > 'x86/cpu' into WIP.x86/core, to merge the NOP changes & resolve
> > > > > a semantic conflict
> > > > > git bisect bad b1f480bc0686e65d5413c035bd13af2ea4888784
> > > > > # bad: [0c925c61dae18ee3cb93a61cc9dd9562a066034d]
> > > > > x86/tools/insn_decoder_test: Convert to insn_decode()
> > > > > git bisect bad 0c925c61dae18ee3cb93a61cc9dd9562a066034d
> > > > > # bad: [514ef77607b9ff184c11b88e8f100bc27f07460d]
> > > > > x86/boot/compressed/sev-es: Convert to insn_decode()
> > > > > git bisect bad 514ef77607b9ff184c11b88e8f100bc27f07460d
> > > > > # bad: [9e761296c52dcdb1aaa151b65bd39accb05740d9] x86/insn:
> > > > > Rename insn_decode() to insn_decode_from_regs()
> > > > > git bisect bad 9e761296c52dcdb1aaa151b65bd39accb05740d9
> > > > > # bad: [d0962f2b24c99889a386f0658c71535f56358f77] x86/entry/32:
> > > > > Remove leftover macros after stackprotector cleanups
> > > > > git bisect bad d0962f2b24c99889a386f0658c71535f56358f77
> > > > > # bad: [3fb0fdb3bbe7aed495109b3296b06c2409734023]
> > > > > x86/stackprotector/32: Make the canary into a regular percpu
> > > > > variable
> > > > > git bisect bad 3fb0fdb3bbe7aed495109b3296b06c2409734023
> > > > > # first bad commit: [3fb0fdb3bbe7aed495109b3296b06c2409734023]
> > > > > x86/stackprotector/32: Make the canary into a regular percpu
> > > > > variable
> > >
> > > With the bad commit the last words in dmesg are:
> > >
> > > mem auto-init: stack:off, heap alloc:off, heap free:off
> > > Initializing HighMem for node 0 (00036ffe:0003f500)
> > > Initializing Movable for node 0 (00000000:00000000)
> > > Checking if this processor honours the WP bit even in supervisor
> > > mode...Ok.
> > > Memory: 948444K/1004124K available (12430K kernel code, 2167K rwdata,
> > > 4948K rodata, 716K init, 716K bss, 55680K reserved, 0K cma-reserved,
> > > 136200K highmem)
> > > SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> > > trace event string verifier disabled
> > > Dynamic Preempt: voluntary
> > > rcu: Preemptible hierarchical RCU implementation.
> > > rcu:     RCU event tracing is enabled.
> > > rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
> > >  Trampoline variant of Tasks RCU enabled.
> > >  Tracing variant of Tasks RCU enabled.
> > > rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> > > rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> > > NR_IRQS: 2304, nr_irqs: 512, preallocated irqs: 0
> > >
> > > without the bad commit dmesg continues:
> > >
> > > random: get_random_bytes called from start_kernel+0x492/0x65a with
> > > crng_init=0
> > > Console: colour dummy device 80x25
> > > printk: console [tty0] enabled
> > > printk: bootconsole [uart0] disabled
> > >
> > > ....
> > >
> > > > > Any suggestions how to fix are welcome!
> > > > >
> > Interesting. I added the following fragment to the kernel config:
> >
> > # CONFIG_STACKPROTECTOR is not set
> >
> > And this resolves the boot issue (tested with v5.17 i686 on Intel
> > Merrifield)
>
> I'm not sure that's the correct approach.
> Any answer from the Andy Lutomirski?
>
> And in general to x86 maintainers, do we support all features on x86 32-bit? If
> no, can it be said explicitly, please?

What compiler version are you using?

--
Brian Gerst
