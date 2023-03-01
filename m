Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33466A6ACA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCAK3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCAK3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:29:01 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A53C27D7A;
        Wed,  1 Mar 2023 02:29:00 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-53916ab0c6bso353598547b3.7;
        Wed, 01 Mar 2023 02:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677666539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7UebrkxxmHx/u88bQ5EqokPCa/rVdSrNnC25LufLff4=;
        b=b1WBXPg1GQ7n96pudQsjiVrg5BbuBIT6nRkkwClefz3DUF3BB5QZAq2tPlNoFvRtOO
         AmPiwWfTgKU0G+ZSqyWi1ZZdX0GEkVEkzCDRqeQn0DA+eQbjtiPjRWDNSfNx/ggsJNtS
         3k9mTua1ppsQ2n9Gn4KxYRQNuP3p9fvStLJvVrr4X8f5/oYkcifKrxiM894IaI13ZzJQ
         nHRtmz425wJFQgHHtEasug/FL1k+gzW7aGPk+xlR1Xn880hsH4QP+L9D3PrUX2goEvaa
         NE2wQGgfoseyinGnOYO8d+llCFFZEmRKeD7tNqK+GVUqgDUaxMSxP5Q7mpfM7amguRvd
         fXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677666539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UebrkxxmHx/u88bQ5EqokPCa/rVdSrNnC25LufLff4=;
        b=C8WyEmkF1GmR4Lu4xaOdmeoAb3MWPH4HMEjph088we4iA/pQpl4LOnB9fvxwUqxPaD
         QvVIZQcTynajNQ2cCz+IT/fwcXnwOhZgQ6kY0O+gwPE6KHZI5rMLnHULKAiTvabhRM74
         GCIivVeaPPqApr5jBllt4K5SSltW2nzG6WUe2nxcdAtSu3r9zfate2YGQuDnv5a2HasF
         rPSwAv+obgzx5iqR2qgy5gWSvBAnIJqhlnBPggzex5C2qE1jkTZpAQxkHPN3evsEVEps
         fnamYFt0nmUp16flSn+hoTPeg1WkrpeOLfP+bogdEO5Qj3010VguEiIzlOukFBXtgqGq
         bXMQ==
X-Gm-Message-State: AO0yUKUf5bujDNLziIruoJpBS0BqqDFKARQ8zm6d14PTtKaJ5ag5692G
        SiT/X2nz/OPfrTsOHuifG3HS+M7Wm/YGywOVXEc=
X-Google-Smtp-Source: AK7set8Z6Ji4KSOIjrUgMJtiz1Fv8iTNxAwdk9MEv6YH1kohVcONqb0vUudy+LB5L3++ke9goFs8rVmnLPYGm/kKNlI=
X-Received: by 2002:a25:9983:0:b0:9f2:a18c:90ed with SMTP id
 p3-20020a259983000000b009f2a18c90edmr2547621ybo.10.1677666539115; Wed, 01 Mar
 2023 02:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20230228155121.3416-1-ubizjak@gmail.com> <Y/5mguXPPqdP3MZF@google.com>
 <20230228160324.2a7c1012@gandalf.local.home> <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230228164124.77c126d2@gandalf.local.home> <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
 <20230228190846.79b06089@gandalf.local.home>
In-Reply-To: <20230228190846.79b06089@gandalf.local.home>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 11:28:47 +0100
Message-ID: <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 1:08 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 28 Feb 2023 18:30:14 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > But looking at this use case, I'd actually NAK it, as it is misleading.
> >
> > I'm trying to parse this. You are saying it is misleading, because it
> > updates js when it doesn't need to?
>
> Correct.

I'm a bit late to the discussion (well, I have to sleep from time to
time, too), but in the hope that everybody interested in this issue
will find the reply, I'll try to clarify the "updates" claim:

The try_cmpxchg is written in such a way that benefits loops as well
as linear code, in the latter case it depends on the compiler to
eliminate the dead assignment.

When changing linear code from cmpxchg to try_cmpxchg, one has to take
care that the variable, passed by reference, is unused after cmpxchg,
so it can be considered as a temporary variable (as said elsewhere,
the alternative is to copy the value to a local temporary variable and
pass the pointer to this variable to try_cmpxchg - the compiler will
eliminate the assignment if the original variable is unused).

Even in linear code, the conversion from cmpxchg to try_cmpxchg is
able to eliminate assignment and compare, as can be seen when the code
is compiled with gcc-10.3.1:

    a1c5:    0f 84 53 03 00 00        je     a51e <rcu_sched_clock_irq+0x70e>
    a1cb:    48 89 c8                 mov    %rcx,%rax
    a1ce:    f0 48 0f b1 35 00 00     lock cmpxchg %rsi,0x0(%rip)
  # a1d7 <rcu_sched_clock_irq+0x3c7>
    a1d5:    00 00
            a1d3: R_X86_64_PC32    .data+0xf9c
    a1d7:    48 39 c1                 cmp    %rax,%rcx
    a1da:    0f 85 3e 03 00 00        jne    a51e <rcu_sched_clock_irq+0x70e>

to:

    a1d0:    0f 84 49 03 00 00        je     a51f <rcu_sched_clock_irq+0x70f>
    a1d6:    f0 48 0f b1 35 00 00     lock cmpxchg %rsi,0x0(%rip)
  # a1df <rcu_sched_clock_irq+0x3cf>
    a1dd:    00 00
            a1db: R_X86_64_PC32    .data+0xf9c
    a1df:    0f 85 3a 03 00 00        jne    a51f <rcu_sched_clock_irq+0x70f>

Newer compilers (e.g. gcc-12+) are able to use likely/unlikely
annotations to reorder the code, so the change is less visible. But
due to reordering, even targets that don't define try_cmpxchg natively
benefit from the change, please see thread at [1].

These benefits are the reason the change to try_cmpxchg was accepted
also in the linear code elsewhere in the linux kernel, e.g. [2,3] to
name a few commits, with a thumbs-up and a claim that the new code is
actually *clearer* at the merge commit [4].

I really think that the above demonstrates various improvements, and
would be unfortunate not to consider them.

[1] https://lore.kernel.org/lkml/871qwgmqws.fsf@mpe.ellerman.id.au/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4e1da8fe031303599e78f88e0dad9f44272e4f99
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8baceabca656d5ef4494cdeb3b9b9fbb844ac613
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=91bc559d8d3aed488b4b50e9eba1d7ebb1da7bbf

Uros.

> >
> > > As try_cmpxchg() is used to get rid of the updating of the old value. As in
> > > the ring buffer code we had:
> > >
> > > void ring_buffer_record_off(struct trace_buffer *buffer)
> > > {
> > >         unsigned int rd;
> > >         unsigned int new_rd;
> > >
> > >         do {
> > >                 rd = atomic_read(&buffer->record_disabled);
> > >                 new_rd = rd | RB_BUFFER_OFF;
> > >         } while (!atomic_cmpxchg(&buffer->record_disabled, &rd, new_rd) != rd);
> >
> > Hear you actually meant "rd" as the second parameter without the & ?
>
> Yes, I cut and pasted the updated code and incorrectly try to revert it in
> this example :-p
>
> >
> > > }
> > >
> > > and the try_cmpxchg() converted it to:
> > >
> > > void ring_buffer_record_off(struct trace_buffer *buffer)
> > > {
> > >         unsigned int rd;
> > >         unsigned int new_rd;
> > >
> > >         rd = atomic_read(&buffer->record_disabled);
> > >         do {
> > >                 new_rd = rd | RB_BUFFER_OFF;
> > >         } while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
> > > }
> > >
> > > Which got rid of the need to constantly update the rd variable (cmpxchg
> > > will load rax with the value read, so it removes the need for an extra
> > > move).
> >
> > So that's a good thing?
>
> Yes. For looping, try_cmpxchg() is the proper function to use. But in the
> RCU case (and other cases in the ring-buffer patch) there is no loop, and
> no need to modify the "old" variable.
>
> >
> > >
> > > But in your case, we don't need to update js, in which case the
> > > try_cmpxchg() does.
> >
> > Right, it has lesser value here but I'm curious why you feel it also
> > doesn't belong in that ring buffer loop you shared (or did you mean,
> > it does belong there but not in other ftrace code modified by Uros?).
>
> The ring buffer patch had more than one change, where half the updates were
> fine, and half were not.
>
> -- Steve
