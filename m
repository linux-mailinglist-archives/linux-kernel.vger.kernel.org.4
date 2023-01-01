Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B0F65AA03
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 13:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjAAM2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 07:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjAAM2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 07:28:24 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1C45FC6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 04:28:23 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id t15so27873919ybq.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 04:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7URFysZSN6Z6LPVxT+yXBreQGfA0TGi/6KTxnv1zPQ=;
        b=m4CkBbsI2qgy3rEjcmWIb/RyUGvlTEsS4GqyT5053SOFVnaBp+7tlDJeyB/oNvBMqT
         rckKFnmUYYIIbyaeyeeDEVK8f4VERRlO9/iX913GnEkX/q3vw6w1em6eRrQm1rgATXTS
         FnhEcsgdR81pkKZhrtChIwFLhKUtVlikjkiN4uNsWGXT0pmG414ZfdeksFPcutWifcJB
         wN4NDlUQjlKWsQuNodL+X+w7j6BRAxpUMPnRzwcFOMrkkbJu7e5bVD+GUwVxn9lb33f3
         sM8MBV+EWOAIjIDRz2lLH/XoDw+1wAVLfkVQ+dyxyYkBq0nMUREH2P1/3ZRAWB05guel
         ID7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7URFysZSN6Z6LPVxT+yXBreQGfA0TGi/6KTxnv1zPQ=;
        b=q/N3mjQaOmlzxgWXZ1IkXCSnL5+hylLw8SzQzxiRgSiGCxUWcZm7YSQGTuzFP7iWBJ
         pa3Ye44Ho2Tu0K+sNC0MezVZVfu3cZZpaEIEkxXpMnd3halOjocyB73wvPoW4RkjAUlR
         uu1sA6hcU9nE/wm7O1Eg8LqLGpPb0C3na4FQZxn3EM+jHoxdCd3o5rI80FaIfU+yq4XE
         BCpLqbmcQY9Qu8kiQPCvB1YUGqMlvVZW+rjGJ1HYW6EeGuIWEsQQLpX9EFT6vJkd/kYx
         FFkVrxpVOtYue6ZI/4RTI+oznOzb+QKDN76MG7YOaaRHKHiU0lYmQUjEInL4WKcAGuh1
         mB+Q==
X-Gm-Message-State: AFqh2koQ7mFD7yecenkoOnhFomOg8867/kpDzvsezeLnSkvGnq9KyVyz
        Vs79mUnFOn6cPT6cVZVZlU2UPxLOy4BWG2sb4m0wgCBcPM9Px+4E
X-Google-Smtp-Source: AMrXdXvS4lpF3KQddvAF09DEYtTB4B8CaWxtR7z/xYy/Ud/tpPXFEsqZnY0VA0puIPo+mKWCXByVoSca3FxW3JEu9ag=
X-Received: by 2002:a25:cc7:0:b0:6e0:c7d3:f026 with SMTP id
 190-20020a250cc7000000b006e0c7d3f026mr4167854ybm.275.1672576102911; Sun, 01
 Jan 2023 04:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20221231215006.211860-1-marijn.suijten@somainline.org>
 <20221231215006.211860-4-marijn.suijten@somainline.org> <20221231215254.pqaegrmldufi7ugo@SoMainline.org>
In-Reply-To: <20221231215254.pqaegrmldufi7ugo@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 1 Jan 2023 14:28:11 +0200
Message-ID: <CAA8EJppF7VcYLn3K6tV3WS+r+4W9XMGfFpD0hXf+fdpvy9osaA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] drm/msm/dpu: Disable MDP vsync source selection
 on DPU 5.0.0 and above
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kalyan Thota <quic_kalyant@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2022 at 23:52, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2022-12-31 22:50:02, Marijn Suijten wrote:
> > Since hardware revision 5.0.0 the TE configuration moved out of the
> > PINGPONG block into the INTF block, including vsync source selection
> > that was previously part of MDP top.  Writing to the MDP_VSYNC_SEL
> > register has no effect anymore and is omitted downstream via the
> > DPU/SDE_MDP_VSYNC_SEL feature flag.  This flag is only added to INTF
> > blocks used by hardware prior to 5.0.0.
> >
> > The code that writes to these registers in the INTF block will follow in
> > subsequent patches.
> >
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 33 ++++++++++--
> >  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  1 +
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c    | 52 +++++++++++++------
> >  3 files changed, 66 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > index 39d4b293710c..1cfe94494135 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> > @@ -407,7 +407,7 @@ static const struct dpu_mdp_cfg msm8998_mdp[] = {
> >       {
> >       .name = "top_0", .id = MDP_TOP,
> >       .base = 0x0, .len = 0x458,
> > -     .features = 0,
> > +     .features = BIT(DPU_MDP_VSYNC_SEL),
> >       .highest_bank_bit = 0x2,
> >       .clk_ctrls[DPU_CLK_CTRL_VIG0] = {
> >                       .reg_off = 0x2AC, .bit_off = 0},
> > @@ -436,7 +436,7 @@ static const struct dpu_mdp_cfg sdm845_mdp[] = {
> >       {
> >       .name = "top_0", .id = MDP_TOP,
> >       .base = 0x0, .len = 0x45C,
> > -     .features = BIT(DPU_MDP_AUDIO_SELECT),
> > +     .features = BIT(DPU_MDP_AUDIO_SELECT) | BIT(DPU_MDP_VSYNC_SEL),
> >       .highest_bank_bit = 0x2,
> >       .clk_ctrls[DPU_CLK_CTRL_VIG0] = {
> >                       .reg_off = 0x2AC, .bit_off = 0},
> > @@ -512,6 +512,31 @@ static const struct dpu_mdp_cfg sm6115_mdp[] = {
> >       },
> >  };
> >
> > +static const struct dpu_mdp_cfg sdm8150_mdp[] = {
>
> Sometimes it is only possible to spot such things _after_ sending,
> probably the thing that makes us human :)
>
> sm8150_mdp*, not sdm.
>

With this name fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
