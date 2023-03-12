Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DBF6B68CC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCLR3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCLR3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:29:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5555D46160
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:29:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id da10so39986610edb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678642189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxYyqt7C2nkBChfw7xRazh33TpU0YO4rKgpItaaFBK8=;
        b=K0w8cqhO1cKFYNFzU+/0Vr3R4cYQ4RAQN0/6zsxLjlIbTfB6ZJ7dmisxSteUToo8fY
         4wBitFWrzT+/N5Z8is240LXqFrA/QXhCmZfECaB91+PhIbTaKiP/Rp35OU96kHp/LLuF
         hyYNbIr0dmiiERgXBLooZnaE4pffxHmcIQxt7tvFivo6AhZg5YCG0Kryi9h/BKt+81+a
         Jh8f0xf4LBLHapc8482rhx3a97IqSkf54nLtoko0rCFZ+8sRGWYhvJ15mSbEo84jR/Ke
         /P1o0g9lZ9qXu/5VDad9jP8ym+CTCT80NthVDp/L+kxNp+CmCWD/TyLNgOnL1M28clCI
         XmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678642189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxYyqt7C2nkBChfw7xRazh33TpU0YO4rKgpItaaFBK8=;
        b=Dz1pPIr47Yc+epmpE21wn+w3Y2KJkEg2n1t7q6osXsfD5Zi6ilt0trx0/D4l3ppc2P
         8SUxkg2ugIFLmNCrp8qUncK4sIzJFiNJcqZXnWQuXJw1p7CqlrBo2opaCWwGh4EE0yu8
         1dxLd6b7JDiYrXH++aQEsRS1zb/rWZxWsWNR5eEJ/V/vP0P6jBCyUFLIrCM4+cxgt87h
         wiE4xq99UW8Vyw1gW4CunjImcnJSu0zXV/gSBSh3Odnxh+HZj2qpVoKqo2N9UNzjzgj9
         C9Q02eTPmnuflYiAsLRtvhPq3y+fuKKZ8Wo4Mi2hbF5f0+az4XhlDv7RHgos3YkfJyuD
         wuQw==
X-Gm-Message-State: AO0yUKUiNEI9yUabyMrd7up/kmtrIPVt9WC18UiukNsRbrPVgSUvHczi
        qQZGG0tebyPS8e0X1EvaFabp/Q==
X-Google-Smtp-Source: AK7set/8/0R7GalSBzGksp0r8lZEcqHwCIpaSotNVtlyPhysgmKmdXCCL1e3cm1oz4it6IEqgemeRA==
X-Received: by 2002:a17:906:4fd5:b0:927:8285:18a3 with SMTP id i21-20020a1709064fd500b00927828518a3mr2046753ejw.0.1678642188807;
        Sun, 12 Mar 2023 10:29:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090637cb00b00926f89e2213sm724617ejc.190.2023.03.12.10.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 10:29:48 -0700 (PDT)
Message-ID: <9f197b20-499a-7437-bff3-c5fbd39b5387@linaro.org>
Date:   Sun, 12 Mar 2023 18:29:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <640e0b2d.c20a0220.63661.19a4@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640e0b2d.c20a0220.63661.19a4@mx.google.com>
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

On 12/03/2023 18:26, Sergey Lisov wrote:
>> Thanks for letting me know.
>>
>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
> 
> OK, at least its codified somewhere.

You got feedback from Devicetree maintainer. It should have been enough.

> Still, this results in the opposite
> effect: DTBs written for one SoC, using compatibles from other SoCs just
> because "they are the same anyway". And doing this properly, well, results
> in essentially duplicate compatibles.
> 
> And "fallback compatibles" won't solve this case anyway, as there is no
> common compatible that denotes "Exynos7 DW-MMC that has the bug".

Your explanation is not correct and we talked about this so many times.
No wildcards in compatibles. That's the rule. You cannot find any
argument good enough to break that rule.

Best regards,
Krzysztof

