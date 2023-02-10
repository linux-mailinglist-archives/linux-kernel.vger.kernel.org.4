Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A1F692B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjBJXqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjBJXqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:46:44 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60FD55286
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:46:34 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id o5so8133442ljj.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4q6XW5XbdQX/MPpKXpGqH3BO1A2MTER/s1wXEr/gwrU=;
        b=O+skqT1FzCFvFvqtXF5FW8Wm6vMHiJaJE58WSPOfKaty1uoyPCBG+joTQ4/URDQgCK
         V1DFxMBm1IE6qQvB8zpklFEaKZ8VdaQf3diPhkH8eAAQzTBeG36eRHJgQJi8dGqez1ce
         4B/fCD+PzYQke5aaQ8pvHf0xQjmUx3oYgV/kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4q6XW5XbdQX/MPpKXpGqH3BO1A2MTER/s1wXEr/gwrU=;
        b=vq5mS76tJQbeSLohSX+KqmE2vTugluh616CayuA841PDqubPmq8fL/12my5ET6tGc3
         AJom2SE0loc3gq1AyGO+z86CaDsrmS2/6GcEscSA7VAr1WX8OqrRZ7j0zX+5m4fhMGwX
         7awVmLkMTP5m56thS6946DhzVUA3WL0jV7aMAMc283Uq3htJ6lK16zpdcjLNNsmuxomG
         DHfiK/h4WaH+SZiXwP/HgAjqoYLPR/YwbLnLHJg8iScGZtYx/Xqj9SUwDU48fqWneN3H
         tTe5+Xed3M+Z2iE9Mu13ZTkzCL0njQLpKjhrDtboKaXH8SYrD6gtVlPA7xQqpEAat9um
         cHjw==
X-Gm-Message-State: AO0yUKUh/MIlCc+qNkKRgxkS8OpJt0cgRMl5p40EDPa37ARW7dELy32R
        GuQatI5PbBx8UxDb7MsWtU4ika95iYSaFcRWkNECRQ==
X-Google-Smtp-Source: AK7set/8bE/xi8HD3yYAegHcZ75Mj/TqtrRvLJOEGnRdFGXQXoi2tM6qHFUWQN2FBLJ+/NVfmoe/K6Y8bEJ4Wxqe5Wc=
X-Received: by 2002:a2e:b4b8:0:b0:290:65bb:6b24 with SMTP id
 q24-20020a2eb4b8000000b0029065bb6b24mr2679443ljm.87.1676072793176; Fri, 10
 Feb 2023 15:46:33 -0800 (PST)
MIME-Version: 1.0
References: <20230204022051.2737724-1-joel@joelfernandes.org> <Y+JQ8GX82Gn+7ZWe@lothringen>
In-Reply-To: <Y+JQ8GX82Gn+7ZWe@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 10 Feb 2023 18:46:21 -0500
Message-ID: <CAEXW_YTCZO-8pT2ixnDmbVaLw31J4JRXieEGvFPdo4P=1GJPLA@mail.gmail.com>
Subject: Re: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Qiang Zhang <Qiang1.zhang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 8:24 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Sat, Feb 04, 2023 at 02:20:50AM +0000, Joel Fernandes (Google) wrote:
> > Recent discussion triggered due to a patch linked below, from Qiang,
> > shed light on the need to accelerate from QS reporting paths.
> >
> > Update the comments to capture this piece of knowledge.
> >
> > Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@intel.com/
> > Cc: Qiang Zhang <Qiang1.zhang@intel.com>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > ---
> >  kernel/rcu/tree.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 93eb03f8ed99..713eb6ca6902 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> >       } else {
> >               /*
> >                * This GP can't end until cpu checks in, so all of our
> > -              * callbacks can be processed during the next GP.
> > +              * callbacks can be processed during the next GP. Do
> > +              * the acceleration from here otherwise there may be extra
> > +              * grace period delays, as any accelerations from rcu_core()
> > +              * or note_gp_changes() may happen only after the GP after the
> > +              * current one has already started. Further, rcu_core()
> > +              * only accelerates if RCU is idle (no GP in progress).
>
> Actually note_gp_changes() should take care of that.

You are referring to  rcu_core() -> rcu_check_quiescent_state() ->
note_gp_changes() doing the acceleration prior to the  rcu_core() ->
rcu_report_qs_rdp() call, correct?

Ah, but note_gp_changes() has an early return which triggers if either:
1. The rnp spinlock trylock failed.
2. The start of a new grace period was already detected before, so
rdp->gp_seq == rnp->gp_seq.

So I think it is possible that we are in the middle of a GP, and
rcu_core() is called because QS reporting is required for the CPU, and
say the current GP started we are in the middle off occurs from the
same CPU so rdp->gp_seq == rnp->gp_seq.

Now, rcu_core()'s call to note_gp_changes() should return early but
its later call to report_qs_rdp() will not accelerate the callback
without the code we are commenting here.

> My gut feeling is that the
> acceleration in rcu_report_qs_rdp() only stands for:
>
> * callbacks that may be enqueued from an IRQ firing during the small window
>   between the RNP unlock in note_gp_changes() and the RNP lock in
>   rcu_report_qs_rdp()

Sure, this also seems like a valid reason.

> * __note_gp_changes() got called even before from the GP kthread, and callbacks
>   got enqueued between that and rcu_core().

Agreed. In this case we will take the early return in
note_gp_changes() when called from the rcu_core(). So yeah, that was
kind of my point as well but slightly different reasoning.

Let me know if you disagree with anything I mentioned, though.

 - Joel
