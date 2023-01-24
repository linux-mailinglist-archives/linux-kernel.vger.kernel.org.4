Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E1867973A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjAXMFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjAXMFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:05:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDFF29E14
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:05:29 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q8so11248197wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ic8eN3I6cwzBtdtpBaU56bD/9LZvawdWvPnRT+wjLI4=;
        b=rWmlzRYnGQGrT/p1+Upzo6brYfnNA3TV77vb/6F5OKaWkJ9j5epg1eVnH4Kj50zAtO
         4fDeGuV7JGcek1cUKifShvKVNs7w/xq9Xc3Z1pVuOYq1tUhh3u8pGTghoeL/4mbMFrrz
         Jy2rWieEKKFGi4dPfDI26D0gaQA+sKz3HJdN4bWvBpTDzfsuMCa/li9GSxAYIC8b8qZm
         ZWp6io6b5QR6pJM5S2uNlOaXqTD+nyfRP16m+ffoWGn9Nuo0xJEvGra6J/rEnVFcquFo
         G++tDTnkY1aQ1Byzy1cfPsCBtC4M7haq2GX2FH2G5woiU8jzS0voGKXKd9b1G6lnc68a
         6bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic8eN3I6cwzBtdtpBaU56bD/9LZvawdWvPnRT+wjLI4=;
        b=DZSTczCWD9fvKZisi2G/tUqiVOUXWx/yRm1NyB3dQ/fIvY0Vsi2I9tqoBTE2+F0x9C
         Mf9v7PXHHHH16m0jP31RfTIg+sLGPQPUlP07axrVBCn1rUrLXncd+NevllMsBP1ik21Y
         XCMT2Yv9cGyHz/QHy0ImU/7lj2aTUmhNWAQpOuiyjiuTQGR1bZcdBGLtQsLLrik8Ef51
         e5NsxhjQiuqBzTVCc33ySgElv5nZGLiPS7AJ+OWJi+vPzOVmqM7mS5v/mWYxTYnvmUWO
         aqILPOTpAwz5XW6xjYzaTbRr3Y2GbCaO9fHdRP2itO7ztH4j8lx7WIn01UbP50Xw9T4q
         xvtw==
X-Gm-Message-State: AFqh2ko2Mx/48EkUHw1JBtsmCc2pxO4GOSAFG1tc46v8/JHLZ6spUlje
        lVsS7ELVWaIBjTuds0xAREG6+w==
X-Google-Smtp-Source: AMrXdXtDWLE9/Mow9jmUwl0uKzwwn4gUuscIRtfACEWMupiXSbKnJKzbMHEgbV+4SIedSnZ3LK2PeQ==
X-Received: by 2002:a05:600c:21c4:b0:3da:fcf1:d4cc with SMTP id x4-20020a05600c21c400b003dafcf1d4ccmr27434734wmj.30.1674561928413;
        Tue, 24 Jan 2023 04:05:28 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w8-20020a05600c2a0800b003d995a704fdsm1749926wme.33.2023.01.24.04.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 04:05:28 -0800 (PST)
Message-ID: <d8fb3c45-435d-f080-6ba4-e9e4595f3638@linaro.org>
Date:   Tue, 24 Jan 2023 13:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] hwmon: (pmbus/tda38640) Add driver for Infineon TDA38640
 Voltage Regulator
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230124110111.3965317-1-Naresh.Solanki@9elements.com>
 <b4b11836-5a4b-a2b7-18e2-89ca26f19817@linaro.org>
 <05947e9f-0667-4565-b481-ca5635da4174@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <05947e9f-0667-4565-b481-ca5635da4174@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 12:45, Naresh Solanki wrote:
> Hi
> 
> On 24-01-2023 04:40 pm, Krzysztof Kozlowski wrote:
>> On 24/01/2023 12:01, Naresh Solanki wrote:
>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>
>>> Add the pmbus driver for the Infineon TDA38640 voltage regulator.
>>>
>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ---
>>>   .../devicetree/bindings/trivial-devices.yaml  |  2 +
>>
>> Split bindings from driver code.
> Sure
>>
>>>   drivers/hwmon/pmbus/Kconfig                   | 16 ++++
>>>   drivers/hwmon/pmbus/Makefile                  |  1 +
>>>   drivers/hwmon/pmbus/tda38640.c                | 78 +++++++++++++++++++
>>>   4 files changed, 97 insertions(+)
>>>   create mode 100644 drivers/hwmon/pmbus/tda38640.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> index f5c0a6283e61..a28b02036489 100644
>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> @@ -141,6 +141,8 @@ properties:
>>>             - infineon,slb9645tt
>>>               # Infineon SLB9673 I2C TPM 2.0
>>>             - infineon,slb9673
>>> +            # Infineon TDA38640 Voltage Regulator
>>> +          - infineon,tda38640
>>>               # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>>>             - infineon,tlv493d-a1b6
>>>               # Infineon Multi-phase Digital VR Controller xdpe11280
>>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>>> index 30448e049486..9f4bbb9c487a 100644
>>> --- a/drivers/hwmon/pmbus/Kconfig
>>> +++ b/drivers/hwmon/pmbus/Kconfig
>>> @@ -395,6 +395,22 @@ config SENSORS_STPDDC60
>>>   	  This driver can also be built as a module. If so, the module will
>>>   	  be called stpddc60.
>>>   
>>> +config SENSORS_TDA38640
>>> +	tristate "Infineon TDA38640"
>>> +	help
>>> +	  If you say yes here you get hardware monitoring support for Infineon
>>> +	  TDA38640.
>>> +
>>> +	  This driver can also be built as a module. If so, the module will
>>> +	  be called tda38640.
>>> +
>>> +config SENSORS_TDA38640_REGULATOR
>>> +	bool "Regulator support for TDA38640 and compatibles"
>>> +	depends on SENSORS_TDA38640 && REGULATOR
>>> +	help
>>> +	  If you say yes here you get regulator support for Infineon
>>> +	  TDA38640 as regulator.
>>
>> Drop entire option, why is it needed?
> You mean regulator option ?
> This is how other pmbus regulator devices have provided option.

Hmmm... I wonder why this is of any use.

>>
>>> +
>>>   config SENSORS_TPS40422
>>>   	tristate "TI TPS40422"
>>>   	help

(...)

>>
>>> +static const struct of_device_id tda38640_of_match[] = {
>>> +	{ .compatible = "infineon,tda38640"},
>>> +	{ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, tda38640_of_match);
>>
>> Where is it used? You miss the user.
> I'm not sure if I get your question right.
> This chip is used in sbp1 board to power CPU rails.

No, where is the data structure used (except module autoloading)?

Best regards,
Krzysztof

