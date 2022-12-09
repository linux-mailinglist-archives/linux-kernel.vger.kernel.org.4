Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB726487D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLIRhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiLIRg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:36:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D9982FA2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:36:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so8855492pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qXsbmkoodLU/AwJjQ4JXkNGpOiLYdE4+WQE1E7o+Bwo=;
        b=t86EOBMhIP/ldR8nxcwebrMd9ocR8tExby0yg2pG8hDVAeplTlpkAB6UlHdjUGL2b5
         OQ8Ls6Okk6+BnUPMmDzTmJqEM8BRuNIHYChWzI/RnpKmNMT3ipirfQ/ZKwIDn+n9H+Ac
         dFa1a+3eO+2Sw6svqf5F6CPOssBlL7/HJcVRRKRV6zreayrpLDquE0Zg8Jcfyxo/Y4pg
         CjscTZcU+4ZQQmGN89+YHXMn6iH0H9Ihsfug23tfhKLS0dOfdg/fgggBFiLKd7soUUc3
         KivDhsoDilYjezLZhtQUMnYVSn2EnUpu+jrvaa46iK29QVFbKVNkTS58yaBOx42Nd/w5
         oyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXsbmkoodLU/AwJjQ4JXkNGpOiLYdE4+WQE1E7o+Bwo=;
        b=KbwsGaIgV2em7yPTul4xza7l6Xysx0fHrqNPr1yfZTy9yar91r44aDcUlVUOr598ER
         rc5GvLAChZ3V5AtJp41E8IxTjfbSDrYP/Rf4OQVIbjn5uBJBeNWilFSy2XF6a17kK87P
         qTzKO34CFV9U5ISvAw6ehx/XffciDbJxDaHL/V2P1CyiOhF85vPZZXPsYorqHdxjz7jt
         A5IB5sOWBxPd+o/s2PHnJD2Wqne34ryMjWfln5ZTYs03+HiMGxyYDVujRevjDHz3pqrY
         G7LMEcLoHH6fo2S6jUgTn4peuJmAnJnT9/4D0qA7pOQnrq0m84uAwURpe0njfY70Xdc6
         M/WQ==
X-Gm-Message-State: ANoB5pkgtsvTWqLbaP5QhzdlcScRxBICRnOu5hnccB/AGukEWqLH68pq
        rBiuhHltaKw95W+j0kRlScfz8zeMzem8JZA5MTe89w==
X-Google-Smtp-Source: AA0mqf7ateMtxBRPd0IFutE2MIFyHz0rRGBmqts6dBrsLB2FgXxkLDLjQoTz8MBCRkUTjg8zk1rHSrEfMZ8gVlOEGUM=
X-Received: by 2002:a17:90a:7485:b0:219:ef02:a5eb with SMTP id
 p5-20020a17090a748500b00219ef02a5ebmr15259474pjk.84.1670607414431; Fri, 09
 Dec 2022 09:36:54 -0800 (PST)
MIME-Version: 1.0
References: <1664960824-20951-1-git-send-email-quic_akhilpo@quicinc.com>
 <20221201225705.46r2m35ketvzipox@builder.lan> <CAPDyKFofsqcoFbYt-9BcisbPdreLGqAAMWorqHi0_D1kwCdYhg@mail.gmail.com>
 <20221207165457.kwdwwiycbwjpogxl@builder.lan> <CAPDyKFpYgYkDdJ79xxkwr-Mqnj5CoBrV+ZZe6Xz4hGLNR4zUVw@mail.gmail.com>
 <20221208210622.x656vbf7rum5hrl7@builder.lan>
In-Reply-To: <20221208210622.x656vbf7rum5hrl7@builder.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Dec 2022 18:36:18 +0100
Message-ID: <CAPDyKFpSXjcJZ=H491s74BChAV89pQ1Wm8PSdU0nVRfroK1=4A@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] clk/qcom: Support gdsc collapse polling using
 'reset' interface
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        krzysztof.kozlowski@linaro.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2022 at 22:06, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Thu, Dec 08, 2022 at 02:40:55PM +0100, Ulf Hansson wrote:
> > On Wed, 7 Dec 2022 at 17:55, Bjorn Andersson <andersson@kernel.org> wrote:
> > >
> > > On Wed, Dec 07, 2022 at 05:00:51PM +0100, Ulf Hansson wrote:
> > > > On Thu, 1 Dec 2022 at 23:57, Bjorn Andersson <andersson@kernel.org> wrote:
> > > > >
> > > > > On Wed, Oct 05, 2022 at 02:36:58PM +0530, Akhil P Oommen wrote:
> > > > > >
> > > > >
> > > > > @Ulf, Akhil has a power-domain for a piece of hardware which may be
> > > > > voted active by multiple different subsystems (co-processors/execution
> > > > > contexts) in the system.
> > > > >
> > > > > As such, during the powering down sequence we don't wait for the
> > > > > power-domain to turn off. But in the event of an error, the recovery
> > > > > mechanism relies on waiting for the hardware to settle in a powered off
> > > > > state.
> > > > >
> > > > > The proposal here is to use the reset framework to wait for this state
> > > > > to be reached, before continuing with the recovery mechanism in the
> > > > > client driver.
> > > >
> > > > I tried to review the series (see my other replies), but I am not sure
> > > > I fully understand the consumer part.
> > > >
> > > > More exactly, when and who is going to pull the reset and at what point?
> > > >
> > > > >
> > > > > Given our other discussions on quirky behavior, do you have any
> > > > > input/suggestions on this?
> > > > >
> > > > > > Some clients like adreno gpu driver would like to ensure that its gdsc
> > > > > > is collapsed at hardware during a gpu reset sequence. This is because it
> > > > > > has a votable gdsc which could be ON due to a vote from another subsystem
> > > > > > like tz, hyp etc or due to an internal hardware signal. To allow
> > > > > > this, gpucc driver can expose an interface to the client driver using
> > > > > > reset framework. Using this the client driver can trigger a polling within
> > > > > > the gdsc driver.
> > > > >
> > > > > @Akhil, this description is fairly generic. As we've reached the state
> > > > > where the hardware has settled and we return to the client, what
> > > > > prevents it from being powered up again?
> > > > >
> > > > > Or is it simply a question of it hitting the powered-off state, not
> > > > > necessarily staying there?
> > > >
> > > > Okay, so it's indeed the GPU driver that is going to assert/de-assert
> > > > the reset at some point. Right?
> > > >
> > > > That seems like a reasonable approach to me, even if it's a bit
> > > > unclear under what conditions that could happen.
> > > >
> > >
> > > Generally the disable-path of the power-domain does not check that the
> > > power-domain is actually turned off, because the status might indicate
> > > that the hardware is voting for the power-domain to be on.
> >
> > Is there a good reason why the HW needs to vote too, when the GPU
> > driver is already in control?
> >
> > Or perhaps that depends on the running use case?
> >
> > >
> > > As part of the recovery of the GPU after some fatal fault, the GPU
> > > driver does something which will cause the hardware votes for the
> > > power-domain to be let go, and then the driver does pm_runtime_put().
> >
> > Okay. That "something", sounds like a device specific setting for the
> > corresponding gdsc, right?
> >
> > So somehow the GPU driver needs to manage that setting, right?
> >
> > >
> > > But in this case the GPU driver wants to ensure that the power-domain is
> > > actually powered down, before it does pm_runtime_get() again. To ensure
> > > that the hardware lost its state...
> >
> > I see.
> >
> > >
> > > The proposal here is to use a reset to reach into the power-domain
> > > provider and wait for the hardware to be turned off, before the GPU
> > > driver attempts turning the power-domain on again.
> > >
> > >
> > > In other words, there is no reset. This is a hack to make a normally
> > > asynchronous pd.power_off() to be synchronous in this particular case.
> >
> > Alright, assuming I understood your clarifications above correctly
> > (thanks!), I think I have got a much better picture now.
> >
> > Rather than abusing the reset interface, I think we should manage this
> > through the genpd's power on/off notifiers (GENPD_NOTIFY_OFF). The GPU
> > driver should register its corresponding device for them
> > (dev_pm_genpd_add_notifier()).
> >
> > The trick however, is to make the behaviour of the power-domain for
> > the gdsc (the genpd->power_off() callback) conditional on whether the
> > HW is configured to vote or not. If the HW can vote, it should not
> > poll for the state - and vice versa when the HW can't vote.
> >
>
> Per Akhil's description I misunderstood who the other voters are; but
> either way it's not the same "HW configured" mechanism as the one we're
> already discussing.

Okay, so this is another thing then.

>
>
> But if we based on similar means could control if the power_off() ops
> should be blocking, waiting for the status indication to show that the
> hardware is indeed powered down, I think this would meet the needs.

Right.

>
> And GENPD_NOTIFY_OFF seems to provide the notification that it was
> successful (i.e. happened within the timeout etc).
>
> > Would this work?
> >
>
> If we can control the behavior of the genpd, I think it would.

Okay, it seems like we need a new dev_pm_genpd_* interface that
consumers can call to instruct the genpd provider, that its
->power_off() callback needs to temporarily switch to become
synchronous.

I guess this could be useful for other similar cases too, where the
corresponding PM domain isn't actually being powered off, but rather
just voted for to become powered off, thus relying on the HW to do the
aggregation.

In any case, I am still a bit skeptical of the reset approach, as is
being suggested in the $subject series. Even if it's rather nice and
clean (but somewhat abusing the interface), it looks like there will
be synchronization problems between the calls to the
pm_runtime_put_sync() and reset_control_reset() in the GPU driver. The
"reset" may actually already have happened when the call to
reset_control_reset() is done, so we may fail to detect the power
collapse, right!?

Let me cook a patch for the new genpd interface that I have in mind,
then we can see how that plays out together with the other parts. I
will post it on Monday!

Kind regards
Uffe
