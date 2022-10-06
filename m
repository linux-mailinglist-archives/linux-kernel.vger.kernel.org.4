Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD7B5F64E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiJFLJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiJFLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:09:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4A59B875
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:09:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f9so1783790ljk.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oSwQHAbZbNwtUkxLe3eMYZC+tGj9k+iujF/sOCF9CJA=;
        b=Tau9z0EzEemX7HCD/owFbmkmGdHSWdR2GXMN01Pq8WD79wwfGZUUvfWdoDorqeKlmh
         STn52wy++sn5LU1hFv0rTb34wPaqHRMXaivhDVNlcNI2ys03njv3Pz8ZibEeN8FtiS0V
         qWBk1etdgukbW2f2r7XMM8LPpimVLULhngSZ8zBxqxNqpd37/u99toxFKpqCxeGYkdeH
         03Lx2D90irWUd9+gwnrWZ6YTZJ/lj4AkFAfjH7owXtlhyDIlFSPYlKkiibzV3kR2qq5l
         G5xx+DJpeE8YVuJK0vNXKj+GiKNbi38wlReyYlk1DuR35JdcPsarF3trF1/KuN+7MOKK
         WEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oSwQHAbZbNwtUkxLe3eMYZC+tGj9k+iujF/sOCF9CJA=;
        b=iDrAqFmGUxawfDXM3zleV+LTn8pBGedZSMmQUuvRKhudcGjik2LZF0pWNQ7iSUcTAj
         aX5XP6tqKG247gfOaVWM7Zjxxt1dXPoV0/QVVnKAQQnEF7Mw/wBjuKmZ/7lxwepDL8h5
         PKsM1r45Yl4AI2+gZ/a/sK31E7PWgvyGUkK66F89aMmPbdFC45mVbveLrCLDbHaU/c7Q
         /jf/t4Vklgq47aHCenOt+vmJqIhWKQhA7BbrLoNGmPeNXglKBdztp0+bD5rMoQNycbrJ
         +alsB2BgQEMvUh9bHSg1HJAooUmhhw+KFGrOQh0MLxDN9RKwYfw8nT+xNy45XjG0+LGR
         wX9Q==
X-Gm-Message-State: ACrzQf0I6Y5T33sbnmFBNiCRHcW0dADuo75r4vNOrbaPLuyDhOwzvyec
        bNsbub+jgiNHoycofYWfynunxA==
X-Google-Smtp-Source: AMsMyM4kF91xOWQduw21qrOovrPo1fTjYY44G7Jsn/AvpxsUvItEagkCKICVBiqOgbBqFTMILIn/jQ==
X-Received: by 2002:a2e:3005:0:b0:26e:18b:f8d0 with SMTP id w5-20020a2e3005000000b0026e018bf8d0mr1237702ljw.451.1665054546334;
        Thu, 06 Oct 2022 04:09:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n18-20020a2e9052000000b0026acd11cd51sm1859817ljg.59.2022.10.06.04.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 04:09:06 -0700 (PDT)
Message-ID: <8213587e-681a-a948-42a6-2b1632b47ac0@linaro.org>
Date:   Thu, 6 Oct 2022 13:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: convert
 qcom,mdm9615-pinctrl.txt to dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v1-1-0cbc006e2a30@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-1-0cbc006e2a30@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 11:57, Neil Armstrong wrote:
> Convert the MDM9515 pinctrl bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ---------------------
>  .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 101 +++++++++++++
>  2 files changed, 101 insertions(+), 161 deletions(-)
> 

Thank you for your patch. There is something to discuss/improve.

> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
> new file mode 100644
> index 000000000000..6a5966fc0098
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,mdm9615-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. MDM9615 TLMM block
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description: |

No need for |

> +  This binding describes the Top Level Mode Multiplexer block found in the
> +  MDM9615 platform.

Instead: "Top Level Mode Multiplexer pin controller node in Qualcomm
MDM9615 SoC."

I see this pattern is coming from other file, so I will fix all of them.

> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"

Drop it, it's included from tlmm-common

> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,mdm9615-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  '#interrupt-cells': true
> +  gpio-controller: true
> +  '#gpio-cells': true
> +  gpio-ranges: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  '-state$':

Use " as quotes

> +    oneOf:
> +      - $ref: "#/$defs/qcom-mdm9615-pinctrl-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-mdm9615-pinctrl-state"
> +
> +'$defs':

No need for quotes

> +  qcom-mdm9615-pinctrl-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"

No need for quotes

> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-7][0-9]|8[0-7])$"

No sd-like functions? If so, then drop oneOf

> +        minItems: 1
> +        maxItems: 16
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +        enum: [ gpio, gsbi2_i2c, gsbi3, gsbi4, gsbi5_i2c, gsbi5_uart,
> +                sdc2, ebi2_lcdc, ps_hold, prim_audio, sec_audio, cdc_mclk, ]
> +
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      drive-strength: true
> +      output-high: true
> +      output-low: true
> +      input-enable: true
> +
> +    required:
> +      - pins
> +      - function
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        tlmm: pinctrl@1000000 {

Use 4 spaces indentation.

> +          compatible = "qcom,mdm9615-pinctrl";
> +          reg = <0x01000000 0x300000>;
> +          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +          gpio-controller;
> +          gpio-ranges = <&msmgpio 0 0 88>;
> +          #gpio-cells = <2>;
> +          interrupt-controller;
> +          #interrupt-cells = <2>;

Add example of -state with and without -pins node.

You dropped it with conversion.


> +        };
> 

Best regards,
Krzysztof

