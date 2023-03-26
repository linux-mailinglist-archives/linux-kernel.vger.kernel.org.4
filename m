Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB006C9382
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjCZJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjCZJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:27:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7510D0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:26:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so24218049edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679822817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VahlOo5KlwSRji1K/2qUnu3qE76o4itfuZQQxoCQsXQ=;
        b=PTa4unM2NVPnWXcwefj8aetMPoDppDQtgUbk6dZ0/ItkMDWynTY3hyV4rKF39NyJGN
         hVsPi2kX8sl8H5A4wF01rf6giIOf369UdEmH6XYwWmaek2VRY608qvfiio+X9ZQkZyBL
         oteYqq1LCp8kDzrY34yZXkxI2D/3P2v56nkGU8L/msN3rEHWuoYN2tKbHqIA///7rH0s
         UZBJFCzHPAF0yHStNjHc/a8nDgsYSC2J3s6n9Z5YpZBowy8tszYM6ZqfvK+twZmYGUDs
         2ofFN+bvgYr+6FDHQpsp/hJs47Kmsny1ZKlUAGSFlJ6wraHZ5WJL0e4SXKczq+x1R2ID
         QtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VahlOo5KlwSRji1K/2qUnu3qE76o4itfuZQQxoCQsXQ=;
        b=wMCtiVf8s2G3CbdMQOXGB2DUpDbcLXmUmNy8vos26d5/dHwMwR6qOHRWlZWt8DkcMm
         s0GaRuxTeTDxAlh8MSDSJegHaSRoC5SXEbB2kkGdH6eXhBRDx2WzY6j2dRcwv0GuvoGq
         8m94ZjBmk9LJZlhSMVzjFKuEF5/7TRR7xSyO2AFUL1y17EqQZppYAKk0YcY5a9vtxu9g
         f1/IBe+rb94n4Ra1Ed6Xg47Hf6X9MzugGl8Ch3j+TgMgdWyiI18HLN3Wt+8vAHrwo0/c
         EZATcppppzBG4E6qWOzHDCocCa0qE/jHjsMaBqLhTB5z/JYs9BDiqeUYKBBAjJAXqvlS
         7zIA==
X-Gm-Message-State: AAQBX9fedUftS/PGKxkzMDGYaFhJxu6iWCJuBTQ7ZhliCX7jMW3FyG8D
        mNdNec8SvBypSmXnQT3ww9q3EQ==
X-Google-Smtp-Source: AKy350aKep/8NAQS3ScZSU6WqB5Ppr/tKZPCLWKiF6NI2LIizmmJ0+03GiPNzUYSVh9U7ITxLM5Rlw==
X-Received: by 2002:a05:6402:2022:b0:4fd:2675:3785 with SMTP id ay2-20020a056402202200b004fd26753785mr9170207edb.22.1679822817074;
        Sun, 26 Mar 2023 02:26:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id u27-20020a50951b000000b004bf999f8e57sm13249082eda.19.2023.03.26.02.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 02:26:56 -0700 (PDT)
Message-ID: <4762f4a1-5e99-4e5a-72c0-9c4c61cdc856@linaro.org>
Date:   Sun, 26 Mar 2023 11:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: ak4458: Convert to dtschema
Content-Language: en-US
To:     Saalim Quadri <danascape@gmail.com>, shengjiu.wang@nxp.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230325201007.13006-1-danascape@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325201007.13006-1-danascape@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 21:10, Saalim Quadri wrote:
> Convert the AK4458 audio DAC bindings to DT schema.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
>  .../devicetree/bindings/sound/ak4458.txt      | 28 ---------
>  .../bindings/sound/asahi-kasei,ak4458.yaml    | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
> deleted file mode 100644
> index 0416c14895d6..000000000000
> --- a/Documentation/devicetree/bindings/sound/ak4458.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -AK4458 audio DAC
> -
> -This device supports I2C mode.
> -
> -Required properties:
> -
> -- compatible : "asahi-kasei,ak4458" or "asahi-kasei,ak4497"
> -- reg : The I2C address of the device for I2C
> -
> -Optional properties:
> -- reset-gpios: A GPIO specifier for the power down & reset pin
> -- mute-gpios: A GPIO specifier for the soft mute pin
> -- AVDD-supply: Analog power supply
> -- DVDD-supply: Digital power supply
> -- dsd-path: Select DSD input pins for ak4497
> -            0: select #16, #17, #19 pins
> -            1: select #3, #4, #5 pins
> -
> -Example:
> -
> -&i2c {
> -	ak4458: dac@10 {
> -		compatible = "asahi-kasei,ak4458";
> -		reg = <0x10>;
> -		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>
> -		mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
> new file mode 100644
> index 000000000000..b97aee96fa17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/asahi-kasei,ak4458.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AK4458 audio DAC
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - asahi-kasei,ak4458
> +      - asahi-kasei,ak4497
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: Analog power supply
> +
> +  dvdd-supply:
> +    description: Digital power supply
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  mute-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO used to mute all the outputs
> +
> +  dsd-path:
> +    description: Select DSD input pins for ak4497
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    oneOf:
> +      - const: 0
> +        description: select #16, #17, #19 pins
> +      - const: 1
> +        description: select #3, #4, #5 pins
> +
> +required:
> +  - compatible
> +  - reg
> +

Based on driver:

allOf:
  - if:
      properties:
        compatible:
          enum:
            - ak4458.....
  then:
    properties:
      dsd-path: false

> +additionalProperties: false
> +
Best regards,
Krzysztof

