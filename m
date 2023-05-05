Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C876F893F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjEETCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjEETCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:02:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A322713
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:02:14 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ac785015d6so23941101fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683313332; x=1685905332;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DHrbJmJ6pFE60C2QgNVteL41mfnKZPzjw2eVnO1Z4E=;
        b=wbc1s/lVAY5eMhASkedKn69kWnMmb5ObWL8voCRmaduIz0OsomcWxa8KL1PxlPktCT
         zhh7URlrau+CosnPVUze8bJnMJVcSmkixbBBGpvFqL4yW3MybkhqcSmVaeQQWV1CbRKk
         ncOi/y2+kPgTkRzJjEhE3gtYIFogYifpehGqAdVcbsT/renmsNTnLL2zpnzitOeh/HTz
         EAfLuxfGAAVA2sXRUmj8fzfYqJWrFOqIpXDE7YPDo2vvggb86FjPdG2Lp9hZKYnOaJ5F
         PcTsFIlzwU8rwBHJiN+P75WrJ08Uve5Iih0bFh0SsyHfO9qRhjLmzunBmkgt7ShRaUl6
         HiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683313332; x=1685905332;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DHrbJmJ6pFE60C2QgNVteL41mfnKZPzjw2eVnO1Z4E=;
        b=JzEwua5MPpAVzmf2sDdiBYCQHMMfpPFmwL8mM8esKK2ZZ9PPuiIzdmqvRyZgvx6LF4
         3Hf3L1b7R9nDW8P0EkAJ0I+o3n4A/defYBwCc5PtYSmOjU6OMjdq9w1tPBQz+52ualRg
         frVr6/jOUaa+Nge0OdSvW7wSa4FEFeJXJJNntsNZuVqr7JEuJnw1wSBkYh3mvaDfE/Yo
         pKJL75Bu5bfmTVUgq2qF+THOoqOspEK3PrrP1FheHO8u8G6gJQjrMTk4SOCB8ZIasRBk
         7lhl5ZOXEip6sBNK7u5okwjgjvImlQ9fln6aF6gXht0+FYwzcCrOHUnNQPZ34womXTf1
         FeIQ==
X-Gm-Message-State: AC+VfDyaka9AnlweKVrj+YE+jTFTct03+bWqh4vUIXV74MG5yk97TKIm
        hkSUYX19SJ/n817NEA5qZTUSTA==
X-Google-Smtp-Source: ACHHUZ67+S12jX06Un8bG9MrIT2ZKsDicFuukUOr2ITOg4B0jHdAwdlOndt1hYOfU+QT+GRtKajvkw==
X-Received: by 2002:a2e:818d:0:b0:2ac:7d7e:a503 with SMTP id e13-20020a2e818d000000b002ac7d7ea503mr749372ljg.36.1683313332494;
        Fri, 05 May 2023 12:02:12 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id q23-20020a2e84d7000000b002a77f45cc00sm81417ljh.29.2023.05.05.12.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:02:12 -0700 (PDT)
Message-ID: <0abecab7-23a1-1095-ba82-b2309f5bd45c@linaro.org>
Date:   Fri, 5 May 2023 21:02:10 +0200
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
        Marijn Suijten <marijn.suijten@somainline.org>,
        stable@vger.kernel.org
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-3-d95d14949c79@linaro.org>
 <14b47c1e-8092-b2f9-1a53-90c42b306de3@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 03/18] media: venus: Remap bufreq fields on HFI6XX
In-Reply-To: <14b47c1e-8092-b2f9-1a53-90c42b306de3@quicinc.com>
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



On 5.05.2023 14:38, Vikash Garodia wrote:
> On 5/4/2023 1:30 PM, Konrad Dybcio wrote:
>> Similarly to HFI4XX, the fields are remapped on 6XX as well. Fix it.
>>
>> Cc: stable@vger.kernel.org # v5.12+
>> Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_helper.h | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
>> index 105792a68060..e0c8f15644df 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
>> @@ -1170,11 +1170,14 @@ struct hfi_buffer_display_hold_count_actual {
>>     /* HFI 4XX reorder the fields, use these macros */
>>   #define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)    \
>> -    ((ver) == HFI_VERSION_4XX ? 0 : (bufreq)->hold_count)
>> +    ((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
>> +    ? 0 : (bufreq)->hold_count)
>>   #define HFI_BUFREQ_COUNT_MIN(bufreq, ver)    \
>> -    ((ver) == HFI_VERSION_4XX ? (bufreq)->hold_count : (bufreq)->count_min)
>> +    ((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
>> +    ? (bufreq)->hold_count : (bufreq)->count_min)
>>   #define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)    \
>> -    ((ver) == HFI_VERSION_4XX ? (bufreq)->count_min : 0)
>> +    ((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
>> +    ? (bufreq)->count_min : 0)
> 
> This patch is not correct. The existing code handles the disparity of buffer requirement payload received from firmware.
> 
> Its applicable only for V4.
> 
> For V6, driver does not rely on firmware to get the buffer requirement. Refer the buffer platform code for more details.
OK right I can see, downstream has a condition for IRIS2/IRIS2_1,
thanks for pointing this out!

Konrad
> 
> -Vikash
> 
>>   struct hfi_buffer_requirements {
>>       u32 type;
>>
