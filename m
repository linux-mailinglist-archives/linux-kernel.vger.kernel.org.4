Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144766A58EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjB1MRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjB1MRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:17:06 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA7B265B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:17:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a7so5552735pfx.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GDuRJNzB+FPcvVYxqkY8xWG29BxTJ0LYww4+9WZDNQ=;
        b=soqfTf0BnDTlVqBS8PWubPPOErtzCuWTAhtUflMLeGsAwLCOiFJt2JfqTvKIxOM3mH
         hunFX4sA33gFFTDEIdqgguK/u0KO1Un4HngqcYY0BcZT1NTr4pX0NaoA0LbhMtWJt+6V
         MF0wi3aEpMYts+YAkCyLDeC2sFA6kJMYbUDwTKXrikxPmjYusFFduGHJQXibcfIYqBDQ
         sbc820S7+Eq/o7is52t5mBVX2eVYfG5e3YrnScGWsABEeVo7XWQXgUukZbT9mKeJnuRm
         n3uXAZKEOo0FXay+dPkGKxGkl2S3dFcq+OyF90OqUCYqR84IDYId7YuCrvGz+TOwr4x+
         9Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GDuRJNzB+FPcvVYxqkY8xWG29BxTJ0LYww4+9WZDNQ=;
        b=2JOzGvCIEeOA+qFPdfvu2ATdVamM9iB1R7yeSxtV0h8AaAbbNssFsUZcDN67Abp1Rt
         39PB5tq3/e06Ka//VqPSfWf2XMedYD6JPM6YMQT6oGAmGCb6WxRTnGD3txDlNB+yJNMk
         WmZKuE7CRGxj/tgqXXWUdUUbb+UfYM/EZt36VYthWSTntC59ZsvOvV9nd/dKDdvXQhV4
         33js6MUhfPBwMtD+C9YJxe/V86qMJmWab9XFODOnZy0uaZoHpjfbrlvQ9rLiip+bYWCY
         sovGV1n1jlX3TK3gnJJeqtWbhAjbOaFYFR0yh5MgnUMIfw9Tp6+TBfJklyWpdFBlzqDi
         j3/g==
X-Gm-Message-State: AO0yUKXc0H378Vsu1667QkJIee6Y9B1NHcv5mfhf9lX0mRef4r2zNxOq
        kfg5LHBrR2kmXW8ubXiFoR/Bji9rqtvw1zcw+6/JuA==
X-Google-Smtp-Source: AK7set/fnigsJgTfH/ZX7+1djP388HDAukz4aDVxJDWE3QImQwXnbumtvaLPAQmZUFw1jxD4pZyjtzAtg/JmKuRJ2Ps=
X-Received: by 2002:a05:6a00:26eb:b0:5de:ece4:2674 with SMTP id
 p43-20020a056a0026eb00b005deece42674mr875574pfw.3.1677586624954; Tue, 28 Feb
 2023 04:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20230215071649.9078-1-quic_mkshah@quicinc.com>
 <20230227153848.auqs4e5hf2qmwmg2@ripper> <CAD=FV=UK9zyQ=Mg3BaVCwOGBG3G7rW2pdpMFtGptR88p8ce9kg@mail.gmail.com>
In-Reply-To: <CAD=FV=UK9zyQ=Mg3BaVCwOGBG3G7rW2pdpMFtGptR88p8ce9kg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Feb 2023 13:16:28 +0100
Message-ID: <CAPDyKFouhMbFFMHeT5vEo_LUQWVe5wKpagx8HUtDpcV7LCa4zQ@mail.gmail.com>
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

On Mon, 27 Feb 2023 at 17:10, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Feb 27, 2023 at 7:35=E2=80=AFAM Bjorn Andersson <andersson@kernel=
.org> wrote:
> >
> > On Wed, Feb 15, 2023 at 12:46:48PM +0530, Maulik Shah wrote:
> > > This change adds power-domains for cpuidle states to use PSCI OS
> > > initiated mode for sc7280.
> > >
> > > This change depends on external project changes [1] & [2] which are u=
nder
> > > review/discussion to add PSCI os-initiated support in Arm Trusted Fir=
mware.
> > >
> > > I can update here once the dependency are in and change is ready to m=
erge.
> > >
> >
> > Please do, I will drop this from the queue for now.
>
> I'm a bit confused about why we're doing this. There's always been a
> question about exactly why we need OSI mode. As far as I can tell it
> can't be for "correctness" reasons because we managed to ship sc7180
> without OSI mode. ...so I guess somehow the argument is that OSI mode
> is more performant in some cases? Are there actual numbers backing
> this up, or is it all theoretical? Before making such a big change, it
> would be good to actually understand what the motivation is and see
> real data. This should be easy to collect since we currently have
> things working without OSI and (presumably) you have OSI working. It
> would also be good to document this motivation in the commit message
> and/or cover letter.

I certainly don't object to what you say here. Although, let me also
share some more background to these suggested changes.

As you know, for mobile platforms, Qcom have been using OS-initiated
mode for years, but on Chromium platforms that has been limited to the
default platform-coordinated mode. Whether that is a deliberate
decision for the Chromium platforms or rather because the PSCI
implementation in TF-A has been lacking OSI support, I don't know.
Maybe you have some more insight to share around this?

Note that, Wing has been working on adding support for PSCI OSI mode
to TF-A [1], which hopefully should land soon. In this regard, it
seems like we are getting closer to finally being able to run some
more in-depth tests, that should allow us to better compare the
behaviour of the PSCI CPU-suspend modes - at least on some platforms.
In fact, Maulik/Wing also presented their work around this topic,
including some results around performance/energy tests at the last
TF-A call [2]. I think some of that data could be shared in the commit
message too.

Kind regards
Uffe

[1]
https://review.trustedfirmware.org/q/topic:psci-osi

[2]
https://www.trustedfirmware.org/meetings/tf-a-technical-forum
