Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6016428BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiLEMr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiLEMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:47:20 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D221B7A1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:47:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso11179584pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 04:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Skm+LNKckmc6G2Jr5AHkpfAt8qWeTvk3qZKc10iUg4o=;
        b=u2x4sPJHmrr8rMTniOlRrg3awbIXBh5A/vu2BxcMk/66ujTOvEAUzX42SzH0/ZBDM5
         vkyQf+vzFF5NegAhIJLWVu42vm1bb8mFxxu6sBK700JTfbHMhALKNZF/i1BX/TEdDuMQ
         6CAnyUuKz6nG7aMMczjq1g4DvBSK38Wa0RHUCZsuK+iSfjITn/7AKoqbUJ5RkhNUHpXq
         w5iyv2nkTHknaWsD4dqVWNoO+bYojMw80fKeJ3285ftkm4EN37V7XXuQbrX2c1KqXnf7
         3Z7b/3UWNZU6GrXbypmd5DfjrJXyXaOrPkcslW5r7wWhyPwpcKpXw+MRncu0ktpjS+t6
         aV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Skm+LNKckmc6G2Jr5AHkpfAt8qWeTvk3qZKc10iUg4o=;
        b=er7Ji/0FW2RBGsrobP0ISlCbKyxE2p3UlZFIqYeorKtP4w4vxuACylLSv5Vel8rTB/
         4dIGnMc1dyhE9Lbj/27OogqKysM0DqdcuJT8E8OZnpNENLNKvRXLvxXQRFT82HJooTzH
         6pcBt6Bk+XX9fAztCvA7jQwypP36JfbaiUTdSs8I0xF5bQL0ctPL4WNE8arnUWG+Kfss
         vH4dt2sarXHVln2KYF//WWbZzBJwg+1nii9AM2lJAzr7UHYdFU2sEfjbroTZTta6aiZN
         IRvaq4itgoMI4UjrsApWrZnp1zsZa24AGwjDNKD7H8yYLpflonn27/3fjjRNFZJAi5Oc
         nL7g==
X-Gm-Message-State: ANoB5pnh0v4Hnu4i8EePhODy5/nxLn6S1MTfZTve38jXfZ7DMC1RcKle
        WKNZE1Vvs/tooJSvnDksIs72RyMa7BszRbYBd1RQ0g==
X-Google-Smtp-Source: AA0mqf4qQzDBPIhJB3SRcS6Ku9gknQOQFsBHFqkD4If7DgzV4mevCrzkrb72BQQ/Pk0CGiDSBMJAs/dvybW9G+kz3Es=
X-Received: by 2002:a17:90a:ae0f:b0:20d:b124:33b1 with SMTP id
 t15-20020a17090aae0f00b0020db12433b1mr87301189pjq.202.1670244438668; Mon, 05
 Dec 2022 04:47:18 -0800 (PST)
MIME-Version: 1.0
References: <5627469.DvuYhMxLoT@kreacher> <4789678.31r3eYUQgx@kreacher>
 <CAPDyKFqu9-=L9B-Vkzqom6akVpim0R2_DPj__3t3dp9Y_oUEEg@mail.gmail.com> <CAJZ5v0jWBREsP4UN98+d8f35zDNA3PwisAxZDq03mZ1JkAg1ww@mail.gmail.com>
In-Reply-To: <CAJZ5v0jWBREsP4UN98+d8f35zDNA3PwisAxZDq03mZ1JkAg1ww@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 5 Dec 2022 13:46:42 +0100
Message-ID: <CAPDyKFp+5cXE8RLP=Q=i06uE1DyE0vzttFj46pQt_hTwmAm6_Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PM: runtime: Do not call __rpm_callback() from rpm_idle()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 at 13:13, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 5, 2022 at 1:08 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 2 Dec 2022 at 15:32, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Calling __rpm_callback() from rpm_idle() after adding device links
> > > support to the former is a clear mistake.
> > >
> > > Not only it causes rpm_idle() to carry out unnecessary actions, but it
> > > is also against the assumption regarding the stability of PM-runtime
> > > status accross __rpm_callback() invocations, because rpm_suspend() and
> > > rpm_resume() may run in parallel with __rpm_callback() when it is called
> > > by rpm_idle() and the device's PM-runtime status can be updated by any
> > > of them.
> >
> > Urgh, that's a nasty bug you are fixing here. Is there perhaps some
> > links to some error reports that can make sense to include here?
>
> There is a bug report, but I have no confirmation that this fix is
> sufficient to address it (even though I'm quite confident that it will
> be).
>
> > >
> > > Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c |   12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > Index: linux-pm/drivers/base/power/runtime.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > +++ linux-pm/drivers/base/power/runtime.c
> > > @@ -484,7 +484,17 @@ static int rpm_idle(struct device *dev,
> > >
> > >         dev->power.idle_notification = true;
> > >
> > > -       retval = __rpm_callback(callback, dev);
> >
> > Couldn't we just extend __rpm_callback() to take another in-parameter,
> > rather than open-coding the below?
>
> I'd rather not do that.
>
> I'd prefer rpm_callback() to be used only in rpm_suspend() and
> rpm_resume() where all of the assumptions hold and rpm_idle() really
> is a special case.
>
> And there is not much open-coding here, just the locking part.

That and the actual call to the callback. Not much, but still.

>
> > Note that, __rpm_callback() already uses a "bool use_links" internal
> > variable, that indicates whether the device links should be used or
> > not.
>
> Yes, it does, but why does that matter?

It means that __rpm_callback() is already prepared to (almost) cover this case.

>
> > > +       if (dev->power.irq_safe)
> > > +               spin_unlock(&dev->power.lock);
> > > +       else
> > > +               spin_unlock_irq(&dev->power.lock);
> > > +
> > > +       retval = callback(dev);
> > > +
> > > +       if (dev->power.irq_safe)
> > > +               spin_lock(&dev->power.lock);
> > > +       else
> > > +               spin_lock_irq(&dev->power.lock);
> > >
> > >         dev->power.idle_notification = false;
> > >         wake_up_all(&dev->power.wait_queue);
> > >
> > >
> > >

Note, it's not a big deal to me, if you feel strongly that your
current approach is better, I am fine with that too.

Kind regards
Uffe
