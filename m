Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12956F3DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjEBGky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjEBGkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:40:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B209D1BFF;
        Mon,  1 May 2023 23:40:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115eef620so32263389b3a.1;
        Mon, 01 May 2023 23:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683009650; x=1685601650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCb3ZZzoxs2Iaol/Cz7Mq3fJhMROIH/+8rLVbBXiEUE=;
        b=Ay3hhxY8fz4dtICNdgIQq2hXYf0lk6iXCaz9WuGK2n3pQejdIY68rePgadvPq0a7L5
         kDt8+dIKz+cZlpBlO16dUCOgWobray36Cla1PLNwFNTuzSlPo+qNwPBrEuO9qgpzKS5s
         BtKuAn/EDLSFWJcP0feYO2r4uaFxF/sT/WBgqBk4oRI00yoU8NluauUSicZbmsoJycEi
         UwUQyjsCS5Irr/DM2JDEjsyYUdJOemfpZyfabCGGQxaDYu1J9Nr5ifnmIW2JLU3d3CLv
         P1V5RnhOGlq7u2H72ahC/V0+UvC+CROHzLm5GftZkDOfC6C0iYIlZMUxrcGUAsNhioz6
         3FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683009650; x=1685601650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCb3ZZzoxs2Iaol/Cz7Mq3fJhMROIH/+8rLVbBXiEUE=;
        b=izO08ISOG5YQ+CEsGfs2VKOQAeSToJ7miEUPaJRWAGGLl6UbtQ4SGjaxYK9mmwhcAW
         bNY3LbBd48BycZ91VAdTYPWRwHrhvN9jO1Um0BE/UvbBirtqcRhbhf7R0CSfRDQEzK3z
         x9MaFuVltLH/yjZxBgSm3yc078tC8rTrQPaFeDQpcneE0EJaKacow3hGjK5YSbzmb2HO
         lYf4tG7x45gT37/Ec2JG9KeWrh51FqOBegFNfDOyMGPbnZRYUaI46I0GKN8Yr/TNDZBf
         Tle5XR9lfIRLrkg9yhvVhYgBOxid1Ece4VMVgrN2kDZhVM4zdH4SFAFOq6f9Iw4fMohv
         cmSQ==
X-Gm-Message-State: AC+VfDzV+EI3iX9u8Zqpr5FnVFkn5b2VyPMwfBkcuaOWuoDZsaRYdw5p
        6IAZ2hjck6AJkSVZWiKzVK0+XGHpsePIhA==
X-Google-Smtp-Source: ACHHUZ7elf160va0dLBrj1SNNCiJYiS0nBbtMLsYC45CCwlEfv67GpvMrHBayzJeyeoyT/IC9THzNA==
X-Received: by 2002:a17:902:da83:b0:1a5:1109:f58e with SMTP id j3-20020a170902da8300b001a51109f58emr19834067plx.29.1683009649945;
        Mon, 01 May 2023 23:40:49 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902778400b001a2135e7eabsm18920475pll.16.2023.05.01.23.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 23:40:48 -0700 (PDT)
Message-ID: <10ee47df-df1f-5c44-7d2b-d367ab7a6f29@gmail.com>
Date:   Tue, 2 May 2023 14:40:44 +0800
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
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <34d70271-ff07-aea8-bcb7-81d39a55167c@linaro.org>
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



On 2023/5/2 下午 02:31, Krzysztof Kozlowski wrote:
> On 02/05/2023 03:31, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>>
>> On 2023/5/1 下午 05:50, Krzysztof Kozlowski wrote:
>>> On 25/04/2023 12:24, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
>>>> Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
>>>> bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
>>>> the initial bindings for ma35d1 series development boards.
>>>>
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>> ---
>>>>    .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>>>>    .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>>>>    .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>>>>    3 files changed, 32 insertions(+), 2 deletions(-)
>>>>    create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>>> I don't see any improvements here. Path in maintainers is still broken.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Does this line cover
>> 'Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml'?
>> ==>  F:    Documentation/devicetree/bindings/*/*/*ma35*
>>
>> I ran 'get_maintainer.pl' on this patch, and it was able to find
>> maintainers and looked good.
>> I also ran 'make htmldocs' and did not see any warnings or errors
>> related to the .yaml files
>> in this patch. However, I am still unsure where the problem lies. Can
>> you suggest any
>> tools I can use to check for errors? I would greatly appreciate any
>> guidance you can provide.
> Apply the patches 1 to 5 and then check if all paths from maintainers
> are correct. I believe the path
> Documentation/devicetree/bindings/arm/npcm/ is not.
>
> I think I told the same last time with explanation that this patch must
> correct path.
>
> Best regards,
> Krzysztof
>

Okay, I think I should combine the patch 11 (for MAINTAINER)  into patch 5.


Best Regards,
Jacky Huang



