Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA068C8D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBFVfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBFVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:35:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A01284B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:35:39 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so12759350pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 13:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8NGdCWC41Xy1O1QF4FREA4fKB18fJvnlW/AXpxCQbQ=;
        b=S/dxotnmgHPQfzi27SmO4FE/hT3AgU4mn5yCTcqIHJi4Xf938K7m9IV5TqLHR1em8o
         +kb9NEQTGXhnRCLypaw5ZjE9r3T4aAcQoQNO3NvCjGNccnh35oRC/OXDVa+YsliPVKAP
         0Mku+nda/pTq7Sv7EJGqQDRt0hoc0e5ZFSwCbl6xjxHmeJyd/iz8YCuNaDJPdMsak0xV
         C+qmX9spkqqTRtGFpFChpluOGJW17/z0x9DldPqbI14J5CwHleAVJLZnR63K8HSzZ8GO
         MTBH7EVPRXY+pr/x1xPStIggnIoKZA6imfPGR5GT0lWMRzPi2aTv07FYJ9jRPVfM3Ibm
         gd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8NGdCWC41Xy1O1QF4FREA4fKB18fJvnlW/AXpxCQbQ=;
        b=qCRU/iPD63HTuCTFxhR7vQUbpab+UkNjxKru1Ztro/owRwtkmM6YruoSyC3hMejx2J
         qzbEfmEZH9ZW/cE0iCqmGfto74lJWkqAfSiyIZYB465iTGBfkJ30yqLAbme1busR4Gtf
         StjZzVzb0FjDFZtpV8wEnuKaZpG6iLrBe/BoOyYy3XmU6w2YPcWbFrYoO8ifk0DY9fuW
         eDEwFAMXhaMhNLtTj11Qx4QRyPOM3oVW/s05OEouiTwqVfUz6ZNssBSgk8CYeSY10vFq
         wZXiKRq2eehd094Zs5HQEIP0Bh4JPhtTXt0Vj0HoDkxepn/rC36n8sIjf5vNwZAKDIbU
         hliw==
X-Gm-Message-State: AO0yUKW97efsjXTvpyfYiFBpCn6DOh3RwmB0VINjBTl1sYqDliRL6rvU
        Vp3oN0rgME0D40RajS4s56hSuFrRNrzsWi0O60/+Ag==
X-Google-Smtp-Source: AK7set+1pCQGWSs08BUT8FAH7b03HIJmaihraE7Tfy/AayH948BRiWIdVSdEWs6eX47ocmtHNlSb2GPCK4BSo4qonm4=
X-Received: by 2002:a17:902:714b:b0:194:6253:d685 with SMTP id
 u11-20020a170902714b00b001946253d685mr107416plm.3.1675719338917; Mon, 06 Feb
 2023 13:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20230127104054.895129-1-abel.vesa@linaro.org> <Y9v/z8CYik3faHh7@google.com>
 <Y+ErWTyV8CnE3Hl+@linaro.org> <Y+E3T6bozU1K2sFb@google.com>
 <Y+E9Z+/+eCpPK6DE@linaro.org> <CAGETcx99ev_JdgYoifEdUg6rqNCs5LHc-CfwTc7j3Bd_zeizew@mail.gmail.com>
 <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com>
In-Reply-To: <CAD=FV=X3nnwuTK2=w7DJfjL_Ai7MiuvTwv8BiVJPMVEWKzR-_g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 6 Feb 2023 13:35:02 -0800
Message-ID: <CAGETcx-LJEZAXT1VazhRf7xtNpST0tfLNmgxH878gkOOP4TDAw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
To:     Doug Anderson <dianders@chromium.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Feb 6, 2023 at 1:10 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Feb 6, 2023 at 11:33 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Feb 6, 2023 at 9:48 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > >
> > > CC'ed Saravana
> >
> > Thanks. Please do cc me for stuff like this from the start. I skimmed
> > the series and I think it's doing one of my TODO items. So, thanks for
> > the patch!
> >
> > I'll take a closer look within a few days -- trying to get through
> > some existing fw_devlink stuff.
> >
> > But long story short, it is the right thing to keep a supplier on
> > indefinitely if there's a consumer device (that's not disabled in DT)
> > that never gets probed. It's a pretty common scenario -- for example,
> > say a display backlight. The default case should be functional
> > correctness. And then we can add stuff that allows changing this
> > behavior with command line args or something else that can be done
> > from userspace.
> >
> > +1 to what Doug said elsewhere in this thread too. I'm trying to
> > consolidate the "when do we give up" decision at the driver core level
> > independent of what framework is being used.
>
> I'm not really sure I agree with the above, at least not without lots
> of discussion in the community. It really goes against what the kernel
> has been doing for years and years in the regulator and clock
> frameworks. Those frameworks both eventually give up and power down
> resources that no active drivers are using. Either changing the
> regulator/clock frameworks or saying that other frameworks should work
> in an opposite way seems like a recipe for confusion.
>
> Now, certainly I won't say that the way that the regulator and clock
> frameworks function is perfect nor will I say that they don't cause
> any problems. However, going the opposite way where resources are kept
> at full power indefinitely will _also_ cause problems.
>
> Specifically, let's look at the case you mentioned of a display
> backlight. I think you're saying that if there is no backlight driver
> enabled in the kernel that you'd expect the backlight to just be on at
> full brightness.

No, I'm not saying that.

> Would you expect this even if the firmware didn't
> leave the backlight on?

sync_state() never turns on anything that wasn't already on at boot.
So in your example, if the firmware didn't turn on the backlight, then
it'll remain off.

> In any case, why do you say it's more correct?

Because if you turn off the display, the device is unusable. In other
circumstances, it can crash a device because the firmware powered it
on left it in a "good enough" state, but we'd go turn it off and crash
the system.

> I suppose you'd say that the screen is at least usable like this.
> ...except that you've broken a different feature: suspend/resume.

If the display is off and the laptop is unusable, then we have bigger
problems than suspend/resume?

> Without being able to turn the backlight off at suspend time the
> device would drain tons of power. It could also overheat when you
> stuffed it in your backpack and damage the battery or start a fire.
> Even if you argue that in the case of the display backlight you're
> better off, what about a keyboard backlight? It's pretty easy to use a
> laptop without the keyboard backlight and if you didn't have a driver
> for it you'd be in better shape leaving it off instead of leaving it
> on 100% of the time, even when the device is suspended.

I think you are again assuming sync_state() will cause stuff to be
turned on if the firmware didn't leave it on before booting the
kernel. This is not the case.

But let's assume you had the same understanding, then I'd argue that
between the default kernel configuration crashing some systems vs
having power impact on others, I'd prefer the former. The firmware
shouldn't have left the keyboard backlight on if it cared about
suspend/resume.

> Overall: if a kernel isn't configured for a given driver we shouldn't
> be expecting the hardware controlled by that driver to work. The best
> we can hope for is that it's at least in a low power state.
>
> In general I think that having a well-defined way to know it's time to
> give up and power off anything for which a driver didn't probe needs
> to be an important part of any designs here.

Btw, the current compromise for deferred probes/optional suppliers is
"keep extending the timeout by 10 seconds as long as modules are being
loaded".

As I said in my earlier email, this is just what I think it should be
like and there's still stuff to figure out before I send out a patch
like that. For example, we could have a sysfs file to write to to
release sync_state() for a device. Then you'd just echo to that file
in your example and go about your day.

-Saravana
