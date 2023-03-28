Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5226CBD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjC1LVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC1LVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:21:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846A23C32
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:21:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x3so48063886edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680002498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0zoscBlvTHjjRLwzqsmHVflR54yqyBJXWRu4DbHXfo=;
        b=XtXJ51p1c5JDwQyfHP2EKx1Qz42375Mks7R9KstgVvtV2PRPZcANgVeDO7XXqdA9h5
         PSgbZezCFSem+O67TiS5EfewoERX2rxMVCyE8Eq69KHdw+pOdP+sqypLdjMjuBu8sCb2
         ss+mnNHN4+Awx20ymc19Vo+AJVQ8rzEM4Pa/bhgJafT4QLhHKLCdYSGdqKnj+4D2NwH/
         AxJvAl6aCarlLqtCkE6Xzfa2agU3gwz5hIJwfY0WFLcnK/8sAFZEdWuvfDLXF9W+NQhC
         oaizRHasHtIHiH6xv319gD3rkrY46DKW2CjVwharOR3iJBISKkuzhl/Kxy0XVuseapiA
         e8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680002498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0zoscBlvTHjjRLwzqsmHVflR54yqyBJXWRu4DbHXfo=;
        b=ZLcwNRGgcasiOZ1CPM8A5/oQYDs6F4+Ha/eKeRfhkcLjIAEdFF5p0xG4ov52Ecc1h8
         RTMe39frUs8FGxMlmf7IhaAd+vrUZm/M5/VnwT5pTPu880Yv+sQG/I4DuRZC5PmxCpK3
         GSFMjFIX0YnNTLP81YwBwQ7zdRJQUQB8lyyDiSVpyuEulZMpBdLbpHs1CNuUoccE0YmV
         z7b9MLBkKlEeFL6b8WF01C0wJXlTiu2IvuI/bGapBHhGAm+K/LmmtC0nCLv4mG8Qjgt6
         drLjBJGsIPROGidbGYdJ7aZ8m1fmnCTMGG7avNIv9vAIx9cETgayvtfJuFK0MIe+FqXw
         8RDw==
X-Gm-Message-State: AAQBX9eNzBdRbnJUf8BUsmqxII/4JC2eEP2ccKa+4+jPlKl4PgiU5Pit
        yYlBaZXvvjY4eVQHdsmAQWejrA==
X-Google-Smtp-Source: AKy350bhS8sE1Git1AtlRiQDnYdFsSNHAsm/FNF0ywmE0CYXHD1GHyeP1JMP0ltV2FR9TFbU782THg==
X-Received: by 2002:a17:906:f6cd:b0:92f:b8d0:746c with SMTP id jo13-20020a170906f6cd00b0092fb8d0746cmr15259029ejb.20.1680002497988;
        Tue, 28 Mar 2023 04:21:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id k24-20020a50ce58000000b004fc9e462743sm15608623edj.91.2023.03.28.04.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 04:21:37 -0700 (PDT)
Message-ID: <f69d7b3a-6b30-5f30-9e72-7197a3a62a2c@linaro.org>
Date:   Tue, 28 Mar 2023 13:21:36 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <75f0a18d-aed9-8610-2925-4e604b4b0241@baylibre.com>
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

On 28/03/2023 12:45, Julien Panis wrote:
> 
> 
> On 3/28/23 08:51, Krzysztof Kozlowski wrote:
>> On 27/03/2023 17:40, Julien Panis wrote:
>>> TPS6594 is a Power Management IC which provides regulators and others
>>> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>> PFSM (Pre-configurable Finite State Machine) managing the state of the
>>> device.
>>> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>>
>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>> ---
>>>   .../devicetree/bindings/mfd/ti,tps6594.yaml   | 231 ++++++++++++++++++
>>>   1 file changed, 231 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>> new file mode 100644
>>> index 000000000000..4498e6361b34
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>> @@ -0,0 +1,231 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/ti,tps6594.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TI TPS6594 Power Management Integrated Circuit
>>> +
>>> +maintainers:
>>> +  - Julien Panis <jpanis@baylibre.com>
>>> +
>>> +description:
>>> +  TPS6594 is a Power Management IC which provides regulators and others
>>> +  features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>> +  PFSM (Pre-configurable Finite State Machine) managing the state of the device.
>>> +  TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>> LP8764X? Compatible says LP8764.
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,lp8764
>> It's confusing. If x was wildcard, didn't you remove part of model name?
> 
> OK, I will remove 'X' from model name in v5.

There is no x in compatible. What is (are) the model name(s)?

> 
>>
>>
>>> +      - ti,tps6593
>>> +      - ti,tps6594

(...)

>>> +
>>> +  rtc:
>>> +    type: object
>>> +    description: RTC provided by this controller.
>>> +    $ref: /schemas/rtc/rtc.yaml#
>> I doubt that you can have here any RTC and any watchdog (below). This
>> should be specific binding instead. Or list of compatibles if you have 3
>> or more possible bindings.
>>
>> Additionally, judging by your DTS you do not have any resources in rtc
>> and watchdog, so these should not be nodes by themself in such case.
> 
> It seems that I can't figure out what you and Rob mean by saying that
> "binding must be complete" and that "RTC and watchdog may or may not
> need binding changes".
> What does "specific binding" mean ?

Specific means not loose, not generic, precise with some accurate
properties.

> Should we add some specific property
> for RTC/WDG provided by the PMIC ?

You know ask me to know what is in your device. I don't know. You should
know.

> Should we write another yaml for both
> of them ? 

Depends. Pretty often yes, but think what do you want to put there?

> Why shouldn't they use the generic rtc/watchdog yaml ? 

There are no properties in these nodes, so you do not need nodes. Or if
you have properties then you need specific binding, not generic one.

> I don't
> understand why they would need some "binding changes". Any example
> I could refer to ? (I might have not looked at the relevant ones for my case
> before sending this v4)

git grep $ref | grep rtc.yaml


Best regards,
Krzysztof

