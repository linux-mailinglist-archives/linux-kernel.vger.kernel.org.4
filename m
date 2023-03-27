Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E46CA9E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjC0QEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjC0QER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:04:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA443C12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:04:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so38496467eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679933054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9d+CJ7xH0NeUIZvPiaZdq/zmEARl/7DsQh+htUqnO4=;
        b=taKDcuQ01TOwBn5emk4eJEOyvH7uNbZHzQ4LaVKRxDAknBe6gooEFvYy+ZjZ8dVXwl
         VI+7zWrX7BCgW1r2OoAKiCQlWCYtEOs4zYqyf7mn6dbt1uU+mdcmJkOy3/1MrUwiQegO
         y59CwGa/LsKRSgmnJpDRDqKBccE2eGsbQtYl0S0Sb10/rKD9qXYUJLONeq2uCEbaKAsf
         4ea0ZGhvgTv8/ZH5x1Vrf2Gm4ceou97im+I/G31g/LcvX3A66MrItEOr2u/kgy6wEYHn
         ib7YkKDPvG8hbOOebou1kegcpXdj/GALmfAQMNz87oXopgjr32RCCM/u+c4KukyamHSg
         +A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679933054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9d+CJ7xH0NeUIZvPiaZdq/zmEARl/7DsQh+htUqnO4=;
        b=cUfGj71pLxHwv2X9+8z73/PYzx29TS10OX86Rtwudu2YsZWKbcNm4PilelgzHldyUQ
         FxUS2kSV8RKFKbdsuKUyuAlHvlqMUNwwH6F+RWuJGbIC+4elJF1ToJLzkVwngt6EFCFM
         v7Gn/bEddDz47Nlxd083CUcKUhzl20Pm/sFNiQ50oXQjJeoaaHl8WkEVyTg/0qZoxCWi
         ZEREnI08tjUjq7dr1+oXYsNWhNsHCu66UV8mKwGq71X8MgGA6l1Pyn2mahP57NuJyE8Q
         dY43I3KDEMFvKXObYHcqOH9yjBKORrn+i7cEus0fvzqfnj1TjCRKr3+hrKoobd5kT05+
         gB+g==
X-Gm-Message-State: AAQBX9dEd8CNwauTwQDKQaaatYp5NHkvuijngy0HGSdlJuBqd3Mex6r9
        j10HqX9wA5kP/70R0U73HXQJ63+ydK/iiZ4y54I=
X-Google-Smtp-Source: AKy350aXxjXxWZUWc28oW6GgoYbcSBUB0NXoeU5O09Qr5yX5ooIkPywTvdE6GOALkRyZ4RCZKydGZA==
X-Received: by 2002:a17:906:578c:b0:88f:a236:69e6 with SMTP id k12-20020a170906578c00b0088fa23669e6mr12928910ejq.7.1679933054387;
        Mon, 27 Mar 2023 09:04:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:581e:789c:7616:5ee? ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id yj8-20020a170907708800b00930170bc292sm14127889ejb.22.2023.03.27.09.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 09:04:14 -0700 (PDT)
Message-ID: <fd349801-0ca1-7f89-f110-513a2cd4fc0f@linaro.org>
Date:   Mon, 27 Mar 2023 18:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] memory: brcmstb_memc: Add new DDR attributes
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230324165231.3468069-1-f.fainelli@gmail.com>
 <20230324165231.3468069-4-f.fainelli@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324165231.3468069-4-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 17:52, Florian Fainelli wrote:
> Provide information about the DDR size, type, width, total width,
> dual/single rank. This is useful for reporting purposes and inventory of
> the system(s).
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/memory/brcmstb_memc.c | 80 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/brcmstb_memc.c b/drivers/memory/brcmstb_memc.c
> index 67c75e21c95e..032567dfd6e2 100644
> --- a/drivers/memory/brcmstb_memc.c
> +++ b/drivers/memory/brcmstb_memc.c
> @@ -13,7 +13,14 @@
>  
>  #define REG_MEMC_CNTRLR_CONFIG		0x00
>  #define  CNTRLR_CONFIG_LPDDR4_SHIFT	5
> -#define  CNTRLR_CONFIG_MASK		0xf
> +#define  CNTRLR_CONFIG_MASK		GENMASK(3, 0)
> +#define  CNTRLR_CONFIG_SIZE_SHIFT	4
> +#define  CNTRLR_CONFIG_SIZE_MASK	GENMASK(7, 4)
> +#define  CNTRLR_CONFIG_WIDTH_SHIFT	8
> +#define  CNTRLR_CONFIG_WIDTH_MASK	GENMASK(9, 8)
> +#define  CNTRLR_CONFIG_TOT_WIDTH_SHIFT	10
> +#define  CNTRLR_CONFIG_TOT_WIDTH_MASK	GENMASK(11, 10)
> +#define  CNTRLR_CONFIG_RANK_SHIFT	16
>  #define REG_MEMC_SRPD_CFG_21		0x20
>  #define REG_MEMC_SRPD_CFG_20		0x34
>  #define REG_MEMC_SRPD_CFG_1x		0x3c
> @@ -63,6 +70,67 @@ static int brcmstb_memc_srpd_config(struct brcmstb_memc *memc,
>  	return 0;
>  }
>  
> +static ssize_t ddr_rank_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct brcmstb_memc *memc = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n",
> +		       memc->config_reg & CNTRLR_CONFIG_RANK_SHIFT ?
> +		       "dual" : "single");

Why all these are not sysfs_emit()? I think it is the preferred (safer)
interface.

Best regards,
Krzysztof

