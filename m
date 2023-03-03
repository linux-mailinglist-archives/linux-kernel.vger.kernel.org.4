Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38DE6A96B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCCLuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCCLuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:50:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7C05C136
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:50:18 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id f11so1966051wrv.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677844217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/ZsxXPLv5WWAqzh9cKOoefVqP5zaXz8g40Y9JGNMY0=;
        b=D5ywEX9PlvxD43n3LDPEAu6JFj+/srayQAmdt2U1SL6KYPds5k6sfQFL1SaPdZDQRk
         9qM6ylzmdxdxUuj2IVlWlNTKg7iQw78qtwV7lU3MGLQYPTB9AzSg0hdPS9vzZZfH1yP5
         qn82sBwr2s1aKtdtUhWsPntolHjVNqLeAsM1KhDlA1XO3A325lEbhhRs8lUioJjZvMsm
         7GHJNWGEKqsQjutfHIfHifVfxRwQUIXdZVJJK0hacApsBYid5qhQmVKnrrTQqF6dYuWV
         LBB2jf0LSuUoG7F5nRn0uhNb6mDGD08roZbHTdmT0ZS4QhM19RInDyQFm3NTWTdDqtlo
         fRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677844217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/ZsxXPLv5WWAqzh9cKOoefVqP5zaXz8g40Y9JGNMY0=;
        b=B2S3EIecNH7IaolwA0BUoIMc//hkapymmUvSFIwlFv35vF74HgZrQSBL8TwBL1knKz
         SfY142oNmvdFQHCYksLpdotoU8/73h4/Now8wsC6bOvcIKr7KkELE4wTJj8+mW2ruYqQ
         FUqE7YEZTvAzkOH5ydHFTXc88ACg8y3fu4ubNHoDWKbom9k58HjNeI1RoDM474cuVdkU
         vr7r/WWrq/FksNH5xDJQMZIy7QUyFi+38zKAUZ7NV5vHQBExFEnmaG0ASKlw7FDtUlXQ
         QR0KQkajvmzGm1brfRkEyJ6s/0FDgmRWLINVyxW1haLz0elxk3SP90Js/VkDrJ8zCJ+Z
         yrfw==
X-Gm-Message-State: AO0yUKWE4V2flDIwAocs34cS9IAMobgM836b6VjRYiDwYmrdgxyAtAm1
        6ocCiUfxFtljJZH0pASM70h2VA==
X-Google-Smtp-Source: AK7set9Qhbng7b9eRG+YENkvTyUcS/e0GYh6eHfCfaEObvNz5iDLzWeSWKPGpKvjWGGNe1AUAf0K/Q==
X-Received: by 2002:adf:edc4:0:b0:2cc:4d03:54cb with SMTP id v4-20020adfedc4000000b002cc4d0354cbmr1072721wro.28.1677844217064;
        Fri, 03 Mar 2023 03:50:17 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b002c7066a6f77sm2000989wri.31.2023.03.03.03.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 03:50:16 -0800 (PST)
Message-ID: <133be267-1aab-350f-f3ba-142cf4dee4d4@linaro.org>
Date:   Fri, 3 Mar 2023 11:50:15 +0000
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
 <2cfba291-656f-9a43-fdd5-7601a6fe6ef5@linaro.org>
 <0b1fafe6-0814-f1a6-ae19-7bd273751102@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <0b1fafe6-0814-f1a6-ae19-7bd273751102@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 03/03/2023 11:42, Konrad Dybcio wrote:
> 
> 
> On 3.03.2023 12:40, Bryan O'Donoghue wrote:
>> On 03/03/2023 11:39, Konrad Dybcio wrote:
>>>
>>>
>>> On 3.03.2023 12:36, Bryan O'Donoghue wrote:
>>>> On 03/03/2023 11:35, Bryan O'Donoghue wrote:
>>>>> On 03/03/2023 11:33, Konrad Dybcio wrote:
>>>>>>
>>>>>>
>>>>>> On 3.03.2023 12:32, Bryan O'Donoghue wrote:
>>>>>>> On 03/03/2023 02:35, Konrad Dybcio wrote:
>>>>>>>> Currently, when sync_state calls set(n, n) all the paths for setting
>>>>>>>> parameters on an icc node are called twice. Avoid that.
>>>>>>>>
>>>>>>>> Fixes: 751f4d14cdb4 ("interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth")
>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>>> ---
>>>>>>>> RFC comes from the fact that I *believe* this should be correct, but I'm
>>>>>>>> not entirely sure about it..
>>>>>>>>
>>>>>>>>
>>>>>>>>      drivers/interconnect/qcom/icc-rpm.c | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>>>>>>>> index a6e0de03f46b..d35db1af9b08 100644
>>>>>>>> --- a/drivers/interconnect/qcom/icc-rpm.c
>>>>>>>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>>>>>>>> @@ -387,7 +387,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>>>>>>>          ret = __qcom_icc_set(src, src_qn, sum_bw);
>>>>>>>>          if (ret)
>>>>>>>>              return ret;
>>>>>>>> -    if (dst_qn) {
>>>>>>>> +    if (dst_qn && src_qn != dst_qn) {
>>>>>>>>              ret = __qcom_icc_set(dst, dst_qn, sum_bw);
>>>>>>>>              if (ret)
>>>>>>>>                  return ret;
>>>>>>>
>>>>>>> Is it possible for src_qn == dst_qn ?
>>>>>> As the commit message says, sync_state calls set(n, n) in
>>>>>> drivers/interconnect/core.c : icc_sync_state(struct device *dev)
>>>>>
>>>>> So you've _seen_ that happen ?
>>>>>
>>>>
>>>> Assuming you have, then why isn't the fix in sync_state i.e. that's an error for everybody right ?
>>> I believe that there's simply no other way of updating every single node
>>> on its own with the icc api, without taking any links into play. But I
>>> see exynos and i.mx also effectively calling it twice on each node.
>>>
>>> Konrad
>>
>> I mean. I'm fine for you to retain my RB on this qcom specific patch since this seems like a real bug to me but... it seems like a generic bug across arches that should probably be resolved @ the higher level.
>>
>> ?
> I suppose we could change the set(n, n) in sync_state to be set(n, NULL)
> and enforce parameter null-checking on all provider->set functions. Do
> I understand this correctly?
> 
> Konrad
>>
>> ---
>> bod

void icc_sync_state(struct device *dev)
{
         struct icc_provider *p;
         struct icc_node *n;
         static int count;

         count++;

         if (count < providers_count)
                 return;

         mutex_lock(&icc_lock);
         synced_state = true;
         list_for_each_entry(p, &icc_providers, provider_list) {
                 dev_dbg(p->dev, "interconnect provider is in synced 
state\n");
                 list_for_each_entry(n, &p->nodes, node_list) {
                         if (n->init_avg || n->init_peak) {
                                 n->init_avg = 0;
                                 n->init_peak = 0;
                                 aggregate_requests(n);
                                 p->set(n, n);
                         }
                 }
         }
         mutex_unlock(&icc_lock);
}
EXPORT_SYMBOL_GPL(icc_sync_state);

I mean p->set(n,n); is done like this since forever. Now that you draw 
attention to it, it doesn't make much sense to me..
