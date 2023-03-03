Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86206A968A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCCLjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCLjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:39:31 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B3B55530
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:39:26 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z42so1968576ljq.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677843565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkDKt1YzeWNRwirQw6wvEDUUEXwHJr3b2oz6pXeJI9c=;
        b=an6IW9IOqyPT/0W+RIywrkM13pW/VcHEkd9uXbu7e4T6Vd5YsK9TjNqy0JxhAoeK2B
         Gte9u7qzh6EjQeEnKaMIKdVHVXrIVtjvNa1EOSLiH2xZylhhBs9nt1dY6pcxbz0biW0O
         y8QfbjepIICLQJjqBYp77MF/OwckqwF/r+s7F+X0N1CG7tl0yBey5c+eJdtwBpAcxk0T
         tKX8JNVp6drhjmeUW6ARDPqq3w/fL0fkZF0S/5K1yvIfhCp8T48pj/D8msPYhP4D+SYI
         KU33KKMjaiZtwmc/esVQnULHhM0OVRgjz5h/Ik+P0Tw5c1bid6umneApMgpQDPEBP1yO
         bTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkDKt1YzeWNRwirQw6wvEDUUEXwHJr3b2oz6pXeJI9c=;
        b=zsuxWiQyb7C9KCmLnEPo4KM96m3YynVeHzIgZFSJfOh+9ooqHP3qt6Mzpu68Q83/t5
         21DQQgMDU3OUEQ6ag/foFskELx1e/XwiVQAAO1OHnpNY5ru0V5C8/PK+euCbG7CgBfvz
         v3Shzd32WPygfG5uor8ihQEb3cQztV1xa1tAZF2jektvFfJNJ+yLfylX5MEa2SNtGmCo
         FNb1vlYrFth4bBA3u7utdc4Lku42Z7qo++12VXpXZxYsrc+qCOL+XDTOz/0Ru10dGZiy
         VGs4676CG83RIyqXYvqpF7JHHti208A03mqczoDQUfby2BtnBabYIi1XvcUn31Sv2R1G
         ri2Q==
X-Gm-Message-State: AO0yUKUYGppBvXoponlPKi/Cu60VT7tsHOqJjOvjK1CGC7v4aE+POBIW
        5/51gVYFGwAj1SlXrlkcDMjANw==
X-Google-Smtp-Source: AK7set8ukR79viwyY7va3KuIUT5EBlrrMxoo/tyCt9ry7Ct7pxXVLhRaEr6/7iSPVguhz4STOwk1iw==
X-Received: by 2002:a2e:7d08:0:b0:295:a930:55d1 with SMTP id y8-20020a2e7d08000000b00295a93055d1mr421966ljc.18.1677843565268;
        Fri, 03 Mar 2023 03:39:25 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id k26-20020a05651c10ba00b00295d38474e5sm269833ljn.46.2023.03.03.03.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 03:39:24 -0800 (PST)
Message-ID: <db4f4e53-e8b9-0807-7490-2c6b76194ad5@linaro.org>
Date:   Fri, 3 Mar 2023 12:39:23 +0100
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
 <08020872-6316-8f81-ac6a-c6eef408818f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <08020872-6316-8f81-ac6a-c6eef408818f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.03.2023 12:36, Bryan O'Donoghue wrote:
> On 03/03/2023 11:35, Bryan O'Donoghue wrote:
>> On 03/03/2023 11:33, Konrad Dybcio wrote:
>>>
>>>
>>> On 3.03.2023 12:32, Bryan O'Donoghue wrote:
>>>> On 03/03/2023 02:35, Konrad Dybcio wrote:
>>>>> Currently, when sync_state calls set(n, n) all the paths for setting
>>>>> parameters on an icc node are called twice. Avoid that.
>>>>>
>>>>> Fixes: 751f4d14cdb4 ("interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth")
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>> RFC comes from the fact that I *believe* this should be correct, but I'm
>>>>> not entirely sure about it..
>>>>>
>>>>>
>>>>>    drivers/interconnect/qcom/icc-rpm.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>>>>> index a6e0de03f46b..d35db1af9b08 100644
>>>>> --- a/drivers/interconnect/qcom/icc-rpm.c
>>>>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>>>>> @@ -387,7 +387,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>>>>        ret = __qcom_icc_set(src, src_qn, sum_bw);
>>>>>        if (ret)
>>>>>            return ret;
>>>>> -    if (dst_qn) {
>>>>> +    if (dst_qn && src_qn != dst_qn) {
>>>>>            ret = __qcom_icc_set(dst, dst_qn, sum_bw);
>>>>>            if (ret)
>>>>>                return ret;
>>>>
>>>> Is it possible for src_qn == dst_qn ?
>>> As the commit message says, sync_state calls set(n, n) in
>>> drivers/interconnect/core.c : icc_sync_state(struct device *dev)
>>
>> So you've _seen_ that happen ?
>>
> 
> Assuming you have, then why isn't the fix in sync_state i.e. that's an error for everybody right ?
I believe that there's simply no other way of updating every single node
on its own with the icc api, without taking any links into play. But I
see exynos and i.mx also effectively calling it twice on each node.

Konrad
