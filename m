Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49254691E78
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjBJLiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjBJLiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:38:15 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A373E72DED
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:38:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso6070725wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3AfScb5eZBvuleQTKe5gvMdffqFNjAeOX6lI523hQE=;
        b=asmkAOnSBKcu3XreoHNmILuUKNc/O5vXcAx16D9bRMvAcqlhx5cTBBNm0tKvQ3rgex
         f0Bq51Uwmmx0s2dB9RyO9NLeHrxNYWJEK76BNaNLyDrKXfcj4Ynfyrh3Ub0+64672wtg
         c6s1fETV3nNjhgs/ccwSbzsIRS2caC4jhGyMb+VDouBbN6h+WBm991X8M95leA0HmRmr
         Omwu2BxnUDZhaXzWKfIh5jIODy5gV1lacSU9icmnYnaq0KryF4K0Npk9zx7F4QCMME25
         Mu5itB1MRcVrMLpHB448z1asKPcl6ZIdJ5ZtaZZ00JLN/ldWkhxpEUMBefWWL5lHbXtO
         r0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3AfScb5eZBvuleQTKe5gvMdffqFNjAeOX6lI523hQE=;
        b=gbCL1n2nlWq+8J0oa2dVIdPQzMH6D4vD1GXxyINgpnpHxRFD+mPjTIFddGFEmJhh5q
         D+z0srDD2bRqmETIP0vzQl6bxEt3hM/Yx3EElOXOOxrR4GRGqYJ3o/oi4ElwFfikp0k6
         3YdwQwKLYT08UG0zWjG58VzQJt0xH2dJe+u8nncfkftzk+0mnO4CjwyDALIV+zMUneB1
         F0+/gYJhXkUr1YQez+iqklpLEkEyfDoCN8sv5KfguE1qLjT3GsyFYeZba8VGKc/hVz3t
         dH82ryJTcwFCh94TMJkDLv9qt9IgSdnTKCXFoHkykLt5XO7lE2yjCwuBksPLDmeiKjQw
         Q9Mw==
X-Gm-Message-State: AO0yUKU6RxUWeB4xrIBRSk5Yi4yWJ8KLK/IPmMmvhPenxIZ8WubloqWK
        b5uMcSTLDVS23DfdmLeRWegC1w==
X-Google-Smtp-Source: AK7set+uEknYw9udTW1kl3Txp9GCn0dwLcAHml7YyNdx8cs9cBLJqKM2WD3mlV1dCTNf8dW4llZy/A==
X-Received: by 2002:a05:600c:ccd:b0:3df:e1d8:cd8f with SMTP id fk13-20020a05600c0ccd00b003dfe1d8cd8fmr9580566wmb.6.1676029092269;
        Fri, 10 Feb 2023 03:38:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003df245cd853sm4408871wme.44.2023.02.10.03.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:38:11 -0800 (PST)
Message-ID: <c06f5b63-2667-2a01-fa1f-7efe4c6f3867@linaro.org>
Date:   Fri, 10 Feb 2023 12:38:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 1/3] dt-bindings: clock: Add Loongson-1 clock
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230209132614.1079198-1-keguang.zhang@gmail.com>
 <20230209132614.1079198-2-keguang.zhang@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209132614.1079198-2-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 14:26, Keguang Zhang wrote:
> Add devicetree binding document and related header file
> for the Loongson-1 clock.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V1 -> V2: Change to one clock controller
>           Add clock-related dt-binding header file
>           Fix the warning of dt_binding_check
> ---

Thank you for your patch. There is something to discuss/improve.

> diff --git a/include/dt-bindings/clock/loongson,ls1x-clk.h b/include/dt-bindings/clock/loongson,ls1x-clk.h
> new file mode 100644
> index 000000000000..579552c5f14b
> --- /dev/null
> +++ b/include/dt-bindings/clock/loongson,ls1x-clk.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Same license as binding please.

> +/*
> + * Loongson-1 clock tree IDs
> + *
> + * Copyright (C) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> + */

Best regards,
Krzysztof

