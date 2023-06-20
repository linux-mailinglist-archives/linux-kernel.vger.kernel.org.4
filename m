Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D36F736397
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjFTG1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTG1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:27:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C041A7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:27:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-988a2715b8cso353650266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687242440; x=1689834440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1yE8tz9H3rEN65rD4mY8DHlzDlGjHODVIcSxoMimnI=;
        b=ZPJi/Kd8F8hNT7+d3OGHtmgUCgnk8jfwgxxWk09roHyJkt/t9yEroDiRyhb6JRE/Fa
         fN4DuvRahmWtV1VmKxACMtLenHSFBcLLxH5BmgkCga0zgKoaVDCLh52QHn9Kq19SLpGU
         A0vn85Csof6gFk6JPEIqfqIM7OXhop76NXvE9FcI7I6dS7aT4Tr59+eilfRmvw3QB1DT
         DaAO7vzbTAn+YcbvrmDf8QUpnZIokra5J5FU502BPWo5JUAB5t+5+mrNpfrT6cz/HEvD
         5Wof5pKJe/Yn2HDJZzg25OcmhW01bHmsE7Z8fDEQeA7RQ2Uf80Z983ajon1mdoKdC1Rr
         uBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687242440; x=1689834440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1yE8tz9H3rEN65rD4mY8DHlzDlGjHODVIcSxoMimnI=;
        b=OTsCJPemNNScf8X/8Ut2Ss9kiTTdVj+CzYqnriKocArVLi1na/N5fU0zVvS3MI4dQd
         tp6cUy0ngQ3IostlBK7ogLpDAVgNJrrYFLX+IIdXq3yOqDd6XkbB7q7unFEgHruiKhTf
         a3i3BFvJF1mjsekAO11oB5ITmTglooMxwSjqcTHd39bW1xWTJwOQFgHFMlmKtaSjyBv1
         UAcUa4N4cFueN9ydGNI1xSMd1Wktm+QT7KizBlVAXIJDDpP3plZK4luU59rz+YbX5WXb
         68DVe65bQ40xUzWwxnWbpEj+/7ZVO/Ws8QIhZSgpIE2RibXUT7M2/LawUhU9Gxeut5ri
         5yRg==
X-Gm-Message-State: AC+VfDx8BUhixwrCZxCpE3IHOLdOF96PtKeXPuip4Ea6MvaKNygRDq0V
        yu9J/5PLOuYo3A2a7YCroRII1w==
X-Google-Smtp-Source: ACHHUZ63jQcKGHNuHANtSDzad8/JzE/X9SIEeQppC0X7BXLvG+L9jzx38DYjtshNsaf3p2+y3M2Sbw==
X-Received: by 2002:a17:907:1c2a:b0:988:84a9:bd64 with SMTP id nc42-20020a1709071c2a00b0098884a9bd64mr4625151ejc.0.1687242440232;
        Mon, 19 Jun 2023 23:27:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id le15-20020a170907170f00b00985bdb7dd5fsm723077ejc.201.2023.06.19.23.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 23:27:19 -0700 (PDT)
Message-ID: <544a723b-20de-563b-6cc3-5efdeec0aef7@linaro.org>
Date:   Tue, 20 Jun 2023 08:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
Content-Language: en-US
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org
References: <20230616035813.255062-1-jaswinder.singh@linaro.org>
 <165dd295-1b3a-5062-772a-613a7bf6fd45@linaro.org>
 <CAJe_ZhdV3yaKUVD43duO4hkGMByJhq7x9bN+eBXJdBXdxgDneg@mail.gmail.com>
 <e2b98d80-8e9a-6083-3bc5-677bef0d3263@linaro.org>
 <CAJe_ZhfeYmxjR7Hcht0F9rc97VG2JCFEEFB+S5kUhSCmsut3Cg@mail.gmail.com>
 <661800ab-c363-49f2-4889-c458a7b298c4@linaro.org>
 <CAJe_Zhe9CKNC_B6y_YxEY_Nz765GQghg1ivYSOROJH8A7FKcnA@mail.gmail.com>
 <1531062a-ce5f-8af0-b569-1b9eac3e7eac@linaro.org>
 <CAJe_Zhct9KGVD1t9CTaFhL05oxa9Rawf5g1OVmWOd-NYVNAErA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJe_Zhct9KGVD1t9CTaFhL05oxa9Rawf5g1OVmWOd-NYVNAErA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 21:17, Jassi Brar wrote:
>>>>>> Can we fix them as well?
>>>>>>
>>>>> ??
>>>> What else I can say to such argument?
>>>>
>>> It was not an argument, I agreed to remove it. I just observed that
>>> the nit-pick was arbitrary.
>>> And frankly
>>>    "dt-bindings: arm: socionext: add Synquacer"   is as misleading as
>>>    "dt-bindings: arm: socionext: add bindings for the Synquacer"   is improper.
>>
>> "add Synquacer boards"
>> it is both precise and correct. No misleading.
>>
> Ok. I am going to do that. Are you going to enforce this practice for
> all submissions in future?

How many cases can you find that I did not enforce it? That I provided a
review and accepted other subject? It's nothing new...

> 
> 
>>>>
>>>> Bindings without user (so no DTSI and no driver)? Just few, not countless.
>>>>
>>> I disagree. But I don't have time to write a script to find
>>> compatibles/enums and properties in yaml/txt files that are not in any
>>> dts/dtsi file.
>>>  By that logic synquacer's spi/netsec/i2c/exiu bindings and drivers in
>>> kernel are illegit too?
>>
>> Don't know which one you talk about.
>>
> Documentation/devicetree/bindings/
>   {
>      i2c/socionext,synquacer-i2c.yaml

There is a user. What do you want to prove with this one?

>      interrupt-controller/socionext,synquacer-exiu.yaml
>      net/socionext,synquacer-netsec.yaml
>      spi/socionext,synquacer-spi.yaml
>    }
> and corresponding code in drivers/
> 
> 
>>> The synquacer dts/dtsi are in u-boot upstream. SR testsuite looks up
>>
>> Sure, can you point it? U-Boot upstream is a valid project. Just like
>> many other upstream ones.
>>
> Location of dts/dtsi in u-boot upstream is
>      https://elixir.bootlin.com/u-boot/latest/source/arch/arm/dts


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

