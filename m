Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A3872BA16
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjFLISc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjFLISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:18:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C51FDC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:17:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30fbac9639fso1156126f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686557873; x=1689149873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BLdKV6ydqTF5FF9wuUDahLeHWRQMuZz0P9EBbaIRdk=;
        b=twR2vTInGL8pHkStNJy5NRmM+Wca1Y/S3lt6RVZyWVxtSYFclxfkNUCZfK69Xg2Y1T
         YRM5Ap8g6gFmuyLVhj/YfTe/Wo5ArRei/EPJJsaF32bfcWKorSwGDsNIvM1h3YC+fv0r
         YlnIcEf3qC1jx7iCr+Jxweq9DU80U5CSwHoRCbGothCClZWUlc7HYVRqRfQopRPGVjD4
         EP8aaxpcLigGPOnEXUjsw0ho1F1RQ5mH0zdKolCsoKfiPGsHeJZ6xn6oOTnlylsbWuXm
         JXdbinv7zF/7Eq3Y42sl56hQ0YwpAzFBAD1jh6oW6RKU2juC9LJMsAHuylEIwQefFePh
         wF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686557873; x=1689149873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BLdKV6ydqTF5FF9wuUDahLeHWRQMuZz0P9EBbaIRdk=;
        b=FPsSgbUUdjwWU44c537zPz6mNiLhYt8WgZdCC/8P1jSC21rsCgWn0a8AlPlN8nIlaa
         x5TunlJYpwZS2mX0yBT2rb2H7PHa82XXEFjXIUit17oEuV6UtDwyVRSbiJK+Cp33wkPI
         FtcUD5FoAhnYJHr4DsK6UWliMnthYpSTHikngkqjCaNSCG1jgh/gPh3gCvi6q8uDnZcz
         L211hJycY7CMd27V54ipdol6ytDv78Y3rXTZ+UZg9fFnr9i52zMgwQ6+y5Ope186NVvy
         /OFe/zI0w43pKFbyL9MOE0bJLiinbZMyBDnq2OoZh5K9aSfsDM1Ki02xJaZNfd4Wx6J8
         N66Q==
X-Gm-Message-State: AC+VfDwrR62Vf2VKqJ8LyXn3GAFEpnBISYu4Cjp11XoB0Vz6tt/kdV5n
        Oo+E2CS8gmxfJYCb7+BqLz75bw==
X-Google-Smtp-Source: ACHHUZ7LLAVAmKum5VLuS9SWmtAfP4UMrs+AF2aFcR0Uh72RFfwgJ7NWUfMQBdCfiMl35JHr/MTF+Q==
X-Received: by 2002:a5d:522b:0:b0:30f:c1f5:e91e with SMTP id i11-20020a5d522b000000b0030fc1f5e91emr1381133wra.27.1686557873141;
        Mon, 12 Jun 2023 01:17:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb02:9baa:82d1:2486? ([2a05:6e02:1041:c10:bb02:9baa:82d1:2486])
        by smtp.googlemail.com with ESMTPSA id m11-20020a5d6a0b000000b0030b5d203e7esm11695296wru.97.2023.06.12.01.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:17:52 -0700 (PDT)
Message-ID: <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
Date:   Mon, 12 Jun 2023 10:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Content-Language: en-US
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     eduval@amazon.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
 <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Eduardo,

On 08/06/2023 19:44, Eduardo Valentin wrote:

[ ... ]

>> Do you have a use case with some measurements to spot an issue or is it
>> a potential issue you identified ?
> 
> 
> yes, a governor that is using I2C device as input, behind I2C fast mode (100KHz)
> and needs to update the zone every 100ms. Each read in this bus, if done alone
> would be around 500us, takes 10bytes to read the device, it is 10 clocks per byte,
> well technically 9, but rounding for the sake of the example, which gets you
> 50 / 100KHz = 500 us. That is for a single read. You add one single extra
> userspace read triggering an unused device update, that is already a 1ms drift.
> Basically you looking at 0.5% for each extra userspace read competing in this
> sysfs node. You add extra devices in the same I2C bus, your governor is looking
> at more than 1% overhead. And I am talking also about a main CPU of ~800MHz.
> I did not even include the lock overhead considered for this CPU ;-)
> 
> Again, this is not about controlling the DIE temperature of the CPU you
> are running the thermal subsystem. This is about controlling
> a target device.

Ok. The target device is on a bus which is slow and prone to contention.

This hardware is not designed to be monitored with a high precision, so 
reading the temperature at a high rate does not really make sense.

Moreover (putting apart a potential contention), the delayed read does 
not change the time interval, which remains the same from the governor 
point of view.

In addition, i2c sensors are usually handled in the hwmon subsystem 
which are registered in the thermal framework from there. Those have 
most of their 'read' callback with a cached value in a jiffies based way 
eg. [1].

So the feature already exists for slow devices and are handled in the 
drivers directly via the hwmon subsystem.

 From my POV, the feature is not needed in the thermal framework.



[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/hwmon/lm95234.c#n163



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

