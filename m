Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAF472766D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjFHE6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHE6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:58:32 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C16C26AF;
        Wed,  7 Jun 2023 21:58:31 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39c84863e34so57652b6e.2;
        Wed, 07 Jun 2023 21:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686200310; x=1688792310;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JT3KlhOojBPgttBy2y+jESI/Sgq2kQ2/GXL/IhkMhrg=;
        b=oJCk96IkLeNGopmiIbbiZG7purBH3OY6c3kx4f0qRS/gRqCBKn6ar3hEUXrP3dvwlF
         TPbqJNotco49vVRe3uQS35fn+hDp6b3T5JNuEnCIVbpswFYUUF0BazJP7ZoKlMU99sQ7
         Mr1/N4Hi3nNv/FKHcCEL6otKiRd+y/tqroI/yWRNZYeTsslmp04L6m3lKH72cXW/OzmY
         YYH/gwVu1FLFC+LBMVAiZA6i9si4ErTgc6s57BYA/17cw9gAGqEpoNwFR1jJPJ9ZmGOM
         fbYnbiz4tveUXRwG6C35PiHwMP8/8pj6vM9xO9arqj59CL66NKzuFMmkPAMHAYGdPT4o
         KiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686200310; x=1688792310;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JT3KlhOojBPgttBy2y+jESI/Sgq2kQ2/GXL/IhkMhrg=;
        b=PYHPSDW3XNpip+K5URwSsNXidUVDoin3HdHF/9zH+ZVFjkgmHC9iI4AOZhiXXLBGEL
         zZnIVQcXgnyNdJfoYILCiYfODP/fQXZywlqSF+RfEuiM8q1VRYc+3uboK/BjvT/24Ovg
         vtBg28LokcxJSWjpBDnHym1MkjEFS8lIMX3yJm1zTSm1L+bqiMpbgtKJR89IEa7AJMx6
         uKbpoVqW1phoW7YItizwRR1D3N3GApTLKOwAw15a2v3LwN0n/Skz9HD4Mw2Msx8+neJy
         a96iYa9DuzNQBRdHTtG/YQBMEB+eC27u/UUXICNIV9X+DIoIKziJaKdWAZlJchDPcNXS
         9LXA==
X-Gm-Message-State: AC+VfDzxWAhdpvPRCf8PdukeC8T6sUZtPiJ3WvOeJYcI+sGegbmwTbjq
        FRoMKUsINrQ08yrOmfWx940=
X-Google-Smtp-Source: ACHHUZ7IbXKqWXIgk0etOFyy/EwK/wZPz4znrrxclmpf7ksuCGmhrJWXKHrojfeLz2BB2S+1qEaGHg==
X-Received: by 2002:a05:6808:96:b0:398:27d3:1fc3 with SMTP id s22-20020a056808009600b0039827d31fc3mr7051865oic.42.1686200310606;
        Wed, 07 Jun 2023 21:58:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b0064d1d8fd24asm206662pfo.60.2023.06.07.21.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 21:58:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c1c485b0-b68b-4db7-4b67-5d59f1ecb84e@roeck-us.net>
Date:   Wed, 7 Jun 2023 21:58:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        patrick@stwcx.xyz
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-3-billy_tsai@aspeedtech.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230608021839.12769-3-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 19:18, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-tach device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>   .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 32 +++++++++++++++++++
>   1 file changed, 32 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..627aa00f2e92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed Tach controller can support upto 1 fan input.
> +

The code says:

In Aspeed AST2600 SoC features 16 TACH controllers, with each
controller capable of supporting up to 1 input.

which is a bit different. I guess there are no examples anymore,
but I'd really like to see how this looks like in the devicetree file,
and how the driver is supposed to distinguish/select the 16 inputs.

> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-tach
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - resets
> +
> +additionalProperties: false

