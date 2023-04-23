Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5764A6EBC4D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 03:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjDWBhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 21:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDWBhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 21:37:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F1110FD;
        Sat, 22 Apr 2023 18:37:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63d4595d60fso21226098b3a.0;
        Sat, 22 Apr 2023 18:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682213863; x=1684805863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsurlK6VENblxj4mf7Tci56cnC08MORC7tAWdMf8iDY=;
        b=GW+uIkK8UzXnxKsMvloIAxwrvkdXj9/vtxk+4V/8297cZ03rHI60kHkk1ilK2DiOSK
         TDgamoxvmHndKSr9hGicEaDXkwu+opCXhoYN+LQeBjpoD3ez3fw/DK0c93YwWLnJfLJ0
         hNaC0ThCAWEMZzsH6p26nk5za62NSA6R9OnWX97fHniveC/nkUBNfu5HyCylbmZ3URdd
         uGIuiVJnVb5cejMJvfMOBdxuftu/QQBvmvyNBpJ0Bz8mqPn1GlNUw4vWgVy5cKo2Wtgv
         AtO57uuoWkRrpjOQvxcQTeeJEqLdAZZ4toZzv72GMdzVZG0/644t/foOJHuA7kNE3U5U
         idhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682213863; x=1684805863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsurlK6VENblxj4mf7Tci56cnC08MORC7tAWdMf8iDY=;
        b=ONXmU+KZOC3DETgk50GAwMqKaoL8GKCWMkCBc8JDK2yKILfN+z71Bq9CoFl7iyd91P
         NdA+TheeTw0WdiBapF0S9k+AatGvf+a0jAsJO3OfEVsYcsarDoY/gV0aKg6mK0AzCE8E
         Qc6CnD9SrW/VBwunoMYrGLTS7qShzkz5RfVgY06ld081Bgp2AIiYWZaPP2oO5Rjeoq+T
         ocKWBSA0nIUn9/KroL7y14bzorOtTCcLm/hu48U5GoOJARq2Ieb5qApUNT9St8lVIohf
         IrcXb1j3023paIhMFpA5iwI5ISJ76uOflSyOdbbxR5eigd1CuKlZTF57lmD6Ur/kSXkU
         7YMw==
X-Gm-Message-State: AAQBX9cjZlVdeO+ukv+HtOQNUOTuyISKgjz0XyTgRMzVd5taoZvu4LB5
        RfNry+dphUGSn8k3yUchBjyPQBd9gNubMtqT3DE=
X-Google-Smtp-Source: AKy350bmNNIdjFr7GnLMJAbnekfliFYN7kAF/Ma1a12gSBCOc+pZb8nKvoRfqL+ayBslEnVKlCax8jSZqBAJx2JKatM=
X-Received: by 2002:a17:90a:b005:b0:24b:60d0:d622 with SMTP id
 x5-20020a17090ab00500b0024b60d0d622mr8083585pjq.24.1682213863274; Sat, 22 Apr
 2023 18:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YQCugPs1bquaA4ZLdsM4S3hWv9OMNTt80tSvjCO0LwiHg@mail.gmail.com>
In-Reply-To: <CAEXW_YQCugPs1bquaA4ZLdsM4S3hWv9OMNTt80tSvjCO0LwiHg@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sun, 23 Apr 2023 09:37:32 +0800
Message-ID: <CAABZP2wE8Gz9wV_YAjNsFo7V=rpymuLOqVJ0=aAmwixqPiHTiQ@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Sun, Apr 23, 2023 at 3:19=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hi Zhouyi,
Thank Joel for your quick response ;-)
I will gradually provide all the necessary information to facilitate
our chasing. Please do not hesitate email me
if I have ignored any ;-)
>
> On Sat, Apr 22, 2023 at 2:47=E2=80=AFPM Zhouyi Zhou <zhouzhouyi@gmail.com=
> wrote:
> >
> > Dear PowerPC and RCU developers:
> > During the RCU torture test on mainline (on the VM of Opensource Lab
> > of Oregon State University), SRCU-P failed with __stack_chk_fail:
> > [  264.381952][   T99] [c000000006c7bab0] [c0000000010c67c0]
> > dump_stack_lvl+0x94/0xd8 (unreliable)
> > [  264.383786][   T99] [c000000006c7bae0] [c00000000014fc94] panic+0x19=
c/0x468
> > [  264.385128][   T99] [c000000006c7bb80] [c0000000010fca24]
> > __stack_chk_fail+0x24/0x30
> > [  264.386610][   T99] [c000000006c7bbe0] [c0000000002293b4]
> > srcu_gp_start_if_needed+0x5c4/0x5d0
> > [  264.388188][   T99] [c000000006c7bc70] [c00000000022f7f4]
> > srcu_torture_call+0x34/0x50
> > [  264.389611][   T99] [c000000006c7bc90] [c00000000022b5e8]
> > rcu_torture_fwd_prog+0x8c8/0xa60
> > [  264.391439][   T99] [c000000006c7be00] [c00000000018e37c] kthread+0x=
15c/0x170
> > [  264.392792][   T99] [c000000006c7be50] [c00000000000df94]
> > ret_from_kernel_thread+0x5c/0x64
> > The kernel config file can be found in [1].
> > And I write a bash script to accelerate the bug reproducing [2].
> > After a week's debugging, I found the cause of the bug is because the
> > register r10 used to judge for stack overflow is not constant between
> > context switches.
> > The assembly code for srcu_gp_start_if_needed is located at [3]:
> > c000000000226eb4:   78 6b aa 7d     mr      r10,r13
> > c000000000226eb8:   14 42 29 7d     add     r9,r9,r8
> > c000000000226ebc:   ac 04 00 7c     hwsync
> > c000000000226ec0:   10 00 7b 3b     addi    r27,r27,16
> > c000000000226ec4:   14 da 29 7d     add     r9,r9,r27
> > c000000000226ec8:   a8 48 00 7d     ldarx   r8,0,r9
> > c000000000226ecc:   01 00 08 31     addic   r8,r8,1
> > c000000000226ed0:   ad 49 00 7d     stdcx.  r8,0,r9
> > c000000000226ed4:   f4 ff c2 40     bne-    c000000000226ec8
> > <srcu_gp_start_if_needed+0x1c8>
> > c000000000226ed8:   28 00 21 e9     ld      r9,40(r1)
> > c000000000226edc:   78 0c 4a e9     ld      r10,3192(r10)
> > c000000000226ee0:   79 52 29 7d     xor.    r9,r9,r10
> > c000000000226ee4:   00 00 40 39     li      r10,0
> > c000000000226ee8:   b8 03 82 40     bne     c0000000002272a0
> > <srcu_gp_start_if_needed+0x5a0>
> > by debugging, I see the r10 is assigned with r13 on c000000000226eb4,
> > but if there is a context-switch before c000000000226edc, a false
> > positive will be reported.
> >
> > [1] http://154.220.3.115/logs/0422/configformainline.txt
> > [2] 154.220.3.115/logs/0422/whilebash.sh
> > [3] http://154.220.3.115/logs/0422/srcu_gp_start_if_needed.txt
> >
> > My analysis and debugging may not be correct, but the bug is easily
> > reproducible.
>
> Could you provide the full kernel log? It is not clear exactly from
> your attachments, but I think this is a stack overflow issue as
> implied by the mention of __stack_chk_fail. One trick might be to turn
> on any available stack debug kernel config options, or check the
> kernel logs for any messages related to shortage of remaining stack
> space.
The full kernel log is [1]
[1] http://154.220.3.115/logs/0422/console.log
>
> Additionally, you could also find out where the kernel crash happened
> in C code following the below notes [1] I wrote (see section "Figuring
> out where kernel crashes happen in C code"). The notes are
> x86-specific but should be generally applicable (In the off chance
> you'd like to improve the notes, feel free to share them ;-)).
Fantastic article!!!, I benefit a lot from reading it. Because we can
reproduce it so easily on powerpc VM,
I can even use gdb to debug it, following is my debug process on
2e83b879fb91dafe995967b46a1d38a5b0889242(srcu: Create an
srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe()).

[2] http://154.220.3.115/logs/0422/gdb.txt
>
> Lastly, is it a specific kernel release from which you start seeing
> this issue? You should try git bisect if it is easily reproducible in
> a newer release, but goes away in an older one.
I did bisect on powerpc VM, the problem begin to appear on
2e83b879fb91dafe995967b46a1d38a5b0889242(srcu: Create an
srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe()).

The kernel is good at 5d0f5953b60f5f7a278085b55ddc73e2932f4c33(srcu:
Convert ->srcu_lock_count and ->srcu_unlock_count to atomic)

But if I apply the following patch [3] to
5d0f5953b60f5f7a278085b55ddc73e2932f4c33, the bug appears again.
[3] http://154.220.3.115/logs/0422/bug.patch

Both native gcc on PPC vm (gcc version 9.4.0), and gcc cross compiler
on my x86 laptop (gcc version 10.4.0) will reproduce the bug.
>
> I will also join you in your debug efforts soon though I am currently
> in between conferences.
Exciting!! Thank you very much!
I can give you ssh access (based on rsa pub key) to PPC vm on Oregon
State University if you like.

Thanks again
Zhouyi
>
> [1] https://gist.github.com/joelagnel/ae15c404facee0eb3ebb8aff0e996a68
>
> thanks,
>
>  - Joel
>
>
>
>
> >
> > Thanks
> > Zhouyi
