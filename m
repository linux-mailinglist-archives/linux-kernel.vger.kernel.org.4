Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED106F8968
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjEETPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjEETPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:15:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D98226BA
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:15:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4effb818c37so2499473e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683314146; x=1685906146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiVwRTZ+QB0butBciUvZ61eG+cEutYbIrZIhBCvhP3o=;
        b=a1zUZVp7P+Bh2nA8KmCkZNONcnTB4MHeOE46Lo5mSrQI7toRazkTUA/yoQshat7VO+
         VYhXS2FVhwq4dCXLY7FoPSN4NUQql0J8rOGYLunllmhQINLPecUim+rBM984BeTvyy8P
         D163wkf4ur+WUeZ+Ed8kkDv4Lv0BjdjLdxgkdLKdKyHgvl/KJjyDIU0gSKLJMd1nVcJO
         F8yRGaUESmmvlx6cJwB39T+UhQNqJo0NvkrGIllPrtwhYo1dV5HMd6guXUPAE8o+HnPU
         woDk8YjWyuQxMgG45Cgj+veypYdjUeVuW2unFsFLnIHhVSdF3ifPc9OKTosUsUAADO7B
         qQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683314146; x=1685906146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiVwRTZ+QB0butBciUvZ61eG+cEutYbIrZIhBCvhP3o=;
        b=CJzIsaDgoUIbGsZjQK9JUrpnrHGp5lv8xRCipGjymbWEcuN8YhPWgcRKn7NVtQt5d1
         i384fPd24DHThR3yRcP4/ZHz6EKUQN7jqGBBhzTCHVYkN5Z/LmNEoK4Q8CItEkVrREiE
         D7w6pJYF6BjjJuecgh6babEMiXpQogh5lr4LbM3FeOJ8tV673qPgMl0z8999c68hl1iS
         ZrRK/d2N5CgZmJLZkRp3hgLzgqrusX7HCyRIxKnAomjHbmf3RWHfTkxPrtz7m8J0PGY+
         yCst8759OdHC5tFhZ2zqLnI7uNW+FFyggGBMmsqylVAZMB60vDSOEPRGnhQYgVOUzeFS
         nRyw==
X-Gm-Message-State: AC+VfDymCNn+Tn/tUURajnhrRsPnTD4VyyzVryejCqbDVpx43hO2ZZX7
        JJp3iXeT4KS7a/W7S+fVYvf+MA==
X-Google-Smtp-Source: ACHHUZ64wwwFvhhC2i/OrhPzCndZiD4HH05o172Xk4jIKTQodmELoGOw0jIZCLOE94OPowrcDs4dAA==
X-Received: by 2002:ac2:47ea:0:b0:4e0:fe29:9313 with SMTP id b10-20020ac247ea000000b004e0fe299313mr715981lfp.15.1683314146638;
        Fri, 05 May 2023 12:15:46 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id x20-20020ac24894000000b004db0d26adb4sm383136lfc.182.2023.05.05.12.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:15:46 -0700 (PDT)
Message-ID: <0cfbb9ed-1bb0-ea9e-9896-9d3896ae18ff@linaro.org>
Date:   Fri, 5 May 2023 21:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 15/18] media: venus: vdec: Fix version check in
 vdec_set_work_route()
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
 <20230228-topic-venus-v2-15-d95d14949c79@linaro.org>
 <2d1f85f2-42c5-1d88-7f0f-f464babfabbc@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2d1f85f2-42c5-1d88-7f0f-f464babfabbc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.05.2023 16:02, Vikash Garodia wrote:
> 
> On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
>> This is not so much V6-dependent as it's IRIS(1|2|2_1). Fix it.
> Again, why is it marked as fix ?
It corrects the logic but does not manifest on currently
supported hardware. I'll reword it and drop the fixes tag.

>>
>> Fixes: 6483a8cbea54 ("media: venus: vdec: set work route to fw")
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/vdec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>> index 51a53bf82bd3..33e3f7208b1a 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -701,7 +701,7 @@ static int vdec_set_work_route(struct venus_inst *inst)
>>       u32 ptype = HFI_PROPERTY_PARAM_WORK_ROUTE;
>>       struct hfi_video_work_route wr;
>>   -    if (!IS_V6(inst->core))
>> +    if (!(IS_IRIS1(inst->core) || IS_IRIS2(inst->core) || IS_IRIS2_1(inst->core)))
> 
> Not a good idea to add IRIS1 just for deciding work route and not at other places in driver. Add IRIS1 relevant
> 
> code in other aspects as well, if the patch needs to handle anything w.r.t IRIS1.
I'd say that correcting this condition is fair regardless. I can
however delay this patch until IRIS1 enablement if you'd prefer
that.

Konrad
> 
>>           return 0;
>>         wr.video_work_route = inst->core->res->num_vpp_pipes;
>>
