Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E01861471F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiKAJsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiKAJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:48:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054D6571
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:48:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z18so15994839edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9l59xnxmm6MxyTzptV730O4VhdUeGa3R9saYS3cy5VM=;
        b=DJgjc2payg/HfyufWZNyeF55mpYFSVJwCfqoDf/ct/7EyOX3x1QwW65jpQ5SL7dPSW
         I/hV8j144hDq1PFVw4cgiTVA4rBOWxIadJX2r5aLqKxkyL/KypF4DpmqnOzZShUMY5n4
         n9snoG3IAX3PT/VPF2xfMXOLXs9jxjEBy1J0PuBhXrO7nG9h78Z7590zY5pCk7x5P4C8
         ojWlsYREWymMkQqGzd2Z75whuHJilVebHy9BD4V62VD9FNAcl4LS8u7vNd94pvceIEgr
         BGXVGUOTDNQbSW7KiDwrwdPfWCUWqW3WH87yVz4axonoXFkgKnOkH0CPZLAGAA3sA7kA
         +WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9l59xnxmm6MxyTzptV730O4VhdUeGa3R9saYS3cy5VM=;
        b=TromDFpugfVXzKOxwUTxvrAjE63gMG8StIIyU7gpO5e+0nZ+MZlp1mL+GrSVDyNojx
         HkkesyddqO+9Mp9gJPNLfH1lhcQdYV+dqjvIRTBGl9qxN0sZxFOL8QUoYFbYW1/1G0aP
         HAN8Hsn02OKq6WaMGmd+zPDo2Tk+LJxEXpbmA7bgAs/UVxl3jEchKuRnjr0N9cUn0yJP
         /vXnxuSudCtrDZaD4V75npFMqJDdU4knl3QWxhfTHPttuehDEjc5NX3i9IEWy5AlWxrJ
         Eb2wADlU8/+eqSa+eP2XrvJ5KFBjaffnT9OYu/czMFfQy8T+yTVrpJ0oEenWJU859Cd5
         80Xg==
X-Gm-Message-State: ACrzQf17A7AcWSph9Bd6ibvwayZ0e9adRxkazdqLw63fpX4+1Qpj2qOy
        31gmIin0C2TmqWAbQULL9YnuOQJZYVsXIlV2k7jvjlpwo09kdA==
X-Google-Smtp-Source: AMsMyM52Qb8n6ZVflPZBWd42xGtu4nvTLPGxsjQEJRNXmCv6YA05uRYt45LORPZwi+SOzJ5i6syz3SNV015PFjc0Gw4=
X-Received: by 2002:a05:6402:5291:b0:45c:3f6a:d4bc with SMTP id
 en17-20020a056402529100b0045c3f6ad4bcmr18176306edb.285.1667296101759; Tue, 01
 Nov 2022 02:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAO4mrfdcnTXXK0BQYr3bp=KyAH1_BUiRJd42a_bKhASgpO+gLw@mail.gmail.com>
In-Reply-To: <CAO4mrfdcnTXXK0BQYr3bp=KyAH1_BUiRJd42a_bKhASgpO+gLw@mail.gmail.com>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Tue, 1 Nov 2022 17:47:45 +0800
Message-ID: <CAO4mrffoOcDe8mNH4_6C5Jiz8beBayt0BC77VaRZ5=rVrPZG7g@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in wait_consider_task
To:     christian@brauner.io, linux-kernel@vger.kernel.org
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

This crash persists in the latest commit, v5.15.76 (4f5365f77018).
However, I still cannot find a reproducer for the crash. I hope the
following crash report is helpful to you.

BUG: kernel NULL pointer dereference, address: 0000000000000850
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 114818067 P4D 114818067 PUD 114819067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 6550 Comm: syz-executor.0 Not tainted 5.15.76 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:ptrace_reparented include/linux/ptrace.h:92 [inline]
RIP: 0010:wait_consider_task+0xb1b/0x1250 kernel/exit.c:1320
Code: 5b 28 09 01 e9 ad f7 ff ff e8 21 d5 14 00 48 8b 45 b8 c7 40 50
00 00 00 00 e9 7a f5 ff ff e8 0c d5 14 00 48 8b 83 98 05 00 00 <4c> 8b
b0 50 08 00 00 48 8b 83 a0 05 00 00 4c 8b b8 50 08 00 00 31
RSP: 0018:ffffc90000ccbd08 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88811084d340 RCX: 0000000000000000
RDX: ffff888014289bc0 RSI: ffffffff81234b74 RDI: ffffc90000ccbdc0
RBP: ffffc90000ccbd70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000020 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000040000005 R15: ffffffff81235380
FS:  00000000018e7940(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000850 CR3: 0000000114817000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_wait_thread kernel/exit.c:1397 [inline]
 do_wait+0x253/0x510 kernel/exit.c:1514
 kernel_wait4+0xb3/0x190 kernel/exit.c:1677
 __do_sys_wait4+0xce/0xe0 kernel/exit.c:1705
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x418fea
Code: 41 54 55 41 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 6b f6 ff ff
45 31 d2 41 89 c0 44 89 e2 48 89 ee 89 df b8 3d 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 30 44 89 c7 89 44 24 0c e8 a2 f6 ff ff 8b 44
RSP: 002b:00007fff47940a40 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 0000000000418fea
RDX: 0000000040000001 RSI: 00007fff47940acc RDI: 00000000ffffffff
RBP: 00007fff47940acc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000040000001
R13: 0000000000000032 R14: 00007fff47940acc R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: 0000000000000850
---[ end trace 3c86ff94252062e2 ]---
RIP: 0010:ptrace_reparented include/linux/ptrace.h:92 [inline]
RIP: 0010:wait_consider_task+0xb1b/0x1250 kernel/exit.c:1320
Code: 5b 28 09 01 e9 ad f7 ff ff e8 21 d5 14 00 48 8b 45 b8 c7 40 50
00 00 00 00 e9 7a f5 ff ff e8 0c d5 14 00 48 8b 83 98 05 00 00 <4c> 8b
b0 50 08 00 00 48 8b 83 a0 05 00 00 4c 8b b8 50 08 00 00 31
RSP: 0018:ffffc90000ccbd08 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88811084d340 RCX: 0000000000000000
RDX: ffff888014289bc0 RSI: ffffffff81234b74 RDI: ffffc90000ccbdc0
RBP: ffffc90000ccbd70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000020 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000040000005 R15: ffffffff81235380
FS:  00000000018e7940(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000850 CR3: 0000000114817000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0: 09 01                or     %eax,(%rcx)
   2: e9 ad f7 ff ff        jmpq   0xfffff7b4
   7: e8 21 d5 14 00        callq  0x14d52d
   c: 48 8b 45 b8          mov    -0x48(%rbp),%rax
  10: c7 40 50 00 00 00 00 movl   $0x0,0x50(%rax)
  17: e9 7a f5 ff ff        jmpq   0xfffff596
  1c: e8 0c d5 14 00        callq  0x14d52d
  21: 48 8b 83 98 05 00 00 mov    0x598(%rbx),%rax
* 28: 4c 8b b0 50 08 00 00 mov    0x850(%rax),%r14 <-- trapping instruction
  2f: 48 8b 83 a0 05 00 00 mov    0x5a0(%rbx),%rax
  36: 4c 8b b8 50 08 00 00 mov    0x850(%rax),%r15
  3d: 31                    .byte 0x31

Best,
Wei



On Sun, 30 Oct 2022 at 17:43, Wei Chen <harperchen1110@gmail.com> wrote:
>
> Dear Linux Developer,
>
> Recently when using our tool to fuzz kernel, the following crash was triggered:
>
> HEAD commit: 64570fbc14f8 Linux 5.15-rc5
> git tree: upstream
> compiler: gcc 8.0.1
> console output:
> https://drive.google.com/file/d/1dGe81ZlqkO1khyG9jB9Gr2Wpg47561CV/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
>
> BUG: kernel NULL pointer dereference, address: 0000000000000850
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 120603067 P4D 120603067 PUD 120604067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 6561 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
> RIP: 0010:wait_consider_task+0xc74/0x1750
> Code: 00 e8 00 e5 34 01 e9 50 f8 ff ff e8 16 b4 16 00 31 f6 31 ff e8
> 0d b5 16 00 e9 df fc ff ff e8 03 b4 16 00 48 8b 83 98 05 00 00 <4c> 8b
> b8 50 08 00 00 48 8b 83 a0 05 00 00 4c 8b b0 50 08 00 00 31
> RSP: 0018:ffffc90000ce7d20 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff888018805280 RCX: ffff888109629b80
> RDX: 0000000000000000 RSI: ffff888109629b80 RDI: 0000000000000002
> RBP: ffffc90000ce7d90 R08: ffffffff8126bf5d R09: 0000000000000000
> R10: 0000000000000005 R11: 0000000000000020 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000020 R15: 0000000040000000
> FS:  00000000027bc940(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000850 CR3: 0000000120602000 CR4: 00000000003526e0
> Call Trace:
>  do_wait+0x2ae/0x630
>  kernel_wait4+0xff/0x1e0
>  __do_sys_wait4+0xd7/0xf0
>  do_syscall_64+0x34/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4189ea
> Code: 41 54 55 41 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 6b f6 ff ff
> 45 31 d2 41 89 c0 44 89 e2 48 89 ee 89 df b8 3d 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 30 44 89 c7 89 44 24 0c e8 a2 f6 ff ff 8b 44
> RSP: 002b:00007ffd6f761890 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
> RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00000000004189ea
> RDX: 0000000040000001 RSI: 00007ffd6f761960 RDI: 00000000ffffffff
> RBP: 00007ffd6f761960 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000040000001
> R13: 0000000000000001 R14: 0000000000000032 R15: 0000000000000bb8
> Modules linked in:
> CR2: 0000000000000850
> ---[ end trace 2e5c6a8b7a712caf ]---
> RIP: 0010:wait_consider_task+0xc74/0x1750
> Code: 00 e8 00 e5 34 01 e9 50 f8 ff ff e8 16 b4 16 00 31 f6 31 ff e8
> 0d b5 16 00 e9 df fc ff ff e8 03 b4 16 00 48 8b 83 98 05 00 00 <4c> 8b
> b8 50 08 00 00 48 8b 83 a0 05 00 00 4c 8b b0 50 08 00 00 31
> RSP: 0018:ffffc90000ce7d20 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff888018805280 RCX: ffff888109629b80
> RDX: 0000000000000000 RSI: ffff888109629b80 RDI: 0000000000000002
> RBP: ffffc90000ce7d90 R08: ffffffff8126bf5d R09: 0000000000000000
> R10: 0000000000000005 R11: 0000000000000020 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000020 R15: 0000000040000000
> FS:  00000000027bc940(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000850 CR3: 0000000120602000 CR4: 00000000003526e0
> ----------------
> Code disassembly (best guess):
>    0: 00 e8                add    %ch,%al
>    2: 00 e5                add    %ah,%ch
>    4: 34 01                xor    $0x1,%al
>    6: e9 50 f8 ff ff        jmpq   0xfffff85b
>    b: e8 16 b4 16 00        callq  0x16b426
>   10: 31 f6                xor    %esi,%esi
>   12: 31 ff                xor    %edi,%edi
>   14: e8 0d b5 16 00        callq  0x16b526
>   19: e9 df fc ff ff        jmpq   0xfffffcfd
>   1e: e8 03 b4 16 00        callq  0x16b426
>   23: 48 8b 83 98 05 00 00 mov    0x598(%rbx),%rax
> * 2a: 4c 8b b8 50 08 00 00 mov    0x850(%rax),%r15 <-- trapping instruction
>   31: 48 8b 83 a0 05 00 00 mov    0x5a0(%rbx),%rax
>   38: 4c 8b b0 50 08 00 00 mov    0x850(%rax),%r14
>   3f: 31                    .byte 0x31
>
> Best,
> Wei
