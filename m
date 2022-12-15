Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7708664D905
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLOJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiLOJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:51:11 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BF25C0E9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:50:21 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y25so14781125lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHzqsSvslMQj7aaAMRNWFcMOjD6mUD/ZMpwlfykKSKw=;
        b=S56nXRJWIWIcfqQKWlqA8nNkrOjKgfGHlcgVASmDbpQZVtcDnlMnvG8vKQaBf9JyjM
         8jtl6WE5nUl0ZtaLbuD4akaR4A/0rX2fobzqo/B6zvBikwXFrf6NfHNJB8AeZrHEOiyg
         IE1IaMqQOw0FZAm0Vk/ij9U1IotgPWL1711eAdEl9xGzU0ejIyN0kViYtz5u8IYXEJnH
         Um18b6K2cZowduD3f1s5g4yIUDVXnlHFk/o8HkkuvThEfoqjFXUFMGaPC7OIMw4NEi0O
         xLyoJapEQfjX5PyUqZrMHu4x+XlqbyUgkFBnUo7P0iUPLWaT5LXa+81uUAZKEO8zidWT
         IsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHzqsSvslMQj7aaAMRNWFcMOjD6mUD/ZMpwlfykKSKw=;
        b=hUArSuMB1ehksslTMqKAWTAEm0EILNQ3PeM9vHEJgrmMIoJzEQbnEdOZc1ngBiXkJv
         NmdOr14x/ucl178piKH3oSJt78zYRNBTrqHJrGUodIUgGfT+t3qcsMfZxU2bS/eYetcX
         3oMjK3hN1KIAajTUemcyoz9OCcN09Dj49Kx8hkhU6qsAfMXnljVOdVfuw6yKvzobIY14
         7ifbwl3TmeArLQmqMAHD7HV1GxFuBMNou23sWJbDe5+jLhBSzAtI3/Py5KWCAXtY0W2U
         Qwf0csTxxnMi0mi2pOo8487WrfPhj8xqgjyCJzJ8NcmIeQ6KxU7kz2OLLf7R+7gzkyez
         NGvg==
X-Gm-Message-State: ANoB5plWiZtdIsLVG4/73BSYMj9px09QHQBoO+JjEO5EKwYtJLalVZFO
        ML9GzXlIXUQZJ1nA0NGn3p964zqdPhAH2P68
X-Google-Smtp-Source: AA0mqf5xGIT7lIRMsBLXsAkmeEH1QBzeR1ZB+qbINWxUEPgNpjUVrG2f0n4VK4CoW4/cA+f3IOsSZA==
X-Received: by 2002:ac2:4bcb:0:b0:4a4:68b9:66bc with SMTP id o11-20020ac24bcb000000b004a468b966bcmr7260898lfq.7.1671097820112;
        Thu, 15 Dec 2022 01:50:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v1-20020ac258e1000000b004946b549a19sm1115937lfo.45.2022.12.15.01.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 01:50:19 -0800 (PST)
Message-ID: <0161902f-1a0c-0be2-2141-3c14d6e6fe54@linaro.org>
Date:   Thu, 15 Dec 2022 10:50:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/5] dt-bindings: power: reset: Add RZ/V2M PWC Power OFF
 bindings
Content-Language: en-US
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
 <20221213224310.543243-3-fabrizio.castro.jz@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213224310.543243-3-fabrizio.castro.jz@renesas.com>
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

On 13/12/2022 23:43, Fabrizio Castro wrote:
> Add dt-bindings document for the RZ/V2M PWC Power OFF driver.

Drop driver.

Subject: drop second, redundant "bindings".

> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  .../reset/renesas,rzv2m-pwc-poweroff.yaml     | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-poweroff.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-poweroff.yaml
> new file mode 100644
> index 000000000000..12456e3e93e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/renesas,rzv2m-pwc-poweroff.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/renesas,rzv2m-pwc-poweroff.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/V2M External Power Sequence Controller (PWC) Power OFF
> +
> +description: |+
> +  The PWC IP found in the RZ/V2M family of chips comes with the below
> +  capabilities
> +    - external power supply on/off sequence generation
> +    - on/off signal generation for the LPDDR4 core power supply (LPVDD)
> +    - key input signals processing
> +    - general-purpose output pins
> +  This node uses syscon to map the registers relevant to Power OFF (the
> +  register map is retrieved from the parent dt-node), and the node should be
> +  represented as a sub node of a "syscon", "simple-mfd" node.
> +
> +maintainers:
> +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a09g011-pwc-poweroff # RZ/V2M
> +          - renesas,r9a09g055-pwc-poweroff # RZ/V2MA
> +      - const: renesas,rzv2m-pwc-poweroff
> +
> +  regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the register map node.

This also has to go.

> +
> +required:
> +  - compatible
> +  - regmap
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    poweroff {
> +            compatible = "renesas,r9a09g011-pwc-poweroff",

Use 4 spaces for example indentation.

> +                         "renesas,rzv2m-pwc-poweroff";
> +            regmap = <&regmapnode>;
> +    };

Best regards,
Krzysztof

