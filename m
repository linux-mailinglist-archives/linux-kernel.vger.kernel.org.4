Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0752C6DC041
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 16:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDIOJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 10:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDIOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 10:09:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A6210D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 07:09:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ga37so7412612ejc.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 07:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681049369; x=1683641369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QC/+02Fx1bZjSkOiyg9i0tDZlYd8mwmfGVMqDc10Bc=;
        b=x1SBAshYQNO02+4XIJDsBjHGqiSqxyggmv5imncBX+Z4oyhCo3o3rRlKy6ckIu84q6
         g9jlrQ/gHSBMkT+JdPr72SuIe0BhooUH6n2xDGyLtGjcaHz1S3mDZWYaldiQttLTyJKv
         V4K7rTAA6DHfiH+sOZnQCb12epmR9QchOFeFnvgMAXYXn8x2KLT1jVZBrULc74yk/mFd
         9fd54KV6jdJz7Q0iwJi6b0t1ZQpl97jtwRNtJ9hRDTULsVOvWtHIdbYGbImR1eqwJHMZ
         ZsRHl7LXa0yHkaWV5O9og7Q63daSaYx0HIFo+4iqbcI3iHpx4N+sSw2Kk9g2r8JSJSeN
         QnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681049369; x=1683641369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QC/+02Fx1bZjSkOiyg9i0tDZlYd8mwmfGVMqDc10Bc=;
        b=TdFlAk6H5E6clyzsTHFhM8FUTnUq73GrOXv583rvPvsG/sflfRPkF8ROgKUiqSXuin
         DHWNdwTbUsKMmW4a/Nabb/kgx/qLv5vLyF4a1HImhc8m/zVJTjPZR8cmph7A2QAyP6b9
         f0IoDriWGeI828e/uDz9JpPNQyKgO1QYsbkhcmgEVR/uEc2oir/qdEA/EqhOx/eGTnKF
         A95x21pdm7z1A2llRbAJy4DcctiIHz2hftX+CCppCJeqL0tZZFjqm5XpWeJVJth2JZZp
         fN5vgMWDDKOm3jVreU3ZwuUWeREIHapJlXhMor9uKzzKAhs7Aiyncm6irvgBI39nZJLz
         hYJg==
X-Gm-Message-State: AAQBX9fPGGfz+qu8Efutqb8SjPYA+5Ri6K5kSUCm0EfKwgyvSqSMeETi
        lZZseHaasfZ2fdWvuHHrd1U2IQ==
X-Google-Smtp-Source: AKy350aJoM9h5ui0mcPGw4CFuh/uYp1HEIXFFDYRxxO+bcpHzaMMsaRTVvl3HF7xMdWdl6S44Q76Bw==
X-Received: by 2002:a17:907:8814:b0:94a:87d6:d39e with SMTP id ro20-20020a170907881400b0094a87d6d39emr430353ejc.58.1681049369395;
        Sun, 09 Apr 2023 07:09:29 -0700 (PDT)
Received: from linaro.org ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id d24-20020a50f698000000b0050299cebf6esm3923724edn.54.2023.04.09.07.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 07:09:28 -0700 (PDT)
Date:   Sun, 9 Apr 2023 17:09:27 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH 1/5] clk: imx: imx8ulp: Fix XBAR_DIVBUS and AD_SLOW clock
 parents
Message-ID: <ZDLHF6VP232yKsCx@linaro.org>
References: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
 <20230331063814.2462059-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331063814.2462059-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-31 14:38:10, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> XBAR_DIVBUS and AD_SLOW should set parent to XBAR_AD_DIVPLAT and
> XBAR_DIVBUS respectively, not the NIC_AD. otherwise we will get
> wrong clock rate.
> 
> Fixes: c43a801a5789 ("clk: imx: Add clock driver for imx8ulp")
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-imx8ulp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
> index a07df3b44703..89121037a8f0 100644
> --- a/drivers/clk/imx/clk-imx8ulp.c
> +++ b/drivers/clk/imx/clk-imx8ulp.c
> @@ -200,8 +200,8 @@ static int imx8ulp_clk_cgc1_init(struct platform_device *pdev)
>  	clks[IMX8ULP_CLK_NIC_AD_DIVPLAT] = imx_clk_hw_divider_flags("nic_ad_divplat", "nic_sel", base + 0x34, 21, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
>  	clks[IMX8ULP_CLK_NIC_PER_DIVPLAT] = imx_clk_hw_divider_flags("nic_per_divplat", "nic_ad_divplat", base + 0x34, 14, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
>  	clks[IMX8ULP_CLK_XBAR_AD_DIVPLAT] = imx_clk_hw_divider_flags("xbar_ad_divplat", "nic_ad_divplat", base + 0x38, 14, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> -	clks[IMX8ULP_CLK_XBAR_DIVBUS] = imx_clk_hw_divider_flags("xbar_divbus", "nic_ad_divplat", base + 0x38, 7, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> -	clks[IMX8ULP_CLK_XBAR_AD_SLOW] = imx_clk_hw_divider_flags("xbar_ad_slow", "nic_ad_divplat", base + 0x38, 0, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> +	clks[IMX8ULP_CLK_XBAR_DIVBUS] = imx_clk_hw_divider_flags("xbar_divbus", "xbar_ad_divplat", base + 0x38, 7, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> +	clks[IMX8ULP_CLK_XBAR_AD_SLOW] = imx_clk_hw_divider_flags("xbar_ad_slow", "xbar_divbus", base + 0x38, 0, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
>  
>  	clks[IMX8ULP_CLK_SOSC_DIV1_GATE] = imx_clk_hw_gate_dis("sosc_div1_gate", "sosc", base + 0x108, 7);
>  	clks[IMX8ULP_CLK_SOSC_DIV2_GATE] = imx_clk_hw_gate_dis("sosc_div2_gate", "sosc", base + 0x108, 15);
> -- 
> 2.37.1
> 
