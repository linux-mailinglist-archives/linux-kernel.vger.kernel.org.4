Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44F65DB31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjADRVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbjADRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:21:01 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE5513DC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:20:58 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4a263c4ddbaso147641177b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 09:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nL02Rh1qmJ+y+2QtT3JxhgjmywEhlM/M66BwZCj7KOs=;
        b=TyJt2DFJnxrrzLUQRSO71GCi5DoLx9eYJnv8dOey98aTChHwFdHJ/4oiI9FThEcnmx
         TFVtUs380c+/YfgeIgW7bus2sjh3cNZYuXlO76v4nWptfhqYVUTfbmsZcttwShu8KfuY
         FRZ5NAgDUXhcmIQeL7ex6LFn8Dwqr4O0rHU14KEphPyQdZF0tlct9TKspNTUWqmGRkXM
         XXg3Lavd4dakkiw/q9RlJhDy/TexTkoCzOuVVEotgsYnms6ncSv6epMkiGsqm1GKJES1
         mAtMd1ffIhS62lzkGQ6xylxK7ZAmtLL5c21ycFSqilaZYa13j7iu+P4x4vzf9up08M24
         Zm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL02Rh1qmJ+y+2QtT3JxhgjmywEhlM/M66BwZCj7KOs=;
        b=EieVZSp62P8YPI5xSvYiw5PTuT0dangGIGMZY3bT719SsSW/FVqiSEE86M9UzP/vRP
         O2uMPwamq9CWjE1NaIvuyYznT/gpDnXpa+3dr+HAZPxRV8lYU3cmicT94E6dH/PmNZh3
         uV+opBEvfJPOPQogl10U6C3v1EsxAKUahHAgyxURdwWy+KDs9Lix13Xyn54hhWMbI1iu
         uC36xmlZIsjEGY+KfXMSJsWMydgy4lxcrI+zwsk4+iSATL3xYbVav3VXdq5rsbeKM5fx
         nhP0dL608Exc0rOzUpqLMpx+wAlkyxyyvpelcAhbB5HLOYZAmoAEd7bS5eUkppbeKBAu
         fi8w==
X-Gm-Message-State: AFqh2kpuFeF+DhX6aXDICi51C13Nsab6A/R64+/ThoJ2EWHB5cgao1lW
        CkmNJtomtDY3WXXsIJGhuarevs9ktfDXGziB1LxMCg==
X-Google-Smtp-Source: AMrXdXv7InDULbhb/a83U+trri33z2HsaN34ajFbweGt+IZoRAuqCcv0/ge6iawr5DBlxzYHW5l4AZEUrhvqU5NubnM=
X-Received: by 2002:a05:690c:fd5:b0:4a4:7135:9214 with SMTP id
 dg21-20020a05690c0fd500b004a471359214mr2070871ywb.378.1672852858082; Wed, 04
 Jan 2023 09:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v1-5-9ccd7e652fcd@linaro.org>
 <aa6724af-99bc-de1d-4c03-82609b59174c@linaro.org> <0e28b301-6980-968c-552d-db16fade6df9@linaro.org>
In-Reply-To: <0e28b301-6980-968c-552d-db16fade6df9@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 4 Jan 2023 19:20:46 +0200
Message-ID: <CAA8EJpqF3bCNa_yGQLt++kmZp3d=La2ZsS=rQOwp6Yp9C+oVJg@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/msm/dsi: add support for DSI-PHY on SM8550
To:     neil.armstrong@linaro.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, 4 Jan 2023 at 12:11, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 04/01/2023 10:53, Dmitry Baryshkov wrote:
> > On 04/01/2023 11:08, Neil Armstrong wrote:
> >> SM8550 use a 4nm DSI PHYs, which share register definitions
> >> with 7nm DSI PHYs. Rather than duplicating the driver, handle
> >> 4nm variant inside the common 5+7nm driver.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> ---
> >>   drivers/gpu/drm/msm/Kconfig               |   4 +-
> >>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |   2 +
> >>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |   1 +
> >>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 102 ++++++++++++++++++++++++------
> >>   4 files changed, 89 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> >> index e7b100d97f88..949b18a29a55 100644
> >> --- a/drivers/gpu/drm/msm/Kconfig
> >> +++ b/drivers/gpu/drm/msm/Kconfig
> >> @@ -140,11 +140,11 @@ config DRM_MSM_DSI_10NM_PHY
> >>         Choose this option if DSI PHY on SDM845 is used on the platform.
> >>   config DRM_MSM_DSI_7NM_PHY
> >> -    bool "Enable DSI 7nm/5nm PHY driver in MSM DRM"
> >> +    bool "Enable DSI 7nm/5nm/4nm PHY driver in MSM DRM"
> >>       depends on DRM_MSM_DSI
> >>       default y
> >>       help
> >> -      Choose this option if DSI PHY on SM8150/SM8250/SM8350/SM8450/SC7280
> >> +      Choose this option if DSI PHY on SM8150/SM8250/SM8350/SM8450/SM8550/SC7280
> >>         is used on the platform.
> >>   config DRM_MSM_HDMI
> >> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> >> index 0c956fdab23e..54e03cc9fbe7 100644
> >> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> >> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> >> @@ -573,6 +573,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
> >>         .data = &dsi_phy_5nm_8350_cfgs },
> >>       { .compatible = "qcom,dsi-phy-5nm-8450",
> >>         .data = &dsi_phy_5nm_8450_cfgs },
> >> +    { .compatible = "qcom,dsi-phy-4nm-8550",
> >> +      .data = &dsi_phy_4nm_8550_cfgs },
> >>   #endif
> >>       {}
> >>   };
> >> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> >> index f7a907ed2b4b..58f9e09f5224 100644
> >> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> >> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> >> @@ -59,6 +59,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs;
> >>   extern const struct msm_dsi_phy_cfg dsi_phy_7nm_7280_cfgs;
> >>   extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8350_cfgs;
> >>   extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs;
> >> +extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs;
> >>   struct msm_dsi_dphy_timing {
> >>       u32 clk_zero;
> >> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> >> index 7b2c16b3a36c..11629c431c30 100644
> >> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> >> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> >> @@ -47,6 +47,8 @@
> >>   #define DSI_PHY_7NM_QUIRK_V4_2        BIT(2)
> >>   /* Hardware is V4.3 */
> >>   #define DSI_PHY_7NM_QUIRK_V4_3        BIT(3)
> >> +/* Hardware is V5.2 */
> >> +#define DSI_PHY_7NM_QUIRK_V5_2        BIT(4)
> >>   struct dsi_pll_config {
> >>       bool enable_ssc;
> >> @@ -124,14 +126,25 @@ static void dsi_pll_calc_dec_frac(struct dsi_pll_7nm *pll, struct dsi_pll_config
> >>       if (pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_PRE_V4_1)
> >>           config->pll_clock_inverters = 0x28;
> >> -    else if (pll_freq <= 1000000000ULL)
> >> -        config->pll_clock_inverters = 0xa0;
> >> -    else if (pll_freq <= 2500000000ULL)
> >> -        config->pll_clock_inverters = 0x20;
> >> -    else if (pll_freq <= 3020000000ULL)
> >> -        config->pll_clock_inverters = 0x00;
> >> -    else
> >> -        config->pll_clock_inverters = 0x40;
> >> +    else if ((pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> >> +        if (pll_freq <= 1300000000ULL)
> >> +            config->pll_clock_inverters = 0xa0;
> >> +        else if (pll_freq <= 2500000000ULL)
> >> +            config->pll_clock_inverters = 0x20;
> >> +        else if (pll_freq <= 4000000000ULL)
> >> +            config->pll_clock_inverters = 0x00;
> >> +        else
> >> +            config->pll_clock_inverters = 0x40;
> >> +    } else {
> >> +        if (pll_freq <= 1000000000ULL)
> >> +            config->pll_clock_inverters = 0xa0;
> >> +        else if (pll_freq <= 2500000000ULL)
> >> +            config->pll_clock_inverters = 0x20;
> >> +        else if (pll_freq <= 3020000000ULL)
> >> +            config->pll_clock_inverters = 0x00;
> >> +        else
> >> +            config->pll_clock_inverters = 0x40;
> >> +    }
> >>       config->decimal_div_start = dec;
> >>       config->frac_div_start = frac;
> >> @@ -222,6 +235,13 @@ static void dsi_pll_config_hzindep_reg(struct dsi_pll_7nm *pll)
> >>               vco_config_1 = 0x01;
> >>       }
> >> +    if ((pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> >> +        if (pll->vco_current_rate < 1557000000ULL)
> >> +            vco_config_1 = 0x08;
> >> +        else
> >> +            vco_config_1 = 0x01;
> >> +    }
> >> +
> >>       dsi_phy_write(base + REG_DSI_7nm_PHY_PLL_ANALOG_CONTROLS_FIVE_1,
> >>                 analog_controls_five_1);
> >>       dsi_phy_write(base + REG_DSI_7nm_PHY_PLL_VCO_CONFIG_1, vco_config_1);
> >> @@ -860,7 +880,8 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
> >>           pr_warn("PLL turned on before configuring PHY\n");
> >>       /* Request for REFGEN READY */
> >> -    if (phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_3) {
> >> +    if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_3) ||
> >> +        (phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> >>           dsi_phy_write(phy->base + REG_DSI_7nm_PHY_CMN_GLBL_DIGTOP_SPARE10, 0x1);
> >>           udelay(500);
> >>       }
> >> @@ -881,20 +902,38 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
> >>       glbl_str_swi_cal_sel_ctrl = 0x00;
> >>       if (phy->cphy_mode) {
> >> -        vreg_ctrl_0 = 0x51;
> >> -        vreg_ctrl_1 = 0x55;
> >> +        if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> >> +            vreg_ctrl_0 = 0x45;
> >> +            vreg_ctrl_1 = 0x45;
> >> +        } else {
> >> +            vreg_ctrl_0 = 0x51;
> >> +            vreg_ctrl_1 = 0x55;
> >> +        }
> >
> > Please move these quirk-specific values down, to the rest of if (QUIRK_5_2) statement.
>
> Ok
>
> >
> >>           glbl_hstx_str_ctrl_0 = 0x00;
> >>           glbl_pemph_ctrl_0 = 0x11;
> >>           lane_ctrl0 = 0x17;
> >>       } else {
> >> -        vreg_ctrl_0 = less_than_1500_mhz ? 0x53 : 0x52;
> >> -        vreg_ctrl_1 = 0x5c;
> >> +        if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> >> +            vreg_ctrl_0 = 0x44;
> >> +            vreg_ctrl_1 = 0x19;
> >> +        } else {
> >> +            vreg_ctrl_0 = less_than_1500_mhz ? 0x53 : 0x52;
> >> +            vreg_ctrl_1 = 0x5c;
> >> +        }
> >>           glbl_hstx_str_ctrl_0 = 0x88;
> >>           glbl_pemph_ctrl_0 = 0x00;
> >>           lane_ctrl0 = 0x1f;
> >>       }
> >> -    if (phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_3) {
> >> +    if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> >> +        if (phy->cphy_mode) {
> >> +            glbl_rescode_top_ctrl = 0x00;
> >> +            glbl_rescode_bot_ctrl = 0x00;
> >> +        } else {
> >> +            glbl_rescode_top_ctrl = less_than_1500_mhz ? 0x3c :  0x03;
> >> +            glbl_rescode_bot_ctrl = less_than_1500_mhz ? 0x38 :  0x3c;
> >> +        }
> >> +    } else if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_3)) {
> >>           if (phy->cphy_mode) {
> >>               glbl_rescode_top_ctrl = less_than_1500_mhz ? 0x3d :  0x01;
> >>               glbl_rescode_bot_ctrl = less_than_1500_mhz ? 0x38 :  0x3b;
> >> @@ -943,9 +982,8 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
> >>       dsi_phy_write(base + REG_DSI_7nm_PHY_CMN_RBUF_CTRL, 0x00);
> >>       /* program CMN_CTRL_4 for minor_ver 2 chipsets*/
> >> -    data = dsi_phy_read(base + REG_DSI_7nm_PHY_CMN_REVISION_ID0);
> >> -    data = data & (0xf0);
> >> -    if (data == 0x20)
> >> +    if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2) ||
> >> +        (dsi_phy_read(base + REG_DSI_7nm_PHY_CMN_REVISION_ID0) & (0xf0)) == 0x20)
> >>           dsi_phy_write(base + REG_DSI_7nm_PHY_CMN_CTRL_4, 0x04);
> >
> > Ugh. I should change this statement to use quirks too.
>
> Sorrt I don't see what you mean, should I change the original REVISION_ID0 to a proper quirk ?
>

No, I'll do this. For now you can leave this piece code as is (reading
rev + your quirk).

-- 
With best wishes
Dmitry
