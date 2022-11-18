Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F159D62F91D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbiKRPSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241795AbiKRPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:18:07 -0500
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C86313D20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:18:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 284A9604F8;
        Fri, 18 Nov 2022 16:18:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668784683; bh=xTX78tatfferuMsgVjKqUI7fCD7HRduNpxMj3qHaCg8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tbUWgcXeIeoTO4dZTm2KsfF0fh1SH3IDU3xk4/hCmqwX/uuXoEeFojbE7yd0VDYbr
         2XMpJuXmBYHbU//+w+6fmzFJzuiJ7VO7/Scsr4JGph05mlRboSoyBASbAYEtmXjQmA
         vAm5sRNuIVIhGj5J6k/GlpRnHP3jnYEe0dLmcULFNX6jAx7BDqyXbWjRC+5Ti9Zo0z
         hVbDbfbzECmoyeEIWmSup8jLPeEovnrYkQgp1/W2tkAsTMPL7Ny4qoZLDhh8sfeAL4
         r7g2qBLvskBZBosjmYbP2BxOp4du/398+6iJW3j/1NYfRxGR8BQPBj8mKRNyp7xMRA
         6FltxbhGn7fAw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1iD4LI01fUW9; Fri, 18 Nov 2022 16:18:00 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.198.198])
        by domac.alu.hr (Postfix) with ESMTPSA id BD3D8604F5;
        Fri, 18 Nov 2022 16:17:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668784680; bh=xTX78tatfferuMsgVjKqUI7fCD7HRduNpxMj3qHaCg8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M8tPYYpNRWT6hY+mw0sAYwF9O63KX2I3ywZUlXHymyc0HI0jC/3oWgYXVbnVmlE0s
         4UggCkzKiRyNT5rKmUs58m+X3lAVpolTioo25zhU2YOZifdigMH/dRudcJSIv4PED4
         PsXgvFZVrdfXZKdK24Jo3x8mIAFgFdUVwgKIK1EiH0dGqQThwcC3jhHzHJ5mhSL2h4
         w+0zI/S9kzbC32u1aj/nu2dJ/YvHmDeInhdgakilFERdkHBuU+6MfviUZSp9knIuFN
         b2/nba63s5itnvmu/CANAFlCsmZ4vlM0U3ZQ0vZ/u36W+pI8luJRoa6P5ds1lPiztd
         aZMWn9KY4SAFA==
Message-ID: <042ce050-93d3-a7e7-6ed2-80f47e72e12a@alu.unizg.hr>
Date:   Fri, 18 Nov 2022 16:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     phillip.lougher@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <9697fcf5-4213-3d5e-176a-e82d4bd07870@alu.unizg.hr>
 <eac8af79-8936-f845-c8dd-c63ebf0d5e81@alu.unizg.hr>
 <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
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

On 18. 11. 2022. 07:11, Phillip Lougher wrote:
> On 17/11/2022 23:05, Mirsad Goran Todorovac wrote:
>> Hi,
>>
>> While trying to bisect, I've found another bug that predated the introduction of squashfs_readahead(), but it has
>> a common denominator in squashfs_decompress() and squashfs_xz_uncompress().
> 
> Wrong, the stall is happening in the XZ decompressor library, which
> is *not* in Squashfs.
> 
> This reported stall in the decompressor code is likely a symptom of you
> deliberately thrashing your system.  When the system thrashes everything
> starts to happen very slowly, and the system will spend a lot of
> its time doing page I/O, and the CPU will spend a lot of time in
> any CPU intensive code like the XZ decompressor library.
> 
> So the fact the stall is being hit here is a symptom and not
> a cause.  The decompressor code is likely running slowly due to
> thrashing and waiting on paged-out buffers.  This is not indicative
> of any bug, merely a system running slowly due to overload.
> 
> As I said, this is not a Squashfs issue, because the code when the
> stall takes place isn't in Squashfs.
> 
> The people responsible for the rcu code should have a lot more insight
> about what happens when the system is thrashing, and how this will
> throw up false positives.  In this I believe this is an instance of
> perfectly correct code running slowly due to thrashing incorrectly
> being flagged as looping.
> 
> CC'ing Paul E. McKenney <paulmck@kernel.org>
> 
> Phillip
> 
> 
> 
>>
>> Frankly, I need an advice on how to handle a situation like this.
>>
>> Obviously, the best place to test the RCU problem with squashfs_readahead() is where it is introduced + Phillip's patches [012]/3.
>>
>> Thanks,
>> Mirsad
>>
>> P.S.
>>
>> This is excerpt from dmesg log attached:
>>
>> [   25.338169] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 4-... } 6 jiffies s: 373 root: 0x10/.
>> [   25.338202] rcu: blocking rcu_node structures (internal RCU debug):
>> [   25.338210] Task dump for CPU 4:
>> [   25.338216] task:canonical-livep state:R  running task     stack: 0 pid:  913 ppid:     1 flags:0x00004008
>> [   25.338237] Call Trace:
>> [   25.338243]  <TASK>
>> [   25.338249]  ? __kasan_check_write+0x14/0x20
>> [   25.338272]  ? _raw_spin_lock_irqsave+0x93/0xf0
>> [   25.338293]  ? sysvec_apic_timer_interrupt+0x89/0x90
>> [   25.338311]  ? asm_sysvec_apic_timer_interrupt+0x20/0x30
>> [   25.338327]  ? sysvec_apic_timer_interrupt+0x89/0x90
>> [   25.338342]  ? sysvec_apic_timer_interrupt+0x89/0x90
>> [   25.338359]  ? asm_sysvec_apic_timer_interrupt+0x20/0x30
>> [   25.338377]  ? lzma_len+0x1fb/0x3b0
>> [   25.338395]  ? dict_repeat+0xec/0x120
>> [   25.338413]  ? lzma_main+0x10d/0x1260
>> [   25.338437]  ? lzma2_lzma+0x2a4/0x3b0
>> [   25.338457]  ? xz_dec_lzma2_run+0x11f/0xb90
>> [   25.338483]  ? xz_dec_run+0x346/0x11e0
>> [   25.338506]  ? squashfs_xz_uncompress+0x135/0x330
>> [   25.338530]  ? lzo_init+0xd0/0xd0
>> [   25.338546]  ? squashfs_decompress+0x88/0xc0
>> [   25.338565]  ? squashfs_read_data+0x1e5/0x8e0
>> [   25.338582]  ? __filemap_get_folio+0x37e/0x540
>> [   25.338602]  ? squashfs_bio_read.isra.2+0x220/0x220
>> [   25.338628]  ? squashfs_readpage_block+0x493/0x950
>> [   25.338650]  ? squashfs_read_folio+0xa4c/0x1140
>> [   25.338671]  ? xas_nomem+0x2f/0x100
>> [   25.338689]  ? squashfs_copy_cache+0x360/0x360
>> [   25.338707]  ? folio_wait_bit+0x3c0/0x3c0
>> [   25.338725]  ? __kasan_check_read+0x11/0x20
>> [   25.338739]  ? pagevec_add_and_need_flush+0x8c/0xa0
>> [   25.338757]  ? folio_add_lru+0x42/0x70
>> [   25.338772]  ? filemap_add_folio+0xd4/0x130
>> [   25.338788]  ? add_to_page_cache_locked+0xa0/0xa0
>> [   25.338806]  ? filemap_read_folio.isra.62+0xbe/0x4d0
>> [   25.338822]  ? __kasan_check_write+0x14/0x20
>> [   25.338838]  ? filemap_page_mkwrite+0x6a0/0x6a0
>> [   25.338856]  ? filemap_add_folio+0x130/0x130
>> [   25.338879]  ? filemap_fault+0x1041/0x1310
>> [   25.338895]  ? __kasan_check_read+0x11/0x20
>> [   25.338918]  ? read_cache_page_gfp+0xd0/0xd0
>> [   25.338932]  ? __rcu_read_unlock+0x55/0x260
>> [   25.338953]  ? try_to_wake_up+0x3c2/0xa10
>> [   25.338972]  ? __filemap_get_folio+0x540/0x540
>> [   25.338985]  ? __pmd+0x10/0x10
>> [   25.339002]  ? __do_fault+0x7c/0x1b0
>> [   25.339019]  ? do_fault+0x1ce/0x6a0
>> [   25.339036]  ? __handle_mm_fault+0x9cb/0x1490
>> [   25.339057]  ? copy_page_range+0x1b90/0x1b90
>> [   25.339073]  ? kernel_fpu_begin_mask+0x160/0x160
>> [   25.339092]  ? __ia32_sys_futex_time32+0x300/0x300
>> [   25.339119]  ? handle_mm_fault+0x11b/0x380
>> [   25.339138]  ? do_user_addr_fault+0x258/0x810
>> [   25.339157]  ? exc_page_fault+0x60/0xe0
>> [   25.339173]  ? asm_exc_page_fault+0x2c/0x40
>> [   25.339194]  </TASK>
>>
>>
>>
>> On 17. 11. 2022. 20:21, Mirsad Goran Todorovac wrote:
>>> Dear all,
>>>
>>> I've noticed two similar RCU stalls with the similar call trace, both involving squashfs_readeahead().
>>>
>>> Configuration is (excerpt):
>>>
>>> CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
>>> CONFIG_HAVE_DEBUG_KMEMLEAK=y
>>> CONFIG_DEBUG_KMEMLEAK=y
>>> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
>>> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
>>> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
>>> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
>>> CONFIG_HAVE_ARCH_KASAN=y
>>> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
>>> CONFIG_CC_HAS_KASAN_GENERIC=y
>>> CONFIG_KASAN=y
>>> CONFIG_KASAN_GENERIC=y
>>> CONFIG_KASAN_OUTLINE=y
>>> # CONFIG_KASAN_INLINE is not set
>>> CONFIG_KASAN_STACK=y
>>> # CONFIG_KASAN_VMALLOC is not set
>>> # CONFIG_KASAN_MODULE_TEST is not set
>>>
>>> Do you think this is worthy of a bisect? I am not yet certain about being able to reproduce the stall, however it occurs at
>>> great memory use and heavy swapping (I thought of experimenting with efficiency of multi-gen LRU in 6.1 with multimedia under 
>>> heavy loads and low memory ...).
>>>
>>> Here is the excerpt from dmesg:
>>>
>>> [ 1326.301544] perf: interrupt took too long (3181 > 3178), lowering kernel.perf_event_max_sample_rate to 62750
>>> [ 1347.269247] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 3-.... } 6 jiffies s: 1317 root: 0x8/.
>>> [ 1347.269294] rcu: blocking rcu_node structures (internal RCU debug):
>>> [ 1347.269310] Sending NMI from CPU 2 to CPUs 3:
>>> [ 1347.269329] NMI backtrace for cpu 3
>>> [ 1347.269343] CPU: 3 PID: 7907 Comm: Isolated Web Co Not tainted 6.1.0-rc5 #1
>>> [ 1347.269357] Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN49WW 07/21/2022
>>> [ 1347.269363] RIP: 0010:__asan_load8+0x3e/0xb0
>>> [ 1347.269386] Code: b8 00 00 00 00 00 00 00 ff eb 0a 48 b8 00 00 00 00 00 80 ff ff 48 39 f8 77 44 48 8d 47 07 48 89 c2 83 e2 07 
>>> 48 83 fa 07 75 1c <48> ba 00 00 00 00 00 fc ff df 48 c1 e8 03 0f b6 04 10 84 c0 75 30
>>> [ 1347.269398] RSP: 0018:ffff888102eef288 EFLAGS: 00000246
>>> [ 1347.269410] RAX: ffff888109280047 RBX: ffff8881157da0ca RCX: ffffffff8fca8434
>>> [ 1347.269419] RDX: 0000000000000007 RSI: 0000000000000001 RDI: ffff888109280040
>>> [ 1347.269427] RBP: ffff888102eef288 R08: 00000000000003ae R09: ffffed1021250de8
>>> [ 1347.269435] R10: ffff888109286f39 R11: ffffed1021250de7 R12: 0000000000000155
>>> [ 1347.269443] R13: ffffc9000122ff18 R14: ffff888109280000 R15: ffff888109280000
>>> [ 1347.269451] FS:  00007efe541e9380(0000) GS:ffff888252f80000(0000) knlGS:0000000000000000
>>> [ 1347.269462] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ 1347.269470] CR2: 00007fa7a15e2000 CR3: 000000013100a003 CR4: 0000000000770ee0
>>> [ 1347.269479] PKRU: 55555554
>>> [ 1347.269484] Call Trace:
>>> [ 1347.269488]  <TASK>
>>> [ 1347.269494]  lzma_main+0x3b4/0x12b0
>>> [ 1347.269517]  lzma2_lzma+0x2dd/0x460
>>> [ 1347.269535]  xz_dec_lzma2_run+0x11e/0xba0
>>> [ 1347.269549]  ? __asan_load4+0x8/0xb0
>>> [ 1347.269564]  ? crc32_le_base+0x179/0x250
>>> [ 1347.269581]  xz_dec_run+0x57b/0x11a0
>>> [ 1347.269600]  squashfs_xz_uncompress+0x196/0x370
>>> [ 1347.269620]  squashfs_decompress+0x8e/0xd0
>>> [ 1347.269633]  ? lzo_uncompress+0x400/0x400
>>> [ 1347.269648]  squashfs_read_data+0x1e6/0x900
>>> [ 1347.269662]  ? kmemleak_alloc+0x4b/0x80
>>> [ 1347.269678]  ? squashfs_bio_read.isra.0+0x230/0x230
>>> [ 1347.269694]  ? squashfs_page_actor_init_special+0x1bb/0x230
>>> [ 1347.269710]  squashfs_readahead+0xa86/0xe70
>>> [ 1347.269722]  ? put_pages_list+0x1e0/0x1e0
>>> [ 1347.269747]  ? squashfs_fill_page+0x190/0x190
>>> [ 1347.269763]  ? psi_task_change+0x106/0x130
>>> [ 1347.269781]  ? raw_spin_rq_unlock+0x17/0x60
>>> [ 1347.269796]  read_pages+0x12d/0x530
>>> [ 1347.269814]  ? file_ra_state_init+0x60/0x60
>>> [ 1347.269829]  ? xas_free_nodes+0x170/0x170
>>> [ 1347.269844]  ? filemap_alloc_folio+0xcf/0x120
>>> [ 1347.269863]  page_cache_ra_unbounded+0x1aa/0x280
>>> [ 1347.269878]  ? __rcu_read_unlock+0x57/0x270
>>> [ 1347.269898]  do_page_cache_ra+0x7c/0x90
>>> [ 1347.269915]  page_cache_ra_order+0x3b4/0x420
>>> [ 1347.269936]  filemap_fault+0x849/0xe40
>>> [ 1347.269951]  ? read_cache_page_gfp+0x90/0x90
>>> [ 1347.269970]  __do_fault+0x76/0x1e0
>>> [ 1347.269984]  do_fault+0x1e5/0x6c0
>>> [ 1347.269998]  __handle_mm_fault+0x905/0x1740
>>> [ 1347.270015]  ? copy_page_range+0x2130/0x2130
>>> [ 1347.270028]  ? mas_find+0x100/0x100
>>> [ 1347.270050]  handle_mm_fault+0x11c/0x3b0
>>> [ 1347.270065]  do_user_addr_fault+0x261/0x8b0
>>> [ 1347.270084]  exc_page_fault+0x61/0xf0
>>> [ 1347.270101]  asm_exc_page_fault+0x27/0x30
>>> [ 1347.270115] RIP: 0033:0x7efe544ce8b4
>>> [ 1347.270126] Code: d5 c4 e1 f9 7e d0 c4 e1 f9 7e d7 48 c1 f8 35 48 c1 ff 2e 48 89 c1 48 89 fe b8 ff 01 00 00 29 c8 83 e6 7f 48 
>>> 8d 0d ec 45 07 00 <c5> fb 10 04 f1 48 98 48 8d 0d fe 44 07 00 c5 fb 59 0c c1 c5 f3 59
>>> [ 1347.270137] RSP: 002b:00007ffc019a6e30 EFLAGS: 00010206
>>> [ 1347.270147] RAX: 0000000000000005 RBX: 00007ffc019a6f50 RCX: 00007efe54542ea0
>>> [ 1347.270156] RDX: ffffffffbfefe12e RSI: 000000000000007b RDI: 000000000000fd7b
>>> [ 1347.270164] RBP: 00007ffc019a6f58 R08: 00007ffc019a6f40 R09: 00000000006f71c0
>>> [ 1347.270173] R10: 00007efe547fc500 R11: 00007efe54459b60 R12: 00007ffc019a7060
>>> [ 1347.270181] R13: 00007ffc019a6f48 R14: 00007ffc019a7040 R15: 00007ffc019a6f40
>>> [ 1347.270199]  </TASK>
>>>
>>>
>>> [ 1534.865687] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 3-.... } 7 jiffies s: 1393 root: 0x8/.
>>> [ 1534.865725] rcu: blocking rcu_node structures (internal RCU debug):
>>> [ 1534.865735] Sending NMI from CPU 2 to CPUs 3:
>>> [ 1534.865752] NMI backtrace for cpu 3
>>> [ 1534.865762] CPU: 3 PID: 9629 Comm: FS Broker 9627 Not tainted 6.1.0-rc5 #1
>>> [ 1534.865776] Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN49WW 07/21/2022
>>> [ 1534.865782] RIP: 0010:__asan_load4+0x8/0xb0
>>> [ 1534.865802] Code: cc cc cc cc 48 c1 e8 03 80 3c 10 00 75 e9 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 55 48 
>>> 89 e5 4c 8b 45 08 <48> 83 ff fb 77 63 eb 0f 0f 1f 00 48 b8 00 00 00 00 00 00 00 ff eb
>>> [ 1534.865811] RSP: 0018:ffff88811fd3f288 EFLAGS: 00000246
>>> [ 1534.865823] RAX: 0000000000000000 RBX: 000000000001d378 RCX: dffffc0000000000
>>> [ 1534.865831] RDX: 0000000000000003 RSI: 000000000000077f RDI: ffff888109280080
>>> [ 1534.865838] RBP: ffff88811fd3f288 R08: ffffffff8fca8622 R09: 000000000001d380
>>> [ 1534.865847] R10: ffff888114694020 R11: ffffed102843b9ff R12: ffff888109280006
>>> [ 1534.865854] R13: ffff888109280000 R14: ffff888109280000 R15: 0000000002bbab0b
>>> [ 1534.865861] FS:  00007fe923eff700(0000) GS:ffff888252f80000(0000) knlGS:0000000000000000
>>> [ 1534.865871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ 1534.865878] CR2: 00007fe90fe90ac0 CR3: 0000000138d5c003 CR4: 0000000000770ee0
>>> [ 1534.865885] PKRU: 55555554
>>> [ 1534.865889] Call Trace:
>>> [ 1534.865893]  <TASK>
>>> [ 1534.865898]  lzma_main+0x5a2/0x12b0
>>> [ 1534.865920]  lzma2_lzma+0x2dd/0x460
>>> [ 1534.865935]  xz_dec_lzma2_run+0x11e/0xba0
>>> [ 1534.865948]  ? crc32_le_base+0x58/0x250
>>> [ 1534.865961]  ? crc32_le_base+0x1e3/0x250
>>> [ 1534.865977]  xz_dec_run+0x57b/0x11a0
>>> [ 1534.865995]  squashfs_xz_uncompress+0x196/0x370
>>> [ 1534.866011]  squashfs_decompress+0x8e/0xd0
>>> [ 1534.866022]  ? lzo_uncompress+0x400/0x400
>>> [ 1534.866034]  squashfs_read_data+0x1e6/0x900
>>> [ 1534.866047]  ? kmemleak_alloc+0x4b/0x80
>>> [ 1534.866061]  ? squashfs_bio_read.isra.0+0x230/0x230
>>> [ 1534.866074]  ? squashfs_page_actor_init_special+0x1bb/0x230
>>> [ 1534.866087]  squashfs_readahead+0xa86/0xe70
>>> [ 1534.866099]  ? xas_create+0x141/0x600
>>> [ 1534.866119]  ? squashfs_fill_page+0x190/0x190
>>> [ 1534.866136]  ? psi_task_change+0x106/0x130
>>> [ 1534.866155]  ? raw_spin_rq_unlock+0x17/0x60
>>> [ 1534.866171]  read_pages+0x12d/0x530
>>> [ 1534.866186]  ? __kasan_check_read+0x11/0x20
>>> [ 1534.866200]  ? folio_batch_add_and_move+0x8d/0xa0
>>> [ 1534.866217]  ? file_ra_state_init+0x60/0x60
>>> [ 1534.866231]  ? folio_add_lru+0x47/0x70
>>> [ 1534.866249]  ? filemap_alloc_folio+0xcf/0x120
>>> [ 1534.866267]  page_cache_ra_unbounded+0x1eb/0x280
>>> [ 1534.866280]  ? __rcu_read_unlock+0x57/0x270
>>> [ 1534.866297]  do_page_cache_ra+0x7c/0x90
>>> [ 1534.866312]  page_cache_ra_order+0x3b4/0x420
>>> [ 1534.866330]  filemap_fault+0x849/0xe40
>>> [ 1534.866343]  ? read_cache_page_gfp+0x90/0x90
>>> [ 1534.866359]  __do_fault+0x76/0x1e0
>>> [ 1534.866372]  do_fault+0x1e5/0x6c0
>>> [ 1534.866384]  __handle_mm_fault+0x905/0x1740
>>> [ 1534.866399]  ? copy_page_range+0x2130/0x2130
>>> [ 1534.866412]  ? mas_find+0x100/0x100
>>> [ 1534.866428]  handle_mm_fault+0x11c/0x3b0
>>> [ 1534.866443]  do_user_addr_fault+0x261/0x8b0
>>> [ 1534.866456]  ? exit_to_user_mode_prepare+0x9b/0x190
>>> [ 1534.866472]  exc_page_fault+0x61/0xf0
>>> [ 1534.866486]  asm_exc_page_fault+0x27/0x30
>>> [ 1534.866498] RIP: 0033:0x7fe93673dd00
>>> [ 1534.866515] Code: Unable to access opcode bytes at 0x7fe93673dcd6.
>>> [ 1534.866521] RSP: 002b:00007fe923efeea8 EFLAGS: 00010246
>>> [ 1534.866532] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
>>> [ 1534.866539] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
>>> [ 1534.866545] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fe837100098
>>> [ 1534.866553] R10: 00007fe868300de8 R11: 0000000000000217 R12: 00007fff95860b2e >>> [ 1534.866561] R13: 00007fff95860b2f R14: 00007fff95860bf8 R15: 00007fe923efef80
>>> [ 1534.866576]  </TASK>

Hello Phillip,

I have considered your theory, and I usually admit when I'm wrong, but this is the very
same combination of programs, windows and tabs used when bisecting the squashfs_readahead()
but, only this time ran under a kernel with CONFIG_DEBUG_KMEMLEAK and CONFIG_KASAN turned
on. So I don't think it's thrashing the system.

MGLRU was supposed to make smarter decisions of evicting the unused memory pages from cache
than the 5.10 code, so my intent was to see how that is working, too.

However, I've browsed through the source and it does actually happen when you call xz_dec_run()
from squashfs_xz_uncompress().

I think that 30 windows and 5-30 tabs each are an example of then normal use nowadays.

Plus, with v5.10 and the same config it doesn't throw stalls (only the unrelated systemd-udevd).

[    7.333220] Missing case (clock == 269720)
[    7.333341] WARNING: CPU: 4 PID: 214 at drivers/gpu/drm/i915/display/intel_dpll_mgr.c:2979 icl_get_dplls+0x948/0x11a0 [i915]
[    7.333343] Modules linked in: i915(+) nvme nvme_core i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops 
cec input_leds rc_core drm serio_raw xhci_pci vm
d xhci_pci_renesas mac_hid video pinctrl_tigerlake
[    7.333368] CPU: 4 PID: 214 Comm: systemd-udevd Not tainted 5.10.0-05-2c85ebc57b3e-squashfs-stall #1
[    7.333370] Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN49WW 07/21/2022

So, my conclusion is that KASAN is operable in 5.10, and the problem with xz decompression is in between
5.19-rc1 and 5.10.0.

What can lock up a core for a dozen of jiffies on my laptop could knock it down for a couple of
minutes on a heavily loaded cloud server.

I lack the knowledge how to see a history of commits and modifications on a single file,
thereof the confusion.

However, I did not even blame your code for this stall I thought you might be interested since
in the RCU stall error it is called from your squash_readahead().

Thorsten has somewhat discouraged me when saying that there are 950 issues on the list to bisect.
I thought how the most of them requires a Google cloud to reproduce, and here is one we could bisect
ourselves, and I already know the developer.

So, at no point was I blaming you or demeaning you. I thought how would I react to a bug in my code,
and concluded that I would be glad that the code became more elegant and closer to the "golden cut"
of programming, if there is such a thing.

Have a nice day!

Thanks
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

