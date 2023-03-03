Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BD06AA018
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjCCT0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCCTZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:25:40 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F1E19F15
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 11:25:37 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id y14so3429278ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677871535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVR9yVzUHZe5uDEMvAYsUw4GqVspvsovyGXRGaq6gkA=;
        b=c4WD1e6Md6Lj/gZYVAXZeQ1UxcFfaiv2xmu3DhnJnvJVssI2BUYlS2W1crznI7nd/U
         ZGu3THdP27Mrt370jUV5Lptm8NjLyGjYjOPKIF+bUYT1Lpduc9aJl+7V7MhkFzyO/+Yl
         YqPXTxIQVm2Etlq3loxL06QMvElqiEpE0F3PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677871535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVR9yVzUHZe5uDEMvAYsUw4GqVspvsovyGXRGaq6gkA=;
        b=3Q6jBtD3Ge4L0fwlW6XIKe2Tw034Bs9XdzAz+jEz5y9bVvFQvKt5f1IR76YsMuWMqy
         vgvTc4zQncMdEi56dnxzJWgox3MW8h4HFFfVlrhU281vqGjOGNf99hhJ8F3LBdwpUnjv
         pNXCcl4qp8w2fhqTxuhgk6K6sE6ZA22BEff1NbQel9JqhXlIV7WLH+TZTptSm6OoJQMt
         WQQB2+u048dm/tgnM70YQzLbIavZntHbovyLIiaC5ZHrLvTX0MJudDRayK34DnwKGaoD
         XWxUD28Xtbq6oA8cJpCIFup5rSKcQqwPzjVu3eps0q8b7xt1UA9gC/srgWHde1YDUbYk
         8hsQ==
X-Gm-Message-State: AO0yUKUiKVrKpCc7wBJGow3D3xEp65koo/7nS0tVbBO+A+qrVAVnb9v0
        JOP9KFYNK2Tr5sSMYU3Tph6A7HVHbs0LO2lYORa92wKZGyKsoMw1
X-Google-Smtp-Source: AK7set/N0+dJKJCvEroCcOt9aGXT72NBzw8QX44bqSZwcMmtcK7njWtCmNBjuhaDUl/qc/AUOM9zL7BL3M1LUN95+L0=
X-Received: by 2002:a2e:b94a:0:b0:293:39fe:b712 with SMTP id
 10-20020a2eb94a000000b0029339feb712mr898776ljs.3.1677871535386; Fri, 03 Mar
 2023 11:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20230302062741.483079-1-jstultz@google.com> <20230302082414.77613351@gandalf.local.home>
 <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
 <20230302152103.2618f1b7@gandalf.local.home> <20230302163253.541ac3a8@gandalf.local.home>
 <20230302163603.223313ba@gandalf.local.home> <20230302165613.2dcc18ca@gandalf.local.home>
 <20230302200136.381468f0@gandalf.local.home> <20230303181134.GA1837196@google.com>
 <20230303133702.4d336ee9@gandalf.local.home>
In-Reply-To: <20230303133702.4d336ee9@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 3 Mar 2023 14:25:23 -0500
Message-ID: <CAEXW_YQN=zPtbd6Nr=F-0GqkHQu+ox3eBnzP30=8MxYGYyFv0Q@mail.gmail.com>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 1:37=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 3 Mar 2023 18:11:34 +0000
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > In the normal mutex's adaptive spinning, there is no check for if there=
 is a
> > change in waiter AFAICS (ignoring ww mutex stuff for a second).
> >
> > I can see one may want to do that waiter-check, as spinning
> > indefinitely if the lock owner is on the CPU for too long may result in
> > excessing power burn. But normal mutex does not seem to do that.
> >
> > What  makes the rtmutex spin logic different from normal mutex in this
> > scenario, so that rtmutex wants to do that but normal ones dont?
>
> Well, the point of the patch is that I don't think they should be differe=
nt
> ;-)

But there's no "waiter change" thing for mutex_spin_on_owner right.

Then, should mutex_spin_on_owner() also add a call to
__mutex_waiter_is_first() ?

> > Another thought is, I am wondering if all of them spinning indefinitely=
 might
> > be Ok for rtmutex as well, since as you mentioned, preemption is enable=
d. So
> > adding the if (top_waiter !=3D last_waiter) {...} might be unnecessary?=
 In fact
> > may be even harmful as you are disabling interrupts in the process.
>
> The last patch only does the interrupt disabling if the top waiter change=
s.
> Which in practice is seldom.
>
> But, I don't think a non top waiter should spin if the top waiter is not
> running. The top waiter is the one that will get the lock next. If the
> owner releases the lock and gives it to the top waiter, then it has to go
> through the wake up of the top waiter.

Correct me if I'm wrong, but I don't think it will go through
schedule() after spinning, which is what adds the overhead for John.

> I don't see why a task should spin
> to save a wake up if a wake up has to happen anyway.

What about regular mutexes, happens there too or no?

> > Either way, I think a comment should go on top of the "if (top_waiter !=
=3D
> > waiter)" check IMO.
>
> What type of comment?

Comment explaining why "if (top_waiter !=3D waiter)" is essential :-).

thanks,

 -Joel
