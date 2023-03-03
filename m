Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAB26A967D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCCLhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjCCLhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:37:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA45CC21
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:36:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso1089064wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677843396;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pye9BN7cPcIdb/MdCrBtNR41BV+vj/ApaKmprZLF99A=;
        b=ev9ZDybRvUhK5zoZnPSdt9npLOCeUTyRqHKzJ9LaRQONF2RnmOFOEhxnfoqiKx+x8k
         MMRwV50yU/f9aBZInYr3BUx6HnyTqir9U4C9+6QiEeD9KUEgflz40Z3OzhZn3hbATNjJ
         4p5jeA81rHe0Gg1Yy3vTa3VO/oSoJV/3vpYZgcCq4fHRELcbfVB1dR0W/0+YBTleBw7e
         b6XIx56EkSxxB4UXS3jqdZg8owTrFZ7IJpOkSYQ5jx1QF9gVZr6i4n9o9fAmfLjHSVvg
         NnIs2w7xKWPUtDcazo/uGzzb2eP/PO/lbju0b2QNUGcpn5uMdkGwE42L6RbdGOIoea/d
         2fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843396;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pye9BN7cPcIdb/MdCrBtNR41BV+vj/ApaKmprZLF99A=;
        b=2wp1ZiznQL2ALz6xTwBaazeTlQ8fNjHmR2xonGRuBcEdX16bXdOi22LccKYayWur8P
         GGGYRjR9tMcPsYQEijpGjBWo8MjPXuOsyhoZ+hCcOjWlkh2fHIKf+f6vNnM551xhJUQ4
         pd5R5vCy4klvOYcbMoMgmeGkg3xiB1vKcXgLroOSTPFJjDAqypS7VJ4sca0bdBhzg00e
         hIspOwrz65+PwOwquYqEWxgnKOQ1CeYFIfzhk+JdcAQO53fnBA1g4dDz7NdahhXnfbCF
         n6EZ5FjMWlQpYP1nTpDsReI9gefBijwqyIyewLnake8d0SbqEaSM10v8ydT0nRKbPTbP
         5kng==
X-Gm-Message-State: AO0yUKUsp+dhChihPFuprRetSA6WP6kIVTDAfhovP7J8cXwklDbtwAB7
        vmLYIyrlWLmRGMKLj3+LOVlcGw==
X-Google-Smtp-Source: AK7set/j3t7g5c8ligHQdZA9qYAsDQ+VpNQ7QSnUaucNif/mZZnEF28nlssAZoiXLVe8p7pxNfm3SQ==
X-Received: by 2002:a05:600c:3549:b0:3eb:55d2:9c4c with SMTP id i9-20020a05600c354900b003eb55d29c4cmr942179wmq.16.1677843396557;
        Fri, 03 Mar 2023 03:36:36 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003eb2e33f327sm9368549wmc.2.2023.03.03.03.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 03:36:36 -0800 (PST)
Message-ID: <08020872-6316-8f81-ac6a-c6eef408818f@linaro.org>
Date:   Fri, 3 Mar 2023 11:36:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] interconnect: qcom: icc-rpm: Don't call
 __qcom_icc_set twice on the same node
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303023500.2173137-1-konrad.dybcio@linaro.org>
 <59b28fb4-1367-9872-ed63-90847e380bb6@linaro.org>
 <29513b9e-8561-7f7e-370e-7515116c7ee6@linaro.org>
 <3116a08a-30a8-c9b9-f079-26739c9e6d49@linaro.org>
In-Reply-To: <3116a08a-30a8-c9b9-f079-26739c9e6d49@linaro.org>
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

On 03/03/2023 11:35, Bryan O'Donoghue wrote:
> On 03/03/2023 11:33, Konrad Dybcio wrote:
>>
>>
>> On 3.03.2023 12:32, Bryan O'Donoghue wrote:
>>> On 03/03/2023 02:35, Konrad Dybcio wrote:
>>>> Currently, when sync_state calls set(n, n) all the paths for setting
>>>> parameters on an icc node are called twice. Avoid that.
>>>>
>>>> Fixes: 751f4d14cdb4 ("interconnect: icc-rpm: Set destination 
>>>> bandwidth as well as source bandwidth")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>> RFC comes from the fact that I *believe* this should be correct, but 
>>>> I'm
>>>> not entirely sure about it..
>>>>
>>>>
>>>>    drivers/interconnect/qcom/icc-rpm.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.c 
>>>> b/drivers/interconnect/qcom/icc-rpm.c
>>>> index a6e0de03f46b..d35db1af9b08 100644
>>>> --- a/drivers/interconnect/qcom/icc-rpm.c
>>>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>>>> @@ -387,7 +387,7 @@ static int qcom_icc_set(struct icc_node *src, 
>>>> struct icc_node *dst)
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
> 

Assuming you have, then why isn't the fix in sync_state i.e. that's an 
error for everybody right ?
