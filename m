Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895EF60FCB2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiJ0QL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiJ0QLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:11:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7182912A369;
        Thu, 27 Oct 2022 09:11:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t25so6033319ejb.8;
        Thu, 27 Oct 2022 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEOpvN68jPCwUN4c3PeZtZY0w4MQx/f0QidBJlMoEDc=;
        b=deZK34HXqBf5Skxc9URyGQnIytbFrme1ALiV0jY/mjqjO6k0Qv1a25vfIL6zdB9MPn
         PBxwstbnUzF/6iO7lH2CV+1sYAJviPIDirLdHMsKGtDvprWCcdWuPYzC1Pdw7O4MbwuX
         8KI3apXgzdNvuduWBN5XnN+FI3yrbDPGAForlnB44mZLDOy+JcAI+BlnuBQ304BuzcRG
         alDqQSw+K25LSf1VU55eaQYJPf6rqJ/LraCyb/nhJAUd+7INCBMRlmVy4LWgJmfCCphN
         kqc6NqzsJD6OpoWuxrbk/tZAWYwXz5NWmE6wEF1moJ0FSDc60uI5c3x2/3/0h4xv4Lat
         bJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEOpvN68jPCwUN4c3PeZtZY0w4MQx/f0QidBJlMoEDc=;
        b=n72YVjQ38sg4Dz0oFzslZig/yg1/RZUChtuI5KqYqF486Tq/6RyI0IIHSinma8HFPd
         5FNnLF6QEkhx9kBqIHqNu470iKWZWVDsImmmTkjOeRTMcfworyca1FDGVeOKm/vN52Qi
         S5ukOb9e3MVWIwUOa2/bQWtxgDt2WFO6lX0gG4YYQKK1zihmd1vUNu3frqgb8EjVaJYP
         I4Pc8fVvPvs15hjCdz0y7NPrszm/IdyPM26Z9Cx/rDQZd96fHL+5XU3cBmMrNkxc7dHt
         SoCMp8DljGjETkDeoZMadVynLuoWHYQsXu1pc060dyi1KYcJ8uCCyF5Q6OBv9QcgLqt6
         1OZA==
X-Gm-Message-State: ACrzQf1vn+3DetfY0dHMIyNwbMo4DkA3cEkT2tQ4XPDFa9uJfqurLTUi
        vP43+UxoGUkMNA3xSE8VrkzS4oN5Pgo=
X-Google-Smtp-Source: AMsMyM6l3G+Idy9P5Qhjudb+fZF+OU8hv2gHWIzFvO/WcVkCskmaZeWTIQrCdsPuGGBaAHM+xG07Gw==
X-Received: by 2002:a17:907:2cf7:b0:78d:c7fc:29ff with SMTP id hz23-20020a1709072cf700b0078dc7fc29ffmr43886752ejc.748.1666887080978;
        Thu, 27 Oct 2022 09:11:20 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090653d000b0078a83220609sm960479ejo.13.2022.10.27.09.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 09:11:20 -0700 (PDT)
Message-ID: <1a9e1bfb-0437-fcd9-8d41-a1e07aced0e3@gmail.com>
Date:   Thu, 27 Oct 2022 18:11:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/1] dt-bindings: rtc: convert hym8563 bindings to
 json-schema
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221021170605.85163-1-sebastian.reichel@collabora.com>
 <a5db8a34-acd0-e262-36f0-0b904468bd1f@linaro.org>
 <20221024185049.GA2034297-robh@kernel.org>
 <20221024220559.dddihmq4xg55h26w@mercury.elektranox.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20221024220559.dddihmq4xg55h26w@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/22 00:05, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Oct 24, 2022 at 01:50:49PM -0500, Rob Herring wrote:
>> On Fri, Oct 21, 2022 at 07:59:26PM -0400, Krzysztof Kozlowski wrote:
>>> On 21/10/2022 13:06, Sebastian Reichel wrote:
>>>> Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
>>>> Schema format.
>>>>
>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>> ---
>>>>  .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
>>>>  .../bindings/rtc/haoyu,hym8563.yaml           | 55 +++++++++++++++++++
>>>>  2 files changed, 55 insertions(+), 30 deletions(-)
>>>>  delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
>>>>  create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
>>>> deleted file mode 100644
>>>> index a8934fe2ab4c..000000000000
>>>> --- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
>>>> +++ /dev/null
>>>> @@ -1,30 +0,0 @@
>>>> -Haoyu Microelectronics HYM8563 Real Time Clock
>>>> -
>>>> -The HYM8563 provides basic rtc and alarm functionality
>>>> -as well as a clock output of up to 32kHz.
>>>> -
>>>> -Required properties:
>>>> -- compatible: should be: "haoyu,hym8563"
>>>> -- reg: i2c address
>>>> -- #clock-cells: the value should be 0
>>>> -
>>>> -Optional properties:
>>>> -- clock-output-names: From common clock binding
>>>> -- interrupts: rtc alarm/event interrupt
>>>> -
>>>> -Example:
>>>> -
>>>> -hym8563: hym8563@51 {
>>>> -	compatible = "haoyu,hym8563";
>>>> -	reg = <0x51>;
>>>> -
>>>> -	interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
>>>> -
>>>> -	#clock-cells = <0>;
>>>> -};
>>>> -
>>>> -device {
>>>> -...
>>>> -	clocks = <&hym8563>;
>>>> -...
>>>> -};
>>>> diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
>>>> new file mode 100644
>>>> index 000000000000..b0b6126b12dd
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
>>>> @@ -0,0 +1,55 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>
>>> Dual license please. I don't think you copied any content from original
>>> bindings... unless the example?
>>>
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/rtc/haoyu,hym8563.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Haoyu Microelectronics HYM8563 RTC
>>>> +
>>>> +maintainers:
>>>> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: haoyu,hym8563
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  "#clock-cells":
>>>> +    const: 0
>>>> +
>>>> +  clock-output-names:
>>>> +    description: From common clock binding to override the default output clock name.
>>>
>>> You need maxItems for this.
>>>
>>>> +
>>>> +  wakeup-source:
>>>> +    description: Enables wake up of host system on alarm.
>>>> +
>>>> +allOf:
>>>> +  - $ref: rtc.yaml
>>>> +
>>>> +unevaluatedProperties: false
>>>> +
>>>

>>> Would be great if you could also correct DTS using these bindings (see
>>> warning from Rob).
>>
>> It looked to me like 'clock-frequency' should be added to the schema.
> 
> I've sent PATCHv2, which removes clock-frequency from all hym8563
> users. My reasoning is, that the old txt binding does not describe
> it and the current Linux driver does not handle it as far as I can
> see.

Didn't note you were doing a conversion as well...
From my abandonment patch serie

  clock-frequency:
    enum: [1, 32, 1024, 32768]

The data sheet shows that it can generate 4 different frequencies.
Rockchip mostly uses 32768, but that doesn't mean someone else is not alowed to set what he/she prefers.

Johan

> 
> https://lore.kernel.org/all/20221024165549.74574-1-sebastian.reichel@collabora.com/
> 
> -- Sebastian
