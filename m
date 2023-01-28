Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC7667F4C0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjA1Elx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjA1Elt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:41:49 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6617DBCF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:41:44 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-50660e2d2ffso93382627b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sk2uvbVYmWxZx30YmA9hD6P375aPkKMFnV8oJPYyEUE=;
        b=ftR7bw3x0mcHGGqDiSMb6HSL2dkiA7QFwZUpGfCZzV0s37x8J3jC/iNgBp4oO1OOZi
         Olr/Ci62jdkirbX0fCCC54YqKwP2BCBvfndYi9SMW7bVxzyWUiTc9vPlKYzIJjRvFonR
         LLwPUcmsbQXtduywUQ6W2xMpa30ALxQCOAVRlIzdyw6cqPiyOA0cbEwxYN7xLb0paADs
         KeDHmE78vOSXupmLsAcrRr+3LHyzY+yPk98UCSL7sAb/3cpwxXuuSfKs8n0Gznmz2sj+
         apaf3Bn6X8hHOJoorNjbZS6+JAdNARekU6ah1erJn0Ynu+IIDaROKjAVBUXoFe6YlPe6
         OFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sk2uvbVYmWxZx30YmA9hD6P375aPkKMFnV8oJPYyEUE=;
        b=CYwK12FzeB1YBTIM543+eIITIq6boiouZ55uKyr2bj7hRJpDCaxVi9YS5NggTmQL50
         LeJ2T1EaDF5sFodkbDcwmxtJBhS+N+yU0FE+T70z/oc4N7psuJHe9za/Gx7hkfDhen4k
         ApD3GQ20I9xCTZs604ts95+cwWt9GcAQgMssVmwaeMCk1Nvzk8qk3N0KzyQgxoehw7/A
         egaeRqSM5PSal/Kr1YudZ2mT45eTWq2bFDOVMI0rBFuG3Hl1kzYG9tBv8NrHscwY0/LE
         32Sb83vSRpkV5117TsRY9O7X2Md4ndoy9DkvfedxiEVBIjjDrR93loD1SzpDjO0TtT15
         0s1Q==
X-Gm-Message-State: AFqh2krcQ8Sj3oT/100FcP6znzKRWTG3Wg5r62+3B0dOwdOdcHRPoZI+
        LvPjm2+BFQPv9k2caDHZyAP0IvuOL/UOVPz6aHds6P0ikGNZ2JNw
X-Google-Smtp-Source: AMrXdXvJl+3i5ra24zoyj2IqtlDmcC26Np35O8vZad9nyF+r+ClApK8YDh2ZGveHDpktG78JfDs0lG3GnuKnYNzKcUM=
X-Received: by 2002:a0d:f807:0:b0:477:b56e:e1d6 with SMTP id
 i7-20020a0df807000000b00477b56ee1d6mr5257138ywf.188.1674880903690; Fri, 27
 Jan 2023 20:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com>
 <CAGETcx8Xy5OzsbW3123esxsbQJq-SqDkP1S5g2mmwzoCz4shtQ@mail.gmail.com>
 <20230125190926.GA2697290-robh@kernel.org> <505fc434-c31f-726e-b1cb-0bbfd5f83490@linaro.org>
 <CAGETcx-f9vy7MDB2vFWP9CL26UY7W65oJArvhzksCu8QG6Y4nw@mail.gmail.com>
In-Reply-To: <CAGETcx-f9vy7MDB2vFWP9CL26UY7W65oJArvhzksCu8QG6Y4nw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 28 Jan 2023 06:41:32 +0200
Message-ID: <CAA8EJpo-mFxq+eGW=YaMxea+zi2Z64QWocuO36aNsM7Wmtu3sA@mail.gmail.com>
Subject: Re: [RESEND PATCH] of: property: do not create clocks device link for
 clock controllers
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 01:12, Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jan 26, 2023 at 2:51 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 25/01/2023 21:09, Rob Herring wrote:
> > > On Tue, Jan 24, 2023 at 06:12:15PM -0800, Saravana Kannan wrote:
> > >> On Wed, Jan 18, 2023 at 5:35 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >>>
> > >>> On Wed, Jan 18, 2023 at 3:11 AM Dmitry Baryshkov
> > >>> <dmitry.baryshkov@linaro.org> wrote:
> > >>>>
> > >>>> Do not create device link for clock controllers. Some of the clocks
> > >>>> provided to the device via OF can be the clocks that are just parents to
> > >>>> the clocks provided by this clock controller. Clock subsystem already
> > >>>> has support for handling missing clock parents correctly (clock
> > >>>> orphans). Later when the parent clock is registered, clocks get
> > >>>> populated properly.
> > >>>>
> > >>>> An example of the system where this matters is the SDM8450 MTP board
> > >>>> (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> > >>>> clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> > >>>> dispcc itself provides clocks to both PHYs, to the PHY parent device,
> > >>>> etc. With just dsi0_phy in place devlink is able to break the
> > >>>> dependency, but with two PHYs, dispcc doesn't get probed at all, thus
> > >>>> breaking display support.
> > >>>>
> > >>>> Cc: Bjorn Andersson <andersson@kernel.org>
> > >>>> Cc: Stephen Boyd <sboyd@kernel.org>
> > >>>> Cc: Saravana Kannan <saravanak@google.com>
> > >>>> Cc: Abel Vesa <abel.vesa@linaro.org>
> > >>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >>>> ---
> > >>>>
> > >>>> This patch has been posted a year ago in January 2022 ([1]). Since that time
> > >>>> Saravana failed to produce patches to assist in debugging the issue
> > >>>> ([2]) or to fix the issue ([3]). The issue we observe has been described
> > >>>> by Abel at ([4]). As we work on adding support for Dual DSI
> > >>>> configurations, the issue becomes more and more important, since binding
> > >>>> the whole display subsystem fails.
> > >>
> > >> I did send out a patch series[1] to try and fix this. Heck I even
> > >> talked about this in LPC 2022. So I don't think it's accurate to say I
> > >> didn't help debug this or fix this. There's some email thread in lore
> > >> where Abel gave more details and I figured out the issue and we didn't
> > >> need any more debugging. And then I sent out [1]. Sorry I missed you
> > >> in the cc lise for [1] -- I try to keep track of everyone to cc but
> > >> things slip through the cracks sometimes. But at the same time, it's
> > >> easy to check for emails from me before saying I didn't help or didn't
> > >> send out fixes :)
> > >>
> > >> If you do try to give [1] a shot, there are a bunch of bugs that
> > >> people pointed out for which I gave fixes on top of [1] in the
> > >> replies. I was supposed to work on v2 over the holidays, but that
> > >> didn't happen because of stuff outside my control.
> > >>
> > >>> That's ample time to fix this, so I intend to apply this. But I'll
> > >>> give it a few days for comments.
> > >>
> > >> Rob, I'd recommend not applying this because it'll fix it for Dmitry
> > >> but break someone else's use case. That's the whole reason it takes me
> > >> a while to send out patches -- it's easy to fix it for a subset of
> > >> devices, but fixing something without breaking someone else is harder
> > >> (I still believe it's doable) and it takes a while to test them on all
> > >> the devices I want to test before sending them out.
> >
> > This case is really simple, I think. Clock controllers (and
> > clock-core-framework) are prepared to handle clock orphans properly.
> > Moreover they have been supposed to work in such way for quite a while.
> > In other words, I don't think we should save them from this
> > -EPROBE_DEFERRED.
>
> A clock controller can depend on other clock controllers for non clock
> tree reasons. For example, it might need a clock ON to access its
> registers. So, while the CCF can handle orphans properly, that's not
> the only dependency. Also, fw_devlink is not just about probing
> either. It also has to do with proper sync_state() callbacks.

Just a question, please excuse if I'm misunderstanding it. Does
fw_devlink created this way also impose any runtime PM dependencies?

>
> Also, I already fixed the issue you are referring to while not
> breaking the conditions I'm referring to. So, I don't know why you are
> so opposed to that. See Abel's Tested-by here:
> https://lore.kernel.org/lkml/YvonlAwXAoXTUTZe@linaro.org/
>
> > Thus I think it is better to let them continue doing their job of
> > handling probe deferrals on their own, at least for the time being.
>
> I'm pretty sure your patch will break other Qualcomm platforms because
> they depend on sync_state() callbacks to boot up properly when
> all/most of their drivers are built as modules.

Qualcomm platforms did not use sync state for clock controllers. Only
for the icc drivers.

>
> > And
> > then, when your patches are finished, we can think about reenabling
> > current behaviour. As a reminder, currently, all Qualcomm platforms
> > trying to use double DSI configuration are broken and have to use
> > fw_devlink= kernel params.
>
> I'm/was working on sending out the v2 when I got your email. Hold
> tight please. It shouldn't take too long.

I'll give v2 a test next week, thank you!

-- 
With best wishes
Dmitry
