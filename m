Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED26B0992
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjCHNk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjCHNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:40:05 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7314824C94;
        Wed,  8 Mar 2023 05:38:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so3820745pjb.0;
        Wed, 08 Mar 2023 05:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678282687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEoW7Edk44DGWc4GB3PWBqttLOpuxjyKXvitXj1SBNA=;
        b=WPZmR06RJjaBgYuthIiHCOGVm22ZUKax0GCCS1OoDD2LO7Fr+b4Dpmsm71txU4PjFu
         vByAePacf8e2mGFRSXX4EvVo/iQcO57+8R+s3m9Cz+iaNSxWgy6YoRfpquPChgobmlUS
         uiuT/CyD/8W8VUFLNBSZ6hFhuLBUs5+7OINgeMzAPW4vsF4Oaz7ZzDvyxsM3DWP2Dn6P
         f6AfMQ3c02pZkLXQ6hi429wOf0UQtAoqGztMVeD8zMjSqOujbM4cCk4oXlHOiDnjQhD2
         aAi83zB60CKa9AiKLWkY6Tl7Lq8QTARs2ft5Fwv/EL10Mv9eqMECfAAAyoJVFctZq9z6
         WapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678282687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEoW7Edk44DGWc4GB3PWBqttLOpuxjyKXvitXj1SBNA=;
        b=v0ZrEyI+f/xVaGZXoJYfaROWw69VdRGfUufL7K/y+FNzJVLClxw1qK0eu11S4xVplQ
         99OoSFxjN/cWQzgB6WKym7Jhrp/5bv3Y9kWAyXou+hXt6/ZprdnCFJrBZPLLYxq/3mmo
         A941cWlJHsyXG9hQMyEWwcIW+j4ccSk84uEM5U+2DoOw1PhbIy+uN/1t6/Prb6rk6xVp
         vvz1x2UcC4Eqd5PVypQlkmvoOkCVwyrPJg7did4kUCSp/tsNE3frddgu0Uay+gIl1OgT
         5puLJdCPDfzpvn2TrjllcNKiG3neDIg+ET/p9gSuV3Zz+rXZZI6V+URzAn+XSdJzj7ke
         QZ9w==
X-Gm-Message-State: AO0yUKU7saONjPnHGCrjQuuvVuILPoeI7T/WZz9dA4tRe4jdimCYxDRq
        h3HYJk43tlV7vfOZ1olN2Uo=
X-Google-Smtp-Source: AK7set/0r12xxZn37DfmlBs5S3EQxFWTEtKllSI2HMgFh3/2TjUn5CNF8v1MNVCn8BMZo2S3AXSw2Q==
X-Received: by 2002:a17:90b:1a8b:b0:234:2007:1ff6 with SMTP id ng11-20020a17090b1a8b00b0023420071ff6mr22771976pjb.14.1678282687514;
        Wed, 08 Mar 2023 05:38:07 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id j24-20020a17090a589800b002369e16b276sm10709273pji.32.2023.03.08.05.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:38:07 -0800 (PST)
Date:   Wed, 8 Mar 2023 21:37:59 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/panel: Add driver for Novatek NT36523
Message-ID: <ZAiPTat/kmLyaJmA@Gentoo>
References: <20230308043706.16318-1-lujianhua000@gmail.com>
 <20230308043706.16318-2-lujianhua000@gmail.com>
 <66d293a8-f850-cb80-0c83-2ebf7e29d0c2@linaro.org>
 <ZAh3MSpQ30YyPAVe@Gentoo>
 <1cbe9e29-13a4-574e-6d8c-b2506e7a36b3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbe9e29-13a4-574e-6d8c-b2506e7a36b3@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 01:33:39PM +0100, Konrad Dybcio wrote:
> 
> phy-type:
>     description: D-PHY (default) or C-PHY mode
>     enum: [ 10, 11 ]
>     default: 10
> 
> try setting that to 11 under your DSI PHYs (or one? not sure).
I already used phy-type = <PHY_TYPE_CPHY> before, this equate to qcom,panel-cphy-mode in
downstream panel device tree, but there is qcom,mdss-dsi-cphy-strength isn't
implemented.
> Konrad
> > 
> >> Could you also implement a 60 (or whatever other value is also
> >> implemented downstream) Hz mode?
> > I will try to implement it.
> >>
> >>> +	.clock = (1600 + 60 + 8 + 60) * (2560 + 26 + 4 + 168) * 104 / 1000,
> >>> +	.hdisplay = 1600,
> >>> +	.hsync_start = 1600 + 60,
> >>> +	.hsync_end = 1600 + 60 + 8,
> >>> +	.htotal = 1600 + 60 + 8 + 60,
> >>> +	.vdisplay = 2560,
> >>> +	.vsync_start = 2560 + 26,
> >>> +	.vsync_end = 2560 + 26 + 4,
> >>> +	.vtotal = 2560 + 26 + 4 + 168,
> >>> +};
> >>> +
> >>> +static const struct drm_display_mode elish_csot_mode = {
> >>> +	/* Current max freqency is 104HZ, TODO 120HZ */
> >>> +	.clock = (1600 + 200 + 40 + 52) * (2560 + 26 + 4 + 168) * 104 / 1000,
> >>> +	.hdisplay = 1600,
> >>> +	.hsync_start = 1600 + 200,
> >>> +	.hsync_end = 1600 + 200 + 40,
> >>> +	.htotal = 1600 + 200 + 40 + 52,
> >>> +	.vdisplay = 2560,
> >>> +	.vsync_start = 2560 + 26,
> >>> +	.vsync_end = 2560 + 26 + 4,
> >>> +	.vtotal = 2560 + 26 + 4 + 168,
> >>> +};
> >>> +
> >>> +static const struct panel_desc elish_boe_desc = {
> >>> +	.modes = &elish_boe_mode,
> >>> +	.dsi_info = {
> >>> +		.type = "NT36523",
> >> That's a bit vague, the driver IC is not very telling about the
> >> panel itself. Since we're not able to determine much more information,
> >> this could contain the panel manufacturer and the device name.
> > Acked.
> >>
> >>> +		.channel = 0,
> >>> +		.node = NULL,
> >>> +	},
> >>> +	.width_mm = 127,
> >>> +	.height_mm = 203,
> >>> +	.bpc = 8,
> >>> +	.lanes = 3,
> >>> +	.format = MIPI_DSI_FMT_RGB888,
> >>> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
> >>> +	.init_sequence = elish_boe_init_sequence,
> >>> +	.is_dual_dsi = true,
> >>> +};
> >>> +
> >> [...]
> >>
> >>> +static int nt36523_probe(struct mipi_dsi_device *dsi)
> >>> +{
> >> [...]
> >>
> >>> +	/* If the panel is dual dsi, register DSI1 */
> >>> +	if (pinfo->desc->is_dual_dsi) {
> >>> +		info = &pinfo->desc->dsi_info;
> >>> +
> >>> +		dsi1 = of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
> >>> +		if (!dsi1) {
> >>> +			dev_err(dev, "cannot get secondary DSI node.\n");
> >>> +			return -ENODEV;
> >>> +		}
> >>> +
> >>> +		dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
> >>> +		of_node_put(dsi1);
> >> Shouldn't you put the reference only if it's found?
> > thanks for spot it.
> >>
> >>> +		if (!dsi1_host) {
> >>> +			dev_err(dev, "cannot get secondary DSI host\n");
> >>> +			return -EPROBE_DEFER;
> >> dev_err_probe, here and in neighbouring exit return paths?
> > Acked.
> >>
> >>
> >> Konrad
