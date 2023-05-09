Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615706FCAB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjEIQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjEIQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:04:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC89A3598
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:04:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so60303337a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683648242; x=1686240242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0W2AbGXoin+5hxz/sFqIGD40a3J1EXdYBNV+hW/GpDI=;
        b=O+4+Ah3ABLUbCNXJT1RMTBCBbF5rL3gK5S3T1/5rN4g0XuQ3kBpcdFJDQwavIXVfUT
         MwK9q3k8Wb/+WBOGcEoJVZJv3EC3aL0D/dyWbxvD3CSAMcR9cE4aVU0TM8MHtFckgn3/
         MrNzUXSbds9aKS7vEmqqe2y9K/HGZS+MV4JXj1zTmp0A2tSAJSP50zxMOWFNsdiwzHOq
         Eqet0WKojWkrwAguAm84x02vTe2WNS+Qo1eK6dy30V9atUnOBm0MhDF1LiFN9/upPz5m
         rmQnmvrQPUmqPQpNEhbGTIKj47TFfCKIKZZ3gV9rFSCrlrc5vPfwirGWtT0f+gebLw5S
         N+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683648242; x=1686240242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W2AbGXoin+5hxz/sFqIGD40a3J1EXdYBNV+hW/GpDI=;
        b=ikYs+kXEvC05+iZr319xnslDb15FIxWCXU8bXoRyMPnH9A/Yl6+fGHgQVkzHWPb8Gq
         YPyO6NlK3Putbssr5WTFlBZfiODva7Ct+oltlG7MsstKSi8fb8PCEHX6p/xbyBH3HH3A
         05L+SeLGAXRltsjtE1jIl6Y99gCDw/6do47eO6uu928IotIom6hnLX7v+VSFRA9GSoH4
         xyc8TjcA8XSz2chKkDJDTE7sHXsaDWHuuvEa50OR7A6+q2v30vta/3eNtUDBbBz2uS/A
         2GGwOq1Pw3rD6nQJjlA3VRIlkXxHU3c8hGgWumeWSxn3iSx4nO67yDW6Le160EP191gZ
         CArg==
X-Gm-Message-State: AC+VfDzYx4CC249DapVZBN2QbVSgliABAUttpbxzdv3tpSf11gPxS0Yd
        33l+iDTUXP4WPmp6h49RFdoMsg==
X-Google-Smtp-Source: ACHHUZ7jsGZVu6tjUq2cwD0yDjE+mb4ZAnC7nOsl5zt9oE6kmtKM+6HxNI35Ddob1uM3Rt65zodX6g==
X-Received: by 2002:a17:907:1c25:b0:969:9c0c:4c97 with SMTP id nc37-20020a1709071c2500b009699c0c4c97mr4171312ejc.1.1683648242301;
        Tue, 09 May 2023 09:04:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id la17-20020a170907781100b00957dad777c1sm1484712ejc.107.2023.05.09.09.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 09:04:01 -0700 (PDT)
Message-ID: <27232a95-6ef8-1a98-4f5d-7d0ea29c20c4@linaro.org>
Date:   Tue, 9 May 2023 18:04:00 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1868d9ae-1376-d91d-a789-9e510bde96a7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 16:19, Michal Simek wrote:
> 
> 
> On 5/7/23 10:07, Krzysztof Kozlowski wrote:
>> On 05/05/2023 15:25, Michal Simek wrote:
>>> The Microchip usb5744 is a SS/HS USB 3.0 hub controller with 4 ports.
>>> The binding describes USB related aspects of the USB5744 hub, it as
>>> well cover the option of connecting the controller as an i2c slave.
>>> When i2c interface is connected hub needs to be initialized first.
>>> Hub itself has fixed i2c address 0x2D but hardcoding address is not good
>>> idea because address can be shifted by i2c address translator in the
>>> middle.
>>>
>>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>> Changes in v2:
>>> - fix i2c-bus property
>>> - swap usb2.0/3.0 compatible strings
>>> - fix indentation in example (4 spaces)
>>> - add new i2c node with microchip,usb5744 compatible property
>>>
>>> It looks like that usb8041 has also an optional i2c interface which is not
>>> covered. But it is mentioned at commit 40e58a8a7ca6 ("dt-bindings: usb:
>>> Add binding for TI USB8041 hub controller").
>>>
>>> i2c-bus name property was suggested by Rob at
>>> https://lore.kernel.org/all/CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com/
>>> and
>>> https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/
>>>
>>> the question is if adding address like this is acceptable.
>>> But it must be specified.
>>>
>>> Driver will follow based on final dt-binding.
>>>
>>> $ref: usb-device.yaml# should be also added but have no idea how to wire it
>>> up to be applied only on usb node not i2c one.
>>>
>>> ---
>>>   .../bindings/usb/microchip,usb5744.yaml       | 110 ++++++++++++++++++
>>>   1 file changed, 110 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>> new file mode 100644
>>> index 000000000000..7e0a3472ea95
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>> @@ -0,0 +1,110 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/usb/microchip,usb5744.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Microchip USB5744 4-port Hub Controller
>>> +
>>> +description:
>>> +  Microchip's USB5744 SmartHubTM IC is a 4 port, SuperSpeed (SS)/Hi-Speed (HS),
>>> +  low power, low pin count configurable and fully compliant with the USB 3.1
>>> +  Gen 1 specification. The USB5744 also supports Full Speed (FS) and Low Speed
>>> +  (LS) USB signaling, offering complete coverage of all defined USB operating
>>> +  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.0
>>> +  controller, so 5 Gbps SuperSpeed data transfers are not affected by slower
>>> +  USB 2.0 traffic.
>>> +
>>> +maintainers:
>>> +  - Piyush Mehta <piyush.mehta@amd.com>
>>> +  - Michal Simek <michal.simek@amd.com>
>>> +
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: microchip,usb5744
>>> +  required:
>>> +    - compatible
>>
>> I don't understand why do you need this select. It basically disables
>> schema matching for other ones.
> 
> I didn't find a way how to have usbXXX,XXXX compatible strings and 
> microchip,usb5744 compatible in the same file. I am definitely lacking knowledge 
> how to write it properly that's why any advise is welcome.

Hm, if you just have both of them like you have now, what happens?

Best regards,
Krzysztof

