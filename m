Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED996A7DBA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCBJfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCBJfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:35:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC5315C96
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:34:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f13so65030875edz.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr+A7QALuObQhl/296kCgsRiHaK1wrkum1MLhntKxyo=;
        b=UiHyvZirZXIedGi9/bNufX+Tou1J7rYhhJlWQhhTWDTohhI2ThwrW+SEZkzyen29AI
         Oj+CEVPShq141Yi98uffs7TsthlDo8v33QpZBR9XDUR6tZu9ThPf/y2dRH9RXFLvwSov
         rtE7F278qqoKWTv++wq8IiGJkwtiYYKgbEHek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr+A7QALuObQhl/296kCgsRiHaK1wrkum1MLhntKxyo=;
        b=hs0yCv5ofEVFoCN7SWV7y3ITfV8YvyqZWq2slaS2tZ135SeCoXQ2raOvcLgE1xWiEo
         Z9UMUXelPrS/U0SUeJvPL7s/9pvQcKVzRyoktfplf7z4d/6S91eXBZqepxZ8/dLPQmIr
         i3AJ4AY+k6LLRy3vchf+2bqG39KJLj3HBuxqrD2LZl+OYQEZOhCVkIF2qduq32Q89Jf5
         ly3uUd2a4aczOSI5MPYrb0XaxAZcN8g4EkSBJXnxub1JRD1G2/Sb2wQrZdyYT/Nz80SG
         aKDzPeDE3YvEAF0/VTfO1ZSZTlt464q56T6eYLxerlf/7sbT+xTRs7qRK+pxMBdo8LLk
         8NRA==
X-Gm-Message-State: AO0yUKX170LCqXOCSasD7U2GC9HuAmgD8NH0BWGe63XPImodEKQ5mquV
        +b0rrco2yl5CTjeXjnTJWmD9ikLeQvp5NASolDskOA==
X-Google-Smtp-Source: AK7set/1GyQzfSexFtUCuSITWpocLHY1MNxblnu1RJN0oCm9sppUTwZwjo+S4V9kbH+8EtdPNxICpOG7bQWydcGI7ao=
X-Received: by 2002:a50:cc88:0:b0:4ae:e548:1c6 with SMTP id
 q8-20020a50cc88000000b004aee54801c6mr5593279edi.6.1677749697798; Thu, 02 Mar
 2023 01:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CANDhNCrfoiz1WdTs+5B8y+TVv8cn4_J-770=bsPqC9Xe=j14hA@mail.gmail.com>
 <CANDhNCq8_Ly9SOwwxrsRCtATotnxpcmkS+5GCnkFVWOWtXfwKQ@mail.gmail.com>
 <87h6v4ktp5.ffs@tglx> <CANDhNCrFWhOBLFWbm+qFFO4H3+VmEjtNLZAxA57EHMuV7YmUdg@mail.gmail.com>
In-Reply-To: <CANDhNCrFWhOBLFWbm+qFFO4H3+VmEjtNLZAxA57EHMuV7YmUdg@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Thu, 2 Mar 2023 10:34:46 +0100
Message-ID: <CAOf5uwnyNE=o=BE_-+oHGRfNvPEtw5jtTuBj45uOCiKNihFBrQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John

On Thu, Mar 2, 2023 at 1:48=E2=80=AFAM John Stultz <jstultz@google.com> wro=
te:
>
> On Wed, Mar 1, 2023 at 2:11=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> >
> > On Mon, Feb 27 2023 at 20:06, John Stultz wrote:
> > > On Mon, Feb 27, 2023 at 4:03=E2=80=AFPM John Stultz <jstultz@google.c=
om> wrote:
> > >> > On Mon, Feb 20 2023 at 19:11, Michael Nazzareno Trimarchi wrote:
> > >> > +static int alarmtimer_pm_notifier_fn(struct notifier_block *bl, u=
nsigned long state,
> > >> > +                                    void *unused)
> > >> > +{
> > >> > +       switch (state) {
> > >> > +       case PM_HIBERNATION_PREPARE:
> > >> > +       case PM_POST_HIBERNATION:
> > >> > +               atomic_set(&alarmtimer_wakeup, 0);
> > >> > +               break;
> > >> > +       }
> > >> > +       return NOTIFY_DONE;
> > >>
> > >> But here, we're setting the alarmtimer_wakeup count to zero if we ge=
t
> > >> PM_HIBERNATION_PREPARE or  PM_POST_HIBERNATION notifications?
> > >> And Michael noted we need to add  PM_SUSPEND_PREPARE and
> > >> PM_POST_SUSPEND there for this to seemingly work.
> >
> > Yup. I missed those when sending out that hack.
> >
> > > So Thomas's notifier method of zeroing at the begining of suspend and
> > > tracking any wakeups after that point makes more sense now. It still
> > > feels a bit messy, but I'm not sure there's something better.
> >
> > I'm not enthused about it either.
>
> That said, it does work. :) In my testing, your approach has been
> reliable, so it has that going for it.
>
> > > My only thought is this feels a little bit like its mirroring what th=
e
> > > pm_wakeup_event() logic is supposed to do. Should we be adding a
> > > pm_wakeup_event() to alarmtimer_fired() to try to prevent suspend fro=
m
> > > occuring for 500ms or so after an alarmtimer has fired so there is
> > > enough time for it to be re-armed if needed?
> >
> > The question is whether this can be called unconditionally and how that
> > interacts with the suspend logic. Rafael?
>
> I took a brief stab at this, and one thing is the test needs to use
> the /sys/power/wakeup_count dance before suspending.
> However, I still had some cases where the recurring alarmtimer got
> lost, so I need to dig a bit more to understand what was going wrong
> there.
>
> In the meantime, I'm ok with Thomas' approach, but we probably need
> some comment documentation that suggests it might be reworked in a
> cleaner way?
>
> thanks
> -john

For now I have pushed to our internal devices this commit message

time: alarmtimer: Fix wakeup lost between freeze(alarmtask) and
alarmtimer_suspend()

    An alarm timer can happen in between a freeze and alarmtimer_suspend as
    below output:

    > [   89.674127] PM: suspend entry (deep)
    > [   89.714916] Filesystems sync: 0.037 seconds
    > [   89.733594] Freezing user space processes
    > [   89.740680] Freezing user space processes completed (elapsed
0.002 seconds)

    User space tasks are frozen now.

    > [   89.748593] OOM killer disabled.
    > [   89.752257] Freezing remaining freezable tasks
    > [   89.756807] alarmtimer_fired: called
    > [   89.756831] alarmtimer_dequeue: called <---- HERE

    Here fires the underlying hrtimer before devices are suspended, so the
    sig_sendqueue() cannot wake up the task because task->state =3D=3D
    TASK_FROZEN, which means the signal won't be handled and the timer won'=
t
    be rearmed until the task is thawed.

    The alarmtimer_suspend() path won't see a pending timer anymore because
    it is dequeued.

    So precisely the time between freeze(alarmtask) and alarmtimer_suspend(=
)
    is a gaping hole which guarantees lost wakeups.

    That hole has been there forever.

    The old horrible freezer hackery was supposed to plug that
    hole, but that gem is not solving anything as far as I understand what
    it is doing.

Grab a bit from Thomas discussion

Michael
