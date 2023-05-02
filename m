Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38666F3DBE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjEBGtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjEBGto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:49:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433641A6;
        Mon,  1 May 2023 23:49:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24e2bbec3d5so193054a91.3;
        Mon, 01 May 2023 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683010182; x=1685602182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yr1OMD7GQzrwg0jgDUJeq8+KPoArZtCkfJLUdDH22rA=;
        b=RlCy7AObH1tppBffuhwTrxyaD8caRZi0L5Gi9f0M+/nXAdB0xmwzM7KCQ2CLWRUcL3
         dSGq1cWgzFWr7iCl9aJzPbcyY5KBP0CGru9xzTxGzXaeEgJljmEvlvu8xa5QkZBsPPRH
         LyAeZj0e5c6e2eD/xGg4/2UBjQvu0EzeRgiIG+BE+4zpPFjVObyWe7YqhcBiBhS8UM+W
         0UceYyxaNgFSvgfDdBiQtFzFWhzH9GQmrnyScXqEYW6+ZiTyvb+uAyJ0EKuSYhWAl39i
         PpHcO4PlPMdT/6lbY+EA94GdrVZYjhQ3SZW5aERA1hslJ1dXTryItJ8rHYp9iE76PVWl
         PhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683010182; x=1685602182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yr1OMD7GQzrwg0jgDUJeq8+KPoArZtCkfJLUdDH22rA=;
        b=HGsYv8iieU/OOP8JAZBAv6f2KZAAy3PWTiJaqObpERnh9jxq7eD3LwJL+TSLbp+2E3
         ANLKLvNfi7GTCOHQrhsLkPDZxdR8IY/3rBeq+MQnOymAt7FKGAzpg0hs6T09rHfDmVR4
         nLMKIJ9z5x0l2kuUwptgTnY/m1sZ37y6bFvvjab1A2QrlfZKWSa2GzltvU4xayx+BKER
         hwUNB09YJmD2Z2mIM/i0w2yRtGrIJ6yLJTM2354dmmgTckwS0F6kmd2CpJoQbTWk3U6A
         m9ZM5KnDAfpYedUX9Tndq+5lc3si3q67N3W6iBnH4PK+7H/0uuVl9RXAl4jLtJDuQfdJ
         UjXA==
X-Gm-Message-State: AC+VfDzZCukppeIufw1EbrJAampLYmd3K1DPGAdbp9DgSiZlAQ9nT6wf
        twrTrIwFA1fDthW09eU7AZs=
X-Google-Smtp-Source: ACHHUZ6XaWHhFMAf1i83OTvD8IMgN9ZoYaaWoKrS3XVm8v4KVP16y9uSFcoFpVYaidUFpF9ALsuanA==
X-Received: by 2002:a17:90a:bb0f:b0:249:842d:312f with SMTP id u15-20020a17090abb0f00b00249842d312fmr16495568pjr.4.1683010182438;
        Mon, 01 May 2023 23:49:42 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b00194c90ca320sm2417826plh.204.2023.05.01.23.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 23:49:42 -0700 (PDT)
Message-ID: <6da2239a-32e7-c8c0-6be9-55f11b66ca1b@gmail.com>
Date:   Tue, 2 May 2023 14:49:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v8 05/11] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
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
 <8d3e330a-8478-2087-3e37-65c1f7767ee7@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <8d3e330a-8478-2087-3e37-65c1f7767ee7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,


On 2023/5/2 下午 02:46, Krzysztof Kozlowski wrote:
> On 02/05/2023 08:40, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>>
>>
>> On 2023/5/2 下午 02:31, Krzysztof Kozlowski wrote:
>>> On 02/05/2023 03:31, Jacky Huang wrote:
>>>> Dear Krzysztof,
>>>>
>>>>
>>>> On 2023/5/1 下午 05:50, Krzysztof Kozlowski wrote:
>>>>> On 25/04/2023 12:24, Jacky Huang wrote:
>>>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>>>
>>>>>> Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
>>>>>> Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
>>>>>> bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
>>>>>> the initial bindings for ma35d1 series development boards.
>>>>>>
>>>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>>>> ---
>>>>>>     .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>>>>>>     .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>>>>>>     .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>>>>>>     3 files changed, 32 insertions(+), 2 deletions(-)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>>>>> I don't see any improvements here. Path in maintainers is still broken.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>> Does this line cover
>>>> 'Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml'?
>>>> ==>  F:    Documentation/devicetree/bindings/*/*/*ma35*
>>>>
>>>> I ran 'get_maintainer.pl' on this patch, and it was able to find
>>>> maintainers and looked good.
>>>> I also ran 'make htmldocs' and did not see any warnings or errors
>>>> related to the .yaml files
>>>> in this patch. However, I am still unsure where the problem lies. Can
>>>> you suggest any
>>>> tools I can use to check for errors? I would greatly appreciate any
>>>> guidance you can provide.
>>> Apply the patches 1 to 5 and then check if all paths from maintainers
>>> are correct. I believe the path
>>> Documentation/devicetree/bindings/arm/npcm/ is not.
>>>
>>> I think I told the same last time with explanation that this patch must
>>> correct path.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Okay, I think I should combine the patch 11 (for MAINTAINER)  into patch 5.
> I don't know what's there. The path which is changed (invalidated) here,
> should be updated here.
>
> Best regards,
> Krzysztof
>

I got it and learn the rule. Thank you very much.
I will fix it.

Best Regards,
Jacky Huang


