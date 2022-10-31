Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0361355F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiJaMIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiJaMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:08:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B44B1118
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:08:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b2so28891053eja.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/K+6HlU0r/LtCJwDn8w/qs2vrhpet54SJvoT/E/99c=;
        b=PPr7KIUjWDoVyMUaror8ko2NV99nr4lxiEpehQjhuzkYuO2N1ukk+zmnjkCDFWHLE0
         1Kwz6HZHmz117IpDpIOnWiDjfo8MP+68ZVzn6N/QKQg68XLGbgdkqq5gJ1nT9Cp2p67B
         yDJye63BOGv6zrGWWX21rbq9Lo9kT8zfogEgVwd+BCWq1Zq25tESML3bGX4p3HcNxXE2
         9reIjFXR5H+W1sKHhJcQWAIeYWVytZg1+AGRT/qLjyJl0r72KPjvD/brqfWXMDQXOhCP
         0ekEpfLQvlG6AMTRIYpWOIC7eT7hG4XbHOYj3GykN1Yfyr8NMndmFCsko/Fd4A5iK2Pv
         zgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/K+6HlU0r/LtCJwDn8w/qs2vrhpet54SJvoT/E/99c=;
        b=jzRUxKo/tQVnBVmCvKB2ntNmrP88ZY7lU0YOATw2gy9oblkU9JvIinsGXf7z7xlQdW
         RDRS7+2tzUs6X7QkXYCzqsMZXGNOHEriffTYlozBeSrc0AQVkIa9Iilnzo7zpqo5uCZl
         rOhQUKUqtIRxHRhBoveJvHVH3hVG51X0vujtc+QeaR8pazVSJG4o236PH0qpWAIdQjB6
         Cx4SQHZga6HvTURoaHD8UbINHrA+nsbbhBKvLDKckE9yAthw2HxX5ZWtWdqJAE4QeKB1
         vi6ehAIJiiRLcmJQB6enNpWc7ghgb+ytSNM/afMF7znSWLe/el0kfFWSokVjzsqRx+ny
         +JFw==
X-Gm-Message-State: ACrzQf1WAcff9TxQXrId34vOc6H9lRDfNw8MopfGDhwRLqpUp5681rEx
        AV3I/YRd7Ny6iV9QhXJUNG595kncDu8y0t8z8sTTD0YH
X-Google-Smtp-Source: AMsMyM5buXb1x2xFOwAZtSFWDvWZKCVtQKAhU8U1OQEnYZKLv5FI8fWwvKyUpN8eKLFaXMPR0wBjhzvKV2BfHmAnHb0=
X-Received: by 2002:a17:907:7f8b:b0:7ad:b45d:4e9a with SMTP id
 qk11-20020a1709077f8b00b007adb45d4e9amr10621621ejc.421.1667218110435; Mon, 31
 Oct 2022 05:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAO4mrfcw6RxYreivijxCgQLOYc8sEQaWG=Q-Y1yX85LNPkdNmw@mail.gmail.com>
In-Reply-To: <CAO4mrfcw6RxYreivijxCgQLOYc8sEQaWG=Q-Y1yX85LNPkdNmw@mail.gmail.com>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 31 Oct 2022 20:07:55 +0800
Message-ID: <CAO4mrfcetHg_K4hOTYiMmLrYsCDp4Lij6u3NhrriTee+JpL9Gw@mail.gmail.com>
Subject: Re: WARNING in save_fpregs_to_fpstate
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org
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

C reproducer: https://drive.google.com/file/d/1yhjiEJE1XlXDcmjuoaw-koWvgFEDpPTP/view?usp=share_link
Syz reproducer:
https://drive.google.com/file/d/191weDFK0f3TSUjj9VkCe_Mc-FHYJDJYF/view?usp=share_link

The bug persists in the latest commit, v5.15.76 (4f5365f77018). Hope
it is helpful.

[   45.409368][ T6874] WARNING: CPU: 0 PID: 6874 at
./arch/x86/include/asm/fpu/internal.h:304
save_fpregs_to_fpstate+0x94/0xb0
[   45.412053][ T6874] Modules linked in:
[   45.412973][ T6874] CPU: 0 PID: 6874 Comm: a.out Not tainted 5.15.76 #3
[   45.414559][ T6874] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[   45.417442][ T6874] RIP: 0010:save_fpregs_to_fpstate+0x94/0xb0
[   45.418840][ T6874] Code: 04 48 89 43 08 5b 5d 41 5c 41 5d e9 c6 21
27 00 e8 c1 21 27 00 48 0f ae 43 40 5b 5d 41 5c 41 5d e9 b1 21 27 00
e8 ac 21 27 00 <0f> 0b eb b9 e8 a3 21 27 00 0f 0b eb 98 0f 1f 44 00 00
66 2e 0f 1f
[   45.423504][ T6874] RSP: 0018:ffffc900025ebdc0 EFLAGS: 00010293
[   45.424936][ T6874] RAX: 0000000000000000 RBX: ffff888010fd30c0
RCX: 0000000000000000
[   45.426794][ T6874] RDX: ffff8881074c3780 RSI: ffffffff8110fed4
RDI: ffff888010fd3100
[   45.428661][ T6874] RBP: 00000000fffffffe R08: 0000000000000000
R09: 0000000000000000
[   45.430564][ T6874] R10: 0000000000000001 R11: 0000000000000002
R12: 0000000000000007
[   45.432509][ T6874] R13: 0000000000000000 R14: 0000000000000000
R15: ffffc9000263c0c8
[   45.435006][ T6874] FS:  00007f28babdc700(0000)
GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   45.437795][ T6874] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.439891][ T6874] CR2: 0000000000000000 CR3: 0000000012c4a000
CR4: 00000000000026e0
[   45.442361][ T6874] Call Trace:
[   45.443162][ T6874]  <TASK>
[   45.443873][ T6874]  kvm_save_current_fpu+0x4a/0x60
[   45.445048][ T6874]  kvm_put_guest_fpu+0x34/0x1c0
[   45.446183][ T6874]  kvm_arch_vcpu_ioctl_run+0x245/0x8d0
[   45.447468][ T6874]  kvm_vcpu_ioctl+0x3f5/0x8c0
[   45.448561][ T6874]  ? __fget_files+0x141/0x260
[   45.449650][ T6874]  ? do_vfs_ioctl+0x150/0xaa0
[   45.450783][ T6874]  ? kvm_uevent_notify_change.part.66+0x250/0x250
[   45.452279][ T6874]  __x64_sys_ioctl+0xb6/0x100
[   45.453368][ T6874]  do_syscall_64+0x34/0xb0
[   45.454413][ T6874]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   45.455796][ T6874] RIP: 0033:0x7f28ba4eb469
[   45.456824][ T6874] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
64 89 01 48
[   45.462144][ T6874] RSP: 002b:00007f28babdbde8 EFLAGS: 00000217
ORIG_RAX: 0000000000000010
[   45.464735][ T6874] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007f28ba4eb469
[   45.467057][ T6874] RDX: 0000000000000000 RSI: 000000000000ae80
RDI: 0000000000000005
[   45.468932][ T6874] RBP: 00007f28babdbe20 R08: 0000000100000001
R09: 0000000000000000
[   45.470821][ T6874] R10: 0000000100000001 R11: 0000000000000217
R12: 00007ffd098d389e
[   45.472679][ T6874] R13: 00007ffd098d389f R14: 00007f28babbc000
R15: 0000000000000003
[   45.474535][ T6874]  </TASK>
[   45.475244][ T6874] Kernel panic - not syncing: panic_on_warn set ...
[   45.476760][ T6874] CPU: 0 PID: 6874 Comm: a.out Not tainted 5.15.76 #3
[   45.478314][ T6874] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[   45.481203][ T6874] Call Trace:
[   45.481960][ T6874]  <TASK>
[   45.482639][ T6874]  dump_stack_lvl+0x8d/0xcf
[   45.483697][ T6874]  panic+0x165/0x3ed
[   45.484606][ T6874]  ? __warn+0xe0/0x140
[   45.485554][ T6874]  ? save_fpregs_to_fpstate+0x94/0xb0
[   45.486800][ T6874]  __warn+0xf6/0x140
[   45.487709][ T6874]  ? save_fpregs_to_fpstate+0x94/0xb0
[   45.488972][ T6874]  report_bug+0x112/0x1b0
[   45.489979][ T6874]  handle_bug+0x3f/0x70
[   45.490944][ T6874]  exc_invalid_op+0x13/0x60
[   45.492011][ T6874]  asm_exc_invalid_op+0x16/0x20
[   45.493164][ T6874] RIP: 0010:save_fpregs_to_fpstate+0x94/0xb0
[   45.494545][ T6874] Code: 04 48 89 43 08 5b 5d 41 5c 41 5d e9 c6 21
27 00 e8 c1 21 27 00 48 0f ae 43 40 5b 5d 41 5c 41 5d e9 b1 21 27 00
e8 ac 21 27 00 <0f> 0b eb b9 e8 a3 21 27 00 0f 0b eb 98 0f 1f 44 00 00
66 2e 0f 1f
[   45.499101][ T6874] RSP: 0018:ffffc900025ebdc0 EFLAGS: 00010293
[   45.500514][ T6874] RAX: 0000000000000000 RBX: ffff888010fd30c0
RCX: 0000000000000000
[   45.502351][ T6874] RDX: ffff8881074c3780 RSI: ffffffff8110fed4
RDI: ffff888010fd3100
[   45.504207][ T6874] RBP: 00000000fffffffe R08: 0000000000000000
R09: 0000000000000000
[   45.506058][ T6874] R10: 0000000000000001 R11: 0000000000000002
R12: 0000000000000007
[   45.507916][ T6874] R13: 0000000000000000 R14: 0000000000000000
R15: ffffc9000263c0c8
[   45.509767][ T6874]  ? save_fpregs_to_fpstate+0x94/0xb0
[   45.511022][ T6874]  kvm_save_current_fpu+0x4a/0x60
[   45.512209][ T6874]  kvm_put_guest_fpu+0x34/0x1c0
[   45.513339][ T6874]  kvm_arch_vcpu_ioctl_run+0x245/0x8d0
[   45.514616][ T6874]  kvm_vcpu_ioctl+0x3f5/0x8c0
[   45.515715][ T6874]  ? __fget_files+0x141/0x260
[   45.516815][ T6874]  ? do_vfs_ioctl+0x150/0xaa0
[   45.517919][ T6874]  ? kvm_uevent_notify_change.part.66+0x250/0x250
[   45.519421][ T6874]  __x64_sys_ioctl+0xb6/0x100
[   45.520513][ T6874]  do_syscall_64+0x34/0xb0
[   45.521540][ T6874]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   45.522909][ T6874] RIP: 0033:0x7f28ba4eb469
[   45.523954][ T6874] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
64 89 01 48
[   45.528519][ T6874] RSP: 002b:00007f28babdbde8 EFLAGS: 00000217
ORIG_RAX: 0000000000000010
[   45.530474][ T6874] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007f28ba4eb469
[   45.532389][ T6874] RDX: 0000000000000000 RSI: 000000000000ae80
RDI: 0000000000000005
[   45.534233][ T6874] RBP: 00007f28babdbe20 R08: 0000000100000001
R09: 0000000000000000
[   45.536096][ T6874] R10: 0000000100000001 R11: 0000000000000217
R12: 00007ffd098d389e
[   45.537931][ T6874] R13: 00007ffd098d389f R14: 00007f28babbc000
R15: 0000000000000003
[   45.539778][ T6874]  </TASK>
[   45.541237][ T6874] Kernel Offset: disabled
[   45.542327][ T6874] Rebooting in 86400 seconds..

Thank you,
Wei


On Sun, 30 Oct 2022 at 18:37, Wei Chen <harperchen1110@gmail.com> wrote:
>
> Dear Linux Developer,
>
> Recently when using our tool to fuzz kernel, the following crash was triggered:
>
> HEAD commit: 64570fbc14f8 Linux 5.15-rc5
> git tree: upstream
> compiler: gcc 8.0.1
> console output:
> https://drive.google.com/file/d/1DkbPrIA6cVbIgS86sfFCZARE1jKhbMTk/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
>
> set kvm_intel.dump_invalid_vmcs=1 to dump internal KVM state.
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 11082 at arch/x86/include/asm/fpu/internal.h:304
> save_fpregs_to_fpstate+0xc2/0xe0
> Modules linked in:
> CPU: 1 PID: 11082 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
> RIP: 0010:save_fpregs_to_fpstate+0xc2/0xe0
> Code: 08 5b 5d 41 5c 41 5d 41 5e e9 da c3 29 00 e8 d5 c3 29 00 48 0f
> ae 45 40 5b 5d 41 5c 41 5d 41 5e e9 c3 c3 29 00 e8 be c3 29 00 <0f> 0b
> eb a2 e8 b5 c3 29 00 0f 0b e9 75 ff ff ff 0f 1f 40 00 66 2e
> RSP: 0018:ffffc900028ffda0 EFLAGS: 00010212
> RAX: 000000000000e11d RBX: 00000000fffffffe RCX: 0000000000040000
> RDX: ffffc90002a29000 RSI: ffff888135ae3700 RDI: 0000000000000002
> RBP: ffff888010bde180 R08: ffffffff8113afa2 R09: 0000000000000000
> R10: 0000000000000005 R11: 00000000fffffffe R12: 0000000000000007
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
> FS:  00007ffa8d5d6700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000003d98d000 CR4: 00000000000026e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000006e52
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>  kvm_save_current_fpu+0x61/0x70
>  kvm_put_guest_fpu+0x34/0x230
>  kvm_arch_vcpu_ioctl_run+0x541/0xb20
>  kvm_vcpu_ioctl+0x3b8/0xa30
>  __x64_sys_ioctl+0xe8/0x140
>  do_syscall_64+0x34/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4692c9
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffa8d5d5c38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004692c9
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
> RBP: 000000000119bfb0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bfac
> R13: 0000000000000000 R14: 000000000119bfa0 R15: 00007fff96fd8ad0
>
> Best,
> Wei
