Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9838473A15E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjFVNC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFVNCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:02:21 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5AE10F8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:02:20 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so6641544276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687438940; x=1690030940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DB8d3i9SZQpXK0PITMgG0UJJzhOSPFuZ3siR9gFiirA=;
        b=JWBLnoCtCGGkUB5i3V5+Wp2c/eM/NkHwaXmiWFfU6SayL+A0epgO0ueS70jSxYr/nf
         IGwIj9yCsfOqcbMd/s+60X0yXmoW+vfBp2HvF9eWw8z/lOxE6DBtgx0dRSqteKXcdMgV
         VhUREva8+tHxkRYQPCHu6Qdb8Xbj5zVLFt8vF6mZuKJXflEkrAhv6TxwD7z8R3G6RMB3
         E3DtBDtPs3MUfBKyryQra6d/agKDhXRd8Ysury1JEWXh/03XYfR8d0k5IXRXM+11nZ5q
         7oW+g+vezHgxos3gCKh5/zg8g3mOnoFoqeY/VghkRUXkwAwpL1ycTGONEOdtEFR90+M3
         MzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687438940; x=1690030940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DB8d3i9SZQpXK0PITMgG0UJJzhOSPFuZ3siR9gFiirA=;
        b=aJoVLFyKsbzHEHJAp9+OCMjRQPaxR0Ydf6l731R41MqNhWqCFhdYjV9IToFBAxuq+Z
         vHTMmOZ4M1QKzBT8wnDXdmEp//eg992kdLZCLk0XOH5dMr/9SHHbyd/veGkT85u1p0mF
         EIYQEudc4YI3g2mP/DZ0lEDwIhx5yeajLA0EndvYh074sia0XuLX3iVn7fBbW3UTeD9g
         WJwt/wK7YqhpN0myF5CpwzzugOLm+GKu8SeyAanCTo+EhgTSGpFcCLdpH8lNb6NetzRb
         cxLXeWLOKYA7e7o7rCXAvPFYhUzUGwP78SG5YZaDMH/H8A2uVoygod1pucRoiXKKh/Pd
         SP4Q==
X-Gm-Message-State: AC+VfDxG/2eMqCjLC/9XD207UvVbaZM6lzmDev4WEBTgENWhnCpPBJbc
        X2Mcg+UFW91z67AE/tx1TicXCZt07k45TiRCc2lSHg==
X-Google-Smtp-Source: ACHHUZ4ChvoACcCJQotbXKQBZUwe/sEs7gSKFAkswWcZVLaKUoJZrYTOIXV9DhFPqKFims2TUNOSo1U3L5+94nmtzwg=
X-Received: by 2002:a25:185:0:b0:be7:dee3:1fed with SMTP id
 127-20020a250185000000b00be7dee31fedmr14146499ybb.65.1687438936863; Thu, 22
 Jun 2023 06:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <CAPDyKFqhVkMH42Vz0+a62j5kFh+R_CvGrcSU7hxoW__tjOhfLw@mail.gmail.com>
 <443b00b1-76b8-c31d-53d3-42e3592d26e8@quicinc.com> <CAPDyKFp5L454WmTPo2eYnBuZ=ZMKEtinLgYU09n=J=3DA1FSJQ@mail.gmail.com>
 <29ccc60e-9ef8-883f-9936-95e6ef842746@quicinc.com>
In-Reply-To: <29ccc60e-9ef8-883f-9936-95e6ef842746@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Jun 2023 15:01:40 +0200
Message-ID: <CAPDyKFqKw-6Qu7YoZw9LQDGvj1PFi3nCDkXcmCJTffxtX75naQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add provision to keep idle state disabled
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com,
        quic_mkshah@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 at 08:21, Tushar Nimkar <quic_tnimkar@quicinc.com> wrote:
>
> Many thanks again,
>
> On 6/16/2023 4:25 PM, Ulf Hansson wrote:
> > On Wed, 14 Jun 2023 at 08:43, Tushar Nimkar <quic_tnimkar@quicinc.com> wrote:
>
> >
> > Right. I am not saying it's the perfect solution, but it seems like it
> > could potentially solve the problem for many cases.
> >
> > If you want some help to turn the cpuidle-psci driver into a loadable
> > module, just reach out, I am happy to help.
> >
> Thanks :)

Np!

> Making cpuidle-psci as loadable does not hold good for target does not
> support DLKM, in addition to it rpmh driver has dependency on
> cpuidle-psci for pm-domain and rpmh probe will get defer, their are
> driver which depends on rpmh probe like interconnect, clk etc. And
> eventually dependent driver probe defers which are essential for Linux
> boot-up.
> Hope you got scenario for getting probe defer if we make cpuidle-psci as
> loadable.

I understand your concern, but you have got my idea wrong.

I was suggesting turning the cpuidle-psci driver into a loadable
module - not the cpuidle-psci-domain driver. The latter is the genpd
provider, which consumers like rpmh need to probe.

>
> I have below options as well
> [A]: Can we think of making "governor/param_governor"
> module_param_string, string named governor only to load. In that way
> need to remove check [3]. Let's say string passed as "teo" then it will
> not load "menu" and loads "teo" once comes-up.
>
> [B]: Can we think of making cpuidle.off as writable, let governors to
> register (i.e remove check [4]) and allow cpuidle_init() to happen (i.e
> remove check [5])
> So in this way cpuidle.off=1, your idle state can not be selected
> because [6] and later we can write off=0 to let same check [6] to fail.
>
> [C]: Coming to this series approach...What is best way to utilize
> already present Flag-CPUIDLE_FLAG_OFF ?
> Since we can not add new DT property to take decision in driver as it's
> not HW feature to be expose in device tree [7]. Can we introduce new
> module_param() for making idle-state disable default and utilize
> CPUIDLE_FLAG_OFF? maybe similar to [8]
>
> happy to hear your thoughts!

In general I am not in favor of module parameters, but maybe it's the
best option to solve this problem. We need Rafael's and Daniel's
opinion to conclude.

However, to me, I still think the easiest approach would be to turn
the cpuidle-psci driver into a loadable module. Let me hack on that
and post a few patches that you can test for this.

>
>
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpuidle/governor.c?h=next-20230620#n93
>
> [4]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpuidle/governor.c?h=next-20230620#n86
>
> [5]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpuidle/cpuidle.c?h=next-20230620#n808
>
> [6]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/kernel/sched/idle.c?h=next-20230620#n167
>
> [7]
> https://lore.kernel.org/lkml/20230608085544.16211-1-quic_tnimkar@quicinc.com/T/#m5d6012b0dfcff700f48c0efbba629382f18ee33b
>
> [8]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/idle/intel_idle.c?h=next-20230620#n2160
> > [...]
> >

Kind regards
Uffe
