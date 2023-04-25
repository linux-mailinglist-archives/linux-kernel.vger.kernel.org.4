Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29506EE0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjDYLMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjDYLMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:12:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90F9A9;
        Tue, 25 Apr 2023 04:12:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so5763703a12.2;
        Tue, 25 Apr 2023 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682421156; x=1685013156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqGIa/lrLpJrmoRpxyzaA1Tx9m/kyGx/QdMVB4h890s=;
        b=paR1bePGwkgWwCzvt9zWE/3yIXCNWtmSsT0JXOZCoOkDwFWX5qx/0q1xVz7W8UPZ8/
         NZ3jKCA8TuuawZYRspyQMrpqS6JGEUe96ObvOff8tZCvtv5CTo4d9yymQ7zYRW46nPlO
         cr9qW29XSjWt4y32wKiuST9i/1hv/S20dD7aOy8cSE2bn9KWbXRXH1Z48UGljuFOiq0J
         ZNcAWtZ51M9j7aSIbCRt99aROSoOGOQQtMpTyUz+G+21EfglryeaMgvwD4kpywkZCER0
         Aw2x7m5XQBHI19c4J2jbX63V6kYHho+46BGCvx9G0e1O3NU4WmpadgKAo9oZ4I81WRic
         zoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682421156; x=1685013156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqGIa/lrLpJrmoRpxyzaA1Tx9m/kyGx/QdMVB4h890s=;
        b=b1vMKQIHrpEiiIScWpeTt9ga3JUHB4Smsc0C7y4NUXZJFP73u/Bm4EUwwmouC/+EX+
         YZr1gmH2WfAWtocxNh5YJHq+r5U9lHi39kUPZ6Kb7o1E3d9htiSpqe1H7qGDKlnCF3BD
         4V36uVKT2lxQuuNcJUr4x2kez/uMlmDlePc5SDbwmb+yXq+qPYRf7m5aM6L7nNL11l3E
         5akG+8OpoGwgDbKyqMABdGnx28EcoEBFHe2U4y990i1B00inrr0aSi2yx02h4JyvbnGe
         XSpzd2K/dFHcc2IW92SUGJPoc51QUyVQ7/YHr2IPPr1+XIwAI39ro+d/bcl9t35LjXGb
         RReg==
X-Gm-Message-State: AAQBX9fnvrdzm8KS0Ri+oWwXfKy47L0xdbNdMIfWmaWZGKhX2IYRH2OE
        19+OGrT9WZzPzSUXhlsPLmMnsYKknZVlxObskyE=
X-Google-Smtp-Source: AKy350YaE9BuCCjbRY5bQ9+2YtrPPIBrPUupFyzvYcjpsSPT95PtmSW2xc4vMHs4fq1+TdODtxYKoQH9Yo8mDvNlnQc=
X-Received: by 2002:a17:90a:950e:b0:24b:2ef6:64d5 with SMTP id
 t14-20020a17090a950e00b0024b2ef664d5mr16266352pjo.47.1682421156130; Tue, 25
 Apr 2023 04:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux> <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org> <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
 <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com> <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
In-Reply-To: <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 25 Apr 2023 11:12:25 +0800
Message-ID: <CAABZP2x5UMxuNYEr6ATsbZPywdnHYYMvi7Pyy80aSqpcHk9yTw@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 7:06=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Tue, Apr 25, 2023 at 6:58=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com=
> wrote:
> >
> > hi
> >
> > On Tue, Apr 25, 2023 at 6:13=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Mon, Apr 24, 2023 at 02:55:11PM -0400, Joel Fernandes wrote:
> > > > This is amazing debugging Boqun, like a boss! One comment below:
> > > >
> > > > > > > Or something simple I haven't thought of? :)
> > > > > >
> > > > > > At what points can r13 change?  Only when some particular funct=
ions are
> > > > > > called?
> > > > > >
> > > > >
> > > > > r13 is the local paca:
> > > > >
> > > > >         register struct paca_struct *local_paca asm("r13");
> > > > >
> > > > > , which is a pointer to percpu data.
> > > > >
> > > > > So if a task schedule from one CPU to anotehr CPU, the value gets
> > > > > changed.
> > > >
> > > > It appears the whole issue, per your analysis, is that the stack
> > > > checking code in gcc should not cache or alias r13, and must read i=
ts
> > > > most up-to-date value during stack checking, as its value may have
> > > > changed during a migration to a new CPU.
> > > >
> > > > Did I get that right?
> > > >
> > > > IMO, even without a reproducer, gcc on PPC should just not do that,
> > > > that feels terribly broken for the kernel. I wonder what clang does=
,
> > > > I'll go poke around with compilerexplorer after lunch.
> > > >
> > > > Adding +Peter Zijlstra as well to join the party as I have a feelin=
g
> > > > he'll be interested. ;-)
> > >
> > > I'm a little confused; the way I understand the whole stack protector
> > > thing to work is that we push a canary on the stack at call and on
> > > return check it is still valid. Since in general tasks randomly migra=
te,
> > > the per-cpu validation canary should be the same on all CPUs.
> > >
> > > Additionally, the 'new' __srcu_read_{,un}lock_nmisafe() functions use
> > > raw_cpu_ptr() to get 'a' percpu sdp, preferably that of the local cpu=
,
> > > but no guarantees.
> > >
> > > Both cases use r13 (paca) in a racy manner, and in both cases it shou=
ld
> > > be safe.
> > New test results today: both gcc build from git (git clone
> > git://gcc.gnu.org/git/gcc.git) and Ubuntu 22.04 gcc-12.1.0
> > are immune from the above issue. We can see the assembly code on
> > http://140.211.169.189/0425/srcu_gp_start_if_needed-gcc-12.txt
> >
> > while
> > Both native gcc on PPC vm (gcc version 9.4.0), and gcc cross compiler
> > on my x86 laptop (gcc version 10.4.0) will reproduce the bug.
>
> Do you know what fixes the issue? I would not declare victory yet. My
> feeling is something changes in timing, or compiler codegen which
> hides the issue. So the issue is still there but it is just a matter
> of time before someone else reports it.
I am going to try bisect on GCC, hope we can find some clue.
>
> Out of curiosity for PPC folks, why cannot 64-bit PPC use per-task
> canary? Michael, is this an optimization? Adding Christophe as well
> since it came in a few years ago via the following commit:
>
> commit 06ec27aea9fc84d9c6d879eb64b5bcf28a8a1eb7
> Author: Christophe Leroy <christophe.leroy@c-s.fr>
> Date:   Thu Sep 27 07:05:55 2018 +0000
>
>     powerpc/64: add stack protector support
>
>     On PPC64, as register r13 points to the paca_struct at all time,
>     this patch adds a copy of the canary there, which is copied at
>     task_switch.
>     That new canary is then used by using the following GCC options:
>     -mstack-protector-guard=3Dtls
>     -mstack-protector-guard-reg=3Dr13
>     -mstack-protector-guard-offset=3Doffsetof(struct paca_struct, canary)=
)
>
>     Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
>  - Joel
