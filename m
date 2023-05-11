Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E56FEF82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbjEKJ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbjEKJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:58:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B839FA6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:58:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso307740966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683799102; x=1686391102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flwRxznwuAYel95+sMOhYZaxHDjgAMi12wSldhudZkk=;
        b=wLUiy/sKdDyW2vYY1KUBQMZM2bNv7qMq5opS7jaQ39UXL7gYULX908NBz3Hssa3xZF
         6ct6KCJ6yomPIW6+oJhk6JvsHZAn2zKNPXHjFdtu8+CCyymdKdpgyrUSRfzbJgAasTn/
         aIhMxdO8fCEFyFg0SIfZBeeZ9iJ6NebnfRppUNhE/E1zek0CZyLBKyMbfQRRHhiwBkgr
         +LtRfn6rUetGYiJR6QOvyVd+qHMhJhpHuLDPj7qOb/WB55KEDAWK0+s7AeuxNTuk04GU
         b6Mxk58Z4nld3bpw4UYSjjQ1fzllwXfmroMbUxtaVfAmD6N87EvB89E4/RON0D6UyKrz
         /3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683799102; x=1686391102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flwRxznwuAYel95+sMOhYZaxHDjgAMi12wSldhudZkk=;
        b=aXv6Cw3S98AZbjhAb3jhQdF6gvqO+lG3953cJN8FUPwtANbCAmv9AkY99GEuazWG7X
         35pQlftx/luq173KgzT1OrHp5TR3aXuME2cMxEkL4dtA6S5LDZN3DxaxMwFQItc3ErHh
         VzlPCV13BbV9uP0NYs9Dep78mkgY/cCv+lFiEqguYSj+tUVwv3mzbnrFc1OInbFlg6xq
         J6HHs6+QsyyRccmrF952B1yBbCWOBKQdl4H5vpUTkDBJGvvCCN7KjAuctU4+1WbpIO2/
         Q/EtIAlOQWLIg/k+AAHljP1WwdQIgVNBlkaUUh94MjhuHWOZM1DYvG6/hUkrvCe40dfU
         0PiQ==
X-Gm-Message-State: AC+VfDzCKIya23U8IbarvVgXIsuuSXKUw2SyHgo3bwzE+Kb5xPdS/gda
        82bvyQRmGwZcSloZ2JBKRiQJfw==
X-Google-Smtp-Source: ACHHUZ5wJWqqCfcn013dbmOg6eTV075b5HIvRHopoYyZNADruM2+gIsxKZuktXAltFCkeuOiblIu8Q==
X-Received: by 2002:a17:907:6eaa:b0:94a:9ae2:1642 with SMTP id sh42-20020a1709076eaa00b0094a9ae21642mr21040424ejc.46.1683799102132;
        Thu, 11 May 2023 02:58:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906300d00b009659cdb2f98sm3739111ejz.23.2023.05.11.02.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:58:21 -0700 (PDT)
Message-ID: <7b3a37e8-0210-c539-5b5b-bf8e587707ea@linaro.org>
Date:   Thu, 11 May 2023 11:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 3/3] dt-bindings: ASoC: Add ESS ES9218P codec bindings
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230510112349.939991-1-aidanmacdonald.0x0@gmail.com>
 <20230510112349.939991-3-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510112349.939991-3-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 13:23, Aidan MacDonald wrote:
> Device tree bindings for the ESS ES9218P codec, which uses an
> I2C control interface.
> 

Thank you for your patch. There is something to discuss/improve.

Subject: reverse dt-bindings and ASoC.

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/sound/ess,es9218p.yaml           | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ess,es9218p.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ess,es9218p.yaml b/Documentation/devicetree/bindings/sound/ess,es9218p.yaml
> new file mode 100644
> index 000000000000..d205b6a8bbb2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ess,es9218p.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ess,es9218p.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ESS ES9218P audio codec
> +
> +maintainers:
> +  - Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> +

allOf with ref to dai-common.

> +properties:
> +  compatible:
> +    const: ess,es9218p
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  avdd-supply:
> +    description:
> +      Definition of the regulator used for digital core power supply.

Drop "Definition of the regulator used for"

> +
> +  vcca-supply:
> +    description:
> +      Definition of the regulator used for oscillator and DAC power supply.
> +

Ditto

> +  avcc3v3-supply:
> +    description:
> +      Definition of the 3.3V regulator for amplifier, switch, and charge pumps.

Drop "Definition of"


> +
> +  avcc1v8-supply:
> +    description:
> +      Definition of the 1.8V regulator for amplifier, switch, and charge pumps.

Ditto

> +
> +  clocks:
> +    items:
> +      - description: clock for master clock (MCLK)
> +
> +  clock-names:
> +    items:
> +      - const: mclk

Drop entire names, not really useful.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      Pin used for codec hardware reset, corresponds to the RESETB pin.
> +
> +  ess,max-clock-div:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Sets the maximum MCLK divider for generating the internal CLK.
> +      CLK must be at least 20x the I2C bus speed or I2C transactions
> +      will fail. The maximum divider should be chosen to ensure that
> +      CLK will not fall below the limit.
> +    enum:
> +      - 1
> +      - 2
> +      - 4
> +      - 8
> +    default: 1

Why do you need to customize it per board?

> +
> +  ess,oscillator-pad-bias:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Sets the oscillator pad drive bias. 0 - full bias, 15 - disabled.
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#sound-dai-cells"
> +  - avdd-supply
> +  - vcca-supply
> +  - avcc3v3-supply
> +  - avcc1v8-supply
> +  - clocks
> +  - clock-names
> +  - reset-gpios
> +
> +additionalProperties: false

Instead: unevaluatedProperties: false


> +
> +examples:

Best regards,
Krzysztof

