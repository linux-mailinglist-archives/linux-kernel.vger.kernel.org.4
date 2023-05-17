Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC9706096
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjEQHB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjEQHBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:01:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2171A2D68
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:01:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so568207a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684306900; x=1686898900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eudh4inWklLfywh9TpEbNPnOHsTbUH6VKtKxjFTWxyU=;
        b=Docejfk3kZ/UN4dmv+Anhivz5V45YpqS5q2HEi+RLT30w0P9o6IGlEbbouWrQBet/R
         8yOuN5VW/AXWr+fHPn7mafafhdGW8llxs1fnxMo9kOgwnEzAlEkU4qLaLKD6MX1pSEgS
         hKIE6MBGOtGxLo8bp0/xeN303djbakXfvqbZjBC76Xvt9O5r46fhZsiKQYIhtBLUbfPA
         3Gol+80gBmHIkbiRpaazXeu4akqktexsIaz9di/ncO1rhInMmCFGV178lHNqQaEIb2g7
         k0x7Hzkv9XxTjKZlzGeT+TjPbvGBrR5rtoBkI17qKSTGE3OEZWnnWJLMpu836Kg1IYdk
         FUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684306900; x=1686898900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eudh4inWklLfywh9TpEbNPnOHsTbUH6VKtKxjFTWxyU=;
        b=SUxlirrQMglONZK/797/FFzVDlGSNzhaznxgQXvuXrXTCuzeOs4yoQDLVBw6nSzlTM
         8WzdLGiNbkexIEDPKmIq36rjpKDtBeVVnfEKMJfLs+8VqPpmJar9Qw6DLSOQEjqpsKDr
         32VNMhDjFon1MT6SgwSnx3SBTspdkrwXkLUI9hri4idhWbLuu/QsStacGfoCFXvXJm0B
         MJocRyB3vTA3j/I33MS2lgtGBCALIYnebjVgdFsjyWYiF1i7lKlcWSbVxdWqfafA1czb
         sTe2XBTCvvyKkNemISJSp6CX0Tuij7rBuBY9ntZXX/impxGhXI1jn84OHDJFxcBBQrqs
         LzeQ==
X-Gm-Message-State: AC+VfDwwGhO48y0RvYY4/f01rYVh6MJZaju5H0N2lJ+sq2le+WiHuMym
        v+zb5TWdxymPnQi3X2iOoookcw==
X-Google-Smtp-Source: ACHHUZ6M/hgvmz5FYkFFbF8FjI6LYzfAb484NWf2CE9BH51n/xY7xJ7MX2+il0qYXyLhlnjnL+yC2g==
X-Received: by 2002:a17:907:318b:b0:962:9ffa:be19 with SMTP id xe11-20020a170907318b00b009629ffabe19mr36669810ejb.5.1684306900651;
        Wed, 17 May 2023 00:01:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id z23-20020a17090674d700b0096ac911ecb8sm6443334ejl.55.2023.05.17.00.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:01:40 -0700 (PDT)
Message-ID: <124a5697-9bcf-38ec-ca0e-5fbcae069646@linaro.org>
Date:   Wed, 17 May 2023 09:01:38 +0200
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
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Yes, apologies, I usually forget the net-next tag.

Shall I resend?

Best regards,
Krzysztof

