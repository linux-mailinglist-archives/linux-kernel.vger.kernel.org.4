Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF686F3DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjEBGrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjEBGq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:46:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E08E3C3E
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:46:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so573765366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 23:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683010014; x=1685602014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IClHL3VtocFJzOQAKgpYJ2u7P758UhgOK8XhvAERrRs=;
        b=GKvp/69ilCvIXXZfWjFaekNxRqehEXZt/OLDePGRMyUWMeILjvzzHc19nwJ/OeIE/d
         T82GyhuM2eK2ffSnRc/ik3dcCWK/Z1JWILyEdLQGVETRX3lA5cRy2rAH4fVyrF9WMRGv
         2cCLZmy3TaOhlAuqM/NAIWYd5i+PqyPX1AzWckqFLCoFnDta8xRswv3rC8X5k1K/IYlo
         /y+vizKK2/0r1/FZdu0KJRAjGRJeJXQfIq1YSTI19LHquYKYDALDfCNlnkoJaPww4mH2
         hfyL+mMYJyBBqo6SmUuxG9yfg8PU+ZpwrfjoDLy140mSyJBs/a+PABezjHOM3ND878/g
         QK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683010014; x=1685602014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IClHL3VtocFJzOQAKgpYJ2u7P758UhgOK8XhvAERrRs=;
        b=M781uS5LZ2MT37JJnouyC258nLJJQ0trscxVOgjB54AGZbYjAVhPTDpa7h/L49bc1J
         UieDP/XmIY4fvrQSZ2gZfp/6cSZ1eu3XXRa7ahL+mc8qmNO1bpcDH5RfD4jjDyBZ4IMh
         cOeCrHFwEHn+QPOJ/Tn6pJLTCM8acEpKe7J5v4Y0gMJVaYLrNQZwd1hamPAvYkibpNmB
         1lRJ3IO51wRogeDbZCLdJyTqfus7xU0FNtPp4wqWUR0IQJf8hc51tCvmDPmT/HQWtSn6
         /cYMfdGOkClbu4kr8iWsG0IvufLCYFdqSpq01iJejiQYmRP/dTyJoCrGtL7+1k5lMlf6
         5vQQ==
X-Gm-Message-State: AC+VfDyJ3gEUskgfg3STDODMWJHfmRB0QXuajFt48wLQ78Er0e4ogzzw
        L0ENnHgelQQQwzgex1GeM6eXeA==
X-Google-Smtp-Source: ACHHUZ5+sIybTWL7luBe79Bmw7jXqzjalUYjMC2It0tIgNxkQF5eyRKJBNRLxVU4+GBzbRY1gfCIUg==
X-Received: by 2002:a17:907:2d25:b0:94f:7844:b0ca with SMTP id gs37-20020a1709072d2500b0094f7844b0camr19015990ejc.52.1683010014607;
        Mon, 01 May 2023 23:46:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709063b1100b0094e6db4d4a1sm15578212ejf.186.2023.05.01.23.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 23:46:54 -0700 (PDT)
Message-ID: <8d3e330a-8478-2087-3e37-65c1f7767ee7@linaro.org>
Date:   Tue, 2 May 2023 08:46:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v8 05/11] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
 <20230425102418.185783-6-ychuang570808@gmail.com>
 <2b79021d-3793-5f2d-8659-5d0d8fc78017@linaro.org>
 <ded0c68a-e0b3-b106-e24d-7d9087c6ca4c@gmail.com>
 <34d70271-ff07-aea8-bcb7-81d39a55167c@linaro.org>
 <10ee47df-df1f-5c44-7d2b-d367ab7a6f29@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <10ee47df-df1f-5c44-7d2b-d367ab7a6f29@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 08:40, Jacky Huang wrote:
> 
> Dear Krzysztof,
> 
> 
> 
> On 2023/5/2 下午 02:31, Krzysztof Kozlowski wrote:
>> On 02/05/2023 03:31, Jacky Huang wrote:
>>> Dear Krzysztof,
>>>
>>>
>>> On 2023/5/1 下午 05:50, Krzysztof Kozlowski wrote:
>>>> On 25/04/2023 12:24, Jacky Huang wrote:
>>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>>
>>>>> Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
>>>>> Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
>>>>> bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
>>>>> the initial bindings for ma35d1 series development boards.
>>>>>
>>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>>> ---
>>>>>    .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>>>>>    .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>>>>>    .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>>>>>    3 files changed, 32 insertions(+), 2 deletions(-)
>>>>>    create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>>>> I don't see any improvements here. Path in maintainers is still broken.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> Does this line cover
>>> 'Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml'?
>>> ==>  F:    Documentation/devicetree/bindings/*/*/*ma35*
>>>
>>> I ran 'get_maintainer.pl' on this patch, and it was able to find
>>> maintainers and looked good.
>>> I also ran 'make htmldocs' and did not see any warnings or errors
>>> related to the .yaml files
>>> in this patch. However, I am still unsure where the problem lies. Can
>>> you suggest any
>>> tools I can use to check for errors? I would greatly appreciate any
>>> guidance you can provide.
>> Apply the patches 1 to 5 and then check if all paths from maintainers
>> are correct. I believe the path
>> Documentation/devicetree/bindings/arm/npcm/ is not.
>>
>> I think I told the same last time with explanation that this patch must
>> correct path.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Okay, I think I should combine the patch 11 (for MAINTAINER)  into patch 5.

I don't know what's there. The path which is changed (invalidated) here,
should be updated here.

Best regards,
Krzysztof

