Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDE4651E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiLTKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiLTJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:59:51 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8556239D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:58:13 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p36so17754953lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQkIqaxBtB0Ewfz7A6he2wHq2KcHNaWctN054QYteZs=;
        b=Se8p7QFKTprIr1l5ziV9OgWwRWON80NMznYu6QzDl152RsVlSZNSRNk3SV/yPj53v5
         5GUyFMko3MHxyJV8ni/WPypCIFB/qwi1aWFUGegQBNXyVJCcfP2Q+KwWX4vQbMuqIQPW
         2Gtvnfo2rmkSO3uqI81ZVHYXA8glKSl8SZ4V/a50xOFnFkKgLTMiIlZ8VAXrQruweOXw
         AYAoWOUX2V8YB/UO9O+k8YcwhI7L0rt9wqSUfsMYg4BI86SxJMmra0anoxw06IEyYHHv
         8zkuCqbfgRCC+8Omkq0Pqqv5gAkFohFnQOLEz2yhMfYHpZBCYCEIBIlXRTwM0IUl0D27
         Cr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQkIqaxBtB0Ewfz7A6he2wHq2KcHNaWctN054QYteZs=;
        b=AfE54xPU4nQIFdRihrrtZZk4s3gqOcClg9o0PksnEUNnnYnKMQ/L/IkRy9dy9V5hTs
         FTxqm9FbRCi7Cymntz0HctUlUHbO1AX13J3eLa28gTxFqA4HKEolCIuP2xIOsTO6yHnR
         3nqocWvdIrt7jiz+lg36QkoPno2cClluCSTjfIp0Ir7YlaUqUZ+0AhcGFQbGIFMRxmAf
         lyhtowXmZQ8Z+ZW1mQ01jCSjGoObvbHmw8wm/8XoFcURpwoiJXOV+sfXpGoL10mfxSRp
         ROcWi4ri1+7owKfk1g69XlAEiy3/6c1TFvnLw1RCu1o4ESXLC5YV0xSWgV097LGQgsSS
         nlYg==
X-Gm-Message-State: ANoB5pk1F8EKpxMJCZ4+z/i2sz4WIUiTUZO6a8FjZ6nnoyytkwx4v7LF
        ghB7Tci1Do0cx/6TBOgat86pwg==
X-Google-Smtp-Source: AA0mqf4fa83vKausq8IwFJxpg7iYptOZiAjPPBjemcwf6+O/3/Qq7ioCFbXlbZhwHmg6RAq9FFkVnw==
X-Received: by 2002:a05:6512:68f:b0:4b6:f595:cfde with SMTP id t15-20020a056512068f00b004b6f595cfdemr11279533lfe.12.1671530291883;
        Tue, 20 Dec 2022 01:58:11 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q5-20020a19a405000000b004b4ea0f4e25sm1397030lfc.301.2022.12.20.01.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:58:11 -0800 (PST)
Message-ID: <26471d96-804a-93e8-d866-e6c89ce52952@linaro.org>
Date:   Tue, 20 Dec 2022 10:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] dt-bindings: display: rockchip: convert
 rockchip-lvds.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <fd51df66-147d-d40f-913e-385625a71984@gmail.com>
 <8db62d1a-365c-d41d-90aa-4c78c5d5e9ce@linaro.org>
 <5e05a6d5-bc89-fb66-fcae-2e1194e23c12@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5e05a6d5-bc89-fb66-fcae-2e1194e23c12@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 15:23, Johan Jonker wrote:
> 
> 
> On 12/19/22 14:04, Krzysztof Kozlowski wrote:
>> On 19/12/2022 13:32, Johan Jonker wrote:
>>> Convert rockchip-lvds.txt to YAML.
>>>
>>> Changed:
>>>   Add power-domains property.
>>>   Requirements between PX30 and RK3288
>>>
>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>> ---
>>>
>>> Changed V3:
>>>   Filename matching compatible style
>>>   Drop "Regulator phandle for "
>>>   Specify properties and requirements per SoC
>>>   Sort order and restyle
>>>
>>> Changed V2:
>>>   Fix title
>>> ---
>>>  .../display/rockchip/rockchip,lvds.yaml       | 170 ++++++++++++++++++
>>>  .../display/rockchip/rockchip-lvds.txt        |  92 ----------
>>>  2 files changed, 170 insertions(+), 92 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
>>> new file mode 100644
>>> index 000000000..03b002a05
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
>>> @@ -0,0 +1,170 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,lvds.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Rockchip low-voltage differential signal (LVDS) transmitter
>>> +
>>> +maintainers:
>>> +  - Sandy Huang <hjc@rock-chips.com>
>>> +  - Heiko Stuebner <heiko@sntech.de>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - rockchip,px30-lvds
>>> +      - rockchip,rk3288-lvds
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    const: pclk_lvds
>>> +
>>> +  avdd1v0-supply:
>>> +    description: 1.0V analog power.
>>> +
>>> +  avdd1v8-supply:
>>> +    description: 1.8V analog power.
>>> +
>>> +  avdd3v3-supply:
>>> +    description: 3.3V analog power.
>>> +
>>> +  rockchip,grf:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Phandle to the general register files syscon.
>>> +
>>> +  rockchip,output:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    enum: [rgb, lvds, duallvds]
>>> +    description: This describes the output interface.
>>> +
>>> +  phys:
>>> +    maxItems: 1
>>> +
>>> +  phy-names:
>>> +    const: dphy
>>> +
>>> +  pinctrl-names:
>>> +    const: lcdc
>>> +
>>> +  pinctrl-0: true
>>> +
>>> +  power-domains:
>>> +    maxItems: 1
>>> +
>>> +  ports:
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +
>>> +    properties:
>>> +      port@0:
>>> +        $ref: /schemas/graph.yaml#/properties/port
>>> +        description:
>>> +          Video port 0 for the VOP input.
>>> +          The remote endpoint maybe vopb or vopl.
>>> +
>>> +      port@1:
>>> +        $ref: /schemas/graph.yaml#/properties/port
>>> +        description:
>>> +          Video port 1 for either a panel or subsequent encoder.
>>> +
>>> +    required:
>>> +      - port@0
>>> +      - port@1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - rockchip,grf
>>> +  - rockchip,output
>>> +  - ports
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: rockchip,px30-lvds
>>> +
>>> +    then:
>>> +      properties:
>>> +        reg: false
>>> +        clocks: false
>>> +        clock-names: false
>>> +        avdd1v0-supply: false
>>> +        avdd1v8-supply: false
>>> +        avdd3v3-supply: false
>>> +
>>
> 
>> I see one compatible expects regmap from parent (grf is the parent here)
>> and other is directly on MMIO bus. Not the best combination... Maybe
>> this  should be just split to two separate bindings? Looking at driver,
>> their code is also very different between these two variants.
> 
> Looking at the manufacturer tree we can expect the rest with grf parent, but also in the same driver combined with different registers and common probe.
> Due to common probe I prefer one common document.

Bindings are not representing Linux driver structure, so common probe is
not really argument. If you create one driver (one probe) handling
different devices like RTC, extcon, regulator and clocks, does it mean
it must be one binding? No.

You are over-complicating bindings now.

These are entirely different devices - their programming model and how
they are modeled in the DTS.

Best regards,
Krzysztof

