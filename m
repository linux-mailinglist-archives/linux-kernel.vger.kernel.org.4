Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988AA6A78B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCBBJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCBBJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:09:12 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AE615174
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:09:08 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id h9so16018365ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 17:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677719346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFAcAS70DqOXg4UFHZrZeg/xN8yy4cVRbtsZIeFKOeA=;
        b=LJxK7itaA+SbRVf5hagas7h71iRJo2oVAUcKGT9/k912uf/5XUTs7NALdEgS3C2N/b
         INEXNd4ac/Frijq01DfFLr8XydZ1v2twGWqimUzsXkIN28o/bTOpNQoYGyZMZ2NAjN2S
         Km/FWsLn/EEy3C4ySjIc6l/Vod7pZtekM4mXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677719346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFAcAS70DqOXg4UFHZrZeg/xN8yy4cVRbtsZIeFKOeA=;
        b=ieJ1p4ycqBDEeDKtmvsBdNSEyyx3ghJ6gjDzzwQ+5OibW9RIrqC+n2szlSOrhoS8Qe
         duKKPBouVH2EnumXGzEX/+y3/Mm0hS/ebiIfPFI1h+5ldPMovVTSBu4K8HhHSLCJDW2f
         9j8rZ06OlzQHlG93r/XRxZ7EADrcnuYy1FrXGhbm2uJS6aZt9b1p5qYaxk1CN8liGKeq
         /EPWmkLEFPtousuO67O3L6Vx2m7ZJXcEERzGoWydbu6BHQ59FiofCLA+FfBYFs9QUs1q
         7W8sX7nPLCC0sEU+p6TBFWwkZ9NchVOXnE6XF33S03cXi6QoSockStGqMHwVwcNTXcpD
         zj8w==
X-Gm-Message-State: AO0yUKWFZ8rBJ5SvnvcjiMzCs7pXYfHirlxDXwflxvNe4l9o6eXpMhrU
        JmwwyJzbYvLul8U34MbR9w2Dr5hiMj3liE/t9sP3FQ==
X-Google-Smtp-Source: AK7set+bmf8KsRhOzgSN+9uTCd6zfcrF2n98R4P9ZPnMq+dPUskGb0QPcKUmqFwiSFKx//Qqc20zPk1FVFrOJGBbjH0=
X-Received: by 2002:a05:651c:169a:b0:295:bae5:c21c with SMTP id
 bd26-20020a05651c169a00b00295bae5c21cmr2716262ljb.3.1677719346237; Wed, 01
 Mar 2023 17:09:06 -0800 (PST)
MIME-Version: 1.0
References: <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636> <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
 <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1> <Y/0/dnmIk508sidK@lothringen>
 <Y/1ZMXsNZtwYPJNW@google.com> <Y/3fxLXbfvnLFEZq@lothringen>
 <Y/5fXskgrQxzbt0U@google.com> <Y/+HPrU/ofFXapHM@lothringen>
 <CAEXW_YTt=VZ8ZMptccFMStsQvfjy5yMbd5Ah3KL=PUB4YVSTCg@mail.gmail.com> <20230302004931.GM2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230302004931.GM2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 1 Mar 2023 20:08:54 -0500
Message-ID: <CAEXW_YRwNT02Z7e1NVd5eCknwtGfS98cViMGjuvp7zFNgu8pxg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as completed
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
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

On Wed, Mar 1, 2023 at 7:49=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Wed, Mar 01, 2023 at 04:31:01PM -0500, Joel Fernandes wrote:
> > On Wed, Mar 1, 2023 at 12:11=E2=80=AFPM Frederic Weisbecker <frederic@k=
ernel.org> wrote:
> > [...]
> > > > Hmmm I see what you mean, so a conservative and configurable "fail-=
safe"
> > > > timeout followed by sysctl to end the boot earlier than the timeout=
, should
> > > > do it (something like 30 seconds IMHO sounds reasonable)? In any ca=
se,
> > > > whatever way we go, we would not end the kernel boot before
> > > > rcu_end_inkernel_boot() is called at least once (which is the curre=
nt
> > > > behavior).
> > > >
> > > > So it would be:
> > > >
> > > >   low level boot + initcalls
> > > >        20 sec                         30 second timeout
> > > > |------------------------------|--------------------------
> > > >                                |                         |
> > > >               old rcu_end_inkernel_boot()      new rcu_end_inkernel=
_boot()
> > > >
> > > > But it could be, if user decides:
> > > >   low level boot + initcalls
> > > >        20 sec                         10 second timeout
> > > > |------------------------------|--------------------------
> > > >                                |                         |
> > > >               old rcu_end_inkernel_boot()      new rcu_end_inkernel=
_boot()
> > > >                                                via /sys/ entry.
> > >
> > > The problem I have with a random default timeout is that it may break=
 sensitive
> > > workloads. If the default is 30 and say the boot only takes 5 seconds=
 and
> > > immediately launches a latency sensitive task, this may break things =
in a
> > > subtle way during these 25 seconds when it usually didn't. Because ex=
pedited
> > > RCU is a hammer interrupting all non-idle CPUs.
> > >
> > > Until now forcing expedited RCU was only performed before any user co=
de. Now it
> > > crosses the boundary so better be careful. I'd personally advocate fo=
r keeping
> > > the current call before init is launched. Then provide an end_boot_sy=
sctl kernel
> > > boot parameter that will ignore the current call before init and let =
the user
> > > signal that through sysctl.
> >
> > Considering that the PREEMPT-RT system benefits from it within the 8
> > seconds, I will go ahead make the default 15 seconds or so and make it
> > tunable. Hopefully that will be an acceptable compromise, with
> > sufficient documentation, changelog, and so forth... If you agree I'd
> > appreciate your Ack on the next posting.
>
> Just checking on the sysfs portion of this.

Yes, the current plan is to add a sysfs node (likely sysctl) with the
15-second failsafe.

> After all, tuning kernel
> boot parameters to specific systems is not all that much fun, especially
> when you have lots of systems.

Are you suggesting to drop "end the boot" sysfs and just have a
minimum-time approach as I initially did?

 - Joel
