Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BBF6F8955
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjEETM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjEETMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:12:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29AD2273E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:12:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f11d267d8bso2423607e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683313944; x=1685905944;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xceCA2XEX2XYZr2wVtYbFEfoG8eDOlxoBa/XP0RVFQY=;
        b=UhPl2UMUAS7synMssm2Xa7YoI0m0FvxnYT3MEZAmEV9W/N3OoIQL2HogKqaceAiUut
         46eNYLbhA44jQmzgucA6ZDSzzS3HAIiOrLwVa1loVhY+rfpHmBHSE/wecQv1zHMgL4Am
         gGJ5Th7rG4ymTi5aBKdZUedFq/bHcoQA4q6Al1Ez4btsoRrxopxe+pDA3IYhBqPgs98Z
         1RmJM7JuMW1KyNIjVXdbI95sqNrNRdIjEffp07ZMmquvHmzVy2Pavgd61hXtSKMZjwTl
         vqx6ksmQ6KmNlyvR8oS7iomKC3uLdFSi1YWBCEUnzGKI2CD/YMnpGpjFZPSOBcgsisA3
         mdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683313944; x=1685905944;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xceCA2XEX2XYZr2wVtYbFEfoG8eDOlxoBa/XP0RVFQY=;
        b=NIeQAdvOi8RVQ6WFtJak30zajkPsohu/sPWyXHyX5A0UOWeMea4k1ZuYHXizuJlYJk
         D6KXwPqXapRuMiytQukMHz0xHLXVpQHe+44dVdgxhzC2U6Ps+pjRLDyoFOv++bZgY6SG
         fLybcLNJlEeE36ZlL8mOGL/at5prtEq/ldXyqREUny9izkMIv6+2JAeKX6gds9qS5E60
         wb98/TK8TmHEcMisJIhZCqGEz5IGb6l4TLmHXZpqgsN2QUNVezclRbQvs6iMMFSgGEZn
         bxIVBr1kaT2j+YDfrZSIkL2PZO8k/T7iBoSxbJ4FvMmzW7PtXJ8jerbaOh2LhyrBmuf0
         9Kfg==
X-Gm-Message-State: AC+VfDzbszscCKzWh1Elv9rtk+QmxU7QO9GXGrmWO36WFUMCb2kq9TKZ
        wbYr97xNGBITQ9dYsIqmC7y3TQ==
X-Google-Smtp-Source: ACHHUZ5mD0x/zoLuBQwU8xI4QgCZ1CDVaEBT6+NSbuoLZmgtGhPSO2BKq9FVxSxiEtX0/j9mfsJuDg==
X-Received: by 2002:a19:f80c:0:b0:4d5:ae35:b221 with SMTP id a12-20020a19f80c000000b004d5ae35b221mr671427lff.34.1683313944137;
        Fri, 05 May 2023 12:12:24 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id 10-20020ac2568a000000b004e9b307d2c8sm385026lfr.238.2023.05.05.12.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:12:23 -0700 (PDT)
Message-ID: <2ccb46b8-db1c-5f4e-681c-7b1fe9fa8402@linaro.org>
Date:   Fri, 5 May 2023 21:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-9-d95d14949c79@linaro.org>
 <4a95547d-916a-3875-7752-f815429182e5@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 09/18] media: venus: hfi_venus: Fix version checks in
 venus_halt_axi()
In-Reply-To: <4a95547d-916a-3875-7752-f815429182e5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.05.2023 15:21, Vikash Garodia wrote:
> 
> On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
>> Only IRIS2(_1) should enter the until-now-IS_V6() path and the
>> condition for skipping part of it should be IS_IRIS2_1 and not the
>> number of VPP pipes. Fix that.
> 
> Do not see any issue with existing code. IRIS2 with single pipe is IRIS2_1. This does not
> 
> quality as a fix to earlier implementation. Since this series introduces VPU versions,
> 
> IRIS2 with 1 pipe is being replaced with IRIS2_1.
> 
> -Vikash
Right, I'll drop the fixes tags.

Also, your email client seems to be inserting 2 newlines instead of 1.
If you're using thunderbird, you may want to edit:

mail.identity.(default or your mail identity idx).default.compose_html

to `false`

or you can use shift+enter as a half-measure

Konrad
> 
>>
>> Fixes: 4b0b6e147dc9 ("media: venus: hfi: Add 6xx AXI halt logic")
>> Fixes: 78d434ba8659 ("media: venus: hfi: Skip AON register programming for V6 1pipe")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index 9b840440a115..ca56b1a8eb71 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -549,10 +549,10 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
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
