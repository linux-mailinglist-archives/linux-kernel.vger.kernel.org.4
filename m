Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C44E5BE447
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiITLQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiITLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:16:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0087971712
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:16:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s10so2570214ljp.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3m0zn687CrWQICkOz4B+QmmOgC0jhiX0DZAFZTb8GwE=;
        b=X9UbCGZsQngixftsgl1qm6yRncthznVeEjGW2Sv5QLSpvL4K7bTWBHV1o/8AHj23sv
         ZznznF4eCuSC3wLfTWVYZIvhpgBqdac4GQqGGN8Hm7/jtbTv2++alWhUcNKXBEfBXj0g
         JZGlIomKoYD1gPr7bFhzG9Uqgp/jYZUa08zeheuwx/gaxtckBkIGm40+xOHqsi1tpcdn
         diyqL3relNgu5PpLvtqQcEmJnIHgbeT43LPudTLUlz2QMB9X4ZA0PRyEUf9HU1A3NxM5
         pMUew92T184GnVwJvadSdb4qFdQtAkFnEq3r1YtYzgQQ8vflHS5Mo+nw1QZQBfaSRCnS
         GXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3m0zn687CrWQICkOz4B+QmmOgC0jhiX0DZAFZTb8GwE=;
        b=rfg6SDAiBGUTO2zAf4VfdOqeDw4LY4A973oY84iLZyz8upPxRd7WmX9wzKo84Mzz1k
         DoRvV2lxOGiYu9dR8zXlN2UBldN403sBtrxjIZ7fdBRUPhhuG7+p7PTELe+kNECpxETG
         hvRO8qVL2fKg+nC7NVAC/nCYk3QpgaWnbZ609/tQPDujpuSHW+3VH1++CRhbDwBMsbz9
         bq1qCs6FCSPahbQ3p0F2m+gJbV+QpJyHCNU2JUtQB6rgipuKjeYDCyb+YivBQRiQGeeh
         4K6CPlYBVq/dBBCMl2Jpx8pfWMsC/aC2tSer0fUQ6jREdezRmK2/bryTQH9w6BkRg68S
         WjsA==
X-Gm-Message-State: ACrzQf35+KmZSj3axyDxROTq48TZn9e1UrSeQusji8eiW0E/+q467upU
        Q0lV818OWE5WcN+lN7rA+hPOyw==
X-Google-Smtp-Source: AMsMyM5qNzWF6Nwqo/fPKyOhxXE6zl6oW3wEpFzKUxsAv4uaccqK+vxJxRUl3kDmcQACkD9iHllaPA==
X-Received: by 2002:a2e:940d:0:b0:261:c5c8:3403 with SMTP id i13-20020a2e940d000000b00261c5c83403mr7213596ljh.86.1663672610229;
        Tue, 20 Sep 2022 04:16:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e9596000000b0026ab83298d6sm217873ljh.77.2022.09.20.04.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 04:16:49 -0700 (PDT)
Message-ID: <a8077058-5493-7b57-0530-c7221a03a799@linaro.org>
Date:   Tue, 20 Sep 2022 13:16:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 1/4 RESEND] ARM: dts: qcom: Use new compatibles for
 crypto nodes
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        thara.gopinath@gmail.com, devicetree@vger.kernel.org,
        robh@kernel.org, andersson@kernel.org, bhupesh.linux@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        Jordan Crouse <jorcrous@amazon.com>
References: <20220919221509.1057574-1-bhupesh.sharma@linaro.org>
 <20220919221509.1057574-2-bhupesh.sharma@linaro.org>
 <bb577304-f048-8fd5-fc7a-47a0897ba792@linaro.org>
 <00dd028f-d636-0cda-40ce-01d5addcbec9@linaro.org>
 <ccc318c0-ee1b-d538-6d2b-bf85a3c9c6fd@linaro.org>
 <CAH=2Ntys+JSurmZn5qN2Kuphi_5q6Ge7cZgd9KMTvAyLnd6JSA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAH=2Ntys+JSurmZn5qN2Kuphi_5q6Ge7cZgd9KMTvAyLnd6JSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 12:48, Bhupesh Sharma wrote:
> On Tue, 20 Sept 2022 at 15:09, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 20/09/2022 10:57, Bhupesh Sharma wrote:
>>>>>             crypto: crypto@8e3a000 {
>>>>> -                   compatible = "qcom,crypto-v5.1";
>>>>> +                   compatible = "qcom,ipq4019-qce";
>>>>
>>>> There are few issues here:
>>>> 1. Compatible is not documented.
>>>
>>> Its documented here:
>>> https://lore.kernel.org/linux-arm-msm/30756e6f-952f-ccf2-b493-e515ba4f0a64@linaro.org/
>>>
>>> [as mentioned in the dependency section in the cover letter :)]
>>>
>>>> 2. Compatible is not supported by old kernel - ABI break.
>>
>> You cannot fix this with dependencies/ordering.
>>
>>>> 3. Everything won't be bisectable...
>>>
>>> I think its a question of dependencies b/w the patchsets intended for
>>> separate areas. Let me think more on how, I can resolve it in newer
>>> versions.
>>
>> DTS always goes separately so this also cannot be fixed with ordering or
>> dependencies. However if Bjorn is fine with it, it's good.
> 
> Sure, I get your point. SInce I haven't sent out the crypto driver and
> DMA driver subsets yet, let me stop and respin the series with the
> dt-bindings changes clubbed with the crypto driver patches in a single
> patchset. I can keep the DMA and dts patchsets separate and send them
> out separately.
> 
> I think that should help maintain the ABI and backward compatibility.
> Please let me know if you think otherwise.

I actually don't know what's in the drivers, so maybe there is no ABI
break by kernel... but you are changing the compatibles in DTS thus any
other project using them will be still broken.

Best regards,
Krzysztof
