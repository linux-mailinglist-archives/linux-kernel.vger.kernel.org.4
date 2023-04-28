Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D36F150F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346005AbjD1KL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345970AbjD1KLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:11:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375385584
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:11:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f315712406so54035385e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682676669; x=1685268669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXzFdP+bsCom1eIU4RjGMEhTHDjKgk0txNlrf8+QKjQ=;
        b=BTJadbAUme0Sy1hlHP/K4faG9iF+975AHqUFdEcWjuUQLtvs65XD2KY+1siMxyE9/l
         o6FKRidLgEQa3A9pzVkgzokqaVHcHAnrb+4s1Q4UEVWfLL0/1joAGQSDuB+dlS23akBL
         eyqrZ39sZx5ejMhovbd+YTearPccBC6fmWVBlfU4oU9YrcIQtMQk9gn4ejgAdj6FPium
         Ekk9tv02jYMShgZvwUbLrSolY+Hp2a23GnYESMDuGqgnAoIfs5r83sLzmZ+IWdbiAFP8
         AXtXAzYYNSLywuEY5PSdMDNAQYWU2M92PldMuAQnBZomC5xqs2niHsqIvpYctk5pV5HT
         rwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682676669; x=1685268669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXzFdP+bsCom1eIU4RjGMEhTHDjKgk0txNlrf8+QKjQ=;
        b=HMICl0ggrhSewhaSwyvZCKTlliNv8uOhXSLfVagNSWrJRfFEQG2ligMBIwwv7lK+2E
         kDADpB/NOrI/cCkaiz6aKo9Er++gKRmgnQQMYEx+btoFDcp/IzPhVOwoTDOezaCczuUS
         VxDdCU8TwfKZ1VCBbPFY76T22+SnU7RYGop6HoAWuR1ooCw7KijCVbr7IKG2GmA2lQDO
         HCEX3vE5earO+4WWYGgw0sOdhY6s1/Lb0Zx0zMgorTRsTx1XVCzvelPirQOORbBz69I8
         O6mp2L7LQob16pOpBacdixrDwW+dY3/Kth1N4fJAMNsdMGcSInMVnVpzf99EdHGe+NxI
         0nYA==
X-Gm-Message-State: AC+VfDzuRso4Fls5ycoQgiEyP1AuBpdpCuKdZvJvX0MH6P9/kLT6uYM0
        L1Rwn3hGNW3314i73hFUxejaUqMo3AYG6V2qiKaSlQ==
X-Google-Smtp-Source: ACHHUZ40io/HDINCoZegM4FbjUwOrQojqqHLfzHukPg8uxIUh+gUZC94V0ajzwAV5EvY1bNvrk3wgQ==
X-Received: by 2002:a7b:cb86:0:b0:3f1:8129:2c53 with SMTP id m6-20020a7bcb86000000b003f181292c53mr3712923wmi.16.1682676669381;
        Fri, 28 Apr 2023 03:11:09 -0700 (PDT)
Received: from [172.23.3.169] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id x8-20020a05600c21c800b003f2390bdd0csm15200964wmj.32.2023.04.28.03.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 03:11:09 -0700 (PDT)
Message-ID: <7d481097-9ffc-6ac5-a53e-09772b2d5b33@linaro.org>
Date:   Fri, 28 Apr 2023 11:11:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/4] Input: pwm-vibra - add support for enable GPIO
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-3-e87eeb94da51@z3ntu.xyz>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230427-hammerhead-vibra-v1-3-e87eeb94da51@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2023 21:34, Luca Weiss wrote:
> Some pwm vibrators have a dedicated enable GPIO that needs to be set
> high so that the vibrator works. Add support for that optionally.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/input/misc/pwm-vibra.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
> index c08971c97ad6..2ba035299db8 100644
> --- a/drivers/input/misc/pwm-vibra.c
> +++ b/drivers/input/misc/pwm-vibra.c
> @@ -11,6 +11,7 @@
>    *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
>    */
>   
> +#include <linux/gpio/consumer.h>
>   #include <linux/input.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> @@ -23,6 +24,7 @@
>   
>   struct pwm_vibrator {
>   	struct input_dev *input;
> +	struct gpio_desc *enable_gpio;
>   	struct pwm_device *pwm;
>   	struct pwm_device *pwm_dir;
>   	struct regulator *vcc;
> @@ -48,6 +50,8 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
>   		vibrator->vcc_on = true;
>   	}
>   
> +	gpiod_set_value_cansleep(vibrator->enable_gpio, 1);
> +
>   	pwm_get_state(vibrator->pwm, &state);
>   	pwm_set_relative_duty_cycle(&state, vibrator->level, 0xffff);
>   	state.enabled = true;
> @@ -80,6 +84,8 @@ static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
>   		pwm_disable(vibrator->pwm_dir);
>   	pwm_disable(vibrator->pwm);
>   
> +	gpiod_set_value_cansleep(vibrator->enable_gpio, 0);
> +
>   	if (vibrator->vcc_on) {
>   		regulator_disable(vibrator->vcc);
>   		vibrator->vcc_on = false;
> @@ -142,6 +148,16 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
>   		return err;
>   	}
>   
> +	vibrator->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> +							GPIOD_OUT_LOW);
> +	err = PTR_ERR_OR_ZERO(vibrator->enable_gpio);
> +	if (err) {
> +		if (err != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to request enable gpio: %d\n",
> +				err);
> +		return err;
> +	}
> +
>   	vibrator->pwm = devm_pwm_get(&pdev->dev, "enable");
>   	err = PTR_ERR_OR_ZERO(vibrator->pwm);
>   	if (err) {
> 
