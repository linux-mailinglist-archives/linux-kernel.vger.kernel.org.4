Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC2368BAA7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBFKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBFKpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:45:09 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68BE6E98
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:45:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m14so9885291wrg.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NrnM3FG0e7QhbFCjFG7aIqrnfRYfB8sX8+GS0tlerk=;
        b=g7VaVQIaZuUW0FvSZehAeCHC5dlDxe5XlqNw/7/w7jSeWiyZcILcm5XydsKtsZ3aIN
         oHTVOMsefhsAFwJcJklu4e4q22lat2SMV3qdNbr7fSCj9Pt2wDHHPv0IrPGPAoBnfrQz
         k9ByUyRieI7X9Ndn2hkK5CrcYnBBfFRwsE1mY4kPUWeMSpplgT5/I0H5YpJ1ZP5Di1aT
         b0+awITw9L4SQgaDrH9sXRMtKYgcqLxOknqLdJ5G5Jv4Dba6Mermzt4KV2drSUu57bbF
         lVCGcNeYa6evqMJGSvtIILc4b5kudF1I2MkgE6PwIIPNCRdV/dC4KNfWm+Eo47fG1sSh
         kAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NrnM3FG0e7QhbFCjFG7aIqrnfRYfB8sX8+GS0tlerk=;
        b=EfcMwef88AaYqibw8Zsn4Uc5p53NGg/WxV4RuC7QuiYTjR48LI2WbFANac3zGMCi2K
         tFjxL7Uvmj/v2H9n2dFON7/qRZWZcrcPqvW51EpCdbXtdXgw0MpiKIyf2NCA7IpIg30u
         NI37x64VSxMeSCjGjL9PT5fvp/P62vYDxFZ+OLV8sCNJV2faceXk3qxitxGeRZXD/MP6
         GyELANsfFlOGm+y+lfzcTyix9Z0CDZlI1oAYB0DT5pnC6TnYVBjxUlw4FSDGF0b63wQ5
         irbnMfHsuFUdzYQdlJRfj2F3GhJFjmV+WrjJ2rkpjJtBu9k+KDXCp1xr4mlKjSH8Ou3L
         xwUA==
X-Gm-Message-State: AO0yUKXGvAt8m6gYfzpBMhvwBxhQKJ/sm53MnJe5rUShvlHoxZmaKAJr
        zgZgobwY3IBa4SghSYeda3qzr9dDLVWPbso6
X-Google-Smtp-Source: AK7set98dqxPimNIdMv8ZWaDeY74ILWNJFHHUvcX0aaDiko9DbYMvXVwMFPziFrbh8Gil435TSMhkg==
X-Received: by 2002:a5d:6351:0:b0:2c3:dfa7:9155 with SMTP id b17-20020a5d6351000000b002c3dfa79155mr6346758wrw.59.1675680306443;
        Mon, 06 Feb 2023 02:45:06 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id e20-20020a5d5954000000b002bfd524255esm8632069wri.43.2023.02.06.02.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 02:45:05 -0800 (PST)
Message-ID: <13261104-4544-b198-0d0c-0d39651f27c9@linaro.org>
Date:   Mon, 6 Feb 2023 10:45:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] nvmem: brcm_nvram: use bcm47xx buffered data
Content-Language: en-US
To:     arinc9.unal@gmail.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
References: <20230206101642.22720-1-wdehoog@exalondelft.nl>
 <20230206101642.22720-3-wdehoog@exalondelft.nl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230206101642.22720-3-wdehoog@exalondelft.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2023 10:16, arinc9.unal@gmail.com wrote:
> From: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
> 
> The bcm47xx module has a copy of the NVRAM data in ram. When available, use
> this one instead of reading from io memory since it causes mtd/ubi to fail.
> 
> [ arinc.unal@arinc9.com: Improved patch subject and log ]
> 
> Signed-off-by: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>   drivers/nvmem/brcm_nvram.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
> index 34130449f2d2..f74bcb1c948e 100644
> --- a/drivers/nvmem/brcm_nvram.c
> +++ b/drivers/nvmem/brcm_nvram.c
> @@ -33,6 +33,12 @@ struct brcm_nvram_header {
>   static int brcm_nvram_read(void *context, unsigned int offset, void *val,
>   			   size_t bytes)
>   {
> +#ifdef CONFIG_BCM47XX_NVRAM
> +
Hmm this is not the right way to fix/add support for this, consider 
adding SoC specific compatible and based on that you can take right 
choice at runtime.

there are 2 issues with this patch which you should probably consider.
1. no dependency expressed in any way in Kconfig.
2. If we build these as modules everything will break as the symbol is 
not exported.


--srini
> +	return bcm47xx_nvram_read(offset, val, bytes);
> +
> +#else
> +
>   	struct brcm_nvram *priv = context;
>   	u8 *dst = val;
>   
> @@ -40,6 +46,8 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
>   		*dst++ = readb(priv->base + offset++);
>   
>   	return 0;
> +
> +#endif
>   }
>   
>   static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
