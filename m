Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D317088CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjERTzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjERTz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:55:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE17E6D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:55:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af225e5b4bso1445301fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684439722; x=1687031722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLecpL00n5TydjOrekl+MdE1His/ixvKUL37QWFYUBk=;
        b=IFnOtuGI2MiWd1lNTTXtiVt2dYO6ZtYasXYHC7Nf8v4oxRe0hx0s0V0yocqxTWY7/0
         yT3zZs1ma7I6mJB9wdNe75wUTmROf3C59QjyLilK5FtT9A9Mh/VWGB4ZX2Z3bZXJplIY
         BDa4ttNjSfrJ8bVqk+kMxLWQ7qFysMRvxi9Fgd/VjmW8ZyQB5SNEgNYrdydoqrOaT8BS
         E3jMwOSFOsKw7gnrr0jSADl26Ji+nANyi0PMfXyVrzcJMYBrlYikrZyi8Oc0ZMIgLBIv
         Xr/rFkr6PmtcyNatfiD+U8XIAuS0QrNvsZgyQ0oNTRSBhDcHT73KvRfFmpOzNhNfIWMF
         9p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684439722; x=1687031722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLecpL00n5TydjOrekl+MdE1His/ixvKUL37QWFYUBk=;
        b=HuDRhCG6hPDSW8TBOgaERo1zBkmnpK9Du5h8a34ZRDjB2tKb0hMepY7/zB8XIiW4sM
         6SpDF+xCAsq/GsJp0AwaC0l+Sa5avNlUe/3OYTdT8frx48OmtWdtw994NSg1VbeCfTDk
         bs6EOUu4JEJPk0tk84KoMC03HJznQAQhexnO9XZxxcpnCZnXg+EAt0Y6qvhBU0P9zICW
         MWw6GxxSNzjOXh6Gr95zyXOYf/7yDe9R6P2I3OrtPWsaaFlVwW5dObuwBHm0jJoXoRF2
         mJn+hlBXNHq1SkbrG3WkqQXpWzaXV2u7fe1G+ZxU4nOLzBAxzaJXyP0x3GDqdjDEyjuK
         o4UQ==
X-Gm-Message-State: AC+VfDzvqbiaL2URhJBxqI7QynmFxB6lAelkWGMMab4EflLpj5pr9cG8
        2nv56QJKh3WOJTQOASjgvBVzrA==
X-Google-Smtp-Source: ACHHUZ5Ade46KD9krlmh1S7mqe0UDW0Ksrdk7YYBQpxqWm0rC3czMniACR7cfcDpd3eB6v2CihVC6g==
X-Received: by 2002:a19:f002:0:b0:4f2:6f3e:aaa7 with SMTP id p2-20020a19f002000000b004f26f3eaaa7mr25398lfc.20.1684439722425;
        Thu, 18 May 2023 12:55:22 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id m5-20020a195205000000b004e8451948desm341519lfb.227.2023.05.18.12.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 12:55:21 -0700 (PDT)
Message-ID: <bd722d46-4297-10bc-77fe-5285fc3b13ce@linaro.org>
Date:   Thu, 18 May 2023 21:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 5/8] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
 <20230228-topic-qos-v8-5-ee696a2c15a9@linaro.org>
 <b1990459-4780-b139-9656-f00f34a2a375@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <b1990459-4780-b139-9656-f00f34a2a375@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.05.2023 17:59, Georgi Djakov wrote:
> Hi Konrad,
> Thanks for re-spinning the patches!
> 
> On 7.04.23 23:14, Konrad Dybcio wrote:
>> Some (but not all) providers (or their specific nodes) require
>> specific clocks to be turned on before they can be accessed. Failure
>> to ensure that results in a seemingly random system crash (which
>> would usually happen at boot with the interconnect driver built-in),
>> resulting in the platform not booting up properly.
>>
>> Limit the number of bus_clocks to 2 (which is the maximum that SMD
>> RPM interconnect supports anyway) and handle non-scaling clocks
>> separately. Update MSM8996 and SDM660 drivers to make sure they do
>> not regress with this change.
>>
>> This unfortunately has to be done in one patch to prevent either
>> compile errors or broken bisect.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c | 40 ++++++++++++++++++++++++++++---------
>>   drivers/interconnect/qcom/icc-rpm.h | 14 +++++++++++--
>>   drivers/interconnect/qcom/msm8996.c | 22 +++++++++-----------
>>   drivers/interconnect/qcom/sdm660.c  | 16 ++++++---------
>>   4 files changed, 58 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index d79e508cb717..419b2122bebd 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -424,21 +424,20 @@ int qnoc_probe(struct platform_device *pdev)
>>       qnodes = desc->nodes;
>>       num_nodes = desc->num_nodes;
>>   -    if (desc->num_bus_clocks) {
>> -        cds = desc->bus_clocks;
>> -        cd_num = desc->num_bus_clocks;
>> +    if (desc->num_intf_clocks) {
>> +        cds = desc->intf_clocks;
>> +        cd_num = desc->num_intf_clocks;
>>       } else {
>> -        cds = bus_clocks;
>> -        cd_num = ARRAY_SIZE(bus_clocks);
>> +        /* 0 intf clocks is perfectly fine */
>> +        cd_num = 0;
>>       }
>>   -    qp = devm_kzalloc(dev, struct_size(qp, bus_clks, cd_num), GFP_KERNEL);
>> +    qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
>>       if (!qp)
>>           return -ENOMEM;
>>   -    qp->bus_clk_rate = devm_kcalloc(dev, cd_num, sizeof(*qp->bus_clk_rate),
>> -                    GFP_KERNEL);
>> -    if (!qp->bus_clk_rate)
>> +    qp->intf_clks = devm_kzalloc(dev, sizeof(qp->intf_clks), GFP_KERNEL);
>> +    if (!qp->intf_clks)
>>           return -ENOMEM;
>>         data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
>> @@ -446,6 +445,18 @@ int qnoc_probe(struct platform_device *pdev)
>>       if (!data)
>>           return -ENOMEM;
>>   +    qp->num_intf_clks = cd_num;
>> +    for (i = 0; i < cd_num; i++)
>> +        qp->intf_clks[i].id = cds[i];
> 
> Sadly, this is introducing a superfluous compiler warning, which is a bit annoying.
> Could you please add some initialization to silence it and re-send just this patch.
Ugh clang doesn't show it.. thanks

Konrad
> 
> drivers/interconnect/qcom/icc-rpm.c: In function ‘qnoc_probe’:
> drivers/interconnect/qcom/icc-rpm.c:450:28: warning: ‘cds’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   450 |   qp->intf_clks[i].id = cds[i];
>       |                         ~~~^~~
> 
> BR,
> Georgi
