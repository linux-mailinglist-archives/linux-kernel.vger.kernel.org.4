Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579CE6A9751
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjCCMfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCCMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:35:13 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD05ADE8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:35:11 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z5so2150570ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 04:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677846910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+y3VNDk/Z06nKlKiA/oJNMccwlA5HSiiicdHD4hUxtk=;
        b=eoou53ujfDFeNBKfwQs8VVNFXjSRp0KdvSXc1ScCXY5tuFHB/O/XmLiMzF3eVinlAR
         YNw8vKjtc2lhcA7swj0zGSmHdWAZUoAChS0exCtCSIdQ3D6J9qZ8L4xwbLiHaKg6Flvg
         983uVGHYKYkaYpt6MznbjEDlecLkjfN3wPzxa7N7BLciL+YA22dT0vGgn/SAWaebJAe9
         9kJ25he5N3LIKfYF+rsdNgi8Gw4Q+j0PUbh6CgxYuvtUFJsx5x93hcWXAwyhNdPm+jHX
         A/5aODBTyDYfPgVCzZCSK7nhJSYcdClo2xHlhtfQPg9Dcw68iI5MFOaYencDMUNFSPQC
         KD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677846910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+y3VNDk/Z06nKlKiA/oJNMccwlA5HSiiicdHD4hUxtk=;
        b=4YTTxoufhVOfcjSACFHWJdpxIjWUH2tBg79txT8FZnSmeG0J69HITmzT5UXHAhuBpr
         ZrmriAcjx3JjDE8NsQwfZtkU1A8ZmayeFDeGF1J/U/JvQA8ERDUOSIAp00NCSNr2HBVM
         j5ZLtrgdoUYCMc9dhMOX454TLJMaWXotKVVWdQ9ImiHGQ8yJx4OQGZMmSDal7LBuxyRW
         3P2pA/10jbJTyghkf8Ez9F1JmVQfcsy3nQ5W57qxtqAFqvTljvSznpZ/7F9WukiB9TDe
         AUQusHDDIPvGP59lzTL+ZvEd938WQp30GJ5kz76+LriUSX/dmjVzadg06BzIeRVqPKzc
         wVvw==
X-Gm-Message-State: AO0yUKUrbWNx/OB16nc1JDbpT9ZV22auT+ubQJ0oHLKkJlDb61iAn1rV
        Ymq3k/ejVVRtV2y1WmYlxa9zrw==
X-Google-Smtp-Source: AK7set+RMg3rfF+NeQcqLED3fXSnKmpz8e9ZYADW6XQ6nBAztzuOF9bj0Mia3LIYKxPL4sC6t5L5Og==
X-Received: by 2002:a05:651c:2125:b0:295:aefd:eb13 with SMTP id a37-20020a05651c212500b00295aefdeb13mr652378ljq.30.1677846909788;
        Fri, 03 Mar 2023 04:35:09 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e30-20020a05651c039e00b002958c4e96fasm294978ljp.3.2023.03.03.04.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 04:35:09 -0800 (PST)
Message-ID: <11fce8ad-46a4-305c-cc8f-c7530c13ecbd@linaro.org>
Date:   Fri, 3 Mar 2023 13:35:08 +0100
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
 <db4f4e53-e8b9-0807-7490-2c6b76194ad5@linaro.org>
 <2cfba291-656f-9a43-fdd5-7601a6fe6ef5@linaro.org>
 <0b1fafe6-0814-f1a6-ae19-7bd273751102@linaro.org>
 <133be267-1aab-350f-f3ba-142cf4dee4d4@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <133be267-1aab-350f-f3ba-142cf4dee4d4@linaro.org>
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



On 3.03.2023 12:50, Bryan O'Donoghue wrote:
> On 03/03/2023 11:42, Konrad Dybcio wrote:
>>
>>
>> On 3.03.2023 12:40, Bryan O'Donoghue wrote:
>>> On 03/03/2023 11:39, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 3.03.2023 12:36, Bryan O'Donoghue wrote:
>>>>> On 03/03/2023 11:35, Bryan O'Donoghue wrote:
>>>>>> On 03/03/2023 11:33, Konrad Dybcio wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 3.03.2023 12:32, Bryan O'Donoghue wrote:
>>>>>>>> On 03/03/2023 02:35, Konrad Dybcio wrote:
>>>>>>>>> Currently, when sync_state calls set(n, n) all the paths for setting
>>>>>>>>> parameters on an icc node are called twice. Avoid that.
>>>>>>>>>
>>>>>>>>> Fixes: 751f4d14cdb4 ("interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth")
>>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>>>> ---
>>>>>>>>> RFC comes from the fact that I *believe* this should be correct, but I'm
>>>>>>>>> not entirely sure about it..
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>      drivers/interconnect/qcom/icc-rpm.c | 2 +-
>>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>>>>>>>>> index a6e0de03f46b..d35db1af9b08 100644
>>>>>>>>> --- a/drivers/interconnect/qcom/icc-rpm.c
>>>>>>>>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>>>>>>>>> @@ -387,7 +387,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>>>>>>>>          ret = __qcom_icc_set(src, src_qn, sum_bw);
>>>>>>>>>          if (ret)
>>>>>>>>>              return ret;
>>>>>>>>> -    if (dst_qn) {
>>>>>>>>> +    if (dst_qn && src_qn != dst_qn) {
>>>>>>>>>              ret = __qcom_icc_set(dst, dst_qn, sum_bw);
>>>>>>>>>              if (ret)
>>>>>>>>>                  return ret;
>>>>>>>>
>>>>>>>> Is it possible for src_qn == dst_qn ?
>>>>>>> As the commit message says, sync_state calls set(n, n) in
>>>>>>> drivers/interconnect/core.c : icc_sync_state(struct device *dev)
>>>>>>
>>>>>> So you've _seen_ that happen ?
>>>>>>
>>>>>
>>>>> Assuming you have, then why isn't the fix in sync_state i.e. that's an error for everybody right ?
>>>> I believe that there's simply no other way of updating every single node
>>>> on its own with the icc api, without taking any links into play. But I
>>>> see exynos and i.mx also effectively calling it twice on each node.
>>>>
>>>> Konrad
>>>
>>> I mean. I'm fine for you to retain my RB on this qcom specific patch since this seems like a real bug to me but... it seems like a generic bug across arches that should probably be resolved @ the higher level.
>>>
>>> ?
>> I suppose we could change the set(n, n) in sync_state to be set(n, NULL)
>> and enforce parameter null-checking on all provider->set functions. Do
>> I understand this correctly?
>>
>> Konrad
>>>
>>> ---
>>> bod
> 
> void icc_sync_state(struct device *dev)
> {
>         struct icc_provider *p;
>         struct icc_node *n;
>         static int count;
> 
>         count++;
> 
>         if (count < providers_count)
>                 return;
> 
>         mutex_lock(&icc_lock);
>         synced_state = true;
>         list_for_each_entry(p, &icc_providers, provider_list) {
>                 dev_dbg(p->dev, "interconnect provider is in synced state\n");
>                 list_for_each_entry(n, &p->nodes, node_list) {
>                         if (n->init_avg || n->init_peak) {
>                                 n->init_avg = 0;
>                                 n->init_peak = 0;
>                                 aggregate_requests(n);
>                                 p->set(n, n);
>                         }
>                 }
>         }
>         mutex_unlock(&icc_lock);
> }
> EXPORT_SYMBOL_GPL(icc_sync_state);
> 
> I mean p->set(n,n); is done like this since forever. Now that you draw attention to it, it doesn't make much sense to me..
Yeah, but we're doing the same thing twice.. So maybe this is not
so much a bug fix as it's an optimization..

Thinking about it again, this could use a likely() too, as this
seems to be the only occurence of set(n, n)

Konrad
