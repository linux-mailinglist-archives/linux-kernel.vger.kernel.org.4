Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF36635539
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiKWJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbiKWJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:14:23 -0500
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CDA10612F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:14:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id F240C604F3;
        Wed, 23 Nov 2022 10:14:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1669194850; bh=IKraaILkbo4MQ67m37oJS7yhTYWYuEJg4rejCceLEc8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=YRgUJ5JEynJDjefV261dYemulLNncpxG37r63wUKKU1LVUZinFJBQ/zmStAk5DUHk
         XwskLvSTaX85OwqpxxD9vmgNEKK6g0aeClN4AIX2g6Kku6bcWgrWPPGb06nxSffARu
         8kGdZn2lcQ744y5Z5ZET9Rb/ri8Y2xcUlDs5o44G04TJOMXSicRx3zLMROqRMMwa4k
         YeKr2JD2NHTfi31gDjAjem2obs08u2qLhTdOO1+hSddYCJNb37uZOSsxGK8atwcGWQ
         3B9oFnG+4oqcF9ex000ewa15F8g6+ql5my8aHh/STpGA6cSeiZ8E50x6nEESKpW0uR
         u5CMmTSvRheeA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9LCHVB7c4gF2; Wed, 23 Nov 2022 10:14:08 +0100 (CET)
Received: from [10.0.2.18] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 8B065604F2;
        Wed, 23 Nov 2022 10:14:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1669194848; bh=IKraaILkbo4MQ67m37oJS7yhTYWYuEJg4rejCceLEc8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=t2xGHi9j/BaMN46sxqRoIB/H5DHoOIyLZa+BjmZORO2bJV3w/fXWKPSa2J27FG861
         PU8iKo+ZheKnt7YDhjvEcgDEuuaiFw9FaPDHMRwEAK0OVlddPPIDCRt0ALHdvRfmSU
         Flrd6FVmfChjBWDZt6sgXZcYCcWaHUxkv/sh25iJv9aocun74h2RZBnAjW7M0hoJ9D
         YMCqE2WKQ5Rla8d54Nf8a4Ydf+GuxEHOEkSvL8jXvd8PTt9k8L3/k9LV7YpLkDahbf
         QQxzgqNU57yMSp/SaVdQ+5KrlvhW8hPrYOYSxg9HjFL+lQKSlCCzsOW6doq53+aFzh
         ksZ3WwyoRmNsw==
Message-ID: <e8f5b9b3-383a-c267-9ee3-f1e0da5466fc@alu.unizg.hr>
Date:   Wed, 23 Nov 2022 10:14:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
To:     paulmck@kernel.org
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, phillip.lougher@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>, elliott@hpe.com
References: <9697fcf5-4213-3d5e-176a-e82d4bd07870@alu.unizg.hr>
 <eac8af79-8936-f845-c8dd-c63ebf0d5e81@alu.unizg.hr>
 <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
 <20221118155534.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <dd430080-774b-1cba-1758-2bf92cb1acac@alu.unizg.hr>
 <20221120175016.GC4001@paulmck-ThinkPad-P17-Gen-1>
 <8e62a31f-3ef8-71ec-6181-2afa56eeb5db@alu.unizg.hr>
 <20221120192150.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <8c9eb87b-5623-730a-5cf6-72d831ef797a@alu.unizg.hr>
 <20221122020734.GD4001@paulmck-ThinkPad-P17-Gen-1>
Content-Language: en-US
In-Reply-To: <20221122020734.GD4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 11. 2022. 03:07, Paul E. McKenney wrote:

>> I'm afraid that I would lose in Far Cry miserably if my cores
>> decided to all lock up for 21 secs. :-(
> 
> Agreed, 21 seconds is an improvement over the earlier 60 seconds, but
> still a very long time.  Me, I come from DYNIX/ptx, where the equivalent
> to the RCU CPU stall warning was 1.5 seconds.  On the other hand, it
> is also the case that DYNIX/ptx had nowhere near the variety of drivers
> and subsystems, nor did it scale anywhere near as far as Linux does today.
> 
> But you only need one CPU to lock up for 21 seconds to get an RCU CPU
> stall warning, not all of them.  ;-)

I can recall an occasion or a couple of them where the entire X Window system
had been unresponsive for quite a number of seconds that sometimes made me reset
the Ubuntu box.

I have the good news: the patches did not apply because they were already applied
in the mainline tree:

mtodorov@domac:~/linux/kernel/linux_stable_build_b$ git log | grep -C5 28b3ae426598
     Signed-off-by: Borislav Petkov <bp@suse.de>
     Reviewed-by: Kees Cook <keescook@chromium.org>
     Acked-by: Florian Weimer <fweimer@redhat.com>
     Link: https://lore.kernel.org/r/898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org

commit 28b3ae426598e722cf5d5ab9cc7038791b955a56
Author: Uladzislau Rezki <uladzislau.rezki@sony.com>
Date:   Wed Feb 16 14:52:09 2022 +0100

     rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT

mtodorov@domac:~/linux/kernel/linux_stable_build_b$ git log | grep -C5 1045a06724f3
     Somehow kernel-doc complains here about strong markup, but
     we really don't need the [] so just remove that.

     Signed-off-by: Johannes Berg <johannes.berg@intel.com>

commit 1045a06724f322ed61f1ffb994427c7bdbe64647
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Jun 29 17:01:02 2022 +0200

     remove CONFIG_ANDROID

mtodorov@domac:~/linux/kernel/linux_stable_build_b$

>> This is at present just the wishful thinking, as I lack your 30 years of
>> experience with the kernel and RCU update system. I am only beginning to realise
>> why it is more efficient than the traditional locking, and IMHO it should
>> avoid locking up cores instead of increasing the number of complaints.
> 
> Just to set the record straight, RCU does not normally lock up any of
> the cores.  Instead, RCU detects that cores have been locked up.
> 
> Give or take the occasional bug in RCU, of course!

Currently, I cannot be the judge of that, for I can't seem to understand how the
magic of RCU works., how it is implemented. There's more homework to be done ;-)

>> But even if the Linux kernel source is magically "memory mapped" into my
>> mind, I still do not see how it could be done. My Linux kernel learning curve
>> had not yet got that up, but I have no doubts that it is designed by
>> Intelligent Designers who are very witty people, and not village idiots ;-)
> 
> There is the school of thought that claims that the Linux kernel is
> driven by evolutionary forces rather than intelligent design.  And as
> we all know, evolutionary forces are driven by random changes, which
> absolutely anyone could make.

Give or take the rate of improbability where a bunch of monkeys randomly typing
would produce a working Linux kernel source would be about a couple of working
sources in a space of 96^30,000,00 (something like 10^300,000,000), it is comparable
to the probability of random coming of the first simplest DNA into the existence
from the amino acid primordial soup.

(Not that many atoms in the Universe - 10^82, you'd need an awful lot of wasted
multiverses with no even single cell life and certainly no working Linux kernels.)

> And one approach is to take a less aggressive RCU CPU stall timeout,
> say reducing from 21 seconds to (say) 15 seconds instead of all the
> way down to 20 milliseconds.  This could allow you to ease into the
> latency-reduction work.
> 
> Alternatively, consider that response time is a property of the
> entire system plus the environment that it runs in.  So I suspect that
> the Android folks are accompanying that 20-millisecond timeout with
> some restrictions on what the on-phone workloads are permitted to do.
> Maybe ask the Android guys what those restrictions are and loosen them
> slightly, again allowing you to ease into the latency-reduction work.

Good point.
> Sometimes an NMI does get the CPUs back on track.  Sometimes the RCU CPU
> stall warning is a symptom of the CPU having gotten too old and failing.
> Most often, though, it is a sign of some sort of lockup, a too-long
> RCU read-side critical section, or as Robert Elliot noted, the lack of
> a cond_resched().
> 
> But please keep in mind that cond_resched() helps only in kernels built
> with CONFIG_PREEMPTION=n.

I have bad news that 6.1-r6 is still affected with squashfs_xz_uncompress bug, despite having both of your fixes
(as visible in above command's output -- double checked):

[   91.065659] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 3-.... } 6 jiffies s: 621 root: 0x8/.
[   91.065694] rcu: blocking rcu_node structures (internal RCU debug):
[   91.065704] Sending NMI from CPU 5 to CPUs 3:
[   91.065721] NMI backtrace for cpu 3
[   91.065730] CPU: 3 PID: 2829 Comm: snap-store Not tainted 6.1.0-rc6 #1
[   91.065741] Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN49WW 07/21/2022
[   91.065746] RIP: 0010:__asan_load4+0x0/0xa0
[   91.065764] Code: 9e c0 84 c0 75 e1 5d c3 cc cc cc cc 48 c1 e8 03 80 3c 10 00 75 e9 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 
00 00 0f 1f 00 <55> 48 89 e5 48 8b 4d 08 48 83 ff fb 77 64 eb 0f 0f 1f 00 48 b8 00
[   91.065771] RSP: 0000:ffff8881388ef140 EFLAGS: 00000246
[   91.065779] RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff9be992fd
[   91.065785] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff888125500004
[   91.065789] RBP: ffff8881388ef1e0 R08: 0000000000000001 R09: ffffed1024aa0de8
[   91.065794] R10: ffff888125506f39 R11: ffffed1024aa0de7 R12: 0000000001067db0
[   91.065799] R13: ffff888125500000 R14: 00000000014fe803 R15: ffff888125502112
[   91.065804] FS:  00007fdec50ab180(0000) GS:ffff888257180000(0000) knlGS:0000000000000000
[   91.065810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.065815] CR2: 00007fdeb7cb6260 CR3: 000000011a436005 CR4: 0000000000770ee0
[   91.065820] PKRU: 55555554
[   91.065823] Call Trace:
[   91.065826]  <TASK>
[   91.065829]  ? lzma_main+0x37a/0x1260
[   91.065845]  lzma2_lzma+0x2b9/0x430
[   91.065857]  xz_dec_lzma2_run+0x11f/0xb90
[   91.065867]  ? __asan_load4+0x55/0xa0
[   91.065880]  xz_dec_run+0x346/0x11f0
[   91.065892]  squashfs_xz_uncompress+0x196/0x370
[   91.065905]  ? lzo_uncompress+0x400/0x400
[   91.065913]  squashfs_decompress+0x88/0xd0
[   91.065923]  squashfs_read_data+0x1e5/0x900
[   91.065930]  ? __create_object+0x4ae/0x560
[   91.065942]  ? squashfs_bio_read.isra.3+0x230/0x230
[   91.065951]  ? __kasan_kmalloc+0xb6/0xc0
[   91.065961]  ? squashfs_page_actor_init_special+0x1a6/0x210
[   91.065972]  squashfs_readahead+0xaa3/0xe80
[   91.065985]  ? squashfs_fill_page+0x190/0x190
[   91.065993]  ? __filemap_add_folio+0x3a1/0x680
[   91.066003]  ? dio_warn_stale_pagecache.part.67+0x90/0x90
[   91.066012]  read_pages+0x122/0x540
[   91.066023]  ? file_ra_state_init+0x60/0x60
[   91.066032]  ? filemap_add_folio+0xd4/0x140
[   91.066040]  ? folio_alloc+0x1b/0x50
[   91.066051]  page_cache_ra_unbounded+0x1e6/0x280
[   91.066064]  do_page_cache_ra+0x7c/0x90
[   91.066074]  page_cache_ra_order+0x393/0x400
[   91.066087]  ondemand_readahead+0x2f1/0x4e0
[   91.066098]  page_cache_async_ra+0x8b/0xa0
[   91.066106]  filemap_fault+0x742/0x1490
[   91.066113]  ? __folio_memcg_unlock+0x35/0x80
[   91.066124]  ? read_cache_page_gfp+0x90/0x90
[   91.066132]  ? filemap_map_pages+0x28e/0xc60
[   91.066145]  __do_fault+0x76/0x1b0
[   91.066154]  do_fault+0x1c6/0x680
[   91.066163]  __handle_mm_fault+0x89a/0x1310
[   91.066173]  ? copy_page_range+0x1b20/0x1b20
[   91.066181]  ? mt_find+0x189/0x330
[   91.066190]  ? mas_next_entry+0xa80/0xa80
[   91.066204]  handle_mm_fault+0x11b/0x390
[   91.066213]  do_user_addr_fault+0x258/0x860
[   91.066225]  exc_page_fault+0x64/0xf0
[   91.066235]  asm_exc_page_fault+0x27/0x30
[   91.066245] RIP: 0033:0x7fdeb7a1e541
[   91.066252] Code: 11 44 b8 e0 0f 11 44 b8 f0 0f 11 04 b8 48 83 c7 40 48 83 c6 f8 75 92 48 85 d2 74 2d 4c 01 d7 49 8d 04 b9 48 83 
c0 10 48 f7 da <0f> 28 05 18 7d 29 00 0f 1f 84 00 00 00 00 00 0f 11 40 f0 0f 11 00
[   91.066259] RSP: 002b:00007fff46f77b60 EFLAGS: 00010293
[   91.066265] RAX: 000055fbe1a57c30 RBX: 00007fff46f77d18 RCX: 000055fbe1a57c20
[   91.066270] RDX: fffffffffffffffb RSI: 0000000000000005 RDI: 0000000000000000
[   91.066274] RBP: 000055fbe16563b0 R08: 0000000000000028 R09: 000055fbe1a57c20
[   91.066279] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000002b
[   91.066283] R13: 000055fbe1656408 R14: 00007fff46f77b80 R15: 0000000000000000
[   91.066292]  </TASK>

(This is apparently only visible in CONFIG_KASAN=y build.)

>> Yes, you guys do an amasing job of keeping 30 million lines of code organised
>> and making some sense. I will cut the smalltalk as I know you are a busy man.
>> If I make a progress to actually produce any patches fixing these lockups and
>> stalls, I will be sure to include you into CC: as you requested.
> 
> Looking forward to seeing what you come up with!

There will have to be a lot of homework to catch up with to before I'd be able to do anything
sensible. :)

Thanks,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

