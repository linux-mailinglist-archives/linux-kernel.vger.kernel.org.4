Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF86459D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLGMbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiLGMbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:31:37 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B2C4EC04
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:31:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g7so28491251lfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 04:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1GOf3uEYk8gTP9XDz9QwwuKudeT3AfYAf9a/Xk700A=;
        b=P7t6NaUWtotLXSAGzeYK7qYNyTh2B/hx31CNgaQresmr3i/q0/RKP+a2WJCEEihW9s
         I/KwIk3MtOymKoVE2Huxz3knCMmsAC1oxWJhdTGjXSvqhhaFfhVNoPsFLDjjAIu1Getd
         yWqmuD5q3dcyecG/cjx4gACfebiE5DGJQvL9yaXdlT49yjhZ/0IF5fB+1QbZbvifSFOL
         tOJCi/KjzG5WqNmzyyW+5WIL1WJqkHZM8Yf3BRfT+6tGQecC0hSACGE5mGIEJg8ndLq7
         EXc1U8k6e5kTKvg/ohhY36eJnKEgWam0ahTWW9FOgleOlgXQIp/srLnqcUxlVUuun/eb
         cWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1GOf3uEYk8gTP9XDz9QwwuKudeT3AfYAf9a/Xk700A=;
        b=4GTovsiE734LIfSwQ+skQn1Sv72HrM1x5voa9e8PsP8VjNAlZDym+eg7QqaMx9vz5/
         owqUZUiSOCb33jFhgkofEsFBR9SG3yYLcbP51uOODZa5dh2L/qCaHqmwn9FN0Tql7ktw
         lbvTjLX7zFD0xtVOY8DEt+tSiSMMQyguH4MMm/B+ClUeNCtDQvU9ByTRRY2RPkZQl6dW
         OkUL5X6m1MgLSABIUXTZAoe31NY+e6Uumoo3AyH8SfO+Qtq9zUAu5XRXk+KhAdewHK2p
         y7cgD8pezJSKZ+0YZyd5q88J2NOOcBCOtqN4EHp7j/cwWrdfVWD41pGpvtujj7UAUDN7
         pyqg==
X-Gm-Message-State: ANoB5pmyI5NHV9UDFYWp8BMh6nyt3ROKo1VY6KKXyk4Hn8vgjEupuxJu
        RNST/12oy8ibPO2lR9uWT6sCwg==
X-Google-Smtp-Source: AA0mqf7Ipmnr9eW6KJgrSxw94wK1rZlICewLntr4O6muD0J4UwxoJ73JVR1oT8JeaJBIG01l4gvxEg==
X-Received: by 2002:a05:6512:150:b0:4ae:6c29:d043 with SMTP id m16-20020a056512015000b004ae6c29d043mr26776442lfo.474.1670416294784;
        Wed, 07 Dec 2022 04:31:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o18-20020a05651205d200b004b5323639d8sm2823837lfo.155.2022.12.07.04.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 04:31:34 -0800 (PST)
Message-ID: <48d60bd0-4de1-4a5e-eca1-1f8a9303cce0@linaro.org>
Date:   Wed, 7 Dec 2022 13:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 5/6] dt-bindings: media: wave5: add yaml devicetree
 bindings
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@collabora.com, bob.beckett@collabora.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        nas.chung@chipsnmedia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
 <20221207121350.66217-6-sebastian.fricke@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207121350.66217-6-sebastian.fricke@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 13:13, Sebastian Fricke wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> Add bindings for the wave5 chips&media codec driver
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

What's happening with this patch? Where is the changelog? Why it is v11
and first time I see it? And why it is v11 with basic mistakes and lack
of testing?!? I would assume that v11 was already seen and tested...


> ---
>  .../devicetree/bindings/cnm,wave5.yml         | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cnm,wave5.yml

Wrong directory. It wasn't here at all before, so I am really confused
how this could happen.

Subject: drop redundant pieces: yaml, devicetree and bindings.


> 
> diff --git a/Documentation/devicetree/bindings/cnm,wave5.yml b/Documentation/devicetree/bindings/cnm,wave5.yml
> new file mode 100644
> index 000000000000..01dddebb162e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cnm,wave5.yml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/wave5.yaml#

You clearly did not test them before sending.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Chips&Media Wave 5 Series multi-standard codec IP
> +
> +maintainers:
> +  - Nas Chung <nas.chung@chipsnmedia.com>
> +  - Robert Beckett <bob.beckett@collabora.com>
> +  - Sebastian Fricke <sebastian.fricke@collabora.com>
> +
> +description: |-
> +  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
> +
> +properties:
> +  compatible:
> +    anyOf:

Please start from example-schema or other recently approved bindings. No
anyOf.

> +      - items:

No items...

> +        - enum:
> +            - cnm,cm511-vpu
> +            - cnm,cm517-vpu
> +            - cnm,cm521-vpu
> +            - cnm,cm521c-vpu
> +            - cnm,cm521c-dual-vpu

What's the difference between this and one above?

> +            - cnm,cm521e1-vpu
> +            - cnm,cm537-vpu
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4

This has to be specific.

> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4

You need to list the names.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  sram:

Missing vendor prefix.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle pointing to the SRAM device node

And what is it for? Why do you need SRAM?

> +    maxItems: 1

Drop

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    vpu: video-codec@12345678 {
> +        compatible = "cnm,cm521-vpu";
> +        reg = <0x12345678 0x1000>;
> +        interrupts = <42>;
> +        clocks = <&clks 42>;
> +        clock-names = "vcodec";
> +        sram = <&sram>;
> +    };

Best regards,
Krzysztof

