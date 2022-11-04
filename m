Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95061A360
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKDVeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKDVeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:34:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D716445EF5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:34:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y14so16512005ejd.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZlIX8cuZeOQRSQTQbQX9cRSlkV364TcFG+GGAYF/Z8=;
        b=wD8sdK4C2h0XhONCEgetpPhAbLse9nzbZXp33TPCGfO4s/SBsMN8AFvXNRER6UQtTj
         ZRIUKTxt7xJ5xzyyBPN0wgOH0s1histmEabT7cNK4lDSUg+BLBxh4O/4Q0RVH4vv+Uo/
         USqg7nZR2Jm//8DmUS9h58/zmo2Rt+u6DVC0iSH/15acXG4JUA2e6k5ntDoCfmpj2WWH
         jHgWRHW0cUQTcXIHCkfMGShWgRefu5eefqeHOxmrHcvVbrKXNc7vSqrsLjDUuZE6CIa/
         vFndEY6r83SzbjTIKrnnCftZ7ArqtkC8DjJyYuifiajNcQpems9Pe0MBU8u9MAge9osc
         WcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZlIX8cuZeOQRSQTQbQX9cRSlkV364TcFG+GGAYF/Z8=;
        b=eM9nNEKlvGT0KTzpACDyV0LgAJjKzQakXUZu1QpsjC3tGbZksA49l6mjuJjGQHyLAf
         zracvRvu5xR4vKL7/Dcf7gau2NXhg/+1xwL9A1zMLSGgmOJQuYGgl8WY6W8fkIQE8sv/
         RuHFrk1JEg0WK/ewmWEJjr6R8kT+DnO/wW990ibAu2tpIrblD9c2SpCa7My8gzBUxJSp
         wL5f8s7q1HTm7l1SYjU0/0PbQgv6OjMRp71LitEm5CGwY0aMsv1UaEMPUJ1Q+qYJS2X/
         buEK2qXuNUNCkF2WlWaMMgKO8kJh6kXbXut+DWodoWBLU9hQ0OexOzSSOhI/7iIcB2lP
         Xp6Q==
X-Gm-Message-State: ACrzQf3DxkLwuMnhxN35IG7Aa/oapEYM6g9EUCNlzxtI7yHsusgvb+XN
        6UU0JCe7vNnkMSLFZa+xKpQUsw==
X-Google-Smtp-Source: AMsMyM52IVgyxrOzvYXBKOSHv/x6OVBfsWMnbzJEcL7xj0tR6Hp4938dpIhHCe6UutoQ06RqOST7Zg==
X-Received: by 2002:a17:907:6d25:b0:7aa:f5a4:5f66 with SMTP id sa37-20020a1709076d2500b007aaf5a45f66mr35482545ejc.216.1667597651457;
        Fri, 04 Nov 2022 14:34:11 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q19-20020a17090676d300b007030c97ae62sm29041ejn.191.2022.11.04.14.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:34:10 -0700 (PDT)
Date:   Fri, 4 Nov 2022 23:34:09 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 5/6] clk: imx: keep hsio bus clock always on
Message-ID: <Y2WFUVJVwA8s6Su4@linaro.org>
References: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
 <20221028095211.2598312-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028095211.2598312-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-28 17:52:10, Peng Fan (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> During Linux System suspend/resume stress test after System Sleep
> enabled, system will stuck sometimes. It is because NICMIX is powered
> down, which HSIOMIX(always on) is not powered down. When NICMIX
> powering down, HSIOMIX will get a hardware handshake, without HSIO ROOT clk,
> the handshake will lose. Then after NICMIX power on when system resume,
> the access to HSIOMIX through NICMIX would be broken. So keep HSIO ROOT
> always on.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
>  [Peng Fan] rewrite commit message
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-imx93.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index 422ad3c89845..7dace96f36df 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -109,7 +109,11 @@ static const struct imx93_clk_root {
>  	{ IMX93_CLK_CCM_CKO2,		"ccm_cko2_root",	0x1d00,	CKO2_SEL, },
>  	{ IMX93_CLK_CCM_CKO3,		"ccm_cko3_root",	0x1d80,	CKO1_SEL, },
>  	{ IMX93_CLK_CCM_CKO4,		"ccm_cko4_root",	0x1e00,	CKO2_SEL, },
> -	{ IMX93_CLK_HSIO,		"hsio_root",		0x1e80,	LOW_SPEED_IO_SEL, },
> +	/*
> +	 * Critical because clk is used for handshake between HSIOMIX and NICMIX when
> +	 * NICMIX power down/on during system suspend/resume
> +	 */
> +	{ IMX93_CLK_HSIO,		"hsio_root",		0x1e80,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL},
>  	{ IMX93_CLK_HSIO_USB_TEST_60M,	"hsio_usb_test_60m_root", 0x1f00, LOW_SPEED_IO_SEL, },
>  	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
>  	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
> -- 
> 2.37.1
> 
