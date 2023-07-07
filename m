Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE2274A8C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGGCJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGGCJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:09:18 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769771709
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:09:16 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-794cddcab71so530520241.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 19:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688695755; x=1691287755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=loqW22wuoKMuno5FXgzwjahhKM4TiUSzWOa3tNZOKjw=;
        b=op/2A1G1bfRmixNAG+OKxYYihwcVCs4FT2kMe0e86NGyOohzplPoCqGUUalIvD5Qai
         ehvRRoZzltmr0irrngGKlnRXx6l/piomlsxLbAXobtn+AuX3DqanXJfKwgJGwOXF9PzE
         g5BZIiHNfZfNtUQC1iAzMq1LkgPPNPMGpKPRfYdERcymb2lIRv5KCPNpyLzuXMOoqBai
         nm2KJhY+SHx9kytni0bL4DxMpTzddkLg5d4mJV7Mx5VwXFeG3BcWYYltKFLPaeB/6aku
         PWldYTB+SN8aKabt2Vyqzk7ozNSZxKFoqBIxg3zNTTpOGEph0KElx42ErZEkDccBu/qc
         84HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688695755; x=1691287755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loqW22wuoKMuno5FXgzwjahhKM4TiUSzWOa3tNZOKjw=;
        b=IEq1nQKbrkMgSQ37xI8Iw16oageXZANnwAyWyVg/bGuPlAMkLXpb/8DEheqPTEmtW0
         oWYPBrQcFq4yUBEI0nk4ts5qodIVxoP4BahiU9of2qB+hqQSEnL7yFedXDz2tPnFahVe
         4+p6bNtDf3wdX+ekGaXDYTSUR8VWc+jlo2nWhyhsYbVa47NTyyaehJ45B4hi3n87GAPd
         A1IGY6ygfF+v/wtLQwUIECu1xI8VNXcry8pt//kQTTKsJE9EbuDflhSozOTTf2yvdglv
         J8okIMiHfC56BI3JzvT5fhTEkKjGgKQUQj75oTNpSh4L8Iiq9GuBhVG0cOsAo+ovCTsV
         tvrw==
X-Gm-Message-State: ABy/qLaadAHDFu5CyJhR11ZRlrA5OSFnuwO1ICiRBUAs85eaO3o0ug2b
        O1ETWT0gGc0hgeimh334Fz9Ukd7+xJecD/zdozc2sod/HUE=
X-Google-Smtp-Source: APBJJlE5i5Nhg0OPrI3DSJathyjiauKG+4zPHUzv2PaNLf5cWZM7JoqObJPGqGI2ZtqitDLRicMQLqUsOn72Hf2Nw6s=
X-Received: by 2002:a67:b14b:0:b0:443:92af:a851 with SMTP id
 z11-20020a67b14b000000b0044392afa851mr2315437vsl.32.1688695755387; Thu, 06
 Jul 2023 19:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
 <20230706120103.GJ2833176@hirez.programming.kicks-ass.net> <CAG-UpRTQ-ovVO02HRd5z-9oZGCPvZ0vODJse8oyuA9L-3NV_pQ@mail.gmail.com>
In-Reply-To: <CAG-UpRTQ-ovVO02HRd5z-9oZGCPvZ0vODJse8oyuA9L-3NV_pQ@mail.gmail.com>
From:   Henry Wu <triangletrap12@gmail.com>
Date:   Fri, 7 Jul 2023 10:09:04 +0800
Message-ID: <CAG-UpRRLFTHg64b0hG4=FbuzhhqNQEU8jGt6TygCVAK1BaT2kQ@mail.gmail.com>
Subject: Fwd: Possible race in rt_mutex_adjust_prio_chain
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a2507905ffdc1e8b"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a2507905ffdc1e8b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I forget to CC linux-kernel, sorry for duplicate mail.

Hi, Peter.

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=886=E6=
=97=A5=E5=91=A8=E5=9B=9B 20:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jul 06, 2023 at 02:08:20PM +0800, Henry Wu wrote:
> > Hi,
> >
> > I found that it's not safe to change waiter->prio after waiter
> > dequeued from mutex's waiter rbtree because it's still on owner's
> > pi_waiters rbtree. From my analysis, waiters on pi_waiters rbtree
> > should be protected by pi_lock of task which have pi_waiters and
> > corresponding rt_mutex's wait_lock, but pi_waiters is shared by many
> > locks owned by this task, so actually we serialize changes on
> > pi_waiters only by pi_lock.
> >
> > `rt_mutex_adjust_prio_chain' changes key of nodes of pi_waiters rbtree
> > without pi_lock and pi_waiters rbtree's invariant is violated. Maybe
> > we are enqueuing waiter on other cpu and pi_waiters rbtree will be
> > corrupted.
>
> Are you talking about [7];
>
> Where we do waiter_update_prio() while only
> holding [L] rtmutex->wait_lock.
>
> VS
>
> rt_mutex_adjust_prio() / task_top_pi_waiter() that accesses ->pi_waiters
> while holding [P] task->pi_lock.
>
> ?
>
> I'll go stare at that in more detail -- but I wanted to verify that's
> what you're talking about.
>

I refered step 7. I checked every call site of rt_mutex_adjust_prio()
and all of them are protected by the right pi_lock.

Imagine a scenario that we have two rt_mutex (M1, M2) and three
threads (A, B, C). Both rt_mutex are owned by thread A. B is blocked
when acquiring M1 and C is blocked when acquiring M2. We use
sched_setattr to change priority of B and C.

CPU0                                             CPU1
.........                                              ..........

rt_mutex_adjust_prio_chain(C)
rt_mutex_adjust_prio_chain(B)
......
[7] update waiter->prio
(Now A's pi_waiters rbtree is
 corrupted temporarily)
......                                                 [11] enqueue
operation may select
                                                       insert position
according to corrupted
                                                       waiter node CPU0 cre=
ated.
[11] Even though we fixed
corrupted waiter now, we
are not sure about pi_waiters's
sanity because other cpu may
create new invariant violation
based on our violation.

> > I attach a source file which can trigger this violation. I tested it
> > on Ubuntu 20.04 LTS with 5.4 kernel.
>
> Well, that's a horribly old kernel :-( Please double check on v6.4 and
> consult that code for the discussion above -- I'm really not too
> interested in debugging something ancient.

I revised my code to make it work on 6.4.2 and fixed one logic error.
I tested it on Fedora 38 with kernel 6.4.2-858.vanilla.fc38.x86_64.
You can find the new code in attachment.

$ sudo ./a.out
.........................
prio: -21
prio: -21
prio: -21
prio: -21
prio: -21
prio: -21
prio: -20
prio: -20
prio: -20
prio: -20
prio: -20
prio: -20
prio: -20
prio: -20
prio: -20
prio: -20
prio: -20
    PID     LWP TTY          TIME CMD
   4564    4564 pts/0    00:00:01 a.out
   4564    4565 pts/0    00:00:00 waiter-0
   4564    4566 pts/0    00:00:00 waiter-1
   4564    4567 pts/0    00:00:00 waiter-2
   4564    4568 pts/0    00:00:00 waiter-3
   4564    4569 pts/0    00:00:00 waiter-4
   4564    4570 pts/0    00:00:00 waiter-5
   4564    4571 pts/0    00:00:00 waiter-6
   4564    4572 pts/0    00:00:00 waiter-7
   4564    4573 pts/0    00:00:00 waiter-8
   4564    4574 pts/0    00:00:00 waiter-9
   4564    4575 pts/0    00:00:00 waiter-10
   4564    4576 pts/0    00:00:00 waiter-11
   4564    4577 pts/0    00:00:00 waiter-12
   4564    4578 pts/0    00:00:00 waiter-13
   4564    4579 pts/0    00:00:00 waiter-14
   4564    4580 pts/0    00:00:00 waiter-15
   4564    4581 pts/0    00:00:00 waiter-16
   4564    4582 pts/0    00:00:00 waiter-17
   4564    4583 pts/0    00:00:00 waiter-18
   4564    4584 pts/0    00:00:00 waiter-19
   4564    4585 pts/0    00:00:00 changer-0
   4564    4586 pts/0    00:00:00 changer-1
   4564    4587 pts/0    00:00:00 changer-2
   4564    4588 pts/0    00:00:00 changer-3
   4564    4589 pts/0    00:00:00 changer-4
   4564    4590 pts/0    00:00:00 changer-5
   4564    4591 pts/0    00:00:00 changer-6
   4564    4592 pts/0    00:00:00 changer-7
   4564    4593 pts/0    00:00:00 changer-8
   4564    4594 pts/0    00:00:00 changer-9
   4564    4595 pts/0    00:00:00 changer-10
   4564    4596 pts/0    00:00:00 changer-11
   4564    4597 pts/0    00:00:00 changer-12
   4564    4598 pts/0    00:00:00 changer-13
   4564    4599 pts/0    00:00:00 changer-14
   4564    4600 pts/0    00:00:00 changer-15
   4564    4601 pts/0    00:00:00 changer-16
   4564    4602 pts/0    00:00:00 changer-17
   4564    4603 pts/0    00:00:00 changer-18
   4564    4604 pts/0    00:00:00 changer-19
found race, hang...

$ sudo crash --no_module
.....................
crash> task -R prio,normal_prio,rt_priority,pi_waiters 4564
PID: 4564     TASK: ffff9b7c8480a8c0  CPU: 3    COMMAND: "a.out"
  prio =3D 80,
  normal_prio =3D 120,
  rt_priority =3D 0,
  pi_waiters =3D {
    rb_root =3D {
      rb_node =3D 0xffffb5bad2ddfcf8
    },
    rb_leftmost =3D 0xffffb5bad2da7d98
  },

crash> print (struct rb_node *)0xffffb5bad2ddfcf8
$1 =3D (struct rb_node *) 0xffffb5bad2ddfcf8
crash> print *(struct rt_mutex_waiter *)((void *)$ - 24)
$2 =3D {
  tree_entry =3D {
    __rb_parent_color =3D 1,
    rb_right =3D 0x0,
    rb_left =3D 0x0
  },
  pi_tree_entry =3D {
    __rb_parent_color =3D 1,
    rb_right =3D 0xffffb5bad2df7d28,
    rb_left =3D 0xffffb5bad2dafd68
  },
  task =3D 0xffff9b7c80388000,
  lock =3D 0xffff9b7caa2cceb0,
  wake_state =3D 3,
  prio =3D 89,
  deadline =3D 0,
  ww_ctx =3D 0x0
}
crash> print $1->rb_left
$3 =3D (struct rb_node *) 0xffffb5bad2dafd68
crash> print *(struct rt_mutex_waiter *)((void *)$ - 24)
$4 =3D {
  tree_entry =3D {
    __rb_parent_color =3D 1,
    rb_right =3D 0x0,
    rb_left =3D 0x0
  },
  pi_tree_entry =3D {
    __rb_parent_color =3D 18446662412739149049,
    rb_right =3D 0xffffb5bad2defdb8,
    rb_left =3D 0xffffb5bad2dbfd30
  },
  task =3D 0xffff9b7d2bca28c0,
  lock =3D 0xffff9b7d004a2970,
  wake_state =3D 3,
  prio =3D 83,
  deadline =3D 0,
  ww_ctx =3D 0x0
}
crash> print $1->rb_left->rb_left
$5 =3D (struct rb_node *) 0xffffb5bad2dbfd30
crash> print *(struct rt_mutex_waiter *)((void *)$ - 24)
$6 =3D {
  tree_entry =3D {
    __rb_parent_color =3D 1,
    rb_right =3D 0x0,
    rb_left =3D 0x0
  },
  pi_tree_entry =3D {
    __rb_parent_color =3D 18446662412738952552,
    rb_right =3D 0xffffb5bad2d87d18,
    rb_left =3D 0xffffb5bad2da7d98
  },
  task =3D 0xffff9b7cfd55a8c0,
  lock =3D 0xffff9b7caa2cc6d0,
  wake_state =3D 3,
  prio =3D 79,
  deadline =3D 0,
  ww_ctx =3D 0x0
}
crash> print $1->rb_left->rb_left->rb_left
$7 =3D (struct rb_node *) 0xffffb5bad2da7d98
crash> print *(struct rt_mutex_waiter *)((void *)$ - 24)
$8 =3D {
  tree_entry =3D {
    __rb_parent_color =3D 1,
    rb_right =3D 0x0,
    rb_left =3D 0x0
  },
  pi_tree_entry =3D {
    __rb_parent_color =3D 18446662412739018033,
    rb_right =3D 0x0,
    rb_left =3D 0x0
  },
  task =3D 0xffff9b7c80bd0000,
  lock =3D 0xffff9b7caa2ccb50,
  wake_state =3D 3,
  prio =3D 80,
  deadline =3D 0,
  ww_ctx =3D 0x0
}
crash>

Key order invariant of pi_waiters had been violated by the last two
waiters above.

Thanks.

Henry

--000000000000a2507905ffdc1e8b
Content-Type: text/x-c-code; charset="US-ASCII"; name="pi_642.c"
Content-Disposition: attachment; filename="pi_642.c"
Content-Transfer-Encoding: base64
Content-ID: <f_ljrxlur40>
X-Attachment-Id: f_ljrxlur40

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGFzc2VydC5oPgojaW5jbHVkZSA8c3RkaW8u
aD4KI2luY2x1ZGUgPHB0aHJlYWQuaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3Rk
aW50Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxl
cnJuby5oPgojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KCiNkZWZpbmUgUENPVU5UIDIwCiNkZWZp
bmUgRVhQRUNURURfUFJJTyAtMjEKCi8vIENvcGllZCBmcm9tIHJlbGF0ZWQgaGVhZGVyLgpzdHJ1
Y3Qgc2NoZWRfYXR0ciB7Cgl1aW50MzJfdCBzaXplOwoKCXVpbnQzMl90IHNjaGVkX3BvbGljeTsK
CXVpbnQ2NF90IHNjaGVkX2ZsYWdzOwoKCS8qIFNDSEVEX05PUk1BTCwgU0NIRURfQkFUQ0ggKi8K
CWludDMyX3Qgc2NoZWRfbmljZTsKCgkvKiBTQ0hFRF9GSUZPLCBTQ0hFRF9SUiAqLwoJdWludDMy
X3Qgc2NoZWRfcHJpb3JpdHk7CgoJLyogU0NIRURfREVBRExJTkUgKi8KCXVpbnQ2NF90IHNjaGVk
X3J1bnRpbWU7Cgl1aW50NjRfdCBzY2hlZF9kZWFkbGluZTsKCXVpbnQ2NF90IHNjaGVkX3Blcmlv
ZDsKCgkvKiBVdGlsaXphdGlvbiBoaW50cyAqLwoJdWludDMyX3Qgc2NoZWRfdXRpbF9taW47Cgl1
aW50MzJfdCBzY2hlZF91dGlsX21heDsKfTsKCnN0YXRpYyBwdGhyZWFkX211dGV4X3QgbXV0ZXhl
c1tQQ09VTlRdOwoKc3RhdGljIHZvaWQgaW5pdF9tdXRleChwdGhyZWFkX211dGV4X3QgKm11dGV4
KSB7CglwdGhyZWFkX211dGV4YXR0cl90IGF0dHI7CglpbnQgcmV0OwoKCXJldCA9IHB0aHJlYWRf
bXV0ZXhhdHRyX2luaXQoJmF0dHIpOwoJYXNzZXJ0KCFyZXQpOwoJcmV0ID0gcHRocmVhZF9tdXRl
eGF0dHJfc2V0cHJvdG9jb2woJmF0dHIsIFBUSFJFQURfUFJJT19JTkhFUklUKTsKCWFzc2VydCgh
cmV0KTsKCglyZXQgPSBwdGhyZWFkX211dGV4X2luaXQobXV0ZXgsICZhdHRyKTsKCWFzc2VydCgh
cmV0KTsKCglwdGhyZWFkX211dGV4YXR0cl9kZXN0cm95KCZhdHRyKTsKfQoKZW51bSB0aHJlYWRf
dHlwZSB7CglXQUlURVIsCglQUklPX0NIQU5HRVIsCn07CgpzdGF0aWMgc3RydWN0IHRocmVhZF9z
cGVjIHsKCWVudW0gdGhyZWFkX3R5cGUgdHlwZTsKCWludCBuYW1lX2luZGV4OwoJcHRocmVhZF9i
YXJyaWVyX3QgKmJhcnJpZXI7CgoJLy8gVXNlZCBieSB3YWl0ZXIuCglwdGhyZWFkX211dGV4X3Qg
KndhaXRfbXV0ZXg7CglwaWRfdCBwaWRfc2F2ZTsKCQoJLy8gVXNlZCBieSBwcmlvIGNoYW5nZXIu
CglwaWRfdCAqd2FpdGVyX3BpZDsKCXVpbnQzMl90IHByaW87Cn0gdGhyZWFkX3NwZWNzW1BDT1VO
VCAqIDJdOwoKc3RhdGljIHB0aHJlYWRfdCB0aHJlYWRzW1BDT1VOVCAqIDJdOwpzdGF0aWMgaW50
IHRocmVhZF9jb3VudCA9IDA7CgpzdGF0aWMgaW50IGJhcnJpZXJfd2FpdChwdGhyZWFkX2JhcnJp
ZXJfdCAqYmFycmllcikgewoJaWYgKCFiYXJyaWVyKSB7CgkJcmV0dXJuIDA7Cgl9CgoJaW50IHJl
dCA9IHB0aHJlYWRfYmFycmllcl93YWl0KGJhcnJpZXIpOwoJYXNzZXJ0KCFyZXQgfHwgcmV0ID09
IFBUSFJFQURfQkFSUklFUl9TRVJJQUxfVEhSRUFEKTsKCglyZXR1cm4gcmV0Owp9CgpzdGF0aWMg
aW50IHNjaGVkX2dldGF0dHIocGlkX3QgcGlkLCBzdHJ1Y3Qgc2NoZWRfYXR0ciAqYXR0ciwgaW50
IGZsYWdzKSB7CglyZXR1cm4gc3lzY2FsbChTWVNfc2NoZWRfZ2V0YXR0ciwgcGlkLCBhdHRyLCBz
aXplb2YoKmF0dHIpLCBmbGFncyk7Cn0KCnN0YXRpYyBpbnQgc2NoZWRfc2V0YXR0cihwaWRfdCBw
aWQsIHN0cnVjdCBzY2hlZF9hdHRyICphdHRyLCBpbnQgZmxhZ3MpIHsKCXJldHVybiBzeXNjYWxs
KFNZU19zY2hlZF9zZXRhdHRyLCBwaWQsIGF0dHIsIGZsYWdzKTsKfQoKc3RhdGljIHZvaWQgKnBy
aW9fY2hhbmdlX2xvb3Aoc3RydWN0IHRocmVhZF9zcGVjICpzcGVjKSB7CglzdHJ1Y3Qgc2NoZWRf
YXR0ciBhdHRyOwoJaW50IHJldDsKCglmb3IgKDs7KSB7CgkJYmFycmllcl93YWl0KHNwZWMtPmJh
cnJpZXIpOwoKCQlyZXQgPSBzY2hlZF9nZXRhdHRyKCpzcGVjLT53YWl0ZXJfcGlkLCAmYXR0ciwg
MCk7CgkJaWYgKHJldCA8IDApIHsKCQkJcGVycm9yKCJzY2hlZF9nZXRhdHRyIik7CgkJCWFzc2Vy
dCgwKTsKCQl9CgkJCgkJYXR0ci5zY2hlZF9wb2xpY3kgPSBTQ0hFRF9SUjsKCQlhdHRyLnNjaGVk
X3ByaW9yaXR5ID0gc3BlYy0+cHJpbzsKCQoJCXJldCA9IHNjaGVkX3NldGF0dHIoKnNwZWMtPndh
aXRlcl9waWQsICZhdHRyLCAwKTsKCQlpZiAocmV0IDwgMCkgewoJCQlwZXJyb3IoInNjaGVkX3Nl
dGF0dHIiKTsKCQkJZXhpdCgxKTsKCQl9CgoJCWJhcnJpZXJfd2FpdChzcGVjLT5iYXJyaWVyKTsK
CX0KfQoKc3RhdGljIHZvaWQgKnRocmVhZCh2b2lkICphcmcpIHsKCXN0cnVjdCB0aHJlYWRfc3Bl
YyAqc3BlYyA9IGFyZzsKCWNoYXIgbmFtZVs2NF07CglpbnQgcmV0OwoJCglzbnByaW50ZihuYW1l
LCBzaXplb2YobmFtZSksICIlcy0lZCIsIAoJCQlzcGVjLT50eXBlID09IFdBSVRFUiA/ICJ3YWl0
ZXIiIDogImNoYW5nZXIiLCAKCQkJc3BlYy0+bmFtZV9pbmRleCk7CglyZXQgPSBwdGhyZWFkX3Nl
dG5hbWVfbnAocHRocmVhZF9zZWxmKCksIG5hbWUpOwoJYXNzZXJ0KCFyZXQpOwoKCXN3aXRjaCAo
c3BlYy0+dHlwZSkgewoJY2FzZSBXQUlURVI6CgkJc3BlYy0+cGlkX3NhdmUgPSBnZXR0aWQoKTsK
CgkJYmFycmllcl93YWl0KHNwZWMtPmJhcnJpZXIpOwoKCQlyZXQgPSBwdGhyZWFkX211dGV4X2xv
Y2soc3BlYy0+d2FpdF9tdXRleCk7CgkJYXNzZXJ0KCFyZXQpOwoJCWJyZWFrOwoJY2FzZSBQUklP
X0NIQU5HRVI6CgkJcHJpb19jaGFuZ2VfbG9vcChzcGVjKTsKCQlicmVhazsKCWRlZmF1bHQ6CgkJ
YXNzZXJ0KDApOwoJCWJyZWFrOwoJfQoKCXJldHVybiBOVUxMOwp9CgpzdGF0aWMgdm9pZCBjcmVh
dGVfdGhyZWFkKHN0cnVjdCB0aHJlYWRfc3BlYyAqc3BlYykgewoJaW50IHJldDsKCglyZXQgPSBw
dGhyZWFkX2NyZWF0ZSgmdGhyZWFkc1t0aHJlYWRfY291bnQrK10sIE5VTEwsIHRocmVhZCwgc3Bl
Yyk7Cglhc3NlcnQoIXJldCk7Cn0KCnN0YXRpYyBpbnQgcHJpbnRfcHJpbygpIHsKCUZJTEUgKmZp
bGUgPSBmb3BlbigiL3Byb2Mvc2VsZi9zdGF0IiwgInIiKTsKCWFzc2VydChmaWxlKTsKCgljaGFy
IGNvbW1bNjRdOwoJaW50IHRtcCwgcHJpbywgcmV0OwoJcmV0ID0gZnNjYW5mKGZpbGUsICIlZCAl
cyAlYyAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCIsCgkJCSZ0
bXAsIGNvbW0sIGNvbW0sICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsCgkJCSZ0
bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZwcmlvKTsKCWFz
c2VydChyZXQgPT0gMTgpOwoKCXByaW50ZigicHJpbzogJWRcbiIsIHByaW8pOwoKCWZjbG9zZShm
aWxlKTsKCglyZXR1cm4gcHJpbzsKfQoKc3RhdGljIHZvaWQgcHJpbnRfdGhyZWFkcyhwaWRfdCBw
cm9jZXNzX3BpZCkgewoJY2hhciBjbWRbMTI4XTsKCXNucHJpbnRmKGNtZCwgc2l6ZW9mKGNtZCks
ICJwcyAtTCAtcCAlZCIsIHByb2Nlc3NfcGlkKTsKCXN5c3RlbShjbWQpOwp9CgppbnQgbWFpbih2
b2lkKSB7CglwaWRfdCBwaWQ7CglpbnQgcmV0OwoKCXBpZCA9IGdldHBpZCgpOwoJcHJpbnRmKCJw
aWQ6ICVkXG4iLCBwaWQpOwoKCWZvciAoaW50IGkgPSAwOyBpIDwgc2l6ZW9mKG11dGV4ZXMpIC8g
c2l6ZW9mKG11dGV4ZXNbMF0pOyArK2kpIHsKCQlpbml0X211dGV4KCZtdXRleGVzW2ldKTsKCQly
ZXQgPSBwdGhyZWFkX211dGV4X2xvY2soJm11dGV4ZXNbaV0pOwoJCWFzc2VydCghcmV0KTsKCX0K
CglwdGhyZWFkX2JhcnJpZXJfdCBiYXJyaWVyOwoJcmV0ID0gcHRocmVhZF9iYXJyaWVyX2luaXQo
JmJhcnJpZXIsIE5VTEwsIFBDT1VOVCArIDEpOwoJYXNzZXJ0KCFyZXQpOwoKCWZvciAoaW50IGkg
PSAwOyBpIDwgUENPVU5UOyArK2kpIHsKCQlzdHJ1Y3QgdGhyZWFkX3NwZWMgKnNwZWMgPSAmdGhy
ZWFkX3NwZWNzW2ldOwoJCQoJCXNwZWMtPnR5cGUgPSBXQUlURVI7CgkJc3BlYy0+bmFtZV9pbmRl
eCA9IGk7CgkJc3BlYy0+d2FpdF9tdXRleCA9ICZtdXRleGVzW2ldOwoJCXNwZWMtPmJhcnJpZXIg
PSAmYmFycmllcjsKCgkJY3JlYXRlX3RocmVhZChzcGVjKTsKCX0KCgkvLyBXYWl0IGZvciBmaWxs
aW5nIG9mIHBpZF9zYXZlLgoJYmFycmllcl93YWl0KCZiYXJyaWVyKTsKCglmb3IgKGludCBpID0g
MDsgaSA8IFBDT1VOVDsgKytpKSB7CgkJc3RydWN0IHRocmVhZF9zcGVjICpzcGVjID0gJnRocmVh
ZF9zcGVjc1tpICsgUENPVU5UXTsKCgkJc3BlYy0+dHlwZSA9IFBSSU9fQ0hBTkdFUjsgCgkJc3Bl
Yy0+bmFtZV9pbmRleCA9IGk7CgkJc3BlYy0+cHJpbyA9IDk5OwoJCXNwZWMtPmJhcnJpZXIgPSAm
YmFycmllcjsKCQlzcGVjLT53YWl0ZXJfcGlkID0gJnRocmVhZF9zcGVjc1tpXS5waWRfc2F2ZTsK
CgkJY3JlYXRlX3RocmVhZChzcGVjKTsKCX0KCglwcmludF9wcmlvKCk7CglwcmludF90aHJlYWRz
KHBpZCk7CgoJc3JhbmRvbSh0aW1lKE5VTEwpKTsKCWludCBpdGVyID0gMDsKCWZvciAoOzspIHsK
CQkrK2l0ZXI7CgkJZm9yIChpbnQgaSA9IDA7IGkgPCBQQ09VTlQ7ICsraSkgewoJCQl0aHJlYWRf
c3BlY3NbaSArIFBDT1VOVF0ucHJpbyA9IChpdGVyICUgMikgPyBpICsgMSA6IFBDT1VOVCAtIGk7
CgkJfQoKCQlmb3IgKGludCBpID0gMDsgaSA8IFBDT1VOVDsgKytpKSB7CgkJCWludCBwb3MgPSBy
YW5kb20oKSAlIFBDT1VOVDsKCQkJaW50IHRtcCA9IHRocmVhZF9zcGVjc1twb3MgKyBQQ09VTlRd
LnByaW87CgkJCXRocmVhZF9zcGVjc1twb3MgKyBQQ09VTlRdLnByaW8gPSB0aHJlYWRfc3BlY3Nb
UENPVU5UXS5wcmlvOwoJCQl0aHJlYWRfc3BlY3NbUENPVU5UXS5wcmlvID0gdG1wOwoJCX0KCgkJ
YmFycmllcl93YWl0KCZiYXJyaWVyKTsKCQliYXJyaWVyX3dhaXQoJmJhcnJpZXIpOwoKCQkvL3N5
c3RlbSgiZWNobyBpdGVyYXRpb24gPiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL3RyYWNlX21h
cmtlciIpOwoKCQlmb3IgKGludCB0cnkgPSAwOyA7ICsrdHJ5KSB7CgkJCWludCBwcmlvID0gcHJp
bnRfcHJpbygpOwoJCQlpZiAocHJpbyA9PSBFWFBFQ1RFRF9QUklPKSB7CgkJCQkvLyBUcnkgYSBu
ZXcgaXRlcmF0aW9uLgoJCQkJYnJlYWs7CgkJCX0KCgkJCWlmICh0cnkgPj0gMTApIHsKCQkJCXBy
aW50X3RocmVhZHMocGlkKTsKCQkJCXByaW50ZigiZm91bmQgcmFjZSwgaGFuZy4uLlxuIik7CgkJ
CQl3aGlsZSAoMSkgewoJCQkJCXNsZWVwKDM2MDApOwoJCQkJfQoJCQl9CgkJfQoJfQoKCWZvciAo
aW50IGkgPSAwOyBpIDwgdGhyZWFkX2NvdW50OyArK2kpIHsKCQlwdGhyZWFkX2pvaW4odGhyZWFk
c1tpXSwgTlVMTCk7Cgl9CgoJcmV0dXJuIDA7Cn0KCg==
--000000000000a2507905ffdc1e8b--
