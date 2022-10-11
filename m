Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CEF5FB6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiJKPKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiJKPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:09:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2360A2528D;
        Tue, 11 Oct 2022 08:02:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b2so13424524plc.7;
        Tue, 11 Oct 2022 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=J58wtPKoWhhaA5HR2/A5/Snd3JbQWbOxXugYX0Yrkus=;
        b=l2kDm1d5C+6w79CMamPFVSXLWU+u3lZP28PE4ZBP+EaXZFbRIIXZhcyNo66pLwPKft
         aTREuXv6yt4x6mKXRgOAp7L+9CB8NqSgiFGgWboA+4A+vYElSpvj+Btd0OHQjidWa5Xh
         FRjfbX1w9zMgSV79JEFygWvL/c6nbcFPfD2dkNT/kC9M+qrtzXPuejDAvxCaevucfDpt
         pCwB4OttpOg++4xe1g2+X4xJef+sn+Wy3+7dZ8taqVgADnPVoRQRDjWt/lwymztNmNYb
         rPlaFKc0q8ykYS5FSo/3yk3agTBm/S4xi95Krah/7ou6tEGfYTz8wrgGhZ/9PRTgwZ8O
         Bkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J58wtPKoWhhaA5HR2/A5/Snd3JbQWbOxXugYX0Yrkus=;
        b=d+0ucnJK+4oLJN40nGsdCaq3fliZ1Djvo9UzOLuBtCM/ZCU3XVSWE1/TSPfo7gyMhv
         5DGMPvY5PVI1FoDM1TNpKpG/ojlI2g89emLypqEXVLj1hpR7BW+D7NKAaHLspuRjDL5Y
         NhJ+LEiKU56vakGx5g5y9rjBmJqSB08J4gdRy/PEACZRlFRbe9YA147T7Znu4V1hhaCf
         I5cQFJHZpfMomIUHczvPDGhGBF2oOWTs/lef2vEklcgpKpOD9jYWCUTPusR1zK4QZXxV
         rfVNGiAgqXxw/UPchDZE9AubWJjdxn94MxBo/9La6FyOriJyDlZcwlc4DwClxPCnPstk
         ymZw==
X-Gm-Message-State: ACrzQf2nSxyfYx4h+7rmkTu0tBIqDKLZe/EOCe1WCZy1h5AzqQtrR7vt
        hd6jc7rbOVT8plFrFKF/sPE=
X-Google-Smtp-Source: AMsMyM5qZZ/DWXkAlKV1evxqgrdOqTdqSxuntEeQ3MsKRc32T4AXPkF0NKdX9gEAwr4TG+TSSx3YAg==
X-Received: by 2002:a17:902:6bc5:b0:183:4bef:1b20 with SMTP id m5-20020a1709026bc500b001834bef1b20mr6361211plt.158.1665500418359;
        Tue, 11 Oct 2022 08:00:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w21-20020a634755000000b0045751ef6423sm7952052pgk.87.2022.10.11.08.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 08:00:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d2c83c4f-653c-438e-a91a-d17b846dec5b@roeck-us.net>
Date:   Tue, 11 Oct 2022 08:00:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221011104739.53262-1-Naresh.Solanki@9elements.com>
 <20221011104739.53262-2-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221011104739.53262-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 03:47, Naresh Solanki wrote:
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>    patternProperties:
>      "^fan@[0-2]":
>        type: object
>        allOf:
>          - $ref: fan-common.yaml#
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   .../devicetree/bindings/hwmon/fan-common.yaml | 80 +++++++++++++++++++
>   1 file changed, 80 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..abc8375da646
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common fan properties
> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +
> +properties:
> +  max-rpm:
> +    description:
> +      Max RPM supported by fan
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pulse-per-revolution:
> +    description:
> +      The number of pulse from fan sensor per revolution.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  target-rpm:
> +    description:
> +      Target RPM the fan should be configured during driver probe.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwm-frequency:
> +    description:
> +      PWM frequency for fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwm-polarity-inverse:
> +    description:
> +      PWM polarity for fan.
> +    type: boolean
> +
> +  label:
> +    description:
> +      Optional fan label
> +    $ref: /schemas/types.yaml#/definitions/string
> +

Same question as before:

How are additional common bindings, such as min-rpm or fan-divider
(also sometimes called fan-prescale) supposed to be handled ?
As additions to this schema, or individually in each driver needing/
using them ?

Thanks,
Guenter
