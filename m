Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D086B066B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjCHLyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjCHLxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:53:49 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633601517A;
        Wed,  8 Mar 2023 03:53:30 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y11so17435513plg.1;
        Wed, 08 Mar 2023 03:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678276409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vj24eZaGsqAjYr4sP0gslIio7aH6ugMTgwkDBRsU18=;
        b=VXH3SA8b1U9e3CJ37OWVuPaHy4IdZVCpO7caEmSCMriN3yPHWEtYJxrxv31ce82qh5
         epd19iy1fddh/mZZZsm5qkA+F5Druqh5ZkKDN2QmDBOVlQ/TB9FVoDrRMBXIJvdhrm/r
         dgJPzzVHOWzYe5CR1JTLK4ThkEbRG6OROW4j4qpOt7GW9buFuRiA5SMDEJ033/FjWz/b
         WZ1MPDQ8NQQdnw+tHP6wy2B10vnLL21fCi4MulyEoFOWKsBVJkXE+jg9pvbkjutb+pv8
         Il84J5edsysbV32qkSXRVZf7B7/VyX37phbVBJzdURBoIkosotGAetagsP+HhvxRKL1D
         cRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Vj24eZaGsqAjYr4sP0gslIio7aH6ugMTgwkDBRsU18=;
        b=RhEgav2xpZ+DORVOuRTCAL9+EOXC205G9KxJv7Fjyh+mWRgvHGSwfvASwDjawOO9R2
         vANB6UKqyiwFudLJ2eb0iBJA/sp9LCY/eJDFGnU2o2+yNBxLuVDKJoN1c2skWJSsFpM2
         0AfX5M2pc4prdwf6zPcah2XY4rYsjf8GLPYzi6viaxQBHm4AS5ZB9v2wpc0Yh7WXYFAR
         qyrTKk5O71oi0EGIDSss39Q06mSh3gbq/YybZ/5EQp86cmuIaZ3fHoxdq9agnq4hQKqH
         utF40fXZBa0uqISCEFqtTtZIsWueUu2OCnPujBHaR2kdwB2+aBgXa9u0M/6uxzxQbtmq
         GH1g==
X-Gm-Message-State: AO0yUKWv2IXYZPRahmUO6mvVn/9jVA6NXdCTrfDYJFd2wrdski/IA1hw
        hoM43zgDFhd+RTH650E2TpM=
X-Google-Smtp-Source: AK7set/dfmC6kYdQhlgkAkhfYlYdPwpyBeTjunHGXTNwJ9uFFNX1eyDEQc2zNVtDi/vXIg7yaraeXw==
X-Received: by 2002:a17:90a:de94:b0:234:881b:2e8b with SMTP id n20-20020a17090ade9400b00234881b2e8bmr18843695pjv.49.1678276409123;
        Wed, 08 Mar 2023 03:53:29 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090a2f8e00b00230da56ddecsm8911479pjd.27.2023.03.08.03.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 03:53:28 -0800 (PST)
Date:   Wed, 8 Mar 2023 19:53:21 +0800
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
Message-ID: <ZAh3MSpQ30YyPAVe@Gentoo>
References: <20230308043706.16318-1-lujianhua000@gmail.com>
 <20230308043706.16318-2-lujianhua000@gmail.com>
 <66d293a8-f850-cb80-0c83-2ebf7e29d0c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d293a8-f850-cb80-0c83-2ebf7e29d0c2@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 12:13:53PM +0100, Konrad Dybcio wrote:
> 
> 
> On 8.03.2023 05:37, Jianhua Lu wrote:
> > Add a driver for panels using the Novatek NT36523 display driver IC.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > Changes in v3:
> >   - Refactor source code
> > 
> > Changes in v2:
> >   - Refactor and clean up source code
> This is a veeery vague changelog, akin to "change patch", please
> be more specific the next time around.
> 
Acked, thanks
> 
> [...]
> 
> > +#define DSI_NUM_MIN 1
> > +
> > +/* Macro modified from mipi_dual_dsi_dcs_write_seq */
> > +#define mipi_dual_dsi_dcs_write_seq(dsi, cmd, seq...)           	   \
> > +	do {                                                               \
> > +		static const u8 d[] = { cmd, seq };                        \
> > +		int i, ret;                                                \
> > +		for (i = 0; i < ARRAY_SIZE(dsi); i++) {                    \
> > +			ret = mipi_dsi_dcs_write_buffer(dsi[i], d, ARRAY_SIZE(d));    \
> > +			if (ret < 0) {                                             \
> > +				dev_err_ratelimited(                               \
> > +					&dsi[i]->dev, "sending command %#02x failed: %d\n", \
> > +					cmd, ret);                                 \
> > +				return ret;                                        \
> > +			}                                                          \
> > +		}                                                                  \
> > +	} while (0)
> > +
> This should definitely be put in a common file..
Acked.
> 
> 
> > +static const struct drm_display_mode elish_boe_mode = {
> > +	/* Current max freqency is 104HZ, TODO 120HZ */
> Is it a DPU issue, or does the panel not work correctly when you
> jack up the clocks? Did you use the correct init sequence and porches
> for the 120Hz mode, including the mode switch command set?
> 
panel will turn into bluescreen when freqency overs 104HZ, downstream
seems use a dsi-cphy enhance feature to make it working. Init sequence
and porches are right

> Could you also implement a 60 (or whatever other value is also
> implemented downstream) Hz mode?
I will try to implement it.
> 
> > +	.clock = (1600 + 60 + 8 + 60) * (2560 + 26 + 4 + 168) * 104 / 1000,
> > +	.hdisplay = 1600,
> > +	.hsync_start = 1600 + 60,
> > +	.hsync_end = 1600 + 60 + 8,
> > +	.htotal = 1600 + 60 + 8 + 60,
> > +	.vdisplay = 2560,
> > +	.vsync_start = 2560 + 26,
> > +	.vsync_end = 2560 + 26 + 4,
> > +	.vtotal = 2560 + 26 + 4 + 168,
> > +};
> > +
> > +static const struct drm_display_mode elish_csot_mode = {
> > +	/* Current max freqency is 104HZ, TODO 120HZ */
> > +	.clock = (1600 + 200 + 40 + 52) * (2560 + 26 + 4 + 168) * 104 / 1000,
> > +	.hdisplay = 1600,
> > +	.hsync_start = 1600 + 200,
> > +	.hsync_end = 1600 + 200 + 40,
> > +	.htotal = 1600 + 200 + 40 + 52,
> > +	.vdisplay = 2560,
> > +	.vsync_start = 2560 + 26,
> > +	.vsync_end = 2560 + 26 + 4,
> > +	.vtotal = 2560 + 26 + 4 + 168,
> > +};
> > +
> > +static const struct panel_desc elish_boe_desc = {
> > +	.modes = &elish_boe_mode,
> > +	.dsi_info = {
> > +		.type = "NT36523",
> That's a bit vague, the driver IC is not very telling about the
> panel itself. Since we're not able to determine much more information,
> this could contain the panel manufacturer and the device name.
Acked.
> 
> > +		.channel = 0,
> > +		.node = NULL,
> > +	},
> > +	.width_mm = 127,
> > +	.height_mm = 203,
> > +	.bpc = 8,
> > +	.lanes = 3,
> > +	.format = MIPI_DSI_FMT_RGB888,
> > +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
> > +	.init_sequence = elish_boe_init_sequence,
> > +	.is_dual_dsi = true,
> > +};
> > +
> [...]
> 
> > +static int nt36523_probe(struct mipi_dsi_device *dsi)
> > +{
> [...]
> 
> > +	/* If the panel is dual dsi, register DSI1 */
> > +	if (pinfo->desc->is_dual_dsi) {
> > +		info = &pinfo->desc->dsi_info;
> > +
> > +		dsi1 = of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
> > +		if (!dsi1) {
> > +			dev_err(dev, "cannot get secondary DSI node.\n");
> > +			return -ENODEV;
> > +		}
> > +
> > +		dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
> > +		of_node_put(dsi1);
> Shouldn't you put the reference only if it's found?
thanks for spot it.
> 
> > +		if (!dsi1_host) {
> > +			dev_err(dev, "cannot get secondary DSI host\n");
> > +			return -EPROBE_DEFER;
> dev_err_probe, here and in neighbouring exit return paths?
Acked.
> 
> 
> Konrad
