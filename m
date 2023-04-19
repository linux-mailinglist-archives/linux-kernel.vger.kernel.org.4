Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F036E7565
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjDSIgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjDSIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:36:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757D67685
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:36:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fw30so26805832ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893396; x=1684485396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edUAJMsfug4ERHT62YNJ2g3PSl5FoBF2DLnU/gsW8yw=;
        b=x+6lq8VA6Wh3N4QZXH/MAaqL4b8LGhILplBuW0D9MUaJMldCLatHlIh33DUgHIMXIm
         EgJwWiISpSiT3XUnBPOEdG8qBeY+RfFrJ20AprkWP6zjbxclOBALbWDb8Y/x4lfPqxCs
         SdsoBjsbXkFL+bZr3jIMtti/fPOIGENhd2Od068KCL7mqJCTjmcc1CMYuLB+XuEa1vts
         5Z/yFH9uFWDyaf4R+jhj3wCIk9TY49R3RRu/PT8SAmhohZwz/OYio+Qx7rvmu7Ke2/qP
         ScDxSWer+RxI54geRxExP/+siXUaAdkyVsJf03Zb9W1gIBGu3YghwGl/Eu5KuMqAnVV1
         L7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893396; x=1684485396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edUAJMsfug4ERHT62YNJ2g3PSl5FoBF2DLnU/gsW8yw=;
        b=jXxEqnwSDBjLR3K/V3UfP4zWc97o8fI9f2W6143e2bj+ibif0WTq4y6buSRwJdJpwN
         nwBO2oLqFRvphWn357vBL7RKxF0jYcgA0bCXLTHviYe98AYDRzdbLe76r9f8CtXHwiNx
         h1Aeoc7W0gVbM5urZCQGsvDSKHwgQWLZhtr6TM6CgMp08vudDWwB3L95aQ1DdJg+lcAK
         kw/9ReAbcjDkGFVKBQ2W57nKOFkmKMm2irg16kNPl7Zo3xI+dZ1Ap/0jp2XfMZF1IVL1
         5awi7dgDQKltokN4E20kmcGVzNIAwdE8/JGRnF5RmywYLmXonXdVHLqKpglDXgnmkpzA
         DYhg==
X-Gm-Message-State: AAQBX9dYL/YimqQGGVhhsgkzimyqrKZ5deYox1pb0PW/hOBgqZxyQlUg
        jZDfXDU8wQQUv+1la+5xlF1dBg==
X-Google-Smtp-Source: AKy350Zjdh/Ctd+CjJNcauM9g46sPlL9BLUYK2qJYJ5AxUNa/z27E/WeOP+dvPY7hvDJx8fS0txvIg==
X-Received: by 2002:a17:906:4c4a:b0:94e:4735:92f8 with SMTP id d10-20020a1709064c4a00b0094e473592f8mr12841404ejw.27.1681893395938;
        Wed, 19 Apr 2023 01:36:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id kt2-20020a170906aac200b0094f6458157csm4562796ejb.223.2023.04.19.01.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 01:36:35 -0700 (PDT)
Message-ID: <503a69d7-1adf-2a5a-b29d-8d873570e61b@linaro.org>
Date:   Wed, 19 Apr 2023 10:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] spi: s3c64xx: changed to PIO mode if there is no
 DMA
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
 <CGME20230419062755epcas2p1370c1ca60d88d6b114a7c7c1de3f15c0@epcas2p1.samsung.com>
 <20230419060639.38853-2-jaewon02.kim@samsung.com>
 <41ebe41f-d773-7cc3-dcad-8574c858645e@linaro.org>
 <e29c3c88-e487-75da-662b-6720a1ef1dc6@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e29c3c88-e487-75da-662b-6720a1ef1dc6@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 10:31, Jaewon Kim wrote:
> 
> On 23. 4. 19. 17:03, Krzysztof Kozlowski wrote:
>> On 19/04/2023 08:06, Jaewon Kim wrote:
>>> Polling mode supported with qurik if there was no DMA in the SOC.
>> typo: quirk
>> You missed verb in your first part of sentence. I don't understand it.
> 
> Sorry, I change this sentence like below.
> 
> Polling mode supported as a quirk for SOCs without DMA.

I would say still verb is missing as supported in past tense does not
make sense.

See:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 


Best regards,
Krzysztof

