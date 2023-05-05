Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A136F897A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjEETYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjEETYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:24:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021854ECE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:24:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f004943558so2473547e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683314654; x=1685906654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFtYkfF8p6muyP6sCedXWbjjpL9Y5mT+RA/iKNtBB10=;
        b=VJ3LTdfpRrRm4cs5dtmtqonfhNqUXH23FibixicFrTmZRVei3kjJhYv+BuKziaFbQW
         KLz5rSjmnkHN22BFCqt400ZTtqtKEvqlqxIlmfE/5DY4kFDiOWtpH/4cUcrPS4E3DX/v
         8rM7/CU8GhkUd+Ck/CPQ5P8/eecBk/5Q6L6mPfQZY7DmeYjoIb5ChQ72HOtkimkfScXS
         h7NGPWVK37KTsQfX6kkLJlspagmr0NF/Fvf0CDE/8iEibJ69PL+5VOrNIkKZUWBWp7Sc
         2GsGFUmlJ9mJo7xLvrUjc+ayGbFOi7UilS0bqbNCrCU6OL1ZRINKl7H4ZqmcCK9dI86c
         dvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683314654; x=1685906654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFtYkfF8p6muyP6sCedXWbjjpL9Y5mT+RA/iKNtBB10=;
        b=Xim6/lKlXia9sTCBOHx4RlRJjA4wd9EhSuH66vyNoViG0I7xE+UHdhutLJflgDcYPq
         59NGvwo2F35dfRMe3+cfZqR6gg8XYV0x2dbeO/wfbaTAzDkttFyLNrA7RLNXORRPQEDH
         X7n6aAPvPBIebD342Zhtk5YvUvbunxXfRYGvgWoqSDXS7qCqllF/PZkyMSoK7TrYXJDp
         1RbS8LasKoLNilvCkGHLXDLNfjMpznpkRV02107FOgYOjC8270X9dFLwKHyQy35sgF2l
         WX/Ogr8XR9etFe1q3vjTgnm7aMXfM6fNqy8ceEJwPvWY05VW3/V18EtRxjJUtBXIOAEx
         M9lg==
X-Gm-Message-State: AC+VfDzOzRCfq8jtiPFsmMYuAPrmC8icxYzAT28S4SHGn+m+WtCvvri4
        pWdoi5Rcs2Dn1aH1rivoTHX/BA==
X-Google-Smtp-Source: ACHHUZ54q+neVDa21tI+PCZkTtJCDWQQqHFBfX132vGVIsROm4MXbqMnO9o91Xe4jw6Z90CxQZA62Q==
X-Received: by 2002:ac2:5a5e:0:b0:4f1:3b3e:2143 with SMTP id r30-20020ac25a5e000000b004f13b3e2143mr693303lfn.38.1683314654273;
        Fri, 05 May 2023 12:24:14 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id z28-20020a05651c023c00b002ab59a09d75sm84477ljn.120.2023.05.05.12.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:24:13 -0700 (PDT)
Message-ID: <9acc7001-2b3a-f635-9814-95850a71f142@linaro.org>
Date:   Fri, 5 May 2023 21:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 06/18] media: venus: firmware: Leave a clue for
 homegrown porters
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
 <20230228-topic-venus-v2-6-d95d14949c79@linaro.org>
 <ef50ac6c-a635-7f83-c484-a4f91b5e5d12@quicinc.com>
 <579f3480-1cbc-5688-7226-986205b5825e@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <579f3480-1cbc-5688-7226-986205b5825e@quicinc.com>
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



On 5.05.2023 15:00, Vikash Garodia wrote:
> 
> On 5/5/2023 6:27 PM, Vikash Garodia wrote:
>>
>> On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
>>> Leave a clue about where the seemingly magic values come from, as it
>>> is not obvious and requires some digging downstream..
> Rephrase the commit text.
Please be more specific, do you want me to use the
explanations you gave in the previous reply?

Konrad
>>> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>>> ---
>>>   drivers/media/platform/qcom/venus/firmware.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
>>> index cfb11c551167..a4cd919e1dbe 100644
>>> --- a/drivers/media/platform/qcom/venus/firmware.c
>>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>>> @@ -241,6 +241,13 @@ int venus_boot(struct venus_core *core)
>>>           return ret;
>>>         if (core->use_tz && res->cp_size) {
>>> +        /*
>>> +         * Clues for porting using downstream data:
>>> +         * cp_start = 0
>>> +         * cp_size = venus_ns/virtual-addr-pool[0] (yes, addr not size)
>>
>> The field is the start address of ns context bank. Since the cp_start is 0, the start address for (next) non-secure context bank
>>
>> is interpreted as size of the (previous) content protection region.
>>
>>> +         * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
>>> +         * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
>>> +         */
>>>           ret = qcom_scm_mem_protect_video_var(res->cp_start,
>>>                                res->cp_size,
>>>                                res->cp_nonpixel_start,
>>>
