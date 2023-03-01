Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A826A6EC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCAOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCAOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:48:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67642BFA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:47:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so17509249pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk/HlwMThBunqETxCPe2T6Blz/aMuv+Os/U2E9jXhXM=;
        b=soQqJ3SjjLd36mf3UoHq/DUNkZbnRgZHPzZOt9Pt7hpQvNgYZUekw8xYnztEKu/RMB
         D22BdR16+qVedAOqXhBxsszoxS9Tq4CjVzXkGsupXz0V1d3kvWCgJaeQMz7Ec2ZtZjQM
         Pf8pY/AVpQ/660BVG3qteJpDzVW3HroKGT5Phz/6pSY2tHfWxogcqVI2g+89XHujrkSM
         ViWoMlSTkhHTKMwsytcib0bp1pWbYHSLp/owJLAP7gnAmDxBDGQXW0g92CeiW8EvVAJq
         jgkJ8xQ+UhS6mjZ/N184uCTt4sFVUMO04jl76eiPt0eF+ncHzRLGU5O+xed0urH1L3JE
         JJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk/HlwMThBunqETxCPe2T6Blz/aMuv+Os/U2E9jXhXM=;
        b=4ZQnZcWG537Q+lnWSyeoMQU0/9YiLBTgMSzWrMpWiUNTde7s0cv+opgb5rKO6sgXzK
         McsF8Py4eIjI/kTA09CxgaLiCRwjeHr5MeQIYkhsEmmYvOWuvBTgA9zI3MpdyYW/VlMZ
         xEihEayT+T2sq9VsTjY97qoZlHHLnVm6DL0RCrQ0wOHfiPi0hbYJf53hwDe9yBoGONPF
         Db8fvZetI9CmUSBLfWnC3UFctjyzmgTOqHDoZHcKL63w1qFWWzj2QKbIH6m4ZTf/si8D
         dbj1I0eCv3SeJo8nWGybqjF5rPGh5Y/kjvV/nyBLDbOjJZEApwsIwzG+r1d3/XPUA51E
         i61A==
X-Gm-Message-State: AO0yUKWr5aZypz+iR2iNnKjN8vB41BQcrYiMhQgd63vY1M+TutofFeDV
        9xa+6GbFkrhPiSnSXAdWrEvfvlp7SdlcCfARc/k93F7RLt69uw==
X-Google-Smtp-Source: AK7set9WsfEf7k5Yh75IpZFUF0UIpEfJjMLzuXJxZ7QpTfAXRJRI+nYQqGm6Tvgo9fVgSF+z+qInN5hkU/P1VuAd3dY=
X-Received: by 2002:a17:90a:ce12:b0:234:925b:7d61 with SMTP id
 f18-20020a17090ace1200b00234925b7d61mr2692127pju.9.1677682062550; Wed, 01 Mar
 2023 06:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20230215071649.9078-1-quic_mkshah@quicinc.com>
 <20230227153848.auqs4e5hf2qmwmg2@ripper> <CAD=FV=UK9zyQ=Mg3BaVCwOGBG3G7rW2pdpMFtGptR88p8ce9kg@mail.gmail.com>
 <CAPDyKFouhMbFFMHeT5vEo_LUQWVe5wKpagx8HUtDpcV7LCa4zQ@mail.gmail.com> <CAD=FV=V+fdfjUbAtvmeG43Nk=J3=Td4RSCZajrsxu8n8ykmH0w@mail.gmail.com>
In-Reply-To: <CAD=FV=V+fdfjUbAtvmeG43Nk=J3=Td4RSCZajrsxu8n8ykmH0w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Mar 2023 15:47:06 +0100
Message-ID: <CAPDyKFruXa2a83TRrpzBF7hsDi8QxOQmrwRwxSjWm_ziFF6fSA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Use PSCI OS initiated mode for sc7280
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>, swboyd@chromium.org,
        wingers@google.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com, Julius Werner <jwerner@chromium.org>
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

On Tue, 28 Feb 2023 at 16:25, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Feb 28, 2023 at 4:17=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Mon, 27 Feb 2023 at 17:10, Doug Anderson <dianders@chromium.org> wro=
te:
> > >
> > > Hi,
> > >
> > > On Mon, Feb 27, 2023 at 7:35=E2=80=AFAM Bjorn Andersson <andersson@ke=
rnel.org> wrote:
> > > >
> > > > On Wed, Feb 15, 2023 at 12:46:48PM +0530, Maulik Shah wrote:
> > > > > This change adds power-domains for cpuidle states to use PSCI OS
> > > > > initiated mode for sc7280.
> > > > >
> > > > > This change depends on external project changes [1] & [2] which a=
re under
> > > > > review/discussion to add PSCI os-initiated support in Arm Trusted=
 Firmware.
> > > > >
> > > > > I can update here once the dependency are in and change is ready =
to merge.
> > > > >
> > > >
> > > > Please do, I will drop this from the queue for now.
> > >
> > > I'm a bit confused about why we're doing this. There's always been a
> > > question about exactly why we need OSI mode. As far as I can tell it
> > > can't be for "correctness" reasons because we managed to ship sc7180
> > > without OSI mode. ...so I guess somehow the argument is that OSI mode
> > > is more performant in some cases? Are there actual numbers backing
> > > this up, or is it all theoretical? Before making such a big change, i=
t
> > > would be good to actually understand what the motivation is and see
> > > real data. This should be easy to collect since we currently have
> > > things working without OSI and (presumably) you have OSI working. It
> > > would also be good to document this motivation in the commit message
> > > and/or cover letter.
> >
> > I certainly don't object to what you say here. Although, let me also
> > share some more background to these suggested changes.
> >
> > As you know, for mobile platforms, Qcom have been using OS-initiated
> > mode for years, but on Chromium platforms that has been limited to the
> > default platform-coordinated mode. Whether that is a deliberate
> > decision for the Chromium platforms or rather because the PSCI
> > implementation in TF-A has been lacking OSI support, I don't know.
> > Maybe you have some more insight to share around this?
>
> You hit the reason exactly. Nobody on the ChromeOS team objected to
> OSI, per say, but it was never supported in ARM Trusted Firmware. I
> still don't have anything against OSI mode, but I just want to make
> sure that the data is there and that we're not just arbitrarily
> churning things. ;-)

Thanks for sharing this information! It certainly helps to better
understand the background for all of us.

>
> I think sc7180's ship has sailed at this point. While we could update
> the firmware for testing, I don't think we'd switch production sc7180
> devices over to OSI. That means that we'll always need to support PC
> mode for sc7180. Switching sc7280 over to OSI needs to be justified
> given that we'll have to continue to support sc7180 with PC mode
> anyway.

Right. Supporting both OSI and PC mode, dynamically based upon what
the PSCI firmware (TF-A) supports should work fine from Linux point of
view.

I may be overlooking something for this particular case - and in that
case, I am happy to help to fix it!

>
>
> > Note that, Wing has been working on adding support for PSCI OSI mode
> > to TF-A [1], which hopefully should land soon. In this regard, it
> > seems like we are getting closer to finally being able to run some
> > more in-depth tests, that should allow us to better compare the
> > behaviour of the PSCI CPU-suspend modes - at least on some platforms.
> > In fact, Maulik/Wing also presented their work around this topic,
> > including some results around performance/energy tests at the last
> > TF-A call [2]. I think some of that data could be shared in the commit
> > message too.
>
> Yup, I was mostly just asking for data like you provided to be in the
> commit message.

Great, thanks for confirming!

>
>
> > Kind regards
> > Uffe
> >
> > [1]
> > https://review.trustedfirmware.org/q/topic:psci-osi
> >
> > [2]
> > https://www.trustedfirmware.org/meetings/tf-a-technical-forum

Kind regards
Uffe
