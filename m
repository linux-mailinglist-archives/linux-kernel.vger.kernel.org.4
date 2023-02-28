Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABD66A5CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjB1QBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjB1QBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:01:19 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A8E32527
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:01:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f41so13798472lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677600072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLj8g7cWA02hy9idKplTTomEBJCXg5TfcG4v549D2mI=;
        b=XTcy/2nOnCqrShLeYBIrtqCIEGQogKWvdj/potwrGdHpnyNfKT+/lETN9btMktP41F
         tYTaO8DKwzWhDu5/fe95UzbUMDbiJ2ybvLebDdkKWrFv2jMnih/F5JDU2EVE/5zIz2YF
         +ZXV/t8JkvwzY9f70zITcCSwDhUpl295OfF1osf+d4LqGmTH6vVAEDnJnsDuirCwGZ1T
         iWAk3wV0r6Mi8vABQNEE4g0QLZe4isivl/5lqmK41cFz3C0SxPBQ6+JB8a31wC3+0zp9
         2BvJHg6iRpsz1Kyl4OVBF7mn+xOszpbBOwgHB2ilGteXiJRR7ap8PDjoOL3OYMxgQngj
         0/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677600072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLj8g7cWA02hy9idKplTTomEBJCXg5TfcG4v549D2mI=;
        b=kLkRQHnQemh36hrosSQYLnTlfh4Z7+YTuzvlGb6jdNJ7aFiEw90b9DJp8WE/aCG16P
         sQKIiIgZ9snpRdoio8Hm4X2OEl5mfkTOO3Hufj//vtEarc5jfgk1lC55kmfBOfSVkn9o
         ynZu7Y+b2EvejJf1Y5kWMF80ABDOjTJWUoIob6STbGCihTuOxkT1TWZW/uZRs4POQqIl
         rmPgfvv8KMR5vY4uVnUANdShvYkGbsKVX5hD9TKOnP3w0l2OjH5hX4/XrQivK8U2Y5eF
         NNWZoqT8o6J80hjTh1RlUR58KyqoRWclveDVY+KNzad9SJxfmuOGcgRMRnxihXRadHE3
         /gWw==
X-Gm-Message-State: AO0yUKUsMFIbOqzeg5DFb57DqSumzuVHYGr1k4AWFNPvxAblQZL52f73
        +PbCNxgFqEGUU+j94vWVhRBrFw==
X-Google-Smtp-Source: AK7set8s9zsE3ofLcRWplOeVWmWiD2DJYeZtoYujRVgUqRI0dBTPbgKPLSCiDcvvEjpyZqVpqeauvw==
X-Received: by 2002:ac2:4465:0:b0:4e0:ce21:b90 with SMTP id y5-20020ac24465000000b004e0ce210b90mr972172lfl.14.1677600072137;
        Tue, 28 Feb 2023 08:01:12 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id u28-20020ac243dc000000b004d5a5d90d83sm1393752lfl.60.2023.02.28.08.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 08:01:11 -0800 (PST)
Message-ID: <3d424869-dcdb-5ef7-5cba-0025924e2f50@linaro.org>
Date:   Tue, 28 Feb 2023 17:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/18] media: venus: hfi_venus: Fix version checks in
 venus_halt_axi()
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-8-58c2c88384e9@linaro.org>
 <a5fe6f7d-d410-9903-789c-d8c760ce6f1b@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a5fe6f7d-d410-9903-789c-d8c760ce6f1b@linaro.org>
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



On 28.02.2023 16:36, Bryan O'Donoghue wrote:
> On 28/02/2023 15:24, Konrad Dybcio wrote:
>> Only IRIS2(_1) should enter the until-now-IS_V6() path and the
>> condition for skipping part of it should be IS_IRIS2_1 and not the
>> number of VPP pipes. Fix that.
>>
>> Fixes: 4b0b6e147dc9 ("media: venus: hfi: Add 6xx AXI halt logic")
>> Fixes: 78d434ba8659 ("media: venus: hfi: Skip AON register programming for V6 1pipe")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index 4d785e53aa0b..0d137e070407 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -550,10 +550,10 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
>>       u32 mask_val;
>>       int ret;
>>   -    if (IS_V6(hdev->core)) {
>> +    if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
>>           writel(0x3, cpu_cs_base + CPU_CS_X2RPMH_V6);
>>   -        if (hdev->core->res->num_vpp_pipes == 1)
>> +        if (IS_IRIS2_1(hdev->core))
>>               goto skip_aon_mvp_noc;
>>             writel(0x1, aon_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>>
> 
> If you want to denote these as fixes, you need your patch 02/18 as a depend...
The main purpose of the Fixes tag is to mark commits that fix bugs in
existing code and it only assists in autoselecting stable patches.
Backporting this makes little sense, as we only support IRIS2 (8250)
and IRIS2_1 (7280) HFI6 platforms and new additions won't be backported.

Konrad
> 
> ---
> bod
