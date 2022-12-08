Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB54A646A6E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLHIZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLHIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:24:52 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCB15B5A4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:24:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id y25so907742lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79xB/zM0U0/1kfBuvBDw4fIid88fhTEKl6HV/65eqGs=;
        b=nvk9SILY86V5yKvRYpP7qenKU1KR1IOY1b/BM+L+QcHCf/u+QVi3c8WQ6vbdg3oPVS
         VVlohE2IuC4MoGbo/EULgXXjjOhfzADR8Tz+4ph/gbsQzdbkQrB1DebQJBjpVwTJddfW
         CzxeFFR1Gbt8Ofq6PTo717dICjqph7MUXke19OJ4L5UvQK5M/WhkaVpsUkCKYq5+3JWy
         xLWn8Jw/KxKzG9XPiOjuwwr4TdHdwIcjuRGGSZwO2UaVJgGs3z7WfcGNGAAIqdW2qx2k
         OwJTU9tn3ajdtwEa41B8OborHPi2OrKiUyNRZMQHz03uFo5+t5f6ruqSNIjIrk+93tnM
         z1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79xB/zM0U0/1kfBuvBDw4fIid88fhTEKl6HV/65eqGs=;
        b=6+dLbGnQksE6+gjk5PgsRwEU9EDCcXSv2P96qjMybuAIg5BcP6KeEnsioww1PFMHBC
         iiXVOtolJkx/XAJOmOzvodz7iikBKNsD/rnzrLNXvYxX1jQ6nfZHWG5kl9HKIEFCvSRY
         gMbJg8+hCA2h4Krm5UDnFz8jewkrpQD7i4dLo8TsXIv406RysFgtSkENbfco4AEAyr3d
         W4drR4ZzKAtfmyPvug8FRgXYzKXSUyHHyPl1pQINQw1glqDpphcM9aJfhTqVWNLnyF+c
         oeT7DhUV7UvfkkCvEy74Na3yVm+a+ofF3/0PnIZxL4dXQ4Www3ZPy/LfdD2PwcVmyn24
         wK0Q==
X-Gm-Message-State: ANoB5pnksBpn+UOzQb6keNXY+a2DD93tKrVP0zPzfPrBC7SplnERd/6K
        fXmo0Bw8y4FGSPQzunXOaL3Zlg==
X-Google-Smtp-Source: AA0mqf5ePKjGDy40LvCJ1aaco/uK1rBASrKzt5yUYPiLyG9tv8AhNviCbFBNMS5KJPPIKiUFaMNyqA==
X-Received: by 2002:a05:6512:74b:b0:4ad:5f7b:46e0 with SMTP id c11-20020a056512074b00b004ad5f7b46e0mr35621340lfs.350.1670487889230;
        Thu, 08 Dec 2022 00:24:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v26-20020a05651203ba00b004b55cebdbd7sm2182547lfp.120.2022.12.08.00.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:24:48 -0800 (PST)
Message-ID: <77f3dea3-7009-eccc-6bac-66309e15a767@linaro.org>
Date:   Thu, 8 Dec 2022 09:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 16/16] dt-bindings: soc: socionext: Add UniPhier AHCI
 glue layer
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-17-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207055405.30940-17-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 06:54, Kunihiko Hayashi wrote:
> Add DT binding schema for components belonging to the platform-specific
> AHCI glue layer implemented in UniPhier SoCs.
> 
> This AHCI glue layer works as a sideband logic for the host controller,
> including core reset, PHYs, and some signals to the controller.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-ahci-glue.yaml         | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
> new file mode 100644
> index 000000000000..bf37be8a778d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-ahci-glue.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier SoC AHCI glue layer
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +description: |+
> +  AHCI glue layer implemented on Socionext UniPhier SoCs is a sideband
> +  logic handling signals to AHCI host controller inside AHCI component.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - socionext,uniphier-pro4-ahci-glue
> +          - socionext,uniphier-pxs2-ahci-glue
> +          - socionext,uniphier-pxs3-ahci-glue
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':

use consistent quotes

> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^reset-controller@[0-9a-f]+$":
> +    $ref: /schemas/reset/socionext,uniphier-glue-reset.yaml#
> +
> +  "phy@[0-9a-f]+$":
> +    $ref: /schemas/phy/socionext,uniphier-ahci-phy.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties:
> +  type: object

What is the additional object? It's not in your example, not in DTS. Why
do you need to allow it?

Best regards,
Krzysztof

