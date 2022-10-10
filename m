Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A78F5F9BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiJJJNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiJJJNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:13:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EAD5B79A;
        Mon, 10 Oct 2022 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665393211; x=1696929211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FSafgwpHtjewaVf768ABQg/kdcKmfRXlnif/dgM4eK0=;
  b=q9GkwMyi9188gqlzRm7/2Xm4A8jkSgm8/SmpmXTbA97ZXWnIJphQz5yK
   leIPiiRDq2unEjNPRpF6JcuqKG0S/E+54KwKOEvpOlRN5EuqdG27ZTigy
   lyfuVExSTNRPFh4XgELVqZDRbClmz2SzFKSZdlgHE0ZcnqNoUO5l32cP+
   +gBUa9/S7r1G+ZQMxA6htHm2UMnHYEBYPhkUNjBXenxlNWyuNaWxNPBVI
   UsKaMTFe4W8D8Dc3O6cQgUHDtkzz9aJTFeR88RSFGcg25RezvDP4PXYNy
   1mCiKvprcIIt2fZeQdXwO3RlD//2p7i4x/ZjNm7TzZLn+a18/KW8HH2G5
   A==;
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="177929212"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Oct 2022 02:13:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 10 Oct 2022 02:13:28 -0700
Received: from [10.12.72.60] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 10 Oct 2022 02:13:26 -0700
Message-ID: <8a335e97-c880-d42f-a455-9ea8f3e65267@microchip.com>
Date:   Mon, 10 Oct 2022 11:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] pinctrl: at91-pio4: Add configuration to userspace
Content-Language: en-US
To:     <Ryan.Wanner@microchip.com>, <linus.walleij@linaro.org>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>
References: <20221007151647.98222-1-Ryan.Wanner@microchip.com>
 <20221007151647.98222-2-Ryan.Wanner@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221007151647.98222-2-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 at 17:16, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Adding support for line bias flags that have been implented in gpio API.

Typo: implemented

> There are functions in the gpiod library that can control line bias from
> userspace this adds that functionality to this driver.
> 
> Adding .pin_config_set allows the driver's pin configuration to be
> accessed from userspace. The general idea for this as been taken from
> stm32, intel, and rockchip drivers that have userspace access for bias
> flags.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com> # on sama5d27 som1 ek
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   drivers/pinctrl/pinctrl-at91-pio4.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index 517f2a6330ad..13b77f1eb6e2 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -902,6 +902,25 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
>   	return 0;
>   }
>   
> +static int atmel_conf_pin_config_set(struct pinctrl_dev *pctldev,
> +				     unsigned pin,
> +				     unsigned long *configs,
> +				     unsigned num_configs)
> +{
> +	struct atmel_group *grp = atmel_pctl_find_group_by_pin(pctldev, pin);
> +
> +	return atmel_conf_pin_config_group_set(pctldev, grp->pin, configs, num_configs);
> +}
> +
> +static int atmel_conf_pin_config_get(struct pinctrl_dev *pctldev,
> +				     unsigned pin,
> +				     unsigned long *configs)
> +{
> +	struct atmel_group *grp = atmel_pctl_find_group_by_pin(pctldev, pin);
> +
> +	return atmel_conf_pin_config_group_get(pctldev, grp->pin, configs);
> +}
> +
>   static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
>   					   struct seq_file *s,
>   					   unsigned int pin_id)
> @@ -949,6 +968,8 @@ static const struct pinconf_ops atmel_confops = {
>   	.pin_config_group_get	= atmel_conf_pin_config_group_get,
>   	.pin_config_group_set	= atmel_conf_pin_config_group_set,
>   	.pin_config_dbg_show	= atmel_conf_pin_config_dbg_show,
> +	.pin_config_set	        = atmel_conf_pin_config_set,
> +	.pin_config_get	        = atmel_conf_pin_config_get,
>   };
>   
>   static struct pinctrl_desc atmel_pinctrl_desc = {
> @@ -1139,6 +1160,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
>   	atmel_pioctrl->gpio_chip->label = dev_name(dev);
>   	atmel_pioctrl->gpio_chip->parent = dev;
>   	atmel_pioctrl->gpio_chip->names = atmel_pioctrl->group_names;
> +	atmel_pioctrl->gpio_chip->set_config = gpiochip_generic_config;
>   
>   	atmel_pioctrl->pm_wakeup_sources = devm_kcalloc(dev,
>   			atmel_pioctrl->nbanks,


-- 
Nicolas Ferre
