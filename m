Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED26D91AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbjDFIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjDFIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:32:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4BB6A4B;
        Thu,  6 Apr 2023 01:32:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y15so49845121lfa.7;
        Thu, 06 Apr 2023 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680769963;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOHXZCsyZpIluywINmsw1p7wvpx+wr79DmVlHr/gEWQ=;
        b=RXoSie3urK8sj5LgAQ69yIZwvf3uKeGVuDmpLvkjTmeLmMaDXc7lKcK+srdi/EYQLP
         ljzUr8v3OhATKepb/Xy3FyEK5Hsd+vinOXa2BogAJ9P+JoLIEJWVcJ2jQHgvRCqh0TKt
         /CkySRz9pdKGfF0HrjreGYSKfenx3QYeh8nr8o/0maDlE7bl6NX2XW0zHflAeXu4v+h+
         jFdh6dSuXf1q9m97Kc1Oj11KvEQbjsN8WUub416ysq0shkqPMlmFPOTPELtklzxah2jU
         pIRl9yWiA4d8AFRtR2Um7zJTgsAGjcmQ79DaSHrP6EM8+tjhyyGSn39kDzBOOJbLd6/v
         fQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680769963;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOHXZCsyZpIluywINmsw1p7wvpx+wr79DmVlHr/gEWQ=;
        b=2igqPDQbH9i5HEQqLNeKvCvPJ3XmwcbBXIFTAD6TaNQBq8ZOokUbrQza6LOCIGxnpi
         YL05LknUgscL/wdZiWslmkrcMvaC+Qxz4ehUudiRY4Od7pNI2yId5CBrbNCtVh6UxQww
         nw8R4ker4UDYdSNCOwdUqrp/jaZT2BFdgM1HGnqoBqYwEqRJDMEl2devwIek7wLE98Iz
         no0dncLKmn2AhDm49AIYt/YmJeqEizGkiZeWsvkOcX7H6E0xwryQA8uoADK3H4sUsSw1
         0IH22vYsiHmFDv8+vtLApU10fxzraVnw11Xc7XUNryvYnuB+QWhOuX16wL2mGtlph3K/
         ub7Q==
X-Gm-Message-State: AAQBX9cT+6d5pLzaN0ViwnBg5NETs824wyFf5OBlUcg3gA7WUrdeQTAG
        9jagDNtL9tdQQT9udHyGBME=
X-Google-Smtp-Source: AKy350Y8O2kiLJa1Zn4LXM4X86wuMH7BcGHrIgzEOznxiEHoWUIHGeKZ6ncDUKnbvWjM1RzffmYgDw==
X-Received: by 2002:ac2:5929:0:b0:4dd:a4e1:4867 with SMTP id v9-20020ac25929000000b004dda4e14867mr1943822lfi.69.1680769963434;
        Thu, 06 Apr 2023 01:32:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id v10-20020ac2592a000000b004d023090504sm168112lfi.84.2023.04.06.01.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 01:32:43 -0700 (PDT)
Message-ID: <f73050b7-3f86-0dcd-5e43-d8a9258afcae@gmail.com>
Date:   Thu, 6 Apr 2023 11:32:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Andreas Kemnade <andreas@kemnade.info>, pavel@ucw.cz,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
References: <20230406060825.103187-1-andreas@kemnade.info>
 <20230406060825.103187-2-andreas@kemnade.info>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: ROHM BD2606MVV LED driver
In-Reply-To: <20230406060825.103187-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Thanks for the patch! Adding new support for devices is Much Appreciated!

On 4/6/23 09:08, Andreas Kemnade wrote:
> Document ROHM BD2606MVV LED driver devicetree bindings.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   .../bindings/leds/rohm,bd2606mvv.yaml         | 76 +++++++++++++++++++
>   1 file changed, 76 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> new file mode 100644
> index 0000000000000..6d4ddd8d31162
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/rohm,bd2606mvv.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BD2606MVV LED controller
> +
> +maintainers:
> +  - Andreas Kemnade <andreas@kemnade.info>
> +
> +description:
> +  The BD2606 MVV is a programmable LED controller connected via I2C that can
> +  drive 6 separate lines. Each of them can be individually switched on and off
> +  but the brightness setting is shared between two of them.

Maybe add a link to data-sheet?
https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/led_driver/bd2606mvv_1-e.pdf

> +
> +properties:
> +  compatible:
> +    const: rohm,bd2606mvv
> +
> +  reg:
> +    description: I2C slave address of the controller.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^led@[0-6]$":
> +    type: object
> +    $ref: common.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 6
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false

According to the data-sheet, BD2606 has an enable-pin. Should it be 
visible in the bindings?


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

