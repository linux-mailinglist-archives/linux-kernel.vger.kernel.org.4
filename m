Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154F86577DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiL1OfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiL1OfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:35:04 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2832DF58E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:34:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 1so23847665lfz.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W09qrZAS/ID+UsTvkuyxxc8lA+fggw9LXlkJ+801LXU=;
        b=iysEDXGdU7jReCgeyeqkyJYoV7Td45kPUW4zqBzDu6XdPGgpuVjRc3j5jlVf3tnce/
         VUNV3ICiZiC5NZ39Sp5OnXnE9b0DFz22oLeIMpUWrTFDxVbq5cku3DzW1Yc+K5wDbjdk
         Y8RMTqumyb13sfQl2m3DNqqf6RjJaLFsVk5pvTRwP6snX2/YA7p1mhNcTAPdwhyKWN1F
         +sJN+SZwc5dUhZoBxtbmN5lN5Ct/nqw5sT8F4JBAYq9exU7wLj3WBGFvcfgNpM+t1yJ5
         2JQKPfQ7rdpr5xq1fnigUn8cITgVvWCGVKikuDuCi63ZRqjoHdUxbMJCattD9PC4bzH4
         IvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W09qrZAS/ID+UsTvkuyxxc8lA+fggw9LXlkJ+801LXU=;
        b=KYHpLcMmxf/zwhmSAaY93ZLPhLhXbec3ElQSbeF5hk6kQZvHdp1sBkus4GSmW1p+3W
         AOB8G13Sp/BIXnVErIMdq+7euiLDRymnOhQ33xhk7UV776suaF1ocl8AEYbLgEVuQSAf
         4MFJQNztlwzFAUCNlhgEmG2eB/m3hFtnAB6BenTUZtl4WZ8ZO0fVWE3PaWHAdHUb016f
         Ehiu3tM6B1KM2BvbXDRHTgV0MZyVry9qvtcNuoFmDCqYM57RSNhLE7FjOF6fpxWYKrIC
         veOrixIW4k12Zv2PkSahBGWaMC2s1mnEIErw2cRUcINkfkBH9U1nQ4DytYcXIDqOLI7n
         VoKg==
X-Gm-Message-State: AFqh2krtVKUza6Im2mT4NSAPydcVMXVzj7Oe6jx1jI0WZPrdFJqynR8x
        phO9vTOJ23GfDHBnixKOBW2FRw==
X-Google-Smtp-Source: AMrXdXuaPKgphx1nky7u++/3z48lKqRU2Zj5P+7jKAgcP3VWCF+usscJL0HLX5B8epTdQjBTSZNAnA==
X-Received: by 2002:ac2:47e2:0:b0:4b5:7282:868c with SMTP id b2-20020ac247e2000000b004b57282868cmr6949839lfp.55.1672238097574;
        Wed, 28 Dec 2022 06:34:57 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c9-20020a056512074900b004caf6f0b08csm2428551lfs.107.2022.12.28.06.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 06:34:57 -0800 (PST)
Message-ID: <47bb59f1-c696-5be3-cc6e-f82f5ee0998e@linaro.org>
Date:   Wed, 28 Dec 2022 16:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8350: add missing
 core_bi_pll_test_se GCC clock
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221228112456.31348-1-krzysztof.kozlowski@linaro.org>
 <d2e303d9-3ac4-f574-680f-4f5ccbf5ed13@linaro.org>
 <5001001a-203f-e832-f916-ce483b2d8ea1@linaro.org>
 <97a27c10-411e-8823-507c-ebb3f71a48ed@linaro.org>
 <279dc76c-9e60-dd93-e2d2-c2dad241620f@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <279dc76c-9e60-dd93-e2d2-c2dad241620f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 16:25, Krzysztof Kozlowski wrote:
> On 28/12/2022 13:50, Dmitry Baryshkov wrote:
>> On 28/12/2022 13:55, Krzysztof Kozlowski wrote:
>>> On 28/12/2022 12:37, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 28.12.2022 12:24, Krzysztof Kozlowski wrote:
>>>>> The GCC bindings expect core_bi_pll_test_se clock input, even if it is
>>>>> optional:
>>>>>
>>>>>     sm8350-mtp.dtb: clock-controller@100000: clock-names:2: 'core_bi_pll_test_se' was expected
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> ---
>>>> Is it even going to be used by anybody, or should we just drop
>>>> it on the driver side as per usual?
>>>
>>> It's mentioned as possible parent, so there might be users somewhere...
>>> Or you want to say that other binding and DTS users cannot use that clock?
>>
>> Yes. In the past few months we have been removing the core_bi_pll_test
>> from the old clock drivers (and new clock drivers mostly lack them).
>> Let's remove it from the rest of clock drivers.
> 
> If you are going to start doing the same work, please at least share it
> upfront.

Excuse me.

-- 
With best wishes
Dmitry

