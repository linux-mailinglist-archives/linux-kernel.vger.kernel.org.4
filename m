Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2906A88F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCBTFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCBTFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:05:32 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD2355065
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:05:07 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 82so4553857ybn.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 11:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ysHfbJ97vMBV5FeNUYC1fvIuo5+8HIV1nyu+fIHIKk=;
        b=KJ9idneEZX/ITvWSxQDU5xFEQ2xtqNs1kxFTIvJKr3vkFyaKzYtHphu/NEfnaVbjGt
         egdqL1ir6HNBsKQzsQ5Kj7hmS6hEvVRfhm8jMvzdslN/YdMkt4anzmb3mavIuksiqYHW
         KpNbPc7Lc6yJKcpJ4vr9u854tCRkXjGxWyyifL1YCMzKzj3Ge6BUDaAEHvwRDd8lMagM
         CWSKlsif8Xi79ud7DstGOfaOPf1l1izwlyS6AB6mf+Z9Zo/rpjNe7mmNjNJ3It2zu1W+
         STBwHy8NFCui/ez2L/WYJ2kE47Hc902jMIyfdL9nStru9HSLXVjXTVLqLnJQXcQVadUU
         OjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ysHfbJ97vMBV5FeNUYC1fvIuo5+8HIV1nyu+fIHIKk=;
        b=kYQUBdGx67lIJCZZRImqCuB9uAg0g+6+KB7UF0agm+zhym1NV5l7d1Kt1SNBqmkVqT
         YTod8xjjrFrSszZHWKDP+k80RcjE/98WsbqwZRfauGoOQWsRa0iMgncBf+zZ+mkrZJWI
         qHyKFg/WhFBC4WO9apAtEnHhfEIe4mRY8gk1gkHGFDcbxwcrL7AJCxsUGSIKOJhrSDXi
         D+9n1vVgGctPgmQzujLLRym/JzButsVumnoLabbFEZdj/KqEE9YPbX6TPZUQYhzSn6Hg
         kFMeNdwj0lzYdzqbWxk520T0bzMX0du4R7Jxh2j8P4npm2fAuhsauKgLIirnrSY5Y9pS
         7jUQ==
X-Gm-Message-State: AO0yUKUJJi7nLwmFCCR0cYmR26sfse/4Y1TCKHM+5kNlm5j/WI4wKHHb
        4VRX+HtADdFN3rsh5FLtK63CpU7uvsNA1R4LMFTVsw==
X-Google-Smtp-Source: AK7set8d0FD8rtP+Lh3tGHIqRGLrxa4Zq1pePiy64LsjPezypYWt7F2MwLhdoCZOVWiYf54e7DQaQduSlbAkNiz1xrc=
X-Received: by 2002:a5b:211:0:b0:91d:98cd:bfe4 with SMTP id
 z17-20020a5b0211000000b0091d98cdbfe4mr6063002ybl.10.1677783906198; Thu, 02
 Mar 2023 11:05:06 -0800 (PST)
MIME-Version: 1.0
References: <1677629817-18891-1-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJpquZAhn+HswNxardN1fE8Zu1CKrCU5EiX=B8mGWuxfWnQ@mail.gmail.com>
 <38bf75b4-799a-9758-aae3-69a7e0fc3f58@quicinc.com> <86787af0-aa95-a2d8-d68c-555be54a3784@linaro.org>
 <dddd3f2f-28e7-2188-5498-399cdb75adb4@quicinc.com>
In-Reply-To: <dddd3f2f-28e7-2188-5498-399cdb75adb4@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Mar 2023 21:04:55 +0200
Message-ID: <CAA8EJpokgWnRZ6rvNtsY4=WVcQv-5bCPYRE+dTqcWjbgzO-bxw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: check core_initialized flag at both
 host_init() and host_deinit()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@gmail.com, agross@kernel.org, andersson@kernel.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 2 Mar 2023 at 20:41, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 3/1/2023 1:15 PM, Dmitry Baryshkov wrote:
> > On 01/03/2023 18:57, Kuogee Hsieh wrote:
> >>
> >> On 2/28/2023 6:16 PM, Dmitry Baryshkov wrote:
> >>> On Wed, 1 Mar 2023 at 02:17, Kuogee Hsieh <quic_khsieh@quicinc.com>
> >>> wrote:
> >>>> There is a reboot/suspend test case where system suspend is forced
> >>>> during system booting up. Since dp_display_host_init() of external
> >>>> DP is executed at hpd thread context, this test case may created a
> >>>> scenario that dp_display_host_deinit() from pm_suspend() run before
> >>>> dp_display_host_init() if hpd thread has no chance to run during
> >>>> booting up while suspend request command was issued. At this scenario
> >>>> system will crash at aux register access at dp_display_host_deinit()
> >>>> since aux clock had not yet been enabled by dp_display_host_init().
> >>>> Therefore we have to ensure aux clock enabled by checking
> >>>> core_initialized flag before access aux registers at pm_suspend.
> >>> Can a call to dp_display_host_init() be moved from
> >>> dp_display_config_hpd() to dp_display_bind()?
> >>
> >> yes,  Sankeerth's  "drm/msm/dp: enable pm_runtime support for dp
> >> driver" patch is doing that which is under review.
> >>
> >> https://patchwork.freedesktop.org/patch/523879/?series=114297&rev=1
> >
> > No, he is doing another thing. He is moving these calls to pm_runtime
> > callbacks, not to the dp_display_bind().
> >
> >>> Related question: what is the primary reason for having
> >>> EV_HPD_INIT_SETUP and calling dp_display_config_hpd() via the event
> >>> thread? Does DP driver really depend on DPU irqs being installed? As
> >>> far as I understand, DP device uses MDSS interrupts and those IRQs are
> >>> available and working at the time of dp_display_probe() /
> >>> dp_display_bind().
> >>
> >> HDP gpio pin has to run through DP aux module 100ms denouncing logic
> >> and have its mask bits.
> >>
> >> Therefore DP irq has to be enabled to receive DP isr with mask bits set.
> >
> > So... DP irq is enabled by the MDSS, not by the DPU. Again, why does
> > DP driver depend on DPU irqs being installed?
>
> sorry, previously i mis understand your question -- why does DP driver
> depend on DPU irqs being installed?
>
> now, I think you are asking why  dpu_irq_postinstall() ==>
> msm_dp_irq_postinstall() ==> event_thread ==> dp_display_config_hdp()
> ==> enable_irq(dp->irq)
>
> With the below test i had run, i think the reason is to make sure
> dp->irq be requested before enable it.
>
> I just run the execution timing order test and collect execution order
> as descending order at below,
>
> 1) dp_display_probe() -- start
>
> 2) dp_display_bind()
>
> 3) msm_dp_modeset_init()  ==> dp_display_request_irq() ==>
> dp_display_get_next_bridge()
>
> 4) dpu_irq_postinstall() ==> msm_dp_irq_postinstall() ==>
> enable_irq(dp->irq)
>
> 5) dp_display_probe() -- end
>
> dp->irq is request at msm_dp_modeset_init() and enabled after.

Should be moved to probe.

>
> That bring up the issue to move DP's dp_display_host_init() executed at
> dp_display_bind().
>
> Since eDP have dp_dispaly_host_init() executed at
> dp_display_get_next_bridge() which executed after dp_display_bind().
>
> If moved DP's dp_display_host_init() to dp_dispaly_bind() which means DP
> will be ready to receive HPD irq before eDP ready.

And the AUX bus population should also be moved to probe(), which
means we should call dp_display_host_init() from probe() too.
Having aux_bus_populate in probe would allow moving component_add() to
the done_probing() callback, making probe/defer case more robust

> This may create some uncertainties at execution flow and complicate
> things up.

Hopefully the changes suggested above will make it simpler.

-- 
With best wishes
Dmitry
