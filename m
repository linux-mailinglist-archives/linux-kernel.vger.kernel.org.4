Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A616D6CD24C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjC2GtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjC2GtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:49:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F150EED;
        Tue, 28 Mar 2023 23:49:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h25so18832280lfv.6;
        Tue, 28 Mar 2023 23:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680072541;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gt+x8l5hdO1MF7qInrd2a05e63r26ixg23F+pmR6ms=;
        b=oS8cz5dV/5iC317d3YrYH4ZB6DI7RK2cEy5cReIMzziIxXmdvUVagCbjIAm0eZL9uu
         YqlA35W7N/DACulrCb5TfLLlOASdplz94wU5v6OrbxgXJ5JT8pBeiymKHMf7wQx6OA5C
         xFzxvJxhDmJDv/LaTTdhWxNSPl1Fdz/zQOMeKQsP4CZ3hOPvv/PuSrutLMeuMnQgMZU8
         A5ttXQW2B+lpoePu1iL9Q+jxiVrrRMmAV6s3sX644/vbRIJHwuhFdGFR3aD1ekNEX9sf
         XVFzZlT+b91A+HxM7oW525lGj3QHuACD6HTO6dBm3H6GpF2Tf7baFNOa6nOPkz8QoH/O
         ufvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680072541;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gt+x8l5hdO1MF7qInrd2a05e63r26ixg23F+pmR6ms=;
        b=IescR4MA9CIHUa+MwaFonDHxCiAD48Pq0qckcp5Hpx0Dy7RXEw07gOKZqGfWulbYsA
         opG9umoUsSBZMM+djps81XNySLpKFZ5hQvY/e/S2VasxIRjp+7kMk3zX/7ellaNh4+91
         vS18ck9ADLqK/rx+n8GA+TUQAkYAyKsy0ISYMNA2zSsaLkMnbAOWzPpGMCi+2AoPIYZz
         4svCaYCwsHYyDckseU0JC8c9h9aP1FOIjPIfJhUNVHjgqt9/ZB8TNBEBIgVZNI4KdFdm
         +/E+btFF/6LZ1++DZa3s8ZsOs0VinZQxwygymxkKEibLT/ttxxgPncpVHXhb2uhsDY0O
         C9KQ==
X-Gm-Message-State: AAQBX9cuIJUQZnle6ehtlr7X/qmIPVS90yVfTjM7C9sfN+vM7UZZUSqk
        THNE6lpFzby6n19jaudB7/0ZjFW0Szo=
X-Google-Smtp-Source: AKy350as7m70JBI0gU0dwmbOr6Yzn2Qge/yEZ0tNaRG5uluQaV/DdDjs9Bn5L2b6w0b31eI4K2ATcg==
X-Received: by 2002:ac2:5210:0:b0:4eb:11dc:d9a5 with SMTP id a16-20020ac25210000000b004eb11dcd9a5mr2622076lfl.32.1680072541044;
        Tue, 28 Mar 2023 23:49:01 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u14-20020a056512094e00b004cb35b31b96sm5339561lft.257.2023.03.28.23.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 23:49:00 -0700 (PDT)
Message-ID: <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
Date:   Wed, 29 Mar 2023 09:48:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
In-Reply-To: <20230328150335.90238-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh, all

This mail is maybe more of a question so that I can get on the same page 
with the rest of the world than anything else. I just have to ask this 
as I am trying to figure out what kind of handling there could be for 
regulator errors. I added Mark and couple of others to the CC as I am 
under the impression they have done some work with the regulator error 
handling lately :)

On 3/28/23 18:03, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add regulator events corresponding to regulator error in regulator flag
> map.
> Also capture the same in pmbus_regulator_get_flags.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 74 +++++++++++++++++++++-----------
>   1 file changed, 49 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index d93405f1a495..509bc0ef1706 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2693,9 +2693,9 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>   	return 0;
>   }
>   
> -/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
> +/* A PMBus status flag and the corresponding REGULATOR_ERROR_* and REGULATOR_EVENTS_* flag */
>   struct pmbus_status_assoc {
> -	int pflag, rflag;
> +	int pflag, rflag, eflag;
>   };
>   
>   /* PMBus->regulator bit mappings for a PMBus status register */
> @@ -2710,27 +2710,36 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
>   		.func = PMBUS_HAVE_STATUS_VOUT,
>   		.reg = PMBUS_STATUS_VOUT,
>   		.bits = (const struct pmbus_status_assoc[]) {
> -			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
> -			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
> -			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> -			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
> +			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN,
> +			REGULATOR_EVENT_UNDER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE,
> +			REGULATOR_EVENT_UNDER_VOLTAGE },
> +			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN,
> +			REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT,
> +			REGULATOR_EVENT_OVER_VOLTAGE_WARN },

The question I have is: Are these mappings to regulator 
errors/notifications always correct?

(I don't know the PMBUS specification in details - and thus I am 
_asking_ this here, not telling that the mapping is incorrect).

Let me explain why I am asking this.

What I have gathered is that at least some ICs allow setting for example 
'voltage limits' for different PMBUS over-voltage WARNs/FAULTs. I 
however don't know if for example the "fatality" of errors indicated by 
FAULTS vs WARNs is mandated by any specification - or if a hw designers 
have free hands to decide what these events indicate on their board - or 
what type of action should be taken when certain ERROR/WARN is emitted.

Then to the handling of regulator errors:

In order to be able to create any handling for the regulator 
errors/notifications, we should be able to classify the 
errors/notifications at least by the severity. The very fundamental 
decision is whether to turn-off the regulator - or even the whole system 
- in order to protect the hardware from damage.

There are few other questions related to error handling as well - for 
example questions like:
Who should handle error? (we may have many consumers?)
When should consumer use for example forced regulator-off without 
knowing the other consumers?
When should we have in-kernel handling for errors?
When should the errors be sent to user-space trusting someone there is 
taking care of the situation?

Following is largely my own pondering - and I would like to gain better 
understanding while also avoid sending wrong events/errors for detected 
HW issues so that we could actually implement recovery actions based on 
regulator errors / notifications.

I have been trying to understand how error handling with regulator 
events should / could work. In my head (and in the regulator fault 
detection limit setting) we have 3 severity categories:

1. PROTECTION:
The most 'severe' type of issue. This is reserved for cases where the 
hardware shuts down the regulator(s) without any SW interaction. In most 
cases there is no need for notification or error status because soc is 
likely to go down when the power is cut off. Border case is when HW 
autonomously shuts down a regulator which does not deliver power to any 
critical component. I am unsure if such situation should be indicated by 
ERROR level notification.

2. ERROR:
Situation where system is no longer usable but the hardware does not do 
error handling. I would like to suggest that the proper handling for 
this type of events is regulator or system shutdown. I think the 
errors/notifications:

#define REGULATOR_ERROR_UNDER_VOLTAGE           BIT(1)
#define REGULATOR_ERROR_OVER_CURRENT            BIT(2)
#define REGULATOR_ERROR_REGULATION_OUT          BIT(3)
#define REGULATOR_ERROR_FAIL                    BIT(4)
#define REGULATOR_ERROR_OVER_TEMP               BIT(5)

#define REGULATOR_EVENT_UNDER_VOLTAGE           0x01
#define REGULATOR_EVENT_OVER_CURRENT            0x02
#define REGULATOR_EVENT_REGULATION_OUT          0x04
#define REGULATOR_EVENT_FAIL                    0x08
#define REGULATOR_EVENT_OVER_TEMP               0x10

should only be used to indicate errors with this severity. That would 
allow actually implementing the handling for these errors. If these 
errors are sent for "less severe" issues, then we will not be able to do 
any generic error handling.

3. WARNING:
Situation where something is off-the-spec, but system is still thought 
to be usable. Here some - probably board/system (use-case?) specific - 
handling may be taking place to prevent things getting worse. I added 
following flags for this purpose:

#define REGULATOR_EVENT_UNDER_VOLTAGE_WARN      0x2000
#define REGULATOR_EVENT_OVER_CURRENT_WARN       0x4000
#define REGULATOR_EVENT_OVER_VOLTAGE_WARN       0x8000
#define REGULATOR_EVENT_OVER_TEMP_WARN          0x10000
#define REGULATOR_EVENT_WARN_MASK               0x1E000

#define REGULATOR_ERROR_UNDER_VOLTAGE_WARN      BIT(6)
#define REGULATOR_ERROR_OVER_CURRENT_WARN       BIT(7)
#define REGULATOR_ERROR_OVER_VOLTAGE_WARN       BIT(8)
#define REGULATOR_ERROR_OVER_TEMP_WARN          BIT(9)


So, my question(s) are:

1) Is this "classification" sensible and is it still possible?
2) does PMBUS *_WARNING status bits always indicate error which maps to 
severity WARNING above? And more importantly
3) does PMBUS *_FAULT status bits always indicate error which maps to 
severity ERROR above? Eg, can we assume correct handling for _FAULT is 
shutting down the regulator/system?

We have something similar in a few (non PMBUS compatible) PMICs. For 
example the ROHM BD9576 has a PROTECTION level error detection 
(automatic shutdown by HW) and then another error detection which just 
generates an IRQ and allows software to decide what should be done.

While writing the driver for that PMIC my thinking was that the decision 
whether IRQ is indicating a fatal error or a warning should be on the 
board-designer's table. Thus I implemented it so that the severity and 
limit configuration for this error is given via device-tree - and it is 
up to board designer to decide whether the fault is ERROR or WARN - and 
notification sent by the driver for this IRQ will reflect the given 
severity.

I wonder if something like this is needed for PMBUS - or if we can 
always say the *_FAULT maps to regulator ERROR and _WARNING maps to 
regulator WARNING no matter how board using the IC is designed?

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

