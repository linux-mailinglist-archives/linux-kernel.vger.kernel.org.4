Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0B262E950
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbiKQXFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbiKQXFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:05:38 -0500
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0A84B9A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:05:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 07D8B604F4;
        Fri, 18 Nov 2022 00:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668726333; bh=CZVDHlXWWMdGGuxic8p88AQPR2XYNK4LkxtwKcLeHfY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=R0IolSW8wnfLGvkPrtzuDZ6TyYmqmmLRmNhLBBQWEmYfYbMU+jyCreXkRdjQtaDRW
         PKEjWo5rZ4UE9BK0wgSYxhHY80RslAPz0c+hFX8hFexBdp7mzwray6k+SeUwI9+CNV
         l5Fi0he/AomvP2e/FaR//MrimyzsmGZs6f0zaxXDORhKS7A4nIJbBDNrj9aeI3B/+z
         qyOAnlFJ9RhhokYzi7hrl3+26VlNij2EYg1tKFbwZeijMBxUrGA/AJ0KI3Qoh+iVDC
         XI0rf3VqjiPWY1ZKc57tV6B+EP7Bcd69O64rAhvbf0EYdcgJ2ueTJ3cfwUrLKDINdj
         kMHfx7fVwusUg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R60QRkh9Prpe; Fri, 18 Nov 2022 00:05:29 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.197.57])
        by domac.alu.hr (Postfix) with ESMTPSA id 1D5C0604E6;
        Fri, 18 Nov 2022 00:05:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668726329; bh=CZVDHlXWWMdGGuxic8p88AQPR2XYNK4LkxtwKcLeHfY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=HXFKWHO+6yomSPME9Sig4VpUnG0UvS18N42SoXu0QLU1e3fZcT0knoWTw/PJU2k8e
         gB/GY87vp3j3b/xaxbU53LY5RDDS9b6cxuFr7PNgDHwk3Ljp3D2oTBBejO4u09TN4f
         Ur6cJsQQERUZ0+NlvHXadj86oQMKZqLXtcOrx/wgjrToBG+LKlf2PGhH8+ONX1ZcVh
         2cIFQryUbU4EelpmgJUj4k75tYnidbu7cnF5pDjkE/RWJEcZ0ilwogsFdug+hpkWUE
         Wj/O4jva9oGODOfIA3KPfRUU+4Mg8Ofk35A+lO3cpT/+I08hnuFd1OxztucK8v5Beq
         LMgbCBIejdDOA==
Content-Type: multipart/mixed; boundary="------------PbCOzgUgOSwftG9QV4F5jePY"
Message-ID: <eac8af79-8936-f845-c8dd-c63ebf0d5e81@alu.unizg.hr>
Date:   Fri, 18 Nov 2022 00:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        phillip.lougher@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <9697fcf5-4213-3d5e-176a-e82d4bd07870@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <9697fcf5-4213-3d5e-176a-e82d4bd07870@alu.unizg.hr>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------PbCOzgUgOSwftG9QV4F5jePY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

While trying to bisect, I've found another bug that predated the introduction of squashfs_readahead(), but it has
a common denominator in squashfs_decompress() and squashfs_xz_uncompress().

Frankly, I need an advice on how to handle a situation like this.

Obviously, the best place to test the RCU problem with squashfs_readahead() is where it is introduced + Phillip's patches [012]/3.

Thanks,
Mirsad

P.S.

This is excerpt from dmesg log attached:

[   25.338169] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 4-... } 6 jiffies s: 373 root: 0x10/.
[   25.338202] rcu: blocking rcu_node structures (internal RCU debug):
[   25.338210] Task dump for CPU 4:
[   25.338216] task:canonical-livep state:R  running task     stack:    0 pid:  913 ppid:     1 flags:0x00004008
[   25.338237] Call Trace:
[   25.338243]  <TASK>
[   25.338249]  ? __kasan_check_write+0x14/0x20
[   25.338272]  ? _raw_spin_lock_irqsave+0x93/0xf0
[   25.338293]  ? sysvec_apic_timer_interrupt+0x89/0x90
[   25.338311]  ? asm_sysvec_apic_timer_interrupt+0x20/0x30
[   25.338327]  ? sysvec_apic_timer_interrupt+0x89/0x90
[   25.338342]  ? sysvec_apic_timer_interrupt+0x89/0x90
[   25.338359]  ? asm_sysvec_apic_timer_interrupt+0x20/0x30
[   25.338377]  ? lzma_len+0x1fb/0x3b0
[   25.338395]  ? dict_repeat+0xec/0x120
[   25.338413]  ? lzma_main+0x10d/0x1260
[   25.338437]  ? lzma2_lzma+0x2a4/0x3b0
[   25.338457]  ? xz_dec_lzma2_run+0x11f/0xb90
[   25.338483]  ? xz_dec_run+0x346/0x11e0
[   25.338506]  ? squashfs_xz_uncompress+0x135/0x330
[   25.338530]  ? lzo_init+0xd0/0xd0
[   25.338546]  ? squashfs_decompress+0x88/0xc0
[   25.338565]  ? squashfs_read_data+0x1e5/0x8e0
[   25.338582]  ? __filemap_get_folio+0x37e/0x540
[   25.338602]  ? squashfs_bio_read.isra.2+0x220/0x220
[   25.338628]  ? squashfs_readpage_block+0x493/0x950
[   25.338650]  ? squashfs_read_folio+0xa4c/0x1140
[   25.338671]  ? xas_nomem+0x2f/0x100
[   25.338689]  ? squashfs_copy_cache+0x360/0x360
[   25.338707]  ? folio_wait_bit+0x3c0/0x3c0
[   25.338725]  ? __kasan_check_read+0x11/0x20
[   25.338739]  ? pagevec_add_and_need_flush+0x8c/0xa0
[   25.338757]  ? folio_add_lru+0x42/0x70
[   25.338772]  ? filemap_add_folio+0xd4/0x130
[   25.338788]  ? add_to_page_cache_locked+0xa0/0xa0
[   25.338806]  ? filemap_read_folio.isra.62+0xbe/0x4d0
[   25.338822]  ? __kasan_check_write+0x14/0x20
[   25.338838]  ? filemap_page_mkwrite+0x6a0/0x6a0
[   25.338856]  ? filemap_add_folio+0x130/0x130
[   25.338879]  ? filemap_fault+0x1041/0x1310
[   25.338895]  ? __kasan_check_read+0x11/0x20
[   25.338918]  ? read_cache_page_gfp+0xd0/0xd0
[   25.338932]  ? __rcu_read_unlock+0x55/0x260
[   25.338953]  ? try_to_wake_up+0x3c2/0xa10
[   25.338972]  ? __filemap_get_folio+0x540/0x540
[   25.338985]  ? __pmd+0x10/0x10
[   25.339002]  ? __do_fault+0x7c/0x1b0
[   25.339019]  ? do_fault+0x1ce/0x6a0
[   25.339036]  ? __handle_mm_fault+0x9cb/0x1490
[   25.339057]  ? copy_page_range+0x1b90/0x1b90
[   25.339073]  ? kernel_fpu_begin_mask+0x160/0x160
[   25.339092]  ? __ia32_sys_futex_time32+0x300/0x300
[   25.339119]  ? handle_mm_fault+0x11b/0x380
[   25.339138]  ? do_user_addr_fault+0x258/0x810
[   25.339157]  ? exc_page_fault+0x60/0xe0
[   25.339173]  ? asm_exc_page_fault+0x2c/0x40
[   25.339194]  </TASK>



On 17. 11. 2022. 20:21, Mirsad Goran Todorovac wrote:
> Dear all,
> 
> I've noticed two similar RCU stalls with the similar call trace, both involving squashfs_readeahead().
> 
> Configuration is (excerpt):
> 
> CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_KASAN=y
> CONFIG_KASAN_GENERIC=y
> CONFIG_KASAN_OUTLINE=y
> # CONFIG_KASAN_INLINE is not set
> CONFIG_KASAN_STACK=y
> # CONFIG_KASAN_VMALLOC is not set
> # CONFIG_KASAN_MODULE_TEST is not set
> 
> Do you think this is worthy of a bisect? I am not yet certain about being able to reproduce the stall, however it occurs at
> great memory use and heavy swapping (I thought of experimenting with efficiency of multi-gen LRU in 6.1 with multimedia under heavy 
> loads and low memory ...).
> 
> Here is the excerpt from dmesg:
> 
> [ 1326.301544] perf: interrupt took too long (3181 > 3178), lowering kernel.perf_event_max_sample_rate to 62750
> [ 1347.269247] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 3-.... } 6 jiffies s: 1317 root: 0x8/.
> [ 1347.269294] rcu: blocking rcu_node structures (internal RCU debug):
> [ 1347.269310] Sending NMI from CPU 2 to CPUs 3:
> [ 1347.269329] NMI backtrace for cpu 3
> [ 1347.269343] CPU: 3 PID: 7907 Comm: Isolated Web Co Not tainted 6.1.0-rc5 #1
> [ 1347.269357] Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN49WW 07/21/2022
> [ 1347.269363] RIP: 0010:__asan_load8+0x3e/0xb0
> [ 1347.269386] Code: b8 00 00 00 00 00 00 00 ff eb 0a 48 b8 00 00 00 00 00 80 ff ff 48 39 f8 77 44 48 8d 47 07 48 89 c2 83 e2 07 48 
> 83 fa 07 75 1c <48> ba 00 00 00 00 00 fc ff df 48 c1 e8 03 0f b6 04 10 84 c0 75 30
> [ 1347.269398] RSP: 0018:ffff888102eef288 EFLAGS: 00000246
> [ 1347.269410] RAX: ffff888109280047 RBX: ffff8881157da0ca RCX: ffffffff8fca8434
> [ 1347.269419] RDX: 0000000000000007 RSI: 0000000000000001 RDI: ffff888109280040
> [ 1347.269427] RBP: ffff888102eef288 R08: 00000000000003ae R09: ffffed1021250de8
> [ 1347.269435] R10: ffff888109286f39 R11: ffffed1021250de7 R12: 0000000000000155
> [ 1347.269443] R13: ffffc9000122ff18 R14: ffff888109280000 R15: ffff888109280000
> [ 1347.269451] FS:  00007efe541e9380(0000) GS:ffff888252f80000(0000) knlGS:0000000000000000
> [ 1347.269462] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1347.269470] CR2: 00007fa7a15e2000 CR3: 000000013100a003 CR4: 0000000000770ee0
> [ 1347.269479] PKRU: 55555554
> [ 1347.269484] Call Trace:
> [ 1347.269488]  <TASK>
> [ 1347.269494]  lzma_main+0x3b4/0x12b0
> [ 1347.269517]  lzma2_lzma+0x2dd/0x460
> [ 1347.269535]  xz_dec_lzma2_run+0x11e/0xba0
> [ 1347.269549]  ? __asan_load4+0x8/0xb0
> [ 1347.269564]  ? crc32_le_base+0x179/0x250
> [ 1347.269581]  xz_dec_run+0x57b/0x11a0
> [ 1347.269600]  squashfs_xz_uncompress+0x196/0x370
> [ 1347.269620]  squashfs_decompress+0x8e/0xd0
> [ 1347.269633]  ? lzo_uncompress+0x400/0x400
> [ 1347.269648]  squashfs_read_data+0x1e6/0x900
> [ 1347.269662]  ? kmemleak_alloc+0x4b/0x80
> [ 1347.269678]  ? squashfs_bio_read.isra.0+0x230/0x230
> [ 1347.269694]  ? squashfs_page_actor_init_special+0x1bb/0x230
> [ 1347.269710]  squashfs_readahead+0xa86/0xe70
> [ 1347.269722]  ? put_pages_list+0x1e0/0x1e0
> [ 1347.269747]  ? squashfs_fill_page+0x190/0x190
> [ 1347.269763]  ? psi_task_change+0x106/0x130
> [ 1347.269781]  ? raw_spin_rq_unlock+0x17/0x60
> [ 1347.269796]  read_pages+0x12d/0x530
> [ 1347.269814]  ? file_ra_state_init+0x60/0x60
> [ 1347.269829]  ? xas_free_nodes+0x170/0x170
> [ 1347.269844]  ? filemap_alloc_folio+0xcf/0x120
> [ 1347.269863]  page_cache_ra_unbounded+0x1aa/0x280
> [ 1347.269878]  ? __rcu_read_unlock+0x57/0x270
> [ 1347.269898]  do_page_cache_ra+0x7c/0x90
> [ 1347.269915]  page_cache_ra_order+0x3b4/0x420
> [ 1347.269936]  filemap_fault+0x849/0xe40
> [ 1347.269951]  ? read_cache_page_gfp+0x90/0x90
> [ 1347.269970]  __do_fault+0x76/0x1e0
> [ 1347.269984]  do_fault+0x1e5/0x6c0
> [ 1347.269998]  __handle_mm_fault+0x905/0x1740
> [ 1347.270015]  ? copy_page_range+0x2130/0x2130
> [ 1347.270028]  ? mas_find+0x100/0x100
> [ 1347.270050]  handle_mm_fault+0x11c/0x3b0
> [ 1347.270065]  do_user_addr_fault+0x261/0x8b0
> [ 1347.270084]  exc_page_fault+0x61/0xf0
> [ 1347.270101]  asm_exc_page_fault+0x27/0x30
> [ 1347.270115] RIP: 0033:0x7efe544ce8b4
> [ 1347.270126] Code: d5 c4 e1 f9 7e d0 c4 e1 f9 7e d7 48 c1 f8 35 48 c1 ff 2e 48 89 c1 48 89 fe b8 ff 01 00 00 29 c8 83 e6 7f 48 8d 
> 0d ec 45 07 00 <c5> fb 10 04 f1 48 98 48 8d 0d fe 44 07 00 c5 fb 59 0c c1 c5 f3 59
> [ 1347.270137] RSP: 002b:00007ffc019a6e30 EFLAGS: 00010206
> [ 1347.270147] RAX: 0000000000000005 RBX: 00007ffc019a6f50 RCX: 00007efe54542ea0
> [ 1347.270156] RDX: ffffffffbfefe12e RSI: 000000000000007b RDI: 000000000000fd7b
> [ 1347.270164] RBP: 00007ffc019a6f58 R08: 00007ffc019a6f40 R09: 00000000006f71c0
> [ 1347.270173] R10: 00007efe547fc500 R11: 00007efe54459b60 R12: 00007ffc019a7060
> [ 1347.270181] R13: 00007ffc019a6f48 R14: 00007ffc019a7040 R15: 00007ffc019a6f40
> [ 1347.270199]  </TASK>
> 
> 
> [ 1534.865687] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 3-.... } 7 jiffies s: 1393 root: 0x8/.
> [ 1534.865725] rcu: blocking rcu_node structures (internal RCU debug):
> [ 1534.865735] Sending NMI from CPU 2 to CPUs 3:
> [ 1534.865752] NMI backtrace for cpu 3
> [ 1534.865762] CPU: 3 PID: 9629 Comm: FS Broker 9627 Not tainted 6.1.0-rc5 #1
> [ 1534.865776] Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN49WW 07/21/2022
> [ 1534.865782] RIP: 0010:__asan_load4+0x8/0xb0
> [ 1534.865802] Code: cc cc cc cc 48 c1 e8 03 80 3c 10 00 75 e9 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 55 48 89 
> e5 4c 8b 45 08 <48> 83 ff fb 77 63 eb 0f 0f 1f 00 48 b8 00 00 00 00 00 00 00 ff eb
> [ 1534.865811] RSP: 0018:ffff88811fd3f288 EFLAGS: 00000246
> [ 1534.865823] RAX: 0000000000000000 RBX: 000000000001d378 RCX: dffffc0000000000
> [ 1534.865831] RDX: 0000000000000003 RSI: 000000000000077f RDI: ffff888109280080
> [ 1534.865838] RBP: ffff88811fd3f288 R08: ffffffff8fca8622 R09: 000000000001d380
> [ 1534.865847] R10: ffff888114694020 R11: ffffed102843b9ff R12: ffff888109280006
> [ 1534.865854] R13: ffff888109280000 R14: ffff888109280000 R15: 0000000002bbab0b
> [ 1534.865861] FS:  00007fe923eff700(0000) GS:ffff888252f80000(0000) knlGS:0000000000000000
> [ 1534.865871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1534.865878] CR2: 00007fe90fe90ac0 CR3: 0000000138d5c003 CR4: 0000000000770ee0
> [ 1534.865885] PKRU: 55555554
> [ 1534.865889] Call Trace:
> [ 1534.865893]  <TASK>
> [ 1534.865898]  lzma_main+0x5a2/0x12b0
> [ 1534.865920]  lzma2_lzma+0x2dd/0x460
> [ 1534.865935]  xz_dec_lzma2_run+0x11e/0xba0
> [ 1534.865948]  ? crc32_le_base+0x58/0x250
> [ 1534.865961]  ? crc32_le_base+0x1e3/0x250
> [ 1534.865977]  xz_dec_run+0x57b/0x11a0
> [ 1534.865995]  squashfs_xz_uncompress+0x196/0x370
> [ 1534.866011]  squashfs_decompress+0x8e/0xd0
> [ 1534.866022]  ? lzo_uncompress+0x400/0x400
> [ 1534.866034]  squashfs_read_data+0x1e6/0x900
> [ 1534.866047]  ? kmemleak_alloc+0x4b/0x80
> [ 1534.866061]  ? squashfs_bio_read.isra.0+0x230/0x230
> [ 1534.866074]  ? squashfs_page_actor_init_special+0x1bb/0x230
> [ 1534.866087]  squashfs_readahead+0xa86/0xe70
> [ 1534.866099]  ? xas_create+0x141/0x600
> [ 1534.866119]  ? squashfs_fill_page+0x190/0x190
> [ 1534.866136]  ? psi_task_change+0x106/0x130
> [ 1534.866155]  ? raw_spin_rq_unlock+0x17/0x60
> [ 1534.866171]  read_pages+0x12d/0x530
> [ 1534.866186]  ? __kasan_check_read+0x11/0x20
> [ 1534.866200]  ? folio_batch_add_and_move+0x8d/0xa0
> [ 1534.866217]  ? file_ra_state_init+0x60/0x60
> [ 1534.866231]  ? folio_add_lru+0x47/0x70
> [ 1534.866249]  ? filemap_alloc_folio+0xcf/0x120
> [ 1534.866267]  page_cache_ra_unbounded+0x1eb/0x280
> [ 1534.866280]  ? __rcu_read_unlock+0x57/0x270
> [ 1534.866297]  do_page_cache_ra+0x7c/0x90
> [ 1534.866312]  page_cache_ra_order+0x3b4/0x420
> [ 1534.866330]  filemap_fault+0x849/0xe40
> [ 1534.866343]  ? read_cache_page_gfp+0x90/0x90
> [ 1534.866359]  __do_fault+0x76/0x1e0
> [ 1534.866372]  do_fault+0x1e5/0x6c0
> [ 1534.866384]  __handle_mm_fault+0x905/0x1740
> [ 1534.866399]  ? copy_page_range+0x2130/0x2130
> [ 1534.866412]  ? mas_find+0x100/0x100
> [ 1534.866428]  handle_mm_fault+0x11c/0x3b0
> [ 1534.866443]  do_user_addr_fault+0x261/0x8b0
> [ 1534.866456]  ? exit_to_user_mode_prepare+0x9b/0x190
> [ 1534.866472]  exc_page_fault+0x61/0xf0
> [ 1534.866486]  asm_exc_page_fault+0x27/0x30
> [ 1534.866498] RIP: 0033:0x7fe93673dd00
> [ 1534.866515] Code: Unable to access opcode bytes at 0x7fe93673dcd6.
> [ 1534.866521] RSP: 002b:00007fe923efeea8 EFLAGS: 00010246
> [ 1534.866532] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> [ 1534.866539] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
> [ 1534.866545] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fe837100098
> [ 1534.866553] R10: 00007fe868300de8 R11: 0000000000000217 R12: 00007fff95860b2e
> [ 1534.866561] R13: 00007fff95860b2f R14: 00007fff95860bf8 R15: 00007fe923efef80
> [ 1534.866576]  </TASK>
> 
> Thank you,
> Mirsad
> 
> -- 
> Mirsad Goran Todorovac
> Sistem inženjer
> Grafički fakultet | Akademija likovnih umjetnosti
> Sveučilište u Zagrebu

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

--------------PbCOzgUgOSwftG9QV4F5jePY
Content-Type: application/x-xz; name="dmesg-5.19-rc1.log.xz"
Content-Disposition: attachment; filename="dmesg-5.19-rc1.log.xz"
Content-Transfer-Encoding: base64

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
AAGc1gGBsQgFiQoEscRn+wIAAAAABFla

--------------PbCOzgUgOSwftG9QV4F5jePY--
