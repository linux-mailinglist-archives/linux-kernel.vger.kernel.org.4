Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8BE6A9A50
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjCCPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCCPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:12:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D166E60ABB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:12:45 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id az36so1820583wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uk+s/qD/3O1ooLhMXsQ7luVlbcQ85Ctw4HQhIQJpqbA=;
        b=fjWQ2ZpgH6O2sZyyZ80AwkI1oUqIXLuZmt5hKWmC2Rim5niL6NUmMZRggQaT39/aAy
         h2q4jABlQ7dE/R/LBBtaFIFPm3dWZ0eDjU7zLfjjxfoX3h0WtiF1P3YMKSL6mH6eN8gF
         f6juQiew6u2ke/5gRQZLDQVsPT0fPUrAnJyPIYZ7/ej4pXjb8ECq12+/n0a7O1cnREuK
         XN9OgQudAjsat8KOcZXu8nYZPVpeW3lciZZCpf3uvbW66zqUkKa4hktumH0rZCUKzC3j
         +3SMbohjGMQHUagNpox9FbfDAvNHc5XDDjGfzlJh2hjleUewlrB4IjNCCzwAflp6oMA/
         WTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk+s/qD/3O1ooLhMXsQ7luVlbcQ85Ctw4HQhIQJpqbA=;
        b=EqSbE5xXhwmHniI/ntwMt/sukF69pIcJfGvuTiSmvrc2rvKo/jkeakwtCPYkujVE0Y
         YD6VKb8ocThxgRPG/L4Bj9M9pp/KGTiJb5LRgZuPs62WxRfuesUCU44XwqusI+sJ7ARm
         kOpLRttDW3Sap8HBYrysAbEWz4qhMhCflwhL3mfZG/AHVQafi67CHNYigaN/oxv/L861
         Cq7Qrf1d9TnMVKkgwJSdwi11wXnxuR/f5sO+KfJcv6l+GSnJr4SOiKtRXmOqW5rlsrVf
         VimyFdz0InTCIhmbvptVuEZFWSsr3TdsR29tnQpfHaGG/8Z8YzJN4gCzokkFHcKYBXVG
         MZww==
X-Gm-Message-State: AO0yUKWZUNJQ1HPsCKcyNk07v3OZGnZcEtCagGPu/sil3+dn1Ej56DvY
        TJ6YM9ep5iRQd1XVmlnwzeKGjQ==
X-Google-Smtp-Source: AK7set9tDQA71r+vFbwR6C+zydRKRlijrx8KIOT77KraGZKtxBVvJ3AeVv9AtZQ3I6S+Dhx38m3EaA==
X-Received: by 2002:a05:600c:3d8b:b0:3eb:578d:ded3 with SMTP id bi11-20020a05600c3d8b00b003eb578dded3mr2023925wmb.35.1677856364323;
        Fri, 03 Mar 2023 07:12:44 -0800 (PST)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c351600b003daf6e3bc2fsm10568349wmq.1.2023.03.03.07.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 07:12:44 -0800 (PST)
Message-ID: <8d9afb7e-0141-f2a7-a779-6c5bfd35e6f9@baylibre.com>
Date:   Fri, 3 Mar 2023 16:12:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mfd: tps65219: Add support for soft shutdown via sys-off
 API
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com, nm@ti.com,
        msp@baylibre.com
References: <20230203140150.13071-1-jneanne@baylibre.com>
 <Y/94Pew4vr6FROcI@google.com> <d4abf0c3-f5c8-fd54-87f6-4397596ae40f@ti.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <d4abf0c3-f5c8-fd54-87f6-4397596ae40f@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/2023 17:35, Andrew Davis wrote:
> On 3/1/23 10:07 AM, Lee Jones wrote:
>> On Fri, 03 Feb 2023, Jerome Neanne wrote:
>>
>>> Use new API for power-off mode support:
>>> Link: https://lwn.net/Articles/894511/
>>> Link: https://lore.kernel.org/all/7hfseqa7l0.fsf@baylibre.com/
>>>
>>> sys-off API allows support of shutdown handler and restart handler.
>>>
>>> Shutdown was not supported before that enhancement.
>>> This is required for platform that are not using PSCI.
>>>
> 
> Not sure what platform doesn't have PSCI off, since you tested on
> AM62-SK I'm guessing you manually disabled the PSCI off for testing?
> 
> Anyway I don't see any huge issues with the code itself, small comment 
> below.
> 
>>> Test:
>>> - restart:
>>>    # reboot
>>>    Default is cold reset:
>>>    # cat /sys/kernel/reboot/mode
>>>    Switch boot mode to warm reset:
>>>    # echo warm > /sys/kernel/reboot/mode
>>> - power-off:
>>>    # halt
>>>
>>> Tested on AM62-SP-SK board.
>>>
>>> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
>>> Suggested-by: Andrew Davis <afd@ti.com>
>>
>> A review from Andrew would be helpful here.
>>
>>> ---
>>>   drivers/mfd/tps65219.c | 45 +++++++++++++++++++++++++++++++-----------
>>>   1 file changed, 34 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
>>> index 0e402fda206b..c134f3f6e202 100644
>>> --- a/drivers/mfd/tps65219.c
>>> +++ b/drivers/mfd/tps65219.c
>>> @@ -25,25 +25,34 @@ static int tps65219_cold_reset(struct tps65219 *tps)
>>>                     TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK);
>>>   }
>>> -static int tps65219_restart(struct notifier_block *this,
>>> -                unsigned long reboot_mode, void *cmd)
>>> +static int tps65219_soft_shutdown(struct tps65219 *tps)
>>>   {
>>> -    struct tps65219 *tps;
>>> +    return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
>>> +                  TPS65219_MFP_I2C_OFF_REQ_MASK,
>>> +                  TPS65219_MFP_I2C_OFF_REQ_MASK);
>>> +}
>>> -    tps = container_of(this, struct tps65219, nb);
>>> +static int tps65219_power_off_handler(struct sys_off_data *data)
>>> +{
>>> +    tps65219_soft_shutdown(data->cb_data);
>>> +    return NOTIFY_DONE;
>>> +}
>>> +static int tps65219_restart(struct tps65219 *tps,
>>> +                unsigned long reboot_mode)
>>> +{
>>>       if (reboot_mode == REBOOT_WARM)
>>>           tps65219_warm_reset(tps);
>>>       else
>>>           tps65219_cold_reset(tps);
>>> -
>>>       return NOTIFY_DONE;
>>>   }
>>> -static struct notifier_block pmic_rst_restart_nb = {
>>> -    .notifier_call = tps65219_restart,
>>> -    .priority = 200,
>>> -};
>>> +static int tps65219_restart_handler(struct sys_off_data *data)
>>> +{
>>> +    tps65219_restart(data->cb_data, data->mode);
>>> +    return NOTIFY_DONE;
>>> +}
>>>   static const struct resource tps65219_pwrbutton_resources[] = {
>>>       DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_FALLING_EDGE_DETECT, 
>>> "falling"),
>>> @@ -269,13 +278,27 @@ static int tps65219_probe(struct i2c_client 
>>> *client)
>>>           }
>>>       }
>>> -    tps->nb = pmic_rst_restart_nb;
>>> -    ret = register_restart_handler(&tps->nb);
>>> +    ret = devm_register_sys_off_handler(tps->dev,
>>> +                        SYS_OFF_MODE_RESTART,
>>> +                        SYS_OFF_PRIO_HIGH,
> 
> Why not default prio? SYS_OFF_PRIO_DEFAULT
I'm not completely clear about PRIO recommendations. Will follow your 
suggestion.
> 
> Then you can use this new helper devm_register_restart_handler()
Sure!
> 
>>> +                        tps65219_restart_handler,
>>> +                        tps);
>>> +
>>>       if (ret) {
>>>           dev_err(tps->dev, "cannot register restart handler, %d\n", 
>>> ret);
>>>           return ret;
>>>       }
>>> +    ret = devm_register_sys_off_handler(tps->dev,
>>> +                        SYS_OFF_MODE_POWER_OFF,
>>> +                        SYS_OFF_PRIO_DEFAULT,
>>> +                        tps65219_power_off_handler,
>>> +                        tps);
> 
> 
> devm_register_power_off_handler()?
> 
Oh yes, right, this is solving the PRIO question by construction. This 
is definitely a better option
> Otherwise I see no major issues,
> 
> Reviewed-by: Andrew Davis <afd@ti.com>
> 
> Andrew
> 
>>> +    if (ret) {
>>> +        dev_err(tps->dev, "failed to register sys-off handler: %d\n",
>>> +            ret);
>>> +        return ret;
>>> +    }
>>>       return 0;
>>>   }
>>> -- 
>>> 2.34.1
>>>
>>
