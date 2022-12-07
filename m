Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EB364532B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLGEqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGEqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:46:44 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41CF56EFD;
        Tue,  6 Dec 2022 20:46:42 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-144bd860fdbso6890967fac.0;
        Tue, 06 Dec 2022 20:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1/Ng+Dr2rkqsmZDPUsgrcOu+0tsMrp/RZvVMuJ/HlU=;
        b=ZZpWywYsd8k0y/0fsZ/u4iyM9Lxlpw+2K+yMBJBA9sJf5oXusPeQK53/YMwXepBj4B
         AmqhyrEz8QndwjjCQ6mnP4PS23tKD+iq6gEy9NHk+y8lH23jBrWyGjhDuL1WUhJLi+by
         2IKK23FZyq6NmzKQ36AxS0lWsOYUWR0xXUjyeYzso1tHiaN/YyipDsXH79O0sfO8WkpX
         u4O9Ke/rMEbGzV3zxy5XeYywQoqHS0UIxTZJFMVbZLPCz3LGswBqiqO5BH3VLBzEyiUJ
         nVUc4ynna4SnEiXuKMBvH9i8QdFXU/672El7IxGkL+yzHxVdB3do/s7QNhExmIqMRgcK
         Wl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1/Ng+Dr2rkqsmZDPUsgrcOu+0tsMrp/RZvVMuJ/HlU=;
        b=KdvyGwWl/Oor5jxBqlb0gJOV50v0UC2IDFtRlu1B1IpEI5sylU2+J8FZpAn+dlG0lw
         nByWH/T65xQfCfLHOVOSx+/sUDb2vo9IQju6pZlBJFQOSaRAUDYzfCQvnKG7m64mtksT
         NybyDwSqegamYCg/mSZtqUS4VFippZHW7ChrjOpw1xekicWZUFh6QaXffTa61pcZsujr
         7UGaz6Fe5S5j5AoLREw3WK81w39qPseoJ9MccaSbM4U6PYQUKpuiR5xVZs7I6o2uTPs9
         6eKr5g42pRozlVdvFFJg7LIa/I25i2Ms5snOKw5mTXPGx0aBHvT8X9k9jXqrqrpbaEp9
         A5EA==
X-Gm-Message-State: ANoB5pkYytTsazuwG9kaVgTAeggYNL23Cd8Xm7mRVwHczAZnYRFEXEd4
        3S7wy5akcMPWM/mjQ3UOhcrhi1WF/A0=
X-Google-Smtp-Source: AA0mqf7RlxYY/y7aZmw8C5UIkz6KslfCL8Wn3tP1DjdGDhtHR0lc1AVg5gbcRFCBSHLWYOauAMlveA==
X-Received: by 2002:a05:6870:9d8b:b0:143:cbc:ac46 with SMTP id pv11-20020a0568709d8b00b001430cbcac46mr38499211oab.271.1670388401977;
        Tue, 06 Dec 2022 20:46:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f8-20020a056870c10800b001446d5702b5sm6675584oad.56.2022.12.06.20.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 20:46:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <61eb8715-958a-f81d-17ad-7086f9ea81f5@roeck-us.net>
Date:   Tue, 6 Dec 2022 20:46:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        marten.lindahl@axis.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221201044643.1150870-1-saravanan@linumiz.com>
 <20221201044643.1150870-4-saravanan@linumiz.com>
 <00de62b2-51dc-2a72-6659-3425d5e1b72c@roeck-us.net>
 <6773256d-2842-fadc-1222-f76e0b495eda@linumiz.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/4] hwmon: (pmbus/mpq7932) Add a support for mpq7932
 Power Management IC
In-Reply-To: <6773256d-2842-fadc-1222-f76e0b495eda@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 19:51, Saravanan Sekar wrote:
> On 01/12/22 16:34, Guenter Roeck wrote:
>> On 11/30/22 20:46, Saravanan Sekar wrote:
>>> The MPQ7932 is a power management IC designed to operate from 5V buses to
>>> power a variety of Advanced driver-assistance system SOCs. Six integrated
>>> buck converters with hardware monitoring capability powers a variety of
>>> target rails configurable over PMBus interface.
>>>
>>> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
>>> ---
>>>   drivers/hwmon/pmbus/Kconfig   |  10 +++
>>>   drivers/hwmon/pmbus/Makefile  |   1 +
>>>   drivers/hwmon/pmbus/mpq7932.c | 144 ++++++++++++++++++++++++++++++++++
>>>   3 files changed, 155 insertions(+)
>>>   create mode 100644 drivers/hwmon/pmbus/mpq7932.c
>>>
>>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>>> index 89668af67206..4a1538949a73 100644
>>> --- a/drivers/hwmon/pmbus/Kconfig
>>> +++ b/drivers/hwmon/pmbus/Kconfig
>>> @@ -317,6 +317,16 @@ config SENSORS_MP5023
>>>         This driver can also be built as a module. If so, the module will
>>>         be called mp5023.
>>> +config SENSORS_MPQ7932
>>> +    tristate "MPS MPQ7932"
>>
>> As written, a dependency on REGULATOR is missing. However, we want the driver
>> enabled even if CONFIG_REGULATOR is not enabled. I would suggest to follow the
>> approach used by other drivers: add a second configuration option
>> SENSORS_MPQ7932_REGULATOR which depends on SENSORS_MPQ7932 and REGULATOR
>> and enables regulator functionality, and use that in the driver to
>> make regulator support optional.
>>
> 
> Hello Guenter,
> 
> I need clarification or confirmation from you before V3.
> 
> Here is my view, communication to MPQ7932 PMIC chip is based on pmbus specification.
> 
> Now the conflict is that we have pmbus directory under hwmon subsystem, if pmbus spec implementation would have been separate like i2c-smbus then we can implement chip driver in regulator subsystem which access pmbus.
> 
> pmbus_core does supports regulator framework PMBUS_REGUALTOR and I believe it is valid MPQ7932 driver implantation under pmbus directory.
> 
> Kindly suggest to remove pmbus dependency on hwmon and proceed further.
> 

Every chip supporting PMBus has hwmon functionality. The PMBus core
as implemented primarily supports hardware monitoring. Some can
act as regulators; that is why regulator support was added to
the PMBus core. Trying to extract it would make no sense.

If you want to implement a driver without hardware monitoring
support for this chip, you won't need the PMBus core. I would not
agree with such an approach, but there is nothing that prevents you
from implementing a regulator-only driver for this chip in the
regulator subsystem.

Guenter

