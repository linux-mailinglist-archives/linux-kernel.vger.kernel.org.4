Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F065700514
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbjELKR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbjELKR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:17:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0410FA
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:17:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3062db220a3so6362177f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683886674; x=1686478674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14BJIVNMULvhbAa0IJTwVfQ7hLurTBIHPZW7PjkOaVo=;
        b=m2GjFHJp3L+cd9d3hGN4nHKQtF447dleqW6dVU0mLF5QhG6X7nDyRw9/ubCErmyDoW
         C4qeM2JSjRv/MA+gXisM1hgky1EumqjImqb2SsWwySSCLEfTFyqp/2zg2z6wfoQbo9Sw
         dxu5dhk+afgKtozHKPFxG9zMWdfMVsmG62SAZSrmKuRy5LrMd41GHRK1E0LE0IFT9gU9
         JrRuvAaeKdvKywhK6LmI2bWVdKqPWeszpVSFaFJ6GKDsEBk4Xv0rlYZO3ewsXQbVsZvx
         VK1FKPc1S8arPxXdMgLjOcYHE/psbNSC34JarSN7vp+PdnJM8OLVA2c37kD5ByYOML1I
         7mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886674; x=1686478674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14BJIVNMULvhbAa0IJTwVfQ7hLurTBIHPZW7PjkOaVo=;
        b=O3U9fSr3XhKAOXJVe49TRJmmcZM/7RPxUXkG+AwBkymvSX3PadNvkkv5roPAh6gqy3
         il3ETB9s7MHEaZUvQxicNitgiBWItFCxS5aMDAHtyt4knwSF25cVus3CkNSBkpEwKmxN
         yh2Qf354U3XMThGIaOBLHSFz5H7bG3YtJCtd/MIlhz9r0ysbN4ZQP6G92fZUh9kSIYqg
         ZBfun+35SKphf9mLEkWhuJS2QlD54K9jCWWQRaObDxqttAA3UFBH6nT55ukvkYKwpZ90
         ILp5Ta3jC9/V3UedMuIL1ZhjTHkdaQYQLkVQH1WGHZqaR4ttTTjwipYGCq9GD74Lz1CP
         Dtnw==
X-Gm-Message-State: AC+VfDykXxSy15cdCoC+fC1WQem522ESF2X8TwHQiXfJFJys1/tUN4jU
        KNfixNYUPNM8oWUiW+5R4xDHUQ==
X-Google-Smtp-Source: ACHHUZ7Nl4tlDQMNUHZVBv7fk43XYLJwOflZ3jsWjnvqzd5OWriCsZwDUTX6lXf5yUaigorw8h9FXQ==
X-Received: by 2002:a5d:5503:0:b0:306:2d3d:a108 with SMTP id b3-20020a5d5503000000b003062d3da108mr17239296wrv.11.1683886674383;
        Fri, 12 May 2023 03:17:54 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k1-20020a7bc301000000b003eddc6aa5fasm28401011wmj.39.2023.05.12.03.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 03:17:53 -0700 (PDT)
Message-ID: <3c98ed14-11cc-a4ba-16b9-1aea1c7ba255@linaro.org>
Date:   Fri, 12 May 2023 11:17:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 2/3] nvmem: brcm_nvram: add .read_post_process() for
 MACs
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230421084312.27932-1-zajec5@gmail.com>
 <20230421084312.27932-2-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230421084312.27932-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/04/2023 09:43, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Parse ASCII MAC format into byte based
> 2. Calculate relative addresses based on index argument
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Applied thanks,

--srini
>   drivers/nvmem/Kconfig      |  1 +
>   drivers/nvmem/brcm_nvram.c | 28 ++++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index b291b27048c7..688b70ba4826 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -55,6 +55,7 @@ config NVMEM_BRCM_NVRAM
>   	tristate "Broadcom's NVRAM support"
>   	depends on ARCH_BCM_5301X || COMPILE_TEST
>   	depends on HAS_IOMEM
> +	select GENERIC_NET_UTILS
>   	help
>   	  This driver provides support for Broadcom's NVRAM that can be accessed
>   	  using I/O mapping.
> diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
> index 39aa27942f28..4567c597c87f 100644
> --- a/drivers/nvmem/brcm_nvram.c
> +++ b/drivers/nvmem/brcm_nvram.c
> @@ -4,6 +4,8 @@
>    */
>   
>   #include <linux/bcm47xx_nvram.h>
> +#include <linux/etherdevice.h>
> +#include <linux/if_ether.h>
>   #include <linux/io.h>
>   #include <linux/mod_devicetable.h>
>   #include <linux/module.h>
> @@ -42,6 +44,25 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
>   	return 0;
>   }
>   
> +static int brcm_nvram_read_post_process_macaddr(void *context, const char *id, int index,
> +						unsigned int offset, void *buf, size_t bytes)
> +{
> +	u8 mac[ETH_ALEN];
> +
> +	if (bytes != 3 * ETH_ALEN - 1)
> +		return -EINVAL;
> +
> +	if (!mac_pton(buf, mac))
> +		return -EINVAL;
> +
> +	if (index)
> +		eth_addr_add(mac, index);
> +
> +	ether_addr_copy(buf, mac);
> +
> +	return 0;
> +}
> +
>   static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
>   				size_t len)
>   {
> @@ -75,6 +96,13 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
>   		priv->cells[idx].offset = value - (char *)data;
>   		priv->cells[idx].bytes = strlen(value);
>   		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
> +		if (!strcmp(var, "et0macaddr") ||
> +		    !strcmp(var, "et1macaddr") ||
> +		    !strcmp(var, "et2macaddr")) {
> +			priv->cells[idx].raw_len = strlen(value);
> +			priv->cells[idx].bytes = ETH_ALEN;
> +			priv->cells[idx].read_post_process = brcm_nvram_read_post_process_macaddr;
> +		}
>   	}
>   
>   	return 0;
