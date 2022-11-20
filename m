Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B816963137A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKTKxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKTKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:53:36 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEF98FE63
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:53:35 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p8so14916048lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98/dMs8xi8NaWvvTFvJfD6GibDYIKhVYvBe75X7q92s=;
        b=Q9mf+cZ5Bb9h068ZV8eN+69oBe0CxLcjU1fBv0enc/2aeGklDl/NF1R9hbjvc2njJP
         TaabQ+5s/g+lO9QGNFXFUdbAcPxCppyMK76VTP35cSmoSphH1J8p+sE4T/rSyVf9unR4
         iVnnYampFLLFarKKkdJreYIEgow4UsAvnOAsyqIuADLKMlxyn3qnWtipXx1iSvs49NG6
         0sOHXkK3i1dgdbU2/ic7xEhm0UHnrVJw1PzQs+GpE+oNgGnlr41UwvHm7he16RFrnkzG
         YwPG8e3uG3QuFiKWB2TQsyl87bRpZcu3vbcSztoxRHJuutA1Sa7k35tVQCBfUJdh/bFm
         EwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98/dMs8xi8NaWvvTFvJfD6GibDYIKhVYvBe75X7q92s=;
        b=WkI4rOVO0fIqLoGR97uU1pcM52eT6o9wRUBahb36G7ZdJ1Mpkn2ic95vBrB3mAEOw6
         fHcm1D85VxhpwXQPsJzkKcbtXcdoGhafWxuLRDy9efD8Irh7Y0Qa+NaBm2KBfyEKQy6X
         ZSagp472QI6MuD2fBPebliSzQNnpXeNKxv3x8w73ZJJ2UyPW/3wg+msQTjL6K824IL46
         c8X8HmssTZgFar9xKsfQTCDiyfmN31e2RC+JTDcfu5KCRhP345uKF+bqssbk4TKDpzRo
         NCyYUSZkD8QFhaBuzi3cgNKRcJdD3n7OPW7NImrSecUpgMTH+SuZwnhSwD/3/a7UQwnF
         ol3w==
X-Gm-Message-State: ANoB5plZtJDo0dZsXlZpN/PwpL9oxPk4MchWegCg31I5Q0ZMzu/UseAl
        xUB4A1vfRLB2UFVife65Tm54NQ==
X-Google-Smtp-Source: AA0mqf4T3JehAAdEgrmSTzP+S/PumiO70TWuSMvAGDttfJU8ezPOacCV78RytK/0eZZ3xmMIPckYVg==
X-Received: by 2002:ac2:596a:0:b0:494:64d8:9e46 with SMTP id h10-20020ac2596a000000b0049464d89e46mr4296510lfp.666.1668941614157;
        Sun, 20 Nov 2022 02:53:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c26-20020ac25f7a000000b0049f54c5f2a4sm1487137lfc.229.2022.11.20.02.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:53:33 -0800 (PST)
Message-ID: <8ecd4617-b127-b52c-3849-e78286084515@linaro.org>
Date:   Sun, 20 Nov 2022 11:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/3] dt-bindings: input/touchscreen: Add compatible for
 IST3038
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20221118182103.3405-1-linmengbo0689@protonmail.com>
 <20221118182103.3405-2-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118182103.3405-2-linmengbo0689@protonmail.com>
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

On 18/11/2022 19:21, Lin, Meng-Bo wrote:
> From: Markuss Broks <markuss.broks@gmail.com>
> 
> Imagis IST3038 is a variant (firmware?) of Imagis IST3038 IC,
> add the compatible for it to the IST3038C bindings.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> [Change from IST3038B to IST3038]
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

