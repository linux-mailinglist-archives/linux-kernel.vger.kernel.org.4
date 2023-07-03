Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B9874541B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGCDVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCDVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:21:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026A1B2;
        Sun,  2 Jul 2023 20:21:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so48242705e9.3;
        Sun, 02 Jul 2023 20:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688354496; x=1690946496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38M0FwP656/My/R316BO0zrI7Qa9x58e/irRx5f2stI=;
        b=dKgQBqUl6jIQfAHIRMPQ88ZlRQDNyJ1lZYrWHEqwlf9pqIlIqv9bf4Gm9ujpEPdLQW
         On6k374TuHVlO0bd8IoXVlyw8DqwENgfRC3ZRVLDLgApjA53pfiXncA/Q7UqvyzU8FNf
         odShTSq4mA5aPCWU6ml0qCdTwJSrtr92y4MxapZYUrgYaYb+dXoZUWReFFl93m+cfqFf
         /rBtqLkep7DHeBl9fdIzkSmmn8OpahTxYEr33yLLZ6fvubmM6Oq2QhMQM6lVpRBzcrPD
         zJv8fnNjhggU5303gYXdFuVTYBNw1qxHx6ghYi2TaKUtieXNi57JAsLNqiwmaHZXeafV
         se7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688354496; x=1690946496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38M0FwP656/My/R316BO0zrI7Qa9x58e/irRx5f2stI=;
        b=HevOroaWPEPX4NuzlYeLUu8LncVirF0eyhxtf5QOUYrKOiL6KiA/q7SSZCCPpTCxSh
         vy+FcRyRaCWs9YP/2U23yGeWl03IO8Wg4TrvpOCwVlXRl/SF+pkoNNrDh5rqpIbC/sFg
         SrifygXVrhSTNrnIF8yHuqDlJQBWcsy39FxGxYU0JiGZ/wTZESSCr051hf7/QFeXFE3F
         RZaX+80R+KJcpvUDxv2ETVvf8yYJhWihHt6TnDmMT4VR/BV4l3DoKnjKlYlADLF2PvEa
         d8hhxb4wdHFRBC8eUedjJiKGBcG2YOVeynMnLJSbQqMy7QuR/WnV1RyPEuFPRIJwPKtg
         hCWQ==
X-Gm-Message-State: AC+VfDzuQeg1XPFa1ckHQiNFmwBWqhC1NLJj/E4YE0KqZJfDgr3lvM3i
        0XTVbzD65FCpEB2Y9kL8inOtgYqbChA=
X-Google-Smtp-Source: ACHHUZ7Rp72qUewfEccta263SQbouSqaHJYfVkSj2157P9f4cf5rg5iLSXNoTE09SJn5RzueTMVLcg==
X-Received: by 2002:a1c:f318:0:b0:3fb:b008:2003 with SMTP id q24-20020a1cf318000000b003fbb0082003mr8489306wmq.38.1688354495571;
        Sun, 02 Jul 2023 20:21:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:32f:1f0:ae0b:3bc8:c743:b2d8? ([2a01:e0a:32f:1f0:ae0b:3bc8:c743:b2d8])
        by smtp.gmail.com with ESMTPSA id f4-20020a1c6a04000000b003fba2734f1esm16756469wmc.1.2023.07.02.20.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 20:21:35 -0700 (PDT)
Message-ID: <4aba0e4a-87f0-1810-bf4d-a2f278e51e8b@gmail.com>
Date:   Mon, 3 Jul 2023 05:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ARM: dts: st: add buswidth property to stm32f429-disco
Content-Language: en-US, fr
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230702103516.139440-1-rgallaispou@gmail.com>
 <11ec64ad-8fb8-e94d-2019-d3deb399084b@linaro.org>
From:   =?UTF-8?Q?Rapha=c3=abl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <11ec64ad-8fb8-e94d-2019-d3deb399084b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 02/07/2023 à 22:14, Krzysztof Kozlowski a écrit :
> On 02/07/2023 12:35, Raphael Gallais-Pou wrote:
>> The ili9341 is left without a mandatory buswidth to properly communicate
>> between the SI bus and the display. Add the device-tree property.
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>>   arch/arm/boot/dts/stm32f429-disco.dts | 1 +
> 
> There is no such file. Please rebase on recent Linux.

Yes, indeed. I forgot to pull, I'm sorry.

> 
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
>> index 3b81228d46a2..5eaf95afc8c7 100644
>> --- a/arch/arm/boot/dts/stm32f429-disco.dts
>> +++ b/arch/arm/boot/dts/stm32f429-disco.dts
>> @@ -197,6 +197,7 @@ display: display@1{
>>   		spi-3wire;
>>   		spi-max-frequency = <10000000>;
>>   		dc-gpios = <&gpiod 13 0>;
>> +		buswidth = <8>;
> 
> There is no such spi property.

While I agree with you, I saw in staging drivers that this property was 
fetch in the device-tree by the fbtft core.

Should I document those in or try to do it another way ?

> 
> Best regards,
> Krzysztof
> 

Thanks,
Raphaël
