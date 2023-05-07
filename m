Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C56F97A8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjEGIXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 04:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEGIXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 04:23:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE0111D8D
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 01:23:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-959a3e2dd27so600075966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 01:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683447815; x=1686039815;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TBivjxMkZZaR8M0CcBynnDvBHZKSjxBTUTWFsCdRlM=;
        b=XyjgadbKtIwHwOw/A6ZwDbKeHZysx6XAHRcUg9acQakMxlo2PRg9GtU4cAEcLe++FV
         awVzmADwVrtifT6/5bM3qRlnBN4FK/xquHxRqAbP/xsmAFLhB7l2CMeApTr9K7u7XWTJ
         gqR6Rkl9YnVR776zQvbIIuB/EmhjUjNJt8GZY1crHAUfCwVPjSHebuqYvv27PnHUEvyH
         OviCv1XyH/USJBNHzra6mf3Ou8CLBqbo2FSyweMLSMixYeCow/7cKgVnxA93CxIYaIX6
         j6uj0huiZnXC1Rmh9ynFJa4RoyPTatAx7MK2e9VAsnRvLUC03+wOc/dyiOUZ31pqt2YO
         v5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683447815; x=1686039815;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TBivjxMkZZaR8M0CcBynnDvBHZKSjxBTUTWFsCdRlM=;
        b=cmC99h8NkSGsJTTQqIsKT44YCz73RmBj/D2Nb2tt7dLEzzGwcadUUrpl2fgP7gyBvV
         MQ1d/JIHL0Eh0cs77foE9KX++RY9a1oygAg5RlN/smcvSeTpGmzl8j4i5ERcuKe3nFvq
         AeKZmlOC12FL0dSlPMX8i7EvGY9mfGVspzFpeNjQpOoxuc7eundHHG5vJhf6XiYJQW3g
         Bdl66Zk+Qw7OgNDKJza0eJCb1grzA9xu0x8VB335nv8IhIeoyxDUPi4woCPCFhGBa7jj
         QonFjUaYcdUB5VTSH1fGrrDKAIyPmWFBWydNl3ArjrLW6iyGdtnpgDet1pkZ+LvbPKu1
         r9mA==
X-Gm-Message-State: AC+VfDwNd18CoV8AwNQjZ9BBiIDVTqFwzQ2y5cZrqh/6GZhDXcE1951g
        7yHvbzZIldCZgXtboO7ohQSW/A==
X-Google-Smtp-Source: ACHHUZ4I6EGyGfb57ezEXvXgBnIay/IdBuS6SgbV6cHYFXgYE6lQLJbxZ0oQXVviWu/hohCn0IT0/Q==
X-Received: by 2002:a17:907:7f25:b0:961:272d:bdcc with SMTP id qf37-20020a1709077f2500b00961272dbdccmr6798156ejc.61.1683447815605;
        Sun, 07 May 2023 01:23:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:183b:950f:b4d5:135a? ([2a02:810d:15c0:828:183b:950f:b4d5:135a])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b0094f49f58019sm3360219ejc.27.2023.05.07.01.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 01:23:35 -0700 (PDT)
Message-ID: <969bfca0-9fff-0b22-6db1-113a7e998bc8@linaro.org>
Date:   Sun, 7 May 2023 10:23:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/4] ARM: dts: aspeed: mtmitchell: Add I2C Fan
Content-Language: en-US
To:     Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230425065715.21871-1-chanh@os.amperecomputing.com>
 <20230425065715.21871-3-chanh@os.amperecomputing.com>
 <7ee3eec8-b5b4-2591-adcd-1831bf7de02b@linaro.org>
 <5d1cc7d5-2d73-c1a2-f95d-5810757640d2@amperemail.onmicrosoft.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5d1cc7d5-2d73-c1a2-f95d-5810757640d2@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2023 10:20, Chanh Nguyen wrote:
> 
> On 25/04/2023 20:15, Krzysztof Kozlowski wrote:
>> On 25/04/2023 08:57, Chanh Nguyen wrote:
>>> Add the MAX31790 node as a Fan I2C controller. It controls the
>>> TACH and PWM for Fan Mt.Mitchell system.
>>>
>>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>>> ---
>>>   arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> index e79f56208b89..6455cf80da0e 100644
>>> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> @@ -477,6 +477,18 @@
>>>   			line-name = "bmc-ocp0-en-n";
>>>   		};
>>>   	};
>>> +
>>> +	max31790@20 {
>>
>> Node names should be generic.
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Thank Krzysztof,
> 
> I think these node names should be "fan-i2c-0" and "fan-i2c-1". Do you 
> have any other idea ?

i2c-0 is not generic. This should be either fan or fan-controller,
depending what this is.
> 
>>
>>> +		compatible = "maxim,max31790";
>>
>> Unfortunately the compatible is undocumented.
>>
>> Please run scripts/checkpatch.pl and fix reported warnings.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Yes Krzysztof,
> 
> This compatible has not yes documented.
> 
> Should I push a document for max31790 to 
> ./Documentation/devicetree/bindings/ or ask to maintainer (Guenter Roeck 
> <linux@roeck-us.net> or Jean Delvare <jdelvare@suse.com>) ?

Check on lore.kernel.org if there is ongoing work. If there is no, then
please submit new the bindings (in DT schema). Maintainers are not for
writing your code, so it's you or some other developer who should do it.

Best regards,
Krzysztof

