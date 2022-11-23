Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880246352B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiKWIaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiKWIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:30:16 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B733C1E3ED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:30:14 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so27108911lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=so2oxuQ4Y7a0f26n1k3pKbLKlCZdT3KjE4FqYS40eg8=;
        b=zIKOQLWS42fFmJhVRRmxrUjpau1bS4ATAyMBrR1xPqJZy+k6yCWZqTOOTzvDV4a9Yg
         Y++393P9WhJldpuJrNUmZjLm67LM/aen3AYMtBE4XybhQZ3PmkWpsh3CX+2QzmH/LhEc
         c48yVznBlXf3dx/pfoTgD95g7Jr/kfumTRPWAEeEz/HNsA8eVPwcjqq6ocu8h5rXAEdL
         5JCigU1/grJHK2RMfTeAaxaVi03R7JfCop/K71tlNYNHXT3ATw8FsF/T+yN/UqDm0gar
         vS00COq+uTf/xAFzBt7o//Kmnn72FOQuXgEj45tZCMuSO/Pvd9OSRLd9PTowMuJIi/FT
         3SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=so2oxuQ4Y7a0f26n1k3pKbLKlCZdT3KjE4FqYS40eg8=;
        b=tny+mJ/fqIV9DSsjEkukrM20xpLcMKa1ibO8eafLByFrfR6rE1IEz36koiKQRlqpu9
         OL9qrSVpSYdOPwoKPU18oKOXm2aVmns7OskkcFJKtQ1XwWDAXPcb63YcgtbMggKpo0wW
         LQGWuN8BIykYhmiH494zKlTbxr+GM9OZUr0UeCvL1vBnlmLHfGKKWC9RslRHhnG56f3b
         UKfWBnKasZ3Hknu412kk0i254q4F/pR42iijOSRtVTwiMfaYyj3iV7swHd2EnU8hOEJx
         DjoWiG4gG7a9wx5RCF4H98yLYt70aQ36GGrKzvfxwY6WayDqVF25TGNxDxjaQ1IWo9EL
         fY8g==
X-Gm-Message-State: ANoB5pnFlK3FUhkLBsVShFCO/VM6zBYTdMqdnIMqmb3OEci1lIrB3pbU
        RX8fCfE4/RywJJJlnb7xK3fe4A==
X-Google-Smtp-Source: AA0mqf69iu9qQh6fCA6UDIq1hcLsriLuOE6oSPhjtXZDsQsFgavDS6cW7I/64DKInOEgrT2IoBd0kQ==
X-Received: by 2002:ac2:434d:0:b0:4a2:51a2:9326 with SMTP id o13-20020ac2434d000000b004a251a29326mr8767700lfl.594.1669192213077;
        Wed, 23 Nov 2022 00:30:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c12-20020a056512324c00b0048af3c090f8sm2809369lfr.13.2022.11.23.00.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:30:12 -0800 (PST)
Message-ID: <3d689f8e-ae2d-2b3e-e783-94b8e6ba8aa0@linaro.org>
Date:   Wed, 23 Nov 2022 09:30:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [v4 2/5] dt-bindings: pwm: Add bindings for aspeed pwm controller
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-3-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123061635.32025-3-billy_tsai@aspeedtech.com>
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

On 23/11/2022 07:16, Billy Tsai wrote:
> Add the aspeed pwm device bindings which should be the child-node of
> pwm-tach mfd.

Subject: drop second, redundant "bindings".

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> new file mode 100644
> index 000000000000..68a60fc73902
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 PWM controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed PWM controller supports up to 16 PWM outputs.
> +  This module is part of the ast2600-pwm-tach multi-function device. For more
> +  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-pwm
> +
> +  "#pwm-cells":
> +    const: 3

Blank line.

> +patternProperties:
> +  "^pwm@[a-z0-9]+$":
> +    description: Set extend properties for each pwm channel.

Description is not a correct sentence. Description explains the hardware
property you have here.

> +    type: object
> +    properties:
> +      reg:
> +        description:
> +          The pwm channel index.
> +        maxItems: 1
> +
> +      aspeed,wdt-reload-enable:
> +        type: boolean
> +        description:
> +          Enable the function of wdt reset reload duty point.
> +
> +      aspeed,wdt-reload-duty-point:
> +        description:
> +          Define the duty point after wdt reset, 0 = 100%
> +        minimum: 0
> +        maximum: 255

Why maximum is 255? Why 0=100%? 0 should be equal to 0 and maximum to
some maximum value (e.g. 100%). If these are percents, use appropriate
units. If these are not - what are these? You need a $ref in such case.

> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false

Best regards,
Krzysztof

