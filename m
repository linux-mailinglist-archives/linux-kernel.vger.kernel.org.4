Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A703E6B64CE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCLKRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCLKRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:17:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5034367C4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:17:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s11so37615516edy.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678616226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GV672TLekgGI6V9z0BQIP7RnPb7Q7MJDId8/YIwZ1Dg=;
        b=JeCcrqOP3MSgbErrH9pvX7kTk2wSY0W5q0wxArfNZ/0vKeX1uiGhRhDgbsDYs/vt0k
         Nm74f3GrVj8plHOZj2wUvZF8Qhv9o16VwTuvc2z6GbM7QqgqjL/kiektz5Qzf99Q0jg/
         LUVrpH2fXb+J21xInAyCdsM0Xz7wzx5dFsx9XsA34iLxEBSlNonl6PQTVglcNxJJ/Gt5
         94CFittaATLqI3a4KotXHkC+LBvDwIzpW/lxSr4E4iSOSSGwTbk96KvrpeVnrEs9z6UW
         paoTZyPwH9V1j+B2XBr4hZ8dBiYBgyorOfNiSNaVnZ1vRKD60n+yIfF5z7ByrYzgouQB
         KOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678616226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GV672TLekgGI6V9z0BQIP7RnPb7Q7MJDId8/YIwZ1Dg=;
        b=Gm0HCj6+sEk9JgOTLMoRXKAhiHLgfkfsmB+/ZU85vaNuL+VjcqF06ZqAAaG+cmkN+5
         jKutbAs/jXjWgXqq89N8gMeMyBiiaQ1L+YlZ0lrlYgKB28Y4c5EXnQrMHKSyZ3oPW4/r
         qi4zxJ/Pc85OdxTI2pA9o+nZwj24OBTISFqrgpmvPGwz0uFfxayQLONw6Y+ZEAC1z7yI
         0DA6xKlckH62jJhvPax9KlIexeegR6ulY3MvScdeSXvxcC4cCLaFFMUDMTRtB6ZJbNoR
         avoVZPPCTLE7LFJ1umdpWrn9A6wimQ8c0/UPLACdBoM8d0xqU0j1v4S3hTOWqyFdG6+h
         FmTw==
X-Gm-Message-State: AO0yUKU68JLvIxnbK2uLX5hjFIdyl/tZejHptNVMMEFIfMpOtqmpbyPY
        JLYNHH95OqrDtFFI24qwm6uHJQ==
X-Google-Smtp-Source: AK7set/SXYtG3BD2/u/lVCLohG5k0R5WQdrWX49oJUFbxo7qshS6bqhpt2WRsqBgP9aWXdTf5r9gpQ==
X-Received: by 2002:a17:906:b050:b0:8b1:e791:faef with SMTP id bj16-20020a170906b05000b008b1e791faefmr30400112ejb.67.1678616226326;
        Sun, 12 Mar 2023 03:17:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id wu5-20020a170906eec500b00927b85e48b0sm232319ejb.111.2023.03.12.03.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:17:05 -0700 (PDT)
Message-ID: <e3deb29a-9468-a937-b95f-ace165aa8085@linaro.org>
Date:   Sun, 12 Mar 2023 11:17:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] iio: proximity: sx9500: Mark ACPI and OF related data
 as maybe unused
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
 <20230311111457.251475-4-krzysztof.kozlowski@linaro.org>
 <20230311122833.03b5a3d7@jic23-huawei>
 <c66c3f92-fa33-5af1-6f19-79b6d3530862@linaro.org>
 <20230311184440.22a1ff0f@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311184440.22a1ff0f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 19:44, Jonathan Cameron wrote:
> On Sat, 11 Mar 2023 13:30:01 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 11/03/2023 13:28, Jonathan Cameron wrote:
>>> On Sat, 11 Mar 2023 12:14:57 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>   
>>>> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
>>>> certain data unused:
>>>>
>>>>   drivers/iio/proximity/sx9500.c:1039:34: error: ‘sx9500_of_match’ defined but not used [-Werror=unused-const-variable=]
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
>>>
>>> Hi Krysztof
>>>
>>> Thanks for looking at these warnings. 
>>>
>>> Drop the protection macros instead.  The tables are trivial in size and
>>> the of_match_ptr() breaks some ways this driver can be used.
>>> ACPI_PTR() isn't as bad, but is pretty much pointless given this size of
>>> the array. 
>>>   
>>
>> For ACPI platform, ACPI table is used, so nothing for PRP0001. For OF
>> platform, OF table is used.
> 
> So you would think, but nope.. That's not how it works (I was surprised
> when I came across this the first time too)
>  
> PRP0001 is magic and requires no specific support in an individual
> driver beyond not using that of_match_ptr() macro!

I know, we talk about ACPI table.

> 
> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/bus.c#L754
> Docs here
> https://elixir.bootlin.com/linux/latest/source/Documentation/firmware-guide/acpi/enumeration.rst#L450

The code is compile when CONFIG_ACPI is defined, right? Then you have
ACPI table, so what for ACPI platform is missing? ACPI platform has ACPI
table.

Best regards,
Krzysztof

