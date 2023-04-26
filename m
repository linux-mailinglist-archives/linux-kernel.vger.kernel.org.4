Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1F26EEBED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbjDZBbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjDZBba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:31:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680EFB204;
        Tue, 25 Apr 2023 18:31:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a516fb6523so68934915ad.3;
        Tue, 25 Apr 2023 18:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682472689; x=1685064689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuDRs1vFbkcZXcrnlIT+LLyPD7RmpI8f3r2qlP6us90=;
        b=Uqw3xpD/dCQ3IkNKfVoB5wMSlLRH/t9mDPI35ten1L8hbvArMtg7xofUrahRmXO5gP
         LooOEyIxlLBksoOy1xMfSqbk3yOuft5GNU9Y3Uizuvcd20Hc2EcB4nm9+VchBsbjRLeC
         v6DJ/m3I8PMwc/qdFsAV+7C5SuCDIgPEVCnoElbLI+N9MA9CSSHu+3I5wkiBwnJm0dOh
         M/1a5XwE8qUgpLgxOQEkZmAOf4zVpj/yU7NHXBQ3cK0Lw2zSd489ztjc4I4SjjLBITy0
         hQ00nYx/FLXAkvfw0LC+H/tH2zWwKnVDO7+Pj9XyPUlFblkUg2xRh/cLKLRpVJikd9Fc
         If1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682472689; x=1685064689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuDRs1vFbkcZXcrnlIT+LLyPD7RmpI8f3r2qlP6us90=;
        b=V1xUaNEZlBSsfOt2AuMwT4d/XXVw3UMbwGwEgyaXd+KRj9HEiaOmWBkE1kjUdr7Pz4
         YOp+pOo5Ha+ruaEOGlXSwakxhTS5/2Fy85L7/pNcZQHc0QjTlZTl6Cvq0QNo9FHYHXem
         7ZulsrjYBYqaHwUOyXekITmUiDB70oh2NtI3CU/ouk9l3beOMNB5Qz20mMFYjO0+tXCn
         Dm+hWNvYP1oJBsYZ9eBLlbdlJYeCIyliQWo5MoBU5mqBpXsjJSGEEiFIxb8XypDkMce+
         qLFl4vdGRuOspBjaCD9gUFdA15CH6YXDbUXP1BxJXV9agRxgJd79KAbvvzYhbx+gA4F6
         1oSw==
X-Gm-Message-State: AC+VfDx09ldVi12okqEpWLgjURhJBH3lwrj2BOWJd2lbG769tS++AVS/
        ejsQA3F9tCatgcyIUaBZw1DGWFVWB+XU15+rEC/kbTw2yYJHnOVK
X-Google-Smtp-Source: ACHHUZ4aZysyoWv0dlcEr9PGYE2hplwd9O+ZR4BXCKS5kR5UyxS0nw3pVY7fAp6LcErxcKlkmQgKMJl62OyfBSINKdg=
X-Received: by 2002:a17:902:d2ce:b0:1a9:8ff5:af51 with SMTP id
 n14-20020a170902d2ce00b001a98ff5af51mr4580507plc.60.1682472688688; Tue, 25
 Apr 2023 18:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux> <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org> <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
 <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
 <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
 <528b2adc-9955-5545-9e9d-affd1f935838@csgroup.eu> <CAABZP2zW7aTPChjvZMA1bECdOdFUdTd-q+vEJXJnH2zPU+uR8A@mail.gmail.com>
 <CAEXW_YQJowYrF2A=f2NOKNNjL6qZH6LzghBxt7VnJFgg-i1zgg@mail.gmail.com>
In-Reply-To: <CAEXW_YQJowYrF2A=f2NOKNNjL6qZH6LzghBxt7VnJFgg-i1zgg@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 26 Apr 2023 09:31:17 +0800
Message-ID: <CAABZP2w8eDSRXCoLiWGjGtz6VifPfaaF=Mje7Y8aXjugy-vNkA@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "lance@osuosl.org" <lance@osuosl.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 8:33=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Tue, Apr 25, 2023 at 9:50=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com=
> wrote:
> >
> > Hi
> >
> > On Tue, Apr 25, 2023 at 9:40=E2=80=AFPM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> > >
> > >
> > >
> > > Le 25/04/2023 =C3=A0 13:06, Joel Fernandes a =C3=A9crit :
> > > > On Tue, Apr 25, 2023 at 6:58=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gma=
il.com> wrote:
> > > >>
> > > >> hi
> > > >>
> > > >> On Tue, Apr 25, 2023 at 6:13=E2=80=AFPM Peter Zijlstra <peterz@inf=
radead.org> wrote:
> > > >>>
> > > >>> On Mon, Apr 24, 2023 at 02:55:11PM -0400, Joel Fernandes wrote:
> > > >>>> This is amazing debugging Boqun, like a boss! One comment below:
> > > >>>>
> > > >>>>>>> Or something simple I haven't thought of? :)
> > > >>>>>>
> > > >>>>>> At what points can r13 change?  Only when some particular func=
tions are
> > > >>>>>> called?
> > > >>>>>>
> > > >>>>>
> > > >>>>> r13 is the local paca:
> > > >>>>>
> > > >>>>>          register struct paca_struct *local_paca asm("r13");
> > > >>>>>
> > > >>>>> , which is a pointer to percpu data.
> > > >>>>>
> > > >>>>> So if a task schedule from one CPU to anotehr CPU, the value ge=
ts
> > > >>>>> changed.
> > > >>>>
> > > >>>> It appears the whole issue, per your analysis, is that the stack
> > > >>>> checking code in gcc should not cache or alias r13, and must rea=
d its
> > > >>>> most up-to-date value during stack checking, as its value may ha=
ve
> > > >>>> changed during a migration to a new CPU.
> > > >>>>
> > > >>>> Did I get that right?
> > > >>>>
> > > >>>> IMO, even without a reproducer, gcc on PPC should just not do th=
at,
> > > >>>> that feels terribly broken for the kernel. I wonder what clang d=
oes,
> > > >>>> I'll go poke around with compilerexplorer after lunch.
> > > >>>>
> > > >>>> Adding +Peter Zijlstra as well to join the party as I have a fee=
ling
> > > >>>> he'll be interested. ;-)
> > > >>>
> > > >>> I'm a little confused; the way I understand the whole stack prote=
ctor
> > > >>> thing to work is that we push a canary on the stack at call and o=
n
> > > >>> return check it is still valid. Since in general tasks randomly m=
igrate,
> > > >>> the per-cpu validation canary should be the same on all CPUs.
> > > >>>
> > > >>> Additionally, the 'new' __srcu_read_{,un}lock_nmisafe() functions=
 use
> > > >>> raw_cpu_ptr() to get 'a' percpu sdp, preferably that of the local=
 cpu,
> > > >>> but no guarantees.
> > > >>>
> > > >>> Both cases use r13 (paca) in a racy manner, and in both cases it =
should
> > > >>> be safe.
> > > >> New test results today: both gcc build from git (git clone
> > > >> git://gcc.gnu.org/git/gcc.git) and Ubuntu 22.04 gcc-12.1.0
> > > >> are immune from the above issue. We can see the assembly code on
> > > >> http://140.211.169.189/0425/srcu_gp_start_if_needed-gcc-12.txt
> > > >>
> > > >> while
> > > >> Both native gcc on PPC vm (gcc version 9.4.0), and gcc cross compi=
ler
> > > >> on my x86 laptop (gcc version 10.4.0) will reproduce the bug.
> > > >
> > > > Do you know what fixes the issue? I would not declare victory yet. =
My
> > > > feeling is something changes in timing, or compiler codegen which
> > > > hides the issue. So the issue is still there but it is just a matte=
r
> > > > of time before someone else reports it.
> > > >
> > > > Out of curiosity for PPC folks, why cannot 64-bit PPC use per-task
> > > > canary? Michael, is this an optimization? Adding Christophe as well
> > > > since it came in a few years ago via the following commit:
> > >
> > > It uses per-task canary. But unlike PPC32, PPC64 doesn't have a fixed
> > > register pointing to 'current' at all time so the canary is copied in=
to
> > > a per-cpu struct during _switch().
> > >
> > > If GCC keeps an old value of the per-cpu struct pointer, it then gets
> > > the canary from the wrong CPU struct so from a different task.
> > This is a fruitful learning process for me!
>
> Nice work Zhouyi..
Thank Joel for your encouragement! Your encouragement is very
important to me ;-)
>
> > Christophe:
> > Do you think there is still a need to bisect GCC ? If so, I am very
> > glad to continue
>
> my 2 cents: It would be good to write a reproducer that Segher
> suggested (but that might be hard since you depend on the compiler to
> cache the r13 -- maybe some trial/error with CompilerExplorer will
> give you the magic recipe?).
I have reported to GCC bugzilla once before ;-) [1]
[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D88348
I think we could provide a preprocessed .i file, and give the command
line that invokes cc1,
The problem is the newest GCC is immune to our issue ;-(
>
> If I understand Christophe correctly, the issue requires the following
> ingredients:
> 1. Task A is running on CPU 1, and the task's canary is copied into
> the CPU1's per-cpu area pointed to by r13.
> 2. r13 is now cached into r10 in the offending function due to the compil=
er.
> 3. Task A running on CPU 1 now gets preempted right in the middle of
> the offending SRCU function and gets migrated to CPU 2.
> 4.  CPU 2's per-cpu canary is updated to that of task A since task A
> is the current task now.
> 5. Task B now runs on CPU 1 and the per-cpu canary on CPU 1 is now that o=
f B.
> 6. Task A exits the function, but stack checking code reads r10 which
> contains CPU 1's canary which is that of task B!
> 7. Boom.
Joel makes the learning process easier for me, indeed!
One question I have tried very hard to understand, but still confused.
for now, I know
r13 is fixed, but r1 is not, why "r9,40(r1)"'s 40(r1) can be assumed
to be equal to 3192(r10).
Thanks in advance.
>
> So the issue is precisely in #2.  The issue is in the compiler that it
> does not treat r13 as volatile as Boqun had initially mentioned.
Please do not hesitate to email me if there is anything I can do (for
example bisecting ;-)). I am very glad to be of help ;-)

Cheers
Zhouyi
>
>  - Joel
>
>
>
> >
> > Cheers
> > Zhouyi
> > >
> > > Christophe
> > >
> > > >
> > > > commit 06ec27aea9fc84d9c6d879eb64b5bcf28a8a1eb7
> > > > Author: Christophe Leroy <christophe.leroy@c-s.fr>
> > > > Date:   Thu Sep 27 07:05:55 2018 +0000
> > > >
> > > >      powerpc/64: add stack protector support
> > > >
> > > >      On PPC64, as register r13 points to the paca_struct at all tim=
e,
> > > >      this patch adds a copy of the canary there, which is copied at
> > > >      task_switch.
> > > >      That new canary is then used by using the following GCC option=
s:
> > > >      -mstack-protector-guard=3Dtls
> > > >      -mstack-protector-guard-reg=3Dr13
> > > >      -mstack-protector-guard-offset=3Doffsetof(struct paca_struct, =
canary))
> > > >
> > > >      Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > >      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > >
> > > >   - Joel
