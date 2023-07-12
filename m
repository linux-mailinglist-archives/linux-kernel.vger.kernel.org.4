Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FB5750AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjGLO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjGLO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:28:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F38198A;
        Wed, 12 Jul 2023 07:28:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8bd586086so52563135ad.2;
        Wed, 12 Jul 2023 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689172102; x=1691764102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d29G4UGHTOvrTSdXfUvhc04mvubBfv0bY2JOgTNo1uw=;
        b=S5lb9XL/Txqs3htFjYU4g4xgB8ToehOwqWly4eW6k5f42z60BVHh7NPAXDHwA7DCEs
         ki5Es3nsXzaayC4Gzl3AodsZusY/r64YhWgol+5Cs56yQbwmAJp8g6FiQWj+DQkYQsg9
         GpaZdqSJabAURvlSlv1Y52jRGXcAuwMfH0pol/RWPJbbYmbIB0ZkRmi+zdVHmLN/iFwR
         aJsjRC4e2OoHBogGqcgS4+fo6fYqHmNdysDvIleV/zd0pHUZZutuUlpLsf5MnYLX19wv
         /1NYQKK8Ki8qEQj/1kS8y5rsf069n27XSpzysG+dGRF/haUjEQ8bXiTwO0SNyrHNi3LV
         g8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689172102; x=1691764102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d29G4UGHTOvrTSdXfUvhc04mvubBfv0bY2JOgTNo1uw=;
        b=JeNe92wRhLY3CgtVg4+rN9TatE3CjL0Y7YUmm8czJLe2eOPeaikJqUmmhT9nLdCaYH
         jILjfbea7LrRnw9HtlGHUhliCpVqcA44KScvN+lnXlpefZTwj2ISUuuWqCfZC02K6r0y
         Y3koZgE5zkiNpar+FLl9v7evJ/mNo4ys6ka62pyTsI9Br5RwxQ6pgoGUOD+kkCfvFb/A
         Mc69LJ78CYbTDREelFxQWv0ymhr4JnbfnjKnBDAXsRRDvFV15/1pZl0PiP59Dmg8FK+Z
         hbrf5HoVOXd7TGLD6X9eqZd9c80YlQ52xmkWLJab9GZDdyfOv3PXqE4iJ9FBEk8xVJ8i
         8zcQ==
X-Gm-Message-State: ABy/qLbpOco2fXcWmmoFnUa0oMyb9ToCxiyttHiHH2a65P5VnEZSF1z6
        GNNOUS2aZfQi9OXYu5fCZyw=
X-Google-Smtp-Source: APBJJlE4muskuJqQfw5y483vMIOjSxPzLKDViBfxKtYogxy0Ldpk2GEZmu9/LB7RYYbsQ3FTFAn/7w==
X-Received: by 2002:a17:902:788c:b0:1ae:8892:7d27 with SMTP id q12-20020a170902788c00b001ae88927d27mr10222431pll.42.1689172101946;
        Wed, 12 Jul 2023 07:28:21 -0700 (PDT)
Received: from [192.168.1.5] ([113.103.7.132])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709027c0600b001b8a37ffb5asm4037587pll.4.2023.07.12.07.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:28:21 -0700 (PDT)
Message-ID: <d1c9dce9-9dbc-46bf-0d18-6d90a3ae7610@gmail.com>
Date:   Wed, 12 Jul 2023 22:28:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230712134347.14897-1-aarongt.shen@gmail.com>
 <20230712135553.trqkxtcuiemwzgwe@pengutronix.de>
From:   Guiting Shen <aarongt.shen@gmail.com>
In-Reply-To: <20230712135553.trqkxtcuiemwzgwe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed,Jul 12,2023 at 21:55:53PM GMT+8, Uwe Kleine-König wrote:
> On Wed, Jul 12, 2023 at 09:43:47PM +0800, Guiting Shen wrote:
>> The driver would never call clk_enable() if the PWM channel was already
>> enabled in bootloader which lead to dump the warning message "the PWM
>> clock already disabled" when turning off the PWM channel.
>>
>> Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
>> the PWM channel was already enabled in bootloader.
>>
>> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
>> ---
>>   drivers/pwm/pwm-atmel.c | 40 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index cdbc23649032..28ea0f7267ca 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -36,7 +36,7 @@
>>   #define PWM_SR			0x0C
>>   #define PWM_ISR			0x1C
>>   /* Bit field in SR */
>> -#define PWM_SR_ALL_CH_ON	0x0F
>> +#define PWM_SR_ALL_CH_MASK	0x0F
>>   
>>   /* The following register is PWM channel related registers */
>>   #define PWM_CH_REG_OFFSET	0x200
>> @@ -464,6 +464,37 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
>>   
>> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm)
>> +{
>> +	unsigned int i;
>> +	int err;
>> +	u32 sr;
>> +
>> +	sr = atmel_pwm_readl(atmel_pwm, PWM_SR);
>> +	if (!(sr & PWM_SR_ALL_CH_MASK))
>> +		return 0;
>> +
>> +	for (i = 0; i < atmel_pwm->chip.npwm; i++) {
>> +		if (!(sr & (1 << i)))
>> +			continue;
>> +
>> +		err = clk_enable(atmel_pwm->clk);
>> +		if (err) {
>> +			dev_err(atmel_pwm->chip.dev,
>> +				"failed to enable clock for pwm #%d: %pe\n",
>> +							i, ERR_PTR(err));
>> +
>> +			while (i--) {
>> +				if (sr & (1 << i))
>> +					clk_disable(atmel_pwm->clk);
>> +			}
>> +			return err;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int atmel_pwm_probe(struct platform_device *pdev)
>>   {
>>   	struct atmel_pwm_chip *atmel_pwm;
>> @@ -504,8 +535,15 @@ static int atmel_pwm_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, atmel_pwm);
>>   
>> +	ret = atmel_pwm_enable_clk_if_on(atmel_pwm);
>> +	if (ret < 0)
>> +		goto remove_pwmchip;
>> +
>>   	return ret;
>>   
>> +remove_pwmchip:
>> +	pwmchip_remove(&atmel_pwm->chip);
>> +
> 
> I'd consider it more natural to do the atmel_pwm_enable_clk_if_on() call
> before registering the pwmchip. But I guess it works like this, too.
> (Well unless it's possible that there are set bits in PWM_SR and the
> clock is off.)

It need to invoke something like atmel_pwm_disable_clk_if_on() after 
failing to register the pwmchip when call the 
atmel_pwm_enable_clk_if_on() first which I feel inconvenient.
And it's impossible to enable PWM channels before enabling the clock.
The bits set in PWM_SR means that the PWM channel and the clock turn on.


-- 
Best regards,
Guiting Shen
