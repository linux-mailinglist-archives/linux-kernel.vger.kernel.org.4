Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD8E74EB70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGKKEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGKKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:04:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6581139;
        Tue, 11 Jul 2023 03:04:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-262f7b67da8so2689149a91.0;
        Tue, 11 Jul 2023 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689069880; x=1691661880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xOIJUgkapAP72avfmFzfdA0jGofTeewsjRSu7enfrI=;
        b=VHC5237aBwdL/KC7j+cBL9NHJvdHvEHliZGzYdCmyqPY6YEL0FXIKMqvLpkbZjRiZZ
         H7hRrs8zh446Ncq6yhZORDv544/RQtyfB1jDO5jIwiIOmAEEyjYcR3YTRnLJxgC2sAmy
         rZPG7v/b4iCyRBi5L5X1vYF5Nve9GJFZ+KeEVx2xQWEK4Xqc1xQrMJ16DjcNm355hf1v
         Oi2u1SIULSiK1eITV/obTWCSmwKJ5noHVQ+xGMDYgbvIbIxYXABXdkuDd0080znRV6Fy
         rweGkHqjyfU1RlDrumd8TX/ib9QNDwDjtY+p+iBqC5cVfF1ReddQ/DCWxMorkXfyNZvU
         JgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689069880; x=1691661880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xOIJUgkapAP72avfmFzfdA0jGofTeewsjRSu7enfrI=;
        b=lOZxi/Y/yQpkwfvd1JD623/VF/N5x9y5oDYUPIbSv5CXjx+Kbl5RhrGgRs2/kx/03T
         EarAecHS1bUNBtcUkS6rnNeDUOp2wjcf3RJMrUdCymcIzhf/j4qKFE+yVNPtD8dH1bKt
         mbd8jNSzAerWgeBYKt5mDz/JtYKoDwXNvFZY1NZ34VSjj8/40rrn5XjXIgTVf33TAPQq
         yUhlZGIeuLDS5Qny/tYnm036e5uKwZAEzBL9cPSi3FKQC1tHRX2WJDB+9MNRgX9CsN7j
         YaMaer01fUCMtgttXveNh+iWq8Ve/6lG03GY76d3R2YYsDYMXdXs8Kp+d6WQ7t9wzAns
         oI4w==
X-Gm-Message-State: ABy/qLZTlioY4deNY8Q46808n9WTNl2D7FPEW2OFdPnwpkB3kg85eisZ
        7qHhoZhNptkkvUDR0Xkgd+UsXLheb58K8kTB/r+07gaGnwI=
X-Google-Smtp-Source: APBJJlFRa55xTXo4H9FtJhOd8zISLE11HWnZRLATctJyPudegXfa5LG8kudTbSIx5f6gcALsNxUMRB05gn/fgGJWsb8=
X-Received: by 2002:a17:90b:46cf:b0:262:fe3e:a7c4 with SMTP id
 jx15-20020a17090b46cf00b00262fe3ea7c4mr2176832pjb.4.1689069880045; Tue, 11
 Jul 2023 03:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <202307111535.4823c255-oliver.sang@intel.com> <CALm+0cUSb+tKqa4O3f_kJxrW1=jjS-iAiG_a4Fz4NQtww7ppAA@mail.gmail.com>
In-Reply-To: <CALm+0cUSb+tKqa4O3f_kJxrW1=jjS-iAiG_a4Fz4NQtww7ppAA@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 11 Jul 2023 18:04:27 +0800
Message-ID: <CALm+0cV+hMRnvT6AwfXHBBqSk5W0ad8gGxqogOvKUVKb0vG0Gw@mail.gmail.com>
Subject: Re: [linus:master] [rcu/nocb] 7625926086: WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 5:45=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.com>=
 wrote:
>
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_=
try_bypass" on:
> >
> > commit: 7625926086765123251f765d91fc3a70617d334d ("rcu/nocb: Fix shrink=
er race against callback enqueuer")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [test failed on linus/master Linux 6.5-rc1]
> > [test failed on linux-next/master fe57d0d86f03a8b2afe2869a95477d0ed1824=
c96]
> >
> > in testcase: trinity
> > version: trinity-i386-abe9de86-1_20230429
> > with following parameters:
> >
> >         runtime: 300s
> >         group: group-00
> >
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> >
> >
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> > the WARNING only happens in a low rate (10 out of 204 runs as below).
> > but since we never observed the issue on parent, and we also noticed
> > there is a WARN_ON_ONCE in code change, so just report what we observed
> > in our tests FYI.
> >
> > 5c83cedbaaad6dfe 7625926086765123251f765d91f
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :202          5%          10:204   dmesg.RIP:rcu_nocb_bypass=
_lock
> >            :202          5%          10:204   dmesg.RIP:rcu_nocb_try_by=
pass
> >            :202          5%          10:204   dmesg.WARNING:at_kernel/r=
cu/tree_nocb.h:#rcu_nocb_bypass_lock
> >            :202          5%          10:204   dmesg.WARNING:at_kernel/r=
cu/tree_nocb.h:#rcu_nocb_try_bypass
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202307111535.4823c255-oliver.s=
ang@intel.com
> >
> >
> >
> > [ 315.569574][ T16] WARNING: CPU: 1 PID: 16 at kernel/rcu/tree_nocb.h:1=
24 rcu_nocb_try_bypass (kernel/rcu/tree_nocb.h:124 kernel/rcu/tree_nocb.h:5=
13)
> > [  315.569582][   T16] Modules linked in: crc32c_intel polyval_clmulni =
polyval_generic ghash_clmulni_intel rapl qemu_fw_cfg intel_agp intel_gtt
> > [  315.569591][   T16] CPU: 1 PID: 16 Comm: rcuop/0 Not tainted 6.4.0-r=
c1-00002-g762592608676 #1
> > [ 315.569594][ T16] RIP: 0010:rcu_nocb_try_bypass (kernel/rcu/tree_nocb=
.h:124 kernel/rcu/tree_nocb.h:513)
> > [ 315.569965][ T49] WARNING: CPU: 0 PID: 49 at kernel/rcu/tree_nocb.h:1=
04 rcu_nocb_bypass_lock (kernel/rcu/tree_nocb.h:104 (discriminator 11))
> > [ 315.570472][ T16] Code: 41 0f b6 34 24 48 8b 54 24 08 e9 23 01 00 00 =
65 8b 05 32 7b f3 7e 3b 83 90 05 00 00 74 02 0f 0b 8b 83 48 02 00 00 85 c0 =
74 06 <0f> 0b f3 90 eb f0 48 89 df e8 44 7f ff ff 48 8b 3c 24 4c 8b a3 90
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   41 0f b6 34 24          movzbl (%r12),%esi
> >    5:   48 8b 54 24 08          mov    0x8(%rsp),%rdx
> >    a:   e9 23 01 00 00          jmp    0x132
> >    f:   65 8b 05 32 7b f3 7e    mov    %gs:0x7ef37b32(%rip),%eax       =
 # 0x7ef37b48
> >   16:   3b 83 90 05 00 00       cmp    0x590(%rbx),%eax
> >   1c:   74 02                   je     0x20
> >   1e:   0f 0b                   ud2
> >   20:   8b 83 48 02 00 00       mov    0x248(%rbx),%eax
> >   26:   85 c0                   test   %eax,%eax
> >   28:   74 06                   je     0x30
> >   2a:*  0f 0b                   ud2             <-- trapping instructio=
n
> >   2c:   f3 90                   pause
> >   2e:   eb f0                   jmp    0x20
> >   30:   48 89 df                mov    %rbx,%rdi
> >   33:   e8 44 7f ff ff          call   0xffffffffffff7f7c
> >   38:   48 8b 3c 24             mov    (%rsp),%rdi
> >   3c:   4c                      rex.WR
> >   3d:   8b                      .byte 0x8b
> >   3e:   a3                      .byte 0xa3
> >   3f:   90                      nop
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   0f 0b                   ud2
> >    2:   f3 90                   pause
> >    4:   eb f0                   jmp    0xfffffffffffffff6
> >    6:   48 89 df                mov    %rbx,%rdi
> >    9:   e8 44 7f ff ff          call   0xffffffffffff7f52
> >    e:   48 8b 3c 24             mov    (%rsp),%rdi
> >   12:   4c                      rex.WR
> >   13:   8b                      .byte 0x8b
> >   14:   a3                      .byte 0xa3
> >   15:   90                      nop
> > [  315.570981][   T49] Modules linked in: crc32c_intel
> > [  315.571642][   T16] RSP: 0000:ffffc9000008bd60 EFLAGS: 00010002
> > [  315.572102][   T49]  polyval_clmulni
> > [  315.572412][   T16]
> > [  315.572413][   T16] RAX: 0000000000000001 RBX: ffff88842fd2e9c0 RCX:=
 0000000000000040
> > [  315.572911][   T49]  polyval_generic
> > [  315.573917][   T16] RDX: 0000000100000eb8 RSI: ffff88842fd2ebe0 RDI:=
 ffff88842fd2ea60
> > [  315.574200][   T49]  ghash_clmulni_intel
> > [  315.574517][   T16] RBP: 0000000100000eb8 R08: 0000000000000001 R09:=
 0000000000000001
> > [  315.574715][   T49]  rapl qemu_fw_cfg
> > [  315.574841][   T16] R10: 0000000000000000 R11: ffff88817e599608 R12:=
 ffffc9000008bdcf
> > [  315.575254][   T49]  intel_agp
> > [  315.575450][   T16] R13: 0000000000000001 R14: 0000000000000002 R15:=
 0000000000000002
> > [  315.575863][   T49]  intel_gtt
> > [  315.576078][   T16] FS:  0000000000000000(0000) GS:ffff88842fd00000(=
0000) knlGS:0000000000000000
> > [  315.576491][   T49]
> > [  315.576694][   T16] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [  315.577105][   T49] CPU: 0 PID: 49 Comm: kswapd0 Not tainted 6.4.0-r=
c1-00002-g762592608676 #1
> > [  315.577277][   T16] CR2: 00000000f7f6f2e8 CR3: 0000000165fc4000 CR4:=
 00000000000406a0
> > [ 315.577689][ T49] RIP: 0010:rcu_nocb_bypass_lock (kernel/rcu/tree_noc=
b.h:104 (discriminator 11))
> > [  315.577861][   T16] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=
 0000000000000000
> > [ 315.578340][ T49] Code: 0b 48 8d ab 40 03 00 00 48 89 ef e8 2f 78 af =
00 85 c0 75 27 f0 ff 83 48 02 00 00 65 8b 05 85 fb f3 7e 39 83 90 05 00 00 =
74 02 <0f> 0b 48 89 ef e8 67 76 af 00 f0 ff 8b 48 02 00 00 5b 5d c3 cc 83
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   0b 48 8d                or     -0x73(%rax),%ecx
> >    3:   ab                      stos   %eax,%es:(%rdi)
> >    4:   40 03 00                rex add (%rax),%eax
> >    7:   00 48 89                add    %cl,-0x77(%rax)
> >    a:   ef                      out    %eax,(%dx)
> >    b:   e8 2f 78 af 00          call   0xaf783f
> >   10:   85 c0                   test   %eax,%eax
> >   12:   75 27                   jne    0x3b
> >   14:   f0 ff 83 48 02 00 00    lock incl 0x248(%rbx)
> >   1b:   65 8b 05 85 fb f3 7e    mov    %gs:0x7ef3fb85(%rip),%eax       =
 # 0x7ef3fba7
> >   22:   39 83 90 05 00 00       cmp    %eax,0x590(%rbx)
> >   28:   74 02                   je     0x2c
> >   2a:*  0f 0b                   ud2             <-- trapping instructio=
n
> >   2c:   48 89 ef                mov    %rbp,%rdi
> >   2f:   e8 67 76 af 00          call   0xaf769b
> >   34:   f0 ff 8b 48 02 00 00    lock decl 0x248(%rbx)
> >   3b:   5b                      pop    %rbx
> >   3c:   5d                      pop    %rbp
> >   3d:   c3                      ret
> >   3e:   cc                      int3
> >   3f:   83                      .byte 0x83
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   0f 0b                   ud2
> >    2:   48 89 ef                mov    %rbp,%rdi
> >    5:   e8 67 76 af 00          call   0xaf7671
> >    a:   f0 ff 8b 48 02 00 00    lock decl 0x248(%rbx)
> >   11:   5b                      pop    %rbx
> >   12:   5d                      pop    %rbp
> >   13:   c3                      ret
> >   14:   cc                      int3
> >   15:   83                      .byte 0x83
> > [  315.578467][   T16] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=
 0000000000000400
> > [  315.578809][   T49] RSP: 0018:ffffc9000019bcb0 EFLAGS: 00010002
> > [  315.579259][   T16] Call Trace:
> > [  315.579261][   T16]  <TASK>
> > [  315.579673][   T49]
> > [  315.579674][   T49] RAX: 0000000000000000 RBX: ffff88842fd2e9c0 RCX:=
 0000000000000000
> > [ 315.579980][ T16] ? find_next_bit (arch/x86/events/core.c:816 arch/x8=
6/events/core.c:965)
> > [  315.580390][   T49] RDX: ffff88842fd2ebe0 RSI: ffff88842fd2ebe0 RDI:=
 ffff88842fd2ed00
> > [ 315.581398][ T16] __call_rcu_common (kernel/rcu/tree.c:2644)
> > [  315.581812][   T49] RBP: ffff88842fd2ed00 R08: 0000000000000001 R09:=
 0000000000000001
> > [ 315.582136][ T16] slab_free+0x53/0xf7
> > [  315.582311][   T49] R10: ffff88842fd2ebe0 R11: 0000000000000001 R12:=
 0000000000000000
> > [ 315.582469][ T16] rcu_do_batch (kernel/rcu/tree.c:2117)
> > [  315.582594][   T49] R13: 0000000100000eb8 R14: ffffc9000019bd88 R15:=
 0000000000000202
> > [ 315.583009][ T16] nocb_cb_wait (kernel/rcu/tree_nocb.h:955)
> > [  315.583301][   T49] FS:  0000000000000000(0000) GS:ffff88842fc00000(=
0000) knlGS:0000000000000000
> > [ 315.583716][ T16] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:1003)
> > [  315.583975][   T49] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [ 315.584388][ T16] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:1010 (d=
iscriminator 24))
> > [  315.584686][   T49] CR2: 00000000590fb014 CR3: 0000000179d50000 CR4:=
 00000000000406b0
> > [ 315.585100][ T16] kthread (kernel/kthread.c:381)
> > [  315.585339][   T49] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=
 0000000000000000
> > [ 315.585752][ T16] ? kthread_complete_and_exit (kernel/kthread.c:332)
> > [  315.585990][   T49] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=
 0000000000000400
> > [ 315.586462][ T16] ret_from_fork (arch/x86/entry/entry_64.S:314)
> > [  315.586710][   T49] Call Trace:
> > [  315.586711][   T49]  <TASK>
> > [  315.587058][   T16]  </TASK>
> > [ 315.587313][ T49] rcu_nocb_flush_bypass (kernel/rcu/tree_nocb.h:381)
> > [  315.587727][   T16] irq event stamp: 38560087
> > [ 315.587934][ T49] lazy_rcu_shrink_scan (kernel/rcu/tree_nocb.h:1367 (=
discriminator 6))
> > [ 315.588346][ T16] hardirqs last enabled at (38560086): _raw_spin_unlo=
ck_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqf=
lags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_sm=
p.h:151 kernel/locking/spinlock.c:194)
> > [ 315.588643][ T49] do_shrink_slab+0x1d0/0x2ea
> > [ 315.589056][ T16] hardirqs last disabled at (38560087): __call_rcu_co=
mmon (kernel/rcu/tree.c:2629 (discriminator 3))
> > [ 315.589292][ T49] shrink_slab+0xa7/0x136
> > [ 315.589466][ T16] softirqs last enabled at (38560080): local_bh_enabl=
e (include/linux/bottom_half.h:33)
> > [ 315.589624][ T49] shrink_node (arch/x86/include/asm/current.h:41 mm/v=
mscan.c:565 mm/vmscan.c:6503)
> > [ 315.589784][ T16] softirqs last disabled at (38560082): local_bh_disa=
ble (include/linux/bottom_half.h:20)
> > [ 315.590054][ T49] balance_pgdat (mm/vmscan.c:7296 mm/vmscan.c:7477)
> > [  315.590296][   T16] ---[ end trace 0000000000000000 ]---
> > [ 315.590570][ T49] kswapd (mm/vmscan.c:7737)
> > [ 315.594237][ T49] ? balance_pgdat (mm/vmscan.c:7670)
> > [ 315.594498][ T49] kthread (kernel/kthread.c:381)
> > [ 315.594711][ T49] ? kthread_complete_and_exit (kernel/kthread.c:332)
> > [ 315.595014][ T49] ret_from_fork (arch/x86/entry/entry_64.S:314)
> > [  315.595260][   T49]  </TASK>
> > [  315.595427][   T49] irq event stamp: 123174
> > [ 315.595658][ T49] hardirqs last enabled at (123173): raw_spin_rq_unlo=
ck_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:=
77 kernel/sched/sched.h:1378)
> > [ 315.596191][ T49] hardirqs last disabled at (123174): lazy_rcu_shrink=
_scan (kernel/rcu/tree_nocb.h:1366 (discriminator 3))
> > [ 315.596724][ T49] softirqs last enabled at (122534): __do_softirq (ar=
ch/x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600)
> > [ 315.597222][ T49] softirqs last disabled at (122527): __irq_exit_rcu =
(kernel/softirq.c:445 kernel/softirq.c:650)
> > [  315.597720][   T49] ---[ end trace 0000000000000000 ]---
> > [  315.622775][  T212] [main] kernel became tainted! (512/0) Last seed =
was 144492271
> > [  315.622787][  T212]
> > [  315.624666][  T212] trinity: Detected kernel tainting. Last seed was=
 144492271
> > [  315.624673][  T212]
> > [  315.626388][  T212] [main] 1282601 iterations. [F:915248 S:367378 HI=
:102957]
> >
> >
>
>
>
> The CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=3Dy
> WARNING: CPU: 1 PID: 16 at kernel/rcu/tree_nocb.h:124
> rcu_nocb_try_bypass+0x28d/0x3cc
> WARNING: CPU: 0 PID: 49 at kernel/rcu/tree_nocb.h:104
> rcu_nocb_bypass_lock+0x4f/0x64
>
> it looks like this:
>
>                                             CPU0
>
>                                                   CPU1
> kswapd
>    ->balance_pgdat
>
>                               rcu_nocb_cb_kthread()
>        ->shrink_node
>
>                                  ->nocb_cb_wait()
>           ->shrink_slab
>
>                                       ->rcu_do_batch()
>              ->do_shrink_slab
>
>                                       ->slab_free()
>                 ->lazy_rcu_shrink_scan
>
>                                       ->__call_rcu_common()
>                     ->for_each_cpu(cpu, rcu_nocb_mask)
>
>                               ->rdp =3D this_cpu_ptr(&rcu_data)  --->
> CPU1's rdp
>                              struct rcu_data *rdp =3D
> per_cpu_ptr(&rcu_data, CPU1);
>                                           ->rcu_nocb_try_bypass()
>                               rcu_nocb_flush_bypass(rdp);
>
>                                           .....
>                                     rcu_nocb_bypass_lock(rdp)
>                                           atomic_inc(&rdp->nocb_lock_cont=
ended);
>
> WARN_ON_ONCE(smp_processor_id() !=3D rdp->cpu);
>
> ->rcu_nocb_wait_contended(rdp);
>
>
>
> atomic_read(&rdp->nocb_lock_contended))
>

kswapd run on CPU0 to access  CPU1's rdp and inc
rdp->nocb_lock_contended,  trigger WARN_ON_ONCE(smp_processor_id() !=3D
rdp->cpu),
CPU1 invoke rcu_nocb_try_bypass() trigger
WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended).

> Should the  WARN_ON_ONCE() check be removed?
>
>
> Thanks
> Zqiang
>
>
>
>
>
>
> >
> > To reproduce:
> >
> >         # build kernel
> >         cd linux
> >         cp config-6.4.0-rc1-00002-g762592608676 .config
> >         make HOSTCC=3Dgcc-12 CC=3Dgcc-12 ARCH=3Dx86_64 olddefconfig pre=
pare modules_prepare bzImage modules
> >         make HOSTCC=3Dgcc-12 CC=3Dgcc-12 ARCH=3Dx86_64 INSTALL_MOD_PATH=
=3D<mod-install-dir> modules_install
> >         cd <mod-install-dir>
> >         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> >
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-scrip=
t is attached in this email
> >
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
