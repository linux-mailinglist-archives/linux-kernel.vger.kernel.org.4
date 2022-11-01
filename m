Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276BA614450
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiKAFeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAFeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:34:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6F4FEF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:34:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f27so34569549eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0izjkeXmOlWfOleFlk/kOzx7RUjO4T1qiM2SYfuA5pI=;
        b=i1+VnU0BtifM0dVt8PV3ohRDvIwqNlZymdxp1zXQ7DuWHPXRgk34yFIs6HqacVJsSK
         TODTznVusuQPJiA1VcLQ0Rsr1z23gvAx34W6EhA8ie1NLEdoUU27BUMt6LopdaUZynDO
         ZyM6sCO9I7RdBG5f9WGzbvXh9g/3Mbj/VjQrKKvq+/Q1FBa9pHvOKgj8k0TIb46A5J5q
         wXXNzvo2Ti/Jy29sKQWCY5fllwDHexg+X7f4JnYGDQz5TyjBJPfdORQKaYmNllCfhWGX
         1O7sguzRVY0pZkeAX3bf6o66YUIqJtRwv7r3JXG1EAK67Yo0eIjF0qtkayNB/pDCfB7P
         jt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0izjkeXmOlWfOleFlk/kOzx7RUjO4T1qiM2SYfuA5pI=;
        b=gRoLyIhZYlTa/PDpeny61746A2hrsYK6EhK7Ia8V0AQvq5VYxylyRl9GiJC3ggrtlN
         RFxv7tur/71dKIyGDMoe9O8Vvp059EB8YmFnxpQSa1uwglIar1lGQtVI3CohmVR9PLlW
         CGPinNByDupAYi1WdO4e+Ycw3hYbkuMtEVIpCo9SuhZBCDl3wjkISnTeTJv+o5na2Xui
         fg5/92G9ihDSrHfx75DAbh85j3Y+odUewr7J9EDttZdDf4DCp25tFrGvUJfx/hQAI2Nq
         DhfFALEnRm+nI1NR1P1uJj68mtCm1uGbp6XrgEC+tcCpLNoMYAbROYe3+tV/LlzL5kcB
         nuFg==
X-Gm-Message-State: ACrzQf2GT2W0qNnj5fMkGSJ/dpy6dD6qhGEFOwBmDY/yG4JWgy1xRPRE
        WtSprUCQzzuLLT2E08r1TNlejpY9WBV3tgv8LvU=
X-Google-Smtp-Source: AMsMyM4F8k3d6YRJdQo9bcnV3woCSV4PZ2PyB07yGUOt3F9+Rg6dmLYVXAO6HoIbJQyRG6M3RQ3xgE8Kbk+zGJfkvYg=
X-Received: by 2002:a17:907:2d06:b0:78d:50db:130e with SMTP id
 gs6-20020a1709072d0600b0078d50db130emr16327035ejc.371.1667280846898; Mon, 31
 Oct 2022 22:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAO4mrfc5zN_QJ_92+SJTmLYhAyS2qLeYp8Ru7J5Wgf3sp-LSRQ@mail.gmail.com>
In-Reply-To: <CAO4mrfc5zN_QJ_92+SJTmLYhAyS2qLeYp8Ru7J5Wgf3sp-LSRQ@mail.gmail.com>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Tue, 1 Nov 2022 13:33:32 +0800
Message-ID: <CAO4mrfduo7WqdFqoXTAct7ScnaXGyCnz30x-HLGOMR6dAfS72g@mail.gmail.com>
Subject: Re: kernel BUG in ntfs_readpage
To:     anton@tuxera.com
Cc:     linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux developers,

Here is the link to the reproducers.

C reproducer: https://drive.google.com/file/d/1w3FkmO6CnWqcODexnjJ0hBuCJcSSWYNr/view?usp=share_link
Syz reproducer:
https://drive.google.com/file/d/1NLtEWT3SM_YmF1-3HmT7p4WqxFamsLoi/view?usp=share_link

The bug persists in the latest commit, v5.15.76 (4f5365f77018). I hope
it is helpful to you.

[   37.617243][ T6858] kernel BUG at fs/ntfs/aops.c:186!
[   37.618488][ T6858] invalid opcode: 0000 [#1] PREEMPT SMP
[   37.619767][ T6858] CPU: 0 PID: 6858 Comm: a.out Not tainted 5.15.76 #5
[   37.621298][ T6858] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[   37.624101][ T6858] RIP: 0010:ntfs_readpage+0xec4/0x14e0
[   37.625360][ T6858] Code: 04 90 ff 49 83 be 38 fd ff ff 00 0f 85 ab
f8 ff ff e8 60 04 90 ff 49 8b 86 30 fd ff ff a8 08 0f 85 97 f8 ff ff
e8 4c 04 90 ff <0f> 0b e8 45 04 90 ff 4c 63 a4 24 80 00 00 00 41 8d 6c
24 01 49 83
[   37.629794][ T6858] RSP: 0018:ffffc900025e3ab0 EFLAGS: 00010293
[   37.631178][ T6858] RAX: 0000000000000000 RBX: 0000000000000001
RCX: 0000000000000000
[   37.632989][ T6858] RDX: ffff88801522d340 RSI: ffffffff81a81c34
RDI: 0000000000000000
[   37.634790][ T6858] RBP: ffff88800c700000 R08: 0000000000000001
R09: 0000000000000000
[   37.636600][ T6858] R10: ffffc900025e3a90 R11: 0000000000000000
R12: 0000000000000020
[   37.638405][ T6858] R13: 0000000000000000 R14: ffff88800c700320
R15: ffffea00004d82c0
[   37.640217][ T6858] FS:  00007f830f5a1700(0000)
GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   37.642251][ T6858] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.643747][ T6858] CR2: 00007f830ef35f20 CR3: 00000000139ab000
CR4: 00000000003506f0
[   37.645546][ T6858] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   37.647396][ T6858] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   37.649207][ T6858] Call Trace:
[   37.649951][ T6858]  <TASK>
[   37.650615][ T6858]  ? lock_acquire+0x211/0x350
[   37.651686][ T6858]  ? rcu_read_lock_held_common+0x9/0x40
[   37.652946][ T6858]  ? rcu_read_lock_sched_held+0x1e/0x80
[   37.654199][ T6858]  ? lock_release+0xe8/0x2e0
[   37.655241][ T6858]  ? lru_cache_add+0x204/0x510
[   37.656327][ T6858]  ? add_to_page_cache_lru+0x128/0x310
[   37.657567][ T6858]  do_read_cache_page+0x759/0xa10
[   37.658708][ T6858]  ? mark_held_locks+0x49/0x70
[   37.659813][ T6858]  ? map_mft_record+0x2b/0x530
[   37.660899][ T6858]  ? ntfs_attr_find+0x1a5/0x300
[   37.661998][ T6858]  map_mft_record+0x9e/0x530
[   37.663037][ T6858]  ntfs_read_locked_inode+0x55/0x1910
[   37.664261][ T6858]  ntfs_read_inode_mount+0x430/0xe10
[   37.665461][ T6858]  ntfs_fill_super+0x771/0x14b0
[   37.666623][ T6858]  ? load_system_files+0x2e20/0x2e20
[   37.667833][ T6858]  mount_bdev+0x1df/0x240
[   37.668822][ T6858]  legacy_get_tree+0x2e/0x80
[   37.669871][ T6858]  vfs_get_tree+0x28/0x100
[   37.670878][ T6858]  path_mount+0x926/0xce0
[   37.671869][ T6858]  ? putname+0x83/0xa0
[   37.672800][ T6858]  do_mount+0x92/0xb0
[   37.673709][ T6858]  __x64_sys_mount+0xb0/0x120
[   37.674774][ T6858]  do_syscall_64+0x34/0xb0
[   37.675795][ T6858]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   37.677142][ T6858] RIP: 0033:0x7f830eeb548a
[   37.678158][ T6858] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d de f9 2a 00 f7 d8
64 89 01 48
[   37.682589][ T6858] RSP: 002b:00007f830f5a0bc8 EFLAGS: 00000286
ORIG_RAX: 00000000000000a5
[   37.684610][ T6858] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007f830eeb548a
[   37.686416][ T6858] RDX: 0000000020000000 RSI: 0000000020000100
RDI: 00007f830f5a0d00
[   37.688677][ T6858] RBP: 00007f830f5a0d80 R08: 00007f830f5a0c00
R09: 0000000000000000
[   37.690617][ T6858] R10: 0000000000000000 R11: 0000000000000286
R12: 00007ffd1df2708e
[   37.692423][ T6858] R13: 00007ffd1df2708f R14: 00007f830f581000
R15: 0000000000000003
[   37.694231][ T6858]  </TASK>
[   37.694913][ T6858] Modules linked in:
[   37.701427][ T6858] ---[ end trace d2c3baab557b05de ]---
[   37.702710][ T6858] RIP: 0010:ntfs_readpage+0xec4/0x14e0
[   37.704006][ T6858] Code: 04 90 ff 49 83 be 38 fd ff ff 00 0f 85 ab
f8 ff ff e8 60 04 90 ff 49 8b 86 30 fd ff ff a8 08 0f 85 97 f8 ff ff
e8 4c 04 90 ff <0f> 0b e8 45 04 90 ff 4c 63 a4 24 80 00 00 00 41 8d 6c
24 01 49 83
[   37.708533][ T6858] RSP: 0018:ffffc900025e3ab0 EFLAGS: 00010293
[   37.709941][ T6858] RAX: 0000000000000000 RBX: 0000000000000001
RCX: 0000000000000000
[   37.712280][ T6858] RDX: ffff88801522d340 RSI: ffffffff81a81c34
RDI: 0000000000000000
[   37.714196][ T6858] RBP: ffff88800c700000 R08: 0000000000000001
R09: 0000000000000000
[   37.716018][ T6858] R10: ffffc900025e3a90 R11: 0000000000000000
R12: 0000000000000020
[   37.717827][ T6858] R13: 0000000000000000 R14: ffff88800c700320
R15: ffffea00004d82c0
[   37.719640][ T6858] FS:  00007f830f5a1700(0000)
GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   37.722186][ T6858] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.723717][ T6858] CR2: 00007f7e1963a000 CR3: 00000000139ab000
CR4: 00000000003506f0
[   37.725528][ T6858] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   37.727333][ T6858] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   37.729145][ T6858] Kernel panic - not syncing: Fatal exception
[   37.731230][ T6858] Kernel Offset: disabled
[   37.732232][ T6858] Rebooting in 86400 seconds..

Best,
Wei

On Sun, 30 Oct 2022 at 17:16, Wei Chen <harperchen1110@gmail.com> wrote:
>
> Dear Linux Developer,
>
> Recently when using our tool to fuzz kernel, the following crash was triggered:
>
> HEAD commit: 64570fbc14f8 Linux 5.15-rc5
> git tree: upstream
> compiler: gcc 8.0.1
> console output:
> https://drive.google.com/file/d/1Vgv6uKdZ3XXWzqYUatGc_ca7xD5nHFbz/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
>
> loop0: detected capacity change from 0 to 67
> ------------[ cut here ]------------
> kernel BUG at fs/ntfs/aops.c:186!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 22515 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
> RIP: 0010:ntfs_readpage+0x1468/0x1860
> Code: 0e 2c 7d ff 49 8b 9f 30 fd ff ff 31 ff 48 c1 eb 03 83 e3 01 48
> 89 de e8 16 2d 7d ff 48 85 db 0f 85 61 f5 ff ff e8 e8 2b 7d ff <0f> 0b
> e8 e1 2b 7d ff f0 41 80 0c 24 10 e9 d9 f8 ff ff e8 d1 2b 7d
> RSP: 0018:ffffc900022bfaf0 EFLAGS: 00010206
> RAX: 0000000000009cb0 RBX: 0000000000000000 RCX: 0000000000040000
> RDX: ffffc90001311000 RSI: ffff8881095cb700 RDI: 0000000000000002
> RBP: 0000000000000020 R08: ffffffff81c04778 R09: 0000000000000000
> R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffea00044bf8c0 R14: ffff88810fea4d80 R15: ffff88810fea50a0
> FS:  00007fc3f28c3700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000525b40 CR3: 0000000110e31000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  do_read_cache_page+0x521/0x7a0
>  map_mft_record+0xcb/0x600
>  ntfs_read_locked_inode+0x69/0x1d20
>  ntfs_read_inode_mount+0x517/0xfb0
>  ntfs_fill_super+0x8e9/0x1710
>  mount_bdev+0x23d/0x280
>  legacy_get_tree+0x2e/0x90
>  vfs_get_tree+0x29/0x100
>  path_mount+0x58e/0x10a0
>  do_mount+0x9b/0xb0
>  __x64_sys_mount+0x13a/0x150
>  do_syscall_64+0x34/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46abda
> Code: 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc3f28c2a48 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fc3f28c2af0 RCX: 000000000046abda
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fc3f28c2ab0
> RBP: 0000000020000000 R08: 00007fc3f28c2af0 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000100
> R13: 00007fc3f28c2ab0 R14: 0000000000000001 R15: 000000002007dd00
> Modules linked in:
> ---[ end trace 55d1771117b77cd9 ]---
> RIP: 0010:ntfs_readpage+0x1468/0x1860
> Code: 0e 2c 7d ff 49 8b 9f 30 fd ff ff 31 ff 48 c1 eb 03 83 e3 01 48
> 89 de e8 16 2d 7d ff 48 85 db 0f 85 61 f5 ff ff e8 e8 2b 7d ff <0f> 0b
> e8 e1 2b 7d ff f0 41 80 0c 24 10 e9 d9 f8 ff ff e8 d1 2b 7d
> RSP: 0018:ffffc900022bfaf0 EFLAGS: 00010206
> RAX: 0000000000009cb0 RBX: 0000000000000000 RCX: 0000000000040000
> RDX: ffffc90001311000 RSI: ffff8881095cb700 RDI: 0000000000000002
> RBP: 0000000000000020 R08: ffffffff81c04778 R09: 0000000000000000
> R10: 0000000000000007 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffea00044bf8c0 R14: ffff88810fea4d80 R15: ffff88810fea50a0
> FS:  00007fc3f28c3700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8c8c03e188 CR3: 0000000110e31000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
> Best,
> Wei
