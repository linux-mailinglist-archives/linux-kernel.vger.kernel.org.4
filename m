Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26E6095E3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJWToo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiJWToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:44:38 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B311613E89
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:44:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id n130so8975100yba.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FSLMeTaIxMz88Yy3aw+LgzwTzfCKyUlZVkQWBr3Qbe4=;
        b=gxd3mfy/xexXP4lIMHYW/9BQOw3wh/q+CasAScr646LjYYg7/2r6rSe8s9qQqdFsD5
         8rAzuYWDkZq9Fg6KPHYPY8CHN1+Wz2/vA7Loz52Cn38Mcbv22PtRXcwBPUgOQekM1E2f
         UKL2jDt9wYQ1ek7RIlOOOw1M9eYfK5UF6K2F4GDdDZAbEfrxm/Zp+ffCFngOfHhwfwJQ
         3PsXHPse/fS+jaFAJK+I4jbDxpdv3fGFifHVnohGD6D1u3gPDsHscywLUr2x6qmi8Oro
         abGh5cTUjQcmtA0ifAVut8HrnTRsZeTM0+dB/uEuzcZNQGtbC9nsIIwWMDbxsE7vic6W
         sTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSLMeTaIxMz88Yy3aw+LgzwTzfCKyUlZVkQWBr3Qbe4=;
        b=NJTg33uQUSZRzrnmL12vFOiSKeTx403fV9hnuck0t9KrULzlM9u4KDoShaU7z7dUH2
         xv9/okz+M9HKmZ85/YlR/FTubvIb2I7+9c4grotBUCps3pUo7kEmvp8+x4peYL4fO5Rz
         d2ZXzzAMCkuKjgvb/hXcNTe3pClnTqyj07S0Wxh05P7UH3Klj+YpYtKzw10DjlRGWxP3
         v82jcACpRLZu9epv6KrCBktjv3xJtlvVvUIFIdyngubpJI3IqlSs+ghsCm4d/OweZt04
         HXmOR8iHy0OJca0o5ydp25WroMu9xQeViYOuqrphl99Y5/1UNqBcPq6CStNg1GJ1I7c/
         JySg==
X-Gm-Message-State: ACrzQf0IWc2u6dWe51raBoKHisJOTwUCr2TFbZMW9oRnIwKipTiDqYjN
        qfCi5LS1NeNeH/yAp7dfzSBiFqblslhXd1QlNky5Iw==
X-Google-Smtp-Source: AMsMyM6EYUG8rbywrLFKJDS0NebSr1gF6s3+efCdwho1X/K6D4iBk55/PnouW/xi5EdYYfBAZOqW2g5lJe6pIHEu5Yw=
X-Received: by 2002:a05:6902:1101:b0:6ca:c770:34a7 with SMTP id
 o1-20020a056902110100b006cac77034a7mr5019524ybu.431.1666554274700; Sun, 23
 Oct 2022 12:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009fa63105eb7648d8@google.com> <00000000000031aec805eb76a2d4@google.com>
 <20221020182155.ecd44ee984b1aeb2e5a2e8ed@linux-foundation.org>
 <CAJuCfpEh0byROe58H_FtL+NMLKAvSrQW0f0wd3QiVTBdRg5CTA@mail.gmail.com>
 <CAJuCfpF7xsZJevfj6ERsJi5tPFj0o6FATAm4k=CMsONFG86EmQ@mail.gmail.com>
 <CANp29Y7aNP+0hd01feB24XrCUPVa0+7kf7NiDAV_FdhPx2VkOQ@mail.gmail.com>
 <CAJuCfpF0eYsNZjQO4OcT8Pnaj9+H8UK_o4bwtLzD=n53-48hJw@mail.gmail.com>
 <CANp29Y4Q3X_KqxjajigGHXHFaY54vEdYkPf+5tcg3k2YyRh+jw@mail.gmail.com>
 <CAJuCfpGOF7fvMH671rBJyGQiEPXVs7E3SnoNeEJBAwV6jBH07A@mail.gmail.com>
 <CANp29Y4yM0W+SJ7tDkENJHBr-pfKyNgzML_W3EZib+-jbnCXWQ@mail.gmail.com> <9317bb19-5404-aada-a314-731f3ebe655c@I-love.SAKURA.ne.jp>
In-Reply-To: <9317bb19-5404-aada-a314-731f3ebe655c@I-love.SAKURA.ne.jp>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 23 Oct 2022 12:44:23 -0700
Message-ID: <CAJuCfpGsnRnXmKVcMG-y-6psFnvSKVhmv+3oO+72ERH8=um+2g@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in vm_area_dup
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Aleksandr Nogikh <nogikh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com>,
        bigeasy@linutronix.de, bpf@vger.kernel.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 3:07 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/10/22 13:55, Aleksandr Nogikh wrote:
> > It worked for me:
> >
> > wget 'https://storage.googleapis.com/syzbot-assets/98cc5896cded/disk-acee3e83.raw.xz'
> > unxz disk-acee3e83.raw.xz
> > qemu-system-x86_64 -smp 2,sockets=2,cores=1 -m 4G -drive file=disk-acee3e83.raw,format=raw -snapshot -nographic -enable-kvm

Yep, that worked, thanks!

>
> Thanks for command line example.
>
> I tried to add -append option in order to disable modules which cause lockdep splat, but failed
> due to missing -kernel option. Then, I tried to pass downloaded vmlinux to -kernel option in order
> to be able to use -append option, but failed again due to file format difference.
>
> Downloadable vmlinux might be useful for calculating symbol addresses, but downloadable vmlinuz
> would be more helpful for passing to boot loader (with modified kernel command line options).
>
> Anyway, already fixed by commit b232a629b70cccb65d0c in linux-next-20221021.

Thank you for confirming, Tetsuo!

>
> #syz fix: mm/ksm: convert break_ksm() to use walk_page_range_vma()
>
> [   43.563343]
> [   43.564256] ======================================================
> [   43.565865] WARNING: possible circular locking dependency detected
> [   43.567533] 6.1.0-rc1-next-20221021+ #2 Not tainted
> [   43.568874] ------------------------------------------------------
> [   43.571009] a.out/853 is trying to acquire lock:
> [   43.572628] ffffffffa72c0b20 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc+0x46/0x2b0
> [   43.574677]
> [   43.574677] but task is already holding lock:
> [   43.576837] ffff889d041e3498 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: break_ksm_pmd_entry+0xf8/0x290
> [   43.579093]
> [   43.579093] which lock already depends on the new lock.
> [   43.579093]
> [   43.582819]
> [   43.582819] the existing dependency chain (in reverse order) is:
> [   43.585488]
> [   43.585488] -> #2 (ptlock_ptr(page)#2){+.+.}-{2:2}:
> [   43.587988]        _raw_spin_lock+0x39/0x90
> [   43.589391]        page_vma_mapped_walk+0x737/0xa80
> [   43.590934]        page_vma_mkclean_one.constprop.0+0xf3/0x240
> [   43.592609]        page_mkclean_one+0x94/0xe0
> [   43.594110]        rmap_walk_file+0xf5/0x360
> [   43.595560]        folio_mkclean+0xb3/0xf0
> [   43.597006]        folio_clear_dirty_for_io+0x60/0x2b0
> [   43.598681]        clear_page_dirty_for_io+0x18/0x60
> [   43.600626]        mpage_submit_page+0x24/0x90
> [   43.602020]        mpage_process_page_bufs+0x16c/0x190
> [   43.603635]        mpage_prepare_extent_to_map+0x240/0x4f0
> [   43.605437]        ext4_writepages+0x3cf/0x1400
> [   43.606957]        do_writepages+0xd6/0x1f0
> [   43.608400]        filemap_fdatawrite_wbc+0x75/0xb0
> [   43.609942]        __filemap_fdatawrite_range+0x54/0x80
> [   43.611580]        file_write_and_wait_range+0x53/0xc0
> [   43.613146]        ext4_sync_file+0x135/0x480
> [   43.614603]        vfs_fsync_range+0x49/0xa0
> [   43.615996]        __x64_sys_fsync+0x38/0x80
> [   43.617405]        do_syscall_64+0x5c/0xa0
> [   43.618758]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   43.620390]
> [   43.620390] -> #1 (&mapping->i_mmap_rwsem){++++}-{3:3}:
> [   43.622828]        down_write+0x46/0x120
> [   43.624209]        dma_resv_lockdep+0x1d3/0x2cc
> [   43.625681]        do_one_initcall+0x62/0x350
> [   43.627076]        kernel_init_freeable+0x2ec/0x364
> [   43.628517]        kernel_init+0x1b/0x170
> [   43.629846]        ret_from_fork+0x2c/0x50
> [   43.631195]
> [   43.631195] -> #0 (fs_reclaim){+.+.}-{0:0}:
> [   43.633265]        __lock_acquire+0x1300/0x2200
> [   43.634630]        lock_acquire+0xd6/0x320
> [   43.635920]        fs_reclaim_acquire+0xaa/0xf0
> [   43.637324]        kmem_cache_alloc+0x46/0x2b0
> [   43.638762]        vm_area_dup+0x25/0xa0
> [   43.640067]        copy_vma+0x102/0x270
> [   43.641271]        move_vma+0x147/0x4d0
> [   43.642509]        __do_sys_mremap+0x206/0x970
> [   43.643826]        __x64_sys_mremap+0x25/0x40
> [   43.645106]        do_syscall_64+0x5c/0xa0
> [   43.646367]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   43.647894]
> [   43.647894] other info that might help us debug this:
> [   43.647894]
> [   43.650937] Chain exists of:
> [   43.650937]   fs_reclaim --> &mapping->i_mmap_rwsem --> ptlock_ptr(page)#2
> [   43.650937]
> [   43.650953]  Possible unsafe locking scenario:
> [   43.650953]
> [   43.650955]        CPU0                    CPU1
> [   43.650956]        ----                    ----
> [   43.650958]   lock(ptlock_ptr(page)#2);
> [   43.650965]                                lock(&mapping->i_mmap_rwsem);
> [   43.661146]                                lock(ptlock_ptr(page)#2);
> [   43.662821]   lock(fs_reclaim);
> [   43.663892]
> [   43.663892]  *** DEADLOCK ***
> [   43.663892]
> [   43.666474] 2 locks held by a.out/853:
> [   43.667641]  #0: ffff889d062d1730 (&mm->mmap_lock#2){++++}-{3:3}, at: __do_sys_mremap+0xfe/0x970
> [   43.669803]  #1: ffff889d041e3498 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: break_ksm_pmd_entry+0xf8/0x290
> [   43.672539]
> [   43.672539] stack backtrace:
> [   43.674396] CPU: 3 PID: 853 Comm: a.out Not tainted 6.1.0-rc1-next-20221021+ #2
> [   43.676232] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [   43.678257] Call Trace:
> [   43.679255]  <TASK>
> [   43.680192]  dump_stack_lvl+0x5a/0x88
> [   43.681416]  find_cpio_data.cold-0x6/0x5b
> [   43.682714]  print_shortest_lock_dependencies.cold-0x5/0x8d
> [   43.684297]  check_noncircular+0x103/0x130
> [   43.685630]  __lock_acquire+0x1300/0x2200
> [   43.686973]  lock_acquire+0xd6/0x320
> [   43.688182]  ? kmem_cache_alloc+0x46/0x2b0
> [   43.689489]  ? __lock_acquire+0x3e1/0x2200
> [   43.691049]  fs_reclaim_acquire+0xaa/0xf0
> [   43.692395]  ? kmem_cache_alloc+0x46/0x2b0
> [   43.693760]  kmem_cache_alloc+0x46/0x2b0
> [   43.695117]  ? vm_area_dup+0x25/0xa0
> [   43.696337]  vm_area_dup+0x25/0xa0
> [   43.697570]  ? sched_clock+0x9/0x20
> [   43.698812]  ? __memcpy-0xd/0x30
> [   43.699955]  ? lock_release+0x14e/0x4b0
> [   43.701206]  ? mt_find+0x179/0x660
> [   43.702346]  ? vma_merge+0x232/0x340
> [   43.703597]  ? copy_vma+0xa0/0x270
> [   43.704748]  copy_vma+0x102/0x270
> [   43.705956]  move_vma+0x147/0x4d0
> [   43.707157]  ? thp_get_unmapped_area+0xca/0xf0
> [   43.708528]  __do_sys_mremap+0x206/0x970
> [   43.709786]  ? syscall_enter_from_user_mode+0x21/0x70
> [   43.711208]  ? __memcpy-0xd/0x30
> [   43.712369]  ? lockdep_hardirqs_on+0x86/0x120
> [   43.713722]  __x64_sys_mremap+0x25/0x40
> [   43.715013]  do_syscall_64+0x5c/0xa0
> [   43.716269]  ? syscall_exit_to_user_mode+0x37/0x60
> [   43.717682]  ? do_syscall_64+0x69/0xa0
> [   43.718826]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   43.720245] RIP: 0033:0x447e8d
> [   43.721412] Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [   43.726518] RSP: 002b:00007fffb8598528 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> [   43.728446] RAX: ffffffffffffffda RBX: 00007fffb8598738 RCX: 0000000000447e8d
> [   43.730346] RDX: 0000000000001000 RSI: 0000000000004000 RDI: 00000000201c4000
> [   43.732299] RBP: 0000000000000001 R08: 00000000202ef000 R09: 0000000000000000
> [   43.734174] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000001
> [   43.735999] R13: 00007fffb8598728 R14: 00000000004c17d0 R15: 0000000000000001
> [   43.737958]  </TASK>
> [   43.739102] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> [   43.741273] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 853, name: a.out
> [   43.743400] preempt_count: 1, expected: 0
> [   43.744780] RCU nest depth: 0, expected: 0
> [   43.746249] INFO: lockdep is turned off.
> [   43.747628] Preemption disabled at:
> [   43.747631] [<ffffffffa5c04158>] break_ksm_pmd_entry+0xf8/0x290
> [   43.750708] CPU: 3 PID: 853 Comm: a.out Not tainted 6.1.0-rc1-next-20221021+ #2
> [   43.752741] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [   43.754964] Call Trace:
> [   43.756143]  <TASK>
> [   43.757235]  dump_stack_lvl+0x5a/0x88
> [   43.758628]  find_cpio_data.cold-0x6/0x5b
> [   43.760044]  __might_resched.cold+0x13c/0x162
> [   43.761536]  __might_sleep+0x50/0xa0
> [   43.762967]  kmem_cache_alloc+0x265/0x2b0
> [   43.764408]  ? vm_area_dup+0x25/0xa0
> [   43.765785]  vm_area_dup+0x25/0xa0
> [   43.767175]  ? sched_clock+0x9/0x20
> [   43.768530]  ? __memcpy-0xd/0x30
> [   43.769802]  ? lock_release+0x14e/0x4b0
> [   43.771288]  ? mt_find+0x179/0x660
> [   43.772931]  ? vma_merge+0x232/0x340
> [   43.774290]  ? copy_vma+0xa0/0x270
> [   43.775603]  copy_vma+0x102/0x270
> [   43.776899]  move_vma+0x147/0x4d0
> [   43.778168]  ? thp_get_unmapped_area+0xca/0xf0
> [   43.779641]  __do_sys_mremap+0x206/0x970
> [   43.780984]  ? syscall_enter_from_user_mode+0x21/0x70
> [   43.782511]  ? __memcpy-0xd/0x30
> [   43.783682]  ? lockdep_hardirqs_on+0x86/0x120
> [   43.785057]  __x64_sys_mremap+0x25/0x40
> [   43.786346]  do_syscall_64+0x5c/0xa0
> [   43.787603]  ? syscall_exit_to_user_mode+0x37/0x60
> [   43.789037]  ? do_syscall_64+0x69/0xa0
> [   43.790337]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   43.791934] RIP: 0033:0x447e8d
> [   43.793053] Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [   43.798111] RSP: 002b:00007fffb8598528 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> [   43.800098] RAX: ffffffffffffffda RBX: 00007fffb8598738 RCX: 0000000000447e8d
> [   43.802002] RDX: 0000000000001000 RSI: 0000000000004000 RDI: 00000000201c4000
> [   43.803916] RBP: 0000000000000001 R08: 00000000202ef000 R09: 0000000000000000
> [   43.805887] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000001
> [   43.807773] R13: 00007fffb8598728 R14: 00000000004c17d0 R15: 0000000000000001
> [   43.809648]  </TASK>
>
>
