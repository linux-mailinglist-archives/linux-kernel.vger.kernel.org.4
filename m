Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4587263B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbjFGPHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbjFGPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:07:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D68F10CE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:07:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9786fc23505so309486966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686150467; x=1688742467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pEWmF5LkerK8vtfqr7UM8riIZv0wnrEgKW36Y8tAnE=;
        b=s/r+BIg8+uPRyororIUyKPf/P2dgCGgyWzqrSvh4HJRTsOQnt8ScwbYgXWWHRH7+kk
         xGokX5VMhVdZG9fWurcsMyYnqB66VE+dtxM5Wx2Zi22yqrqOVCYoS5UP64Fm7GXm6Yw5
         GxYE3/Z41SoVG5DZVRgSoot6lKgl5cpwBKT6HEYdhacqkf1PbDLiA4IFkdgRBcvk/OiG
         toipGCgcGCY9LqkpAd+RnPsdHtFtbIyqhAYti0bZFMb7WTbPhXX4jAmHpOBIRvGMt+Rx
         t39TfV0vfzY9/7JmsHu4HyeOEsUTlKWTbPmZFcEw6tOC5+PW7PTG1NN1/V0DQrUGubFL
         JoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150467; x=1688742467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pEWmF5LkerK8vtfqr7UM8riIZv0wnrEgKW36Y8tAnE=;
        b=fVzAdshpNq84WxdgbnQqHvtYlitIrtPCLTY9EV5y4aM3h76+4OsiPuB2AM4Zs4O9hy
         UFpSGchEUX7M2zr0PCUd2J7P3ZxAC+edmOtnxGqlRyRyzozrl8J1tDZhuZAxvEPQDmPf
         GoSGe3jactBQr9r1Ct037sXYOml4H0kKMqKJwkBYTb7SwF2o7XB9MeNMky/rpugDqy+a
         LevMD9A/wHggpvghYE2s/7DwKfRNkLfHtkPBAIzRc9HXZITc4It1U6pRZwLlyoJYHopz
         aiy5C/YfJ09Q0Gxl/QCHYnUL15OHRnpXSUocs3JCEujPllrTIvjZ4Fvj0IQBZyvooaTn
         b8SA==
X-Gm-Message-State: AC+VfDy50zsIlhXyam76tMtySdv/Cg25hnt78oHo8MRyTMP0n+yTazgx
        8qyf/0Ipo+uRgFgcuaiMC/6I5Q==
X-Google-Smtp-Source: ACHHUZ6jNU3FR44kx1P4nQzUDhzkZwXyb6WTXFN9fPcxgb3oW7TCYQPqoPFf6j/hfLL4ghktHSV8Kw==
X-Received: by 2002:a17:907:7282:b0:96a:ee54:9f20 with SMTP id dt2-20020a170907728200b0096aee549f20mr6922708ejc.37.1686150466661;
        Wed, 07 Jun 2023 08:07:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lt3-20020a170906fa8300b009788d8389e9sm281874ejb.169.2023.06.07.08.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 08:07:46 -0700 (PDT)
Message-ID: <88740a95-d7b0-e5d0-62db-65b41c66c5bc@linaro.org>
Date:   Wed, 7 Jun 2023 17:07:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Content-Language: en-US
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
 <20230607095802.3adcd4f9@xps-13>
 <166bdc27-f77c-9076-f866-180cfa5bff76@sberdevices.ru>
 <08da4e86-433a-7d2e-25ff-ffa24221abdf@linaro.org>
 <835a3587-1e0f-64d7-1d1a-b639ae8b7307@sberdevices.ru>
 <2ca6e619-1d57-8fff-6176-9ee890e0d167@linaro.org>
 <5ca9eb2b-4bc8-5883-a029-3eeca905fe6e@sberdevices.ru>
 <20230607113605.50a992bb@xps-13>
 <6c1973d1-38c0-6048-90ad-da2f60df8238@sberdevices.ru>
 <9105207b-0dfb-346f-422f-984cf3454f90@linaro.org>
 <57ccf7ac-7d94-8a66-7a0e-abfe14f7df2c@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <57ccf7ac-7d94-8a66-7a0e-abfe14f7df2c@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 16:55, Arseniy Krasnov wrote:
>>>> The bindings and your driver internal representation are two different
>>>> things. Anyway, as mentioned above, wiring the RB line to one die and
>>>> not the other would be valid hardware design and would require the rb
>>>> property to be in the chip node. Please perform a per-chip property read
>>>> in the driver as well.
>>>
>>> Done, I resend both patches (bindings + driver update) as a single patchset. Your review comments
>>> for driver code were also fixed.
>>
>> No, please send new version, not the same. New version means with fixed
>> comments and with patch changelog.
> 
> Sorry, Yes, I mean new version, here it is:
> https://lore.kernel.org/linux-mtd/20230607145026.2899547-1-AVKrasnov@sberdevices.ru/
> 
> There I fixed bindings and tested it.

I still see v1 and there is no changelog. So it's the same?

Best regards,
Krzysztof

