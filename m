Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC1074BB48
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjGHCLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGHCLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:11:45 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D011BF4;
        Fri,  7 Jul 2023 19:11:44 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1b0605d4d11so2416417fac.1;
        Fri, 07 Jul 2023 19:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688782303; x=1691374303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c5+LP2Dka2g4JRdhYjLYJ87aW46X7bmdl20w2O3x1Fc=;
        b=RVO/YQQr617tdYWue9F/AQ45bflDt3Vdcwg94pnXCS8yqRn68RmBnjsuJZG0qLbOc+
         1bRo515Ia8FmOYLvV3cNZcY9RLqYjplGaVUEUHM00Ur7KRg72wuGwV1R3mq0LxLJw8uQ
         KEag26c6sjNEXtpJlj1+QeAGosU2/JR9ZfmziHsRP5G3WuLyKJb31jvAME3Eb7+ElBz2
         qQq6SjxfzYsWxVio71xj/wvZSaMl86louWcJOT62J0IhCWKwKU1GZlGGkBjsobQ80Z8j
         ec9r2DOyuccQo/QKmaCd91EQN/186XQCJM6wUTekOI+GO0zxL7oo5NsV8s45+ozdMxuE
         lbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688782303; x=1691374303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5+LP2Dka2g4JRdhYjLYJ87aW46X7bmdl20w2O3x1Fc=;
        b=I7bVN81VDu4wjUhCWQth8J80/rNReWtxhm3VUpaEon2sedHArbIXP783qqsN83kNnJ
         HyBwQIkT1t6WIE2kzvOMKaA14B3q2D0vMmLxAuN1UOgrEwm6lkb0fnM3v27AREhz5B4p
         jPmCnFoXxn7/YjNEo0zc1iAYC6aVGIWueS/AKZay9jfLD7lz5nT0rGUmV/untHIaLsDv
         3tBQJ5NbVj8B9p9xy0EcEYFyv9KY4ZBsokz1lJysusxYEx0eEF+Cu+EkbuyE39W6WRz8
         rwIb67Hng8cq66F6YQRn2aql6zpuu5N7hcb5167DvSp8kK7LTEP/6TGklcojJEqx7dQd
         r2UA==
X-Gm-Message-State: ABy/qLY0UB/zPIPIi+L3MdNm+wj42tkiDRRQX/E6XfSN9NIYM167FOa4
        0vMHv1TOiEbOSkqRTEu/gOCcPWKuRV7NnZpPdSXJ0SvH0KU=
X-Google-Smtp-Source: APBJJlFZx2rjsRV9iAkOCPH+w3UTopPmyHfitPi57JOUsvQE/Ub/Gh3ea0RD8GwRk42OuAHbC49wN38QyMRq1AI4dak=
X-Received: by 2002:a05:6870:a2d1:b0:1a6:a6fc:f6f1 with SMTP id
 w17-20020a056870a2d100b001a6a6fcf6f1mr8450138oak.26.1688782302756; Fri, 07
 Jul 2023 19:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230704082615.7415-1-qiang.zhang1211@gmail.com>
 <77d16cbb-b28c-4b13-aecb-9ad787559557@paulmck-laptop> <CALm+0cW6DojcxSnzf2mMXhXP-MHJ0aEvSqyh1TbtvBC4bzfsOw@mail.gmail.com>
 <087e3da2-ffd9-4cf4-8893-73f4edc3cfba@paulmck-laptop>
In-Reply-To: <087e3da2-ffd9-4cf4-8893-73f4edc3cfba@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Sat, 8 Jul 2023 10:11:30 +0800
Message-ID: <CALm+0cV2WdFzSaLpGodqv6idxvBSjupHPHNuK_z3r8Xya7KUuw@mail.gmail.com>
Subject: Re: [PATCH] srcu: Make srcu_might_be_idle() take early return if
 rcu_gp_is_normal() return true
To:     paulmck@kernel.org
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Fri, Jul 07, 2023 at 06:28:29PM +0800, Z qiang wrote:
> > >
> > > On Tue, Jul 04, 2023 at 04:26:15PM +0800, Zqiang wrote:
> > > > When invoke synchronize_srcu(), in the srcu_might_be_idle(), the current
> > > > CPU's sdp->lock will be acquired to check whether there are pending
> > > > callbacks in the sdp->srcu_cblist, if there are no pending callbacks,
> > > > probabilistically probe global state to decide whether to convert to
> > > > synchronize_srcu_expedited() call. however, for the rcupdate.rcu_normal=1
> > > > kernels and after the rcu_set_runtime_mode() is called, invoke the
> > > > rcu_gp_is_normal() is always return true, this mean that invoke the
> > > > synchronize_srcu_expedited() always fall back to synchronize_srcu(),
> > > > so there is no need to acquire sdp->lock to check sdp->srcu_cblist and
> > > > probe global state in srcu_might_be_idle().
> > > >
> > > > This commit therefore make srcu_might_be_idle() return immediately if the
> > > > rcu_gp_is_normal() return true.
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > ---
> > > >  kernel/rcu/srcutree.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 20d7a238d675..aea49cb60a45 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -1172,6 +1172,8 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> > > >       unsigned long tlast;
> > > >
> > > >       check_init_srcu_struct(ssp);
> > > > +     if (rcu_gp_is_normal())
> > > > +             return false;
> > >
> > > Again, thank you for looking into SRCU!
> > >
> > > I am not at all enthusiastic about this one.  With this change, the name
> > > srcu_might_be_idle() is no longer accurate.  Yes, the name could change,
> > > but any name would be longer and more confusing.
> > >
> > > So unless there is a measureable benefit to this one on a production
> > > workload, I cannot justify taking it.
> > >
> > > Is there a measureable benefit?
> >
> > Hi, Paul
> >
> > I only find that for Preempt-RT kernel,  the rcu_normal_after_boot is
> > set by default:
> > static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
> > This affects only rcu but also srcu, this make the synchronize_srcu() and
> > synchronize_srcu_expedited() always fall back to __synchronize_srcu(ssp, true),
> > this means that call the srcu_might_be_idle() is meaningless.
>
> I do understand that the current setup favors default kernel builds at
> runtime by a few low-cost instructions, and that your change favors,
> as you say, kernels built for real-time, kernels built for certain types
> of HPC workloads, and all kernels during a small time during boot.
>
> My question is instead whether any of this makes a measureable difference
> at the system level.
>
> My guess is "no, not even close", but the way to convince me otherwise
> would be to actually run the workload and kernels on real hardware and
> provide measurements showing a statistically significant difference that
> the workload(s) in question care(s) about.
>
> So what can you show me?
>
> And srcu_might_be_idle() is not meaningless in that situation, just
> ignored completely.  And that is in fact the nature and purpose of the
> C-language || operator.  ;-)
>

Agree with you :)
This make me want to ask another question,  why srcu also use
rcupdate.rcu_normal and rcupdate.rcu_expedited to decide expedited
srcu grace-period or only use normal grace-period instead of
generating srcu_normal and srcu_expedited?

Thanks
Zqiang

>
>                                                         Thanx, Paul
>
> > Thanks
> > Zqiang
> >
> > >
> > >                                                         Thanx, Paul
> > >
> > > >       /* If the local srcu_data structure has callbacks, not idle.  */
> > > >       sdp = raw_cpu_ptr(ssp->sda);
> > > >       spin_lock_irqsave_rcu_node(sdp, flags);
> > > > --
> > > > 2.17.1
> > > >
