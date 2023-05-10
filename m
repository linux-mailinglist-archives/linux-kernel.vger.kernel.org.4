Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A56FDE55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbjEJNRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjEJNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:17:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082E576B7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:17:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a34a14a54so1433158466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683724628; x=1686316628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0NNPcaQxaKPxC35q4lb7Q2k/KJXCpc0ipK342+puDU=;
        b=QnDTCjRVA6jNRLhzY0ZS4HptY0D7fNBaEUgzFrPD+YpobP/gzd5apV3HjsDrqWUN/O
         6h8DG8keAQkOVidAH87PIwVTNgHDSx3umnzVhSKwntgsd3k3RuHMhjSOVFCG26bVcnej
         /hDCbk2kWM8yKSn/5XXovixpm9otRI9sOdjXnoG5b7Sg39CC/sV5Q3MSZjuR2g4WWFe6
         XmaBfrYQqDLbOaFLyrXajhgGngg1kB9HLSC57TV45gIk50oESBIcO8HoAuRtgKTzRxaN
         R7qAdLOtnX5IgoKpypv7SKn2usmYsrWgqsvamzvZj5YBclikTuJTkL/hvspTQ1J+OQaN
         7wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683724628; x=1686316628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0NNPcaQxaKPxC35q4lb7Q2k/KJXCpc0ipK342+puDU=;
        b=fFvAv1szUoNWpCgpKxmRAy7krQ9J7fVEf2g0hXA+xbxTZ94oEkqZF2omDwdrUVgV+6
         Uu0iBsDe5dDxFeiVWu0xEtTy5Pd5eW+upZIytgLSTYUV1TzEOH+ZhUVUuFpxRp8EhbmN
         maRtSMzLIK/ay/Pgkf1PW91xqf36wpZWik6cMGht/XN6VfG52sExn+aX/ZWDHcCzVk+V
         lq8gqIRGiLYhBMjzvSVA5uCCXGcE8MWwgw28N+Wygzqzg6wLIzeCfGtrRVWzTOFROVcH
         Eg7SEZ7SN0IlBr2pcuq0oFnQnfxcyZs2TvGLkHvdKX57Lg+kvmSLPts/Fs+Hjn2kctwy
         +jrw==
X-Gm-Message-State: AC+VfDxt9LZV87RrLC2WSvgGcSpG8kzbtBuhYouw7zlNsLnRgm1Gc5cx
        U1OcScx2pJ9gfk/msOcD+jBwtA==
X-Google-Smtp-Source: ACHHUZ6YL9+LN9HNfDK/e/WVnPK1YCtDvn0BZgkGmj5+wk/gJcPNkGoRrZK92hJdd60Iu9y/EMt5Vg==
X-Received: by 2002:a17:906:eec9:b0:94e:46ef:1361 with SMTP id wu9-20020a170906eec900b0094e46ef1361mr14978482ejb.34.1683724628495;
        Wed, 10 May 2023 06:17:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00965fdb90801sm2687310ejz.153.2023.05.10.06.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 06:17:07 -0700 (PDT)
Message-ID: <764ae6a7-cb25-93ac-720a-56c9a831a493@linaro.org>
Date:   Wed, 10 May 2023 15:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: usb: Add binding for Microchip usb5744
 hub controller
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        ilias.apalodimas@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <dd31f987316fb2739644628b5840a6d447b5a587.1683293125.git.michal.simek@amd.com>
 <32aa46df-9ed5-7d2a-868f-a36414f54534@linaro.org>
 <1868d9ae-1376-d91d-a789-9e510bde96a7@amd.com>
 <27232a95-6ef8-1a98-4f5d-7d0ea29c20c4@linaro.org>
 <882f0cb5-7a5f-fe56-fdd9-f6074c1e359a@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <882f0cb5-7a5f-fe56-fdd9-f6074c1e359a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 13:00, Michal Simek wrote:
> 
> 
> On 5/9/23 18:04, Krzysztof Kozlowski wrote:
>> On 09/05/2023 16:19, Michal Simek wrote:
>>>
>>>
>>> On 5/7/23 10:07, Krzysztof Kozlowski wrote:
>>>> On 05/05/2023 15:25, Michal Simek wrote:
>>>>> The Microchip usb5744 is a SS/HS USB 3.0 hub controller with 4 ports.
>>>>> The binding describes USB related aspects of the USB5744 hub, it as
>>>>> well cover the option of connecting the controller as an i2c slave.
>>>>> When i2c interface is connected hub needs to be initialized first.
>>>>> Hub itself has fixed i2c address 0x2D but hardcoding address is not good
>>>>> idea because address can be shifted by i2c address translator in the
>>>>> middle.
>>>>>
>>>>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - fix i2c-bus property
>>>>> - swap usb2.0/3.0 compatible strings
>>>>> - fix indentation in example (4 spaces)
>>>>> - add new i2c node with microchip,usb5744 compatible property
>>>>>
>>>>> It looks like that usb8041 has also an optional i2c interface which is not
>>>>> covered. But it is mentioned at commit 40e58a8a7ca6 ("dt-bindings: usb:
>>>>> Add binding for TI USB8041 hub controller").
>>>>>
>>>>> i2c-bus name property was suggested by Rob at
>>>>> https://lore.kernel.org/all/CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com/
>>>>> and
>>>>> https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/
>>>>>
>>>>> the question is if adding address like this is acceptable.
>>>>> But it must be specified.
>>>>>
>>>>> Driver will follow based on final dt-binding.
>>>>>
>>>>> $ref: usb-device.yaml# should be also added but have no idea how to wire it
>>>>> up to be applied only on usb node not i2c one.
>>>>>
>>>>> ---
>>>>>    .../bindings/usb/microchip,usb5744.yaml       | 110 ++++++++++++++++++
>>>>>    1 file changed, 110 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..7e0a3472ea95
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>>>> @@ -0,0 +1,110 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/usb/microchip,usb5744.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Microchip USB5744 4-port Hub Controller
>>>>> +
>>>>> +description:
>>>>> +  Microchip's USB5744 SmartHubTM IC is a 4 port, SuperSpeed (SS)/Hi-Speed (HS),
>>>>> +  low power, low pin count configurable and fully compliant with the USB 3.1
>>>>> +  Gen 1 specification. The USB5744 also supports Full Speed (FS) and Low Speed
>>>>> +  (LS) USB signaling, offering complete coverage of all defined USB operating
>>>>> +  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.0
>>>>> +  controller, so 5 Gbps SuperSpeed data transfers are not affected by slower
>>>>> +  USB 2.0 traffic.
>>>>> +
>>>>> +maintainers:
>>>>> +  - Piyush Mehta <piyush.mehta@amd.com>
>>>>> +  - Michal Simek <michal.simek@amd.com>
>>>>> +
>>>>> +select:
>>>>> +  properties:
>>>>> +    compatible:
>>>>> +      contains:
>>>>> +        const: microchip,usb5744
>>>>> +  required:
>>>>> +    - compatible
>>>>
>>>> I don't understand why do you need this select. It basically disables
>>>> schema matching for other ones.
>>>
>>> I didn't find a way how to have usbXXX,XXXX compatible strings and
>>> microchip,usb5744 compatible in the same file. I am definitely lacking knowledge
>>> how to write it properly that's why any advise is welcome.
>>
>> Hm, if you just have both of them like you have now, what happens?
> 
> 
> make 
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/microchip,usb5744.yaml 
> dt_binding_check
>    DTEX    Documentation/devicetree/bindings/usb/microchip,usb5744.example.dts
>    LINT    Documentation/devicetree/bindings
>    CHKDT   Documentation/devicetree/bindings/processed-schema.json
>    SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>    DTC_CHK Documentation/devicetree/bindings/usb/microchip,usb5744.example.dtb
> /home/monstr/data/disk/linux/Documentation/devicetree/bindings/usb/microchip,usb5744.example.dtb: 
> hub@1: 'i2c-bus', 'peer-hub', 'reset-gpios' do not match any of the regexes: 
> 'pinctrl-[0-9]+'
> 	From schema: 
> /home/monstr/data/disk/linux/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> /home/monstr/data/disk/linux/Documentation/devicetree/bindings/usb/microchip,usb5744.example.dtb: 
> hub@2: 'i2c-bus', 'peer-hub', 'reset-gpios' do not match any of the regexes: 
> 'pinctrl-[0-9]+'
> 	From schema: 
> /home/monstr/data/disk/linux/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> 
> And this is even without usb-device.yaml wired.

Yeah, you cannot define properties in allOf:if:then. Your select just
makes the schema not selected thus it is a NOOP and error is hidden.

I gave you examples how these should be expressed and the examples *do
not* define properties in allOf:if:then, right?

Best regards,
Krzysztof

