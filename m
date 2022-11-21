Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD1632DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiKUUNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiKUUNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:13:16 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F065853
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:13:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso9815628wmp.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qaJml6B45GINP8nvpvWNlH6+dLeFFe+BHZD8DKIginQ=;
        b=v+X7X/u9lJ/H+xBNZXa8t/6nqQ3v+jSAJmIroCZMGbv75Sf7M1btDkn0SQKkzegIU8
         cmfR9aKFMNrn4fGGNc+l7h9+pSFoU7PKVxuimUzmNCBOPZCTRBT6kJcKvxKixUwIWwUj
         N1TQoOUG+v7qt0vQPGwoUi7GBVJ3gLKiKHt5CpwFZjud8qLO9jmLCcrFMVFJbf62EQko
         Wg3+3Dw8uSSQB3/yZvS5E67kwqcxSTuQbnQb7IGXto63qByYSgx6Aw6HGAlFlM4xiRTk
         ty0C1gueGzafw1Pj7wEUCrwueHi54xUPhoiZ/k1qRUYdRXoefEPCugJq5mAfOTbHZfS4
         rH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaJml6B45GINP8nvpvWNlH6+dLeFFe+BHZD8DKIginQ=;
        b=Mx/Bs6roxAo9Dnr0iX9CJiK0YVwX5+7Fwg7VmpY4UEsdCQu3VPK3aRJcV35KskFAOj
         Q6UmJOGnZmaISTOEbx9FIhw8l/sT24+7MiNsm+wpjLy0+UWMkGYTRp0a5qbIP+q8eGDN
         sXcI/cTm2H1W6mBejz9i0p4ldlP7qSLb6dSRN8cYvrZTato1DCpA7OmI2IyqPQebRFLo
         OnKzCuwx3k1jmRgVfobFHByyXmlZUNazt3NDYHsf0kpTTa2AD3Oo5tSbSPcrmHMYgK9u
         7vHXeOFPT4V90V8qeyRRP67OycMa04iTVbPHOLOpWHBvb2mO4M1L5pBabFKn6NvkTG/P
         J3/A==
X-Gm-Message-State: ANoB5pnj93o68szMwuxmxBFcViVPsXCUtCFOGY8E5SonPR1Jysp3nqHC
        zmf5xBENbqF0CildmJYy8QwKIQ==
X-Google-Smtp-Source: AA0mqf6RBlJyCNs6T/UJivikFhLC8pbMTe7ir2MDgF84bzycAp/GDrV5vndGJXD/KxzgYxXwoA6uEg==
X-Received: by 2002:a1c:4b12:0:b0:3cf:90de:7724 with SMTP id y18-20020a1c4b12000000b003cf90de7724mr17577759wma.18.1669061592691;
        Mon, 21 Nov 2022 12:13:12 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b003b476cabf1csm14733865wml.26.2022.11.21.12.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 12:13:12 -0800 (PST)
Date:   Mon, 21 Nov 2022 22:13:10 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Peng Fan <peng.fan@nxp.com>
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
Subject: Re: [PATCH v2 2/5] clk: imx: replace osc_hdmi with dummy
Message-ID: <Y3vb1r8G+B8n3T+A@linaro.org>
References: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
 <20221117113637.1978703-3-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117113637.1978703-3-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-17 12:36:34, Dario Binacchi wrote:
> There is no occurrence of the hdmi oscillator in the reference manual
> (document IMX8MNRM Rev 2, 07/2022). Further, if we consider the indexes
> 76-81 and 134 of the "Clock Root" table of chapter 5 of the RM, there is
> no entry for the source select bits 101b, which is the setting referenced
> by "osc_hdmi".
> Fix by renaming "osc_hdmi" with "dummy", a clock which has already been
> used for missing source select bits.
> 
> Tested on the BSH SystemMaster (SMM) S2 board.
> 
> Fixes: 96d6392b54dbb ("clk: imx: Add support for i.MX8MN clock driver")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

I don't think this is correct. It might even break the EVKs HDMI
support.

Peng, can you please confirm ?

> ---
> 
> (no changes since v1)
> 
>  drivers/clk/imx/clk-imx8mn.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 72f9563a0ff6..0fae97e61e2c 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -108,27 +108,27 @@ static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll1_out
>  						      "sys_pll3_out", "clk_ext4", };
>  
>  static const char * const imx8mn_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
> +						"video_pll1_out", "sys_pll1_133m", "dummy",
>  						"clk_ext3", "clk_ext4", };
>  
>  static const char * const imx8mn_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
> +						"video_pll1_out", "sys_pll1_133m", "dummy",
>  						"clk_ext3", "clk_ext4", };
>  
>  static const char * const imx8mn_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
> +						"video_pll1_out", "sys_pll1_133m", "dummy",
>  						"clk_ext2", "clk_ext3", };
>  
>  static const char * const imx8mn_sai6_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
> +						"video_pll1_out", "sys_pll1_133m", "dummy",
>  						"clk_ext3", "clk_ext4", };
>  
>  static const char * const imx8mn_sai7_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
> +						"video_pll1_out", "sys_pll1_133m", "dummy",
>  						"clk_ext3", "clk_ext4", };
>  
>  static const char * const imx8mn_spdif1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						  "video_pll1_out", "sys_pll1_133m", "osc_hdmi",
> +						  "video_pll1_out", "sys_pll1_133m", "dummy",
>  						  "clk_ext2", "clk_ext3", };
>  
>  static const char * const imx8mn_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
> -- 
> 2.32.0
> 
