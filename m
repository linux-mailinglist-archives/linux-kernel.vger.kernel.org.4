Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4B26B6F69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCMGNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCMGNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:13:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07476C640;
        Sun, 12 Mar 2023 23:13:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g17so14265615lfv.4;
        Sun, 12 Mar 2023 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678687987;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRhBcf5ZDslUPYrSaszRsi4kzEuDzWr1ClJbjTYi3Tk=;
        b=hp13GnpJvHNlKW7UrZhp28Yd97f62UyJZWYN3y68MhiJV3kD8xtnWKIYUKu9AX9rcm
         ZMkTvvkDI6YlvON8BbY6Oado2GtV3pvtFq0sfX/jqmdOZZyD2k9mzBQinDXmHllGNZLc
         TCOx0pB/OmE3v4djCIF47t3q/t7afpT7FzYdOCm4YKax+dUSRNoZsEcTh0N0cHffrSWF
         di0i2OUDwit2zlG8Z8jXSng+1+XZXHUsSEtluhDvvmSTrsSKC61c8uQvgb/Gdree6LSs
         ep8xA/ONXOT8gVPAIsjo8QRAmPr+8IBb/sfPZzAa379OvmE1CkiH4Slon+46EigYXNZh
         y66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678687987;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRhBcf5ZDslUPYrSaszRsi4kzEuDzWr1ClJbjTYi3Tk=;
        b=EdzSiCifWEPp6ep4AoemwGQpj25vfQ8xj7AZ15ikDpvuzUP3sMgu0HuernuPLHbZ+a
         JFmTS7NtT1vIzJvY6WGtbwYZ/tpeoSxwAEPfzTWLhLt2gQutYK8XPoQws+FxD5a7e5iK
         Af6AavvZzjMVz9Yrqt8nyl4bGZKtA+0SpANB/qbP/YK+Mp9aL7KdTBSSE2HTB+g9Ue/i
         RAVVTvGUZN58J/ozdH/Cwilt/7we7g52ZBiDV+cIKcc769+0Xvqw9EbUpYLUK/WlUe4u
         5VfC1zG0alovBXZQ9LD+0VutHgwpRH4NP3GCui5z+WSZVv2i2PNXf41K56W1DpBmkmZJ
         S4Lw==
X-Gm-Message-State: AO0yUKV2uTKkfZD/EhzItq+PstCyqayBBb/1/nPcBtnd/j8EVncJJQFF
        PgBkUTvvsoXnaj08mXhuv6biTtk0THU=
X-Google-Smtp-Source: AK7set8NPLifK38O/uGQzCr4tN5Dn6eLIY7/DHqlA+pCbAZc9r7FYETdy61jrvlaSaiWtwB4W0iifA==
X-Received: by 2002:a05:6512:1319:b0:4e8:3d0:84b4 with SMTP id x25-20020a056512131900b004e803d084b4mr2527943lfu.24.1678687987108;
        Sun, 12 Mar 2023 23:13:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id w11-20020a19c50b000000b004dc4b0ca734sm864626lfe.250.2023.03.12.23.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 23:13:06 -0700 (PDT)
Message-ID: <7a8d38bb-cfc1-f13b-e108-be0c61928ff0@gmail.com>
Date:   Mon, 13 Mar 2023 08:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-2-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCHv1 01/11] dt-bindings: power: supply: adc-battery: add
 binding
In-Reply-To: <20230309225041.477440-2-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 3/10/23 00:50, Sebastian Reichel wrote:
> Add binding for a battery that is only monitored via ADC
> channels and simple status GPIOs.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   .../bindings/power/supply/adc-battery.yaml    | 67 +++++++++++++++++++
>   1 file changed, 67 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/power/supply/adc-battery.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/adc-battery.yaml b/Documentation/devicetree/bindings/power/supply/adc-battery.yaml
> new file mode 100644
> index 000000000000..9d478bf9d2ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adc-battery.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/adc-battery.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADC battery
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: |
> +  Basic Battery, which only reports (in circuit) voltage and optionally
> +  current via an ADC channel.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: adc-battery
> +
> +  charged-gpios:
> +    description:
> +      GPIO which signals that the battery is fully charged.
> +    maxItems: 1
> +
> +  io-channels:
> +    minItems: 1
> +    maxItems: 3
> +
> +  io-channel-names:
> +    oneOf:
> +      - const: voltage
> +      - items:
> +          - const: voltage
> +          - enum:
> +              - current
> +              - power
> +      - items:
> +          - const: voltage
> +          - const: current
> +          - const: power

Good side of not knowing things is being able to asking for more 
information ;)

So, just by judging these bindings, we have a battery which provides 
fuel-gauge information via analog line connected to ADC(?)

Reading the description you have here and comments by Linus allows me to 
assume the line can represent current flowing out of the battery, or the 
battery voltage.

My guess then is that the io-channel-names property is going to tell 
which if these properties is being informed by the specific lines, 
right(?). Do you think you could add some small description for 
io-channel-names if you respin the series? I'd like to be more certain I 
"guessed" things right. ;) Maybe also add the 'power' option in the main 
description which currently just states voltage and power. (Assuming 
some devices do actually "expose" power levels via these "channels"?

> +
> +  monitored-battery: true
> +
> +required:
> +  - compatible
> +  - io-channels
> +  - io-channel-names
> +  - monitored-battery
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    fuel-gauge {
> +        compatible = "adc-battery";
> +        charged-gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
> +        io-channels = <&adc 13>, <&adc 37>;
> +        io-channel-names = "voltage", "current";
> +
> +        power-supplies = <&charger>;
> +        monitored-battery = <&battery>;
> +    };

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

