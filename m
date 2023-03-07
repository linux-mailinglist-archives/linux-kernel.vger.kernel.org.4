Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A96ADD1F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCGLTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjCGLSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:18:37 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B7144A0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:18:33 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h9so12779971ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 03:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678187912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEJH2oPkbi1+iJDHn1rP4D2o13uzAezWWeXGGiglOnA=;
        b=QXV5F31hp/CbDr8oy2zdsTE5WwhxjRPnx51w4/9yWPm0uBeR46c9+9h1eX9kKtAJGI
         E+EcjkFBN2shyjHFFNIVK4ud0xBoVawDoqXj+GK99mgSglQjgghoXn3mzYC6ZeKcYB4z
         tsXpS3Hrrp341UO9+ahGtCHBaY+2bveECG3utFb2Hp0RFlDNBuWFsixS4fqQvR9Yjzsd
         gYxQUmRVp33Wcex8Fivdt5vFLasXpoc/1MUX+cJeSqZsHYnuA/9w4Dxubq02ZxIgByvK
         63/L1XEa9dJfIj8WRbJU51KWLW/Ux6lOV9lPY42t0Zf5gYSPF0lX6SoE4GgfOQM9X4pq
         otMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678187912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEJH2oPkbi1+iJDHn1rP4D2o13uzAezWWeXGGiglOnA=;
        b=AUdrR2hXBFYY+UnPCkGPuMVU3jmfw37atBm1S0jflto0qADH8CDymDl67KWL8A7UHz
         RtHbzqj3ngNFaxLfnRcm5Fk8GAVR5taZLRtf6UxfNOvjPMTkMKBGQ8KXUHNz6N8Luy9W
         VGtQNjFYTHl+Un3BG7JDeBX1qeud9MXLN4bovcGgPBoE0D5pvAHsu7ye5NsonVBNlK2O
         5uINPD8skzT2gqvCjklfqwTYIO5QZ/pCb2mxh6k5fcJ1idQKYG8NI7V5o+ok4GSzm28E
         yylWisnNRox0O4yXs5QqB9n7gGR9YP0HvacAINGTDm8FZbn1vRB7FYPHp4+9EGxjLk69
         Pf4g==
X-Gm-Message-State: AO0yUKU+CVCkUOUtrK1twEr62CFH+rariwlyNgOxhMxNCkjmpGHLTDCB
        MewtZ8jMYHkkJFLy3nScb36O/w==
X-Google-Smtp-Source: AK7set+Ex4pJbRG4CQNBxxBBHsApvu6Oe1P+M6XD1BdlbnHPo+Fzz61dmlFW8f0MPwzp3MTYjk5Chg==
X-Received: by 2002:a2e:998c:0:b0:295:aca0:8205 with SMTP id w12-20020a2e998c000000b00295aca08205mr3893351lji.52.1678187911960;
        Tue, 07 Mar 2023 03:18:31 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id g10-20020ac2538a000000b004ddaea30ba6sm1993150lfh.235.2023.03.07.03.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 03:18:31 -0800 (PST)
Message-ID: <9cb64f82-b6d0-44fa-4851-2cb1a5c2c94c@linaro.org>
Date:   Tue, 7 Mar 2023 12:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/18] media: venus: core: Assign registers based on VPU
 version
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-7-58c2c88384e9@linaro.org>
 <a93a16ec-2e56-1d0b-c326-25f490d8f5b5@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a93a16ec-2e56-1d0b-c326-25f490d8f5b5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.03.2023 05:57, Dikshita Agarwal wrote:
> 
> On 2/28/2023 8:54 PM, Konrad Dybcio wrote:
>> IRIS2(_1) has a different register map compared to other HFI6XX-
>> using VPUs. Take care of it.
>>
>> Signed-off-by: Konrad Dybcio<konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
>> index c13436d58ed3..bdc14acc8399 100644
>> --- a/drivers/media/platform/qcom/venus/core.c
>> +++ b/drivers/media/platform/qcom/venus/core.c
>> @@ -246,7 +246,7 @@ static int venus_enumerate_codecs(struct venus_core *core, u32 type)
>>     static void venus_assign_register_offsets(struct venus_core *core)
>>   {
>> -    if (IS_V6(core)) {
>> +    if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
>>           core->vbif_base = core->base + VBIF_BASE;
>>           core->cpu_base = core->base + CPU_BASE_V6;
>>           core->cpu_cs_base = core->base + CPU_CS_BASE_V6;
> 
> AR50_LITE also should be added here, as I see you have added the same to places where we are using V6 based registers.
> 
> if the base addresses are not assigned here properly. the register writing at other places will be wrong, ex: patch 05/18
I have a separate patch set which specifically adds AR50L data,
and they're not 1:1, vbif_base and aon_base are gone (at least
according to techpack/video). I intend to push it when I get it
all working, but here's what it looks like right now:


diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index fd9ecb1f7a05..f88b4781c5d0 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -254,6 +254,14 @@ static void venus_assign_register_offsets(struct venus_core *core)
                core->wrapper_base = core->base + WRAPPER_BASE_V6;
                core->wrapper_tz_base = core->base + WRAPPER_TZ_BASE_V6;
                core->aon_base = core->base + AON_BASE_V6;
+       } else if (IS_AR50_LITE(core)) {
+               core->vbif_base = NULL;
+               core->cpu_base = core->base + CPU_BASE_V6;
+               core->cpu_cs_base = core->base + CPU_CS_BASE_V6;
+               core->cpu_ic_base = core->base + CPU_IC_BASE_V6;
+               core->wrapper_base = core->base + WRAPPER_BASE_V6;
+               core->wrapper_tz_base = core->base + WRAPPER_TZ_BASE_V6;
+               core->aon_base = NULL;
        } else {
                core->vbif_base = core->base + VBIF_BASE;
                core->cpu_base = core->base + CPU_BASE;
-- 
2.39.2


Konrad

> 
> Thanks,
> 
> Dikshita
> 
