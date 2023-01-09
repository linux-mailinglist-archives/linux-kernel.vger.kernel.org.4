Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2351662378
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjAIKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjAIKtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:49:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1112BBD7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:49:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fc4so18936064ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqAqPhIqERgD29GWWy+ln9sbSBK7E7D/BXF1DQNgTDU=;
        b=O2+RQyS8HsQ7EWLgCpAFgp+Vo3Omg/v6W5paOULH5B7BSlhnwQP/nFusR6fwnTU9gp
         O4Q6ZhCect9eMFhcnj9t+ssyCA+MJvXSHvhhHCXi1z/d2V8H5FfqzpbJ3EtLQ2iojyVG
         DFdjwFodA+NvbyhmpAMLyv4tAdroDBSBb1dlpVMMBU0m5dL4j1G+DAMaNrG7g4R3kdye
         G88ukGxjX/VOSUv0oz06f1S1dfu8TfJXd+QOa0O3i+XlAlJlBClDMuPR3s8nw9BvMLdA
         NikjApF5FhKT4adr5i91Yx9Oplfat0/3y1VYr8hFbR5ER0THlyojVdP1ZoXZEwD7/a5o
         bbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqAqPhIqERgD29GWWy+ln9sbSBK7E7D/BXF1DQNgTDU=;
        b=SdXpXB/LhPmIeCCM/EWWzVoObe43BCIOAXf5+Ios07tw1+uCsjZbqTt5ZDu452Aejq
         e6JE/de1UaexDrC++ReMxA/lh3HUGy0GxCqG/b4DJPDL4iw62xM7+35W+qhlbKDr5q1j
         P033RMABFZ6lDA/yr65YOnlvoNZWQedrGrEw4nf/X/9qZ1ZGY19hlrIaUVyrQOjcuI/V
         9O/PYskiGccf94cXKlnvgnKciuLSwQqaE6kAd8OKSOj846NlLbLtAefsZ7Yddv9Jbof8
         yj0OwJvobqhG5rEIMsq06477GWS6ThsANIstBFYoZAWjFmhPs88pR9LtKnj8eFFWSpHz
         oYBQ==
X-Gm-Message-State: AFqh2kpcRXMwiiskQRQP6ej53FBxNc0prXAiq32kPit7YcTPWxkgE+kh
        cX1Jignw0iwhZiblKD2ezSRGBg==
X-Google-Smtp-Source: AMrXdXuDMndAcHwHQy7+2S02KFcRC5cWaGLNPd+fcA5kFAGcMEV2c1u69dIoKNmuKgcu+Jr/wn3GvA==
X-Received: by 2002:a17:907:c011:b0:7c0:e5ca:411c with SMTP id ss17-20020a170907c01100b007c0e5ca411cmr52648321ejc.17.1673261367517;
        Mon, 09 Jan 2023 02:49:27 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a20-20020a17090680d400b007c4f32726c4sm3579814ejx.133.2023.01.09.02.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:49:27 -0800 (PST)
Date:   Mon, 9 Jan 2023 12:49:25 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        18701859600@163.com, bsp-development.geo@leica-geosystems.com,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V4 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Message-ID: <Y7vxNX2HAp5TPoWp@linaro.org>
References: <20221214030719.4123889-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20221214030719.4123889-2-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214030719.4123889-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-14 04:07:19, LI Qingwu wrote:
> Defined IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV in imx8mp-clock.h
> but never assigned. It will cause the system to hang if using them.
> Alias IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV to IMX8MP_CLK_M7_CORE
> for backward compatibility.
> 
> Fixes: 8c83a8ff4dd9 (clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code)
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
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
