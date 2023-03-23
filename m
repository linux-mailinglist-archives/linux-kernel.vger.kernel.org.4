Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32AE6C6C07
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjCWPPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjCWPPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:15:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9BE1043F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:15:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b20so55125222edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679584506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T0EIRlor9wN9UbhWdsh79YHQkDroJAzuUdmd2X+qriQ=;
        b=a9yJXmVYDeK0NwIHu2IpvL74NnIG0899faHFGDMQlG8vSHbEOejUzIgt0eogbaoQiU
         hlLIpsoKk6glSaVvbIf+Yj12Z6ycPS6erte8U77kqVNLYSVW/XRMb+4Qx33/gxDnknr2
         dZIKgEEdP6APYawwVA0zOJCj0/oAhGazZ+ELnvidtKXj57Xwf2anyencQLxMpcDBtVlZ
         LCDTVcJCpLDA79ilaf9E5z1hXRQOczmxdA2U8Hd+tlZ522QkWp1+cEpRozgb3Pmdq5i/
         Q2eOGz89jQ1AHUNUgFL7FN2Hel1yuoS26IZhfm/m3ibo2OnWzIe1zK8PxNQMAO42oYCj
         C5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679584506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0EIRlor9wN9UbhWdsh79YHQkDroJAzuUdmd2X+qriQ=;
        b=GQ1lD9/WX5RtTGG/jK9LBV0UXSPGChDKDmp20onsYVM0kBMAZlYemcZxjdMkPGudqa
         w2meTVO4ZwOwdFn6t9g/d6b8sylGnaW2cKCRTXSc6AfDmRuauNB3TwFVpUkkJiHDMFj8
         grkFEBdfQIxfsHJXAjWoW/wFSwBJFYX6RFM0BQrfUy//JwtK+RDL3PSXkpwyh6eI5uMT
         Ztj6DADerC5j3b0lr5hp2jj1p4RhWjmIgW09q1GyNqhuAzCsRrJDaKVhWFZRFpj8yy+u
         mCUkqwpgT0HrYxdIMjUbUtv2gPLUL28s40ksyZ6uDi0uZNQwGrjiUOyQ+m0xv9Gspd01
         og7Q==
X-Gm-Message-State: AO0yUKWeFCaam9/hd/EBJjaF3LXxjeE48/3Wm15H3qo+bV9ubzi0nzqc
        +uNzpZNQ7Fl1a23jnOT+1gHL2A==
X-Google-Smtp-Source: AK7set8gtYX838jmT3vkdbM6ajyzGH8Lai6OGJWibken05c+x+1ZWKC1tz/RH7h9iUeekgQDHZHt3g==
X-Received: by 2002:a17:906:28c9:b0:934:8043:ebf8 with SMTP id p9-20020a17090628c900b009348043ebf8mr10909795ejd.26.1679584506221;
        Thu, 23 Mar 2023 08:15:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d350:23b1:cb94:f39d? ([2a02:810d:15c0:828:d350:23b1:cb94:f39d])
        by smtp.gmail.com with ESMTPSA id gz14-20020a170906f2ce00b00923221f4062sm8777740ejb.112.2023.03.23.08.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 08:15:05 -0700 (PDT)
Message-ID: <1a2e0f7a-771f-5590-fc54-b9dbf059a925@linaro.org>
Date:   Thu, 23 Mar 2023 16:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: alc5632: Convert to dtschema
To:     Saalim Quadri <danascape@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230323130511.16367-1-danascape@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323130511.16367-1-danascape@gmail.com>
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

On 23/03/2023 14:05, Saalim Quadri wrote:
> Convert the ALC5632 audio codec bindings to DT schema.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>


Thank you for your patch. There is something to discuss/improve.


> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/realtek,alc5632.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ALC5632 audio CODEC
> +
> +description: |
> +  Pins on the device (for linking into audio routes):
> +      * SPK_OUTP
> +      * SPK_OUTN
> +      * HP_OUT_L
> +      * HP_OUT_R
> +      * AUX_OUT_P
> +      * AUX_OUT_N
> +      * LINE_IN_L
> +      * LINE_IN_R
> +      * PHONE_P
> +      * PHONE_N
> +      * MIC1_P
> +      * MIC1_N
> +      * MIC2_P
> +      * MIC2_N
> +      * MICBIAS1
> +      * DMICDAT
> +
> +maintainers:
> +  - Liam Girdwood <lgirdwood@gmail.com>

This should not be subsystem maintainer but someone related to the
device. It's maintainer or interested contributor. Unless that's the
case here?

> +
> +properties:
> +  compatible:
> +    const: realtek,alc5632
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-controller: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#gpio-cells'
> +  - gpio-controller
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        alc5632: alc5632@1a {

Node name: codec
and drop alc5632 label

> +            compatible = "realtek,alc5632";
> +            reg = <0x1a>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +        };
> +    };

Best regards,
Krzysztof

