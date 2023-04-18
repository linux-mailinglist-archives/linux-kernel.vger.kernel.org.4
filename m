Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD44D6E5A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjDRHJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDRHJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:09:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995EB1FE5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:09:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id c9so31758667ejz.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681801772; x=1684393772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dqMfJus3L0V4CyqoNejxJugqIJ1uzJrSENoG5X9s2es=;
        b=kFY3dQGNsxc32413uTKo3YYtXO1uo0wqJ9v3pELM+0DKD0eFCTHEgXAQE38mHy1TTL
         zC1iVLEJXjk6xMfzWygTXPCavXcmH/0dfY2bgNZ7r5F5vxzMAUPLPsW2HqAGOAMx/rpX
         tIUOkORAfvCNOQnADkn3PCcTq2jzvntvhonX3ihrkb0BBP+adrSp+V+SmXRrFi+blHJv
         4nfgiqq49/6NpKbjA2wQORNFAze4GyWB02a+1IxGURXBJoFxmYAjl5hemtgRL01NW3b3
         eTDs1TAiKjSptXmbxJM3cXtFAhz07CepQufWWWvsfHD7a3098RaAMNtYpBgrQdQWzUxU
         ObMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681801772; x=1684393772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqMfJus3L0V4CyqoNejxJugqIJ1uzJrSENoG5X9s2es=;
        b=MmflkLnaH18fpK1uh1f+iUutl3liOsmD+o7+oUtmdqCfcW2RyX84vXogJGmOvf4v4c
         8q3x8PqnieWMV2+f9AQp7c4LFCbrwijr+WTUeayZwWSGfmvZAFPc5Cec/kTPPirPN9Si
         tJOngTQf86f4Vpxity+esDhXeloO8iW25XNzdGYaz62P0UZkgDoP2rS05tjIRnvfJQ4T
         zrUu59bQabPmVRSJuEwpzG4X5gIuZCU5fCOJybaVhSnBqQJ/x6OK1jxmbXsL89edztBu
         9wgdrRFgW6skVwdEDi+hAKVY0z0pGoN7haut1kuj+colP3UZbevLXZU0c+lYMjv21sgu
         0c9Q==
X-Gm-Message-State: AAQBX9cpZEyAAGy9++NVHnbOa1MRFzH0+lAC20zYHGqlMeWqtdpwfyKW
        4QZf9LrS7P95MJht9mGBOaOqEg==
X-Google-Smtp-Source: AKy350ZGZ/VpT5OUrMXdnOaMJ4x+Z8GPooB3COD1bqfek+cE8WIKQde6hNPA3G9felheu0+s90+oHg==
X-Received: by 2002:a17:906:73d3:b0:94f:80d6:b825 with SMTP id n19-20020a17090673d300b0094f80d6b825mr4972685ejl.19.1681801772040;
        Tue, 18 Apr 2023 00:09:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id gx18-20020a1709068a5200b0094f16a3ea9csm4768239ejc.117.2023.04.18.00.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 00:09:31 -0700 (PDT)
Message-ID: <1e1fb90a-43c0-3b0a-ab7a-8ca3ce8b02ed@linaro.org>
Date:   Tue, 18 Apr 2023 09:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/6] dt-bindings: power: supply: add MAX77659 charger
 binding
Content-Language: en-US
To:     "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
 <20221220132250.19383-5-Zeynep.Arslanbenzer@analog.com>
 <5ba4295f-1197-913c-b1eb-a23798c3badf@linaro.org>
 <MN2PR03MB5197E655DE2EAACAEA2316578B9C9@MN2PR03MB5197.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB5197E655DE2EAACAEA2316578B9C9@MN2PR03MB5197.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 23:43, Arslanbenzer, Zeynep wrote:
>> On 20/12/2022 14:22, Zeynep Arslanbenzer wrote:
>>> This patch adds device tree binding documentation for MAX77659 charger.
>>
>> Do not use "This commit/patch".
>> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst*L95__;>Iw!!A3Ni8CS0y2Y!-AnHmIThbB5Q88_dFdveEmsXlsfflRXDabf6RVE5ySRusMxP24NEfAr8RCsu26LTvoaIIMvEDr2YxDECrGlMwR8-ywvoR62rXB0W$ 
>>
>>>
>>> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>>
>>> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>>
>>> ---
>>>  .../power/supply/adi,max77659-charger.yaml    | 42 +++++++++++++++++++
>>>  MAINTAINERS                                   |  1 +
>>>  2 files changed, 43 insertions(+)
>>>  create mode 100644 
>>> Documentation/devicetree/bindings/power/supply/adi,max77659-charger.ya
>>> ml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/power/supply/adi,max77659-charger.
>>> yaml 
>>> b/Documentation/devicetree/bindings/power/supply/adi,max77659-charger.
>>> yaml
>>> new file mode 100644
>>> index 000000000000..24f8b5a2bd84
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/supply/adi,max77659-char
>>> +++ ger.yaml
>>> @@ -0,0 +1,42 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
>>> +---
>>> +$id: 
>>> +https://urldefense.com/v3/__http://devicetree.org/schemas/power/suppl
>>> +y/adi,max77659-charger.yaml*__;Iw!!A3Ni8CS0y2Y!-AnHmIThbB5Q88_dFdveEm
>>> +sXlsfflRXDabf6RVE5ySRusMxP24NEfAr8RCsu26LTvoaIIMvEDr2YxDECrGlMwR8-ywv
>>> +oR5rKUR11$
>>> +$schema: 
>>> +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
>>> +aml*__;Iw!!A3Ni8CS0y2Y!-AnHmIThbB5Q88_dFdveEmsXlsfflRXDabf6RVE5ySRusM
>>> +xP24NEfAr8RCsu26LTvoaIIMvEDr2YxDECrGlMwR8-ywvoRy_yWWBS$
>>> +
>>> +title: Battery charger for MAX77659 PMIC from ADI.
>>
>> Drop full stop.
>>
>>> +
>>> +maintainers:
>>> +  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>>
>>> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>>
>>> +
>>> +description: |
>>> +  This module is part of the MAX77659 MFD device. For more details
>>> +  see Documentation/devicetree/bindings/mfd/adi,max77659.yaml.
>>> +
>>> +  The charger is represented as a sub-node of the PMIC node on the device tree.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: adi,max77659-charger
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  adi,fast-charge-timer:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Fast-charge safety timer value (in hours).
>>
>> No, use suffixes for common units.
> 
> Hi Krzysztof,
> 
> Thank you for your review. The possible register values of the fast charge safety timer are described in the datasheet as follows. I was undecided about using the common unit, second, as it may affect the comprehensibility of the code. Of course, I can use second as the common unit if you think it's more appropriate.

This is quite common property, so I do not understand why this one
driver should have it written differently. I understand that parsing
0/1/2/3 is easier for the machine than 0/3/5/7 but it is not easier for
humans.

> 
> 0b00 = Timer disabled 
> 0b01 = 3 hours 
> 0b10 = 5 hours 
> 0b11 = 7 hours
> 
>>
>>> +
>>> +  adi,fast-charge-microamp:
>>> +    description: Fast-charge constant current value.
>>
>>> +
>>> +  adi,topoff-timer:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Top-Off timer value (in minutes).
>>
>> No, use suffixes for common units.
> 
> Similar case:
> 
> 0b000 = 0 minutes 
> 0b001 = 5 minutes 
> 0b010 = 10 minutes 
> 0b011 = 15 minutes 
> 0b100 = 20 minutes 
> 0b101 = 25 minutes 
> 0b110 = 30 minutes 
> 0b111 = 35 minutes

Come on, this is easy to parse. Divide by 5 and where is the code
complexity?

Best regards,
Krzysztof

