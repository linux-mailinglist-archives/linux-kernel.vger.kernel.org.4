Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2AD6F3BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjEBBb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEBBbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:31:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C08A1BEF;
        Mon,  1 May 2023 18:31:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ab032d9266so9484505ad.0;
        Mon, 01 May 2023 18:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682991084; x=1685583084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3UiPi93XxKnJZMKFtiJdn8rcY/Fce5ICdXhxYOZLt7g=;
        b=eth/IVwicIFgK8HA1XDSLyb6VLbPTLyzYwkwQcEmLwCPkzxJVDGxL6inORC2A34Z2J
         FZCZYM2a2fTcnBGN0jW8n9HS3hYWcxzvM9FGywG0dkoMGWLiDNMd9KJxRHjMy3VL2a+g
         nn8ZPY7TCTup/d9Y5q/RrOVWxEyWCusDi2XOhsDBsQWwPD/ZUgSiACkZowehrEj5LM0J
         93YVmj87JQO4uz7OPLfkNoomiRz8hC2UXXa2akAqEXJnnWNeclwVnIyM81dlord4HcZq
         UCApej9G6fdrWoSdGxPcgiLr+daRGm+LsXuqpedlLbfE1YKKk1CzmyoeRrmiExVqmXCZ
         kZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682991084; x=1685583084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UiPi93XxKnJZMKFtiJdn8rcY/Fce5ICdXhxYOZLt7g=;
        b=C+djaZ3lAY/VAo1pHpVBLALTyk2tC2X5o1afzZjxEOqXKyH0grO9NjMNyj4Rqlf5/f
         mDORKHZBeRVCX6+S27Ln6gbu3xJk+ZecqdXeyI9JSX+EaRdphgCF0J8W8+QJ10nVAsDh
         ONoqhYY8MSY0zIeARHrNeiMoBHrNaUiDcXRlLwRrYACoCAsE8AtvFnHfWm8w3AyAhFD6
         qWSOu72g8x8TB8d8+dqvuI0nFrs3iIRsFsAuTMXQ7Gcmo1w8kGrVvazEVJstIoJkJJl/
         +eqVn14fPNDbgbmxrHv54DoFQpQYkjQc6fbuRx04+etacK2mtwb9JlHouPLaejuPMQT8
         VWBg==
X-Gm-Message-State: AC+VfDxUsdI10Djii7bJhfz0IFC0K1dmBNCbjCSNICgZF+2aqKdxHmxh
        itLe/Z46ftlOcO4H/4bBQO4=
X-Google-Smtp-Source: ACHHUZ54DEsjzfPJFYIrD41DzqrmDV4UclbY63nLz0F0Xw9gBVL6xTBmdtV4bBR5dePMxArsAvWpzg==
X-Received: by 2002:a17:902:c950:b0:1a1:9020:f9c7 with SMTP id i16-20020a170902c95000b001a19020f9c7mr18185423pla.44.1682991083602;
        Mon, 01 May 2023 18:31:23 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y18-20020a170903011200b001a674fb0dd8sm18621719plc.247.2023.05.01.18.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 18:31:23 -0700 (PDT)
Message-ID: <ded0c68a-e0b3-b106-e24d-7d9087c6ca4c@gmail.com>
Date:   Tue, 2 May 2023 09:31:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v8 05/11] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
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
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2b79021d-3793-5f2d-8659-5d0d8fc78017@linaro.org>
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


On 2023/5/1 下午 05:50, Krzysztof Kozlowski wrote:
> On 25/04/2023 12:24, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
>> Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
>> bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
>> the initial bindings for ma35d1 series development boards.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>>   .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>>   .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>>   3 files changed, 32 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
> I don't see any improvements here. Path in maintainers is still broken.
>
> Best regards,
> Krzysztof
>

Does this line cover 
'Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml'?
==>  F:    Documentation/devicetree/bindings/*/*/*ma35*

I ran 'get_maintainer.pl' on this patch, and it was able to find 
maintainers and looked good.
I also ran 'make htmldocs' and did not see any warnings or errors 
related to the .yaml files
in this patch. However, I am still unsure where the problem lies. Can 
you suggest any
tools I can use to check for errors? I would greatly appreciate any 
guidance you can provide.


Best Regards,
Jacky Huang

