Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87A7663D40
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjAJJtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjAJJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:49:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C44D70F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:49:40 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g10so8344297wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3yg0yWxaO3D77Rc0YvK78QrEddXCLnXNXF1NfjRw2ik=;
        b=p0+wGr50kzPrjqKDE6iMoVByKnfBTswHllyJ0hbTRrcv6KmotSkY9fXD0ucOZHCXg7
         UrGyLCQD2cNuR2Pv/UCVKtIgWL7SJ3J9ldLEJ1mLC0dca5dNETHiYiY5EUmHtI+64fKM
         8kmCedm+aUmlSpmmnL8EkQLGWIQt5UMElxFD7swiH0Y6C8NUM0vkia35z0HZdZJEL3wk
         CAnSjbq4HBkHcU/OEQyvyILwKqGfuoUZSK4AIXXqL9QQjlNJu7XZlYP2OJvRqyxf12JX
         oGsp5QGCtnbKbBcZuvo1qPOjYJAIDxft+NYlwey/Z5SpnUN/Ww3JTVSCYXykUWnPTAZK
         acAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yg0yWxaO3D77Rc0YvK78QrEddXCLnXNXF1NfjRw2ik=;
        b=O6w6yDjPQQxnw+2YNNPjpqaO038fpohlPVIWoiUQVMGmaUhfm6sSgGn77x8HC1XZHu
         7TcDOrdnzFPpbaJ8R3FM4Amk9etzfEm2flt5egjl9vR75hr5AQBcYqVQrPxdZPK8sWGC
         t0XUQ2wxF08vYYxsF8Vn0tEYwXXX0c3oTWhJowRAO0hKJgyZiwBC+Ti1gmr11jSDmlPr
         VZfObQV+xgjnotxCw1eu6CAPopCXN1Ye1stvH3y8zFScuzIY2zyMFwL4+UiBUPKv6GyZ
         /PHL77xoeMbBlzqxIDNMRHi84MTDZmsQ8LWC4oeWhqR4+SBej0l0EJv7dXzE4oJkmxH8
         /mFw==
X-Gm-Message-State: AFqh2kqGNPQk/q1riHa3HxTwZvwl2uWb6u/Vxx3fLhlnZ+oDj4F3kLJS
        94eYd4qHTPPac8HVu9fcmHDXaw==
X-Google-Smtp-Source: AMrXdXuASSZzKeUfOw9NJX7VERkz88BE+g/9yYKsDXnLCZOI/iHYipX/l8kBD+iUSPDp91rG1gf3AA==
X-Received: by 2002:a05:600c:2142:b0:3d5:365b:773e with SMTP id v2-20020a05600c214200b003d5365b773emr58864982wml.39.1673344178638;
        Tue, 10 Jan 2023 01:49:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0ad200b003d9c97d82f2sm14117592wmr.8.2023.01.10.01.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:49:38 -0800 (PST)
Message-ID: <110af65f-9c18-524d-a073-ef7be60d1f5a@linaro.org>
Date:   Tue, 10 Jan 2023 10:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/5] dt-bindings: soc: hpe: hpe,gxp-srom.yaml
Content-Language: en-US
To:     clayc@hpe.com, linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        verdun@hpe.com, nick.hawkins@hpe.com, arnd@arndb.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, olof@lixom.net
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-3-clayc@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230110042533.12894-3-clayc@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 05:25, clayc@hpe.com wrote:
> From: Clay Chang <clayc@hpe.com>
> 
> Document binding to support SROM driver in GXP.
> 
> Signed-off-by: Clay Chang <clayc@hpe.com>
> ---
>  .../bindings/soc/hpe/hpe,gxp-srom.yaml        | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml
> new file mode 100644
> index 000000000000..14ad97d595c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml

Don't drop stuff to soc. Put it in respective directories. This also
applies to your driver.

SROM controllers go to memory-controllers. What is this, I have no clue.
"SROM Control Register" is not helping me.

> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/hpe/hpe,gxp-srom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP SoC SROM Control Register
> +
> +maintainers:
> +  - Clay Chang <clayc@hpe.com>
> +
> +description: |+
> +  The SROM control register can be used to configure LPC related legacy
> +  I/O registers.

And why this is a hardware? No, you now add fake devices to be able to
write some stuff from user-space... Otherwise this needs proper hardware
description.

> +
> +properties:
> +  compatible:
> +    items:

Drop items, you have only one item.

> +      - const: hpe,gxp-srom
> +
> +  reg:
> +    items:
> +      - description: SROM LPC Configuration Registers

Drop items and description. Just maxItems: 1

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    srom: srom@80fc0000 {
> +      compatible = "hpe,gxp-srom";
> +      reg = <0x80fc0000 0x100>;
> +    };

Best regards,
Krzysztof

