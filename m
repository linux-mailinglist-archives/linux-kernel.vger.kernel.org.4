Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F4B61A35C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKDVcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKDVcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:32:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA618E0F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:31:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id 13so16583535ejn.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXeLyBT66GcyNMkGNLXyVq2BhJDegmKs2IP6Dg3V8qs=;
        b=s4ZFu+PCO6R25MJtYlf69zGk3gnbGDZkaUqyPYLtWvW6MIMnBIjnyTKebSWOx9jAnF
         6LiEgJJ0FDwh04Zurj3z1tPIq9+Lr+nYILvIKiw1U1tJ3njQ9J3EooL7eICl+nZ1IEIX
         nfDiUD5j8fbuAqAgnFbqHSQBGbciDdKaruJ8U26Syo6k/m5HNSw40sAl6gq7mCfwTopi
         lt6wyHQ59TL/bHONQ9xyM2dZVQyVMnj7+UnZ4WwOhAdvzMtigS+X7RaUR1iC4NjsdImw
         G6z9z01hWRlXxPGHwJEqMKVZ6uvExDq3RKgmJO61cryUMW630NioRgpW2cCA2OYcsvFj
         l11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXeLyBT66GcyNMkGNLXyVq2BhJDegmKs2IP6Dg3V8qs=;
        b=TDX+6U96mrh6Q5DE+qj0r4Vnnu+G1YxjOIB2+dbCRlW8wT/UVY/QsHB6nlnbS62wcC
         nk7Uu7GpikXsftEkspP8WuwEb5kZwhRPhDr40NGpKbvx/9apJcIkH+jlYI2NXHhlAns2
         J9wayfQBRIdFILyCVQI6uXS+YBDzT/0hb5qW6dMPfLmqPDrFzgBq+aW3Ik8fcJaCa6cN
         naYa+5zhr/BuK6emJ73Tfcnin5+DRg3j6fUZl/M09Jn92/JwkE5CSQlCVJqPrb/sKTNV
         I//t6UtIKQ6UdXDrBKeJl5EojrOA7gxAGATknVf6BCFg0S/+J1k+/wtKRvTWtdD76UVm
         fhXQ==
X-Gm-Message-State: ACrzQf3+23BaDdtblYh4AuhjQrHVpl2DBL6cG9GWmANcHkz0RfWn7MZE
        hdMmXZCLuK5gMPyKHgdOE4ZoRw==
X-Google-Smtp-Source: AMsMyM5b811dTOciUQ1WKFKeaNpDRnVgKPJ8hWO1y+EM8yeTBh4emwKaqkeDo/SAaFhkTuhBWRukyw==
X-Received: by 2002:a17:907:746:b0:741:4a1b:cb1f with SMTP id xc6-20020a170907074600b007414a1bcb1fmr35116157ejb.370.1667597516128;
        Fri, 04 Nov 2022 14:31:56 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m19-20020aa7c493000000b00458dc7e8ecasm263591edq.72.2022.11.04.14.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:31:55 -0700 (PDT)
Date:   Fri, 4 Nov 2022 23:31:54 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 6/6] clk: imx93: keep sys ctr clock always on
Message-ID: <Y2WEyhj7L8nyoBuu@linaro.org>
References: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
 <20221028095211.2598312-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028095211.2598312-7-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-28 17:52:11, Peng Fan (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> Keep sys ctr clock always on to make sure its register
> can be accessed for cpuidle.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-imx93.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index 7dace96f36df..b42a877ecca1 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -242,7 +242,8 @@ static const struct imx93_clk_ccgr {
>  	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
>  	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, },
>  	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
> -	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, },
> +	/* Critical because clk accessed during CPU idle */
> +	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, CLK_IS_CRITICAL},
>  	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
>  	{ IMX93_CLK_TSTMR2_GATE,	"tstmr2",	"bus_wakeup_root",	0x9f00, },
>  	{ IMX93_CLK_TMC_GATE,		"tmc",		"osc_24m",		0x9f40, },
> -- 
> 2.37.1
> 
