Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31D66C296
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjAPOrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjAPOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:46:53 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ADE22A23
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:28:37 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hw16so56647876ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxLG6TTl8Ic/7g0hQk8ggT8NcHPanULLyMvVruCtN2c=;
        b=QGlGugyS3UvUwNLlIz8UrjuOagHJQAqHFl0b7LiY3pjSEWd3QV1zO3d7SD+ZdOrza/
         x5G601a1q2QAghOuPl7OdIp9uPmU80fKtCLExlG0gqWjm6fUeq7GSy9iQGAcg40I4EQD
         uBAIPv9fIr6E02fF+8KfST95igZxAubbSqvFiLGzsFV1t2wHawhuQyiS4tuxLUNCZVcm
         IiZ/evYO0C57J+AqkIVIgcTDq3eESoliRyBmTsdEnB5TzNDp3BBNwGSSAMLmo2niFZ2R
         BjVB1PJEfyiH2hs5yn26f08V0UfgPzYpxG7tmnn7c0kQrvek5qNl7gTTU6p4wQQlV5rJ
         QJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxLG6TTl8Ic/7g0hQk8ggT8NcHPanULLyMvVruCtN2c=;
        b=j+Mu7d7agyGNH20k+fr6/BlGeAmCoobrKpJyefy3XJbk2YEqnwa2tPllrUfmtHS6EH
         7EzmY0Xw/1N9JyWnhsMC3hhPi8+odouxSunuCPMLgJSVWWzE6mXJMxiDYdEPuTzRO4fP
         AXzmNxCuaXIAiIXO+SDxnVGxddxv7WFkbQUA0/JUmoTCPNcpfZG8rfI8RzO01x2tJ9lr
         tUSnfED1dub1n8qQ8Ug0JndoB5HdB8/uo2CBSKMv1ACgzrP0BKRCVGw+zM1ZQCNl7bG7
         66psjqG0f6s0efuBXvzvN70fuGVJt5MUmU0fa/W3gdfovxQ/azfuUEuRBkF1JqiCFaCz
         TGAw==
X-Gm-Message-State: AFqh2kqh2lK+eaf7qjbSqQHEtCVzh7Dhd4okkDSHPSNHeQcUYu+XHmuT
        N9NpAFiOb+Vg1UAYow637xxAHA==
X-Google-Smtp-Source: AMrXdXvhKj+dWSAovh86aIL0ls/STdzn8oZMPR+FmLegGDzAEOO/UU2HiZ10lUEtT+U1aacM+pz0zw==
X-Received: by 2002:a17:906:5786:b0:7c0:e535:13fc with SMTP id k6-20020a170906578600b007c0e53513fcmr100863185ejq.37.1673879315637;
        Mon, 16 Jan 2023 06:28:35 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id lb14-20020a170907784e00b007c0fd177c0bsm11753152ejc.46.2023.01.16.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 06:28:35 -0800 (PST)
Date:   Mon, 16 Jan 2023 16:28:33 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        18701859600@163.com, bsp-development.geo@leica-geosystems.com,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V5 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Message-ID: <Y8VfEfnWwt8+QB1W@linaro.org>
References: <20230111101030.686885-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20230111101030.686885-2-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111101030.686885-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-11 11:10:30, LI Qingwu wrote:
> Defined IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV in imx8mp-clock.h
> but never assigned. It will cause the system to hang if using them.
> Alias IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV to IMX8MP_CLK_M7_CORE
> for backward compatibility.
> 
> Fixes: 8c83a8ff4dd9 (clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code)
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>

Stephen, can you please pick this up yourself?

Thanks!

> ---
>  drivers/clk/imx/clk-imx8mp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 652ae58c2735..601eea7ab99d 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -522,6 +522,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_CLK_A53_SRC] = hws[IMX8MP_CLK_A53_DIV];
>  	hws[IMX8MP_CLK_A53_CG] = hws[IMX8MP_CLK_A53_DIV];
>  	hws[IMX8MP_CLK_M7_CORE] = imx8m_clk_hw_composite_core("m7_core", imx8mp_m7_sels, ccm_base + 0x8080);
> +	hws[IMX8MP_CLK_M7_DIV] = hws[IMX8MP_CLK_M7_CORE];
> +	hws[IMX8MP_CLK_M7_SRC] = hws[IMX8MP_CLK_M7_CORE];
>  	hws[IMX8MP_CLK_ML_CORE] = imx8m_clk_hw_composite_core("ml_core", imx8mp_ml_sels, ccm_base + 0x8100);
>  	hws[IMX8MP_CLK_GPU3D_CORE] = imx8m_clk_hw_composite_core("gpu3d_core", imx8mp_gpu3d_core_sels, ccm_base + 0x8180);
>  	hws[IMX8MP_CLK_GPU3D_SHADER_CORE] = imx8m_clk_hw_composite("gpu3d_shader_core", imx8mp_gpu3d_shader_sels, ccm_base + 0x8200);
> -- 
> 2.25.1
> 
