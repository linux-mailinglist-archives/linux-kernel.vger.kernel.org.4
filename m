Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402C06CC25D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjC1Ooe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjC1Oob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:44:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCFBBDE9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:44:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so50792573edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680014666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1RXGFn+vcWvifONYTCuI6mtyH3vlLPcp2qfAwB5mMg=;
        b=vsJbZiNlnEUa4STeqicxMpHCCmqUTSxPEvkllbFnHOCt5OZZSSrexWZ+hwPMwfF96P
         P2Xom75jo1ltINp+kb89Eo1bVDq8hfk5bvHX38sPDPAoAdGJeTsrO/wra+j/ru7lCZtG
         ynXt7mSIb9irD+/OS2lkgPAO9Gk7XcAhQj6kzgIAkzjT2GaKt/9Rw/Lo4EeWM77Ifb4s
         8hIb9GTnfkJ6/rpRG/+U8M1ucr3UsrC8nhc/mm7F2TMZW2qacJE6V6i8Ia5ROurrvcj6
         F4t/yNxSMFrXdKMEkAK3f+xA/DR35mtYUslJkatfa0JdpKVGqCl1Q+ekxAiPUA+gamVw
         LhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680014666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1RXGFn+vcWvifONYTCuI6mtyH3vlLPcp2qfAwB5mMg=;
        b=oIiYyBQDJsoIyXgRCHYuWTxwQncqb5dTWT43beaZNxxxTkoDmg00U8n0W0aCSdY3bQ
         i8ZxcEYlawoB1LhQUYNOAV0DiOjzbYMGYCzK9cFgxrgAhiMuklv8mmPcDe9miUhyy9B7
         hDNVqJDGqSmAhKCseHVcwLZ5+ireLIE2IYPpH/sOFWAu/Zb4Lkbn8GxP5D37abp96Nb6
         SUWIs7bMBduYIk75+bhZSjvs4FKSTJLENQU/oPUNa9s8TjrzYSIZ0dN8uoomdjE4CbfG
         E91vtYyFMTjoEXXcgSvM6nASYZQGcYcHMSz8npKrs3VYHOj9OhWWuDW72lVTKItWqQ1X
         Xu/g==
X-Gm-Message-State: AAQBX9dj8x6YO5nLAJkUKsdPjExpJ/NbDdKDmpKTDfPMDGpCwevUzB1m
        XjWZ/uHyVOZM0ABAObSU3jXRPQ==
X-Google-Smtp-Source: AKy350YzR+xGfHrkbNMHzkSLkADtXYt1PeHCFRiRdVPuS6jMW9QCjmlAubHsid6h5lOXd9SbB3Rbew==
X-Received: by 2002:a17:907:6e17:b0:92f:c6b5:de08 with SMTP id sd23-20020a1709076e1700b0092fc6b5de08mr17365113ejc.76.1680014666011;
        Tue, 28 Mar 2023 07:44:26 -0700 (PDT)
Received: from [10.105.135.205] ([88.128.92.162])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906b28700b00931c887372dsm15199037ejz.107.2023.03.28.07.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:44:25 -0700 (PDT)
Message-ID: <fa74223a-b0ae-9f5d-406e-b41c95332dfa@linaro.org>
Date:   Tue, 28 Mar 2023 16:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com
Cc:     eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
References: <20230327154101.211732-1-jpanis@baylibre.com>
 <20230327154101.211732-2-jpanis@baylibre.com>
 <a0c18c3a-4f9e-f491-582f-8d3ca56ec26f@linaro.org>
 <75f0a18d-aed9-8610-2925-4e604b4b0241@baylibre.com>
 <f69d7b3a-6b30-5f30-9e72-7197a3a62a2c@linaro.org>
 <fc519231-dd00-8ce3-ecdb-a1e1364cd0c4@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fc519231-dd00-8ce3-ecdb-a1e1364cd0c4@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 16:20, Julien Panis wrote:
> 
> 
> On 3/28/23 13:21, Krzysztof Kozlowski wrote:
>> On 28/03/2023 12:45, Julien Panis wrote:
>>>
>>> On 3/28/23 08:51, Krzysztof Kozlowski wrote:
>>>> On 27/03/2023 17:40, Julien Panis wrote:
>>>>> TPS6594 is a Power Management IC which provides regulators and others
>>>>> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>>>> PFSM (Pre-configurable Finite State Machine) managing the state of the
>>>>> device.
>>>>> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>>>>
>>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>>>> ---
>>>>>    .../devicetree/bindings/mfd/ti,tps6594.yaml   | 231 ++++++++++++++++++
>>>>>    1 file changed, 231 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..4498e6361b34
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>>> @@ -0,0 +1,231 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/mfd/ti,tps6594.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: TI TPS6594 Power Management Integrated Circuit
>>>>> +
>>>>> +maintainers:
>>>>> +  - Julien Panis <jpanis@baylibre.com>
>>>>> +
>>>>> +description:
>>>>> +  TPS6594 is a Power Management IC which provides regulators and others
>>>>> +  features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>>>> +  PFSM (Pre-configurable Finite State Machine) managing the state of the device.
>>>>> +  TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>>> LP8764X? Compatible says LP8764.
>>>>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - ti,lp8764
>>>> It's confusing. If x was wildcard, didn't you remove part of model name?
>>> OK, I will remove 'X' from model name in v5.
>> There is no x in compatible. What is (are) the model name(s)?
> 
> Basically, the model names are:
> - lp8764-q1 ('x' came from an error in internal documentation)

Ah, ok, that explains.

> - tps6593-q1
> - tps6594-q1
> 
> But...for these 3 pmics, there are 19 PN provided
> by TI. For instance: tps659413f, tps659411f, ...
> Each PN gives information about non-volatile memory
> settings and firmware. So, there can be several PN
> for a given model name.
> 
> Which solution is recommended in such situation ?
> 
> IMO, using the 3 'xxxxxx-q1' names for compatible
> strings makes sense (that's what already exists in
> linux for others TI pmics).
> But if you think that full PN names should be specified
> to differentiate internal FW/NVM configurations, I will do
> that and we will get 19 compatible strings.

I think it is fine as long as their programming model is exactly the same.

> 
>>
>>>>
>>>>> +      - ti,tps6593
>>>>> +      - ti,tps6594
>> (...)
>>
>>>>> +
>>>>> +  rtc:
>>>>> +    type: object
>>>>> +    description: RTC provided by this controller.
>>>>> +    $ref: /schemas/rtc/rtc.yaml#
>>>> I doubt that you can have here any RTC and any watchdog (below). This
>>>> should be specific binding instead. Or list of compatibles if you have 3
>>>> or more possible bindings.
>>>>
>>>> Additionally, judging by your DTS you do not have any resources in rtc
>>>> and watchdog, so these should not be nodes by themself in such case.
>>> It seems that I can't figure out what you and Rob mean by saying that
>>> "binding must be complete" and that "RTC and watchdog may or may not
>>> need binding changes".
>>> What does "specific binding" mean ?
>> Specific means not loose, not generic, precise with some accurate
>> properties.
>>
>>> Should we add some specific property
>>> for RTC/WDG provided by the PMIC ?
>> You know ask me to know what is in your device. I don't know. You should
>> know.
>>
>>> Should we write another yaml for both
>>> of them ?
>> Depends. Pretty often yes, but think what do you want to put there?
> 
> There's nothing to put there actually.
> 
>>
>>> Why shouldn't they use the generic rtc/watchdog yaml ?
>> There are no properties in these nodes, so you do not need nodes. Or if
>> you have properties then you need specific binding, not generic one.
> 
> We do not need nodes indeed, since we do not have properties to put in them.

OK. Then please remove the watchdog and rtc nodes. We asked about them
to make binding complete, because often they need additional data (e.g.
pins or interrupts). In this case the expectation will be to add
rtc.yaml and watchdog.yaml refs to main device node (top level) if you
ever need their properties (like start-year).

Best regards,
Krzysztof

