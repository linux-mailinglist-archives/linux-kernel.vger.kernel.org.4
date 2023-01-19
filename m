Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BE167368B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjASLSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASLSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:18:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24B6F895
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:18:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2821275wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Y/7gmhFhCAZgaW8XwXPZJxeQ167TuH5cJsnd9QCY0A=;
        b=Vtdvrj5mqGL5Qwyz7fZlW2SRUuyTH60A/JM+xN3FUpPJTBLokcSytP/QQ7Ng9YByVa
         OZseG7rOaETa3ijIc3tqjWwUBC/vHfSDvfyPTaiOoS2bg4iqfVKXERhiOYodXUyFFUmP
         w8L0aa44TrdKpioA8iBUkjIgat/VZU7sPWwRh7+NyuFPm9syfBtAfzqFVMURZV+0gYNu
         TYU5zi64UEb0bzXBCczqAloHvFzJROdg9CknZOMhyYm+RTBWCVyyOvqtFCOWJUMZv6KB
         BtszcMzNvSiNbe9Ubv8m+e7Jpv65KP9a28w7VlmFWUk00wEwzA9ASL81QEvXS6JLq9Wn
         wBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y/7gmhFhCAZgaW8XwXPZJxeQ167TuH5cJsnd9QCY0A=;
        b=hckqkS/kQSu9KP1B9Z9rD4K+OfrkOl+6Uo5f/F9bHbS41bW9eMO0JW5L8izMmr8QlJ
         pFPP/JjjhIeTXHSsDBOYb8ITqmDSwXdN2+FQdG1zuLQjcC0Ndq/J0FNumVJH7DWstMJd
         g0YyhoQUJBW7ZRc9iU0C5l8i3tIurim21pVsN4UDIKyw8EF/9nd2THC9B+UEabF8nOot
         Mr76blimWWXhVjhD33zY1ThMjMtitiur4vtZ2C75ta1BXnlY9RxoXgvmqFuktr+4A5Cw
         5HcMrwt7azJo8WnpXI8D8bKdwquOvPTn9fMcXKIXDTXR7XEL1gqLK3t2Goa8LtLxeWtP
         xvuA==
X-Gm-Message-State: AFqh2kr5XuMVqw+SVmgcMsvZnLS7nJ+HI2M+CcDKRPwR3jzZ3mbEWDNC
        fSveTP7RWZR+rfNT7fp+//2YTA==
X-Google-Smtp-Source: AMrXdXsNLRE6TCmBw96DPdVTL/oG7el495vqcCnFNIL+CV051Rw93O1+XVUmqZkQ3fe6P4fxNDSUBg==
X-Received: by 2002:a05:600c:348f:b0:3db:742:cfe9 with SMTP id a15-20020a05600c348f00b003db0742cfe9mr9501898wmq.34.1674127089348;
        Thu, 19 Jan 2023 03:18:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b002bbb2d43f65sm30424666wrx.14.2023.01.19.03.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:18:08 -0800 (PST)
Message-ID: <d5ae4755-26df-f4e7-b69a-83d9431bfbee@linaro.org>
Date:   Thu, 19 Jan 2023 12:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v1 4/4] ASoC: dt-bindings: simple-card: create jack for
 aux_devs
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kernel@axis.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230118125226.333214-1-astrid.rost@axis.com>
 <20230118125226.333214-5-astrid.rost@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118125226.333214-5-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 13:52, Astrid Rost wrote:
> Add simple-card,aux-jack-types:
> Array of snd_jack_type to create jack-input-event for jack devices in
> aux-devs. If the setting is 0, the supported type of the device is used.
> A device which has the functions set_jack and get_jack_supported_type
> counts as jack device.

How a device can have "set_jack"? Isn't this part of code? Are you sure
you describe here hardware, not Linux driver behavior?

> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  .../bindings/sound/simple-card.yaml           | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index ed19899bc94b..2635b1c04fc9 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -199,6 +199,13 @@ properties:
>      maxItems: 1
>    simple-audio-card,mic-det-gpio:
>      maxItems: 1
> +  simple-audio-card,aux-jack-types:
> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"

Drop quotes.

> +    description: |
> +      Array of snd_jack_type to create jack-input-event for jack
> +      devices in aux-devs. If the setting is 0, the supported
> +      type of the device is used. A device which has the functions
> +      set_jack and get_jack_supported_type counts as jack device.

Same problems.

Additionally, if this is a type of aux-dev, then maybe it should be just
added as argument to aux-dev?

>  
>  patternProperties:
>    "^simple-audio-card,cpu(@[0-9a-f]+)?$":
> @@ -498,3 +505,31 @@ examples:
>              };
>          };
>      };
> +#--------------------
> +# Add a headphone and a headset mic jack,
> +# which use an auxiliary jack detector e.g. via i2c.
> +# The events, which should be enabled are:
> +# SND_JACK_HEADPHONE = 1
> +# SND_JACK_MICROPHONE = 2
> +#--------------------

No new examples, integrate it into some existing one.

> +    sound {
> +        compatible = "simple-audio-card";
> +        simple-audio-card,widgets =
> +            "Headphone", "Headphone Jack",
> +            "Headset Mic", "Headset Mic Jack";
> +        simple-audio-card,routing =
> +            "Headphone Jack", "HPLEFT",
> +            "Headphone Jack", "HPRIGHT",
> +            "LEFTIN", "Headset Mic",
> +            "RIGHTIN", "Headset Mic";
> +        simple-audio-card,aux-devs = <&hp_jack>, <&hs_mic_jack>;
> +        simple-audio-card,aux-jack-types = <1 2>;
> +        simple-audio-card,cpu {
> +            sound-dai = <&ssi2>;
> +        };
> +        simple-audio-card,codec {
> +            sound-dai = <&codec>;
> +            clocks = <&clocks>;
> +        };
> +    };

Best regards,
Krzysztof

