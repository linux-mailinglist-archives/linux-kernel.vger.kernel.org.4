Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B5070E217
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbjEWQdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjEWQdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:33:01 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE6A192;
        Tue, 23 May 2023 09:32:55 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6af6b6837acso2284903a34.1;
        Tue, 23 May 2023 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684859574; x=1687451574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPezlvdKhV+coJaauiTgwhI+5Pzq8mi1EoTAVT+O2ts=;
        b=lVNeG+5Eyg9uJXCOL/rNQ6fySKIAPy/y9LvgrHrpZica5FHk0YiiV6ALtlDQHu3fZa
         oq+v+FzZmArma8i5i95WxN5ufCjpW4sEA4SymafCkw1ypAXTac3CSYn1vvHMyheNvWiF
         dv69+QGNWjIsmy/2yytJNuJTJILsXgEH9Q7htfd7E9g7Z63ZNnZSuab0Cr5hpVDbElzK
         i5HMpDhXNFsOk/VLxtAalVvPBW7dafxKTav0bUEKhGgHlg14yEkZaG7b5XP0BP+yMnqW
         E3Qo1RKFDPyzmuYLj9EKsvzg39D7A+kM1dogbMXkgIBGkMMaFaUZImKjC0lwclrktiJj
         lDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684859574; x=1687451574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPezlvdKhV+coJaauiTgwhI+5Pzq8mi1EoTAVT+O2ts=;
        b=C2LBbtPIYr78v1UAmTNsXKWuzmG0K8Sz75RgsKDvz8ui2tMw1fv3CJegh8UAJVHpNi
         vAupZMFpOX+tgUWrKPQgzHh8mttnbezAHm+sOx5GExdyRr7JxP1RKTpB8/2fenC9Bigo
         malqoMRY04NKh9inhMAFIUqFHiWTOCp808UC1bzjBqESMz/JSRk0eVPc9si7l5ZioZOn
         Sseynz8i9WZxIEJBxduXzLJfiNmQcspBLVX6CgT+meYVNl98uoE2vJujx/Xjzt0KBi/F
         RAdbf5f11z4bdXZCQTXf3/DV3dU8sPntz9YT9uKUuW5qfhVO2Xm9i3j0vv27sjbs/i0/
         0cmA==
X-Gm-Message-State: AC+VfDzM1TMC3uHbFDwoIJ1HThIRXBnB/cZWtnHFf7KN/j4tivDvrzWL
        UBMNsbF8bgYIW5ssPpTniEiJXp/pEKY2RPHGMQg=
X-Google-Smtp-Source: ACHHUZ7agrWpvbSwDULewkv3+90ipL/mriVjj2Uo2kBIiVTM37EaF7RgSxdtRpG+ZXoGAvRSFmZrjP9k79UbMEZ7nXU=
X-Received: by 2002:a54:4003:0:b0:398:349:aa8d with SMTP id
 x3-20020a544003000000b003980349aa8dmr4578796oie.28.1684859574251; Tue, 23 May
 2023 09:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
 <20230517152654.7193-2-mathieu.desnoyers@efficios.com> <CAFUsyfJ49mE+7p1ywEHetRHqr=DWY7aiFYzfva9Mtqp3_XYncg@mail.gmail.com>
 <cdac8821-a298-aced-8084-8da3ba64a1be@efficios.com>
In-Reply-To: <cdac8821-a298-aced-8084-8da3ba64a1be@efficios.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Tue, 23 May 2023 11:32:40 -0500
Message-ID: <CAFUsyf+L6JF=pZ6QstQhdGGPVM7e7ML2a5LEbzmP6sTs3cwJng@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] rseq: Add sched_state field to struct rseq
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 7:49=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2023-05-19 16:51, Noah Goldstein wrote:
> > On Wed, May 17, 2023 at 10:28=E2=80=AFAM Mathieu Desnoyers via Libc-alp=
ha
> > <libc-alpha@sourceware.org> wrote:
> >>
> >> Expose the "on-cpu" state for each thread through struct rseq to allow
> >> adaptative mutexes to decide more accurately between busy-waiting and
> >> calling sys_futex() to release the CPU, based on the on-cpu state of t=
he
> >> mutex owner.
> >>
> >> It is only provided as an optimization hint, because there is no
> >> guarantee that the page containing this field is in the page cache, an=
d
> >> therefore the scheduler may very well fail to clear the on-cpu state o=
n
> >> preemption. This is expected to be rare though, and is resolved as soo=
n
> >> as the task returns to user-space.
> >>
> >> The goal is to improve use-cases where the duration of the critical
> >> sections for a given lock follows a multi-modal distribution, preventi=
ng
> >> statistical guesses from doing a good job at choosing between busy-wai=
t
> >> and futex wait behavior.
> >>
> >> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> >> Cc: Carlos O'Donell <carlos@redhat.com>
> >> Cc: Florian Weimer <fweimer@redhat.com>
> >> Cc: libc-alpha@sourceware.org
> >> ---
> >>   include/linux/sched.h     | 12 ++++++++++++
> >>   include/uapi/linux/rseq.h | 17 +++++++++++++++++
> >>   kernel/rseq.c             | 14 ++++++++++++++
> >>   3 files changed, 43 insertions(+)
> >>
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index eed5d65b8d1f..c7e9248134c1 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -2351,11 +2351,20 @@ static inline void rseq_signal_deliver(struct =
ksignal *ksig,
> >>          rseq_handle_notify_resume(ksig, regs);
> >>   }
> >>
> >> +void __rseq_set_sched_state(struct task_struct *t, unsigned int state=
);
> >> +
> >> +static inline void rseq_set_sched_state(struct task_struct *t, unsign=
ed int state)
> >> +{
> >> +       if (t->rseq)
> >> +               __rseq_set_sched_state(t, state);
> >> +}
> >> +
> >>   /* rseq_preempt() requires preemption to be disabled. */
> >>   static inline void rseq_preempt(struct task_struct *t)
> >>   {
> >>          __set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
> >>          rseq_set_notify_resume(t);
> >> +       rseq_set_sched_state(t, 0);
> >
> > Should rseq_migrate also be made to update the cpu_id of the new core?
> > I imagine the usage of this will be something along the lines of:
> >
> > if(!on_cpu(mutex->owner_rseq_struct) &&
> >     cpu(mutex->owner_rseq_struct) =3D=3D this_threads_cpu)
> >     // goto futex
> >
> > So I would think updating on migrate would be useful as well.
>
> I don't think we want to act differently based on the cpu on which the
> owner is queued.
>
> If the mutex owner is not on-cpu, and queued on the same cpu as the
> current thread, we indeed want to call sys_futex WAIT.
>
> If the mutex owner is not on-cpu, but queued on a different cpu than the
> current thread, we *still* want to call sys_futex WAIT, because
> busy-waiting for a thread which is queued but not currently running is
> wasteful.
>
I think this is less clear. In some cases sure but not always. Going
to the futex
has more latency that userland waits, and if the system is not busy (other =
than
the one process) most likely less latency that yield. Also going to the fut=
ex
requires a syscall on unlock.

For example if the critical section is expected to be very small, it
would be easy
to imagine the lock be better implemented with:
while(is_locked)
  if (owner->on_cpu || owner->cpu !=3D my_cpu)
    exponential backoff
  else
    yield

Its not that "just go to futex" doesn't ever make sense, but I don't
think its fair
to say that *always* the case.

Looking at the kernel code, it doesn't seem to be a particularly high cost =
to
keep the CPU field updated during migration so seems like a why not
kind of question.
> Or am I missing something ?
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
