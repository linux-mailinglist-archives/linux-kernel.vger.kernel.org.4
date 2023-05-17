Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B88E706557
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjEQKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjEQKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:34:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0045640E6;
        Wed, 17 May 2023 03:34:24 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E931C6605877;
        Wed, 17 May 2023 11:34:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684319663;
        bh=WNx8LLXM7GrSvGNzhmchbC8fi2zZZqQ5I2UjKhrGGnk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WZkkZirENmeTVBmQY446rlfa84uVjYBkWt+dROBYuMcyyCuEaPrIAzRLhTEhEOQGI
         mML+974y2O57rEfmGDPLAwK3KSP1JHzyaMmFWbgL2L1bypjdPdYVhcUC4f6pmqJdns
         lF6+8OV2hDL5baF979nIELWLTlNx/txSs7mnMbFQaEfNnx9iF7w6FvY9G5oWfbi8ZZ
         594RhHf6D5U6k3lCbM/4GFM8QZFrBmt+0mfVeK6Ka3yIsILEfaAuQnVV7Gi7OdbbM6
         GNSLQLHuAI16L5U4JjRBvopXwDzblmiaPq5p8EmiumkJwEwQPIZrbWau1pV4RGijO9
         f96Y3njwE+v0Q==
Message-ID: <f8f4c224-0070-6dc5-665c-ad75f0306d72@collabora.com>
Date:   Wed, 17 May 2023 12:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/7] iio: adc: rockchip_saradc: Match alignment with open
 parenthesis
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
 <20230516230051.14846-5-shreeya.patel@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230516230051.14846-5-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/23 01:00, Shreeya Patel ha scritto:
> Match alignment with open parenthesis for improving the code
> readability.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com

> ---
>   drivers/iio/adc/rockchip_saradc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 05ea823a8f16..5e1e8575bc76 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -144,7 +144,7 @@ static void rockchip_saradc_power_down(struct rockchip_saradc *info)
>   }
>   
>   static int rockchip_saradc_conversion(struct rockchip_saradc *info,
> -				   struct iio_chan_spec const *chan)
> +				      struct iio_chan_spec const *chan)
>   {
>   	reinit_completion(&info->completion);
>   
> @@ -387,8 +387,7 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
>   }
>   
>   static int rockchip_saradc_volt_notify(struct notifier_block *nb,
> -						   unsigned long event,
> -						   void *data)
> +				       unsigned long event, void *data)
>   {
>   	struct rockchip_saradc *info =
>   			container_of(nb, struct rockchip_saradc, nb);


