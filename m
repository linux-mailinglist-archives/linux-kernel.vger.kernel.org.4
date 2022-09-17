Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65295BB75F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIQJBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:01:37 -0400
Received: from sypressi2.dnainternet.net (sypressi2.dnainternet.net [83.102.40.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2E2BB2F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 02:01:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sypressi2.dnainternet.net (Postfix) with ESMTP id 2141D120E9;
        Sat, 17 Sep 2022 11:55:24 +0300 (EEST)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Score: 2.975
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
Received: from sypressi2.dnainternet.net ([83.102.40.154])
        by localhost (sypressi2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id u9GGZTBquAQY; Sat, 17 Sep 2022 11:55:23 +0300 (EEST)
Received: from kirsikkapuu2.dnainternet.net (kirsikkapuu2.dnainternet.net [83.102.40.52])
        by sypressi2.dnainternet.net (Postfix) with ESMTP id ECA6B1AAA;
        Sat, 17 Sep 2022 11:55:23 +0300 (EEST)
Received: from localhost (87-95-96-237.bb.dnainternet.fi [87.95.96.237])
        by kirsikkapuu2.dnainternet.net (Postfix) with ESMTP id 70E5F3BAF;
        Sat, 17 Sep 2022 11:55:16 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 17 Sep 2022 11:55:16 +0300
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        horatiu.vultur@microchip.com
Subject: Re: [PATCH -next v2 2/2] pinctrl: ocelot: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <YyWLdHE2Eou3ySW8@surfacebook>
References: <20220917024634.1021861-1-yangyingliang@huawei.com>
 <20220917024634.1021861-2-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917024634.1021861-2-yangyingliang@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Sep 17, 2022 at 10:46:34AM +0800, Yang Yingliang kirjoitti:
> Switch to use devm_platform_get_and_ioremap_resource() to simplify code.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index c672bc2a4df5..d2c144611d4b 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -2073,8 +2073,7 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>  				     "Failed to get reset\n");
>  	reset_control_reset(reset);
>  
> -	base = devm_ioremap_resource(dev,
> -			platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -- 
> 2.25.1
> 
> 

-- 
With Best Regards,
Andy Shevchenko


