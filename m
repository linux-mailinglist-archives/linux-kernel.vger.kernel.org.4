Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4861E390
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiKFQ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKFQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:55:58 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D462D2DB;
        Sun,  6 Nov 2022 08:55:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u24so14193808edd.13;
        Sun, 06 Nov 2022 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBYMUFl3e5R+pZHviVQL+DTqJuv5eEXGZobcOsrRlIQ=;
        b=VxqY+tiaFok2OSbjuoJhYdmP2hebxzYXibqrE6bJgcLJamdHDzRG6wszxGDjTMWeeI
         NvEQLQE6d/cnRfinLwAZiBPcmAoKePFXqSXmhWxk8Oo+WKrD8EFN27t1VnMP/x8UM6Dv
         AwHzWdHs6VfiLPfG1atvO1bFdoa3aQixCgWKSkZWsgLEjeaZkHB7jFA5ycC3rZM9pcIZ
         bSJa3Te4TuzNqooLsPhQhheopUNgsWQyJFURbNbCnwnT3lSSgmCwyu2Yzs3ocB4zNAXb
         6EaZBVPXKHKwIOewVHgVHnExm+rgWEvu9YtCx77glSqFWC/rIUP01ODYxXQUWY/vcM7O
         ph/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBYMUFl3e5R+pZHviVQL+DTqJuv5eEXGZobcOsrRlIQ=;
        b=2DZO+WbzjxuM1gU+X8eDkHY5EAprs+1udVOov6Lz4PAvmf5OEcx3IuXMqXfcOrv+Sn
         O8xLfP8YWk8Z3Dyc7PJarKqF9H4nQiyN9KLxXyQ0uLcUzbcsXVP76efr+aXOsvIMn1W1
         Ie8Hja38sGKhQ7qdeQlFD/DCwOZTN9c0Bh63QgZlgJ8J4frf6Ek/kdxFuztx1V7NtUFm
         HG6/v1N32PZS3ZJKv0u2DnTSx8eGRH4rEXdv+ZG82izPQzM3pjk01tcKUF3rRdiql9AD
         GghbUOYjXKiU5b1vw16P9vDTqwv5U7AhleT8+9OoaCYHnTQl5W/xiyF6vz03pHhbbRw0
         lUAA==
X-Gm-Message-State: ANoB5pm3iee60iUpQ4FEUeFUFj+Rp3uig/w2D8YH/8IvClkhJ+6XuDv4
        aG2/2ysJ55OZm4nB+aOcYWFlY3SP+DM2wymSLfOPDlvR+rA=
X-Google-Smtp-Source: AA0mqf47I2tbwPU2lMV0XIyZowDQq87jDF6XOzAjVnSkrfNQNbxOlkI3kB95dlw9uCxb+xcbaOaPnTaXNP/Wb/89wrs=
X-Received: by 2002:a05:6402:5291:b0:45c:3f6a:d4bc with SMTP id
 en17-20020a056402529100b0045c3f6ad4bcmr8751649edb.285.1667753755288; Sun, 06
 Nov 2022 08:55:55 -0800 (PST)
MIME-Version: 1.0
References: <CAO4mrfdwcZx1LPUduO1ycNs-hz0jGmiG+Lbe7VN-ext=aFzYEQ@mail.gmail.com>
In-Reply-To: <CAO4mrfdwcZx1LPUduO1ycNs-hz0jGmiG+Lbe7VN-ext=aFzYEQ@mail.gmail.com>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 7 Nov 2022 00:55:20 +0800
Message-ID: <CAO4mrfd9nWObBXFmQqCgmxfp=wucv2YiyaEHOFxwt-WWmv8jGg@mail.gmail.com>
Subject: Re: kernel BUG in reiserfs_update_sd_size
To:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
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

C reproducer: https://drive.google.com/file/d/1Zpylo9ayWUtnFSkdTS2qszoAxomB_h5P/view?usp=share_link
Syz reproducer:
https://drive.google.com/file/d/1wW_xyEfybUkYVK-By0qNqsSosIsWRmqJ/view?usp=share_link

The bug persists in Linux v6.0.0. I hope it is helpful to you.

[   51.239162][ T6622] kernel BUG at fs/reiserfs/prints.c:390!
[   51.239539][ T6622] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[   51.239948][ T6622] CPU: 0 PID: 6622 Comm: a.out Not tainted 6.0.0 #38
[   51.240371][ T6622] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   51.240998][ T6622] RIP: 0010:__reiserfs_panic+0x12f/0x140
[   51.241373][ T6622] Code: 40 fa a7 8a 48 0f 44 c8 48 0f 44 d8 48 c7
c7 40 fb a7 8a 4c 89 fe 48 89 da 4d 89 f0 49 c7 c1 a0 3e 0f 91 31 c0
e8 10 73 0a 08 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55
48 89 e5 41
[   51.242602][ T6622] RSP: 0018:ffffc90009997380 EFLAGS: 00010246
[   51.242995][ T6622] RAX: 00000000000000a7 RBX: ffffffff8aa789e0
RCX: 46d2c6edc7752800
[   51.243496][ T6622] RDX: 0000000000000000 RSI: 0000000080000000
RDI: 0000000000000000
[   51.244008][ T6622] RBP: ffffc90009997470 R08: ffffffff816b75fc
R09: ffffed100c7867e1
[   51.244504][ T6622] R10: ffffed100c7867e1 R11: 0000000000000000
R12: ffffffff8aa78a20
[   51.245015][ T6622] R13: ffffc900099973a0 R14: ffffffff8c6888a2
R15: ffff888014d8e6a8
[   51.245518][ T6622] FS:  00007f1e44cb9700(0000)
GS:ffff888063c00000(0000) knlGS:0000000000000000
[   51.246087][ T6622] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.246502][ T6622] CR2: 000055af26e96c80 CR3: 0000000021e44000
CR4: 0000000000750ef0
[   51.247008][ T6622] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   51.247510][ T6622] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   51.248009][ T6622] PKRU: 55555554
[   51.248239][ T6622] Call Trace:
[   51.248457][ T6622]  <TASK>
[   51.248645][ T6622]  ? reiserfs_debug+0x10/0x10
[   51.248941][ T6622]  reiserfs_update_sd_size+0xf98/0x1080
[   51.249285][ T6622]  ? restart_transaction+0x1d0/0x1d0
[   51.249648][ T6622]  ? journal_begin+0x1f1/0x350
[   51.249964][ T6622]  reiserfs_mkdir+0x715/0x8b0
[   51.250257][ T6622]  ? reiserfs_symlink+0x850/0x850
[   51.250569][ T6622]  ? down_write+0x10d/0x170
[   51.250854][ T6622]  ? down_read_killable+0x80/0x80
[   51.251166][ T6622]  ? __up_read+0x7a0/0x7a0
[   51.251442][ T6622]  reiserfs_xattr_init+0x34b/0x730
[   51.251786][ T6622]  reiserfs_fill_super+0x31bd/0x37d0
[   51.252118][ T6622]  ? widen_string+0x3a/0x340
[   51.252411][ T6622]  ? reiserfs_kill_sb+0x150/0x150
[   51.252722][ T6622]  ? string+0x2b0/0x2b0
[   51.252983][ T6622]  ? vsnprintf+0x1cd0/0x1cd0
[   51.253269][ T6622]  ? vsnprintf+0x1bf4/0x1cd0
[   51.253566][ T6622]  ? __ptr_to_hashval+0x2f0/0x2f0
[   51.253886][ T6622]  ? snprintf+0xc0/0x110
[   51.254150][ T6622]  ? vscnprintf+0x80/0x80
[   51.254423][ T6622]  ? set_blocksize+0x1d5/0x360
[   51.254733][ T6622]  mount_bdev+0x26c/0x3a0
[   51.254996][ T6622]  ? reiserfs_kill_sb+0x150/0x150
[   51.255303][ T6622]  legacy_get_tree+0xea/0x180
[   51.255590][ T6622]  ? remove_save_link+0x4a0/0x4a0
[   51.255895][ T6622]  vfs_get_tree+0x86/0x270
[   51.256166][ T6622]  path_mount+0x1a09/0x2c10
[   51.256461][ T6622]  ? kasan_quarantine_put+0xc0/0x210
[   51.256790][ T6622]  ? slab_free_freelist_hook+0x12e/0x1a0
[   51.257137][ T6622]  ? mark_mounts_for_expiry+0x520/0x520
[   51.257478][ T6622]  ? user_path_at_empty+0x149/0x1a0
[   51.257812][ T6622]  ? kmem_cache_free+0x95/0x1d0
[   51.258119][ T6622]  ? user_path_at_empty+0x149/0x1a0
[   51.258446][ T6622]  __se_sys_mount+0x2f9/0x3b0
[   51.258738][ T6622]  ? vtime_user_exit+0x2b2/0x3e0
[   51.259032][ T6622]  ? __x64_sys_mount+0xc0/0xc0
[   51.259315][ T6622]  ? syscall_enter_from_user_mode+0x2e/0x1d0
[   51.259666][ T6622]  ? lockdep_hardirqs_on+0x8d/0x130
[   51.259990][ T6622]  ? __x64_sys_mount+0x1c/0xc0
[   51.260272][ T6622]  do_syscall_64+0x3d/0x90
[   51.260538][ T6622]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   51.260886][ T6622] RIP: 0033:0x7f1e442e948a
[   51.261154][ T6622] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d de f9 2a 00 f7 d8
64 89 01 48
[   51.262264][ T6622] RSP: 002b:00007f1e44cb8d38 EFLAGS: 00000286
ORIG_RAX: 00000000000000a5
[   51.262750][ T6622] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007f1e442e948a
[   51.263207][ T6622] RDX: 0000000020000000 RSI: 0000000020000100
RDI: 00007f1e44cb8e70
[   51.263663][ T6622] RBP: 00007f1e44cb8ef0 R08: 00007f1e44cb8d70
R09: 0000000000000030
[   51.264120][ T6622] R10: 0000000000000000 R11: 0000000000000286
R12: 00007fff8eeaa83e
[   51.264576][ T6622] R13: 00007fff8eeaa83f R14: 00007f1e44c99000
R15: 0000000000000003
[   51.265036][ T6622]  </TASK>
[   51.265215][ T6622] Modules linked in:
[   51.277512][ T6622] ---[ end trace 0000000000000000 ]---
[   51.277881][ T6622] RIP: 0010:__reiserfs_panic+0x12f/0x140
[   51.278221][ T6622] Code: 40 fa a7 8a 48 0f 44 c8 48 0f 44 d8 48 c7
c7 40 fb a7 8a 4c 89 fe 48 89 da 4d 89 f0 49 c7 c1 a0 3e 0f 91 31 c0
e8 10 73 0a 08 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55
48 89 e5 41
[   51.279354][ T6622] RSP: 0018:ffffc90009997380 EFLAGS: 00010246
[   51.279728][ T6622] RAX: 00000000000000a7 RBX: ffffffff8aa789e0
RCX: 46d2c6edc7752800
[   51.280214][ T6622] RDX: 0000000000000000 RSI: 0000000080000000
RDI: 0000000000000000
[   51.280695][ T6622] RBP: ffffc90009997470 R08: ffffffff816b75fc
R09: ffffed100c7867e1
[   51.281164][ T6622] R10: ffffed100c7867e1 R11: 0000000000000000
R12: ffffffff8aa78a20
[   51.282917][ T6622] R13: ffffc900099973a0 R14: ffffffff8c6888a2
R15: ffff888014d8e6a8
[   51.283402][ T6622] FS:  00007f1e44cb9700(0000)
GS:ffff888063c00000(0000) knlGS:0000000000000000
[   51.283948][ T6622] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.284340][ T6622] CR2: 00007efcd65b9520 CR3: 0000000021e44000
CR4: 0000000000750ef0
[   51.284807][ T6622] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   51.285295][ T6622] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   51.285775][ T6622] PKRU: 55555554
[   51.285992][ T6622] Kernel panic - not syncing: Fatal exception
[   51.286478][ T6622] Kernel Offset: disabled
[   51.286740][ T6622] Rebooting in 86400 seconds..

Best,
Wei

On Sun, 30 Oct 2022 at 18:25, Wei Chen <harperchen1110@gmail.com> wrote:
>
> Dear Linux Developer,
>
> Recently when using our tool to fuzz kernel, the following crash was triggered:
>
> HEAD commit: 64570fbc14f8 Linux 5.15-rc5
> git tree: upstream
> compiler: gcc 8.0.1
> console output:
> https://drive.google.com/file/d/1laVB52iSmAz7ATjvqKgcZw9Qf3pVh50t/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
>
> REISERFS (device loop0): Using rupasov hash to sort names
> REISERFS panic (device loop0): vs-13065 update_stat_data: key [1 2 0x0
> IND], found item *3.6* [1 2 0x0 IND], item_len 44, item_location 4052,
> free_space(entry_count) 0
> ------------[ cut here ]------------
> kernel BUG at fs/reiserfs/prints.c:390!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 0 PID: 12506 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__reiserfs_panic.cold.17+0x37/0x8c
> Code: d1 85 74 63 e8 e6 f4 9f fc 4c 89 f1 48 89 da 4c 89 ee 49 c7 c0
> a0 30 29 89 48 c7 c7 04 8f c0 85 e8 f1 60 fe ff e8 c5 f4 9f fc <0f> 0b
> e8 be f4 9f fc 4d 85 ed 49 c7 c4 26 a6 d1 85 74 36 e8 ad f4
> RSP: 0018:ffffc900020b7aa0 EFLAGS: 00010216
> RAX: 0000000000013eb9 RBX: ffff888016c8a000 RCX: 0000000000040000
> RDX: ffffc9000226d000 RSI: ffff888111950000 RDI: 0000000000000002
> RBP: ffffc900020b7b10 R08: ffffffff849d7e9b R09: 0000000000000000
> R10: 0000000000000005 R11: 0000000080000000 R12: ffffffff85d1a626
> R13: ffffffff85c07963 R14: ffffffff85079d30 R15: ffffc900020b7c60
> FS:  00007f3386280700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000525b40 CR3: 0000000011cfd000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  reiserfs_update_sd_size+0x33b/0x450
>  reiserfs_mkdir+0x2db/0x3c0
>  reiserfs_xattr_init+0x1be/0x330
>  reiserfs_fill_super+0x110e/0x1620
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
> RSP: 002b:00007f338627fa48 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f338627faf0 RCX: 000000000046abda
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f338627fab0
> RBP: 0000000020000000 R08: 00007f338627faf0 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000100
> R13: 00007f338627fab0 R14: 0000000000000001 R15: 0000000020011500
> Modules linked in:
> ---[ end trace 15f12b9b91cc8105 ]---
> RIP: 0010:__reiserfs_panic.cold.17+0x37/0x8c
> Code: d1 85 74 63 e8 e6 f4 9f fc 4c 89 f1 48 89 da 4c 89 ee 49 c7 c0
> a0 30 29 89 48 c7 c7 04 8f c0 85 e8 f1 60 fe ff e8 c5 f4 9f fc <0f> 0b
> e8 be f4 9f fc 4d 85 ed 49 c7 c4 26 a6 d1 85 74 36 e8 ad f4
> RSP: 0018:ffffc900020b7aa0 EFLAGS: 00010216
> RAX: 0000000000013eb9 RBX: ffff888016c8a000 RCX: 0000000000040000
> RDX: ffffc9000226d000 RSI: ffff888111950000 RDI: 0000000000000002
> RBP: ffffc900020b7b10 R08: ffffffff849d7e9b R09: 0000000000000000
> R10: 0000000000000005 R11: 0000000080000000 R12: ffffffff85d1a626
> R13: ffffffff85c07963 R14: ffffffff85079d30 R15: ffffc900020b7c60
> FS:  00007f3386280700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000525b40 CR3: 0000000011cfd000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
> Best,
> Wei
