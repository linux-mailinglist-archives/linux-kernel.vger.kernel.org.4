Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C619A6E2271
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDNLk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNLky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:40:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B214ED0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:40:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dm2so44942626ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681472451; x=1684064451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwCnm0dqF6GO9rD40udc/VGMXwcnBrK2/hebHkxzkgU=;
        b=SsI69cum9qeu0etn2SIPkAfRUOij/h8S6VFCMpuN1D3QWOUs+kky4qxmj1gsUPUc3d
         7LF0CEaInESiQRJbEvNXw+LcqLZfaMPIw0jlutiq/yiR34XcvToBa/a/iP/npQGtciQ5
         5tbD3L9TfW9gSpau207N/XLAEwr05CABrein9SHZ5VN1EkOgkhkIyylB7mWKDD/fCflQ
         OdaG7ikmby8gBpbkjPoF/V+nYVuRB6D/BmQSz5+ZXkJJgceHE0S03VncogZuQ5Gu6CkU
         lumPe64Ek7MkPNHYQJGEqrL/DWGHRZxE0LWWHWj1WibXDdrv3oVZygVHM+1MRb0pO9cR
         FdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681472451; x=1684064451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwCnm0dqF6GO9rD40udc/VGMXwcnBrK2/hebHkxzkgU=;
        b=IR74H4Gx76KQA8icmTUjcePKo/rtNpxD2TI/MjSdVDXMAwr72qsc31VYh1Xeup6G/h
         Qikeuh+2/7VT7n+R8kbeO/AfrLM9fKywKJQZ4w4aTVLS/b52AhclyM5z7dKOdamoLXDq
         7of6XIqPIfPWQkwqwTAaHXflF6ZjUyIfCrMQ9hIuEWd7xdQwB1vOTFuR4EXNXMw8/YRa
         t9nnAMXjD5SXDB2kJE7TZwH5RmqEH6OLof8l2LFb7bS40tNz2cAPIL509qinpzhRDIXz
         qqmhWJbcQA2RNRzaN6GQIK8Q6gS7efBV7ukd86tByJihLuDMdzP4ps+o/75U0P/4T8Wm
         7KTQ==
X-Gm-Message-State: AAQBX9eDvTu/7cZPGG2SxfFDhIihrqHqiZzuUmtA3TTc4gprRHq3o+T0
        QyOk1ZSOqJutgilLm8DoHqF+IA==
X-Google-Smtp-Source: AKy350b9+O0ZZJipRXtRD4UQuPeSzAlpeim/uewsl4aFs4kjyrgNQ/vfpndmvaF3DStL+OWori2gtQ==
X-Received: by 2002:a17:907:6f17:b0:94e:dc3c:cca2 with SMTP id sy23-20020a1709076f1700b0094edc3ccca2mr2123702ejc.70.1681472451565;
        Fri, 14 Apr 2023 04:40:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:40b9:8c57:b112:651d? ([2a02:810d:15c0:828:40b9:8c57:b112:651d])
        by smtp.gmail.com with ESMTPSA id dk8-20020a170906f0c800b0094a44aa90ddsm2279434ejb.216.2023.04.14.04.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 04:40:51 -0700 (PDT)
Message-ID: <40498f71-d0cd-e7af-6515-c60a8d1edce8@linaro.org>
Date:   Fri, 14 Apr 2023 13:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] dt-bindings: misc: esm: Add ESM support for TI K3
 devices
Content-Language: en-US
To:     Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com
References: <20230414105225.194195-1-n-francis@ti.com>
 <20230414105225.194195-2-n-francis@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414105225.194195-2-n-francis@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:52, Neha Malcom Francis wrote:
> Document the binding for TI K3 ESM (Error Signaling Module) block.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  .../devicetree/bindings/misc/esm-k3.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/esm-k3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/esm-k3.yaml b/Documentation/devicetree/bindings/misc/esm-k3.yaml
> new file mode 100644
> index 000000000000..5e637add3b0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/esm-k3.yaml

Filename matching compatible. Missing vendor prefix and device name.

> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/esm-k3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 ESM Binding

Drop: Binding

> +
> +maintainers:
> +  - Neha Malcom Francis <n-francis@ti.com>
> +
> +description: |
> +  The ESM (Error Signaling Module) is an IP block on TI K3 devices
> +  that allows handling of safety events somewhat similar to what interrupt
> +  controller would do. The safety signals have their separate paths within
> +  the SoC, and they are handld by the ESM, which routes them to the proper

typo: handled

> +  destination, which can be system reset, interrupt controller, etc. In the
> +  simplest configuration the signals are just routed to reset the SoC.

There is no proper bindings directory for ESM? Misc is discouraged.

> +
> +properties:
> +  compatible:
> +    const: ti,j721e-esm
> +
> +  reg:
> +    items:
> +      - description: physical address and length of the registers which
> +          contain revision and debug features

Drop useless "physical address and length of the registers which". reg
cannot be anything else.

> +      - description: physical address and length of the registers which
> +          indicate strapping options
> +
> +  ti,esm-pins:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      integer array of ESM event IDs to route to external event pin which can
> +      be used to reset the SoC. The array can have an arbitrary amount of event
> +      IDs listed on it.

What is ESM event ID? The property name suggests pins...


> +    minItems: 1
> +    maxItems: 255
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ti,esm-pins
> +
> +examples:
> +  - |
> +    main_esm: esm@700000 {

Drop label.

> +        compatible = "ti,j721e-esm";
> +        reg = <0x0 0x700000 0x0 0x1000>;
> +        ti,esm-pins = <344>, <345>;
> +    };

Best regards,
Krzysztof

