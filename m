Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04896F685B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjEDJef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjEDJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:34:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AD04229
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:34:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bcc565280so283844a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683192870; x=1685784870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHpNhqVirJHtfj48DuYU6pqasfvlpaN+Pya2uIQJJVo=;
        b=JYU1WqchEc/ywUMdVk0jiC0ulHZJz6qSUKspsh3gj2iG4/jKj3V1+lGhph6oKSDsWR
         PE9wL3kh8D0ZzYwcXgZxnbpxgfHslll0Xki8NL9Lb06eHQWTuC5jwkjfcL1Iq+a9pJkG
         WPNeGpS3fSyRpFTMK8WV4Q2YUGIpI3B44pdJ7vrSLDQVenRROXpKOeILszqDLCRyyGae
         oQSgZ6VObuRPNsIj70OJNo430dMIHpF5h/tlKLlPRrykGkmBXUjUPYO1BVgZ7+hiolG4
         GK77DxlFYGnn7fzxyQboZ+ccCsCIs1b9V5wITOpa4p+gI6HRfcVP/pT/ikAZwFGhImoS
         PQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683192870; x=1685784870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHpNhqVirJHtfj48DuYU6pqasfvlpaN+Pya2uIQJJVo=;
        b=Iw2Cer3QsBrfinsujoNEZV620f/N+GG9DsMeeYJxu9EezVZbayYhP8bQ/MIRPGNZJx
         XaqiHlt8CAeWiz3T0/ScA0aHDrhP605DPuTcXrsm7XZdXLKK1JuLbH4g/nZsinon5gjT
         dFw7UCrcfAA+bTO84aSHFtkk5a3jBBWn91e1SBEMp1XxUJaoSjW5Sw8kcT8EbO5Gyd59
         pMPzvPHoDsIt9OgcEsRbXgj+Sp7I59A7KT/G8sNHYhVsCOl/b62aMWGGiJ+DwExpFYk+
         iE3giYrqwW6XHI7DZcn5sPFKdi7eb5bLzJKA1Kw06af8FOirt1VM7hwoaYja1WzOeiV6
         yy1w==
X-Gm-Message-State: AC+VfDxWrBFI5wZneOAvM4miUhS77uXfi4olUeVrownbBoiJeDTbtOoQ
        obh7zfU5AQiYDCI2R1Ilm9Geag==
X-Google-Smtp-Source: ACHHUZ6uuLndnjDHvVZLxdO+9rwlDW+R6xuWDQVXD8Cv1vYeh5QLopEn0YoZzmx5Ynfbn/Y7Gtst9A==
X-Received: by 2002:a17:907:9717:b0:94a:44ef:853d with SMTP id jg23-20020a170907971700b0094a44ef853dmr6424356ejc.68.1683192869944;
        Thu, 04 May 2023 02:34:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id pv4-20020a170907208400b0094f49f58019sm18371630ejb.27.2023.05.04.02.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 02:34:29 -0700 (PDT)
Message-ID: <dfd3498c-62ab-92d3-22d6-21729dc619fa@linaro.org>
Date:   Thu, 4 May 2023 11:34:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] regulator: Add bindings for TPS6287x
Content-Language: en-US
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@axis.com
References: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
 <20230502-tps6287x-driver-v2-1-fb5419d46c49@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230502-tps6287x-driver-v2-1-fb5419d46c49@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 10:30, Mårten Lindahl wrote:
> Add bindings for the TPS62870/TPS62871/TPS62872/TPS62873 voltage
> regulators.
> 

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Just a hint - I in general ignore all the emails without dt-bindings prefix.

> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
>  .../devicetree/bindings/regulator/ti,tps62870.yaml | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
> new file mode 100644
> index 000000000000..32f259f16314
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/ti,tps62870.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TPS62870/TPS62871/TPS62872/TPS62873 voltage regulator
> +
> +maintainers:
> +  - Mårten Lindahl <marten.lindahl@axis.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tps62870
> +      - ti,tps62871
> +      - ti,tps62872
> +      - ti,tps62873
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +
> +    properties:
> +      "vout":

Drop quotes.

Why do you need entire "regulators" node for one regulator? Why do you
need child at first place. Drop it entirely.


> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false

You missed that piece of explanation:

"The set of possible operating modes depends on the capabilities of
every hardware so each device binding documentation explains which
values the regulator supports."



Best regards,
Krzysztof

