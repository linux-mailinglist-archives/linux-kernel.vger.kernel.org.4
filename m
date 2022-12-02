Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB956404F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiLBKnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiLBKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:43:34 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB86BE4C9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:43:23 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id n1so4971662ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+0ulguKeXm/n7vuYd1eLCO9MpBSp6kkQ2zGIF22QHY=;
        b=plS6eIMbW/mDhBfftfW1Z8n7t5W9K5Mmg9a6PoOhB/Gv/GCVNDZBWq26hnL+vr589I
         0bl7zWf5dtuyyFwWRzdML1dSlMQfjDfYElaHi30+0izuSYsRmfV+OdnGo4sDV8jfjBr+
         5QQWmvwcfw97JBtAlIz6I5kZa3lyTQvKQUU6MMlS32xbu3yqsqLiVDMuyh6wqEgWw6LI
         ENuAwratBd1coZ4BX8QWVAVgYUhoFV3Pi0lVCjTc3nlVqvxFa/KBhtd9xrYzCdkjij9/
         2ZGyfMXdq3s4lTjyWkanpPmyR5jl6JDm5AoAKS1MVgfCsgtxwpVdUTtWUWOorcod/CPw
         T+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+0ulguKeXm/n7vuYd1eLCO9MpBSp6kkQ2zGIF22QHY=;
        b=RskdBnmmGe3PXyZgvBXIgouibeX7YJwpoe/IinoVPgcFdtBpg+TfLU+DQtXkEiSZxG
         sj7e95d6Jrcq9jqxtm0idipfwP8iutHi1uAWwfIp0i8FBkZmSSzZ+ZcrfYfZN21RlTck
         TJ+UIBlMaC7lZUwt4rVvkW/yfpbQgtDCUVU1GIJRVlzKubsk5OZepkSfz9fgfJAK7aMd
         VJorKHc9JCtuFgZWp47i77/FGdUnFOUehzqeXPWK/iDuFgxxXj29PI4zpD1Yeyda/qJ6
         CNUz+P36r7Qkbk/mml89OXEYIjJyfE8v7KI2lA5IuID3zGmwftPCgNkflN4tZ15iR0Xi
         Ck1g==
X-Gm-Message-State: ANoB5pn2wLj18hf7NzZFmNNRp0e9G/ZDYoYK2n4rjSa/x6ERfYWnb0NV
        KzyjjLRZyLJtkXwGwkLBY2nFTQ==
X-Google-Smtp-Source: AA0mqf4RmALN2uJz6Yih1UczV5VibEASyt5/O2GGhNQ/c1rtTmGSmJJA71Hj6QLdVDxJtW/rqtQOVg==
X-Received: by 2002:a2e:8888:0:b0:279:ca3e:69f5 with SMTP id k8-20020a2e8888000000b00279ca3e69f5mr3666255lji.391.1669977801676;
        Fri, 02 Dec 2022 02:43:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c1-20020a19e341000000b00492b494c4e8sm971845lfk.298.2022.12.02.02.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:43:20 -0800 (PST)
Message-ID: <9e40f25b-3223-2fa2-6f33-fe91871aed1f@linaro.org>
Date:   Fri, 2 Dec 2022 11:43:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v8 03/11] dt-bindings: clock: meson: add A1 peripheral
 clock controller bindings
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-4-ddrokosov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221201225703.6507-4-ddrokosov@sberdevices.ru>
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

On 01/12/2022 23:56, Dmitry Rokosov wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> Add the documentation to support Amlogic A1 peripheral clock driver,
> and add A1 peripheral clock controller bindings.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-clkc.yaml       | 65 ++++++++++++
>  include/dt-bindings/clock/a1-clkc.h           | 98 +++++++++++++++++++
>  2 files changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> new file mode 100644
> index 000000000000..7729850046cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> @@ -0,0 +1,65 @@
> +#SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/amlogic,a1-clkc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson A/C serials Peripheral Clock Control Unit Device Tree Bindings

Same comments as with previous patch. All of them.


Best regards,
Krzysztof

