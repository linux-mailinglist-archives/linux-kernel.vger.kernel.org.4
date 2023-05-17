Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C707062C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjEQI1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjEQI0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:26:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF0044A5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:26:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1b2so416507a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684312000; x=1686904000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIOrvUUAtZyi4FUcHTM2x45qSYsRRVl2b97WHgQpvzE=;
        b=eQ3g/7Rm2/GZIotGQTg6KTEm2qew6cAgGks8iRaNvcPsWwXAFYZsrAKPtZC9leV57r
         OkmcZ+onUsyadK95vLiahEr/ht/fI0Km4qnow2gVjD3f3ENWjmmVMB9MxWk1SGhvKDye
         0N03RnFIiWFqMa+0Ph3YnDkIgj0qUmM0SYmv4rMMgY0XJP0l1LLZywu3oWugm0spIpGB
         +cgBR81BvIQBEGwE30xAM/NQIg2+rf9dXi9aKRVxIFhxTUCcgYLiYqgXRU9SnDPU6KMi
         NUbw6jjFT7jfkaA1+YE+xKERJR8AeGWms3MEpI5n4z32X0yU35nuUcDaN4eRmlsVDLKB
         M64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312000; x=1686904000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIOrvUUAtZyi4FUcHTM2x45qSYsRRVl2b97WHgQpvzE=;
        b=ajAenf0sjNuvcEl7oWJWnRnd7kKVDjcjh7Jnx5+UXN5VCpY4ovgxiuN4VXBLuf3xLP
         Xgdc/Bn9Ko2VD7CXMzTOpLGVlb1MBvnghP11lvBEQySJfPAwsYpoDJIOsot8C4CKTTb8
         Hb2VGJ83lNdUogmTb6DLBG8Own4ryOgTRMDOmdVptxV+39NY/R+Zp8e++/TiFfyXWYT7
         tsvd94YK5g6JxKbG1yI9FVWA71S6xxRn6V9tVeoOKVdswnrJHshOMHPxQuWfWi+cyPEL
         f6Nwzq7k5no91WF1QE/KP+vnEj9aZ7fwuSYk5KSW78fyhoOOVk2pHieM96Q6zDTqK6yz
         PQxw==
X-Gm-Message-State: AC+VfDxvXHNwxozAR71JJpPMegRL6Ctxxc5IFs75v7oHySe2X8fYAiAZ
        jkMv7iH21hHIHqF3wXI4RScagA==
X-Google-Smtp-Source: ACHHUZ7eptdbo1d96sX474rlETqgth2MCTCvWmKHpGMhDBMtcdSR5IZGuNGlLOAJwIKRGbpoWAwKcw==
X-Received: by 2002:aa7:d551:0:b0:508:3f06:8fd1 with SMTP id u17-20020aa7d551000000b005083f068fd1mr1386249edr.29.1684312000564;
        Wed, 17 May 2023 01:26:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402111800b0050bc4eb9846sm9010673edv.1.2023.05.17.01.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:26:40 -0700 (PDT)
Message-ID: <50cc1727-999f-9b7a-ef09-14461fa4ddfb@linaro.org>
Date:   Wed, 17 May 2023 10:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5] dt-bindings: net: nxp,sja1105: document spi-cpol/cpha
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
 <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
 <20230515105035.kzmygf2ru2jhusek@skbuf> <20230516201000.49216ca0@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516201000.49216ca0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 05:10, Jakub Kicinski wrote:
> On Mon, 15 May 2023 13:50:35 +0300 Vladimir Oltean wrote:
>> On Mon, May 15, 2023 at 09:45:25AM +0200, Krzysztof Kozlowski wrote:
>>> Some boards use SJA1105 Ethernet Switch with SPI CPHA, while ones with
>>> SJA1110 use SPI CPOL, so document this to fix dtbs_check warnings:
>>>
>>>   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: ethernet-switch@0: Unevaluated properties are not allowed ('spi-cpol' was unexpected)
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Is my instinct that this should go to net-next correct?

It would be great missing net-next was pointed out by checkpatch.pl.

Best regards,
Krzysztof

