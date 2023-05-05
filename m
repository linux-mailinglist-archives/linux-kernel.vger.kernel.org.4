Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0F6F80E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjEEKgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEEKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:36:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2AE160B8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 03:36:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so25561556a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683283001; x=1685875001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6P1NvRZhmG0sW88TDzSjO6dqD9uWFc9zDmR+e/FHxls=;
        b=zW+ppvCF3A6LqCsimlAzTFaxeulkw9iDMNm1tWBlJclS2UZWdKhp95C6OZoGALDVBY
         Qp+RnIGKcF0/nNn6EqAnwTg/upcB3euxkXYV9tysHZLuvnJtlxj8ZYorThutTY849WFM
         UZhke10epqn/gyxdDC5m8iqwSVxsRr9yIxgpLz0oVB6JXIugeBawAFBVrAeA8Ipa3Jto
         oVTT4dnaQns8eZPNzjAwlqeniebCWzyX0Kt3XEHwkmojocqXoAqVeiTcOBG/DH+K8FnT
         f4Oz7Itdw6NP8TxEmFl4HKhfrYz2iuZtlTVlxEkadhWICYSC5G7gQlNafCbSimbM0lbU
         c/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683283001; x=1685875001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6P1NvRZhmG0sW88TDzSjO6dqD9uWFc9zDmR+e/FHxls=;
        b=Zi2II8Jy7hiZJ/D8oTx3T1oaniqd0iRjsvYA0xCVQ5dujK1zwHagU7hfR2ZpQY1zHE
         rQ8cbUqFB3Pfbu51K/RDdaEyxmimUVDJORjKUI7MltIZwpPWjhHo3dIYZrzXii/DDW7r
         bcRz2J+zlQvlZUN+pVcMAu8VjnrZbwz+FOK02JJd2vptTtbYuqevwHqr1PGiZTHvkRil
         Yfy3fzpOX0OyZvo2gY8yiMc4CUiGsXvsjtOjD/z8irT10p7kRkONgT5b74tKRIipk8lH
         L/Gw1hvysbI3xEv4nufGp/rBQYKJREx7TwBgUt5Vr4WR+dAqceMZhFB/Lr9fjy37PzvI
         14hA==
X-Gm-Message-State: AC+VfDz49rLGJF5qBa925Z1EIukWTDDpc6nfo2XIy7yhBhKCaSeyrk62
        Av8xvLDvGDJeIkScyXNrPMz77A==
X-Google-Smtp-Source: ACHHUZ56QCUbLannYrh+1hd0xTKIV8jBso/IrDB9gcmJyCIVljROHj1xwm/qgoDSJnj6TxFx2m1ggw==
X-Received: by 2002:a17:907:3e29:b0:94e:bcb6:5f31 with SMTP id hp41-20020a1709073e2900b0094ebcb65f31mr1703620ejc.20.1683283000995;
        Fri, 05 May 2023 03:36:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id ml13-20020a170906cc0d00b00965e1be3002sm629175ejb.166.2023.05.05.03.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 03:36:40 -0700 (PDT)
Message-ID: <20d58d52-afab-dced-1d55-c839b8938595@linaro.org>
Date:   Fri, 5 May 2023 12:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: misc: brcm,kona-smc: convert to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230504190250.GA10108@standask-GA-A55M-S2HP>
 <30ee7d92-cc95-ba83-89e9-a2465cbd2fb7@linaro.org>
 <20230505071822.GA3236@standask-GA-A55M-S2HP>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505071822.GA3236@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 09:18, Stanislav Jakubek wrote:

>>> +      - items:
>>> +          - enum:
>>> +              - brcm,bcm11351-smc
>>> +              - brcm,bcm21664-smc
>>> +              - brcm,bcm23550-smc
>>> +          - const: brcm,kona-smc
>>> +      - items:
>>> +          - const: bcm,bcm11351-smc
>>> +          - const: bcm,kona-smc
>>> +        deprecated: true
>>
>> That's not correct. You deprecate the same set as you allow before. I
>> think you wanted to deprecated kona-smc alone.
> 
> What I'm trying to do here is to deprecate both compatibles with the
> "bcm" vendor prefix, as these were initially introduced in [1]. bcm11351 is the
> only one that ever had the "bcm" prefix, both bcm21664 [2] and bcm23550 [3]
> were introduced with the "brcm" prefix (though they were never documented).
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=7f6c62e2695bcb1547afdeb4ad3bcdf8c610be2c
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=2eba905e860f8aed5f2743b45259bb2e92548a55
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=fcd4138653f049c8fa45b48dc5f2806ced68e304

Ah, right, I missed the difference in prefix. I propose to just drop it.
It was deprecated 10 years ago!

Best regards,
Krzysztof

