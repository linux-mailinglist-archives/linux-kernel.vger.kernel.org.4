Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4215C632DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiKUUTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiKUUTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:19:13 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B97CB696
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:19:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id t1so9268429wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2YssgXesKzDDqTy+l2rOE6j9dPCuISGfB3qINrW5NY=;
        b=DDKxtQ/4PQQ82eX2FE2Bvql6KWZbbrka2EcphaRV5wFLOTJrhk+uG4+f6TOc46kBcM
         85NZIurnpnl5IROuuvrND2pI0OFFrc0TBdAUrgJDqDyzQJu56VuPCIW95+cXmh64HaRk
         QBObzvAMYeGkT0N7Dec6175IQPLuuKdK6bn5gd6eVNtfaQG0uAiXmTd+Xv4TSEgNz4+X
         XGsPTafMhV4XV7e/QfuSZROM7SJ4YUYleAfKPthap4LcSkOTyqGDd66KzH51Fm2qdspG
         sdB1owBEaCiJJOyfOx5nujuQq/aIi2MQo6E20L/OV06TGYyy44pLoIGnJSKfN4lIdbSh
         1POA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2YssgXesKzDDqTy+l2rOE6j9dPCuISGfB3qINrW5NY=;
        b=URi/c7zliHX5JD5LPq25IkeQkZwfn8QVmaNYHFoC1sfLsQrfCqecalCdGUHGWulkKg
         7wCnhBlvI3jR0qgEksnM4ZcieYOHO6uMdT60S7cIA4VSaYmP5a74ldDd29wKXUQpnBz8
         X7zg6ZYSrOQPdwlHyjo1TXgEkvPY89SeLxIh6rAW1mCoThn66bnWIjbpJEBhO9+iLbx2
         EvPrHaZe+o21vLZJEK1+SP0/0FJXHdC0BMnfttEqyuGJ6NIa/ihDFjKw1TR1DqnFsIsL
         VIy/yCvRika0ltAUbgy8LZQyenvhJZKSYsn4sISFUBxjU3cl4dVYiEuic2QZufQuJ1rl
         4JqA==
X-Gm-Message-State: ANoB5pmDr1z/8dQTRdTBaBHJYKbvf1shEGt/GmzHVZ59lBP3y/OXYNg0
        Syal4ODRxoTnruxNuMKZW7U7ZA==
X-Google-Smtp-Source: AA0mqf6rbDf37PjcFTBtQWSwtpm/6LMyjwaNmBZSC2ZVhhi7/ShjxpuRoTcJGE5/LcQMeCNhKqOiAA==
X-Received: by 2002:a05:600c:1f0c:b0:3cf:a41d:8418 with SMTP id bd12-20020a05600c1f0c00b003cfa41d8418mr6267451wmb.190.1669061949631;
        Mon, 21 Nov 2022 12:19:09 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b003cfa26c410asm21561537wmq.20.2022.11.21.12.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 12:19:09 -0800 (PST)
Date:   Mon, 21 Nov 2022 22:19:07 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        michael@amarulasolutions.com, Abel Vesa <abelvesa@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 4/5] clk: imx8mn: fix imx8mn_sai2_sels clocks list
Message-ID: <Y3vdO6Kh47dH+C/u@linaro.org>
References: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
 <20221117113637.1978703-5-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117113637.1978703-5-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-17 12:36:36, Dario Binacchi wrote:
> According to the "Clock Root" table of the reference manual (document
> IMX8MNRM Rev 2, 07/2022):
> 
>      Clock Root     offset     Source Select (CCM_TARGET_ROOTn[MUX])
>         ...          ...                    ...
>    SAI2_CLK_ROOT    0xA600            000 - 24M_REF_CLK
>                                       001 - AUDIO_PLL1_CLK
>                                       010 - AUDIO_PLL2_CLK
>                                       011 - VIDEO_PLL_CLK
>                                       100 - SYSTEM_PLL1_DIV6
>                                       110 - EXT_CLK_2
>                                       111 - EXT_CLK_3
>         ...          ...                    ...
> 
> while the imx8mn_sai2_sels list contained clk_ext3 and clk_ext4 for
> source select bits 110b and 111b.
> 
> Fixes: 96d6392b54dbb ("clk: imx: Add support for i.MX8MN clock driver")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> 
> (no changes since v1)
> 
>  drivers/clk/imx/clk-imx8mn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index b80af5d1ef46..37128c35198d 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -109,7 +109,7 @@ static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll_out"
>  
>  static const char * const imx8mn_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
>  						"video_pll_out", "sys_pll1_133m", "dummy",
> -						"clk_ext3", "clk_ext4", };
> +						"clk_ext2", "clk_ext3", };
>  
>  static const char * const imx8mn_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
>  						"video_pll_out", "sys_pll1_133m", "dummy",
> -- 
> 2.32.0
> 
