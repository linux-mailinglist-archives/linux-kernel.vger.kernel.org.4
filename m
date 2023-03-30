Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FDE6D0F62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjC3Tv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjC3TvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:51:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574345FE1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:51:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y19so12071113pgk.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680205881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2KkKqSokarGzXyvNEiBBLEjwsvtzgAMOVE94PKyWD4=;
        b=jblTpS57i+2qud1N3ZeARD/kLDam7ssMfSuc49oUZusL5RWH3zfQtd4ssUo5hFZ36z
         1LZx1C4T2zWor2eM4VadNdp7Ir8myhwEhm4y8N5XaOA4bqzz17DUb6OpfQTHi9blehEQ
         m84ZbM/jU5ws4652ddOnuVLHm/5pmSfUzIXsg46LqxC+i1L2M0PwrmrPc63O4EPC4YRf
         xBJS54AmX//tZynU4RmqACTh39CRIE8KhlJriX1VDr+Z6g+Ak/Q//93qktcgUxofkDln
         vzVBbN6mopaR+CZwv4mYwGQ7Nk9oar/8mia54z7qHRbghF1tQ0+Su6olQxga2OGwuAs8
         0nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680205881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2KkKqSokarGzXyvNEiBBLEjwsvtzgAMOVE94PKyWD4=;
        b=UNf94pEPH63vvZ+8CpFClEuP34YO6R+quhDllPuOkRlKM3ECiVJa9dS61kjfmtFlB7
         m/g9QIOrlb6xyYj2+v7bko4LCqAqP7a6IugBak/xvzJX1PK0/+UkxCWtYe3w7l10Crf5
         UoHDCU1JZmtiJ+IfNJIUh5r6cHCMtcqVaa9XmXM95JZcPf/QGwvrCe8ATFOoD6IHage1
         9LLYJ3CJCaglCUxaSXgOX7ssXar4wmzUPXd5IIR9888oG0utC5mSDx0FZEbbiU+R2pDv
         Gi2+ibsjDzdYNCd2qTEKTbZpAN1lrpkkEWaTcLsqj4E27Jzd6XCdQYuvHjCl3nVt7pK6
         4KIg==
X-Gm-Message-State: AAQBX9fPESk2ZmdYXVKS3ahFE//DLLZ965EkJ9EqsbFoqgXib8LeBFjg
        A8b4UUfAUsKkYE1tndGOxu50tgQKBlPUbTFYlCoxYw==
X-Google-Smtp-Source: AKy350YljZg0LAJ1pGauRJH9Ug9x1zpWp1FCNUw1cQIIYVmoHx0TjmmxrQsLPEF80/N7Q2v7bpghrRyPhMXzy8oZRjM=
X-Received: by 2002:a05:6a00:1a8b:b0:627:d4fa:6a9c with SMTP id
 e11-20020a056a001a8b00b00627d4fa6a9cmr13061941pfv.6.1680205880504; Thu, 30
 Mar 2023 12:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
 <CAGETcx9f1p2esfyzyfU04EAB1FXh=d9-U81DaGyZNjL_Vti3oQ@mail.gmail.com> <ZCVyBuKMvDV0gQPW@linaro.org>
In-Reply-To: <ZCVyBuKMvDV0gQPW@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Mar 2023 12:50:44 -0700
Message-ID: <CAGETcx-mxzzZ_FU6Agju9gMhFOEDhY6Rj78BnvAVJjNtZhif=w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Allow genpd providers to power off domains on sync state
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 4:27=E2=80=AFAM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
>
> On 23-03-27 17:17:28, Saravana Kannan wrote:
> > On Mon, Mar 27, 2023 at 12:38=E2=80=AFPM Abel Vesa <abel.vesa@linaro.or=
g> wrote:
> > >
> > > There have been already a couple of tries to make the genpd "disable
> > > unused" late initcall skip the powering off of domains that might be
> > > needed until later on (i.e. until some consumer probes). The conclusi=
on
> > > was that the provider could return -EBUSY from the power_off callback
> > > until the provider's sync state has been reached. This patch series t=
ries
> > > to provide a proof-of-concept that is working on Qualcomm platforms.
> >
> > I'm giving my thoughts in the cover letter instead of spreading it
> > around all the patches so that there's context between the comments.
> >
> > 1) Why can't all the logic in this patch series be implemented at the
> > framework level? And then allow the drivers to opt into this behavior
> > by setting the sync_state() callback.
> >
> > That way, you can land it only for QC drivers by setting up
> > sync_state() callback only for QC drivers, but actually have the same
> > code function correctly for non-QC drivers too. And then once we have
> > this functionality working properly for QC drivers for one kernel
> > version (or two), we'll just have the framework set the device's
> > driver's sync_state() if it doesn't have one already.
>
> I think Ulf has already NACK'ed that approach here:
> [1] https://lore.kernel.org/lkml/CAPDyKFon35wcQ+5kx3QZb-awN_S_q8y1Sir-G+G=
oxkCvpN=3DiiA@mail.gmail.com/

I would have NACK'ed that too because that's an incomplete fix. As I
said further below, the fix needs to be at the aggregation level where
you aggregate all the current consumer requests. In there, you need to
add in the "state at boot" input that gets cleared out after a
sync_state() call is received for that power domain.

> And suggested this new approach that this patch series proposes.
> (Unless I missunderstood his point)
>
> >
> > 2) sync_state() is not just about power on/off. It's also about the
> > power domain level. Can you handle that too please?
>
> Well, this patchset only tries to delay the disabling of unused power
> domains until all consumers have had a chance to probe. So we use sync
> state only to queue up a power-off request to make sure those unused
> ones get disabled.

Sure, but the design is completely unusable for a more complete
sync_state() behavior. I'm okay if you want to improve the
sync_state() behavior in layers, but don't do it in a way where the
current design will definitely not work for what you want to add in
the future.

> >
> > 3) In your GDSC drivers, it's not clear to me if you are preventing
> > power off until sync_state() only for GDSCs that were already on at
> > boot. So if an off-at-boot GDSC gets turned on, and then you attempt
> > to turn it off before all its consumers have probed, it'll fail to
> > power it off even though that wasn't necessary?
>
> I think we can circumvent looking at a GDSC by knowing it there was ever
> a power on request since boot. I'll try to come up with something in the
> new version.

Please no. There's nothing wrong with reading the GDSC values. Please
read them and don't turn on GDSC's that weren't on at boot.

Otherwise you are making it a hassle for the case where there is a
consumer without a driver for a GDSC that was off at boot. You are now
forcing the use of timeouts or writing to state_synced file. Those
should be absolute last resorts, but you are making that a requirement
with your current implementation. If you implement it correctly by
reading the GDSC register, things will "just work". And it's not even
hard to do.

NACK'ed until this is handled correctly.

>
> >
> > 4) The returning -EBUSY when a power off is attempted seems to be
> > quite wasteful. The framework will go through the whole sequence of
> > trying to power down, send the notifications and then fail and then
> > send the undo notifications. Combined with point (2) I think this can
> > be handled better at the aggregation level in the framework to avoid
> > even going that far into the power off sequence.
>
> Again, have a look at [1] (above).

See my reply above. If you do it properly at the framework level, this
can be done in a clean way and will work for all power domains.

-Saravana

>
> Ulf, any thoughts on this 4th point?
>
> >
> > -Saravana
> >
> > >
> > > I've been doing extensive testing on SM8450, but I've also spinned th=
is
> > > on my X13s (SC8280XP). Both patches that add the sync state callback =
to
> > > the SC8280XP and SM8450 are here to provide context. Once we agree on
> > > the form, I intend to add the sync state callback to all gdsc provide=
rs.
> > >
> > > Currently, some of the gdsc providers might not reach sync state due =
to
> > > list of consumers not probing yet (or at all). The sync state can be
> > > enforced by writing 1 to the state_synced sysfs attribute of the
> > > provider, thanks to Saravana's commit [1] which has been already merg=
ed.
> > >
> > > [1] https://lore.kernel.org/r/20230304005355.746421-3-saravanak@googl=
e.com
> > >
> > > V2 (RFC) of this patchset was here:
> > > https://lore.kernel.org/all/20230320134217.1685781-1-abel.vesa@linaro=
.org/
> > >
> > > Changes since v2:
> > >  * renamed genpd_queue_power_off_work to pm_genpd_queue_power_off and=
 added
> > >    comment about its purpose w.r.t. it being exported.
> > >  * added the qcom_cc generic sync state callback to all providers tha=
t
> > >    register GDSCs, instead of SM8450 and SC8280XP
> > >
> > > Changes since v1:
> > >  * Added the qcom_cc sync state callback which calls in turn the gdsc=
 one
> > >  * dropped extra semicolon from pm_domain.h
> > >
> > > Abel Vesa (4):
> > >   PM: domains: Allow power off queuing from providers
> > >   soc: qcom: rpmhpd: Do proper power off when state synced
> > >   clk: qcom: gdsc: Avoid actual power off until sync state
> > >   clk: qcom: Add sync state callback to all providers
> > >
> > >  drivers/base/power/domain.c            | 18 ++++++++++--------
> > >  drivers/clk/qcom/apss-ipq6018.c        |  1 +
> > >  drivers/clk/qcom/camcc-sc7180.c        |  1 +
> > >  drivers/clk/qcom/camcc-sc7280.c        |  1 +
> > >  drivers/clk/qcom/camcc-sdm845.c        |  1 +
> > >  drivers/clk/qcom/camcc-sm6350.c        |  1 +
> > >  drivers/clk/qcom/camcc-sm8250.c        |  1 +
> > >  drivers/clk/qcom/camcc-sm8450.c        |  1 +
> > >  drivers/clk/qcom/common.c              | 19 +++++++++++++++++++
> > >  drivers/clk/qcom/common.h              |  2 ++
> > >  drivers/clk/qcom/dispcc-qcm2290.c      |  1 +
> > >  drivers/clk/qcom/dispcc-sc7180.c       |  1 +
> > >  drivers/clk/qcom/dispcc-sc7280.c       |  1 +
> > >  drivers/clk/qcom/dispcc-sc8280xp.c     |  1 +
> > >  drivers/clk/qcom/dispcc-sdm845.c       |  1 +
> > >  drivers/clk/qcom/dispcc-sm6115.c       |  1 +
> > >  drivers/clk/qcom/dispcc-sm6125.c       |  1 +
> > >  drivers/clk/qcom/dispcc-sm6350.c       |  1 +
> > >  drivers/clk/qcom/dispcc-sm6375.c       |  1 +
> > >  drivers/clk/qcom/dispcc-sm8250.c       |  1 +
> > >  drivers/clk/qcom/dispcc-sm8450.c       |  1 +
> > >  drivers/clk/qcom/dispcc-sm8550.c       |  1 +
> > >  drivers/clk/qcom/gcc-apq8084.c         |  1 +
> > >  drivers/clk/qcom/gcc-ipq806x.c         |  1 +
> > >  drivers/clk/qcom/gcc-ipq8074.c         |  1 +
> > >  drivers/clk/qcom/gcc-mdm9615.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8660.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8909.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8916.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8939.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8953.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8960.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8974.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8976.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8994.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8996.c         |  1 +
> > >  drivers/clk/qcom/gcc-msm8998.c         |  1 +
> > >  drivers/clk/qcom/gcc-qcm2290.c         |  1 +
> > >  drivers/clk/qcom/gcc-qcs404.c          |  1 +
> > >  drivers/clk/qcom/gcc-qdu1000.c         |  1 +
> > >  drivers/clk/qcom/gcc-sa8775p.c         |  1 +
> > >  drivers/clk/qcom/gcc-sc7180.c          |  1 +
> > >  drivers/clk/qcom/gcc-sc7280.c          |  1 +
> > >  drivers/clk/qcom/gcc-sc8180x.c         |  1 +
> > >  drivers/clk/qcom/gcc-sc8280xp.c        |  1 +
> > >  drivers/clk/qcom/gcc-sdm660.c          |  1 +
> > >  drivers/clk/qcom/gcc-sdm845.c          |  1 +
> > >  drivers/clk/qcom/gcc-sdx55.c           |  1 +
> > >  drivers/clk/qcom/gcc-sdx65.c           |  1 +
> > >  drivers/clk/qcom/gcc-sm6115.c          |  1 +
> > >  drivers/clk/qcom/gcc-sm6125.c          |  1 +
> > >  drivers/clk/qcom/gcc-sm6350.c          |  1 +
> > >  drivers/clk/qcom/gcc-sm6375.c          |  1 +
> > >  drivers/clk/qcom/gcc-sm7150.c          |  1 +
> > >  drivers/clk/qcom/gcc-sm8150.c          |  1 +
> > >  drivers/clk/qcom/gcc-sm8250.c          |  1 +
> > >  drivers/clk/qcom/gcc-sm8350.c          |  1 +
> > >  drivers/clk/qcom/gcc-sm8450.c          |  1 +
> > >  drivers/clk/qcom/gcc-sm8550.c          |  1 +
> > >  drivers/clk/qcom/gdsc.c                | 26 ++++++++++++++++++++++++=
++
> > >  drivers/clk/qcom/gdsc.h                |  6 ++++++
> > >  drivers/clk/qcom/gpucc-msm8998.c       |  1 +
> > >  drivers/clk/qcom/gpucc-sc7180.c        |  1 +
> > >  drivers/clk/qcom/gpucc-sc7280.c        |  1 +
> > >  drivers/clk/qcom/gpucc-sc8280xp.c      |  1 +
> > >  drivers/clk/qcom/gpucc-sdm660.c        |  1 +
> > >  drivers/clk/qcom/gpucc-sdm845.c        |  1 +
> > >  drivers/clk/qcom/gpucc-sm6115.c        |  1 +
> > >  drivers/clk/qcom/gpucc-sm6125.c        |  1 +
> > >  drivers/clk/qcom/gpucc-sm6350.c        |  1 +
> > >  drivers/clk/qcom/gpucc-sm6375.c        |  1 +
> > >  drivers/clk/qcom/gpucc-sm8150.c        |  1 +
> > >  drivers/clk/qcom/gpucc-sm8250.c        |  1 +
> > >  drivers/clk/qcom/gpucc-sm8350.c        |  1 +
> > >  drivers/clk/qcom/lcc-ipq806x.c         |  1 +
> > >  drivers/clk/qcom/lpassaudiocc-sc7280.c |  1 +
> > >  drivers/clk/qcom/lpasscc-sc7280.c      |  1 +
> > >  drivers/clk/qcom/lpasscorecc-sc7180.c  |  2 ++
> > >  drivers/clk/qcom/lpasscorecc-sc7280.c  |  2 ++
> > >  drivers/clk/qcom/mmcc-apq8084.c        |  1 +
> > >  drivers/clk/qcom/mmcc-msm8974.c        |  1 +
> > >  drivers/clk/qcom/mmcc-msm8994.c        |  1 +
> > >  drivers/clk/qcom/mmcc-msm8996.c        |  1 +
> > >  drivers/clk/qcom/mmcc-msm8998.c        |  1 +
> > >  drivers/clk/qcom/mmcc-sdm660.c         |  1 +
> > >  drivers/clk/qcom/videocc-sc7180.c      |  1 +
> > >  drivers/clk/qcom/videocc-sc7280.c      |  1 +
> > >  drivers/clk/qcom/videocc-sdm845.c      |  1 +
> > >  drivers/clk/qcom/videocc-sm8150.c      |  1 +
> > >  drivers/clk/qcom/videocc-sm8250.c      |  1 +
> > >  drivers/soc/qcom/rpmhpd.c              | 19 +++++++------------
> > >  include/linux/pm_domain.h              |  4 ++++
> > >  92 files changed, 161 insertions(+), 20 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
