Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE0B6DEC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDLHWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDLHWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:22:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE861713
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:22:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q15so7307401ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681284162; x=1683876162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4f9EVZqNZ+GzqjpGfS3SyfyVN9rRf+QNMY2/O3Iing=;
        b=GUr2R7zChOecWXHR42bQqiwUEy9+wBUazZhLsV+6ZVpugAWdDUPTW9fE197eQ+wOwc
         wupgF7//FBu64twuGaLb4WAZ/RUZ5QEQhKcPEUIbbLOMKdbAF5lLNkwAE81Ox0a9mOJn
         PvpmgidMjgaPOS//iEmZ0gYB5s+BcP35Q7+ljxlgK/WHRaphsBkDu8kV1+P9Sf3PxsrN
         AsxmXoEkK7p8eZYAnXSEYTG9OIgxLj2nPH9WiMmutF27QKJUj7eTBddg+4PSqltXLetR
         d5JEQwvud2VSxYfDCGJPda/PgIpSdUz+fwXJTC+AMF1i3p4sv01obX9fALk6wr9TXBR8
         ZwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681284162; x=1683876162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4f9EVZqNZ+GzqjpGfS3SyfyVN9rRf+QNMY2/O3Iing=;
        b=PPPAWoGJV6r0cLdg2suyGaqDrJfXuvXUxC3YWBIx3KcDC+RHVeCI7KNBRn8x94nZXT
         C8NFKRkJhonzHtAXx/ZzGg+veVEd8Glp4yyqtDF5SUy1m7nmp8MP1AxIPJg0hSCpGe0U
         dftyuF9xZmZD4dWgJKwxnDlilWmPLKY6TxycCFbS7EZIf1rh7eZInNj4lbvXbXXzBOFV
         lEZlX4QboRuEmeh+X+cpJvN+BOGpWCgynAd3ngAswYzH87YGJeoQ19jCAl6VjrB7rj+c
         YeUdyEsVxeAfTH35PrWTa6PF+/leOi+c7c3jCKs/hYGIguON/ETI88u6A8BBqQa2JLQI
         9a9g==
X-Gm-Message-State: AAQBX9eyCtc60fmXx1IIFfZMmgyoquJmmw+6WpvjYiert8T8eL4UUapR
        Ce6fFePWXgxxePgCYp6Nm+RY8A==
X-Google-Smtp-Source: AKy350aDJOdDoHVJhr7RPAnvHasDaKEMp6jnfyQAlf1vAVo2UXDe3Uk8tAU8GT8ynRvie7/b0Zg70Q==
X-Received: by 2002:a2e:7c0f:0:b0:2a0:f395:cc4c with SMTP id x15-20020a2e7c0f000000b002a0f395cc4cmr3869079ljc.49.1681284162372;
        Wed, 12 Apr 2023 00:22:42 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id l9-20020a19c209000000b004ec84d24818sm1681915lfc.282.2023.04.12.00.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 00:22:42 -0700 (PDT)
Message-ID: <6f2621bc-5442-f409-2d18-ea64dce3cc58@linaro.org>
Date:   Wed, 12 Apr 2023 09:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad: correct pin
 drive-strength
To:     Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230407180710.128815-1-krzysztof.kozlowski@linaro.org>
 <ZDVtXkCON8DFUDjh@hovoldconsulting.com>
 <887eb9f6-9882-37c6-4332-ddae7a354187@linaro.org>
 <ZDZUiW+74rhhRAfS@hovoldconsulting.com>
 <15e1d05f-b7e1-27bc-7363-aefd2d155eea@linaro.org>
 <ZDZbif25qQh79cuG@hovoldconsulting.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZDZbif25qQh79cuG@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.04.2023 09:19, Johan Hovold wrote:
> On Wed, Apr 12, 2023 at 09:03:31AM +0200, Krzysztof Kozlowski wrote:
>> On 12/04/2023 08:49, Johan Hovold wrote:
>>> On Tue, Apr 11, 2023 at 06:58:33PM +0200, Krzysztof Kozlowski wrote:
>>>> On 11/04/2023 16:23, Johan Hovold wrote:
>>>>> On Fri, Apr 07, 2023 at 08:07:10PM +0200, Krzysztof Kozlowski wrote:
>>>>>> Fix typo in drive-strength property name.
>>>>>
>>>>> In the future, please try to use the established commit-summary prefix.
>>>>> In this case:
>>>>>
>>>>> 	arm64: dts: qcom: sc8280xp-x13s:
>>>>
>>>> Sure.
>>>>
>>>> commit ca1ce7207e53cfe69aee5002eb3795069668da53
>>>> Author: Johan Hovold <johan+linaro@kernel.org>
>>>> Date:   Fri Aug 5 11:23:17 2022 +0200
>>>>
>>>>     arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add alternate touchpad
>>>
>>> Yeah, we initially used a longer prefix (including "x13s" which was
>>> missing in the Subject of this patch), but quite soon decided on using
>>> the shorter
>>>
>>> 	arm64: dts: qcom: sc8280xp-x13s:
>>>
>>> instead.
>>
>> Thanks. Do you know if this rule applies to other long-names? I was
>> usually keeping full name or shortening them by cutting end, but maybe I
>> should cut the middle?
>>
>> sm8250-sony-xperia-edo-pdx206
>> sm8250-sony-xperia-edo
>> sm8250-pdx206
I do sm8250-pdx206 or sm8250-edo for common dtsi changes

Generally anything that contains the SoC name and isn't ambiguous
works, IMO. And the more concise, the better.

Konrad
> 
> I would not call it a rule just yet, but I guess there are further cases
> were this could have been used. Perhaps you can all decide to use it for
> the other Qualcomm dts as well.
> 
> For the X13s the, 'sc8280xp-x13s' is enough to uniquely define the
> board and it mirrors 'sc8280xp-crd' (and using a shorter prefix makes
> the commit logs easier to read).
> 
> The general suggestion is still to check 'git log --oneline' for the
> files in question and use what appears to be the (recent) common prefix.
> 
> Johan
