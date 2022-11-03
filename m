Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4BA61846A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKCQaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKCQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:29:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C481BB34
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:29:51 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id hh9so1528637qtb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WzI5WHDGOhILd2kGTGSG7qJD/oMtmbhddu8DVRjwYa8=;
        b=iR4qWTvnQ9PK6KX3xLXJJOzYzuLeNPTJ5QqMlgdV6aYVyeuiPSztQohCxcwzupcZTM
         f89PBCC8TnTlTF6PqvJjVqVcFJGCC/heuJ7SggeKGyIK5RBL/rhxsShENw67NTrptTjg
         QcDX+40Neuew+11KbTD2vFZIwcfH/FmvMq6sgGHh5OJ3xzpc9gjHa+A3n0cuEFwlRPtB
         eIFb0mZDmTmyvoo1ImX4gAi0P4jxR1GowJpiwwcfXsdRLYQe4do09L6uX8uk/P4DfjL3
         9GbCQF8s+hNNU72F2ZUgombhRPuUhfYn6rLYDEKRDmW1rDNuv9uia1VJQJBe1WcLCgq8
         ULiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzI5WHDGOhILd2kGTGSG7qJD/oMtmbhddu8DVRjwYa8=;
        b=ACgGR9isQI5qMopbS8DPFvhwU60Ove70prA4LhcEX/LPAxmELUcY5p74DuLBVL6ZNH
         IzpLqlynwFAZAxuGM9eQoXZ5Tld5GONB0X2O7NmDUG1TLCtpsCuGayEgRefdYJvfgFh+
         g1q2/alDm1p61/m5Sci5A4UKg+nQeXWKOWdbuQLjTSCgt3uxZcVBJiJW+itkh5//kZHM
         iHNTD+7YLQg6ekEiBRR/r7VQz2gbu6aBWZ7aibE/pCX8vJsIgy+fHW+QQGcdhc3ym88f
         lHvW9dyLo9jVHbvoAXXHhaowEsjSfTn0X3wOTbC6LlDSIWKRHkxVqYw8pdEgM1bF9B36
         N0LQ==
X-Gm-Message-State: ACrzQf01hB4C7WodtG/W9aGiQpp+f6FJaRekpvmBNgomRr6s2HOyFu5J
        C3Xq9h1svOi5I8gktUFZaAKk+A==
X-Google-Smtp-Source: AMsMyM6uaWdvy7fAoM8b3ziC+Hx3Fsa/5e0pLstybGOQYB7L/NfOxWftJpK5SmD4Fz4HdYXb6c01mA==
X-Received: by 2002:a05:622a:10e:b0:398:d464:eefa with SMTP id u14-20020a05622a010e00b00398d464eefamr25748915qtw.172.1667492990935;
        Thu, 03 Nov 2022 09:29:50 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a244f00b006fa468342a3sm1044435qkn.108.2022.11.03.09.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:29:50 -0700 (PDT)
Message-ID: <b85230d4-8fce-ba49-0d6b-8c4d20132cda@linaro.org>
Date:   Thu, 3 Nov 2022 12:29:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for gxp
 gadget
To:     richard.yu@hpe.com, verdun@hpe.com, nick.hawkins@hpe.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221103160625.15574-1-richard.yu@hpe.com>
 <20221103160625.15574-3-richard.yu@hpe.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103160625.15574-3-richard.yu@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 12:06, richard.yu@hpe.com wrote:
> From: Richard Yu <richard.yu@hpe.com>
> 

Subject: Drop redundant second "binding" word.

> Create documentation for the hpe,gxp-udc binding to support access to
> the virtual USB device.
> 
> Signed-off-by: Richard Yu <richard.yu@hpe.com>
> ---
>  .../devicetree/bindings/usb/hpe,gxp-udc.yaml  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-udc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/hpe,gxp-udc.yaml b/Documentation/devicetree/bindings/usb/hpe,gxp-udc.yaml
> new file mode 100644
> index 000000000000..f1ec4df8c3d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/hpe,gxp-udc.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/hpe,gxp-udc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP Gadget Universal Device Controller (UDC)
> +
> +maintainers:
> +  - Richard Yu <richard.yu@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-udc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdevnum:
> +    description:
> +      virtual device number.

That's unusual property... Why numbering devices is part of DT (hardware
description)?

> +
> +  fepnum:
> +    description:
> +      number of the flexible end-points this device is needed.

Similar question.

BTW, if you end sentence with '.', it means it is an sentence, so you
need to start it with capital letter.

> +
> +  hpe,syscon-phandle:

phandle is redudant. You need rather specific name, so "hpe,ehci-syscon"
or whatever it is.


> +    $ref: '/schemas/types.yaml#/definitions/phandle'


No quotes.

> +    description:
> +      Phandle to the gxp vEHCI controller access vDevice registers.

Drop "Phandle to"

Isn't "gxp" a GXP?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vdevnum
> +  - fepnum
> +  - hpe,syscon-phandle
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    udc@80401000 {

Node name "usb", I think it is more popular for USB controllers.

> +      compatible = "hpe,gxp-udc";
> +      reg = <0x80401000 0x1000>;
> +      interrupts = <13>;
> +      interrupt-parent = <&vic1>;
> +      vdevnum = <0>;
> +      fepnum = <7>;
> +      hpe,syscon-phandle = <&udc_system_controller>;
> +    };

Best regards,
Krzysztof

