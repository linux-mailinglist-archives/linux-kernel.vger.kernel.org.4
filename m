Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE046DAB21
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbjDGJ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjDGJ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:56:56 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA37ECB;
        Fri,  7 Apr 2023 02:56:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bx10so24765678ljb.8;
        Fri, 07 Apr 2023 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680861411;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMmt0J7ORv2kNOivTrzHCNzDsNn+ORI7SQCDfabUQlQ=;
        b=eNPnkVGvBbGr9Btxvn/s9UijDefC/i/wn3RTw621S4TZ5aZ0BfwJNXwW4fy2AylBQ4
         RP8Yy6IKobIQrGZClMZumuo4PM7YX5n84HpT7Bn665/AHIXRoe2yONpfxMGUlfjXOFog
         1H/fY3/qfzNFw1AC1JbXxf3Tu0CmG3/6sqKd119Cd22sTotw7zkk0MzzxGRwcy16whfR
         sg+KRqXXd7x/d8mrXUJge4mhBXIgdwWnLV8zo3cdHAR10l1FXUUBTftONJgzrTKeh37m
         LCK731eIzVgbZld3/Np9RXN44ukaWvEDgg0btTzFAIqhGxEYw3sHlmy/nqIT4xthpONi
         LIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680861411;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMmt0J7ORv2kNOivTrzHCNzDsNn+ORI7SQCDfabUQlQ=;
        b=UO5O7MeqmxYige3sW+ATSE3mZ99j+NwLHluo2nx57ndNjRsVYwkzGCYfQTMGw8BwuT
         C9zG8kR09fHonW6UOGhad+VHyQvoNe8BWX7GzJ5uWAlBjh5eQrmfWcqm+iFjUPHbwmYI
         qWaAMDhr8N+UhLcBFg5amemrFhePH6aBpib9sje6mLPCrMSigMawd8eZHzB7Npxucevl
         fINlQahiqqGtjt9dISp38QNf+JWllymDNXGAfuFqsbGSqoK/6EBIoND2GCucu1tnOXHM
         aUkGz/NGEt7U+6MaTQiNmmd52NV4QxLZrnCU1Ns6g8S4CLSqWsVgl9ib3GUdfLLBBlzs
         bXbQ==
X-Gm-Message-State: AAQBX9eDXRDhJzZDRT9sjWwJ2dcU5+mPzBcURgB9FUu2bfCwNHovm9Iv
        WlTfnuNpmv2/NwuJsopaJ9k4ZRTolXI=
X-Google-Smtp-Source: AKy350adYwZ2tMS6/aINbpRHWU2upOjKpcv+V0eiAolEaez7cReLwzPlmEqDWjL60giadZTX9sxsCA==
X-Received: by 2002:a2e:9a90:0:b0:295:ba22:360 with SMTP id p16-20020a2e9a90000000b00295ba220360mr524428lji.42.1680861411435;
        Fri, 07 Apr 2023 02:56:51 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id v12-20020a2e9f4c000000b00295a583a20bsm722163ljk.74.2023.04.07.02.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 02:56:51 -0700 (PDT)
Message-ID: <fafac053-6009-562e-8e29-ee6435a3c8d1@gmail.com>
Date:   Fri, 7 Apr 2023 12:56:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
References: <20230406060825.103187-1-andreas@kemnade.info>
 <20230406060825.103187-3-andreas@kemnade.info>
 <7d8c558f-0d21-91ed-ecd0-cac079d366ee@gmail.com>
 <20230406214539.59dfaac7@aktux>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel i2c
 LED driver
In-Reply-To: <20230406214539.59dfaac7@aktux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 22:45, Andreas Kemnade wrote:
> On Thu, 6 Apr 2023 11:57:15 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> [...]
> 
>>
>>> + */
>>> +
>>> +#include <linux/i2c.h>
>>> +#include <linux/leds.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#define BD2606_MAX_LEDS 6
>>> +#define BD2606_MAX_BRIGHTNESS 63
>>> +#define BD2606_REG_PWRCNT 3
>>> +#define ldev_to_led(c)	container_of(c, struct bd2606mvv_led, ldev)
>>> +
>>> +struct bd2606mvv_led {
>>> +	bool active;
>>
>> I didn't spot where this 'active' was used?
>>
> [..]
> 
>>> +		if (reg < 0 || reg >= BD2606_MAX_LEDS ||
>>> +		    priv->leds[reg].active) {
> 
> here
> 
>>> +			of_node_put(child);
>>> +			return -EINVAL;
>>> +		}
>>> +		led = &priv->leds[reg];
>>> +
>>> +		led->active = true;
> 
> and here

Oh, right. So, if I read this correctly, "active" is only used in the 
probe for checking if same 'reg' is given for mone than one LEDs.

If the 'active' is not used after probe then I'd prefer limiting the 
life-time to probe. Perhaps drop this from the allocated private data 
and just take it from the stack and let it go when probe is done?

This is a minor thing but if there will be other reason(s) to re-spin, 
then this might be changed?

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

