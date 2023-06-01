Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A38371F6D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjFAXu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFAXu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF1194;
        Thu,  1 Jun 2023 16:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A488D64AE1;
        Thu,  1 Jun 2023 23:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077ADC433D2;
        Thu,  1 Jun 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685663424;
        bh=lcmOjedKmuez/BCfGRbZK+xkGv9ydrmspQLiwE3iVsA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MAN8qZVXEvUDp+65LgkpNoQ3lwVYbh1YDcsVkE/wknq0jMYijreRbbwMCpidXm7DC
         TQ0wqswq7aJD+DiZ/pTuhgvblooBs9CYcUHA4dnCA+xNzdfi6MPswSJLsCKN5eIdXh
         wa6MjDearm4euCxUXPe6WrMZCj03OKPbxePr2SGVqlQJS0d+F0J/OIcM3+/VeFPrEr
         j+qTeEAEJbLeuSTdiIssPG7Nd0V6/cUPKtSqq2fbefpSqHlcrYCo+2C3xHN0MGgebO
         3IZXj5gn8WS3R8mBK8v+cpcrV1yRK3oRWd6gjJZryH/Y+X52uB7rwFxB8y2NPUqgP0
         IqBNTjcQQWqaA==
Message-ID: <81ff6195-19c3-95d6-6d37-58f7719a9265@kernel.org>
Date:   Fri, 2 Jun 2023 08:50:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 38/43] pata: cirrus: drop legacy pinctrl
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-20-nikita.shubin@maquefel.me>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230601054549.10843-20-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 14:45, Nikita Shubin wrote:
> Drop legacy acquire/release since we are using
> pinctrl for this now.

Please use full 72 chars lines.

> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Please change the commit title to:

ata: pata_ep93xx: remove legacy pinctrl use

Also, are the functions ep93xx_ide_acquire_gpio() & ep93xx_ide_release_gpio()
used somewhere else ? If not, this patch should remove these functions as well.

> ---
>  drivers/ata/pata_ep93xx.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index 8d363bc71342..88cf31000000 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -921,28 +921,18 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
>  	void __iomem *ide_base;
>  	int err;
>  
> -	err = ep93xx_ide_acquire_gpio(pdev);
> -	if (err)
> -		return err;
> -
>  	/* INT[3] (IRQ_EP93XX_EXT3) line connected as pull down */
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		err = irq;
> -		goto err_rel_gpio;
> -	}
> +	if (irq < 0)
> +		return irq;
>  
>  	ide_base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
> -	if (IS_ERR(ide_base)) {
> -		err = PTR_ERR(ide_base);
> -		goto err_rel_gpio;
> -	}
> +	if (IS_ERR(ide_base))
> +		return PTR_ERR(ide_base);
>  
>  	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
> -	if (!drv_data) {
> -		err = -ENXIO;
> -		goto err_rel_gpio;
> -	}
> +	if (!drv_data)
> +		return -ENXIO;
>  
>  	drv_data->pdev = pdev;
>  	drv_data->ide_base = ide_base;
> @@ -1000,8 +990,6 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
>  
>  err_rel_dma:
>  	ep93xx_pata_release_dma(drv_data);
> -err_rel_gpio:
> -	ep93xx_ide_release_gpio(pdev);
>  	return err;
>  }
>  
> @@ -1013,7 +1001,6 @@ static int ep93xx_pata_remove(struct platform_device *pdev)
>  	ata_host_detach(host);
>  	ep93xx_pata_release_dma(drv_data);
>  	ep93xx_pata_clear_regs(drv_data->ide_base);
> -	ep93xx_ide_release_gpio(pdev);
>  	return 0;
>  }
>  

-- 
Damien Le Moal
Western Digital Research

