Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645EC7334BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345985AbjFPP3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjFPP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:29:14 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2434526AF;
        Fri, 16 Jun 2023 08:29:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso1194654e87.0;
        Fri, 16 Jun 2023 08:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686929351; x=1689521351;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VeValyIzucrvcdVSMQeHHxyyygnInnDMzRn1T9fpOHo=;
        b=end5jpdjZlV6qafEDB7eSX+jg2bgePpVQoUMEvCdMs4hreRxXDJTk90OlYoNQQtlhe
         5WCLJCE+vW1emiDxw7J0yYxnPgN5ep/mo9Z1f0x9Mkle1kUegaX+vxNtqgCy2d6EAacZ
         VhGavcOJW24CkWuorxUkYU9MSDr0sYAuXKRqOnMXgglwd9KcDOdel7C854kZS4SZk4nv
         T/B7lnyv/xJ8m6EpHkhdY/flhM5ZCMKLzYjTRvRa0mcc5R88sr5jF+dwLmDci+q4QbNC
         QiDBOULejPo+aUUzTp54oqD4H7vp8c9zcScMR9wQSkscXM/gg1WnNtTbp4tzNzvTjlih
         dkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686929351; x=1689521351;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeValyIzucrvcdVSMQeHHxyyygnInnDMzRn1T9fpOHo=;
        b=JzuQX42sDANFQdvMKQkg7+vb95njX2/nyz39IOY0uzZD1rEyuj/LgFHaIqgJMcIook
         F6r8wAFPUK1CuZMjWdEWfyLQUNCIscOLMlB2NmDbsqc/mx9Bez4DS+4iScDDD6RL51j+
         GM7ttf/TIMVSGCC8pBZOQwF7bIb/Wy1t/z22/jE1zfrmcUmj85FhSGP6q1rTOn1nmlZP
         pyGjnrsUWZ3gNriN+x/IMz7p77s+hyW6MIeH6yZSlE1l9ltJhCnIUPS9Smye2QZDJ/qo
         AUa1RiU0GhvK6hdtkRG/gSJnWazcYMFHI89moFy5RqB8Rn65rswuBjUxcJrl1oGQbA7X
         9rTw==
X-Gm-Message-State: AC+VfDxo9jRoa/Hl+N5owjpd/+DvKSw4aNZpIpHgFCczcX3SAHompkbl
        piTyhZMZVltLlE6v3HQrUE8=
X-Google-Smtp-Source: ACHHUZ7lf6ZCg92WrS5N6WhJIVm8cZsqXmc9I3KGq/I3Ihg88kzzkPbjfTiefkPlMFqImG6X9xUaFA==
X-Received: by 2002:a05:6512:60a:b0:4f8:560e:f4d8 with SMTP id b10-20020a056512060a00b004f8560ef4d8mr1585656lfe.6.1686929351105;
        Fri, 16 Jun 2023 08:29:11 -0700 (PDT)
Received: from [192.168.50.244] (83.8.116.77.ipv4.supernova.orange.pl. [83.8.116.77])
        by smtp.gmail.com with ESMTPSA id d13-20020aa7d5cd000000b00510d110db58sm10019513eds.80.2023.06.16.08.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:29:10 -0700 (PDT)
Message-ID: <23f9f004-3e20-67b0-bddc-ab9700968c53@gmail.com>
Date:   Fri, 16 Jun 2023 17:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH 2/4] video: backlight: lp855x: get PWM for PWM mode during
 probe
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-pwm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230429104534.28943-1-aweber.kernel@gmail.com>
 <20230429104534.28943-3-aweber.kernel@gmail.com>
 <20230614083953.e4kkweddjz7wztby@pengutronix.de>
Content-Language: en-US
In-Reply-To: <20230614083953.e4kkweddjz7wztby@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 10:39, Uwe Kleine-König wrote:
> On Sat, Apr 29, 2023 at 12:45:32PM +0200, Artur Weber wrote:
>> Also deprecate the pwm-period DT property, as it is now redundant
>> (pwms property already contains period value).
>>
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>> ---
>>  drivers/video/backlight/lp855x_bl.c | 48 ++++++++++++++++-------------
>>  1 file changed, 26 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
>> index 81012bf29baf..21eb4943ed56 100644
>> --- a/drivers/video/backlight/lp855x_bl.c
>> +++ b/drivers/video/backlight/lp855x_bl.c
>> ...
>> @@ -472,11 +456,31 @@ static int lp855x_probe(struct i2c_client *cl)
>>  	lp->enable = devm_regulator_get_optional(dev, "enable");
>>  	if (IS_ERR(lp->enable)) {
>>  		ret = PTR_ERR(lp->enable);
>> -		if (ret == -ENODEV) {
>> +		if (ret == -ENODEV)
>>  			lp->enable = NULL;
>> -		} else {
>> +		else
>>  			return dev_err_probe(dev, ret, "getting enable regulator\n");
>> -		}
>> +	}
>> +
>> +	lp->pwm = devm_pwm_get(lp->dev, lp->chipname);
>> +	if (IS_ERR(lp->pwm)) {
>> +		ret = PTR_ERR(lp->pwm);
>> +		if (ret == -ENODEV || ret == -EINVAL)
> 
> Why would you ignore EINVAL?

EINVAL is returned when the pwms property is not found in the DT node
for the backlight. Not sure if there's a better way of separately
detecting whether it's present (especially when taking into
consideration non-DT platforms that might use the driver). Would be nice
to have something like devm_regulator_get_optional but for PWMs...

Still, someone who's setting up the driver could check the debug
messages to see if the backlight was set up in PWM mode or register mode.

> ...
>> +		pwm_init_state(lp->pwm, &pwmstate);
>> +		/* Legacy platform data compatibility */
>> +		if (lp->pdata->period_ns > 0)
>> +			pwmstate.period = lp->pdata->period_ns;
>> +		pwm_apply_state(lp->pwm, &pwmstate);
> 
> This is a change in behaviour. Before lp855x_probe() didn't modify the
> state the bootloader left the backlight in. Now you're disabling it (I
> think). Is this intended?

I didn't really consider the implication of this in this way, as on the
device I was testing this on (Exynos4212-based tablet) the PWM state
would get reset during PWM chip initialization in the kernel anyways,
meaning that the state from the bootloader would be lost regardless of
this change. Either way, there's no guarantee that this would be the
same on other devices, though I'd assume that in most cases it's not
noticeable anyways as brightness is usually set somewhere in userspace
(or even earlier, in the driver, if the init-brt property is set).
Nonetheless, that's an oversight on my part.

As for the reasoning for this change in behavior - the previous behavior
was to silently fail if, while setting the brightness, the PWM could not
be set up. This seemed rather confusing to me (I encountered this while
I was initially working on the tablet, I added a "pwm" property instead
of "pwms" and was wondering why the backlight didn't work...)

Of course, that could be fixed by adding error detection in the
brightness set function, but since I was already working on it, it made
more sense to me for the PWM to be set up during the probing process,
given that this way we could 1. warn about errors early, and 2. catch
deferred probes and defer the backlight's probe if we're still waiting
for the PWM. That's why it's done the way it is in this patch.

If this is undesired behavior, let me know and I'll submit another patch
to revert it.

Best regards
Artur
