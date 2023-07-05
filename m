Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548487480B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGEJUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGEJU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:20:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC71DD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:20:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991fe70f21bso753649466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688548819; x=1691140819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BklEsHObd9lavchnm/4o+Pr3bOXNI+WG9VrYnDlfX7o=;
        b=EQeZouLRROqNhu91gJoDc7GAUq2uokA65yYUzgJNMk7xsGU/qBnXfF5M9jhB4Q1M4Y
         Mbh0jto9tJqsCxHAr/CxCiD/nRQCRpB2LppPA/aizWlfVr5/oWsDWhAkPF+qTXhQaWYe
         1vcQz8I07zXB0h49fw8VjjGeWkiD/Iq9vHpUPuYOdML/Ek1L9o7/myTN2MmV7l24NWvJ
         /yZ7RmYgmzxpCyvh4bG32p/T3Zj/HS2N1nDYmUCCaBv+yiMGaKiKQrRcmVobaGkrPIms
         k9CtXajXnQmlWZsKmVRBkwC3Ep2UaeOXIXNZv4dGgpNEWNAyvevLGGHcAUUOX7fv3Kd2
         /hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548819; x=1691140819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BklEsHObd9lavchnm/4o+Pr3bOXNI+WG9VrYnDlfX7o=;
        b=WgBOSve/8v+2aRPv0cHHkAck66f0yO0vSpZRADDY22OJJIxncLSHN870NPn1litgCS
         m8Nm5AwJvDpLJXkPowLIA2K0/Ujh2cyFzAE7PTwaBnHKN6vx7bFjiM0JBt2+IvLv1Oo4
         GB6ZRBkNwYgm8MOyWymnBQlxhuhKo+NE6QE4m9r/soTW5HAiBxFDH+ezoe/cPp/zkOgv
         N46NWNw6PMhGmI70hYllCbf6iv38oysqZSKOi8rqa2zaryiPjN30oBdM+ehFChzeon1B
         wwh2b9aJn/TWHMqoP9I6MAZBVfYHd6mi9x7BLTgg+9AlcnIDmTE5oJ4Dumnffg3sh8F7
         aSdg==
X-Gm-Message-State: ABy/qLYP/N21n/6uzPlozpU7uxS+6SpLWjr4bityvg6H9DfXtK0/Pu/Z
        yYOCezPV46j5bCj6lkVkr+LUexiinDaD9pg/vgY=
X-Google-Smtp-Source: APBJJlGUR6tdUIBs1Ggtp7BC+0WhkW9OOgzEC1K0guvcFh3QVyRQqIOjQG5pDHe0ySWPCgMprM+v+Q==
X-Received: by 2002:a17:907:2ce6:b0:965:6075:d0e1 with SMTP id hz6-20020a1709072ce600b009656075d0e1mr13807518ejc.72.1688548818868;
        Wed, 05 Jul 2023 02:20:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906c01500b009929ab17bdfsm8735573ejz.168.2023.07.05.02.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:20:18 -0700 (PDT)
Message-ID: <2923201f-8bf4-a55d-a033-28ae5e569466@linaro.org>
Date:   Wed, 5 Jul 2023 11:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 1/1] regulator: Add awinic,aw3750x.yaml
Content-Language: en-US
To:     like@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     liweilei@awinic.com, liangdong@awinic.com, yijiangtao@awinic.com
References: <20230705081942.2608531-1-like@awinic.com>
 <20230705081942.2608531-2-like@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705081942.2608531-2-like@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 10:19, like@awinic.com wrote:
> From: Ke Li <like@awinic.com>

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Missing commit msg.

> 
> Signed-off-by: Ke Li <like@awinic.com>
> ---
>  .../bindings/regulator/awinic,aw3750x.yaml    | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw3750x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/awinic,aw3750x.yaml b/Documentation/devicetree/bindings/regulator/awinic,aw3750x.yaml
> new file mode 100644
> index 000000000000..cdb3d9dbf88f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/awinic,aw3750x.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license.

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/awinic,aw3750x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic AW3750X Power Management IC
> +
> +maintainers:
> +  - Weidong Wang <wangweidong.a@awinic.com>
> +  - Ke Li <like@awinic.com>
> +
> +description: |
> +  AW3750X is designed to generate both positive and negative bias voltages for.
> +  TFT-LCD panels or other general dual-supply applications. It consists a highly
> +  integrated synchronous boost converter with input voltage from 2.7V to 5.5V.
> +
> +properties:
> +  compatible:
> +    const: awinic,aw3750x_led

I don't understand why there is _led suffix. Isn't this regulator? Can
it be anything else?

Also, x looks like a wildcard, which is not allowed in compatibles.

> +
> +  enp:
> +    type: object
> +    $ref: regulator.yaml#
> +    description:
> +      Properties for single LDO regulator.
> +
> +    properties:
> +      regulator-name: true

Drop

> +
> +    required:
> +      - regulator-name

Is it really required?

> +
> +    unevaluatedProperties: false
> +
> +  enn:
> +    type: object
> +    $ref: regulator.yaml#
> +    description:
> +      Properties for single BOOST regulator.
> +
> +    properties:
> +      regulator-name: true
> +
> +    required:
> +      - regulator-name
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - enp
> +  - enn
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/pinctrl/mt8186-pinfunc.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    pio: pinctrl@10005000 {
> +      aw_enn_default: aw_enn_default {
> +        pins_cmd_dat {
> +          pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
> +          slew-rate = <1>;
> +          output-low;
> +        };
> +      };
> +
> +      aw_enn_output_high: aw_enn_output_high {
> +        pins_cmd_dat {
> +          pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
> +          slew-rate = <1>;
> +          output-high;
> +        };
> +      };
> +
> +      aw_enn_output_low: aw_enn_output_low {
> +        pins_cmd_dat {
> +          pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
> +          slew-rate = <1>;
> +          output-low;
> +        };
> +      };
> +
> +      aw_enp_default: aw_enp_default {
> +        pins_cmd_dat {
> +          pinmux = <PINMUX_GPIO1__FUNC_GPIO1>;
> +          slew-rate = <1>;
> +          output-low;
> +        };
> +      };

All this is incorrect and unrelated. Drop it.

> +
> +      aw_enp_output_high: aw_enp_output_high {
> +        pins_cmd_dat {
> +          pinmux = <PINMUX_GPIO1__FUNC_GPIO1>;
> +          slew-rate = <1>;
> +          output-high;
> +        };
> +      };
> +
> +      aw_enp_output_low: aw_enp_output_low {
> +        pins_cmd_dat {
> +          pinmux = <PINMUX_GPIO1__FUNC_GPIO1>;
> +          slew-rate = <1>;
> +          output-low;
> +        };
> +      };
> +
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        aw3750x@3e {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "awinic,aw3750x_led";
> +            aw3750x_gpio_ctrl = <0>;
> +            reg = <0x3e>;
> +            outp = <0x0E>;
> +            outn = <0x0E>;
> +            enn-gpio = <&pio 7 0>;
> +            enp-gpio = <&pio 1 0>;

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> +            pinctrl-names = "aw_enn_default", "aw_enn_output_high",
> +                            "aw_enn_output_low", "aw_enp_default",
> +                            "aw_enp_output_high", "aw_enp_output_low";
> +            pinctrl-0 = <&aw_enn_default>;
> +            pinctrl-1 = <&aw_enn_output_high>;
> +            pinctrl-2 = <&aw_enn_output_low>;
> +            pinctrl-3 = <&aw_enp_default>;
> +            pinctrl-4 = <&aw_enp_output_high>;
> +            pinctrl-5 = <&aw_enp_output_low>;
> +
> +            aw_lcdb_outp_vreg: enp {
> +              label = "outp";

Really?


Best regards,
Krzysztof

