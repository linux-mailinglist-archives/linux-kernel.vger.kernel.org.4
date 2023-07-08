Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B443974BC6C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 08:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGHGpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 02:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGHGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 02:45:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777E81FEC;
        Fri,  7 Jul 2023 23:45:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso9062715ad.2;
        Fri, 07 Jul 2023 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688798727; x=1691390727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/5uEObhFMe/jSN8KbQQnE8VqMdCbWCRfXqhmDAT8Yk=;
        b=o2JJVaaCsvMI+MaSOHZA9qWywAx2TcT3eMHyXT1ckB4TDzBLOIxBuBpUjMaDGBewnO
         /8kuq+zZuCQVKt5TGYEOJtcFSBHqukDbx2vp2fKlBCZk6bkA68mv1iVqwvvcns82LdCf
         RI7Mr8QQLjeMi3kj7OvyBNAs7/fdodZDPbKNxdHGrwkLcMVRDuM2TZxCPV6GtRdm+1Ho
         Xpi0RmiI4WNhD6mRgRCeQtfmZ+AKPiI32TpKZ9O1UZInM4eFr+/y+4WoeYjZ8OAHHJ3B
         CkZMTWFncvjhylZ7cmtdJzdYFQXSLRGI8fPFO8gM4pT4uzE4ByHzs4Gdl8ufGF9yfVf0
         eaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688798727; x=1691390727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/5uEObhFMe/jSN8KbQQnE8VqMdCbWCRfXqhmDAT8Yk=;
        b=Yy3KNHn1ujIiSUIRjAqaaQhyYnOiCLJZ6BspB98rOBS2WTvmbdh4G1Hr3CXekCDFLm
         owgP2oC3ARM84tOQ87zIm8vARqv3mVGVZrpMB3Df+aYWYxfSmVj5wg9V0RSZZyu+U+Fy
         wI4oRZKVSNWRigaQsLc5R0f5Eiy6IojB9bC2uwL3Ld5V21g/JiifHickft+czpnL2oDQ
         sRshr18tlkiJHRpWejjsbVs02aPzfahQVluLMFvpOwoR1pzItAyezSFweu0DNGBLDub3
         0l7rhOorgYvoTEYpGwfkM93472HcaRyaQBPWFoD033fkSn1GRuGyv4vYCEi7XkWtqVDO
         e/jw==
X-Gm-Message-State: ABy/qLbYvR5Dh62xJOcpoyh0T+C6mRfkdsW6zSAU8dlmNmjnGPpOLeLZ
        TAE1eTGmQZGrhBxkOlaHqIv9sltTfiogBkx2gtiejDR2cfs=
X-Google-Smtp-Source: APBJJlFNhDttcjqT6CV3lvtWun/rS6mhriYJKyIb5M77toRDfBpmBhO8H68bukpuuDtAJeQvU2K7lT6o42qRC4Hoo6U=
X-Received: by 2002:a17:902:7c82:b0:1b3:d608:899a with SMTP id
 y2-20020a1709027c8200b001b3d608899amr5887951pll.68.1688798726890; Fri, 07 Jul
 2023 23:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230704082615.7415-1-qiang.zhang1211@gmail.com>
 <77d16cbb-b28c-4b13-aecb-9ad787559557@paulmck-laptop> <CALm+0cW6DojcxSnzf2mMXhXP-MHJ0aEvSqyh1TbtvBC4bzfsOw@mail.gmail.com>
 <087e3da2-ffd9-4cf4-8893-73f4edc3cfba@paulmck-laptop> <CALm+0cV2WdFzSaLpGodqv6idxvBSjupHPHNuK_z3r8Xya7KUuw@mail.gmail.com>
 <daaefdef-03d7-4681-bceb-df29d488f5c3@paulmck-laptop>
In-Reply-To: <daaefdef-03d7-4681-bceb-df29d488f5c3@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Sat, 8 Jul 2023 14:45:14 +0800
Message-ID: <CALm+0cXDge39jGx+LEgee10uqLZ6KZrbU=i=Jgxte1qR2YQ7Vg@mail.gmail.com>
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
> On Sat, Jul 08, 2023 at 10:11:30AM +0800, Z qiang wrote:
> > >
> > > On Fri, Jul 07, 2023 at 06:28:29PM +0800, Z qiang wrote:
> > > > >
> > > > > On Tue, Jul 04, 2023 at 04:26:15PM +0800, Zqiang wrote:
> > > > > > When invoke synchronize_srcu(), in the srcu_might_be_idle(), the current
> > > > > > CPU's sdp->lock will be acquired to check whether there are pending
> > > > > > callbacks in the sdp->srcu_cblist, if there are no pending callbacks,
> > > > > > probabilistically probe global state to decide whether to convert to
> > > > > > synchronize_srcu_expedited() call. however, for the rcupdate.rcu_normal=1
> > > > > > kernels and after the rcu_set_runtime_mode() is called, invoke the
> > > > > > rcu_gp_is_normal() is always return true, this mean that invoke the
> > > > > > synchronize_srcu_expedited() always fall back to synchronize_srcu(),
> > > > > > so there is no need to acquire sdp->lock to check sdp->srcu_cblist and
> > > > > > probe global state in srcu_might_be_idle().
> > > > > >
> > > > > > This commit therefore make srcu_might_be_idle() return immediately if the
> > > > > > rcu_gp_is_normal() return true.
> > > > > >
> > > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > > ---
> > > > > >  kernel/rcu/srcutree.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > index 20d7a238d675..aea49cb60a45 100644
> > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > @@ -1172,6 +1172,8 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> > > > > >       unsigned long tlast;
> > > > > >
> > > > > >       check_init_srcu_struct(ssp);
> > > > > > +     if (rcu_gp_is_normal())
> > > > > > +             return false;
> > > > >
> > > > > Again, thank you for looking into SRCU!
> > > > >
> > > > > I am not at all enthusiastic about this one.  With this change, the name
> > > > > srcu_might_be_idle() is no longer accurate.  Yes, the name could change,
> > > > > but any name would be longer and more confusing.
> > > > >
> > > > > So unless there is a measureable benefit to this one on a production
> > > > > workload, I cannot justify taking it.
> > > > >
> > > > > Is there a measureable benefit?
> > > >
> > > > Hi, Paul
> > > >
> > > > I only find that for Preempt-RT kernel,  the rcu_normal_after_boot is
> > > > set by default:
> > > > static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
> > > > This affects only rcu but also srcu, this make the synchronize_srcu() and
> > > > synchronize_srcu_expedited() always fall back to __synchronize_srcu(ssp, true),
> > > > this means that call the srcu_might_be_idle() is meaningless.
> > >
> > > I do understand that the current setup favors default kernel builds at
> > > runtime by a few low-cost instructions, and that your change favors,
> > > as you say, kernels built for real-time, kernels built for certain types
> > > of HPC workloads, and all kernels during a small time during boot.
> > >
> > > My question is instead whether any of this makes a measureable difference
> > > at the system level.
> > >
> > > My guess is "no, not even close", but the way to convince me otherwise
> > > would be to actually run the workload and kernels on real hardware and
> > > provide measurements showing a statistically significant difference that
> > > the workload(s) in question care(s) about.
> > >
> > > So what can you show me?
> > >
> > > And srcu_might_be_idle() is not meaningless in that situation, just
> > > ignored completely.  And that is in fact the nature and purpose of the
> > > C-language || operator.  ;-)
> >
> > Agree with you :)
> > This make me want to ask another question,  why srcu also use
> > rcupdate.rcu_normal and rcupdate.rcu_expedited to decide expedited
> > srcu grace-period or only use normal grace-period instead of
> > generating srcu_normal and srcu_expedited?
>
> Because I have not yet come across a situation where it was useful for
> the one to be expedited and the other normal.
>
> But if you know of such a situation, let's talk about it.
>

Thanks, I will let you know if I come across such a situation :) .

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
> > > > Thanks
> > > > Zqiang
> > > >
> > > > >
> > > > >                                                         Thanx, Paul
> > > > >
> > > > > >       /* If the local srcu_data structure has callbacks, not idle.  */
> > > > > >       sdp = raw_cpu_ptr(ssp->sda);
> > > > > >       spin_lock_irqsave_rcu_node(sdp, flags);
> > > > > > --
> > > > > > 2.17.1
> > > > > >
