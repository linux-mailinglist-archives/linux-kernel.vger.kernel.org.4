Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D60632D02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiKUT3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKUT3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:29:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF71C4B50
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:29:19 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g12so21319304wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=75vBWBM19+UHLSvv+yKI6bYsJIRXQLQc7YhBfHY2I5Q=;
        b=IClFDSz+BFfQSzD7aT70HiDDUC1jHdNc6gyaeogYW7FUjnGiFam6+J531LwH8R9Yg+
         vSzVKu/f/Wj82qZnlab9xnn6Z/8pmZTpfwJLgEbVN6mszpC6GBKSXslNZZIlRA4kqmKc
         Qs8wuGkFB4efQRGUoA1mMBeyTzbjFN7TcdRqboT77Uq/EA0+1NPNodPTJl0rCAo6uv81
         3IwxazhnvqppQxTtBUxFEB/PqzzLvMsPQNiaON+dyCIjliPx8lTKdZaZPfgYYKxGutTg
         4QrwFxHQYuYSOvX0aXTS7XBJyAieggsM+7tIcqUgx9Ag8EmliBD6Gbywnk1GUL+cfMQl
         YBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75vBWBM19+UHLSvv+yKI6bYsJIRXQLQc7YhBfHY2I5Q=;
        b=pXbEtPOe9XtBIPHmEiTNlIAAGpDmoVzdYPeLIdeCVeYuE6phvgi91eouit8bwtvVp9
         WAkUT/F1APGDyjFk4wt+sfVxw5xQEB5qTGdkuqhWHftMKn7Kn2PtpWqwagIe1oCyhwiP
         mWH9OMRVKnV5/Uqm9GhN25Ipjjqn52n9f4SC9pZnicG96pWW40e9C/uxIRAew/OLtUrg
         G4/tWpN/LMm61rIfxdcxiGw0W58MPmjJUhie1kzqZRdTAlvjZFg7TcV4GBJwXBu6eTXZ
         dXWXx9JPpi0uNfoLu0Lawb5DSw5g1fMljm5BcRIpwV1wgNMCD/CC8D/xImisjd0gWuMA
         aFFQ==
X-Gm-Message-State: ANoB5pl37eqEyVgyO9aB++jI8Zd0sJC2DFniQ/r78YIVOackyGvM4vQz
        SU4ldSDxf9c75ykmKCPZWFeQuA==
X-Google-Smtp-Source: AA0mqf7+6SK7o4+TK+OIPnFSGL3QyPMMVUMCxCMGxIkuG2ps4F6Th6sFCHO3+g6S/TMl8KEzYZ+9vA==
X-Received: by 2002:a5d:474c:0:b0:234:d495:d3ae with SMTP id o12-20020a5d474c000000b00234d495d3aemr5078372wrs.448.1669058958299;
        Mon, 21 Nov 2022 11:29:18 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y15-20020a1c4b0f000000b003cf7292c553sm14579060wma.13.2022.11.21.11.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 11:29:17 -0800 (PST)
Date:   Mon, 21 Nov 2022 21:29:16 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bough Chen <haibo.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB
 offsets
Message-ID: <Y3vRjItCVhvCRLv4@linaro.org>
References: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-17 19:10:11, Giulio Benetti wrote:
> Fix IMXRT1050_CLK_LCDIF_APB offsets.
> 
> Fixes: 7154b046d8f3 ("clk: imx: Add initial support for i.MXRT1050 clock driver")
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

You dropped the patch version from the subject line.

Other than that:

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> V1->V2:
> * nothing done
> V2->V3:
> * added commit log and not only subject as suggested by Jesse Taube
> V3->V4:
> * added Fixes: as suggested by Fabio Estevam
> ---
>  drivers/clk/imx/clk-imxrt1050.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> index 9539d35588ee..26108e9f7e67 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -140,7 +140,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>  	hws[IMXRT1050_CLK_USDHC1] = imx_clk_hw_gate2("usdhc1", "usdhc1_podf", ccm_base + 0x80, 2);
>  	hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", "usdhc2_podf", ccm_base + 0x80, 4);
>  	hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", "lpuart_podf", ccm_base + 0x7c, 24);
> -	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x74, 10);
> +	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x70, 28);
>  	hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base + 0x7C, 6);
>  	hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", ccm_base + 0x7C, 7);
>  	imx_check_clk_hws(hws, IMXRT1050_CLK_END);
> -- 
> 2.34.1
> 
