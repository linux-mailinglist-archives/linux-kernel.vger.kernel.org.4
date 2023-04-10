Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32B6DC852
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjDJPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDJPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:21:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED5846B9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:21:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kt17so1052156ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681140070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZRw2wqvE/1MC1yZ0G5iCqLIwh8QF13oSGU/qO0zu+o=;
        b=NYo/3/coo0c/yMIO7bncY2O4PQowzUY4HreJOHBoBdj/x/RT9LPYs4ujUtFPQI+WqW
         Bxc9fR08xu5vm9VS6WFaCprSpdIAtUR6LsjR9LnFAETjS+VrCEtoYq3PzHzsqy/M4Uls
         d6+XvtbngL3LscT0riA721aHMiTkyQjxPYRDQfqlV8BTrWJH6AzeZ2LeRg9rsVNtoZmJ
         hVp9RTmhyPI8hSl0Qp0w8iv9r2bbaeu1jgXTcqpn2kb/x9clBGSQLRfPu7BZxokZZGwq
         Z9zuTz6iZZvKScRfWUaqJOebbbRn/wyv2jQ7p1YharDKr3joVIx9E9uAp1SRaR0ByNXp
         INxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZRw2wqvE/1MC1yZ0G5iCqLIwh8QF13oSGU/qO0zu+o=;
        b=nPts5Pc+5lblf7eul3zybyuWJbbz/2HI1Eu2hocezhMMHJn/WZyoOD+QyyzyW89hur
         G6J3vyKado9OMyFUwwZTj/HJqTHff1qDb4AbYrANS3y12YC6ywiS6D/GNy2l0x0IB405
         MwVY1KEFdx4zKQ6tbGfJtXXNB7jsdVkYddJtkJI4j6ST7AS6a/jR5miQbjxzJ7JLC8At
         RQUzWPD/EPptyhlRvvqHpBFun8bPPp7Pwd5S9s6FyRXfcpFeRnbyK0A2l1ZM0lsIZGue
         ctwAwh17GiV9wDU42NxmusEYHedJt4xEFvrQ8DcgzWFl6QwV/sc6wQkmqwURRo4Bk4RC
         wX5Q==
X-Gm-Message-State: AAQBX9f6tLVvK1OLPtAzliIquCvKqVNi+lkAAdsLQt0hcnkg/8nrK0Ig
        UeDRd7d+fC48Q3fQvPMYXMn9ig==
X-Google-Smtp-Source: AKy350brrjadn1puHhcMr9fNNUWP0/tw4thCV3WBC6mO5mKGKNcG/rCgLhMkPEKFkStbM15G1M4YBw==
X-Received: by 2002:a17:907:c60f:b0:94a:6fe4:c309 with SMTP id ud15-20020a170907c60f00b0094a6fe4c309mr3938620ejc.16.1681140069909;
        Mon, 10 Apr 2023 08:21:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eacd:ffa4:1df7:3870? ([2a02:810d:15c0:828:eacd:ffa4:1df7:3870])
        by smtp.gmail.com with ESMTPSA id h22-20020a1709063b5600b0094cafa4fb8bsm344729ejf.124.2023.04.10.08.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:21:09 -0700 (PDT)
Message-ID: <44a7ee80-e770-4918-9caa-f606713fe584@linaro.org>
Date:   Mon, 10 Apr 2023 17:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
Content-Language: en-US
To:     Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
 <20230329083235.24123-2-Delphine_CC_Chiu@Wiwynn.com>
 <b66f708c-5369-c1c9-5506-c609a245bf4c@linaro.org>
 <PS2PR04MB3592E90B033CA23F47CD02F2B7959@PS2PR04MB3592.apcprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PS2PR04MB3592E90B033CA23F47CD02F2B7959@PS2PR04MB3592.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 09:11, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> Thank you for reviewing.
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, March 29, 2023 4:37 PM
>> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
>> patrick@stwcx.xyz; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
>> Jeffery <andrew@aj.id.au>
>> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
>>
>>   Security Reminder: Please be aware that this email is sent by an external
>> sender.
>>
>> On 29/03/2023 10:32, Delphine CC Chiu wrote:
>>> From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
>>>
>>> Add GPIO names for SOC lines.
>>>
>>> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
>>> ---
>>>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 49
>> +++++++++++++++++++
>>>  1 file changed, 49 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> index 8c05bd56ce1e..59819115c39d 100644
>>> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> @@ -238,4 +238,53 @@
>>>  &gpio0 {
>>>       pinctrl-names = "default";
>>>       pinctrl-0 = <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
>>> +     status = "okay";
>>
>> Was it disabled before?
>>
> Yes, 

Really? Can you provide any proof for this?

> we have to enable gpio status for meeting aspeed-g6 device tree setting, and set net names for pulling gpio pin from application layer.

What is "enable gpio status"? What does it mean to "meet aspeeg-g6
devicetree setting"?
What names have anything to do with my question?

Sorry, I cannot parse it at all.

>>> +     gpio-line-names =
>>> +     /*A0-A7*/ "","","","","","","","",
>>> +     /*B0-B7*/ "power-bmc-nic","presence-ocp-debug",
>>> +               "power-bmc-slot1","power-bmc-slot2",
>>> +               "power-bmc-slot3","power-bmc-slot4","","",
>>> +     /*C0-C7*/ "presence-ocp-nic","","","reset-cause-nic-primary",
>>> +               "reset-cause-nic-secondary","","","",
>>> +     /*D0-D7*/ "","","","","","","","",
>>> +     /*E0-E7*/ "","","","","","","","",
>>> +     /*F0-F7*/ "slot1-bmc-reset-button","slot2-bmc-reset-button",
>>> +               "slot3-bmc-reset-button","slot4-bmc-reset-button",
>>> +               "","","","presence-emmc",
>>> +     /*G0-G7*/ "","","","","","","","",
>>> +     /*H0-H7*/ "","","","",
>>> +               "presence-mb-slot1","presence-mb-slot2",
>>> +               "presence-mb-slot3","presence-mb-slot4",
>>> +     /*I0-I7*/ "","","","","","","bb-bmc-button","",
>>> +     /*J0-J7*/ "","","","","","","","",
>>> +     /*K0-K7*/ "","","","","","","","",
>>> +     /*L0-L7*/ "","","","","","","","",
>>> +     /*M0-M7*/
>> "","power-nic-bmc-enable","","usb-bmc-enable","","reset-cause-usb-hub","","",
>>> +     /*N0-N7*/ "","","","","bmc-ready","","","",
>>> +     /*O0-O7*/
>> "","","","","","","fan0-bmc-cpld-enable","fan1-bmc-cpld-enable",
>>> +     /*P0-P7*/ "fan2-bmc-cpld-enable","fan3-bmc-cpld-enable",
>>> +               "reset-cause-pcie-slot1","reset-cause-pcie-slot2",
>>> +               "reset-cause-pcie-slot3","reset-cause-pcie-slot4","","",
>>> +     /*Q0-Q7*/ "","","","","","","","",
>>> +     /*R0-R7*/ "","","","","","","","",
>>> +     /*S0-S7*/ "","","power-p5v-usb","presence-bmc-tpm","","","","",
>>> +     /*T0-T7*/ "","","","","","","","",
>>> +     /*U0-U7*/ "","","","","","","","GND",
>>> +     /*V0-V7*/ "bmc-slot1-ac-button","bmc-slot2-ac-button",
>>> +               "bmc-slot3-ac-button","bmc-slot4-ac-button",
>>> +               "","","","",
>>> +     /*W0-W7*/ "","","","","","","","",
>>> +     /*X0-X7*/ "","","","","","","","",
>>> +     /*Y0-Y7*/ "","","","reset-cause-emmc","","","","",
>>> +     /*Z0-Z7*/ "","","","","","","",""; };
>>> +
>>> +&gpio1 {
>>> +     status = "okay";
>>
>> Same question...
> Yes, the answer is same as above.

So the same incorrect?


Best regards,
Krzysztof

