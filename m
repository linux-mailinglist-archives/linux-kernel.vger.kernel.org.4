Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960756DA0E2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbjDFTR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbjDFTRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:17:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E0F4C3C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:17:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g18so3839710ejj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680808640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ijzbpgNtHL1RkS2L+qjoGrMwmwbEWamTYTlNJO92bs=;
        b=Ea8n0AeuLrtRFB9IE3jNr3iYzxG4XpMsZIQ1il+1u7bTA6ANlawJvRJ1fnD6PVmVfk
         AY3fBR/uI7rfX7joRBJ4jHyR5nvtOfgKgRnzqz/JlL82ReVA85m/n/rX47lfZjqk0P2I
         7mC8Q4H804wmbI/QcMUxKmSP4vQmwafISdzph7ZySbQ8A7w+Yu+Yfkbo9gcrddWBqNdb
         y9N0b2f0t6+QePuscOelHl1iE8aKAZo43+bUz8xUTE8Di+vMStfbGSgS0a0Zf52AyNGN
         dXqZQc8ZeAWmemuZUs7Z4R8+hqLHW0By9N6T+3vrDF8fFMsnTUybR0oocjLey//uGApm
         SmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680808640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ijzbpgNtHL1RkS2L+qjoGrMwmwbEWamTYTlNJO92bs=;
        b=wKvCNMMYEjLrpP/O7trGrHEEvPTnxUZlQCVAxHMUjksSoiVrAWEQSUERUHRnM8bnDq
         bAlWUfcK9T2Dd9Iz+zEzolGRkq6zHGCO/aWzb79oNlFO8RSNq520xqlrs+Pqeu9amZUV
         phM2Kdia6JdAqjmoOLtgGq3w31qNiMwzT5UOwRZ5EObZRskdqbQVeOmbVLWxBw/ztL2y
         OVevLjsJR6QtEMWy+RYWu7QvIBwh2rfwNy3bo31MgGp4Fwa2yl9kbnCttjXVjHLg7e2e
         csSdHsV2MvAV83WyylvUXwMDmoAkeYyRerZmoTaA3btCaPn3N1bZK6RoL+hZ+PyyAMAo
         i/hA==
X-Gm-Message-State: AAQBX9eYkxwNZ/tJ1XLvRDJUZGKICo2vCtq+kr3YFIoIq1RFfzNkkT1a
        ZEjXeGehMkEFg8SpERznr9+0PQ==
X-Google-Smtp-Source: AKy350b1Xq0EzRAX6tJKE72sTgus/SxFTbGctJTqPR9I03mw5W3opdbMHFF7WuJ33Uw7DbuVPdiSWA==
X-Received: by 2002:a17:907:c24d:b0:949:b9fa:497a with SMTP id tj13-20020a170907c24d00b00949b9fa497amr3017624ejc.70.1680808639713;
        Thu, 06 Apr 2023 12:17:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id hr15-20020a1709073f8f00b009477ba90a85sm1155808ejc.69.2023.04.06.12.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:17:19 -0700 (PDT)
Message-ID: <2d8d417d-0a0b-9a45-a8e0-a3cb116874e5@linaro.org>
Date:   Thu, 6 Apr 2023 21:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add MAX31827
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        "Greg.Schwendimann@infineon.com" <Greg.Schwendimann@infineon.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406164331.6557-1-daniel.matyas@analog.com>
 <20230406164331.6557-2-daniel.matyas@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406164331.6557-2-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 18:43, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.
> 
> The device is a ±1°C accuracy from -40°C to +125°C
> (12 bits) local temperature switch and sensor with I2C/SM-
> Bus interface. The combination of small 6-bump wafer-lev-
> el package (WLP) and high accuracy makes this temper-
> ature sensor/switch ideal for a wide range of applications.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>  .../bindings/hwmon/adi,max31827.yaml          | 48 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 +
>  MAINTAINERS                                   |  7 +++

>  3 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> new file mode 100644
> index 000000000000..b6ed2d46a35d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,max31827.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX31827, MAX31828, MAX31829 Low-Power Temperature Switch

Where are the compatibles? I expect them in such case to be compatible
with this 31827.

> +
> +maintainers:
> +  - Daniel Matyas <daniel.matyas@analog.com>
> +
> +description: |
> +  Analog Devices MAX31827, MAX31828, MAX31829 Low-Power Temperature Switch with
> +  I2C Interface
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31827-MAX31829.pdf

Missing blank line

> +properties:
> +  compatible:
> +    enum:
> +      - adi,max31827
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      Must have values in the interval (1.6V; 3.6V) in order for the device to
> +      function correctly.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        status = "okay";

Drop status

> +        max31827: max31827@42 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Drop also label. You do not use it.


> +            compatible = "adi,max31827";
> +            reg = <0x42>;
> +            vref-supply = <&reg_vdd>;
> +        };
> +    };
> +...
> \ No newline at end of file

Patch error to fix.

> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 6f482a254a1d..7763610b97bc 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -43,6 +43,8 @@ properties:
>            - adi,adp5589
>              # Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher
>            - adi,lt7182s
> +            # MAX31827 Low-Power Temperature Switch with I2C interface
> +          - adi,max31827

No need for this.

Best regards,
Krzysztof

