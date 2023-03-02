Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF60D6A7C00
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCBHsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCBHsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:48:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036AB12048
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:48:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cw28so14878507edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 23:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677743308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWlPVf4Cit/dFQTQX4rrG7U8CqsA/gWMb6EuJUBZ534=;
        b=QobkjA9b1ZGNO4b8h98pR5ymuNOLoV5YnRVLGveeKTcec9nPi2oMVn7k8Zo3l22oau
         BUO/5qbFU1rpl9rF3W4IJuQzne6PxrHfrFPFUEDH3jqjfC8oHf/eyTwUCsDxm7+1snfl
         b1UOmFJl6yrlIWQ+dd534ZJPEVZG5VQCYowabB5N2NmMgDIlT5Habymt5t+3EUcbJVjL
         b5zIkLGfmsZAoaKVhIccBaUeMIDuZWBUI+6zooYaKB48CJ54n97+r5SdQe4HmniGKvWq
         mlyG+5csSdECgZaq9U5cx0nhBEySLXB/0Eb8KlzI6eBsScoET+jSnYG6kPMqAW7fFj4I
         vIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677743308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWlPVf4Cit/dFQTQX4rrG7U8CqsA/gWMb6EuJUBZ534=;
        b=etI8kPusOQuw8fMK9rQQgIKyoQGijfcnI5QxqsX7wNgJMbVeJ3mhhJoSIWRFZBZS9H
         B6IWZbEpub+GknnCKqocLtKfujXxVs7FTm0PuGhF6Fc2XxyLuQhzZ4HxUCTfmz2c4nWj
         +JvXwV9Gv/w6n0XZURmYjFk5JbH3ipnKAOacD/aUnmlpTLVjIZQGzM245C1Rq9Cz0QmF
         Py56TGgnucyWAl6KeGOQENJep+NbB6CvwPX/LaEL9WBZusNfYvLcNbgEeJPnURTsKnuj
         Mcucj1XLdSzu/xi9Ph/RI28IA0gQrBy3925oYGjXZ5iTpGxFWWlvDUHxfp6NicRwTKEq
         hIyA==
X-Gm-Message-State: AO0yUKW1b5OmEemnHrD4kf13WfmAyRB8R6w/IVRdCNtZHDL+8ZAQyJ6s
        LJWyNF8xflxKZ/1z8wUvPplZWA==
X-Google-Smtp-Source: AK7set+14R3s4BQCLQJ4a4hLLQ4KmCksx2AHQmA0f9u8S8H5YBpB+0ckDzo54MI947hi1fI6LpcImw==
X-Received: by 2002:a17:906:9b89:b0:88e:e498:109b with SMTP id dd9-20020a1709069b8900b0088ee498109bmr11865040ejc.5.1677743308465;
        Wed, 01 Mar 2023 23:48:28 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906355a00b008b17b0f5d07sm6777876eja.217.2023.03.01.23.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 23:48:27 -0800 (PST)
Message-ID: <8c3a16f6-f1fb-911b-b935-31ed8e227f8f@linaro.org>
Date:   Thu, 2 Mar 2023 08:48:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: add binding for aw200xx
Content-Language: en-US
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
References: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
 <20230228211046.109693-2-mmkurbanov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230228211046.109693-2-mmkurbanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 22:10, Martin Kurbanov wrote:
> Add YAML devicetree binding for AWINIC AW20036/AW20052/AW20074
> led driver.
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>  .../bindings/leds/awinic,aw200xx.yaml         | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> new file mode 100644
> index 000000000000..08181703e223
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AWINIC AW200XX LED
> +
> +maintainers:
> +  - Martin Kurbanov <mmkurbanov@sberdevices.ru>
> +
> +description: |
> +  This controller is present on AW20036/AW20054/AW20072.
> +  It is a 3x12/6x9/6x12 matrix LED programmed via
> +  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> +  3 pattern controllers for auto breathing or group dimming control.
> +
> +  For more product information please see the link below:
> +  aw20036 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151532_5eb65894d205a.pdf
> +  aw20054 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151602_5eb658b2b77cb.pdf
> +  aw20072 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151754_5eb659227a145.pdf

Links do not work. Error 401

> +
> +properties:
> +  compatible:
> +    enum:
> +      - awinic,aw20036
> +      - awinic,aw20054
> +      - awinic,aw20072
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  awinic,display-rows:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Leds matrix size

Why do you need this property? Number of LEDs are known from the number
of children. Matrix size is fixed in compatible, isn't it?

> +
> +patternProperties:
> +  "^led@[0-9a-f]$":
> +    type: object
> +    $ref: common.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description:
> +          LED number
> +        maxItems: 1
> +
> +      led-max-microamp:
> +        default: 9780
> +        description: |
> +          Note that a driver will take the minimum of all LED limits
> +          since the chip has a single global setting.
> +          The maximum output current of each LED is calculated by the
> +          following formula:
> +            IMAXled = 160000 * (592 / 600.5) * (1 / display-rows)
> +          And the minimum output current formula:
> +            IMINled = 3300 * (592 / 600.5) * (1 / display-rows)
> +


Best regards,
Krzysztof

