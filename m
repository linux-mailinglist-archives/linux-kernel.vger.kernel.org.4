Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76667692BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBJXzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjBJXzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:55:23 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D297E02F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:55:18 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j17so10794838lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hub9eRpb+vroZn2JIwZrXOy9Vh1ghxk4CimJGPNm0Ac=;
        b=wWTQ7RF97aVudont8TU+6FhsCigfrMmOIjnS/02DpAK68VqQXI7/Yp4T+culJTNknr
         b4pOM3v1l5mTQNVk589OcKjhA0wcm7Z+f+g5zOxsHrKaTLg6Ed+5lxt1h5c2mz+EqLuh
         Fn41MlFyF56lNYD6aLSGbeiR3vcwqU4K3TpYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hub9eRpb+vroZn2JIwZrXOy9Vh1ghxk4CimJGPNm0Ac=;
        b=ein20TZRnDidOhZxRFRE61q56E9creEdVuzEFkgEqpqwSV+0JelXLeuo6sc0R8/o9g
         gRQMDD1JoZMsvYZBV8btOTH/kSR5GRIiwHZ65twyR1aEO9CmSbF2lItDpiHA/x4PU8y/
         g4l/pp8QIFlwz80//8NiKBRE1eLvY1SCuAEdZCeuMJsMUyoMzIsz5+AEyQR0Hx4nV3Gn
         NKVcMrX26QzgNMkCV1xZ6zrBPc2kBnE+RAiDlNFP4iEkUW5L2OHHliBq0vz8946qESgs
         PZOxs07FzXAbrJL0YB7TKVM6NPv6wwxVgP59NYcksfMt3NfpuGxo4tFKtIC0L4JO3zC0
         oGxw==
X-Gm-Message-State: AO0yUKWy+1G5SUdGke+prcwLAUBCiyoiw1C8weXvZCmohGBJa2M3Z3pj
        9yUMgbYwzbiBTlhYjmAjLapXD9JlO2n7516VtoRFFA==
X-Google-Smtp-Source: AK7set/QhEfDVyZculK9TptRG98c56WuSq04L/SFwsKvGb+6EFvfVl29B2nHU/ZB9573vyR8m4zBepXjbJXDr1LvgSY=
X-Received: by 2002:ac2:4a66:0:b0:4db:dd7:dee2 with SMTP id
 q6-20020ac24a66000000b004db0dd7dee2mr2494355lfp.16.1676073316327; Fri, 10 Feb
 2023 15:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20230204022051.2737724-1-joel@joelfernandes.org>
 <PH0PR11MB58800C6FD1C0DDF8EC67DB5DDADA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CAEXW_YRwe781s1faLQcRBvL5pBWv9WmRuhcP=PmqHUJcm9Rphg@mail.gmail.com>
 <CAEXW_YSY5nYL4LUoAX1Z8kUXtE-GW3Zor__cDWsdPL3OqEe4bA@mail.gmail.com> <PH0PR11MB5880E2B1C4A0A4DFA46C3B7FDADB9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880E2B1C4A0A4DFA46C3B7FDADB9@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 10 Feb 2023 18:55:04 -0500
Message-ID: <CAEXW_YQyqPCPZf8wLHaVqVWO43jND0kmsYbS=t_EFrXrBmzRvw@mail.gmail.com>
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
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 8:15 PM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
>
> On Mon, Feb 6, 2023 at 12:19 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Sun, Feb 5, 2023 at 10:09 PM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
> > >
> > >
> > > >Recent discussion triggered due to a patch linked below, from Qiang,
> > > >shed light on the need to accelerate from QS reporting paths.
> > > >
> > > >Update the comments to capture this piece of knowledge.
> > > >
> > > >Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@intel.com/
> > > >Cc: Qiang Zhang <Qiang1.zhang@intel.com>
> > > >Cc: Frederic Weisbecker <frederic@kernel.org>
> > > >Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >
> > > >---
> > > > kernel/rcu/tree.c | 13 ++++++++++++-
> > > > 1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > >diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > >index 93eb03f8ed99..713eb6ca6902 100644
> > > >--- a/kernel/rcu/tree.c
> > > >+++ b/kernel/rcu/tree.c
> > > >@@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> > > >       } else {
> > > >               /*
> > > >                * This GP can't end until cpu checks in, so all of our
> > > >-               * callbacks can be processed during the next GP.
> > > >+               * callbacks can be processed during the next GP. Do
> > > >+               * the acceleration from here otherwise there may be extra
> > > >+               * grace period delays, as any accelerations from rcu_core()
> > >
> > >
> > > Does the extra grace period delays means that if not accelerate callback,
> > > the grace period will take more time to end ? or refers to a delay in the
> > > start time of a new grace period?
> >
> > Yes, so IMO it is like this if we don't accelerate:
> > 1. Start GP 1
> > 2. CPU1 queues callback C1 (not accelerated yet)
> > 3. CPU1 reports QS for GP1 (not accelerating anything).
> > 4. GP1 ends
> > 5. CPU1's note_gp_changes() is called, accelerate happens, now the CB
> > will execute after GP3 (or alternately, rcu_core() on CPU1 does
> > accelerate).
> > 6. GP2 ends.
> > 7. GP3 starts.
> > 8. GP3 ends.
> > 9. CB is invoked
> >
> > Instead, what we will get the following thanks to the acceleration here is:
> > 1. Start GP 1
> > 2. CPU1 queues callback C1 (not accelerated yet)
> > 3. CPU1 reports QS for GP1 and acceleration happens as done by the
> > code this patch adds comments for.
> > 4. GP1 ends
> > 5. CPU1's note_gp_changes() is called
> > 6. GP2 ends.
> > 7. CB is invoked
> >
> >Sorry I missed some steps, here is the update:
> >1. Start GP 1
> >2. CPU1 queues callback C1 (not accelerated yet)
> >3. CPU1 reports QS for GP1 (not accelerating anything).
> >4. GP1 ends
> >5. GP2 starts for some other reason from some other CPU.
> >6. CPU1's note_gp_changes() is called, acceleration happens, now the CB
> >will execute after GP3.
> >7. GP2 ends.
> >8. GP3 starts.
> >9. GP3 ends.
> >10. CB is invoked
> >
> >Instead, what we will get the following thanks to the acceleration here is:
> >1. Start GP 1
> >2. CPU1 queues callback C1 (not accelerated yet)
> >3. CPU1 reports QS for GP1 and acceleration happens as done by the
> >code this patch adds comments for.
> >4. GP1 ends
> >5. GP2 starts
> >6. GP2 ends.
> >7. CB is invoked
> >
> >Does that make sense or is there a subtlety I missed?
>
>
>
> Thanks for detailed description, that is to say, the grace period delays means that
> if there is no acceleration,  the invocation of callback may be delayed by one or
> more grace periods.
>
> Can you re-describe the meaning of  "grace period delays "in the comments?

Yes, good point. I should change it to "one or more delays". Thank you
for the suggestion!

Sorry for my late reply as I was OOO this week.

 - Joel


>
> Thanks
> Zqiang
>
>
>
> >
> >Thanks,
> >
> > - Joel
