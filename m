Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD96B129C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCHUEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCHUEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:04:36 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55A7301E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:04:35 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id n18so15799642ybm.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678305874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgiAiljnut4x4KojkZEYCBr9lUbzxmiy/Wpveu0hTeU=;
        b=q39LOavP0PxjMVkc7KSrE1R3B/rGZc61GxiGlhUUyKrPaRjqE3M0EfGqGy9nx7txmM
         fAP/MbFEIeUXpvV1dkxIRwwOmArrn/QQGDC5yradFVvWXeNcms1/EJb5U+JN+Eqz02iz
         fcm/h6pvAsYIQ9l6eK/bE3vFCzQW9ugAWkloc535AW2+BFfVfDSuKfSINWN/drF56eb3
         Cz+IzigTAvVVSQKVuUtMzAVAzd8AYHL8O5iZaiseAdA7Qz577JruKtT+Y8OaAUvHmDN+
         lQTgQb2SntiiMSvhxmh3RWiMadSiyD1NjTxDm+hAU9etlHudH85HKnuvSzdlrBNUS2Dy
         6GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678305874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgiAiljnut4x4KojkZEYCBr9lUbzxmiy/Wpveu0hTeU=;
        b=wbWOZ2wh0APCVuE+rS/PjderFl7NvAtEtesimoOMS0GdOfME3Pzk9lnfQwW7kl/0OC
         vlejaTMMy6Bu0Z2dqaFl+5s0mBr+Qz8C9GjVH9VQ5uh8/HdfIhd1pACF9Fu2EE1jUvU3
         lvN1SSwr3RswXGzcvYjp+oA6QjGzJS3Jtou/VQ9OrcT78/0ZhzaOOQUoB/wuholD5l4c
         DWN3faGwPjkEZuNWXu5kSwOLL8JRz88NZ8AEHzhwUk8qVWTGZxCKQHJhxVJzuuFmJFzA
         XgeU3Xok7FjIFNMAHYNQ7L8tV5Tel2KHWuRg3n+4O0hEa+BpljFEATBm/mFogXVkszfT
         saHQ==
X-Gm-Message-State: AO0yUKV0xCP8V5pDw85T3kdRk0Uj5kErVLQM3WCGGyoSJUB7E7x5gYq4
        yE4jkwUywGlrwWlVNLiCJiVLiiRqIaUP8RpRGGKI
X-Google-Smtp-Source: AK7set+iOgd86MWzFDasyceCVC09JR/h4TmOPifJeXgAKy2mmskx7mOOIURVDn/9N1onw6AVXM5h+m4AMaRlv4/TEhg=
X-Received: by 2002:a25:8c0c:0:b0:b27:4632:f651 with SMTP id
 k12-20020a258c0c000000b00b274632f651mr22268ybl.3.1678305874604; Wed, 08 Mar
 2023 12:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20230302062741.483079-1-jstultz@google.com> <20230302082414.77613351@gandalf.local.home>
 <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
 <20230302152103.2618f1b7@gandalf.local.home> <20230302163253.541ac3a8@gandalf.local.home>
 <20230302163603.223313ba@gandalf.local.home> <20230302165613.2dcc18ca@gandalf.local.home>
 <20230302200136.381468f0@gandalf.local.home> <20230307203122.14b077c4@gandalf.local.home>
In-Reply-To: <20230307203122.14b077c4@gandalf.local.home>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 8 Mar 2023 12:04:23 -0800
Message-ID: <CANDhNCpw+M_bwLpxb-vdL__xZrQsAVCMBozVt3+v4ncUVKbfAA@mail.gmail.com>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 5:31=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu, 2 Mar 2023 20:01:36 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > @@ -1421,11 +1425,23 @@ static bool rtmutex_spin_on_owner(struct rt_mut=
ex_base *lock,
> >                *    for CONFIG_PREEMPT_RCU=3Dy)
> >                *  - the VCPU on which owner runs is preempted
> >                */
> > -             if (!owner_on_cpu(owner) || need_resched() ||
> > -                 !rt_mutex_waiter_is_top_waiter(lock, waiter)) {
> > +             if (!owner_on_cpu(owner) || need_resched()) {
> >                       res =3D false;
> >                       break;
> >               }
> > +             top_waiter =3D rt_mutex_top_waiter(lock);
>
> rt_mutex_top_waiter() can not be called outside the wait_lock, as it may
> trigger that BUG_ON() you saw.
>
> New patch below.

Hey Steven!
  Thanks for the new version! It avoids the crash issue. However, with
my sef-created reproducer, I was still seeing similar regression going
between mutex to rtmutex.

I'm interested in continuing to see if we can further tweak it, but
I've got some other work I need to focus on, so I think I'm going to
advocate for the revert in the short-term and look at finer grained
locking (along with rtmutex to address the priority inversion issue)
in the longer term.

thanks
-john
