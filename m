Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5B61D984
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 11:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKEKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKEKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 06:52:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6855324
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 03:52:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt23so19109929ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmYcctTiJYwwICkx5wu/bw8pUXXtcC2eFjna9pAcZHs=;
        b=kMA28qDz2uGz76+Qxhi8rg+rfrk/Jrx0jjm4eBeI4LxKkLB/ncVOhxdgQPamDaUeRH
         p0kH6XqKpiMXVcrEr/MFCQbTGbb0K0n6BcyQ0NuroLi8Q7U+KcNTHaKh1c+7IywHV938
         mXTESu8+iUaGZwWjQ87Wi2osLmTdUVCL0N4ylKbdD5Hxj7FUpd4h3PeXy0045lxh02s3
         cBq6k82BDaFYhq/7q1Xg4rxDfmRjm+SwZSOzpSV8Ty5ygdiRXJz7W+DF6HhjiUnKcyyS
         Jc07WQS3pw3CMOjfdihL92OG2dvnSWZB/oD/b+Zgl3NyTHk2xvr/Di94SrXPvwZC3pJB
         NYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmYcctTiJYwwICkx5wu/bw8pUXXtcC2eFjna9pAcZHs=;
        b=hBaPEE14EpPOPafG4clELjkHYQ265gGR/OC+8tkXwCkgAsddBrvjc1rtpvKGcHXML+
         DypIokprKaNwDMYQGvCF7+MYtEXINxjEDf8nA0hMgPQrSmog2MA5bNIeh/ViUR4av8bp
         jNQn3sPk1fqX9SS1GxkbWdLSjzPrD1GuTu6AnEXc/8jwszRxl+QeN7liJ2SpdXKVx1js
         UO/mea8uvChI7XbAc+n1Rr3DPsHxp3zFlnsdQTYWaYKDpSjsp5Rejt0zrWzyWRtvqoGV
         bYgRCwJ/+sK4G0nUv+ADBwDDCaXOhg7KDC0BBhcbYNBkhFuT6Ph3aY8bpIyPpUav5BeO
         EA/w==
X-Gm-Message-State: ACrzQf3NJ7NhRpyvxtK3QV2Lt50asdoZEmMnwg/0gDK20eoibjmruvxL
        j/15pRWtyj7OnmSGj66kdH8UDuTMcOaQ+816FlsQgscDi3s=
X-Google-Smtp-Source: AMsMyM7XIJ+eyAwMRRcSwfrnNnOoroHukEtAtoEQjMLnkwWOEZP/X8p0e7hAEv5whmFUewre9Rej4EPRetHS9mXL6H0=
X-Received: by 2002:a17:907:2c71:b0:79e:8603:72c6 with SMTP id
 ib17-20020a1709072c7100b0079e860372c6mr39228016ejc.172.1667645564153; Sat, 05
 Nov 2022 03:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAO4mrffA2tTwCKQ-objUH7BJ2GjSXaJdi=pq0vtqjicx8eH7wA@mail.gmail.com>
 <c0112b1d-e3bb-9f54-eb0d-f5d77275a323@wanadoo.fr>
In-Reply-To: <c0112b1d-e3bb-9f54-eb0d-f5d77275a323@wanadoo.fr>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sat, 5 Nov 2022 18:52:08 +0800
Message-ID: <CAO4mrfehbWr+wNxP22GntPmeFprap+PjuCwQgdqUahtPXHKJ6Q@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in debug_check_no_obj_freed
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

The bug persists in 5.15.76. Unfortunately, we do not have a reproducer eit=
her.

BUG: kernel NULL pointer dereference, address: 0000000000000038
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 10876 Comm: systemd-udevd Not tainted 5.15.76 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:983 [inline]
RIP: 0010:debug_check_no_obj_freed+0xc7/0x210 lib/debugobjects.c:1023
Code: 48 89 34 24 48 8b 3c 24 45 31 ff e8 63 d6 fc 01 48 8b 54 24 20
48 89 44 24 18 48 c7 c0 a0 a9 82 88 48 8b 04 10 48 85 c0 74 4b <48> 8b
48 18 41 83 c7 01 4c 8b 30 48 39 cb 77 2e 48 39 e9 73 29 83
RSP: 0018:ffffc9000d3dfbb8 EFLAGS: 00010002
RAX: 0000000000000020 RBX: ffff88811741d000 RCX: 0000000000000000
RDX: 0000000000099b40 RSI: ffffffff852b51d8 RDI: ffffffff888c44e8
RBP: ffff88811741e000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc9000d3dfa60 R11: 0000000000000001 R12: dead000000000122
R13: dead000000000100 R14: 0000000000000020 R15: 0000000000000003
FS:  00007f29edb2a8c0(0000) GS:ffff88813dc00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000038 CR3: 000000010cc24000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 free_pages_prepare mm/page_alloc.c:1345 [inline]
 free_pcp_prepare+0x177/0x490 mm/page_alloc.c:1391
 free_unref_page_prepare mm/page_alloc.c:3317 [inline]
 free_unref_page_list+0x8a/0x660 mm/page_alloc.c:3433
 release_pages+0x1d2/0x1140 mm/swap.c:963
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0x60/0x1e0 mm/mmu_gather.c:249
 tlb_finish_mmu+0x5f/0xb0 mm/mmu_gather.c:340
 unmap_region+0x155/0x1a0 mm/mmap.c:2668
 __do_munmap+0x292/0x6f0 mm/mmap.c:2899
 __vm_munmap+0x96/0x180 mm/mmap.c:2922
 __do_sys_munmap mm/mmap.c:2948 [inline]
 __se_sys_munmap mm/mmap.c:2944 [inline]
 __x64_sys_munmap+0x2a/0x30 mm/mmap.c:2944
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7f29ec9a66e7
Code: c7 c0 ff ff ff ff eb 8d 48 8b 15 ac 47 2b 00 f7 d8 64 89 02 e9
5b ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 b8 0b 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 81 47 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd3fcf6c98 EFLAGS: 00000207 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 00000000000c3c94 RCX: 00007f29ec9a66e7
RDX: 00007f29edae9000 RSI: 0000000000041000 RDI: 00007f29edae9000
RBP: 0000000000000021 R08: 0000557c1a93c0d0 R09: 0000000000000000
R10: 0000000000000210 R11: 0000000000000207 R12: 0000557c1a872ea0
R13: 0000557c1a872ef0 R14: 00007f29ed709aa4 R15: 00007f29edae9028
 </TASK>
Modules linked in:
CR2: 0000000000000038
---[ end trace 850a1b705a5c4266 ]---
RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:983 [inline]
RIP: 0010:debug_check_no_obj_freed+0xc7/0x210 lib/debugobjects.c:1023
Code: 48 89 34 24 48 8b 3c 24 45 31 ff e8 63 d6 fc 01 48 8b 54 24 20
48 89 44 24 18 48 c7 c0 a0 a9 82 88 48 8b 04 10 48 85 c0 74 4b <48> 8b
48 18 41 83 c7 01 4c 8b 30 48 39 cb 77 2e 48 39 e9 73 29 83
RSP: 0018:ffffc9000d3dfbb8 EFLAGS: 00010002

RAX: 0000000000000020 RBX: ffff88811741d000 RCX: 0000000000000000
RDX: 0000000000099b40 RSI: ffffffff852b51d8 RDI: ffffffff888c44e8
RBP: ffff88811741e000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc9000d3dfa60 R11: 0000000000000001 R12: dead000000000122
R13: dead000000000100 R14: 0000000000000020 R15: 0000000000000003
FS:  00007f29edb2a8c0(0000) GS:ffff88813dc00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000038 CR3: 000000010cc24000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 48 89 34 24          mov    %rsi,(%rsp)
   4: 48 8b 3c 24          mov    (%rsp),%rdi
   8: 45 31 ff              xor    %r15d,%r15d
   b: e8 63 d6 fc 01        callq  0x1fcd673
  10: 48 8b 54 24 20        mov    0x20(%rsp),%rdx
  15: 48 89 44 24 18        mov    %rax,0x18(%rsp)
  1a: 48 c7 c0 a0 a9 82 88 mov    $0xffffffff8882a9a0,%rax
  21: 48 8b 04 10          mov    (%rax,%rdx,1),%rax
  25: 48 85 c0              test   %rax,%rax
  28: 74 4b                je     0x75
* 2a: 48 8b 48 18          mov    0x18(%rax),%rcx <-- trapping instruction
  2e: 41 83 c7 01          add    $0x1,%r15d
  32: 4c 8b 30              mov    (%rax),%r14
  35: 48 39 cb              cmp    %rcx,%rbx
  38: 77 2e                ja     0x68
  3a: 48 39 e9              cmp    %rbp,%rcx
  3d: 73 29                jae    0x68
  3f: 83                    .byte 0x83

Best,
Wei

On Mon, 31 Oct 2022 at 00:43, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 30/10/2022 =C3=A0 10:23, Wei Chen a =C3=A9crit :
> > Dear Linux Developer,
> >
> > Recently when using our tool to fuzz kernel, the following crash was tr=
iggered:
> >
> > HEAD commit: 64570fbc14f8 Linux 5.15-rc5
>
> Hi,
>
> any reason to run your fuzzer on 5.15-rc5?
>
> We are at 5.15.76 and many things have already been fixed in the 5.15
> branch.
>
> 5.15 is also old.
>
> CJ
