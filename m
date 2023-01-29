Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BBA680088
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjA2RpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 12:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjA2RpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:45:01 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1204D6EB5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:44:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so8601350wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDVqMwkXzQiwnLCIs/h43LafiVs1rZMTm8awi1qCCKc=;
        b=w0aTvaIintJcu8HU7uxDd+368iaEn8jPDp5DkzPJFdRPAwMrnip0Y77XTRfcJBAdHj
         VWTidx1OV9y+w7+urHB/D+3I3K17rwJZbw7QYHtpaaIAXdBALUARE+t7mgaI4Wfw3IUH
         GxyVFgg73RVe1BnW83ZJvtaIDw2ts0ODJ+TICcSb13MDrOOt1AwvudgwTzv2jeHzwXS6
         YLbt3dPHP6LYvyUikKHBn65VPT0Cau8k1DSzDEV8vHxgcc/PydLwMSZo3gCJewqhNU9X
         Padm4pJxlO9d+5aaSaEb752vxypSJyeab7IMASNwwtHsQ62dE50IDtJITU0rUKtJ+rPu
         Sx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDVqMwkXzQiwnLCIs/h43LafiVs1rZMTm8awi1qCCKc=;
        b=plaZRjvTWVg5mdogbCStlwpf/2ePqE933YZwErlUdY0veUSRtA7zrcricS/NB0bI5O
         IPTcTT+wKWgOyAQ/hwX5sA2uqGRVEORXz5VrP3BvrmVc0hh2Ww3uuNmZwk+omOJL28gj
         j/FrsEzK+Cm75Rgjy2ldy0rb+j007ekJXiGjO81j0Qz2Wsr1pkk88IlgShIvWQ40SZc8
         Pik2WsHAWTOVhEHfjy9E6XLJAttvDscdJPB57xx0+VwY9WyGbUN6y3eYnYMb9fUPhaVX
         Rle/FKOasqemkQz577+bO+eiu1rsneOi1vaLUdRRDH7lBRCF//ODjfk4eBcihcgypTHG
         Yj8g==
X-Gm-Message-State: AO0yUKX9PdfYdTMVOLVccVpL/hr7rTYk2CesLm07Ckh/46TzoP/7TKEf
        zYcxLx0fs3BKgG2W+GBAiRzsRg==
X-Google-Smtp-Source: AK7set9OhOe4XHsV2+ozJ/7/aDfXe0ptogZxgvVXaITVWgOHypR3+G8KPJ7ocr022Dmi0R2srkRVIw==
X-Received: by 2002:a05:600c:1e08:b0:3dc:58fb:c1eb with SMTP id ay8-20020a05600c1e0800b003dc58fbc1ebmr1126427wmb.8.1675014297663;
        Sun, 29 Jan 2023 09:44:57 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003d9fba3c7a4sm14899978wmq.16.2023.01.29.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 09:44:57 -0800 (PST)
Date:   Sun, 29 Jan 2023 19:44:55 +0200
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
Message-ID: <Y9awlwWhjoH77dM2@linaro.org>
References: <20230119085421.102804-1-marcel@ziswiler.com>
 <20230119085421.102804-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119085421.102804-3-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Applied both.

Thanks.

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
