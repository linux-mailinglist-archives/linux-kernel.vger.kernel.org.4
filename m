Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B76966BD28
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjAPLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjAPLrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:47:43 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA0113D6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:47:42 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id o75so29982226yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RBf39+z4ErBa48WOVq36Ef3lCWm7DQwVSyfmLd9/PQE=;
        b=SZtEaI37+UvOiuCsh7Z8U1GbTRPuHHkCPFC9ujGTJKN+/e5MxOWwDXcd17t8kRciqM
         LuAZN9jlv+Uif6o6JolMySPsGuwXe5KJJ5/Oi6t6jpxYJEN9T5nPJHBYJjRFTm+fT0NI
         ++ighlshCjO6sDZnRp1RoGvPz8rSVoNAVFLiw4Q4k3/BwaTpAMExtj/DT2ECOV9XbFJ8
         oud4jnAx6GuqiYSIPHqz8N86LiTALmx3gccmIyJf6BfyzL/0EHU2t+QtTzwtz8sDVZSt
         LSOAbvoZMNpAT5S1EG3SBZHidrBMYzo7Y0sj1KhMzEscdU8e+3FxPI46hhS04NJ3xCTh
         87uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBf39+z4ErBa48WOVq36Ef3lCWm7DQwVSyfmLd9/PQE=;
        b=hnTAIaxhGRk9dHXK+OyjAHv2w7+HWKShl9csXfOub7ajzwaLrsqRTujL21LdCShtf+
         jDux2UiWn5q85R9JPlYx+HPEFhlAJ6+45dMdusbW0sHwg5vv3fTlYmF3xer2MAFBDZD0
         f+4GRY0x0zEyo0qfs586IKblXXTHLLNnc3CEEnNn5FZK0N/r2YWrmhS24p0gJgQEpqDV
         Ce/qzgdJ137b85Qr5Tiy9cMq73rSUn8apZd94PVzaewtpKv4jto4DxgXcuPcCG1XBuHB
         Y/v4qC+5niVYGPEiHiAGLYcHi/J5oOExBXFP391nqBMD0JTIQUdunuMbQx/PyAek3pFE
         8y0Q==
X-Gm-Message-State: AFqh2koBPkZkfAVDN0C0VYtPMJ1ig0iBVwv8IfAWkzjJJ3Ypjru9M1Wk
        Pd9W+llo7GJ8JIazEqBq9B2RoPYBHr+Hp40XvIkXcg==
X-Google-Smtp-Source: AMrXdXtHHHK1YcteV3Q0i4v+HDquYjRu4C/hl7moGBKdK9coM9J1UhmoR+Sv0CC5pOUAkzLqAAKY7j4Gk17/dJEEn0E=
X-Received: by 2002:a25:606:0:b0:709:9335:236e with SMTP id
 6-20020a250606000000b007099335236emr7936674ybg.288.1673869661448; Mon, 16 Jan
 2023 03:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20230116114059.346327-1-konrad.dybcio@linaro.org>
 <20230116114059.346327-2-konrad.dybcio@linaro.org> <3b4e5183-25c4-ab04-6b0c-74a57540d00e@linaro.org>
In-Reply-To: <3b4e5183-25c4-ab04-6b0c-74a57540d00e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 16 Jan 2023 13:47:30 +0200
Message-ID: <CAA8EJprgFA-vod9vnt+uzptzgbvbrMSe+zOpd2ftsz0pS9jb8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/dsi: Add phy configuration for SM6375
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        sunliming <sunliming@kylinos.cn>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 at 13:42, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 16.01.2023 12:40, Konrad Dybcio wrote:
> > From: Konrad Dybcio <konrad.dybcio@somainline.org>
> >
> > SM6375 uses a boring standard 7nm PHY. Add a configuration entry for it.
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > ---
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Sorry, bit messy revisiting old patches before the email change..
>
> Konrad
> > Depends on [1] to work properly, but won't hurt for it to land
> > separately..
> >
> > [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1642586079-12472-1-git-send-email-loic.poulain@linaro.org/
> >
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 20 ++++++++++++++++++++
> >  3 files changed, 23 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > index cbe669fca26d..57445a5dc816 100644
> > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > @@ -569,6 +569,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
> >         .data = &dsi_phy_7nm_8150_cfgs },
> >       { .compatible = "qcom,sc7280-dsi-phy-7nm",
> >         .data = &dsi_phy_7nm_7280_cfgs },
> > +     { .compatible = "qcom,sm6375-dsi-phy-7nm",
> > +       .data = &dsi_phy_7nm_6375_cfgs },
> >       { .compatible = "qcom,sm8350-dsi-phy-5nm",
> >         .data = &dsi_phy_5nm_8350_cfgs },
> >       { .compatible = "qcom,sm8450-dsi-phy-5nm",
> > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > index 5f0b1c9b09ef..c849bfd7494e 100644
> > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > @@ -55,6 +55,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_14nm_8953_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_10nm_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_10nm_8998_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_7nm_cfgs;
> > +extern const struct msm_dsi_phy_cfg dsi_phy_7nm_6375_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_7nm_7280_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8350_cfgs;
> > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> > index af5c952c6ad0..3b1ed02f644d 100644
> > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> > @@ -1152,6 +1152,26 @@ const struct msm_dsi_phy_cfg dsi_phy_7nm_cfgs = {
> >       .quirks = DSI_PHY_7NM_QUIRK_V4_1,
> >  };
> >
> > +const struct msm_dsi_phy_cfg dsi_phy_7nm_6375_cfgs = {
> > +     .has_phy_lane = true,

Any regulators here?

> > +     .ops = {
> > +             .enable = dsi_7nm_phy_enable,
> > +             .disable = dsi_7nm_phy_disable,
> > +             .pll_init = dsi_pll_7nm_init,
> > +             .save_pll_state = dsi_7nm_pll_save_state,
> > +             .restore_pll_state = dsi_7nm_pll_restore_state,
> > +     },
> > +     .min_pll_rate = 600000000UL,
> > +#ifdef CONFIG_64BIT
> > +     .max_pll_rate = 5000000000ULL,
> > +#else
> > +     .max_pll_rate = ULONG_MAX,
> > +#endif
> > +     .io_start = { 0x5e94400 },
> > +     .num_dsi_phy = 1,
> > +     .quirks = DSI_PHY_7NM_QUIRK_V4_1,
> > +};
> > +
> >  const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs = {
> >       .has_phy_lane = true,
> >       .regulator_data = dsi_phy_7nm_36mA_regulators,



-- 
With best wishes
Dmitry
