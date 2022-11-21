Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E83632F94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiKUWK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKUWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:10:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC18BC80D7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:10:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l14so3059577wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRR3RzwlMsl9gUPziLpbyooFq3AsphOP+PSPpJyQx+g=;
        b=C9GzapMbOacL8zYzDWVRs3+/qYM5T0y9fqflHl2TZzs/cvYUqdRLb41zQHEiWHYCKp
         h/bCDgG2xspXa6kEY6kohfT9DF1yYbe5d8J7D60CkfnPIqFqo8j2D8belLI8s83k3GsG
         H+goshF4jxdAZMvznPliyUororU22VOCy8Rsyq52mArVtPE9YjYRVWg0+SB4J1pQf1mO
         MYR0x9iV8YqUh7wutK2mzsh0TJhRyOzAPV8DSTmN/nd+gftLU56v3p2y0tRYksgsUMsA
         Kg58RLc1/7R8n5e9SBbpOhrmsUUIDokaaWlFE7xKuPAbL6qWDHNG+d3q+LN4s9BUrTMO
         pvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRR3RzwlMsl9gUPziLpbyooFq3AsphOP+PSPpJyQx+g=;
        b=1w7rdHyAVNtd7JFwM/eqy/1zQOchA66tVkDhaKzKvMuz2afCbBELvFpAK3UEFafsPx
         vdUDR/O0UHlpP1Jm+Wmw/F/mE4VNGNNTVp+E4eHexjL+0W9Ht91PLjOccce64yZXL5Zd
         da4yCFuJRVp0qFVFxL+nH06IUEu3UtRcC3Q2tacVJ4Grj9OTS2eDwMMzdtlaP201JH/Z
         +fN3Mh5P+vCOgSrdUgg9sjzdOjS46AQJyCArfBxRlFbm2as/y+hWIWEbeY6Isr3rPalM
         t/N4u4oI6H4K8Tk9AN8Ib5lPVQIzIHXD6d35/h5PNR0pn1US1i8DP6IlYmrSA4YFZFh/
         j0EQ==
X-Gm-Message-State: ANoB5pn+YSxFbQe70h/A6T6slzCtmA8xZhOr4ujKuLjquwCjBvWazaJJ
        jGNWqnI0/IhDrfcmRoWKU3S9EQ==
X-Google-Smtp-Source: AA0mqf40nJIz/c53JTgd3rI7SoVigsjcW9HIqTgE2EGcTELGqjwqtXv0Caae2rk0B3ZgLA+eM1h+6w==
X-Received: by 2002:adf:db4e:0:b0:241:c694:f4b9 with SMTP id f14-20020adfdb4e000000b00241c694f4b9mr8276456wrj.552.1669068618184;
        Mon, 21 Nov 2022 14:10:18 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c3b8e00b003b4c979e6bcsm21983306wms.10.2022.11.21.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 14:10:17 -0800 (PST)
Date:   Tue, 22 Nov 2022 00:10:15 +0200
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
Message-ID: <Y3v3R94KF8/ygnkT@linaro.org>
References: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117181014.851505-1-giulio.benetti@benettiengineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Applied patches #1 and #2. Thanks.

As a suggestion, next time, please send two separate patchsets,
since there are two different subsystems involved (and the patches #3
and #4 are not related to #1 and #2).

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
