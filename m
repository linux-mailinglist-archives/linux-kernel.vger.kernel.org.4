Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB46EC436
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 06:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDXEAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 00:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXEAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:00:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E326A3;
        Sun, 23 Apr 2023 21:00:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63d4595d60fso24924611b3a.0;
        Sun, 23 Apr 2023 21:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682308818; x=1684900818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD4zk8SXagl6Af10bvs1PSiqRe7ndVA9tW9qLEuXgDk=;
        b=OJWj9bSwNu8ICp4frOj9XYVCXr7Y+NvAD3AAdL3CYr7Ky/4Y5OKJov3N5UKAVAhA19
         2ujETFnQCY7XH3jVzYQYer/sozS76IDLqmXJ3FJ3H6ZoZDinxBQEh+3z4MVxNwyqNoo2
         pmhi1I62UwvZxVH+wV5mYulv2cj9HDFXENgRPXiX/i3MIUA9bjhmLKPaG/kbBdfTWl3A
         vzYYPlx+qW9yP2GJcjuz7RiRktK3PkyRMBFe9toXCWtJN18fwrslEEWRvMHq55vsNyDO
         fX9dR3ZxYcPXqnga7IHMPwpXaQgPEoyznG+trC4n2hi02v/0Ox+Cpq4wtsAoXQ3RzCHK
         ALDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682308818; x=1684900818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD4zk8SXagl6Af10bvs1PSiqRe7ndVA9tW9qLEuXgDk=;
        b=U9knZUsxnX0LcpfBm6g2rirTrF0sJ62NaKk6MtALKyIQV5Do8P/E5tmF7n+q98kqN7
         4f0urwgSPzt1204cCXBU/ZAr5IDxmjnZhSPYmbJZTy2MXlmkEK8RWLHhR9lEHXjlt3XX
         FA0D09F22x0BIcmVTrvVNgly9bnxKdzuEcMHQ6L4G6YcOYaVau+dZm9yoDLYem1eyTLm
         xWvJ1urh0tG0af787VWadayiHljFCgCzTd8yKMyzE4nitNfVkJPP92a+aXQAhaZNCXSl
         FdnEACeLL6o5bSH6AGjt35zHLAr95fsvDl4e4eTh8kHKSDutUpWHbX7AADZT9N5KbPnJ
         /b2w==
X-Gm-Message-State: AAQBX9dPA/Fd3cvUa3+rAe10JdDwMTaWyqIoizsI00Hq02nk8qZAL9x9
        cnyufBVdQGkuYy5uW9mCi2BY6b8cl7EhTxJaZvG1ZEbGucTVTw==
X-Google-Smtp-Source: AKy350b39GDAUkoNiB1UlootxQ+IW337QywwZP8iXGITg4fHx3aazqM6AmC31GQX11XAaWnZW9AIf0iYWm6PHGGAC7Y=
X-Received: by 2002:a17:90a:6e07:b0:24b:8d41:2930 with SMTP id
 b7-20020a17090a6e0700b0024b8d412930mr6174976pjk.24.1682308818081; Sun, 23 Apr
 2023 21:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com> <ZEXOMC2casTlobE1@boqun-archlinux>
In-Reply-To: <ZEXOMC2casTlobE1@boqun-archlinux>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 24 Apr 2023 12:00:06 +0800
Message-ID: <CAABZP2w6BeHvGwcofZ5PvDMKr4JxdoN5j-sBHMyiUAS7zLzDMg@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Boqun for your wonderful analysis!

On Mon, Apr 24, 2023 at 8:33=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Sat, Apr 22, 2023 at 09:28:39PM +0200, Joel Fernandes wrote:
> > On Sat, Apr 22, 2023 at 2:47=E2=80=AFPM Zhouyi Zhou <zhouzhouyi@gmail.c=
om> wrote:
> > >
> > > Dear PowerPC and RCU developers:
> > > During the RCU torture test on mainline (on the VM of Opensource Lab
> > > of Oregon State University), SRCU-P failed with __stack_chk_fail:
> > > [  264.381952][   T99] [c000000006c7bab0] [c0000000010c67c0]
> > > dump_stack_lvl+0x94/0xd8 (unreliable)
> > > [  264.383786][   T99] [c000000006c7bae0] [c00000000014fc94] panic+0x=
19c/0x468
> > > [  264.385128][   T99] [c000000006c7bb80] [c0000000010fca24]
> > > __stack_chk_fail+0x24/0x30
> > > [  264.386610][   T99] [c000000006c7bbe0] [c0000000002293b4]
> > > srcu_gp_start_if_needed+0x5c4/0x5d0
> > > [  264.388188][   T99] [c000000006c7bc70] [c00000000022f7f4]
> > > srcu_torture_call+0x34/0x50
> > > [  264.389611][   T99] [c000000006c7bc90] [c00000000022b5e8]
> > > rcu_torture_fwd_prog+0x8c8/0xa60
> > > [  264.391439][   T99] [c000000006c7be00] [c00000000018e37c] kthread+=
0x15c/0x170
> > > [  264.392792][   T99] [c000000006c7be50] [c00000000000df94]
> > > ret_from_kernel_thread+0x5c/0x64
> > > The kernel config file can be found in [1].
> > > And I write a bash script to accelerate the bug reproducing [2].
> > > After a week's debugging, I found the cause of the bug is because the
> > > register r10 used to judge for stack overflow is not constant between
> > > context switches.
> > > The assembly code for srcu_gp_start_if_needed is located at [3]:
> > > c000000000226eb4:   78 6b aa 7d     mr      r10,r13
> > > c000000000226eb8:   14 42 29 7d     add     r9,r9,r8
> > > c000000000226ebc:   ac 04 00 7c     hwsync
> > > c000000000226ec0:   10 00 7b 3b     addi    r27,r27,16
> > > c000000000226ec4:   14 da 29 7d     add     r9,r9,r27
> > > c000000000226ec8:   a8 48 00 7d     ldarx   r8,0,r9
> > > c000000000226ecc:   01 00 08 31     addic   r8,r8,1
> > > c000000000226ed0:   ad 49 00 7d     stdcx.  r8,0,r9
> > > c000000000226ed4:   f4 ff c2 40     bne-    c000000000226ec8
> > > <srcu_gp_start_if_needed+0x1c8>
> > > c000000000226ed8:   28 00 21 e9     ld      r9,40(r1)
> > > c000000000226edc:   78 0c 4a e9     ld      r10,3192(r10)
> > > c000000000226ee0:   79 52 29 7d     xor.    r9,r9,r10
> > > c000000000226ee4:   00 00 40 39     li      r10,0
> > > c000000000226ee8:   b8 03 82 40     bne     c0000000002272a0
> > > <srcu_gp_start_if_needed+0x5a0>
> > > by debugging, I see the r10 is assigned with r13 on c000000000226eb4,
> > > but if there is a context-switch before c000000000226edc, a false
> > > positive will be reported.
> > >
> > > [1] http://154.220.3.115/logs/0422/configformainline.txt
> > > [2] 154.220.3.115/logs/0422/whilebash.sh
> > > [3] http://154.220.3.115/logs/0422/srcu_gp_start_if_needed.txt
> > >
> > > My analysis and debugging may not be correct, but the bug is easily
> > > reproducible.
> >
> > If this is a bug in the stack smashing protection as you seem to hint,
> > I wonder if you see the issue with a specific gcc version and is a
> > compiler-specific issue. It's hard to say, but considering this I
>
> Very likely, more asm code from Zhouyi's link:
>
> This is the __srcu_read_unlock_nmisafe(), since "hwsync" is
> smp_mb__{after,before}_atomic(), and the following code is first
> barrier then atomic, so it's the unlock.
>
>         c000000000226eb4:       78 6b aa 7d     mr      r10,r13
>
> ^ r13 is the pointer to percpu data on PPC64 kernel, and it's also
> the pointer to TLS data for userspace code.
>
>         c000000000226eb8:       14 42 29 7d     add     r9,r9,r8
>         c000000000226ebc:       ac 04 00 7c     hwsync
>         c000000000226ec0:       10 00 7b 3b     addi    r27,r27,16
>         c000000000226ec4:       14 da 29 7d     add     r9,r9,r27
>         c000000000226ec8:       a8 48 00 7d     ldarx   r8,0,r9
>         c000000000226ecc:       01 00 08 31     addic   r8,r8,1
>         c000000000226ed0:       ad 49 00 7d     stdcx.  r8,0,r9
>         c000000000226ed4:       f4 ff c2 40     bne-    c000000000226ec8 =
<srcu_gp_start_if_needed+0x1c8>
>         c000000000226ed8:       28 00 21 e9     ld      r9,40(r1)
>         c000000000226edc:       78 0c 4a e9     ld      r10,3192(r10)
>
> here I think that the compiler is using r10 as an alias to r13, since
> for userspace program, it's safe to assume the TLS pointer doesn't
> change. However this is not true for kernel percpu pointer.
I learned a lot from your analysis, this is a fruitful learning
journey for me ;-)
>
> The real intention here is to compare 40(r1) vs 3192(r13) for stack
> guard checking, however since r13 is the percpu pointer in kernel, so
> the value of r13 can be changed if the thread gets scheduled to a
> different CPU after reading r13 for r10.
>
> __srcu_read_unlock_nmisafe() triggers this issue, because:
>
> * it contains a read from r13
> * it locates at the very end of srcu_gp_start_if_needed().
>
> This gives the compiler more opportunity to "optimize" a read from r13
> away.
Ah, this why adding __srcu_read_unlock_nmisafe() triggers this issue.
>
>         c000000000226ee0:       79 52 29 7d     xor.    r9,r9,r10
>         c000000000226ee4:       00 00 40 39     li      r10,0
>         c000000000226ee8:       b8 03 82 40     bne     c0000000002272a0 =
<srcu_gp_start_if_needed+0x5a0>
>
> As a result, here triggers __stack_chk_fail if mis-match.
>
> If I'm correct, the following should be a workaround:
>
>         diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>         index ab4ee58af84b..f5ae3be3d04d 100644
>         --- a/kernel/rcu/srcutree.c
>         +++ b/kernel/rcu/srcutree.c
>         @@ -747,6 +747,7 @@ void __srcu_read_unlock_nmisafe(struct srcu_s=
truct *ssp, int idx)
>
>                 smp_mb__before_atomic(); /* C */  /* Avoid leaking the cr=
itical section. */
>                 atomic_long_inc(&sdp->srcu_unlock_count[idx]);
>         +       asm volatile("" : : : "r13", "memory");
>          }
>          EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);
>
> Zhouyi, could you give a try? Note I think the "memory" clobber here is
> unnecesarry, but I just add it in case I'm wrong.
After applying above, the srcu_gp_start_if_needed becomes
http://140.211.169.189/0424/srcu_gp_start_if_needed.txt now.
Yes, the modified kernel has survived > 2 hours' test, while the
original kernel will certainly fail within 3 minutes.
>
>
> Needless to say, the correct fix is to make ppc stack protector aware of
> r13 is volatile.
Yes, agree, thank you

Thanks you all

Regards
Zhouyi
>
> Regards,
> Boqun
>
> > think it's important for you to mention the compiler version in your
> > report (along with kernel version, kernel logs etc.)
> >
> > thanks,
> >
> > - Joel
> >
> >
> >  - Joel
