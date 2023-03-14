Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFB06B91A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCNL2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCNL2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:28:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7A2618BB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:28:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o12so60610299edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678793323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOrTbnKTcE7CauGtKPDZAIZx3EY7nUKDtivuP9yBIvs=;
        b=olc0q14IwQ9q8wZw71hvNsbQjPxVbaB7Q1Y5ubAKoYpMubDGVb7FvJf252fUZPXEaZ
         CdZ39e8ufUMdZHhHt2arvPJAWhvWwN3NEhXw9+6z4tHQUw9ap2OijZElmtM1DUCoU4U0
         F/Ni4guEPIUoKilRDKsKY3W9XxsnhfOym61oPQl9wMxAGvJwveC63pZlgmvcvaJyJt8G
         p9ZLlUqg+8OBsgnESYiNj9x2l16/2G2jyUQQF4YBaYzKle/jxjypPZaVtQAzhtbGVqaj
         R3GJuT8bXG1MbIjatgd2qwovq8DhXH3mC02ygXejSwg+QcEe5LW9XhH1+O0EoinsGLDr
         j2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678793323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOrTbnKTcE7CauGtKPDZAIZx3EY7nUKDtivuP9yBIvs=;
        b=qQXbTevC2CRV1QRu3ehsntehOYeTibo9pcCSe0DiyOa1DDnDWqXpvUKA1ULqzoA6er
         CI2EHvMkMATGQkGx7tCw/l3U3yJVcv3x3EHB5uGjahgyZQDLPGW6pvQ3o19lTjvRkw8Z
         EhUzmpWVyXxbolQ+nKsb9yIrZnQc7p2V8Enwg9KSHkSlhRJAQg90l1GKyWpg4+mnwRan
         IIoKiiIqgAoI0jAugHS4Az9U3nRkcjdHcQtf0zvge7UGFeU6jow7tBznnjRTXH57uwaH
         ViTRv5412lC74F8RMv5gHPgm9pFWVxg791zZkA4yvU9bFVAZztkhwEnHhvrDBlnXyIi/
         8jGw==
X-Gm-Message-State: AO0yUKXD1ImnqclX4qHfDlIl6pFv/23jdQAR+r88xFV6jWNrV0rwzebG
        952gFJvHOekhNLvEKPAjE2vP2g==
X-Google-Smtp-Source: AK7set8Ex15efZPVYFuYY54Frd1acshjdF/oeAMqSwkNIBG/aUh05lW25OUm7KGUBskPUPa6E142uw==
X-Received: by 2002:a17:907:7290:b0:8b1:2eef:154c with SMTP id dt16-20020a170907729000b008b12eef154cmr2370532ejc.0.1678793322773;
        Tue, 14 Mar 2023 04:28:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id z22-20020a170906271600b0091f58083a15sm1015459ejc.175.2023.03.14.04.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 04:28:42 -0700 (PDT)
Message-ID: <ffebef1d-8447-181b-1890-3e638d399c62@linaro.org>
Date:   Tue, 14 Mar 2023 12:28:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 3/5] dt-bindings: clock: meson: add A1 PLL and
 Peripherals clkcs bindings
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
References: <20230313201259.19998-1-ddrokosov@sberdevices.ru>
 <20230313201259.19998-4-ddrokosov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313201259.19998-4-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 21:12, Dmitry Rokosov wrote:
> Add the documentation for Amlogic A1 PLL and Amlogic A1 Peripherals
> clock drivers.
> Introduce Amlogic A1 PLL and Amlogic A1 Peripherals device tree
> bindings and include them to MAINTAINERS.
> 


>  
> diff --git a/include/dt-bindings/clock/amlogic,a1-clkc.h b/include/dt-bindings/clock/amlogic,a1-clkc.h
> new file mode 100644
> index 000000000000..2b16b1f1a5bf
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,a1-clkc.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

???

> +#define CLKID_SPIFC		84
> +#define CLKID_USB_BUS		85
> +#define CLKID_SD_EMMC		86
> +#define CLKID_PSRAM		87
> +#define CLKID_DMC		88

And what is here? Between 88 and 121?

> +#define CLKID_GEN_SEL		121
> +
> +#endif /* __A1_CLKC_H */
> diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> new file mode 100644
> index 000000000000..8e97d3fb9d30
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

I found in changelog:
"fix license issue, it's GPL-2.0+ only in the current version"
and I do not understand.

The license is wrong, so what did you fix?

> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Jian Hu <jian.hu@amlogic.com>
> + *
> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> + */
> +
> +#ifndef __A1_PLL_CLKC_H
> +#define __A1_PLL_CLKC_H
> +
> +#define CLKID_FIXED_PLL		1
> +#define CLKID_FCLK_DIV2		6
> +#define CLKID_FCLK_DIV3		7
> +#define CLKID_FCLK_DIV5		8
> +#define CLKID_FCLK_DIV7		9
> +#define CLKID_HIFI_PLL		10


Probably I asked about this... why indices are not continuous? You know
that consumers are allowed to use number 2 and it will be your ABI, even
though you did not write it in the binding? That's a tricky and
confusing pattern for no real gains.

Best regards,
Krzysztof

