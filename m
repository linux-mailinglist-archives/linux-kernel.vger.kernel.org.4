Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9068C49F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjBFRYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBFRYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:24:36 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D47E2D155
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:24:14 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bi36so18661104lfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 09:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sS0A0Czb9WxV1S+N4V3EYqAA6ZFJye37GWBGxAs3i/A=;
        b=cACepK4B4AmB8yeEpssioV1L+mOD8ewu64shYj2TBqsgc+0PB2qHClXuLe7R8qKcjp
         X5Uy0MDyroxlGGr9NjuMRauLdAHYGy59fOCkmtw34IRatzG40NHxEuit0PvgVak6sDLI
         cGk/D03z/sxjIRsfc3xNrauCSRi4XZsu7019g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sS0A0Czb9WxV1S+N4V3EYqAA6ZFJye37GWBGxAs3i/A=;
        b=lopep5HeWXodOV1PxjmfQfnqOtxCQomyPKzh6qBF8GKsFeal6O9qkj0t4/XQvYfKnl
         lhqpKp84kn/9DUhl2Lwr94lziQSRlUH4AyuKMRglBkEtTmL7Yxz73XTPdqlNvVJ3/cCy
         YXPpnY/F/wFgogWtP8Xc0KT1vpoTa/0gFupKGJHa1taV6y7N8rc86LyO9I8GFarGn575
         cdUncGVHbwWJ8mpHDfEVkb4x3kDCWTLzuhWj/ytMjKvw0u1dMsmWCooK+BVPO6wRG4Wb
         OLl2i+Yn4hK9LYDBoRvOgRx3fF/rni0n/0/SLzc/nqU4N6hMbxliiYZngjYCN1N2QQJb
         0nHw==
X-Gm-Message-State: AO0yUKUlbkKnYw/wm9m21Z2sSp4eHbICXxqFWeHercYz7U1NDapYzD5j
        2eICaDBfOhOuZbwfM/MD5+BR/h0ps3l9T3wMrhkNDw==
X-Google-Smtp-Source: AK7set/GspoK7qZ5ikAe2UrLJRpGdSd3YUTtughky3DwdCYJoF6bvWrfLL1QDGuCiNEXI7KiIStNE+igcDXMLVWYHuk=
X-Received: by 2002:a05:6512:3d29:b0:4d5:7655:95db with SMTP id
 d41-20020a0565123d2900b004d5765595dbmr4422124lfv.57.1675704252413; Mon, 06
 Feb 2023 09:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20230204022051.2737724-1-joel@joelfernandes.org>
 <PH0PR11MB58800C6FD1C0DDF8EC67DB5DDADA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CAEXW_YRwe781s1faLQcRBvL5pBWv9WmRuhcP=PmqHUJcm9Rphg@mail.gmail.com>
In-Reply-To: <CAEXW_YRwe781s1faLQcRBvL5pBWv9WmRuhcP=PmqHUJcm9Rphg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 6 Feb 2023 12:24:00 -0500
Message-ID: <CAEXW_YSY5nYL4LUoAX1Z8kUXtE-GW3Zor__cDWsdPL3OqEe4bA@mail.gmail.com>
Subject: Re: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
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

On Mon, Feb 6, 2023 at 12:19 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Sun, Feb 5, 2023 at 10:09 PM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
> >
> >
> > >Recent discussion triggered due to a patch linked below, from Qiang,
> > >shed light on the need to accelerate from QS reporting paths.
> > >
> > >Update the comments to capture this piece of knowledge.
> > >
> > >Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@intel.com/
> > >Cc: Qiang Zhang <Qiang1.zhang@intel.com>
> > >Cc: Frederic Weisbecker <frederic@kernel.org>
> > >Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > >---
> > > kernel/rcu/tree.c | 13 ++++++++++++-
> > > 1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > >diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > >index 93eb03f8ed99..713eb6ca6902 100644
> > >--- a/kernel/rcu/tree.c
> > >+++ b/kernel/rcu/tree.c
> > >@@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> > >       } else {
> > >               /*
> > >                * This GP can't end until cpu checks in, so all of our
> > >-               * callbacks can be processed during the next GP.
> > >+               * callbacks can be processed during the next GP. Do
> > >+               * the acceleration from here otherwise there may be extra
> > >+               * grace period delays, as any accelerations from rcu_core()
> >
> >
> > Does the extra grace period delays means that if not accelerate callback,
> > the grace period will take more time to end ? or refers to a delay in the
> > start time of a new grace period?
>
> Yes, so IMO it is like this if we don't accelerate:
> 1. Start GP 1
> 2. CPU1 queues callback C1 (not accelerated yet)
> 3. CPU1 reports QS for GP1 (not accelerating anything).
> 4. GP1 ends
> 5. CPU1's note_gp_changes() is called, accelerate happens, now the CB
> will execute after GP3 (or alternately, rcu_core() on CPU1 does
> accelerate).
> 6. GP2 ends.
> 7. GP3 starts.
> 8. GP3 ends.
> 9. CB is invoked
>
> Instead, what we will get the following thanks to the acceleration here is:
> 1. Start GP 1
> 2. CPU1 queues callback C1 (not accelerated yet)
> 3. CPU1 reports QS for GP1 and acceleration happens as done by the
> code this patch adds comments for.
> 4. GP1 ends
> 5. CPU1's note_gp_changes() is called
> 6. GP2 ends.
> 7. CB is invoked

Sorry I missed some steps, here is the update:
1. Start GP 1
2. CPU1 queues callback C1 (not accelerated yet)
3. CPU1 reports QS for GP1 (not accelerating anything).
4. GP1 ends
5. GP2 starts for some other reason from some other CPU.
6. CPU1's note_gp_changes() is called, acceleration happens, now the CB
will execute after GP3.
7. GP2 ends.
8. GP3 starts.
9. GP3 ends.
10. CB is invoked

Instead, what we will get the following thanks to the acceleration here is:
1. Start GP 1
2. CPU1 queues callback C1 (not accelerated yet)
3. CPU1 reports QS for GP1 and acceleration happens as done by the
code this patch adds comments for.
4. GP1 ends
5. GP2 starts
6. GP2 ends.
7. CB is invoked

Does that make sense or is there a subtlety I missed?

Thanks,

 - Joel
