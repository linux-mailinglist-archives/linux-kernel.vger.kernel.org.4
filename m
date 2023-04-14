Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DBB6E1D70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDNHqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjDNHqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:46:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F28410DB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:46:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id xi5so43482616ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681458375; x=1684050375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJMpHJ9Id0D2MrYTYA9hknAdsv0k6501D9t8I/C7d9M=;
        b=txlFOjH8fFM6V0K2iqGzmAMMCIm43mrgAtn5O23gUflpUzNV2Rpgqzyj34lkHelagh
         3Z9I7b94i2jt6d7RpXZOQITxQjp+vvYbZP40/eRiJ5v33/skX6S2k2uc4E3SstTfxI18
         sZA7P+JpURGiE2tCWB04WomqYjwXeRzI8nmK3m2Of569r+/GB45NMjRc1lU3+fW5aaQY
         oLQgQ/MMNAsRgt5L7XpdVpwiXp6+n/gBS6y4S0KYEH+x0gHcih330c1HDX4hLyWawHKs
         bgurP0rC3kXMr3wOevYaMkVAXhnctMSAzTqaUSSkrYMFod8sxeHuzQKI2cjbhhIXGC2e
         uVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681458375; x=1684050375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJMpHJ9Id0D2MrYTYA9hknAdsv0k6501D9t8I/C7d9M=;
        b=JkMWfCET0L2+q6GGSEj6qcDVLgVZQSiJnUOpDTid16MWj3Xyf+bahyVxpNoBRux05F
         o6vpz1DOZXAKSANvPNZ1svthTBZywIKqpezCG6zrsujB+Yn7j3dlSphan2vCDoRg1wru
         Yp2JVwZ5MKUPxRFoc1DPfDZximz9wDtUHGJqluuyGZhheTEXBhZoHKALLMhQ4ddRJICR
         boVBXT3RFTp1PfD8UFHa16hZOU0dgXng2KEXy+iq/7LyrJeu/ps2sydb9/EOOCcmuNLk
         P/U0gToM2KuGSUu1X9i7MrbvjjEDGBquz+3B+/C3pf1C350A7aDlxnKsxw/v6B5GShgX
         LbTA==
X-Gm-Message-State: AAQBX9ekOv3NSAS4lE4LPOITUUROmJ8EDyfncnfZuIGEJBqyobq9h5T4
        OUrnkFhvHqX+Y1qNbgzTAZH/Sw==
X-Google-Smtp-Source: AKy350boGKzFJ21zxd7dL/1s/qxBNhWGZUduYhPtCkpcSN3V6n/4aQoosh6V9eTJuVzLb50Doxr4Vg==
X-Received: by 2002:a17:907:20aa:b0:94a:93cf:6b11 with SMTP id pw10-20020a17090720aa00b0094a93cf6b11mr3725931ejb.27.1681458375074;
        Fri, 14 Apr 2023 00:46:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id tg4-20020a1709078dc400b0094ea3a32694sm1969651ejc.190.2023.04.14.00.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 00:46:14 -0700 (PDT)
Message-ID: <5a59485e-5421-0cd9-ce51-79cf0fd6da79@linaro.org>
Date:   Fri, 14 Apr 2023 09:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 04/12] dt-bindings: reset: nuvoton: Document ma35d1
 reset control
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-5-ychuang570808@gmail.com>
 <874a1e5c-f82e-68d7-3617-042deb928071@linaro.org>
 <41807e8d-b081-6c91-3fc8-f273770ea493@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <41807e8d-b081-6c91-3fc8-f273770ea493@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 02:55, Jacky Huang wrote:
> Dear Krzysztof,
> 
> 
> On 2023/4/14 上午 12:58, Krzysztof Kozlowski wrote:
>> On 12/04/2023 07:38, Jacky Huang wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
>>> between the reset controller and reset references in the dts.
>>> Add documentation to describe nuvoton ma35d1 reset driver.
>>>
>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>>
>> This is an automated instruction, just in case, because many review tags
>> are being ignored. If you do not know the process, here is a short
>> explanation:
>>
>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>> versions, under or above your Signed-off-by tag. Tools like b4 can help
>> here. However, there's no need to repost patches *only* to add the tags.
>> The upstream maintainer will do that for acks received on the version
>> they apply.
>>
>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>
>> Best regards,
>> Krzysztof
>>
> 
> Thank you for your explanation. I was not aware of the rules for adding 
> tags, and it was my mistake.
> I thought that it was necessary for the reviewer to proactively add the 
> "reviewed-by" tag to the patch

I proactively added the tag last time. You expect me to review it every
time and every time add my tag? You know, we all have better things to do...

Best regards,
Krzysztof

