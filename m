Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6286E6F28B0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 14:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjD3MMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 08:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjD3MMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 08:12:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618781727
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 05:12:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc4d96e14so1241080a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682856754; x=1685448754;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOAkIUSEs7b6pvNH1SS1me48LA5OZVukhoF6fPz2AOQ=;
        b=Nm3VM/IAufTLdrkTK40snaxHL+7z5i3QOLjw1eiVb/wjvbq+Oyoc0qoGRTK4ukeX6X
         qAizpdccJ2zfAb9vKvnRkTqMHBxivJRODQAYDBEOULPy2GDDO1zS8V76qIL5nEdp3Vka
         FkEZfukZV346mOXHhj93xj0wHU+NSl7C32dwCeKi2HI0GgjaA4DJcEDGrR3s5DD+deYZ
         fTTUiXxLqLl4TL00Qim8UaiRuNIF2ct2Mp98UE5ZDVNrQ0x6Yk4G3B0Q6konTUILCKgf
         8/ExdeblcDp4lzZLFwfliN+XhNQ/zo04v+S4xNeTYtC5Y6MwdELvlBTTIzMpnN0HZ+IB
         zvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682856754; x=1685448754;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOAkIUSEs7b6pvNH1SS1me48LA5OZVukhoF6fPz2AOQ=;
        b=ICLTQzydoH842Ie2q7vLKJy1aWbSLdKzn5GKGq9Y7D1jUUt0JivvdfMeSeBW4oup5I
         mAIxJt2LTfFjabyLj89SkZjS7RZmlyAHUDsdVfM5i3iTwkzEJNFf71RE750jYLFcqwnc
         EkHjrG/CtwsdH0k3diCm6uoNcZ0sYouEdALfrhUowd9ZQu7F5BJCPLuiJXcuzZ06zDGZ
         /z90ut+DHXuvkqSmVwaA6n9BLKMnfHPozTDt8z2gNljoM7yWcQiJhGQSGSTaufMSbP30
         eF6HjtsQM/pkOgmnKu11Abn1tu4t5ImpRcVh2ij3/UPrU//dlZhmfIVjiDowqUEm4Qjn
         weGA==
X-Gm-Message-State: AC+VfDxBA8w9oqlBeg81BmjLSLkogCPdxKRs9ascE4UtyR34QszkYBVu
        pMiE14K0DHTHiwJBvtpBC5GCeA==
X-Google-Smtp-Source: ACHHUZ5vH8qhRuHSQ+Tiok+SsLg5uU8X83UFPedVxJQtdsvj32geMRotH8gGl3QtxwPoko8dEjLKxw==
X-Received: by 2002:a17:907:2da4:b0:94e:83d3:1b51 with SMTP id gt36-20020a1709072da400b0094e83d31b51mr10241997ejc.23.1682856754746;
        Sun, 30 Apr 2023 05:12:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4f23:e9a6:a1cf:ebd3? ([2a02:810d:15c0:828:4f23:e9a6:a1cf:ebd3])
        by smtp.gmail.com with ESMTPSA id hb8-20020a170906b88800b0094bb4c75695sm13630346ejb.194.2023.04.30.05.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 05:12:34 -0700 (PDT)
Message-ID: <d10e48cf-3cf8-89b7-8741-260adccfdfed@linaro.org>
Date:   Sun, 30 Apr 2023 14:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: brcm,kona-i2c: convert to YAML
Content-Language: en-US
To:     Wolfram Sang <wsa@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <9875ec0211187e4f5e2a4379c63eacdb69b31d7a.1682252615.git.stano.jakubek@gmail.com>
 <72ba28004afb733224f7294a146fc2a6a5a834a7.1682252615.git.stano.jakubek@gmail.com>
 <168234258850.2489090.5138716439435477956.robh@kernel.org>
 <20230426172354.GB2506@standask-GA-A55M-S2HP> <ZE4Q6p1tAiIoZo/M@sai>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZE4Q6p1tAiIoZo/M@sai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2023 08:55, Wolfram Sang wrote:
> 
>>> i2c@1c000: compatible: ['brcm,kona-i2c'] is too short
>>> 	arch/arm/boot/dts/bcm23550-sparrow.dtb
>>>
>>
>> These warnings are fixed by the first patch in the series.
>> Maybe it didn't apply?
> 
> So, this depends on patch 1 but I2C doesn't pick up DT changes. So,
> shall this go via arm-soc, then? Or DT? Anyway, for any route:
> 
> Acked-by: Wolfram Sang <wsa@kernel.org>

The dtbs warnings - if fixed via any other pactch - can be safely
ignored. They do not affect bisectability. Please grab this patch via
I2C. The DTS will go separately via arm-soc.

Best regards,
Krzysztof

