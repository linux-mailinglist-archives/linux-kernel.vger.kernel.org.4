Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E2D5BC56B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiISJda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiISJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:33:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6583F14031
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:33:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso4186351wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=d12+OyZjgr7PoWm5cPjXSNuyiIQvN3uPV/EGY5V2b1Q=;
        b=gnfr8cRXbS/wpbvVPvZcKVAjeMmrwlloM2/a/LrdrXKRopoda+y4KaVz6Iju/uYK1P
         toQR5Q7TobkmWgYQflg+5P8/eftdMw3JyxzmKyoTwa7E0u3e6/Ib2eRqCiqdIpafGHqk
         OezJxyh9DaEuQXclro49QZR4/pSvVkaTgGhJAOjKNdvDi1BcKVTR2aA95jMZuFZydubi
         KkpxQviaYs608z0ps55rGip2N2aPpzu0wckrt2joTIKOrveQE4WEzTryTpOWZq+1366i
         1hkUJzi8X5zwJwLS8e6/a6B6yh1js+HjL1v96fYcmUuWJIoWKjyB/aCqsMwhbcTDWFi7
         qL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=d12+OyZjgr7PoWm5cPjXSNuyiIQvN3uPV/EGY5V2b1Q=;
        b=XZWobLHL0DCzvsyBQ6awVw+IDYPAb8atbDN3uf4c3gP0iFGwVvSVfD9Dyp/wCW9d0x
         U7Iu8E4BTKMq3p8R/coGkaRir/WJBwJ8BgFXB7tjlRNv0z9BCLkNnM+xpOroWxRkWfXN
         3McARTAWAlmEcYtgQc8Jart2ycRS66ObE8/pqj2+TZUJxUDBIkQsdNCihTUZRVEucM3D
         FOinQsFh1chW+EGLZc+XSkP9f7dNEB5JMUiZ26AhEyTUlrU1US0lIcd3ZYdYtrR9LYe/
         4grsBMpEQpVdrxZdfgnBBTPA8bFkIKByERWdOexKkRa16V+K2YjSSS7Tj1sMrwmulRP7
         rSpQ==
X-Gm-Message-State: ACgBeo2ZNQeh5Bt9mX/5coUCFyaCxzjMkwGQSeluysYY3RBUzerAGb6A
        N1IgEeX1IlWdtu+I3BSFSGnyNA==
X-Google-Smtp-Source: AA6agR5lkQJ3tnCpGQZbJHAgXSSBjez6nvJjs1S6nmUjNgnywaLZOTGb8zhkbD7IGIUFr9qwaLADpQ==
X-Received: by 2002:a05:600c:a46:b0:3a6:9c49:b751 with SMTP id c6-20020a05600c0a4600b003a69c49b751mr18914823wmq.169.1663580000598;
        Mon, 19 Sep 2022 02:33:20 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003a342933727sm15121521wmp.3.2022.09.19.02.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 02:33:20 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:33:18 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Han Xu <han.xu@nxp.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:NXP i.MX CLOCK DRIVERS" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2] clk: imx: imx6sx: remove the SET_RATE_PARENT flag for
 QSPI clocks
Message-ID: <Yyg3XtsmMKgC9IDz@linaro.org>
References: <20220915150959.3646702-1-han.xu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915150959.3646702-1-han.xu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-15 10:09:59, Han Xu wrote:
> There is no dedicate parent clock for QSPI so SET_RATE_PARENT flag
> should not be used. For instance, the default parent clock for QSPI is
> pll2_bus, which is also the parent clock for quite a few modules, such
> as MMDC, once GPMI NAND set clock rate for EDO5 mode can cause system
> hang due to pll2_bus rate changed.
> 
> Fixes: f1541e15e38e ("clk: imx6sx: Switch to clk_hw based API")
> Signed-off-by: Han Xu <han.xu@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

Stephen, will you be picking this?

Thanks.

> 
> ---
> changes in v2
> - fix the build break due to missing close parenthesis
> ---
>  drivers/clk/imx/clk-imx6sx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
> index 2301d8fb8c76..d9ff831bdf47 100644
> --- a/drivers/clk/imx/clk-imx6sx.c
> +++ b/drivers/clk/imx/clk-imx6sx.c
> @@ -324,13 +324,13 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
>  	hws[IMX6SX_CLK_SSI3_SEL]           = imx_clk_hw_mux("ssi3_sel",         base + 0x1c,  14,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
>  	hws[IMX6SX_CLK_SSI2_SEL]           = imx_clk_hw_mux("ssi2_sel",         base + 0x1c,  12,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
>  	hws[IMX6SX_CLK_SSI1_SEL]           = imx_clk_hw_mux("ssi1_sel",         base + 0x1c,  10,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
> -	hws[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_hw_mux_flags("qspi1_sel", base + 0x1c,  7, 3, qspi1_sels, ARRAY_SIZE(qspi1_sels), CLK_SET_RATE_PARENT);
> +	hws[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_hw_mux("qspi1_sel",        base + 0x1c,  7,      3,      qspi1_sels,        ARRAY_SIZE(qspi1_sels));
>  	hws[IMX6SX_CLK_PERCLK_SEL]         = imx_clk_hw_mux("perclk_sel",       base + 0x1c,  6,      1,      perclk_sels,       ARRAY_SIZE(perclk_sels));
>  	hws[IMX6SX_CLK_VID_SEL]            = imx_clk_hw_mux("vid_sel",          base + 0x20,  21,     3,      vid_sels,          ARRAY_SIZE(vid_sels));
>  	hws[IMX6SX_CLK_ESAI_SEL]           = imx_clk_hw_mux("esai_sel",         base + 0x20,  19,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
>  	hws[IMX6SX_CLK_CAN_SEL]            = imx_clk_hw_mux("can_sel",          base + 0x20,  8,      2,      can_sels,          ARRAY_SIZE(can_sels));
>  	hws[IMX6SX_CLK_UART_SEL]           = imx_clk_hw_mux("uart_sel",         base + 0x24,  6,      1,      uart_sels,         ARRAY_SIZE(uart_sels));
> -	hws[IMX6SX_CLK_QSPI2_SEL]          = imx_clk_hw_mux_flags("qspi2_sel", base + 0x2c, 15, 3, qspi2_sels, ARRAY_SIZE(qspi2_sels), CLK_SET_RATE_PARENT);
> +	hws[IMX6SX_CLK_QSPI2_SEL]          = imx_clk_hw_mux("qspi2_sel",        base + 0x2c,  15,     3,      qspi2_sels,        ARRAY_SIZE(qspi2_sels));
>  	hws[IMX6SX_CLK_SPDIF_SEL]          = imx_clk_hw_mux("spdif_sel",        base + 0x30,  20,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
>  	hws[IMX6SX_CLK_AUDIO_SEL]          = imx_clk_hw_mux("audio_sel",        base + 0x30,  7,      2,      audio_sels,        ARRAY_SIZE(audio_sels));
>  	hws[IMX6SX_CLK_ENET_PRE_SEL]       = imx_clk_hw_mux("enet_pre_sel",     base + 0x34,  15,     3,      enet_pre_sels,     ARRAY_SIZE(enet_pre_sels));
> -- 
> 2.25.1
> 
