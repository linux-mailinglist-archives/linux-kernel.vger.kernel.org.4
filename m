Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1066B66226B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjAIKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbjAIKCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:02:24 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B882E8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:02:20 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v19so2135993ybv.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9fhCNkHD8R84SoJprEs3JUZC7/T4pbSbQNPTyFgf4Mk=;
        b=haVBrLGAAw8RBM8DDoq/NYfhLGT3AQr+HDpqy55lprYj7DT2jCySVtSxw7KrqBnvNj
         p3C/pv/7KzpIslQILpCkRuFYvlF0jLcju5l5ocI6UwqzLwzWNhRCFqzodR9RNFb9VI4v
         HdEnRIfTQ7+p11jpYUsn7wFwGgHy4YgSCVb4pM0A7yY99R9s9jKim7KYuo8ROHN1aoxB
         IRsD0viL7tZmoHykMhESoyGsL5UHuHENxhgHHlnsqimd4WipoS3urdr/EyFfLgvohaE9
         eInJ1BTf/d9o4JeK+F5H90/EFUPUwzHZlBA3qTr6VA/th/JHVWz39xkut8vhFkRNAcox
         j3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fhCNkHD8R84SoJprEs3JUZC7/T4pbSbQNPTyFgf4Mk=;
        b=lpI9mrAefKeQPI9WG2j+yiKhdi4qw6ctaUnspweN11+mBbnMzrJ8s/DRJ5ivyNnLFc
         cfolJVkIDUcuHheuBiTICc5LiiMKd+oYZtp5t+2wCUhTPmLgOmW2mAGT45nv36yKh8uM
         zdwJ57qLPrZOxxpg2K0kFHkxRgfLc9hpAuhOPoth8Sx9IdZ64U1AInPojJAD9YB6riWp
         ykCOvqPlYkV8+sc3ysVfoZoun3xwepNPgx35ghRxxmcHOnZ4aeEY1jj20SlrAApj1v1o
         aPLrbft+gr7Ls16vA0yniTSJepMbWXxoXbPoZWo0Lqcsbp5JJLMU5obVQn3XvVUoLQaB
         jAcg==
X-Gm-Message-State: AFqh2koq/OZ90UQ8L93hhFs5+lydcY9v+1QPBjPA+56EztoYX1G6t01k
        hD3TLrjBudibjkC7YH5OX8XPddbN5ooimOftKEMhAA==
X-Google-Smtp-Source: AMrXdXutmkdZr1tZGgCofhg5egpYmyIguSqC+tRQCcIDkVre+FY2EQqw3dOrugo0Zgf8XYKSI8LzafLyL3PjcHm8g/k=
X-Received: by 2002:a25:e90c:0:b0:73a:3b94:47fc with SMTP id
 n12-20020a25e90c000000b0073a3b9447fcmr7050410ybd.152.1673258539540; Mon, 09
 Jan 2023 02:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v2-6-87f1c16d7635@linaro.org> <b8e05110-e96d-0454-6990-27e2567c0e9a@linaro.org>
In-Reply-To: <b8e05110-e96d-0454-6990-27e2567c0e9a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 9 Jan 2023 12:02:08 +0200
Message-ID: <CAA8EJppG5PeaZZ9j6D8aPn3K7ZO+D=pN6dzqKdDztPshGp+f5A@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] drm/msm/dsi: add support for DSI-PHY on SM8550
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 11:38, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 09/01/2023 10:26, Neil Armstrong wrote:
> > SM8550 use a 4nm DSI PHYs, which share register definitions
> > with 7nm DSI PHYs. Rather than duplicating the driver, handle
> > 4nm variant inside the common 5+7nm driver.
> >
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/Kconfig               |  4 +-
> >   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 +
> >   drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
> >   drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 88 ++++++++++++++++++++++++++-----
> >   4 files changed, 79 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> > index e7b100d97f88..949b18a29a55 100644
> > --- a/drivers/gpu/drm/msm/Kconfig
> > +++ b/drivers/gpu/drm/msm/Kconfig
> > @@ -140,11 +140,11 @@ config DRM_MSM_DSI_10NM_PHY
> >         Choose this option if DSI PHY on SDM845 is used on the platform.
> >
> >   config DRM_MSM_DSI_7NM_PHY
> > -     bool "Enable DSI 7nm/5nm PHY driver in MSM DRM"
> > +     bool "Enable DSI 7nm/5nm/4nm PHY driver in MSM DRM"
> >       depends on DRM_MSM_DSI
> >       default y
> >       help
> > -       Choose this option if DSI PHY on SM8150/SM8250/SM8350/SM8450/SC7280
> > +       Choose this option if DSI PHY on SM8150/SM8250/SM8350/SM8450/SM8550/SC7280
> >         is used on the platform.
> >
> >   config DRM_MSM_HDMI
> > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > index 04126af74bb5..798cd3c86031 100644
> > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > @@ -573,6 +573,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
> >         .data = &dsi_phy_5nm_8350_cfgs },
> >       { .compatible = "qcom,sm8450-dsi-phy-5nm",
> >         .data = &dsi_phy_5nm_8450_cfgs },
> > +     { .compatible = "qcom,dsi-phy-4nm-8550",
>
> Forgot to change this... I can resend a v3 with this fixed.

Yes, please.

>
> Neil
>
> > +       .data = &dsi_phy_4nm_8550_cfgs },
> >   #endif
> >       {}
> >   };
> > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > index f7a907ed2b4b..58f9e09f5224 100644
> > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > @@ -59,6 +59,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs;
> >   extern const struct msm_dsi_phy_cfg dsi_phy_7nm_7280_cfgs;
> >   extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8350_cfgs;
> >   extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs;
> > +extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs;
> >
> >   struct msm_dsi_dphy_timing {
> >       u32 clk_zero;
> > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> > index 7b2c16b3a36c..af5c952c6ad0 100644
> > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> > @@ -47,6 +47,8 @@
> >   #define DSI_PHY_7NM_QUIRK_V4_2              BIT(2)
> >   /* Hardware is V4.3 */
> >   #define DSI_PHY_7NM_QUIRK_V4_3              BIT(3)
> > +/* Hardware is V5.2 */
> > +#define DSI_PHY_7NM_QUIRK_V5_2               BIT(4)
> >
> >   struct dsi_pll_config {
> >       bool enable_ssc;
> > @@ -124,14 +126,25 @@ static void dsi_pll_calc_dec_frac(struct dsi_pll_7nm *pll, struct dsi_pll_config
> >
> >       if (pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_PRE_V4_1)
> >               config->pll_clock_inverters = 0x28;
> > -     else if (pll_freq <= 1000000000ULL)
> > -             config->pll_clock_inverters = 0xa0;
> > -     else if (pll_freq <= 2500000000ULL)
> > -             config->pll_clock_inverters = 0x20;
> > -     else if (pll_freq <= 3020000000ULL)
> > -             config->pll_clock_inverters = 0x00;
> > -     else
> > -             config->pll_clock_inverters = 0x40;
> > +     else if ((pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> > +             if (pll_freq <= 1300000000ULL)
> > +                     config->pll_clock_inverters = 0xa0;
> > +             else if (pll_freq <= 2500000000ULL)
> > +                     config->pll_clock_inverters = 0x20;
> > +             else if (pll_freq <= 4000000000ULL)
> > +                     config->pll_clock_inverters = 0x00;
> > +             else
> > +                     config->pll_clock_inverters = 0x40;
> > +     } else {
> > +             if (pll_freq <= 1000000000ULL)
> > +                     config->pll_clock_inverters = 0xa0;
> > +             else if (pll_freq <= 2500000000ULL)
> > +                     config->pll_clock_inverters = 0x20;
> > +             else if (pll_freq <= 3020000000ULL)
> > +                     config->pll_clock_inverters = 0x00;
> > +             else
> > +                     config->pll_clock_inverters = 0x40;
> > +     }
> >
> >       config->decimal_div_start = dec;
> >       config->frac_div_start = frac;
> > @@ -222,6 +235,13 @@ static void dsi_pll_config_hzindep_reg(struct dsi_pll_7nm *pll)
> >                       vco_config_1 = 0x01;
> >       }
> >
> > +     if ((pll->phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> > +             if (pll->vco_current_rate < 1557000000ULL)
> > +                     vco_config_1 = 0x08;
> > +             else
> > +                     vco_config_1 = 0x01;
> > +     }
> > +
> >       dsi_phy_write(base + REG_DSI_7nm_PHY_PLL_ANALOG_CONTROLS_FIVE_1,
> >                     analog_controls_five_1);
> >       dsi_phy_write(base + REG_DSI_7nm_PHY_PLL_VCO_CONFIG_1, vco_config_1);
> > @@ -860,7 +880,8 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
> >               pr_warn("PLL turned on before configuring PHY\n");
> >
> >       /* Request for REFGEN READY */
> > -     if (phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_3) {
> > +     if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_3) ||
> > +         (phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> >               dsi_phy_write(phy->base + REG_DSI_7nm_PHY_CMN_GLBL_DIGTOP_SPARE10, 0x1);
> >               udelay(500);
> >       }
> > @@ -894,7 +915,19 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
> >               lane_ctrl0 = 0x1f;
> >       }
> >
> > -     if (phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_3) {
> > +     if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> > +             if (phy->cphy_mode) {
> > +                     vreg_ctrl_0 = 0x45;
> > +                     vreg_ctrl_1 = 0x45;
> > +                     glbl_rescode_top_ctrl = 0x00;
> > +                     glbl_rescode_bot_ctrl = 0x00;
> > +             } else {
> > +                     vreg_ctrl_0 = 0x44;
> > +                     vreg_ctrl_1 = 0x19;
> > +                     glbl_rescode_top_ctrl = less_than_1500_mhz ? 0x3c :  0x03;
> > +                     glbl_rescode_bot_ctrl = less_than_1500_mhz ? 0x38 :  0x3c;
> > +             }
> > +     } else if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_3)) {
> >               if (phy->cphy_mode) {
> >                       glbl_rescode_top_ctrl = less_than_1500_mhz ? 0x3d :  0x01;
> >                       glbl_rescode_bot_ctrl = less_than_1500_mhz ? 0x38 :  0x3b;
> > @@ -943,9 +976,8 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
> >       dsi_phy_write(base + REG_DSI_7nm_PHY_CMN_RBUF_CTRL, 0x00);
> >
> >       /* program CMN_CTRL_4 for minor_ver 2 chipsets*/
> > -     data = dsi_phy_read(base + REG_DSI_7nm_PHY_CMN_REVISION_ID0);
> > -     data = data & (0xf0);
> > -     if (data == 0x20)
> > +     if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2) ||
> > +         (dsi_phy_read(base + REG_DSI_7nm_PHY_CMN_REVISION_ID0) & (0xf0)) == 0x20)
> >               dsi_phy_write(base + REG_DSI_7nm_PHY_CMN_CTRL_4, 0x04);
> >
> >       /* Configure PHY lane swap (TODO: we need to calculate this) */
> > @@ -1058,7 +1090,8 @@ static void dsi_7nm_phy_disable(struct msm_dsi_phy *phy)
> >       dsi_phy_hw_v4_0_config_lpcdrx(phy, false);
> >
> >       /* Turn off REFGEN Vote */
> > -     if (phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_3) {
> > +     if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V4_3) ||
> > +         (phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
> >               dsi_phy_write(base + REG_DSI_7nm_PHY_CMN_GLBL_DIGTOP_SPARE10, 0x0);
> >               wmb();
> >               /* Delay to ensure HW removes vote before PHY shut down */
> > @@ -1092,6 +1125,10 @@ static const struct regulator_bulk_data dsi_phy_7nm_97800uA_regulators[] = {
> >       { .supply = "vdds", .init_load_uA = 97800 },
> >   };
> >
> > +static const struct regulator_bulk_data dsi_phy_7nm_98400uA_regulators[] = {
> > +     { .supply = "vdds", .init_load_uA = 98400 },
> > +};
> > +
> >   const struct msm_dsi_phy_cfg dsi_phy_7nm_cfgs = {
> >       .has_phy_lane = true,
> >       .regulator_data = dsi_phy_7nm_36mA_regulators,
> > @@ -1201,3 +1238,26 @@ const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs = {
> >       .num_dsi_phy = 2,
> >       .quirks = DSI_PHY_7NM_QUIRK_V4_3,
> >   };
> > +
> > +const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs = {
> > +     .has_phy_lane = true,
> > +     .regulator_data = dsi_phy_7nm_98400uA_regulators,
> > +     .num_regulators = ARRAY_SIZE(dsi_phy_7nm_98400uA_regulators),
> > +     .ops = {
> > +             .enable = dsi_7nm_phy_enable,
> > +             .disable = dsi_7nm_phy_disable,
> > +             .pll_init = dsi_pll_7nm_init,
> > +             .save_pll_state = dsi_7nm_pll_save_state,
> > +             .restore_pll_state = dsi_7nm_pll_restore_state,
> > +             .set_continuous_clock = dsi_7nm_set_continuous_clock,
> > +     },
> > +     .min_pll_rate = 600000000UL,
> > +#ifdef CONFIG_64BIT
> > +     .max_pll_rate = 5000000000UL,
> > +#else
> > +     .max_pll_rate = ULONG_MAX,
> > +#endif
> > +     .io_start = { 0xae95000, 0xae97000 },
> > +     .num_dsi_phy = 2,
> > +     .quirks = DSI_PHY_7NM_QUIRK_V5_2,
> > +};
> >
>


-- 
With best wishes
Dmitry
