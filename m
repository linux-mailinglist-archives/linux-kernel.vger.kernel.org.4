Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC14964C959
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiLNM5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiLNM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:57:33 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B40D83
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:57:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z26so10280768lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QnNuGQfSQbAUE6GNMoYQCq2pc1i4TkuOm31eeRGtPWw=;
        b=e+ZFt79sFAl/ng3MlAFZey6LgB5BZOkoOMkfb5kawnUTlGfueRDuKQHJbYVyCLHzCh
         AbFEaxmq0iVlYA8IN0pLKGhVDeM+UaxBaqUIo2brknqUV1GkaLP5iL4eA3PHDAUFXCP9
         gKgeb4VEFxD5O4UUNm34TXfZvI6Mf7YQmsYs29QroOFOcdid3NBlolNvlO20rZ+3e2P+
         rczlJlfv4W4+iShnTLlTcS3COmFYi2q3w90AbKQM2drtvqbG8ts4rgxozpacSUyQ8a2T
         cbkxurd51/7rwkiqQ8anOst2fRaA0P3yIfWQxtWiQRwUMEAyMxTKzJh7DiLu4+lg8bKw
         LJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnNuGQfSQbAUE6GNMoYQCq2pc1i4TkuOm31eeRGtPWw=;
        b=O13cm1M9JmHpEUmlBKEfkGwAu/6IhUDFOaFouwZbolrp170tN74HdfpeIlRpfTo5lc
         Bw10PvGNR9X7ZLZoOrMbNRiNaPJ/1rWKuKelxqfP5M+jSWk6TdvlaSirDPJ0ViPgE2yZ
         hFKyE7QFIBEd6BqV3N6OdHoG2B78VC5zZde0Eb4mkt6+B9abt/pRQ95/n7RbYEg8u7Rz
         0xtngcKljuhd7vYXj1tXVoolJqerpHBA+j2jVTYQlTLL6jKHgAO2mjNKVLmwQVYNhjsc
         S/jtYhUj0TZDVZRzmE46hO/BcW8ebKQmOnzFvrseybwywZOTxx02Ei95p0oH2K4y3tjg
         veiA==
X-Gm-Message-State: ANoB5plQxMjmg+wIYIXVvuYqaRYzJ4gQuPXW+cE9qeyf6MHzugTcojpK
        EK8OFFwWnX72koDbMiNUe76vmw==
X-Google-Smtp-Source: AA0mqf4VDU7YakTwMOK/jqEwdvPiYHChwfZ97Zz6jNfcpEhL/UW7C4dB0ijmdIl1wF2fO/ngfOap9Q==
X-Received: by 2002:a05:6512:251:b0:4b6:f627:e65b with SMTP id b17-20020a056512025100b004b6f627e65bmr2079692lfo.31.1671022650450;
        Wed, 14 Dec 2022 04:57:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651c131000b0027760138c53sm602472lja.72.2022.12.14.04.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 04:57:30 -0800 (PST)
Message-ID: <98461105-a513-327f-17b7-09a1e8d572f0@linaro.org>
Date:   Wed, 14 Dec 2022 13:57:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 12/17] dt-bindings: soc: socionext: Add UniPhier
 peripheral block
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-13-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213082449.2721-13-hayashi.kunihiko@socionext.com>
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

On 13/12/2022 09:24, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the peripheral block implemented on
> Socionext Uniphier SoCs.
> 
> Peripheral block implemented on Socionext UniPhier SoCs is an integrated
> component of the peripherals including UART, I2C/FI2C, and SCSSI.
> 
> Peripheral block has some function logics to control the component.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

