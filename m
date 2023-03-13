Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F726B7051
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCMHuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCMHuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:50:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF8C28EBA;
        Mon, 13 Mar 2023 00:50:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m4so1488608lfj.2;
        Mon, 13 Mar 2023 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678693843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHVFhtI+WXf+TBj10nSr3LhfstrJCEyqqp0nJVtIGAI=;
        b=VVZESDY+oTzxvnvslJHVZjQSe5DUbdpK43nfxg2WnlNfG0M+gT0Gjl08wmwh5cQ49/
         JQ3wfc5d/UvLsYAf9JfeMndoXE9pyJ7yGCFstuNbTB9RvTB+qZl1ylD8JGktY5Ri7FoL
         7jzT9qXP/n0/UUT9dIy2P6Lg3LmvQAV9pdLGDJIQjXqVLsyg0p0vFE+tMvWAElf0IOuC
         +GWmp9ieI/IyGets07dkU1CRexebvgGdK5Ciy6ppXiQWrnp56LNDO98XbErBT4jRwiwJ
         wjfrnDbsjwi2gCOQQO282QQJeE0ru7HQ7Az/BzNzkxEQpNHAjM8JafCouafLWGl/U5IJ
         VIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678693843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHVFhtI+WXf+TBj10nSr3LhfstrJCEyqqp0nJVtIGAI=;
        b=eUpumf1WXVDnuIXr84HqTg1bu6I1HZJottEuWWjvsbQ6uP2RXHoacJ8Iwx3OWObVew
         lS0XtL/KIypkpAoID9j+BMCfwcXY81XRFC9jHFtvBO0fg//WUBRbpM0CjMH67EacUh40
         FxBP0AGQErhoMZilw3Cb0NQzbzMuKjJ6JuZdfxNSUB9ocnexqq+MJjI1HGfqcCrntPsQ
         YuObtjxRcg7PqCGTG5Q6oehZYWDjgNup7XvZwkjluiXbBMJMWPdNWRL76rAnJw91UZUI
         ly0iaX/uZJa+VLpYV8IBU+ha/PD2iTXy2oBzWUAe/9+TjyGC5YDUXcQsTU2QFN1zhvgq
         kO+w==
X-Gm-Message-State: AO0yUKXLOVP5IuJlgzCXYBCQZrLa/XeIckFjROUv2u+kOeiGapBNaWJF
        EC0fUaT7SubOQNHDh5A6DS4=
X-Google-Smtp-Source: AK7set+a/ehVNgVfh6mj22qz9e7j+xFSeNhlbdsU/N6rBb/9ab+vAMThy59TeGCu7cwhl4xkVxs05Q==
X-Received: by 2002:ac2:4a90:0:b0:4dd:ac8d:671f with SMTP id l16-20020ac24a90000000b004ddac8d671fmr8196362lfp.34.1678693843053;
        Mon, 13 Mar 2023 00:50:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id x2-20020ac259c2000000b004db3d57c3a8sm895354lfn.96.2023.03.13.00.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 00:50:42 -0700 (PDT)
Message-ID: <f30f2b92-e4ba-a5a4-54e1-926495338009@gmail.com>
Date:   Mon, 13 Mar 2023 09:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv1 07/11] power: supply: generic-adc-battery: drop memory
 alloc error message
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-8-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230309225041.477440-8-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 00:50, Sebastian Reichel wrote:
> Error printing happens automatically for memory allocation problems.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/power/supply/generic-adc-battery.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
> index d07eeb7d46d3..771e5cfc49c3 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -243,10 +243,8 @@ static int gab_probe(struct platform_device *pdev)
>   	bool any = false;
>   
>   	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
> -	if (!adc_bat) {
> -		dev_err(&pdev->dev, "failed to allocate memory\n");
> +	if (!adc_bat)
>   		return -ENOMEM;
> -	}
>   
>   	psy_cfg.drv_data = adc_bat;
>   	psy_desc = &adc_bat->psy_desc;

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

