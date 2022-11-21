Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD1632CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiKUT0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiKUT0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:26:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A99A273
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:26:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id g12so21309694wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZL6rLSjizF6F00imfDrFMSQ/wOdXEjel6osgWFNPC0=;
        b=atyYg8gYVIhmIFzcSF88hX9vc6gWRn7Z576mhNVRnpIrwfucmpdrazHU0U/N/xOSSX
         B4afvQa36DDrPjinYnBlTUwpEoXoZhgJaqUM2ynKK1KGpbeRQL4atSL9F1oBI1rdCAmI
         2yLr/tloD+Pg2+r08gGhfD31OjPg4qACJQ2kVvSO3DZBTQIDwcqinQ7RGLgSpwuY9RH+
         GCAQQ2/5PBAJ2RhtXFtyyQRSB7MkhiKtTb+oLpwChX6lZU3fX9+wUwOXOX/VmU6oDEzR
         wYEBGhA3V+3/spRDATk+YwzPmkXqUi2rsKKcnz58j0sWPNyP8ULT0AhNv+yw51W2UXXF
         PJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZL6rLSjizF6F00imfDrFMSQ/wOdXEjel6osgWFNPC0=;
        b=mB37+9zjiFSXPbrDz+3WTmSA898hYwXGpZ4kgWW4Ja56V792o5JRx+zgbAheSXwk+7
         djohFtL8AcSDHmJn+j4MDz1XctlOpYC2ju4NWz3AxUf+doQeJizYy0sBhDC51Kmj39wC
         6D9iGdExO/Qvz5Wy6hVDpOxHYQUiqMURUOzrVg/nx2B/7k3LUcYCH0mMVxpbV4L/1MvJ
         t5DSSik3lXxY4JV1AnmwnwiWtcX05GVzJcxseyan8K+qh4cvUzYQBtTmLXWTscA3xfbH
         NVbLpe93UOj6r9zr1EN0VyXQHCxv+fJo+tEY0RawImq0e78CYuVscKhXRCwZ/lGpcVfe
         /cnQ==
X-Gm-Message-State: ANoB5pks3Jx9MExnpoo5RpQmmZQECc8hIyPXUrmrwdKFaB/kUb4ChRBJ
        L1PTsJ5+flEt1lrbQ3DPk1Qv5w==
X-Google-Smtp-Source: AA0mqf78fNj3kHp6o5Hgjh/rdsY6F2cjjjqHn4aCQo9tYpssMt4RyiI+CAYKm2SYwU9+HoLc+FrBpA==
X-Received: by 2002:adf:dd81:0:b0:236:88a2:f072 with SMTP id x1-20020adfdd81000000b0023688a2f072mr12136401wrl.516.1669058789434;
        Mon, 21 Nov 2022 11:26:29 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id c1-20020adffb01000000b0023657e1b980sm11878553wrr.53.2022.11.21.11.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 11:26:28 -0800 (PST)
Date:   Mon, 21 Nov 2022 21:26:27 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
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
        Bough Chen <haibo.chen@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: Re: [PATCH v2 1/4] clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB
 offsets
Message-ID: <Y3vQ47WJnC7yofwD@linaro.org>
References: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-15 20:32:41, Giulio Benetti wrote:
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Missing commit message. Same for patch #2 and #4.

> ---
> V1->V2:
> * nothing done
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
