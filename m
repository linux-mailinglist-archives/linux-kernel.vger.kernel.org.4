Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435B69DAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjBUHKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjBUHKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:10:52 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF1122A2F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:10:51 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s26so13107831edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kgb49vjgU2eT4Pv1XI+e0Oh4ocAtL7C6GhW52Fh4Hk8=;
        b=kgLFzsPsxOr4mC6okfdWGQSZ+MLnmYES4U/clA7dAD4Kv3lDJ4VDzfvgbTqmdLX40F
         li+JSKAU7GHvf00CwLYEyVDyAHFnhQTfvyq9Gf05eo62ydlDW9+cAcvgG6urNndtStr0
         r5zDGgBbqy9qlgcsj4d2LcGOe0DPE7ZAGJNX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kgb49vjgU2eT4Pv1XI+e0Oh4ocAtL7C6GhW52Fh4Hk8=;
        b=MHqZbH6iOaPN1AlaJozH6C048PIbGua/vHKVW1VAOZsqVEEfs4laVT9nUkC33AtWk4
         EcxK2+aTlUlJslxXIzMvMWLr0sPeDwFNMCmup9PQfx/itfidDFDxudlr83pIopXZ0Xae
         bXtdr9M+46rtISEvZlLVxHbjTU+LbnFjSQHG8y7HHrdRn1W6eG6X4U/8tgn+gufYsJR+
         ikhZU3CJc6suie11cj+zVsf3LS6ABwNAOUFIYc4WCkg9lA6zAuc3B5z0oqqRzZ80EEVp
         W0mhaqamEh+56ZUHNpluM9SPpXorgAEzVW8twpuGWJLl3KNdc0aKcUoFP0TfUB256Iz3
         qCZA==
X-Gm-Message-State: AO0yUKUQE+t3Y0aupzzxLKFGbO2E7vxxacuTPmr0NreR7oD2IMykA8F4
        vt0J9srhMi9XT4xcCrphDqLhf1Ena2ag9ZDbYCh37A==
X-Google-Smtp-Source: AK7set+N4IPd4or5RkW+Czctx3mfhAps/tBbtiKsffNIzsNinXZT0OPZ6DlieX1f4hQZixjwisH+gIpGpVls58TxWn4=
X-Received: by 2002:a50:d544:0:b0:4ad:6e3e:7da6 with SMTP id
 f4-20020a50d544000000b004ad6e3e7da6mr1297538edj.6.1676963449702; Mon, 20 Feb
 2023 23:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CAOf5uwmZWZij1tKUFUWKSKqyph4OYe6C3HdA8TQtrB7ztOdC-A@mail.gmail.com>
 <874jrfq3jw.ffs@tglx>
In-Reply-To: <874jrfq3jw.ffs@tglx>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 21 Feb 2023 08:10:38 +0100
Message-ID: <CAOf5uw=+yZiTXGyjDgiw_w9yZZ5Pz3JQpykdCyFfbpNBTz+rXA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Feb 21, 2023 at 1:12 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Michael!
>
> On Mon, Feb 20 2023 at 22:32, Michael Nazzareno Trimarchi wrote:
> > On Mon, Feb 20, 2023 at 10:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>   * alarmtimer_fired - Handles alarm hrtimer being fired.
> >> @@ -194,6 +196,8 @@ static enum hrtimer_restart alarmtimer_f
> >>         int ret = HRTIMER_NORESTART;
> >>         int restart = ALARMTIMER_NORESTART;
> >>
> >> +       atomic_inc(&alarmtimer_wakeup);
> >> +
> >
> >        ptr->it_active = 0;
> >         if (ptr->it_interval) {
> >                 atomic_inc(&alarmtimer_wakeup);
> >                 si_private = ++ptr->it_requeue_pending;
> >         }
> >
> > Should I not go to the alarm_handle_timer? and only if it's a periodic
> > one?
>
> Why?
>

You are right. I will pay more attention to my reply.

Michael

> Any alarmtimer which hits that window has exactly the same problem.
>
> It's not restricted to periodic timers. Why would a dropped one-shot
> wakeup be acceptable?
>
> It's neither restricted to posix timers. If a clock_nanosleep(ALARM)
> expires in that window then the task wake up will just end up in the
> /dev/null bucket for the very same reason. Why would this be correct?
>
> Hmm?
>
> <GRMBL>
> > Michael
> >
> >>         spin_lock_irqsave(&base->lock, flags);
>
> <SNIP>Tons of wasted electrons</SNIP>
>
> Can you please trim your replies?
>
> </GRMBL>
>
> Thanks,
>
>         tglx
