Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546CC680085
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjA2RnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 12:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjA2RnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:43:06 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D210D2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:43:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m15so6601252wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EESc6yHcetQSdYJXbMgFW7vC03SHAVb9eblyBiy6LFU=;
        b=y01AtHPUuoTnAyyQI5Y84VCRlVRSr6eK1jtn5D9X0DeY0QtIqW7YKA7tL67ecJs0jS
         taxMzSGnxw19AK5gbJZAxDxZq4FaRiVmOA0m6JnWFtG5vT6qT98kqn9dPPh07HeOrqjN
         fvB4+zd1zcLkNC9evzo/NR29Bb5C/X3/6awaXbJ9vE3LcLIglsgTpwsbaBCC7E+jgFsz
         LpQXWmO/MlfK6hSkR7YlLs02RpeoTHMwyKH436Rxp52pQHvyg5IGFtqP1usdCbr7/Ea4
         quCDo3cBFfXG8cvkjcG0LC2wa2Bf089k4P5K3Iy/XaqTYHHI1hNol7f5jtreas3zrIBD
         RPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EESc6yHcetQSdYJXbMgFW7vC03SHAVb9eblyBiy6LFU=;
        b=5Bwed8JIu2U0VGK5xUvzXyY7/NjdjQ3iv0JdphrJvshbiy7fO81lFwyBQ668gGYc7r
         ATbTsm5fy4jU9e4IVGh51yVFgOCUpzee5JtQYns+5rUzHmFJlGwTQwGVR1PNPslxiQsz
         7QALsJ2McGtDkFIJw6qD+z1o2q3mug7BNuPz2H69Gdmii9qymiqpLEDPAf7L3rbs06nI
         5yptVWSsyYaOswIGE0BU2EoraOr5dEQSopqNBuWw4odgEZC5OE1WoQuUiANKaTBOwBBq
         y1gh41bMJ3xwL/Kayz5ion2xsJeRLOHKJiPA54MWN0yayCIRjSA6ehKXONZKKLfRzckk
         6hWw==
X-Gm-Message-State: AO0yUKUiMXKs67eh6VlH3f1pLRDpV0df43+b7fH4kV4CB4LP5wG3bLqM
        FvPDhn1inDqB6O25RykL5s+B2Q==
X-Google-Smtp-Source: AK7set+2UOrnRZs2WQATlKfJG00hkAln8uWzTi7jsYZeI2wVskdLLWL0SHLBX0y2Hy280n/qgI8G6A==
X-Received: by 2002:a05:600c:6008:b0:3da:282b:e774 with SMTP id az8-20020a05600c600800b003da282be774mr2998074wmb.38.1675014185123;
        Sun, 29 Jan 2023 09:43:05 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d640e000000b002bfb5bda59asm9737686wru.25.2023.01.29.09.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 09:43:04 -0800 (PST)
Date:   Sun, 29 Jan 2023 19:43:03 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1 2/2] dt-bindings: imx8ulp: clock: no spaces
 before tabs
Message-ID: <Y9awJ04VzbGexSuc@linaro.org>
References: <20230119085421.102804-1-marcel@ziswiler.com>
 <20230119085421.102804-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119085421.102804-3-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19 09:54:21, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes the following warnings:
> 
> include/dt-bindings/clock/imx8ulp-clock.h:204: warning: please, no space
>  before tabs
> include/dt-bindings/clock/imx8ulp-clock.h:215: warning: please, no space
>  before tabs
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> 
> ---
> 
>  include/dt-bindings/clock/imx8ulp-clock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/imx8ulp-clock.h b/include/dt-bindings/clock/imx8ulp-clock.h
> index 953ecfe8ebcc..827404fadf5c 100644
> --- a/include/dt-bindings/clock/imx8ulp-clock.h
> +++ b/include/dt-bindings/clock/imx8ulp-clock.h
> @@ -201,7 +201,7 @@
>  #define IMX8ULP_CLK_SAI7		2
>  #define IMX8ULP_CLK_SPDIF		3
>  #define IMX8ULP_CLK_ISI			4
> -#define IMX8ULP_CLK_CSI_REGS 		5
> +#define IMX8ULP_CLK_CSI_REGS		5
>  #define IMX8ULP_CLK_PCTLD		6
>  #define IMX8ULP_CLK_CSI			7
>  #define IMX8ULP_CLK_DSI			8
> @@ -212,7 +212,7 @@
>  #define IMX8ULP_CLK_GPU2D		13
>  #define IMX8ULP_CLK_GPU3D		14
>  #define IMX8ULP_CLK_DC_NANO		15
> -#define IMX8ULP_CLK_CSI_CLK_UI 		16
> +#define IMX8ULP_CLK_CSI_CLK_UI		16
>  #define IMX8ULP_CLK_CSI_CLK_ESC		17
>  #define IMX8ULP_CLK_RGPIOD		18
>  #define IMX8ULP_CLK_DMA2_MP		19
> -- 
> 2.36.1
> 
