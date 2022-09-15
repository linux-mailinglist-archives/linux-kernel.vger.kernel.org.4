Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2F5B9EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIOPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIOPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:34:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B881C4DF20
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:34:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n10so864540wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5auL/I6heoc3oC1MfrQqV61J6xoegw4kn0WK18zjqX8=;
        b=SPG9pcmWt1CBtILRIqSrcZOtaojdRBSH9OJTzoOUV2ybXQ3nJu5szk6GUcwbiJ7Z/D
         +eG46zuJJ1i2MZ3oC0tn91BLiJbU4sPOnfkf0KfBcmOEfXPNcaRiBqq0NNeaGAyjeTlg
         QFf460eHXCDHxj8LImYeMzQMcTAIpXGulGZBBCeV3wvv//YTf8AvpmeMhqbKqn3JcHn0
         c0jbfpPOhXFexk8TVIwnvanDAjvlv7kwV7FUV735kmoepqN4fMngWb9kZ4fTI7+E5fkS
         isMflxo+E1jq6M5TJEu9veEFZXhx5tZrKKbqmH8hRrjzPsnPZxWmQOIeWII58J7CpyQH
         APVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5auL/I6heoc3oC1MfrQqV61J6xoegw4kn0WK18zjqX8=;
        b=j9S/qZvEQMBsg6XjofmUaiJif1+fTnRHxPG1wm5uTiWyHWDRujceSimUQKl1kuy51c
         OQuOZZLkQhkJelHwlN+uXexEuquwVLsc4Am6+j8ZHaWzhqS2nPCRDfX1iixK0n2vjgiR
         m2NXBvr+dTI1vww64piFcfoe0q20GrL8nUBOhF+g5zQ4nBcYidore6YIwp1K2WRQNl+6
         7btksX7SFGIzgOEjp7aUeCzVqYvIIIopoJdfLGio+JzxhfKUA642zt2Bh+gLM8Ujf9oz
         JrQPIZuQGIj/XQudK67Sx6aevZ5zlhEzAT2tLihbYAuRVQyBOiMlmHBd+w1PAD1IeIQq
         mQaw==
X-Gm-Message-State: ACrzQf21yePdN9v7rXfHHzREND4b2M3GS5opz9+0gC0ukDMa7JRS4B3D
        iLN0nDy823jHIapihQuNABuZsg==
X-Google-Smtp-Source: AMsMyM5s2Fqxdl5RwZxg92gPm3e8LK0uga9LwXT+YPHXedQOEwWwPr192TKaKicLGJCSZeUVDz+6gg==
X-Received: by 2002:a5d:6c63:0:b0:22a:4247:1e7c with SMTP id r3-20020a5d6c63000000b0022a42471e7cmr138194wrz.625.1663256051306;
        Thu, 15 Sep 2022 08:34:11 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.72])
        by smtp.gmail.com with ESMTPSA id m2-20020a5d6242000000b00228df23bd51sm2933106wrv.82.2022.09.15.08.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 08:34:10 -0700 (PDT)
Message-ID: <15e029f2-874e-a83e-e58d-72e42d0a4c89@linaro.org>
Date:   Thu, 15 Sep 2022 16:34:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v8 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        lee@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>
References: <20220915094453.1872798-1-kavyasree.kotagiri@microchip.com>
 <20220915094453.1872798-2-kavyasree.kotagiri@microchip.com>
 <522952a9-e413-a042-5e76-54329758712b@linaro.org>
In-Reply-To: <522952a9-e413-a042-5e76-54329758712b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 16:32, Krzysztof Kozlowski wrote:
> On 15/09/2022 10:44, Kavyasree Kotagiri wrote:
>> +
>> +patternProperties:
>> +  "^serial@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      Child node describing USART. See atmel-usart.txt for details
>> +      of USART bindings.
>> +
>> +  "^spi@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      Child node describing SPI. See ../spi/spi_atmel.txt for details
>> +      of SPI bindings.
>> +
>> +  "^i2c@[0-9a-f]+$":
>> +    $ref: ../i2c/atmel,at91sam-i2c.yaml
> 
> No improvements here.
>

... probably because it is a resend, while it should not be a resend. I
asked to fix it, so I expect next version. If you do not agree, please
keep discussion going.


Best regards,
Krzysztof
