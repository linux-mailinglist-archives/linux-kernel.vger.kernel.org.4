Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E078A717078
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjE3WMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjE3WMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:12:06 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BF710D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:12:03 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-561b7729a12so4608767b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685484723; x=1688076723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoikQ24IRuw8V1bI3fB4AXs6Vt9clGgETJMS8PTWY9M=;
        b=JBzFXe43yEA4MwmyXbJnIuAFPI8KpiMlBqNMHsO2FeR3Ft/gGq5DHeLD42vmi46CAJ
         NYA371x5lbnH8TageYKekHMJ4vBUs7x5f3obZBjAcII13fdnYV0x95rbqC3imJXNooFe
         M5oSATtvlNl/LPUEliC12Pv7NOHRg3N8Ktnlmls9oO+DxJTz9UqRoZKn7A/Idv8nKChW
         0+mo6XuvAy9YIMD7nmuUEuuF1mQ3gKa/WbguOrsPmKbwsALuvEEKUocdrIxrY0WkphFa
         PBSTmnYCJRxAlW9ZjMQAJ8dtojYQRnLQPUl3ORTRC8GTK6Ia+4t9CSxbw+Lqw21S8+/4
         /rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685484723; x=1688076723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZoikQ24IRuw8V1bI3fB4AXs6Vt9clGgETJMS8PTWY9M=;
        b=K9SUnVJUu8K3+YrkGJJF3UyICh45EhkmhD27/CEpSAsDZi5gHJ6GdB4MK1swCm/KIZ
         0Nzwy0ldTDe/Fd2k2NzvMv6w6IBZPM4+6mNcjE4ogryys7j9kQ+7uNDL8oIluGlnCtfN
         GiAVwpytUvDd9YZZS6vkIhgB+yCfRb2MyC+Mf/4wAUs41yLS4XaHrqN7yxZy/jnwjDVP
         rQT1fYhY1yunNZfQ7nqq46xtwTzVCD2vlwOHFdl9+2i8E7vZ1IA2Z7obiz7M/kdIeUDO
         Zr6LpNMEv0bXKJjMI/bSR5uxdo1yalsM7A507RBKCA8edatg8Yr6MfKpUi05IMIx/xWZ
         kZDA==
X-Gm-Message-State: AC+VfDx+BZQ64xtCeKJOYGemFO5H+JdFnmNHe+6+aqdPissnEp+wsOli
        UQ2glCbp+BkOAI+DNKVBkDOxQjvDS/PNpdWvxlUXkA==
X-Google-Smtp-Source: ACHHUZ51M7z6vLdDuU6YnJV8hHa71g3G6VR7IR1jzPsgmFsx8wxq7CUQyYcHGRFbiY1FORhFgrlnHoQ+C4gsvM2GB1A=
X-Received: by 2002:a05:690c:80d:b0:565:85b0:c128 with SMTP id
 bx13-20020a05690c080d00b0056585b0c128mr14929653ywb.6.1685484723087; Tue, 30
 May 2023 15:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230424110933.3908-1-quic_mkshah@quicinc.com>
 <CAPDyKFqSY9HJgKwuOqJPU5aA=wcAtDp91s0hkQye+dm=Wk=YDQ@mail.gmail.com>
 <20230525024546.ug6nbrmkgx2alerc@ripper> <CAPDyKFrzHHz+c_y787TVKLGizA3vVfKvnu+uJ1JC+itgryfdSQ@mail.gmail.com>
 <20230529160848.ujthfuuj3zblkq4b@ripper>
In-Reply-To: <20230529160848.ujthfuuj3zblkq4b@ripper>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 May 2023 00:11:26 +0200
Message-ID: <CAPDyKFo1rsm5gk_eKESa_WMFn6bSicH1UV1vJ7CU_64jZ5Uj-Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Use PSCI OS initiated mode for sc7280
To:     Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Maulik Shah <quic_mkshah@quicinc.com>, dianders@chromium.org,
        swboyd@chromium.org, wingers@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rafael

On Mon, 29 May 2023 at 18:05, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Mon, May 29, 2023 at 10:58:23AM +0200, Ulf Hansson wrote:
> > On Thu, 25 May 2023 at 04:41, Bjorn Andersson <andersson@kernel.org> wrote:
> > >
> > > On Wed, May 24, 2023 at 11:56:28AM +0200, Ulf Hansson wrote:
> > > > On Mon, 24 Apr 2023 at 13:09, Maulik Shah <quic_mkshah@quicinc.com> wrote:
> > > > >
> > > > > Changes in v4:
> > > > > - Add missing s-o-b line and reviewed by in patch 1
> > > > > - Address ulf's comments for error handling in patch 2
> > > > >
> > > > > Changes in v3:
> > > > > - Add new change to provide helper function dt_idle_pd_remove_topology()
> > > > > - Address ulf's comments for error handling
> > > > > - Add reviewed by ulf for devicetree change
> > > > >
> > > > > Changes in v2:
> > > > > - Add new change to Move enabling OSI mode after power domains creation
> > > > > - Fix compatible string to domains-idle-states for cluster idle state.
> > > > > - Update cover letter with some more details on OSI and PC mode
> > > > >   comparision
> > > > >
> > > > > The dependency [2] is now merged in trustedfirmware project.
> > > > >
> > > > > Stats comparision between OSI and PC mode are captured at [3] with
> > > > > usecase
> > > > > details, where during multiple CPUs online the residency in cluster idle
> > > > > state is better with OSI and also inline with single CPU mode. In PC
> > > > > mode
> > > > > with multiple CPUs cluster idle state residency is dropping compare to
> > > > > single CPU mode.
> > > > >
> > > > > Recording of this meeting is also available at [4].
> > > > >
> > > > > This change adds power-domains for cpuidle states to use PSCI OS
> > > > > initiated mode for sc7280.
> > > > >
> > > > > This change depends on external project changes [1] & [2] which are
> > > > > under review/discussion to add PSCI os-initiated support in Arm Trusted
> > > > > Firmware.
> > > > >
> > > > > I can update here once the dependency are in and change is ready to
> > > > > merge.
> > > > >
> > > > > [1] https://review.trustedfirmware.org/q/topic:psci-osi
> > > > > [2] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/19487
> > > > > [3] https://www.trustedfirmware.org/docs/PSCI-OS-initiated.pdf
> > > > > [4] https://www.trustedfirmware.org/meetings/tf-a-technical-forum
> > > > >
> > > > > Maulik Shah (3):
> > > > >   cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
> > > > >   cpuidle: psci: Move enabling OSI mode after power domains creation
> > > > >   arm64: dts: qcom: sc7280: Add power-domains for cpuidle states
> > > > >
> > > > >  arch/arm64/boot/dts/qcom/sc7280.dtsi  | 98 ++++++++++++++++++++-------
> > > > >  drivers/cpuidle/cpuidle-psci-domain.c | 39 ++++-------
> > > > >  drivers/cpuidle/dt_idle_genpd.c       | 24 +++++++
> > > > >  drivers/cpuidle/dt_idle_genpd.h       |  7 ++
> > > > >  4 files changed, 117 insertions(+), 51 deletions(-)
> > > > >
> > > >
> > > > Looks like this series has not been queued up yet. Note that patch1
> > > > and patch2 are needed for stable kernels too. Moreover, patch3 (Qcom
> > > > DTS change) is dependent on patch 1 and patch2.
> > > >
> > > > Therefore I suggest Bjorn to pick this up via the Qcom SoC tree.
> > > > Bjorn, is that okay for you?
> > > >
> > >
> > > Sorry, this fell between the chairs after you pointed me to it...
> > >
> > > I can certainly pick the 3 patches through my tree, but are they fixing
> > > any current regressions, or is it just that we need the first two
> > > patches to land before the 3rd patch?
> >
> > I am not aware of any current regressions.
> >
>
> Okay, that confirms my understanding. So not -rc material.
>
> > >
> > > I also presume the 3rd patch is only needed when paired with the new
> > > ATF?
> >
> > Patch3 is beneficial to use with a new TF-A, but works with an old
> > TF-A too. Anyway, forget what I said about patch3 earlier, as that was
> > just not the complete information.
> >
> > The problem is that we can't be using a new TF-A (supporting both PSCI
> > OSI and PC mode) without patch1 and patch2, unless we are using
> > patch3.
> >
> > Thus, I strongly suggest we tag patch1 and patch2 for stable kernels,
> > to avoid any potential conflicts of TF-A versions that may be used.
> >
>
> So you're suggesting that I pick them for v6.5 and add a Cc: stable?
>
> An alternative would be that you take the cpuidle patches for v6.4-rc
> and I pick the dt for v6.5 - given that the cpuidle patches actually
> resolves a problem, while the dts just introduces "new functionality".

Right, that's probably the best option. Although I don't have a tree
to take these patches through, let's ask Rafael if he can help with
this.

Rafael, can you pick patch 1 and patch 2 from $subject series for
v6.4-rc and tag them for stable? Then Bjorn can pick patch3 for v6.5.

Kind regards
Uffe
