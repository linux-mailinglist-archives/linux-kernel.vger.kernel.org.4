Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAAE6E3B36
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDPS3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDPS31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:29:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0772D4A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:29:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id c9so19754971ejz.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681669756; x=1684261756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tflw8i4j0TQIcG7WO4F7UB30GcbFSpnCQyqYMVOmPVE=;
        b=bDVwxcJcwqtbtexId4RVj8axjMDOOg2wduPK5x2L83Sa6rVQGbu4bBFcpktLEpQRrj
         CocLuHyOdjJ2GljFuXkqYAB5JUxGAZfbtTim8fsTdnxbdGhcAqJUy4EOECqhLMNHdSAf
         cUX1BNXyUBJS/pLwah2NgvWphLZQzB/jIeZH0uJMeSe+MV6BioG8QNSUUtaRKCsn0rO2
         hKDCemC6L9n78pYO3IFxoFljnqsOdWQYOkM/N6JvkU/3Ob9sWnRtHpMYUdlLNR6se1ma
         qFL5w4Q2mwBkU9Gso31FfO7/UfDaduQefXtQRV6UN6vagbHgD+gjVgaI6MGubKVJRngy
         lRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669756; x=1684261756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tflw8i4j0TQIcG7WO4F7UB30GcbFSpnCQyqYMVOmPVE=;
        b=RGkpsNsMzKOGNIJZpq9eCelSGC3vUwPze36IwARvEYxb8j/MxV6WGr0H8nqySsZFj8
         2zxjc0qjTmyzTu1akiO8jUmJOy96AEJTm0ImmbqQ/UUnm0AHGE08orRclP2F15bzIM/W
         aombHpfzlEifmzbEd3DdaX+LKYaGLgHCJclZqfXoOxM2cDJ9D+BrOoBmXtGKC+rPh9DN
         gDZEEtF3V4Us9Fy1uLNtQVGWO5w0uZ+Pf3dj2xcC8Zy7xwbgx47OBFWnZqOaf9sC0aSh
         2fiQF4V8ZTOib6p01mzqSsXS+hVGvtImsLflQ4H2nNRb+M/yAQSYTh4C9Ete/N4ye7Mp
         pv7w==
X-Gm-Message-State: AAQBX9eYF1wlYOWMKQaRAD0MNbdEKRKicXkQo9EFmKtlk6vIpaBmLaEY
        cLkc9Ok7IWoTmiZR1ehAowY30A==
X-Google-Smtp-Source: AKy350ZW8rl8oiwUKcc0aBNis+bj5DxtIjbCZXO5PNIds0APWzt0wW3L/pM3E+C0L5cOnAw5oNRF7g==
X-Received: by 2002:a17:906:ad87:b0:94a:4b7a:9886 with SMTP id la7-20020a170906ad8700b0094a4b7a9886mr5189967ejb.12.1681669756331;
        Sun, 16 Apr 2023 11:29:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b0094f7da9f1besm157432eju.61.2023.04.16.11.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:29:15 -0700 (PDT)
Message-ID: <7bdd986f-401e-08b6-6621-b680ef56198a@linaro.org>
Date:   Sun, 16 Apr 2023 20:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/9] Add RT5033 charger device driver
Content-Language: en-US
To:     Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1681646904.git.jahau.ref@rocketmail.com>
 <cover.1681646904.git.jahau@rocketmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cover.1681646904.git.jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 14:44, Jakob Hauser wrote:
> This patchset adds the charger driver "rt5033-charger". It is part of the
> multifunction device rt5033. The patchset is based on an older version by
> Beomho Seo of March 2015. For more information on the history and setup of
> the patchset see the cover sheet of version v1, there is a link further down
> below the changelog.
> 
> In patch 9 I didn't change the extcon phandle, I haven't received any answer
> on this.
> 
> Changes in v2:
>  - Rebased to linux-next (20230413), as suggested by Lee.
>  - The v1 patch 3 "mfd: rt5033: Fix comments and style in includes" vanished
>    as it got applied already.
>  - Dropped the v1 patch 8 "power: supply: rt5033_charger: Make use of high
>    impedance mode". The high impedance mode is kind of a sleep mode for power
>    saving. It turned out that it might complicate a future implementation of
>    an rt5033 flash LED driver. Therefore drop it for now. The high impedance
>    mode could be added at a later date as a power saving improvement.
>  - Patch 2: Changed variable name "data" back to original "dev_id".
>  - New patch 5: Changed name of regulators to lowercase, as suggested by Rob.
>  - Patch 6: In function "rt5033_charger_dt_init" replaced the devicetree units
>    "uamp" to "microamp" and "uvolt" to "microvolt". However, I didn't change
>    the unit names of the driver-internal variables in order to keep the
>    variable names short. Let me know if you think they should be changed too.
>  - Patch 9: Removed '|' after all "description" blocks in all three files.
>  - Patch 9: In the example of "mfd/richtek,rt5033.yaml" changed "i2c@0"
>    to "i2c".
>  - Patch 9: In the example of "mfd/richtek,rt5033.yaml" removed the last part
>    on the battery fuelgauge. It has its own I2C line and is therefore not a
>    subsidiary of the rt5033 MFD driver.
>  - Patch 9: Replaced units "uamp" by "microamp" and "uvolt" by "microvolt"
>    in the example of "mfd/richtek,rt5033.yaml" and the file
>    "power/supply/richtek,rt5033-charger.yaml".
>  - Patch 9: Changed name of regulators to lowercase in
>    "regulator/richtek,rt5033-regulator.yaml" and in the example of
>    "mfd/richtek,rt5033.yaml" (related to patch 5).
>  - Patch 9: Removed example from "regulator/richtek,rt5033-regulator.yaml".
>    It is already part of the example in "mfd/richtek,rt5033.yaml".

Thanks for describing the changes. It's much more readable for us if
such complex changelog is put in each patch under --- .

Best regards,
Krzysztof

