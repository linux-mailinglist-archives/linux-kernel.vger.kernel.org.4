Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC66FFE2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbjELAyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELAyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:54:33 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88D94C1F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:54:31 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba6fffc5524so399562276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683852871; x=1686444871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=13QXrDUunIKS3nzQg7+Y1LNFFExufB7mhjww9OSaI8E=;
        b=yv1Aa0DVgbmRTQkD15m6TtlspfJ7PzwXL2nXvLpU70QfFaBqC1ZfiWzwhTRcKvE/zz
         d9wRHDY1pc9TlM9+eUhRU2dLWh+hPHGJCVco7faJTF8+7O18gd384Xq7u6UibbahCyK/
         tp/2OaK7mSJO5DPV++bvh6CRqD1xc5SD7kIAgQaXk2xmC2bqaZdAXWfaixSZO6O19Epd
         kRh3bTe0Kf0CLB2L17bBFPxhp53JuuhXHjCIhw++6slNvoNlDqADguKmzt2QVYrbkxrH
         iSTfijY7nWhqB4pAYpOHGeU/HOvuVBb64GxmCN2C07JwaGHiYJwV7wZh68ZvLkPH8GAM
         65KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683852871; x=1686444871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13QXrDUunIKS3nzQg7+Y1LNFFExufB7mhjww9OSaI8E=;
        b=YnY8jsOwG9m7566XRri8IH+jP0D6hXVLvi2PwvCJ7jbuB7nlNkqMAMgw18HsQQm62G
         LmBb56UJGZHs0tP0mQ7QF3JwNWDdP8xCqlBi152iBsSy+hqKadEO39mRZz450EcviBNx
         ILzH1KLUhn73pJIIvoD5XYc02bcR1DaMW1JV0CGrLSpXiJmOXOTx1fTG63uBemhHCJ0t
         nCSwU1NzyC4a3ny7DrB+f7AMFMjLfUqdcKvf2L6QimLlDt6B1Vk2nJPcjG75+6p1R9Nq
         DB9lTO+sFIvjf/aQSDxxoOoo+0GCq2oelnI5cU+CYVBL5TzV09503HOtcBrT7BYmJtrg
         fnUQ==
X-Gm-Message-State: AC+VfDwKU9mPm0N78/rQ6KcODh6RZOgYbS1Ex0pVQ3mgvy8bNZZsbSnj
        fIdJ2o+lolIGd6Pjmvdw736hSBdVPbK3pl8j5oajIg==
X-Google-Smtp-Source: ACHHUZ6zkj2jHzJNInf49SFDRu6Bq9VJMsYGKJu/kXQsYy2rYOra+A374VNd1ggRwTE5R7JxkHjyk1m8Mg6ijUN5VeA=
X-Received: by 2002:a25:fd6:0:b0:b9d:b22e:6082 with SMTP id
 205-20020a250fd6000000b00b9db22e6082mr21017812ybp.3.1683852870690; Thu, 11
 May 2023 17:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com>
 <1683750665-8764-2-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJprtQF0x_LCOTrt5bvRnJ+xRz6QxLF6QAP-4Pff6V5TJ2g@mail.gmail.com>
 <20230511155331.2jmfe7xcs5tihdgb@ripper> <5ef83699-01de-d062-6239-9bb834c70458@linaro.org>
 <8ac0b5f5-27da-2b28-8f10-b2fca447511a@quicinc.com>
In-Reply-To: <8ac0b5f5-27da-2b28-8f10-b2fca447511a@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 12 May 2023 03:54:19 +0300
Message-ID: <CAA8EJpokAoGni7vNwuijs7EvmjCweO3pgChij3Qx3OUkVTVpiQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/msm/dp: enable HDP plugin/unplugged interrupts
 to hpd_enable/disable
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 12 May 2023 at 03:16, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 5/11/2023 8:57 AM, Dmitry Baryshkov wrote:
> > On 11/05/2023 18:53, Bjorn Andersson wrote:
> >> On Thu, May 11, 2023 at 07:24:46AM +0300, Dmitry Baryshkov wrote:
> >>> On Wed, 10 May 2023 at 23:31, Kuogee Hsieh <quic_khsieh@quicinc.com>
> >>> wrote:
> >>>>
> >>>> The internal_hpd flag was introduced to handle external DP HPD
> >>>> derived from GPIO
> >>>> pinmuxed into DP controller. HPD plug/unplug interrupts cannot be
> >>>> enabled until
> >>>> internal_hpd flag is set to true.
> >>>> At both bootup and resume time, the DP driver will enable external DP
> >>>> plugin interrupts and handle plugin interrupt accordingly.
> >>>> Unfortunately
> >>>> dp_bridge_hpd_enable() bridge ops function was called to set
> >>>> internal_hpd
> >>>> flag to true later than where DP driver expected during bootup time.
> >>>>
> >>>> This causes external DP plugin event to not get detected and
> >>>> display stays blank.
> >>>> Move enabling HDP plugin/unplugged interrupts to
> >>>> dp_bridge_hpd_enable()/disable() to
> >>>> set internal_hpd to true along with enabling HPD plugin/unplugged
> >>>> interrupts
> >>>> simultaneously to avoid timing issue during bootup and resume.
> >>>>
> >>>> Fixes: cd198caddea7 ("drm/msm/dp: Rely on hpd_enable/disable
> >>>> callbacks")
> >>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >>>
> >>> Thanks for debugging this!
> >>>
> >>> However after looking at the driver I think there is more than this.
> >>>
> >>> We have several other places gated on internal_hpd flag, where we do
> >>> not have a strict ordering of events.
> >>> I see that dp_hpd_plug_handle() and dp_hpd_unplug_handle() also toggle
> >>> DP_DP_IRQ_HPD_INT_MASK and DP_DP_HPD_REPLUG_INT_MASK depending on
> >>> internal_hpd. Can we toggle all 4 interrupts from the
> >>> hpd_enable/hpd_disable functions? If we can do it, then I think we can
> >>> drop the internal_hpd flag completely.
> >>>
> >>
> >> Yes, that's what I believe the DRM framework intend us to do.
> >>
> >> The problem, and reason why I didn't do tat in my series, was that in
> >> order to update the INT_MASKs you need to clock the IP-block and that's
> >> done elsewhere.
> >>
> >> So, for the internal_hpd case, it seems appropriate to pm_runtime_get()
> >> in hpd_enable() and unmask the HPD interrupts, and mask the interrupts
> >> and pm_runtime_put() in hpd_disable().
> >>
> >>
> >> But for edp and external HPD-signal we also need to make sure power is
> >> on while something is connected...
> >
> > I think this is already handled by the existing code, see calls to the
> > dp_display_host_init().
> >
> >>
> >>> I went on and checked other places where it is used:
> >>> - dp_hpd_unplug_handle(), guarding DP_DP_HPD_PLUG_INT_MASK toggling. I
> >>> think we can drop these two calls completely. The function is under
> >>> the event_mutex protection, so other events can not interfere.
> >>> - dp_bridge_hpd_notify(). What is the point of this check? If some
> >>> other party informs us of the HPD event, we'd better handle it instead
> >>> of dropping it. Correct?  In other words, I'd prefer seeing the
> >>> hpd_event_thread removal. Instead of that I think that on
> >>> HPD/plug/unplug/etc. IRQ the driver should call into the drm stack,
> >>> then the hpd_notify call should process those events.
> >>>
> 1) DP with GPIO: No downstream drm_bridge are connected, is_edp = false
> and internal HPD-logic is in used (internal_hpd = true). Power needs to
> be on at all times etc.
>
> 2) DP without GPIO: Downstream drm_bridge connected, is_edp = false and
> internal HPD-logic should not be used/enabled (internal_hpd = false).
> Power doesn't need to be on unless hpd_notify is invoked to tell us that
> there's something connected...
>
> - dp_bridge_hpd_notify(). What is the point of this check? <== i have
> below two questions,
>
> 1) can you explain when/what this dp_bridge_hpd_notify() will be called?

The call chain is drm_bridge_hpd_notify() ->
drm_bridge_connector_hpd_notify() -> .hpd_notify() for all drm_bridge
in chain

One should add a call to drm_bridge_hpd_notify() when the hotplug
event has been detected.

Also please note the patch https://patchwork.freedesktop.org/patch/484432/

>
> 2) is dp_bridge_hpd_notify() only will be called at above case #2? and
> it will not be used by case #1?

Once the driver calls drm_bridge_hpd_notify() in the hpd path, the
hpd_notify callbacks will be called in case#1 too.

BTW: I don't see drm_bridge_hpd_notify() or
drm_kms_{,connector_}_hotplug_event() HPD notifications in the DP
driver at all. This should be fixed.

>
>
>
> >>
> >> I agree, that seems to be what's expected of us from the DRM framework.
> >>
> >> Regards,
> >> Bjorn
> >>
> >>>
> >>>> ---
> >>>>   drivers/gpu/drm/msm/dp/dp_display.c | 27 ++++++++++++++-------------
> >>>>   1 file changed, 14 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> b/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> index 3e13acdf..71aa944 100644
> >>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >>>> @@ -1088,13 +1088,6 @@ static void dp_display_config_hpd(struct
> >>>> dp_display_private *dp)
> >>>>          dp_display_host_init(dp);
> >>>>          dp_catalog_ctrl_hpd_config(dp->catalog);
> >>>>
> >>>> -       /* Enable plug and unplug interrupts only if requested */
> >>>> -       if (dp->dp_display.internal_hpd)
> >>>> -               dp_catalog_hpd_config_intr(dp->catalog,
> >>>> -                               DP_DP_HPD_PLUG_INT_MASK |
> >>>> -                               DP_DP_HPD_UNPLUG_INT_MASK,
> >>>> -                               true);
> >>>> -
> >>>>          /* Enable interrupt first time
> >>>>           * we are leaving dp clocks on during disconnect
> >>>>           * and never disable interrupt
> >>>> @@ -1396,12 +1389,6 @@ static int dp_pm_resume(struct device *dev)
> >>>>
> >>>>          dp_catalog_ctrl_hpd_config(dp->catalog);
> >>>>
> >>>> -       if (dp->dp_display.internal_hpd)
> >>>> -               dp_catalog_hpd_config_intr(dp->catalog,
> >>>> -                               DP_DP_HPD_PLUG_INT_MASK |
> >>>> -                               DP_DP_HPD_UNPLUG_INT_MASK,
> >>>> -                               true);
> >>>> -
> >>>>          if (dp_catalog_link_is_connected(dp->catalog)) {
> >>>>                  /*
> >>>>                   * set sink to normal operation mode -- D0
> >>>> @@ -1801,15 +1788,29 @@ void dp_bridge_hpd_enable(struct drm_bridge
> >>>> *bridge)
> >>>>   {
> >>>>          struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
> >>>>          struct msm_dp *dp_display = dp_bridge->dp_display;
> >>>> +       struct dp_display_private *dp;
> >>>> +
> >>>> +       dp = container_of(dp_display, struct dp_display_private,
> >>>> dp_display);
> >>>>
> >>>>          dp_display->internal_hpd = true;
> >>>> +       dp_catalog_hpd_config_intr(dp->catalog,
> >>>> +                               DP_DP_HPD_PLUG_INT_MASK |
> >>>> +                               DP_DP_HPD_UNPLUG_INT_MASK,
> >>>> +                               true);
> >>>>   }
> >>>>
> >>>>   void dp_bridge_hpd_disable(struct drm_bridge *bridge)
> >>>>   {
> >>>>          struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
> >>>>          struct msm_dp *dp_display = dp_bridge->dp_display;
> >>>> +       struct dp_display_private *dp;
> >>>> +
> >>>> +       dp = container_of(dp_display, struct dp_display_private,
> >>>> dp_display);
> >>>>
> >>>> +       dp_catalog_hpd_config_intr(dp->catalog,
> >>>> +                               DP_DP_HPD_PLUG_INT_MASK |
> >>>> +                               DP_DP_HPD_UNPLUG_INT_MASK,
> >>>> +                               false);
> >>>>          dp_display->internal_hpd = false;
> >>>>   }
> >>>
> >>> --
> >>> With best wishes
> >>> Dmitry
> >



-- 
With best wishes
Dmitry
