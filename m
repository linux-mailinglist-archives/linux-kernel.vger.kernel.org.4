Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E466211C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjAIJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjAIJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:11:46 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB30D178B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:08:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o15so5738462wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeamC+5HCrCEB+x0OBOSbvY/5eyBn0AnwZPYF9JEd3U=;
        b=EZDB9m7KfPX6hQI067hHiDmD14mANKUfROLBf4JAbzvFo/R5gP9heZZXHaP3G3IDqT
         ZZ97cGEM5qB4R4Lrhre5ZmvTBBT5dNHfsu3b2EUEdl/f9uRqoE7jmKFDL36gDFX7f+gj
         y3nZSPpBimWZgy4+y8l/dZGGqA25RR80FQgzr91+bt14Dic9CnmSB9s1FrmSdVHtErSL
         EeMIaZsMktewJ9j6JrjaqR0lPPMbpo8b1Gk3SLKPrsUeYMFTaSf2JI0wEa2QZiZSGS79
         KsiVHYOYR6bknah+a3kkxCkQchaMsc5GcUUlDmEpOXE9hicCiBt5XrOleKh5CzJCvZYC
         mgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeamC+5HCrCEB+x0OBOSbvY/5eyBn0AnwZPYF9JEd3U=;
        b=y+XqocGgslKH62bzH6W0uu3FFf2A7AU3ZR6jARDFAubNM84vlbr7xD0jfeu43SUmHS
         ULgqItrlD1+ouWYy3uwEM/653ZhGwVszhjH3YQfcgP6W0CyNuhVuh+ZoaM/hrUDVzJva
         AhKvGUs8cXFziGcBhEiAQMCzBo0vzYVbFGbzS00wH29J8F+7jNDfKCjKS7hmRkZ7uuh8
         GZhyukd+5VzrLqAVgo26PlAa2V+5SuQ6yLkBoV+g/eFqf3HXE2uTztgoYyzMxj8ouCBh
         wMozW5NJlADFJUVPzTlJeZQd/RhaGo5eodK0s55lh0ckkXjJzf/altKict8slliXlBlc
         QDpQ==
X-Gm-Message-State: AFqh2kpBZ2B9MUIHOfiJTSMbW+ojqNj9+WWNkWNhl1zhzjzyn+yAaT3W
        8qA5IcJgQxrt0xzJRXos+0sVSYrUIJH7VTha
X-Google-Smtp-Source: AMrXdXtr26ao+GD/mNTKp+tCDB3XicbZ8EYtBKq8RVrXkuHmtnPQi3ZeTIqsyC3vqEs/MF6Dje8IKg==
X-Received: by 2002:a05:600c:4f48:b0:3d6:8570:1239 with SMTP id m8-20020a05600c4f4800b003d685701239mr56297915wmq.16.1673255282438;
        Mon, 09 Jan 2023 01:08:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003c6f1732f65sm16469505wmq.38.2023.01.09.01.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 01:08:01 -0800 (PST)
Message-ID: <c0586501-53cf-b8f6-3c5b-9d153c7e0e21@linaro.org>
Date:   Mon, 9 Jan 2023 10:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Content-Language: en-US
To:     Chester Lin <clin@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
References: <20221221073232.21888-1-clin@suse.com>
 <20221221073232.21888-2-clin@suse.com>
 <17dc933d-e46c-ddfa-b185-5c24fa7dddb6@linaro.org>
 <Y7u8cWR7p3/MfKgB@linux-8mug>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7u8cWR7p3/MfKgB@linux-8mug>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 08:04, Chester Lin wrote:
> Hi Krzysztof,
> 
> On Thu, Dec 22, 2022 at 12:28:31PM +0100, Krzysztof Kozlowski wrote:
>> On 21/12/2022 08:32, Chester Lin wrote:
>>> Add DT schema for the pinctrl driver of NXP S32 SoC family.
>>>
>>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>>> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
>>> Signed-off-by: Chester Lin <clin@suse.com>
>>> ---
>>>
>>> Changes in v3:
>>> - Remove the minItems from reg because there's no optional item for s32g2.
>>> - List supported properties of pinmux-node and pincfg-node and add more
>>>   descriptions.
>>> - Adjust the location of "required:".
>>> - Fix descriptions and wordings.
>>> - Rename the yaml file to nxp,s32g2-siul2-pinctrl.yaml.
>>>
>>> Changes in v2:
>>> - Remove the "nxp,pins" property since it has been moved into the driver.
>>> - Add descriptions for reg entries.
>>> - Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
>>> - Fix schema issues and revise the example.
>>> - Fix the copyright format suggested by NXP.
>>>
>>>  .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      | 129 ++++++++++++++++++
>>>  1 file changed, 129 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
>>> new file mode 100644
>>> index 000000000000..1554ce14214a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
>>> @@ -0,0 +1,129 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright 2022 NXP
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: NXP S32G2 pin controller
>>> +
>>> +maintainers:
>>> +  - Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
>>> +  - Chester Lin <clin@suse.com>
>>> +
>>> +description: |
>>> +  S32G2 pinmux is implemented in SIUL2 (System Integration Unit Lite2),
>>> +  whose memory map is split into two regions:
>>> +    SIUL2_0 @ 0x4009c000
>>> +    SIUL2_1 @ 0x44010000
>>> +
>>> +  Every SIUL2 region has multiple register types, and here only MSCR and
>>> +  IMCR registers need to be revealed for kernel to configure pinmux.
>>> +
>>> +  Please note that some register indexes are reserved in S32G2, such as
>>> +  MSCR102-MSCR111, MSCR123-MSCR143, IMCR84-IMCR118 and IMCR398-IMCR429.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - nxp,s32g2-siul2-pinctrl
>>> +
>>> +  reg:
>>> +    description: |
>>> +      A list of MSCR/IMCR register regions to be reserved.
>>> +      - MSCR (Multiplexed Signal Configuration Register)
>>> +        An MSCR register can configure the associated pin as either a GPIO pin
>>> +        or a function output pin depends on the selected signal source.
>>> +      - IMCR (Input Multiplexed Signal Configuration Register)
>>> +        An IMCR register can configure the associated pin as function input
>>> +        pin depends on the selected signal source.
>>> +    items:
>>> +      - description: MSCR registers group 0 in SIUL2_0
>>> +      - description: MSCR registers group 1 in SIUL2_1
>>> +      - description: MSCR registers group 2 in SIUL2_1
>>> +      - description: IMCR registers group 0 in SIUL2_0
>>> +      - description: IMCR registers group 1 in SIUL2_1
>>> +      - description: IMCR registers group 2 in SIUL2_1
>>> +
>>> +patternProperties:
>>> +  '-pins$':
>>> +    type: object
>>> +    additionalProperties: false
>>> +
>>> +    patternProperties:
>>> +      '-grp[0-9]$':
>>> +        type: object
>>> +        allOf:
>>> +          - $ref: pinmux-node.yaml#
>>> +          - $ref: pincfg-node.yaml#
>>> +        description: |
>>> +          Pinctrl node's client devices specify pin muxes using subnodes,
>>> +          which in turn use the standard properties below.
>>> +
>>> +        properties:
>>> +          bias-disable: true
>>> +          bias-high-impedance: true
>>> +          bias-pull-up: true
>>> +          bias-pull-down: true
>>> +          drive-open-drain: true
>>> +          input-enable: true
>>> +          output-enable: true
>>> +
>>> +          pinmux:
>>> +            description: |
>>> +               An integer array for representing pinmux configurations of
>>> +               a device. Each integer consists of a PIN_ID and a 4-bit
>>> +               selected signal source(SSS) as IOMUX setting, which is
>>> +               calculated as: pinmux = (PIN_ID << 4 | SSS)
>>> +
>>> +          slew-rate:
>>> +            description: |
>>> +              0: 208MHz
>>> +              1-3: Reserved
>>> +              4: 166MHz
>>> +              5: 150MHz
>>> +              6: 133MHz
>>> +              7: 83MHz
>>> +            enum: [0, 4, 5, 6, 7]
>>
>> You have known values, then use them. This is much more readable in DTS.
> 
> The main reason of mapping with register values [0-7] is to simplify the
> driver implementation while handling register r/w. 

Define bindings for the DTS, not for the drivers.

> To improve readability
> as you suggested, I am thinking of having a DT header "s32g2-pinfunc.h" with
> a few binding macros/helper as below, the only difference compared to v3 is
> using S32G2_PINMUX and S32G2_SLEW_XXXMHZ macros rather than pure integers
> to represent pinmux and slew-rate property values.

Binding headers is not a place for register values. By definition -
these are bindings, not hardware description. Hardware description is
DTS. Feel free to store them in DTS headers, but anyway this does not
solve the issue here.

The issue is: you store register values in DTS, which is limited, not
extendable description. Each of your devices would need entirely
different binding for this because register values can change between
every SoC version. Several other pinctrl bindings use similar approach,
but they have not got a clear mapping to values (e.g. they have fast and
slow). For the case with real values, use the same solution as
drive-strength - real values.

> 
> Regards,
> Chester
> 
> 
> From 3a29d905ae104e694230ffc02dc9f9de4191c5d1 Mon Sep 17 00:00:00 2001
> From: Chester Lin <clin@suse.com>
> Date: Fri, 28 Oct 2022 16:44:29 +0800
> Subject: [PATCH] dt-bindings: pinctrl: add support for NXP S32 SoCs
> 
> Add DT schema and hedaer file for the pinctrl driver of NXP S32 SoC family.
> 
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      | 136 ++++++++++++++++++
>  include/dt-bindings/pinctrl/s32g2-pinfunc.h   |  17 +++

NAK for bindings.


Best regards,
Krzysztof

