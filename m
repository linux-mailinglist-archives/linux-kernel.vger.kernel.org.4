Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D269E2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjBUPBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjBUPBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:01:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8281E5DE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:01:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b12so18343676edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ku9Sfu7j4bHHppnPG09Dp4qk22uNWpKvB6ENZGbQQ2k=;
        b=tMU8PVt3/P1RHV9UCnXT7GIfsXrWlzhijpIUST+1I3mV0cvsQu0dbXW7b4mVE2E9bs
         0kZy045REwx0B2FoimgDodPBILBitDIeDZ7aknvRb6QWqm6/scPz3P4foaAH4uopndbQ
         S5YIjoeQndkO4coNULcFv6kezaatRhvM5L0hLDu8g76trmN4WA6cHjSfbxSqj5ba/OTa
         PDUyps+ZU0b1WpxccFqcjLRv+rGFLrzKPj1OxgvEgVMHJw1/CkKOaYMnOKOvMUOSJXTL
         zXh36wWOAMnkpz0PJMQQf/8ComZvfO8dPbPRDAYr2OiNAaTs0JO5hyCCAZl1Eyt3JqnU
         poSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku9Sfu7j4bHHppnPG09Dp4qk22uNWpKvB6ENZGbQQ2k=;
        b=Pu17hJgOnbpqFaluJF9HzeFhXLSQTPljJpfXSoGuZyukbX3DWNSWAkIB5RawMBgZez
         IDxP7LSfV9KSj7EpQ8UsIy5ruMDMt4Ca2T3AxIjmkjo3Khjf7GB7jyrrhxZm5ZEzyDvy
         x7wrg4h9WhGEqqKt0CYo6AULcC/6g3MuUoW0+usVcXyr94qEYieCHHowy2acGAz0Mgzw
         e73XwruPb+BkeZIG1Tvjmn+0CLSqbja7qhMMbU2ursNXKtCLKHS9s+HvxctsHIXYjwNR
         /m3uw8y/jNxkxIINMJ20yzO+CQ9/YSiNwFUs38KZkCzJEEmiSt56v0bvFfOmIMZ1dzE6
         VUmg==
X-Gm-Message-State: AO0yUKWeEvE4bn2hagDSZE0piC4LFRqIwQEw84ZgzgD02DBboWRvTiTU
        KkUHBlJblPQMnU528/U/zWMg1Q==
X-Google-Smtp-Source: AK7set++jZ3zzogaqLogYo6ovzP788P8oYq49dFTYgrbR0MORXW2k00MJE9+n84aonTBA83tFeui5w==
X-Received: by 2002:a17:906:374d:b0:886:ec6e:4c1 with SMTP id e13-20020a170906374d00b00886ec6e04c1mr12887067ejc.59.1676991699545;
        Tue, 21 Feb 2023 07:01:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v6-20020a17090651c600b008b175c46867sm6725247ejk.116.2023.02.21.07.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 07:01:39 -0800 (PST)
Message-ID: <ce5f8e9c-0e05-3391-1393-25ea8086f10c@linaro.org>
Date:   Tue, 21 Feb 2023 16:01:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/4] dt-bindings: mfd: Add DT bindings for TI TPS6594
 PMIC
To:     Julien Panis <jpanis@baylibre.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net
Cc:     hdegoede@redhat.com, eric.auger@redhat.com, jgg@ziepe.ca,
        razor@blackwall.org, suma.hegde@amd.com,
        stephen@networkplumber.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eblanc@baylibre.com,
        jneanne@baylibre.com
References: <20230216114410.183489-1-jpanis@baylibre.com>
 <20230216114410.183489-2-jpanis@baylibre.com>
 <c50503f0-dce1-a3b0-2973-8a22b5ef8bc2@linaro.org>
 <4e64838c-b727-923b-b6d5-413a0681977c@baylibre.com>
 <8de5a3bb-a0b1-8d69-cf61-0c33f42c56f6@linaro.org>
 <85183c04-40e3-fd97-c4ca-06795fe99e40@baylibre.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <85183c04-40e3-fd97-c4ca-06795fe99e40@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 15:49, Julien Panis wrote:
> 
> 
> On 2/21/23 12:17, Krzysztof Kozlowski wrote:
>> On 17/02/2023 13:10, Julien Panis wrote:
>>> On 2/17/23 10:06, Krzysztof Kozlowski wrote:
>>>> On 16/02/2023 12:44, Julien Panis wrote:
>>>>> TPS6594 is a Power Management IC which provides regulators and others
>>>> Subject: drop second/last, redundant "DT bindings for". The
>>>> "dt-bindings" prefix is already stating that these are bindings.
>>>>
>>>>
>>>>> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>>>> PFSM (Pre-configurable Finite State Machine) managing the state of the
>>>>> device.
>>>>> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>>>>
>>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>>>> ---
>>>>>    .../devicetree/bindings/mfd/ti,tps6594.yaml   | 164 ++++++++++++++++++
>>>>>    1 file changed, 164 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..37968d6c0420
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
>>>>> @@ -0,0 +1,164 @@
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
>>>>> +description: |
>>>>> +  TPS6594 is a Power Management IC which provides regulators and others
>>>>> +  features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>>>> +  PFSM (Pre-configurable Finite State Machine) managing the state of the device.
>>>>> +  TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - ti,tps6594
>>>>> +      - ti,tps6593
>>>>> +      - ti,lp8764x
>>>> Any particular choice of ordering (different than alphabetical)?
>>> Thank you for the review.
>>>
>>> I chose this ordering because it emphasizes the fact that tps6593 and
>>> lp8764x
>>> are derivatives of tps6594 : tps6593 is nearly the same (a minor feature
>>> is not
>>> supported), and lp8764x has less resources (less bucks/LDO, and no RTC).
>>>
>>> Besides, a multi-PMIC synchronization scheme is implemented in the PMIC
>>> device
>>> to synchronize the power state changes with other PMIC devices. This is done
>>> through a SPMI bus : the master PMIC is the controller device on the
>>> SPMI bus,
>>> and the slave PMICs are the target devices on the SPMI bus. For the 5 boards
>>> we work on (for which device trees will be sent in another patch series):
>>> - tps6594 is used on 3 boards and is always master (multi-PMIC config)
>>> - tps6593 is used on 1 board and is master (single-PMIC config)
>>> - lp8764x is used on 2 boards and is always slave (multi-PMIC config)
>>> There might not be situations in which lp8764x would be master and tps6594
>>> or tps6593 would be slave.
>>>
>>> That's why I preferred this ordering.
>>>
>>> Do you think that alphabetical order would be better ?
>> It's simpler (requires no knowledge about chips) and reduces the future
>> conflicts. It's fine to keep it also ordered like you said, although I
>> wonder how other people adding new compatibles here will figure it out...
> 
> I will reorder it alphabetically in v2.
> 
>>
>>>>> +
>>>>> +  reg:
>>>>> +    description: I2C slave address or SPI chip select number.
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  ti,use-crc:
>>>>> +    type: boolean
>>>>> +    description: If true, use CRC for I2C and SPI interface protocols.
>>>> Hm, why different boards would like to enable or disable it? Why this
>>>> suits DT?
>>> You're right. Reading your comment, it appears to me that CRC feature is
>>> not fully
>>> related to HW description and should not be set in DT.
>>>
>>> CRC is not 'fully' related to HW, but...
>>> For CRC feature as well, PMICs are synchronized (for boards with
>>> multi-PMIC config).
>>> To use CRC mode, this feature must be requested explicitly on the master
>>> PMIC
>>> through I2C or SPI driver, then it is enabled for the slave PMICs
>>> through SPMI bus: that
>>> sync is performed 'automatically', without intervention from the I2C or
>>> SPI driver to
>>> enable CRC on slave PMICs.
>>> As a consequence, CRC feature is enabled for all PMICs at I2C/SPI driver
>>> probe,
>>> or it is let disabled for all PMICs. But it can't be enabled for one
>>> PMIC and disabled
>>> for another one.
>>>
>>> This will probably rediscussed for I2C/SPI drivers, but do you think
>>> that a 'use_crc'
>>> driver parameter would be an acceptable solution ? If so, the master
>>> PMIC would have
>>> to be identified, so that the driver can explicitly enable CRC mode for
>>> this one if
>>> 'use_crc' is true. With this solution, some 'ti,is-master;' bool
>>> property would be necessary.
>> It looks the property should be only in the drivers, not in the DT.
> 
> I will remove 'ti,use-crc;' property from the DT. This will be only in
> the driver.
> Do you also consider that a property such as 'ti,is-secondary-pmic;'
> would not be acceptable either ? From driver point of view, this
> primary/secondary role on SPMI bus is a 'built-in' property of the
> PMIC (CRC must be enabled only via primary PMIC but using the
> primary PMIC does not imply that CRC is necessarily used).

Depends, I am not sure. Are the PMICs in some kind of hierarchical
topology? Like one is parent of another? If not (so both are
parallel/equal children of SPMI bus), then some property to indicate
which one is the main PMIC makes sense.


(...)

>>> Using a PMIC without using the provided regulators does not seem very
>>> interesting
>>> indeed.
>>> But strictly speaking, these regulators are not required. One could use
>>> some others
>>> resources provided by the PMIC (the Error Signal Monitor device for
>>> instance).
>> Then the first method.
> 
> OK. Regarding buck34, it might be unnecessary and could finally be
> removed in v2. If we keep it, my understanding of your suggestion is:
> allOf:
>    - if:
>         required:
>          - buck12
>      then:
>        properties:
>          buck123: false
>          buck1234: false
>    - if:
>        required:
>          - buck123
>      then:
>        properties:
>          buck34: false
>    - if:
>        required:
>          - buck1234
>       then:
>          properties:
>            buck34: false

Yes, something like this.

Best regards,
Krzysztof

