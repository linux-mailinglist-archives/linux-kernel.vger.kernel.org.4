Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC573B24B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFWIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjFWIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:04:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B2A1BE7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:04:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fa798cf201so4845355e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687507473; x=1690099473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEReHr6Km4uN96K+wzhhty6cNh29m54e0wS7gro4H10=;
        b=A3aqmfSLf0+s3oHaDs4NnVRaPvNc7l3UD4C1xuEjSkXwRfjpgxbi6zo161jl6P+5YM
         q8PCxl66ia8uePPy0keCXXfnwRKnfZtrLHifucMmxHMfhHIL9Qfmh0D7AflBSIUsxCil
         +6iSGs3ek/3DB1EHTsx6Iwc1lUwZr8obAx1rUIcRwJhl68ZBevWIqKCmhQUWJd3FTNop
         AnkY2ol+hk1MXzMf9REkgxo7irRiGI+/5pvZHAhDEzJdoCHBFCNGOyFMSGMGYegv4Nvb
         mJqnlgxzKpsc6V7DjRtIwtHc0tEORUDu87IvLPFeV0HjUBsKg6G4L7mFI2tiDyQPdEcj
         JjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687507473; x=1690099473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEReHr6Km4uN96K+wzhhty6cNh29m54e0wS7gro4H10=;
        b=BY3QjTBXjA1xVDBbeCwU4uyJ16mb5zokX/76wk2AKb1qV7iUkIzn9wWpceXbs6Uyjy
         S3faq1keTeIrjeSOKgO2ZecTiwPpJPpRHE4FESACH2pl675xTjdiqCtUhRtfg3FMT41j
         MCsZT7KIAGLyBiAI8TZWELuaacrkN1GdndYxApmo9S5SSqh38ACj0JA6Gg+ckOhTCMxv
         +ffMYb4Kfqnw+R0sJuFUh7/Xp0+yfj7Q62Qf1QjDQtNw6oyaRUNHDH77H/YGAnLkmDm9
         GTah03/GHbSowWEczeRUR6w+Pp2c81R8jWeYLT1cLj0o3ZYAs2U3MXguMFG7i+i9t3n5
         2ZmA==
X-Gm-Message-State: AC+VfDzXK9e0HESZwDHVhtsCafaHtRhxdkVwtU6uDeuIrKAnYp+8FdYj
        nSFAkccfreuomNbeMp5FcQWYKQ==
X-Google-Smtp-Source: ACHHUZ7cgpUkcsoYszSVTliMuHU6qE3Pdf0ElKfLVvzNYbP1Sqr6LjHdJ7G1N/5x0CcVyM8Yo6cDKQ==
X-Received: by 2002:a1c:e90d:0:b0:3f8:fc2a:c7eb with SMTP id q13-20020a1ce90d000000b003f8fc2ac7ebmr14131597wmc.5.1687507473021;
        Fri, 23 Jun 2023 01:04:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003f9b2c602c0sm1588349wmh.37.2023.06.23.01.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 01:04:32 -0700 (PDT)
Message-ID: <20b480d8-087c-d5fe-08ca-7d2b684f4f96@linaro.org>
Date:   Fri, 23 Jun 2023 10:04:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0 boards
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230604165627.16963-1-aweber.kernel@gmail.com>
 <aae10e8f-b4f2-7417-ab08-41d6ec9ab8fc@linaro.org>
 <72af054e-e82b-917c-1f9b-fe231dcfa5bf@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <72af054e-e82b-917c-1f9b-fe231dcfa5bf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 14:52, Artur Weber wrote:
> On 04/06/2023 21:15, Krzysztof Kozlowski wrote:
>> On 04/06/2023 18:56, Artur Weber wrote:
>>> +/*
>>> + * This device does not use the built-in RTC; instead, the RTC in the
>>> + * S5M8786 PMIC is used instead. Remove the unused node to avoid DTB check
>>> + * warnings.
>>> + */
>>> +/delete-node/ &rtc;
>>
>> This is not the solution. The S3C RTC is there. Just like all other
>> boards we have two RTCs and DTS should be complete. Definitely you
>> should not remove something just because there were warnings. Instead
>> warnings should be fixed.
> 
> The problem is that the built-in RTC does not seem to work on this
> device. I attempted to add it, using the same clocks as other devices
> in mainline using the S5M8676 PMIC:
> 
> &rtc {
> 	status = "okay";
> 	clocks = <&clock CLK_RTC>, <&s5m8767_osc S2MPS11_CLK_AP>;
> 	clock-names = "rtc", "rtc_src";
> };
> 
> However, it just prints the following on startup:
> 
>  s3c-rtc 10070000.rtc: rtc disabled, re-enabling
>  s3c-rtc 10070000.rtc: registered as rtc0
>  s3c-rtc 10070000.rtc: hctosys: unable to read the hardware clock

This should be debugged then... but with explanation is fine to leave
the node disabled.

Removal of nodes is almost never correct.


Best regards,
Krzysztof

