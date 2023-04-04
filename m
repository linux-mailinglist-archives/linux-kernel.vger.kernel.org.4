Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9080E6D58A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjDDGSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjDDGSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:18:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753F830FF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:17:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h8so126178288ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 23:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680589062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDjaU2rar9tWF1A9zRNafmNtWp0F/aW8MT9UYDo8+8s=;
        b=ER/Gjr8X3DKa1om2wxA8O4xQ/E+zMFEI/9rl+Lx047ZntTFt4fEiUvmpOwEs6vQWTD
         3P9RIpT0v1Od8EmCfSbASaXuWCKTWn0m6XN/nGaABvumC0ywdZn6Bj0PAfh3tL+cDCz2
         RXMnBE7s2gbQF9r+89T4JsG/JO2b9SIoQBdwFsIotIaa+ArG7i2+07TLJ9aN6Wcn10e+
         BwP07mCUULfB7dJEH3o2Nu6WdrXboJE/vtJxSOYt41cXSaRU5yd6WAAIdZiH5h/mo2Ow
         P2YU7V/EVlsY4xzOjcYhXMyymt1t1hngBK+2K1dZwylyAxa6xH7TqhihGUx4841mXHiv
         /FRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680589062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDjaU2rar9tWF1A9zRNafmNtWp0F/aW8MT9UYDo8+8s=;
        b=e5llHM0FNGLDC0XCyhHSJ4q0nHN7lbqx0U8flBZdG3KUTQHAukGQ9R+5II7go+sTYG
         6vKuvrXe351QhJ8dngeRWeOl6OaAqsXW82GKbYwXqLs+ZbtLza7QvJoYLQ4SpivL+L5Q
         IfKnMBPAHvJXaUA+s85loGkAEC38f6JopCTfZuP2+i9afiIE7ET+EGeM045U2InrTdWj
         cU4WWPqhkQXDsPLaOnfel5QkcteR/27q2z4IISUQlwjjqSxMqAj5o3BmtJx8DtP6fz1g
         cDilwcuIOLLBHfbnz+taaF5jqXGM0iwosi8Hr4BRAEiuP/vfLFZ8ObJz5J65WbvjviQi
         SEiw==
X-Gm-Message-State: AAQBX9fcFlauH1t/Lo3zQQZaOyhRj998qH/pduz7Iaoc0+6wQmCr7O0d
        I+VVYbl7lUZ/BaDXbTpF+M37eir+v8kgRWs9r5A=
X-Google-Smtp-Source: AKy350acMPUvg8FQaSMcxpUkt8euvDaA6UhTGNL2AIK9rmdVQWP6apDq0xztamPFlkojeWn2icK9vQ==
X-Received: by 2002:a17:906:668c:b0:924:7f98:7c55 with SMTP id z12-20020a170906668c00b009247f987c55mr1131637ejo.48.1680589062126;
        Mon, 03 Apr 2023 23:17:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906a28c00b00946e6dd887csm5414775ejz.126.2023.04.03.23.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 23:17:41 -0700 (PDT)
Message-ID: <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
Date:   Tue, 4 Apr 2023 08:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 17:43, Ibrahim Tilki wrote:
> Devicetree binding documentation for Analog Devices MAX313XX RTCs
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../devicetree/bindings/rtc/adi,max313xx.yaml | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> new file mode 100644
> index 000000000..0c17a395e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX313XX series I2C RTCs
> +
> +maintainers:
> +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: Analog Devices MAX313XX series I2C RTCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max31328
> +      - adi,max31329
> +      - adi,max31331
> +      - adi,max31334
> +      - adi,max31341
> +      - adi,max31342
> +      - adi,max31343
> +
> +  reg:
> +    description: I2C address of the RTC
> +    items:
> +      - enum: [0x68, 0x69]
> +
> +  interrupts:
> +    description: |

Do not need '|'.

> +      Alarm1 interrupt line of the RTC. Some of the RTCs have two interrupt
> +      lines and alarm1 interrupt muxing depends on the clockin/clockout
> +      configuration.
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    description: |

Do not need '|'.

> +      RTC can be used as a clock source through its clock output pin when
> +      supplied.
> +    const: 0
> +
> +  clocks:
> +    description: |

Do not need '|'.

> +      RTC uses this clock for clock input when supplied. Clock has to provide
> +      one of these four frequencies: 1Hz, 50Hz, 60Hz or 32.768kHz.
> +    maxItems: 1
> +
> +  aux-voltage-chargeable:
> +    enum: [0, 1, 2]
> +    description: |
> +      Enables trickle charger.
> +      0: Charger is disabled (default)
> +      1: Charger is enabled
> +      2: Charger is enabled with a diode

2 is not an allowed value. I asked to drop this property. It is coming
from rtc.yaml. I also do not understand "with a diode". So otherwise it
is charging with, I don't know, FET?

> +
> +  trickle-resistor-ohms:
> +    description: Selected resistor for trickle charger.
> +    enum: [3000, 6000, 11000]
> +
> +required:
> +  - compatible
> +  - reg
> +
Best regards,
Krzysztof

