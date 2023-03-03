Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2DB6A9678
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCCLg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCCLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:36:25 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F052D6A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:36:04 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z42so1959377ljq.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677843361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXaibxCxN96gQiwpJ+BuY84g9JyeIUpm3+3LcMKcd1E=;
        b=mObgM6Sn1VUpgTYg2iaK28+Uc64mKtahx+n1xjGm8wT10T5nr5uLKhJhA4QhazuqR0
         dOhMXaiH8ZY928EPgrfGeZm+NByLTYrA7axoOGeFOkuYPLc5/IkHvMKcQCGCWqOS8I/p
         jy8SwZ6kFIUu8T6+BsmohJQSV2ffdnAqzX8GXQ2j/aJMh35ZQFYk1QLIFszd+w2lEoQc
         4fhKothB9oQyhBbHRySLAsmF/0gsFxKzyl6pWzwiJoBH0fk1G37jq2lNTWpDIeZSco2D
         wHd9ExMC/Q2a/Igg5HAlMRqrgnZ3k35w9wrgSmY2Z4fXMSXNN6r1xd69tAXKKLGBT8pv
         3lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXaibxCxN96gQiwpJ+BuY84g9JyeIUpm3+3LcMKcd1E=;
        b=FRsE93B9pBDd7MPkw+lYCtgp1jZNl1H+nnFQzDR2R0vFQ8FnmnYNsxO2V0xCmCEP3z
         Enh5BFtr2mZVCys8pR6FhhN3T0+7AhwJrDOH8RbMWpfR6fgVkpMJALuqdvLcsAeOa0jt
         ZZUQxa9AHCDu+4iIZSzC/jMmOjvmNJy043nde2JJeJmUBKqibQHjsp7Q/gmrd45DoQuM
         vlc39B/n+CljQ4E3CO+gTOVZivVO1ZGpzDNxRC5pqad3jbeG92wpQULL8FsRp+TNDDBc
         rwnuUAIbE7EaKNxuFFzoAUq6JwYEcUcuBq22lBJIIyENWfSvKrrls1No3U00da4nBP5N
         qEAg==
X-Gm-Message-State: AO0yUKVhXMfyiDxfIkSq4FeUuqPtE5lFpBCO42AXoFTTP4ZaUkUCmMUe
        f4b1SSw0gHdDK8SQFO9D6M/m4Q==
X-Google-Smtp-Source: AK7set+48sElqcXXM7v5LEWkakEpLUSfn4s8SOkqgQRfeqgkCH/UtAnRpB8nReXg0lj7oDZvko757A==
X-Received: by 2002:a2e:5c9:0:b0:295:a370:c2d with SMTP id 192-20020a2e05c9000000b00295a3700c2dmr537138ljf.19.1677843361675;
        Fri, 03 Mar 2023 03:36:01 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id s23-20020a2e9c17000000b002945d119e09sm267559lji.8.2023.03.03.03.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 03:36:01 -0800 (PST)
Message-ID: <bdda5f36-8a65-4bcb-a990-3bc76ff90db5@linaro.org>
Date:   Fri, 3 Mar 2023 12:36:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] interconnect: qcom: icc-rpm: Don't call
 __qcom_icc_set twice on the same node
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303023500.2173137-1-konrad.dybcio@linaro.org>
 <59b28fb4-1367-9872-ed63-90847e380bb6@linaro.org>
 <29513b9e-8561-7f7e-370e-7515116c7ee6@linaro.org>
 <3116a08a-30a8-c9b9-f079-26739c9e6d49@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3116a08a-30a8-c9b9-f079-26739c9e6d49@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.03.2023 12:35, Bryan O'Donoghue wrote:
> On 03/03/2023 11:33, Konrad Dybcio wrote:
>>
>>
>> On 3.03.2023 12:32, Bryan O'Donoghue wrote:
>>> On 03/03/2023 02:35, Konrad Dybcio wrote:
>>>> Currently, when sync_state calls set(n, n) all the paths for setting
>>>> parameters on an icc node are called twice. Avoid that.
>>>>
>>>> Fixes: 751f4d14cdb4 ("interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>> RFC comes from the fact that I *believe* this should be correct, but I'm
>>>> not entirely sure about it..
>>>>
>>>>
>>>>    drivers/interconnect/qcom/icc-rpm.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>>>> index a6e0de03f46b..d35db1af9b08 100644
>>>> --- a/drivers/interconnect/qcom/icc-rpm.c
>>>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>>>> @@ -387,7 +387,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>>>        ret = __qcom_icc_set(src, src_qn, sum_bw);
>>>>        if (ret)
>>>>            return ret;
>>>> -    if (dst_qn) {
>>>> +    if (dst_qn && src_qn != dst_qn) {
>>>>            ret = __qcom_icc_set(dst, dst_qn, sum_bw);
>>>>            if (ret)
>>>>                return ret;
>>>
>>> Is it possible for src_qn == dst_qn ?
>> As the commit message says, sync_state calls set(n, n) in
>> drivers/interconnect/core.c : icc_sync_state(struct device *dev)
> 
> So you've _seen_ that happen ?
Yes, I did, on every boot previous to this patch, I believe.

Konrad
> 
