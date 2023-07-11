Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860E474E415
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGKCbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjGKCbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:31:21 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D06197;
        Mon, 10 Jul 2023 19:31:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a3790a0a48so4006150b6e.1;
        Mon, 10 Jul 2023 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689042680; x=1691634680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vKCsfZmQ4pdPeNTJyUuoml7xtipyGpfEqf7kDYskjU=;
        b=oDCAc5LxzzKVXMV7c8RHtevUUAMyTt+Yf1wboAuOvQW8XhL3bRnujfvSw1c2F/p0R1
         O0ZYblp0elMGQfwD6fXQVdw00hLKtgVa7hgB2FWY0SUWOvkrIMVgALU3JFSDX5BzqRao
         59RRLGxSst9SHUWndmvIW+3KKaeekl67sTd18v5PsN+y74acg9lPJpSQA7xHLyBF1pVW
         5fVvmO6hXwy8sfn9ASrj0dVbXcqYUwmWoYvATCaAr6WHQUaw/JEiXdFGjXBIDObq3te2
         ah7IvR5ndVx70dXrPyLYUKB2TDx/7ig1JtNwX3bCB/j0XsX/VNnIVNCJHW9qNCBzgFjX
         xPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689042680; x=1691634680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vKCsfZmQ4pdPeNTJyUuoml7xtipyGpfEqf7kDYskjU=;
        b=ORwrr+7SvkPmF5xp/Hx4bUSPraRlxezCYuYzSVZYu9OWjtS0CUoxprD/aNixt3m+kE
         u8I1X6ah5rqBWshbMmMAuaMFG6yQJY3D50EZhk2RyjSZosGjg2CeKOLDA2lNQf8/s2Bs
         Yvi50Fa213eDHchL/sMaJ+oLhHOaijlTf7X5mdzLmc/DeDuJkJL/pSOZCzI21a81XVF7
         n7T1C9Q5a28Qk6VIrJDsyvVHtJ5DH6/wxcc2rwQqpZ2Hf+/zW241GmGCN3+Uikd78UUt
         yQHVQEXljxMzRCQ70lPboeo31rlAaROlienUgg1WW/XxSb+rsJSUQn/AcI5MEnnbbUpW
         6FRg==
X-Gm-Message-State: ABy/qLYrz3oa3xfn+qKS1tqDDHAVbgfVyJdzUOumESiZWfb9IMcO7rXX
        YmII9zXOS8+WM4yBLTInvjE=
X-Google-Smtp-Source: APBJJlF69HmcE9pA9bI0uyTf9CZoeAAH0AkorKJeTM4T0kEzUpLX5q1z7+3fh4uJqexowXW1QwAixA==
X-Received: by 2002:a05:6358:3386:b0:135:515c:38ee with SMTP id i6-20020a056358338600b00135515c38eemr7122186rwd.25.1689042679717;
        Mon, 10 Jul 2023 19:31:19 -0700 (PDT)
Received: from [192.168.220.128] ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id a28-20020a63705c000000b00528513c6bbcsm384979pgn.28.2023.07.10.19.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 19:31:19 -0700 (PDT)
Message-ID: <d3f07a74-3fce-2310-a1fc-239aa1a25024@gmail.com>
Date:   Tue, 11 Jul 2023 10:30:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] pwm: atmel: enable clk when pwm already enabled in
 bootloader
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     claudiu.beznea@microchip.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230710144214.63343-1-aarongt.shen@gmail.com>
 <ZKwdHUWzXujfVk0R@orome>
From:   Guiting Shen <aarongt.shen@gmail.com>
In-Reply-To: <ZKwdHUWzXujfVk0R@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 23:00:45PM GMT+8, Thierry Reding wrote:
> On Mon, Jul 10, 2023 at 10:42:14PM +0800, Guiting Shen wrote:
>> The driver would never call clk_eanble() if the pwm channel already
>> enable in bootloader which lead to dump the warning message of "the pwm
>> clk already disabled" when poweroff the pwm channel.
>>
>> Add atmel_pwm_enanle_clk_if_on() in probe function to enable clk if the
>> pwm channel already enabled in bootloader.
> 
> You've got multiple spelling errors in the commit message. Also, PWM is
> an abbreviation and so should be all uppercase (except for the subject
> prefix). I also prefer spelling out terms like "clock" in the commit
> message. This is text that is supposed to be readable. It's not code.

Got it, Thank you. How about this commit message:

The driver would never call clk_enable() if the PWM channel was already
enabled in bootloader which lead to dump the warning message "the pwm
clock already disabled" when turn off the PWM channel.

Add atmel_pwm_enable_clk_if_on() in probe function to enable clk if the
PWM channel was already enabled in bootloader.

>>
>> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
>> ---
>>  drivers/pwm/pwm-atmel.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index cdbc23649032..385f12eb604c 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -464,6 +464,29 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
>>  
>> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm)
>> +{
>> +	u32 sr, i;
> 
> Maybe make i an unsigned int since you use it to iterate over npwm,
> which is unsigned int as well.

Ok, I will correct it in v2 patch.

>> +	int err;
>> +
>> +	sr = atmel_pwm_readl(atmel_pwm, PWM_SR);
>> +	if (!sr)
>> +		return 0;
>> +
>> +	for (i = 0; i < atmel_pwm->chip.npwm; i++) {
>> +		if (!(sr & (1 << i)))
> 
> We would usually write this as BIT(i), but I see that the rest of the
> driver uses this notation, so it's fine to keep this as-is.
> 
>> +			continue;
>> +
>> +		err = clk_enable(atmel_pwm->clk);
>> +		if (err) {
>> +			dev_err(atmel_pwm->chip.dev, "enable clock error\n");
> 
> Might be worth to include the error code in the error message to make it
> easier to diagnose where the issue is. Something like:
> 
> 	dev_err(atmel_pwm->chip.dev, "failed to enable clock: %d\n", err);
> 
>> +			return err;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int atmel_pwm_probe(struct platform_device *pdev)
>>  {
>>  	struct atmel_pwm_chip *atmel_pwm;
>> @@ -504,6 +527,10 @@ static int atmel_pwm_probe(struct platform_device *pdev)
>>  
>>  	platform_set_drvdata(pdev, atmel_pwm);
>>  
>> +	ret = atmel_pwm_enable_clk_if_on(atmel_pwm);
>> +	if (ret < 0)
>> +		goto unprepare_clk;
> 
> This is not correct. You call this after pwmchip_add(), so you need to
> make sure to also remove the PWM chip on error. Preferably, though, you
> should call this before adding the PWM chip in the first place.

Sorry, I will call this before adding the PWM chip in v2 patch.

>> +
>>  	return ret;
>>  
>>  unprepare_clk:
>> -- 
>> 2.25.1
>>

-- 
Regards,
Guiting Shen

