Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4948170C0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjEVOUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjEVOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:20:41 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB2F4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:20:29 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3942c6584f0so2058952b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684765228; x=1687357228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE7WKYKJoUyzqBoJ7pWcEG4sFnUkFiK40AdwSey28Ac=;
        b=DLHBFYV+EI+UyyiLhHQoMegk4asD7tHEkKjySGQ5rGv9bUgOoFwTZIKw3VbCC+RWRv
         BcRMH3sJ21rn37oFOVrazHyuXw4/Ajy/f5PDTeo1JNgBxh6LJGxghdVKmeUdbiv9SFsS
         XI7vqC6SMc91Kl5WIOxLgw1Qq9DCMbVCmXB55v72Vll/2Wz5mrD3IVR8od0dDFBWd4Ve
         poPcmJTGrM4zgey4FQGRu5JnbPIF7bliQmjdzUfBBSpay6hVIU5JMUkZ/SRlFra0EQog
         94Sq3cn5HC51ycEvYuMJ/8o+XUtVoj74fQBScpIso5aw2pkpFWcTWqk4FF7itHQDF2v4
         cYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684765228; x=1687357228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE7WKYKJoUyzqBoJ7pWcEG4sFnUkFiK40AdwSey28Ac=;
        b=crG8kfFlQjlQ8PEEBwY9ixwjjxEAUghyX6EEF2XUSlHbXDVgPDvIyWyPCb4PIuR+Wu
         0qXO/J0E+MVsEmcQjvuG1UGjp24B/aO9s2k+0ZoFvAb4PWfO3FZGnuku2+Wbs+4Uuz7v
         xSaqElb+J/si22ihk7Vfq/ekzRNLK7Yv8w4Y6Xj1Y3kyKgTmEmPY4DZb9/rkDbsIQK3s
         ulP/flexw3XFGK4wQ0E4VdIRyEdzAImB8ADah3ut5j36Vm0W1HEHKDs37GC4H+OHDNzo
         GC1QMcyDzV5u4hbRW5ZittSPpUotBWc7yqJq5wE3a7zEymhfq+HzDa11YB5paJOKOMNz
         2VoA==
X-Gm-Message-State: AC+VfDyIpRR5RpUt1u3oRdL2tY9tBkHTQCM3b4gvUjjh0PnjPh3MYWQM
        XucZwvKLvxD9tkXKuXjLilPF7SKNXho0D/R5zSM=
X-Google-Smtp-Source: ACHHUZ7eZ0GNtCudA8zuTJFy57Sa3xUxPzQs64UHXVeFTkbE3lJTRZFzUFIuPEU2YIlQBbcDa3zFUNetLeghNn/DbkI=
X-Received: by 2002:aca:1a06:0:b0:392:4511:d893 with SMTP id
 a6-20020aca1a06000000b003924511d893mr5038282oia.3.1684765228507; Mon, 22 May
 2023 07:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XMJC=u5aASRNCqfVi7tJwDJBYGCw5i13M-R8zXdB9-8Ew@mail.gmail.com>
 <986151e4-66ef-b76d-f66d-318017f34b5d@kernel.org> <CAFcO6XNEZVpyPNNuU9X0wub-hrWcfwWX1bP1MT3ggddfgPvmTg@mail.gmail.com>
 <c5bf15c0-932c-5466-3663-92ecebab4760@kernel.org>
In-Reply-To: <c5bf15c0-932c-5466-3663-92ecebab4760@kernel.org>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Mon, 22 May 2023 22:20:16 +0800
Message-ID: <CAFcO6XPhm1_9rKNzM1YWVoH5aPxMyFSgO-nXkf2a=Mqn9xvFEw@mail.gmail.com>
Subject: Re: A null-ptr-deref bug in f2fs_write_end_io
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested the patch, it works fine.


Regards,
 butt3rflyh4ck.

On Mon, May 22, 2023 at 8:44=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/5/22 11:58, butt3rflyh4ck wrote:
> > OK, the attachment is a reproducer.
>
> Thank you!
>
> I've figured out a patch, could you please have a try w/ this patch?
>
> https://lore.kernel.org/linux-f2fs-devel/20230522124203.3838360-1-chao@ke=
rnel.org/
>
> Thanks,
>
> >
> > Regards.
> >   butt3rflyh4ck.
> >
> > On Fri, May 19, 2023 at 11:24=E2=80=AFPM Chao Yu <chao@kernel.org> wrot=
e:
> >>
> >> Hi,
> >>
> >> Thanks for the report, it will be helpful if you can provide a
> >> reproducer.
> >>
> >> On 2023/5/19 15:13, butt3rflyh4ck wrote:
> >>> Hi, there is a null-ptr-deref  bug in f2fs_write_end_io in
> >>> fs/f2fs/data.c, I reproduce it in the latest kernel too.
> >>>
> >>> #Quick description
> >>> When a thread always calls F2FS_IOC_RESIZE_FS to  resize fs, if resiz=
e
> >>> fs is failed, f2fs kernel thread would  invoke callback function to
> >>> update
> >>> f2fs io info, it would call  f2fs_write_end_io and may trigger
> >>> null-ptr-deref in NODE_MAPPING.
> >>> ```
> >>> static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info =
*sbi)
> >>> {
> >>> return sbi->node_inode->i_mapping;
> >>> }
> >>> ```
> >>> there is deref in sbi.
> >>>
> >>> #crash log
> >>> ----------------------------------------
> >>> general protection fault, probably for non-canonical address
> >>> 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
> >>> KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037=
]
> >>> CPU: 0 PID: 17 Comm: ksoftirqd/0 Not tainted 6.4.0-rc1 #18
> >>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 =
04/01/2014
> >>> RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:1972 [inline]
> >>> RIP: 0010:f2fs_write_end_io+0x727/0x1050 fs/f2fs/data.c:370
> >>> Code: 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 b3 07 00 00 48 8b
> >>> 44 24 08 4c 8b a8 60 01 00 00 49 8d 7d 30 48 89 f8 48 c1 e8 03 <80> 3=
c
> >>> 18 00 0f 85 9c 07 00 00 4d 3b 75 30 0f 84 10 04 00 00 e8 10
> >>> RSP: 0018:ffffc9000042fc78 EFLAGS: 00010216
> >>> RAX: 0000000000000006 RBX: dffffc0000000000 RCX: 0000000000000100
> >>> RDX: ffff888013d18000 RSI: ffffffff83a93a4d RDI: 0000000000000030
> >>> RBP: ffffea00009e6900 R08: 0000000000000001 R09: 0000000000000000
> >>> R10: 0000000000000000 R11: 0000000000000000 R12: ffffea00009e6900
> >>> R13: 0000000000000000 R14: ffff88802a3cec48 R15: 0000000000000000
> >>> FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:000000000=
0000000
> >>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: 0000555faf194000 CR3: 00000000251bd000 CR4: 0000000000750ef0
> >>> PKRU: 55555554
> >>> Call Trace:
> >>>    <TASK>
> >>>    bio_endio+0x5af/0x6c0 block/bio.c:1608
> >>>    req_bio_endio block/blk-mq.c:761 [inline]
> >>>    blk_update_request+0x5cc/0x1690 block/blk-mq.c:906
> >>>    blk_mq_end_request+0x59/0x4c0 block/blk-mq.c:1023
> >>>    lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
> >>>    blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1101
> >>>    __do_softirq+0x1d4/0x8ef kernel/softirq.c:571
> >>>    run_ksoftirqd kernel/softirq.c:939 [inline]
> >>>    run_ksoftirqd+0x31/0x60 kernel/softirq.c:931
> >>>    smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
> >>>    kthread+0x33e/0x440 kernel/kthread.c:379
> >>>    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> >>>    </TASK>
> >>> Modules linked in:
> >>> ---[ end trace 0000000000000000 ]---
> >>> RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:1972 [inline]
> >>> RIP: 0010:f2fs_write_end_io+0x727/0x1050 fs/f2fs/data.c:370
> >>> Code: 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 b3 07 00 00 48 8b
> >>> 44 24 08 4c 8b a8 60 01 00 00 49 8d 7d 30 48 89 f8 48 c1 e8 03 <80> 3=
c
> >>> 18 00 0f 85 9c 07 00 00 4d 3b 75 30 0f 84 10 04 00 00 e8 10
> >>> RSP: 0018:ffffc9000042fc78 EFLAGS: 00010216
> >>> RAX: 0000000000000006 RBX: dffffc0000000000 RCX: 0000000000000100
> >>> RDX: ffff888013d18000 RSI: ffffffff83a93a4d RDI: 0000000000000030
> >>> RBP: ffffea00009e6900 R08: 0000000000000001 R09: 0000000000000000
> >>> R10: 0000000000000000 R11: 0000000000000000 R12: ffffea00009e6900
> >>> R13: 0000000000000000 R14: ffff88802a3cec48 R15: 0000000000000000
> >>> FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:000000000=
0000000
> >>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: 0000555faf194000 CR3: 00000000251bd000 CR4: 0000000000750ef0
> >>> PKRU: 55555554
> >>> -----------------------
> >>>
> >>> # new crash log in latest kernel
> >>> ---------------------
> >>> [  193.695164][ T8174] loop0: detected capacity change from 0 to 2641=
92
> >>> [  193.696467][ T8174] F2FS-fs (loop0): Magic Mismatch,
> >>> valid(0xf2f52010) - read(0x0)
> >>> [  193.696875][ T8174] F2FS-fs (loop0): Can't find valid F2FS
> >>> filesystem in 2th superblock
> >>> [  193.698363][ T8174] F2FS-fs (loop0): invalid crc_offset: 0
> >>> [  193.700454][ T8174] F2FS-fs (loop0): Disable nat_bits due to
> >>> incorrect cp_ver (4542359912962316977, 0)
> >>> [  193.716594][ T8174] F2FS-fs (loop0): Try to recover 2th superblock=
, ret: 0
> >>> [  193.717102][ T8174] F2FS-fs (loop0): Mounted with checkpoint
> >>> version =3D 3e17dab1
> >>> [  193.743330][ T8174] F2FS-fs (loop0): For resize: curseg of type 0:=
 46 =3D=3D> 4
> >>> [  193.743904][ T8174] F2FS-fs (loop0): For resize: curseg of type 3:=
 52 =3D=3D> 6
> >>> [  193.745690][ T8174] F2FS-fs (loop0): For resize: curseg of type 4:=
 50 =3D=3D> 8
> >>> [  193.746108][ T8174] F2FS-fs (loop0): For resize: curseg of type 5:=
 48 =3D=3D> 10
> >>> [  193.751857][ T8174] F2FS-fs (loop0): resize_fs failed, should run
> >>> fsck to repair!
> >>> [  193.780283][    C0] general protection fault, probably for
> >>> non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
> >>> [  193.781027][    C0] KASAN: null-ptr-deref in range
> >>> [0x0000000000000030-0x0000000000000037]
> >>> [  193.781572][    C0] CPU: 0 PID: 17 Comm: ksoftirqd/0 Not tainted
> >>> 6.4.0-rc2-00163-g2d1bcbc6cd70-dirty #17
> >>> [  193.782201][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX=
,
> >>> 1996), BIOS 1.15.0-1 04/01/2014
> >>> [  193.782727][    C0] RIP: 0010:f2fs_write_end_io+0x727/0x1050
> >>> [  193.783083][    C0] Code: 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0=
f
> >>> 85 b3 07 00 00 48 8b 44 24 08 4c 8b a8 60 01 00 00 49 8d 7d 30 48 89
> >>> f8 48 c1 e8 03 <80> 3c 18 00 0f 85 9c 07 00 00 4d 3b 75 30 0f 0
> >>> [  193.784268][    C0] RSP: 0018:ffffc9000042fc78 EFLAGS: 00010216
> >>> [  193.784629][    C0] RAX: 0000000000000006 RBX: dffffc0000000000
> >>> RCX: 0000000000000100
> >>> [  193.785109][    C0] RDX: ffff888013d18000 RSI: ffffffff83a9588d
> >>> RDI: 0000000000000030
> >>> [  193.785576][    C0] RBP: ffffea000143e740 R08: 0000000000000001
> >>> R09: 0000000000000000
> >>> [  193.786051][    C0] R10: 0000000000000000 R11: 0000000000000000
> >>> R12: ffffea000143e740
> >>> [  193.786571][    C0] R13: 0000000000000000 R14: ffff888041423738
> >>> R15: 0000000000000000
> >>> [  193.787055][    C0] FS:  0000000000000000(0000)
> >>> GS:ffff88802ca00000(0000) knlGS:0000000000000000
> >>> [  193.787620][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> >>> [  193.787997][    C0] CR2: 000056056fd87000 CR3: 000000001b546000
> >>> CR4: 00000000000006f0
> >>> [  193.788585][    C0] Call Trace:
> >>> [  193.788863][    C0]  <TASK>
> >>> [  193.789115][    C0]  ? bio_uninit+0x1b7/0x410
> >>> [  193.789509][    C0]  ? f2fs_write_end+0xa80/0xa80
> >>> [  193.790053][    C0]  bio_endio+0x5af/0x6c0
> >>> [  193.790522][    C0]  blk_update_request+0x5cc/0x1690
> >>> [  193.791171][    C0]  blk_mq_end_request+0x59/0x4c0
> >>> [  193.791695][    C0]  lo_complete_rq+0x1c6/0x280
> >>> [  193.792247][    C0]  blk_complete_reqs+0xad/0xe0
> >>> [  193.792759][    C0]  __do_softirq+0x1d4/0x8ef
> >>> [  193.793312][    C0]  ? __irq_exit_rcu+0x190/0x190
> >>> [  193.793805][    C0]  run_ksoftirqd+0x31/0x60
> >>> [  193.794183][    C0]  smpboot_thread_fn+0x659/0x9e0
> >>> [  193.794576][    C0]  ? sort_range+0x30/0x30
> >>> [  193.794900][    C0]  kthread+0x33e/0x440
> >>> [  193.795263][    C0]  ? kthread_complete_and_exit+0x40/0x40
> >>> [  193.795907][    C0]  ret_from_fork+0x1f/0x30
> >>> [  193.796324][    C0]  </TASK>
> >>> [  193.796689][    C0] Modules linked in:
> >>> [  193.797189][    C0] ---[ end trace 0000000000000000 ]---
> >>> [  193.797635][    C0] RIP: 0010:f2fs_write_end_io+0x727/0x1050
> >>> [  193.798182][    C0] Code: 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0=
f
> >>> 85 b3 07 00 00 48 8b 44 24 08 4c 8b a8 60 01 00 00 49 8d 7d 30 48 89
> >>> f8 48 c1 e8 03 <80> 3c 18 00 0f 85 9c 07 00 00 4d 3b 75 30 0f 0
> >>> [  193.799559][    C0] RSP: 0018:ffffc9000042fc78 EFLAGS: 00010216
> >>> [  193.799945][    C0] RAX: 0000000000000006 RBX: dffffc0000000000
> >>> RCX: 0000000000000100
> >>> [  193.800329][    C0] RDX: ffff888013d18000 RSI: ffffffff83a9588d
> >>> RDI: 0000000000000030
> >>> [  193.800666][    C0] RBP: ffffea000143e740 R08: 0000000000000001
> >>> R09: 0000000000000000
> >>> [  193.801047][    C0] R10: 0000000000000000 R11: 0000000000000000
> >>> R12: ffffea000143e740
> >>> [  193.801503][    C0] R13: 0000000000000000 R14: ffff888041423738
> >>> R15: 0000000000000000
> >>> [  193.802069][    C0] FS:  0000000000000000(0000)
> >>> GS:ffff88802ca00000(0000) knlGS:0000000000000000
> >>> [  193.802804][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> >>> [  193.803356][    C0] CR2: 000056056fd87000 CR3: 000000001b546000
> >>> CR4: 00000000000006f0
> >>> [  193.804046][    C0] Kernel panic - not syncing: Fatal exception in=
 interrupt
> >>> [  193.804748][    C0] Kernel Offset: disabled
> >>> [  193.805086][    C0] Rebooting in 86400 seconds..
> >>> ----------------------------
> >>>
> >>> If needed, I would provide reproduce.
> >>>
> >>> Regards,
> >>>    butt3rflyh4ck.
> >>>
> >>>
> >>>
> >
> >
> >



--=20
Active Defense Lab of Venustech
