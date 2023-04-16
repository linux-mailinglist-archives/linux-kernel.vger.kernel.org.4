Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A38C6E3595
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjDPHSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPHSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:18:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820930C6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:18:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy21so13323810ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681629528; x=1684221528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shJMfgVoZ/Uf3DZ3zDo9afK/q9xkXpJiFnl//R92tvI=;
        b=vMgoignxc+Q8AEpA4YE2dH/3yZVV3lffJ1FRQE9sikuR/9fZKeXb0kGHtxa2axg7zN
         ksUaFg+6EdXWnjIpU18LyXuUCXlB4yUwk8HOr32sDJXkt4St3DAYp+Gu9SDHsvHWXdsm
         ULLaD7AhrF8FPwC4A5c8OkHnFExvpJ0SQpCjrVZ56oLqds63/huuHH2rCym4JNVlkTeW
         QS9/XLLBrCovAHmFJSAgMP5MEyR7sGhQfKH8mwG2hP/DfpMj/nEz4ZtGPL+XHfxjVlwT
         1qmokUUJrsgQjjg0nhXaH8ZtYf9jIYU8XEmY6eGBm6Y6c72jaJGBQyEyqKbOF69/PSP2
         VFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629528; x=1684221528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shJMfgVoZ/Uf3DZ3zDo9afK/q9xkXpJiFnl//R92tvI=;
        b=mI0MR8yNZ7zeEP/skHbvm3FwRzFTaq+4KPs+vBN69aWtBuLSyK7lCnK+TiIMH3zIGM
         DnwM/aiPPrdXBiFfX6eOT70ACcnLcnZ5ulgydC7kNEQYbDU6ZjONFY7GZFjq+IYLv5Ve
         +qVuKLAVxiVgSkAiwxpv7Z+9dpTqt8+dvNTcZ0/f4AZMWrRNKr6ZlivYJnvr3A0QTWg1
         YlCa8DVZKvTQFTNnUsIkNEHYw8wcbI097Nhgv7li2sfYDTAgxQWVrJNAfDArFWAfirdg
         Mw5rSCdRaWmkbhdonJlHKWFpyDFd+TAs5qQSnBVD+iFF+rKup03Zb6y9CFGSSwccFldL
         WB3A==
X-Gm-Message-State: AAQBX9fcVParSPSWP/rZuxVBuqAp11qTB7nnXzBZciEfD4/8yS+GqudG
        YsPjDaSX4vJr2zZevbE5yDcdY3uvanvuXILET50=
X-Google-Smtp-Source: AKy350bA0/Hj6WBxqqB7KTZIkvmNM4AjQoPUWqFuSeSMCMxymM3HjpocW0nSNIIk9qGyg6Junh5DTA==
X-Received: by 2002:a17:907:9908:b0:885:a62c:5a5c with SMTP id ka8-20020a170907990800b00885a62c5a5cmr3209036ejc.46.1681629528314;
        Sun, 16 Apr 2023 00:18:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id xb9-20020a170907070900b0094e6a9c1d24sm4817719ejb.12.2023.04.16.00.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 00:18:47 -0700 (PDT)
Message-ID: <c21d1af9-41e4-34aa-8596-ed1c2accd13a@linaro.org>
Date:   Sun, 16 Apr 2023 09:18:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] w1: omap-hdq: allow compile testing
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
 <20230415104304.104134-5-krzysztof.kozlowski@linaro.org>
 <2023041542-arrogance-jury-ccf1@gregkh>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2023041542-arrogance-jury-ccf1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2023 17:18, Greg Kroah-Hartman wrote:
> On Sat, Apr 15, 2023 at 12:42:53PM +0200, Krzysztof Kozlowski wrote:
>> omap-hdq does not depend on anything from ARCH_OMAP for building.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/w1/masters/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
>> index 692cac3ff0ee..ad316573288a 100644
>> --- a/drivers/w1/masters/Kconfig
>> +++ b/drivers/w1/masters/Kconfig
>> @@ -53,7 +53,7 @@ config W1_MASTER_GPIO
>>  
>>  config HDQ_MASTER_OMAP
>>  	tristate "OMAP HDQ driver"
>> -	depends on ARCH_OMAP
>> +	depends on ARCH_OMAP || COMPILE_TEST
>>  	help
>>  	  Say Y here if you want support for the 1-wire or HDQ Interface
>>  	  on an OMAP processor.
>> -- 
>> 2.34.1
>>
> 
> I'm guessing this shouldn't be part of this series?

Yes, a git format-patch glitch. It's included in the series as 12/15.

Best regards,
Krzysztof

