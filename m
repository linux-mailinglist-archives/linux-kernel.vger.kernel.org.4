Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10C664D015
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiLNTad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiLNTab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:30:31 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040E926118
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:30:30 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B993820222;
        Wed, 14 Dec 2022 20:30:27 +0100 (CET)
Date:   Wed, 14 Dec 2022 20:30:26 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] drm/msm/dpu1: Wire up DSC mask for active CTL
 configuration
Message-ID: <20221214193026.dv2fuubysctcvlkg@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>, Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221213232207.113607-1-marijn.suijten@somainline.org>
 <20221213232207.113607-4-marijn.suijten@somainline.org>
 <184d22f1-7ed1-4a67-1c25-9fafeb94db83@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184d22f1-7ed1-4a67-1c25-9fafeb94db83@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-14 20:43:29, Dmitry Baryshkov wrote:
> On 14/12/2022 01:22, Marijn Suijten wrote:
> > Active CTLs have to configure what DSC block(s) have to be enabled, and
> > what DSC block(s) have to be flushed; this value was initialized to zero
> > resulting in the necessary register writes to never happen (or would
> > write zero otherwise).  This seems to have gotten lost in the DSC v4->v5
> > series while refactoring how the combination with merge_3d was handled.
> > 
> > Fixes: 58dca9810749 ("drm/msm/disp/dpu1: Add support for DSC in encoder")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 1 +
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 1 +
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c  | 2 ++
> >   3 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> > index ae28b2b93e69..35791f93c33d 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> > @@ -61,6 +61,7 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
> >   	intf_cfg.intf_mode_sel = DPU_CTL_MODE_SEL_CMD;
> >   	intf_cfg.stream_sel = cmd_enc->stream_sel;
> >   	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
> > +	intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
> >   	ctl->ops.setup_intf_cfg(ctl, &intf_cfg);
> >   
> >   	/* setup which pp blk will connect to this intf */
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > index 0f71e8fe7be7..9ee3a7306a5f 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > @@ -274,6 +274,7 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
> >   	intf_cfg.intf_mode_sel = DPU_CTL_MODE_SEL_VID;
> >   	intf_cfg.stream_sel = 0; /* Don't care value for video mode */
> >   	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
> > +	intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
> >   	if (phys_enc->hw_pp->merge_3d)
> >   		intf_cfg.merge_3d = phys_enc->hw_pp->merge_3d->idx;
> >   
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> > index 7cbcef6efe17..92ddf9995b37 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> > @@ -209,6 +209,7 @@ static void dpu_encoder_phys_wb_setup_cdp(struct dpu_encoder_phys *phys_enc)
> >   
> >   		intf_cfg.intf = DPU_NONE;
> >   		intf_cfg.wb = hw_wb->idx;
> > +		intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
> 
> We usually don't have DSC with the writeback, don't we?

I am unsure so ended up adding them in writeback regardless.  Downstream
uses a separate callback to process intf_cfg.dsc instead of going
through setup_intf_cfg().

To prevent these from being missed again (in the case of copy&paste),
how about instead having some function that sets up intf_cfg with these
default values from a phys_enc?  That way most of this remains oblivious
to the caller.

On the same note, that callback on non-DPU_CTL_ACTIVE_CFG hardware
doesn't use the intf_cfg.dsc member anyway, but it was again added to
keep the blocks somewhat consistent (in case it ever becomes used?).

> >   		if (mode_3d && hw_pp && hw_pp->merge_3d)
> >   			intf_cfg.merge_3d = hw_pp->merge_3d->idx;
> > @@ -230,6 +231,7 @@ static void dpu_encoder_phys_wb_setup_cdp(struct dpu_encoder_phys *phys_enc)
> >   		intf_cfg.wb = hw_wb->idx;
> >   		intf_cfg.mode_3d =
> >   			dpu_encoder_helper_get_3d_blend_mode(phys_enc);
> > +		intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
> >   		phys_enc->hw_ctl->ops.setup_intf_cfg(phys_enc->hw_ctl, &intf_cfg);
> >   	}
> >   }

- Marijn
