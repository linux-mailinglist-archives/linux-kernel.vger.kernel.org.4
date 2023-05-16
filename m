Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EF2704903
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjEPJVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjEPJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:21:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EF49E4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:20:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso20803474a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684228833; x=1686820833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKmrFlgSWX+t+l7PFgADejC3QH11/GIGNmgdRMFWF4M=;
        b=wNjphbz7UyLurZVuOw11aYjCR9pjaj5kpOwiOgs5llFTjhoQ2nXjO7AkDn85sl31VK
         AzibSy1qBWebYtFSQHQcm9jsOY4JZn8F+S3tGoAWBlKaORwFqBgNo3LnwLF+g/hJcy37
         s/lmssAGNCtAFfqz9EqYzmCTG1ZpMZtO1Gp2v+IZus6A7PKbpxrn66+lB23RkxiXm+ze
         ADy5a4oSp2rYpBfugLJDh+i1YPeC3gt8PnDhEqiMRpCcPTBJ1D4mRFjbOEMe5RoKk4XZ
         VqUMml0LLnFBkYhtMFX1QJfA2LYdgiJgKYnkE0qjxoqpJG3AHLyunTzBzWTMIY8ZhB4M
         H83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228833; x=1686820833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKmrFlgSWX+t+l7PFgADejC3QH11/GIGNmgdRMFWF4M=;
        b=Q5yRs1FLs9+2yeLr6KufCOe3qwGWDUOjSByij1gnbRQfDDRY5shWTEPMI0h94FsI0Y
         uOyEBshZdT3WkaY97tAxoHKDqrXMCnVI//7nyzkf+9C2dvPPPQKu9vZNX+6ch9H5s+CQ
         cCpZ89GOgE41MRreqgsImPk6AG6w971u5ge6pWcrJ+zsL51iDNrR/8d5lwu08sG8YGrX
         +W/QW3Q6l5VRGdvDkjipg5bNSKr4dcvQDHUU6zLG4Vn26/aF55x1/zi97cLVKiDPT26b
         b3DH1vQshkpPhV01dxe+c05Fge3D8EE9tU0jCArWYzLrV6xxHyMD89Mph2mJer1VeJNH
         QeMg==
X-Gm-Message-State: AC+VfDyYQH6i5J5PvmKqPIqlurWvYVnpapUzvQpGpodkR5IIMojIeb7H
        OvXCEcOeRVeoeBZuI/Mw21qk1g==
X-Google-Smtp-Source: ACHHUZ6BJWFuWCwXtypRGM2NV6a/s3a/P/PDkDpk8hHfQebAywD0uX9kjk0A0N0fAJ3zx6ufXn35Nw==
X-Received: by 2002:a05:6402:202a:b0:504:8c1a:70db with SMTP id ay10-20020a056402202a00b005048c1a70dbmr31410720edb.32.1684228832934;
        Tue, 16 May 2023 02:20:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id v16-20020a056402185000b0050cc4461fc5sm7874223edy.92.2023.05.16.02.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 02:20:32 -0700 (PDT)
Message-ID: <c4d30304-08d8-6a31-8f91-7840fe2922fb@linaro.org>
Date:   Tue, 16 May 2023 11:20:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 RESEND 0/4] Add S4 SoC PLL and Peripheral clock
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230516064736.10270-1-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516064736.10270-1-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 08:47, Yu Tu wrote:
> 1. Add S4 SoC PLL and Peripheral clock controller dt-bindings.
> 2. Add PLL and Peripheral clock controller driver for S4 SOC.
> 
> Yu Tu (4):
>   dt-bindings: clock: document Amlogic S4 SoC PLL clock controller
>   dt-bindings: clock: document Amlogic S4 SoC peripherals clock
>     controller
>   clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
>   clk: meson: s4: add support for Amlogic S4 SoC peripheral clock
>     controller
> 
> V7 -> V8:
> 1. Change patch 0001/0002 dt-bindings title description, remove "meson".
> Suggested by Dmitry, Neil.

So you only removed one word from title and description? This does not
justify dropping review tag.

You already got a comment for this - add the tag.

Best regards,
Krzysztof

