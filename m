Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA673BC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjFWQdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWQda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:33:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57E22114
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:33:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9786fc23505so78834766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687538007; x=1690130007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+1ixJV2FYmj+SoA0cV3gTRANTZOKE/jEW6S67bqJuk=;
        b=XxZa31d1ORlVsrrmdP58C3CyuRyekaw/LYrXsRM1RlTB+EbLl0xnuCPm1Id4Bbytqe
         lnazcYGbn3/qXj8gniE5qy7yQpxH6bmP9HFAaqTFbogHyzkzyJ6j7k7D6xhae4mrnj9u
         NAP9aIdheXlR4DXz9YR6q20dHYmlp6gr4p+ofygDy9GxNptyYCddhoC27qdj5oCU+2C3
         rbeVnjAb145Dq2TT+1eegK8r6snFRXoYv7fsp6vw1pHkdltLNmZQL2deaV65sqw9GBVB
         7PyksJKk1GTw3ynMTsXoTfOjO6kf9iysiPDz2FCM55k7CDHdCsE69dPaI/R5xP9/mOQZ
         g29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538007; x=1690130007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+1ixJV2FYmj+SoA0cV3gTRANTZOKE/jEW6S67bqJuk=;
        b=f8wm4LhOPJHWEK4wSVJv1uW5zzzmSXe9wpPvJaBl5msFGoFIn9YSSO7S0o3tQPIOvl
         WMQrEk8vQOo5wlRjzKeO6pN2y7kCvXxJP7g6uMwDW+rR2YnVPyBH3dCuCVbRGO4NElyh
         KvOYNLTGgosT5y+zHEyGEp5gYX8F4fcgeToAdexLrdSWfdlMKpHzeMR/dD0VnL+3Or9Q
         b7v+tzlcOgZoDPu93Ul/uklDPz+9BRFByVI5nBidCDVsxcDL2lQH5mRXCHkv7V/UDNi5
         OVCKH9OfkoTZetfC/yZoFnk+zWyj5tCsy5u+UNsY/oCZ3mCzziliO4M7omBd0mCXPojl
         48Hg==
X-Gm-Message-State: AC+VfDz/g4znu72Eo1AlbYm3dm++YaF3aVs4Hh+qPHFcxsn4aWJdP/TM
        DwaZ1AKn8YDeQoQPnj6ktFyaiQ==
X-Google-Smtp-Source: ACHHUZ5Sm8pZbl0baYUGugIGtVPSSYfHmWwbJvqIMXKaivS52KQEH2NwX0y29m0cH+LRZ94VIhhO6w==
X-Received: by 2002:a17:907:934e:b0:989:5d0:3189 with SMTP id bv14-20020a170907934e00b0098905d03189mr13163559ejc.33.1687538006857;
        Fri, 23 Jun 2023 09:33:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709064c4100b0096f7cf96525sm6245528ejw.146.2023.06.23.09.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:33:26 -0700 (PDT)
Message-ID: <d962285e-b3f0-6225-316c-39a7d16808cd@linaro.org>
Date:   Fri, 23 Jun 2023 18:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Content-Language: en-US
To:     Aleksandr Shubin <privatesub2@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
References: <20230623150012.1201552-1-privatesub2@gmail.com>
 <20230623150012.1201552-2-privatesub2@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623150012.1201552-2-privatesub2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 16:59, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> controller witch is different from the previous pwm-sun4i.
> 
> The D1 and T113 are identical in terms of peripherals,
> they differ only in the architecture of the CPU core, and
> even share the majority of their DT. Because of that,
> using the same compatible makes sense.
> The R329 is a different SoC though, and should have
> a different compatible string added, especially as there
> is a difference in the number of channels.
> 
> D1 and T113s SoCs have one PWM controller with 8 channels.
> R329 SoC has two PWM controllers in both power domains, one of
> them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> 
> Add a device tree binding for them.
> 
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> new file mode 100644
> index 000000000000..eec9d1dd67c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner D1, T113-S3 and R329 PWM
> +
> +maintainers:
> +  - Aleksandr Shubin <privatesub2@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: allwinner,sun20i-d1-pwm
> +      - items:
> +          - const: allwinner,sun20i-r329-pwm
> +          - const: allwinner,sun20i-d1-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  clocks:
> +    items:
> +      - description: 24 MHz oscillator
> +      - description: Bus Clock
> +
> +  clock-names:
> +    items:
> +      - const: hosc
> +      - const: bus
> +
> +  resets:
> +    maxItems: 1
> +    description: module reset
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun20i-r329-pwm
> +
> +    then:
> +      properties:
> +        allwinner,pwm-channels:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description: The number of PWM channels configured for this instance
> +          enum: [6, 9]
> +

Your DTS says this is 8, so you did not test it. Why do you need it in
the first place? r329 can have both 6 and 9?

Anyway, this won't work with additionalProperties, which you would see
with testing. Don't define properties in allOf. Also switch to
unevaluatedProperties: false.

Best regards,
Krzysztof

