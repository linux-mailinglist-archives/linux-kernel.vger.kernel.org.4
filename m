Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265716A969B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCCLlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjCCLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:41:11 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712535F234
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:40:56 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r18so1978309wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677843655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Z6C3IEs9+sZB4AdVkwjomCIEC9N7YxUCDwVo818ObQ=;
        b=tLRqMa0vHMmBhgJSOoyvQKsCIrSRc9ACGqbnyCgy4ObbrVF77OUEcS1rF/XDMqFftL
         vC7OGpVGJhGgZ9Jvf4aF+Zy4ndRDwu4fxxvH830wpb0LWo+O3oJPmOJ9ublVml34vwp4
         aP7xBOPKkQKXgb2KFQ1+Wen9buj32n/BeB64rmQTcHGYCGrCSGeL3ZB53OKDOcKVv6an
         l1FW/ZJrCpWqBPeGk4sCQycIAk2drk36hWQMW6duJDd8S1WrF8PgTR8D5m4m8qtLDe2/
         zBe5XcsyzOHq2Gr/MLyApECvSrzNqHC02E1LeEX8CT6rqa3k5KtIxOg2Bn0F/9h7EIv7
         cPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z6C3IEs9+sZB4AdVkwjomCIEC9N7YxUCDwVo818ObQ=;
        b=3C42CxsR/9Qdr/1CJDcio1d4/51378jM/kFQGfQbd6qmCqRnosqsID2IkMmttdIz7P
         UoQOx/L6skHimvedNB2AEsv2l6hPlqCWE5MtjwCeWQScK4mS0wPBmd0QjJt4OQQdn1n8
         xQyscwWL2Q5mRnl2UbPUte4Oz8HC9kxvyi/Il1cktBFHiH8zpBWBhDyzOoMo61Zu6D8F
         /49yri1usgXwCrZD4lL0sf0NrCckNEB8v+Veiuk886c2Yu53dGRJvDuO3jgqsIJYF334
         ZAftfivVVdy2YwE7ZQQlfK38KNWESe9TbJcWD5zQbF5vL+5TpX3FCjLzr1EnCR6mt5RI
         CTTw==
X-Gm-Message-State: AO0yUKVEbLhHSXZN9o0iaZEmeY12NmwRTpk/ww4qsMADlRjl8bUKLced
        FxmzUUeGQPIEW9CGT+xCxHhf5g==
X-Google-Smtp-Source: AK7set9yObgvzoNRgqWPtz3O4FxX8nmlNXSZnpomFRrBbNVqReKcvaeehnL3MZmH4fqqdP8Y/LKzhQ==
X-Received: by 2002:a5d:4147:0:b0:2ca:6442:c811 with SMTP id c7-20020a5d4147000000b002ca6442c811mr1058628wrq.51.1677843654887;
        Fri, 03 Mar 2023 03:40:54 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p13-20020a056000018d00b002c5691f13eesm1940450wrx.50.2023.03.03.03.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 03:40:54 -0800 (PST)
Message-ID: <2cfba291-656f-9a43-fdd5-7601a6fe6ef5@linaro.org>
Date:   Fri, 3 Mar 2023 11:40:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] interconnect: qcom: icc-rpm: Don't call
 __qcom_icc_set twice on the same node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303023500.2173137-1-konrad.dybcio@linaro.org>
 <59b28fb4-1367-9872-ed63-90847e380bb6@linaro.org>
 <29513b9e-8561-7f7e-370e-7515116c7ee6@linaro.org>
 <3116a08a-30a8-c9b9-f079-26739c9e6d49@linaro.org>
 <08020872-6316-8f81-ac6a-c6eef408818f@linaro.org>
 <db4f4e53-e8b9-0807-7490-2c6b76194ad5@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <db4f4e53-e8b9-0807-7490-2c6b76194ad5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 11:39, Konrad Dybcio wrote:
> 
> 
> On 3.03.2023 12:36, Bryan O'Donoghue wrote:
>> On 03/03/2023 11:35, Bryan O'Donoghue wrote:
>>> On 03/03/2023 11:33, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 3.03.2023 12:32, Bryan O'Donoghue wrote:
>>>>> On 03/03/2023 02:35, Konrad Dybcio wrote:
>>>>>> Currently, when sync_state calls set(n, n) all the paths for setting
>>>>>> parameters on an icc node are called twice. Avoid that.
>>>>>>
>>>>>> Fixes: 751f4d14cdb4 ("interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth")
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> ---
>>>>>> RFC comes from the fact that I *believe* this should be correct, but I'm
>>>>>> not entirely sure about it..
>>>>>>
>>>>>>
>>>>>>     drivers/interconnect/qcom/icc-rpm.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>>>>>> index a6e0de03f46b..d35db1af9b08 100644
>>>>>> --- a/drivers/interconnect/qcom/icc-rpm.c
>>>>>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>>>>>> @@ -387,7 +387,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>>>>>         ret = __qcom_icc_set(src, src_qn, sum_bw);
>>>>>>         if (ret)
>>>>>>             return ret;
>>>>>> -    if (dst_qn) {
>>>>>> +    if (dst_qn && src_qn != dst_qn) {
>>>>>>             ret = __qcom_icc_set(dst, dst_qn, sum_bw);
>>>>>>             if (ret)
>>>>>>                 return ret;
>>>>>
>>>>> Is it possible for src_qn == dst_qn ?
>>>> As the commit message says, sync_state calls set(n, n) in
>>>> drivers/interconnect/core.c : icc_sync_state(struct device *dev)
>>>
>>> So you've _seen_ that happen ?
>>>
>>
>> Assuming you have, then why isn't the fix in sync_state i.e. that's an error for everybody right ?
> I believe that there's simply no other way of updating every single node
> on its own with the icc api, without taking any links into play. But I
> see exynos and i.mx also effectively calling it twice on each node.
> 
> Konrad

I mean. I'm fine for you to retain my RB on this qcom specific patch 
since this seems like a real bug to me but... it seems like a generic 
bug across arches that should probably be resolved @ the higher level.

?

---
bod
