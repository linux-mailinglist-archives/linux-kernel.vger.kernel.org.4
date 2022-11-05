Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD45F61DD55
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 19:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiKESoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 14:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKESoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:44:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98D81572C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 11:44:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x21so10670572ljg.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZqM95oaPnJH5MWhlRXsh/pWYkhJUcy6fi/S/KLDeWUY=;
        b=i8fgFmifmE2Phhsq1JPfWQNpmrQX0+ooyicsgoxgtQAmqDeRap3MBc7AoGm0MJ7M3M
         Har1YTulusg/2t3IN/iBpL3sK3EsnGVE/pGFJlCjTe1xrZb46hVwZKzfz65FOmc1Uz8R
         rmwsRRKwlnbGBfN4dYB1qptl5Yfu1PNVZV9rOH4zQFXNYqjRBCMOwVBHgUW+Vrfxawt6
         wGf/Q0BoF2U23YLWy0YQVKf3Q2oRqK1PrEldxJ1zHXSS6wPpoq7WK/wC/qjetG32yN47
         Q1lq/MB7nBpivCwjpjVYSsbjan0knjOuKIqeZZPKM6PNmY0W2Voove26aW731rivYfKm
         nmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqM95oaPnJH5MWhlRXsh/pWYkhJUcy6fi/S/KLDeWUY=;
        b=G06K9bVzRv9talOWPsVj8zvHzJeQeVP4ZTi35+OcSa8ylHlZAI8YNfFU96Vr4R8YJh
         I5VYwY8iZS93L7V/A6N8UBIbZ42+2s+tzlS4A5y+EZj6r9rhG6qK539EzJ1ZsPhstnYj
         igetcf1FWFQFUjjS1XC8ZaR9HMBfMqPO6hvW09r+TS6QYWc2I7rmOkZxbD9HSsyqxidy
         Cgav544e5pwm6+4OlIpiM+AFwYwRXd0jkzCiD3Es0BEZ79BaWTPCtHvHI1sy642RYc3b
         Zt51uwhwMUiHnqRKX4bSnJkmA7ng+fr6/4w097yPUrgH7P1cgkIzdsIhDU3DJdzPjQj2
         swzQ==
X-Gm-Message-State: ACrzQf3JG8p9269AMIka6vfBQ38yJXaV4o4R9ejPBoLRnuVj2bqjXpcb
        NSTMP1/hLGCxE4fjOUriYWwshw==
X-Google-Smtp-Source: AMsMyM7OO4zYB/vcy8i1R2jRRjgDN+xMBxQNR3RbzhMCOaS4aSSPJtSTQhnXBAgmsT65yZmr79W0Ng==
X-Received: by 2002:a2e:91c4:0:b0:277:e53:151a with SMTP id u4-20020a2e91c4000000b002770e53151amr15950844ljg.81.1667673848114;
        Sat, 05 Nov 2022 11:44:08 -0700 (PDT)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25e75000000b004991437990esm386360lfr.11.2022.11.05.11.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 11:44:07 -0700 (PDT)
Message-ID: <35b095a0-6bda-32c2-99e2-6815a852f9f0@linaro.org>
Date:   Sat, 5 Nov 2022 19:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: document Delta AHE-50DC BMC
To:     Zev Weiss <zev@bewilderbeest.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, soc@kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20221105013321.2719-1-zev@bewilderbeest.net>
 <20221105013321.2719-2-zev@bewilderbeest.net>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221105013321.2719-2-zev@bewilderbeest.net>
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

On 05/11/2022 21:33, Zev Weiss wrote:
> Document Delta AHE-50DC BMC board compatible.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

