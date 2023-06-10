Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3383572ADE9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjFJRxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjFJRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:53:46 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7B3198C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 10:53:44 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1ba50e50bso31705341fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686419623; x=1689011623;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIEzVxcGjD9CVIf4I3Z3N+pdYEhzOZJwo+94D6dlc90=;
        b=avuypdQbWhRDBnsYaWNoeHJSrw3yjmvuaUylUCZADfSHI6a01Rc/dPnkLpqsrDFYA/
         6GurQcQ49HaDhV2ozrJEuNs9JtIyvCRpom6ADaQox1bQ8AlSy46YynYJlEgnt5aANeHS
         SA2KDtaC91ZcVuLn9vBIQvhV0NK+wJDLcSLKkKF9pdbyTbr65FX/2j9PmHq996F6IzdG
         G+7k2bSSLzTmvJo+NPU9ck1dEmfRD8N9KL67yLqK/JsTmYSPAVbbMuyPlW8tRc3dVzH7
         UeQM8VMAFz0+/dR+zxN5V77ysYAX+NVufs0Ec0nYr+EImNAdFKE6ZVkGuJIJ/v6Bh46S
         d6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686419623; x=1689011623;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIEzVxcGjD9CVIf4I3Z3N+pdYEhzOZJwo+94D6dlc90=;
        b=itchZnTApwoVnaIDPvBUSLLZUTx7g/yu3Jx2U/TnyUqMQ6zfdpO7WbPWlIZjAadswR
         567JfNmNI87VGb0QrT4KVCj1h6YJmhGoUUcNAG/gw8CSj/0DLQoBCcvFwk/8Wi6PeWCk
         t6HIEsC8WiRvH/+zBjmjRZ3UWUw+MU9FQ1asYJbUT2b2qnkLa/uVxWDb/KRr45NahX1e
         k37THzqrrXpJ/lSMHbkwmL3wKKWIVJu1evEoKWFwe3EWLxZenCRO4Vvw8wVCnZItrfLT
         CfdYDyapeTMBbja7tsH7WfPog3uaihIJq3OlfWY7wlptTc1pZ5nIlaMm1rnJ7RcQzz3o
         BKMQ==
X-Gm-Message-State: AC+VfDzTO9++HgXauFO1DIm35CtLqyp/IzATTsfar9+jXz+RdPNARCwt
        5eLBktgfhBdkcy+9j6szAAvsHg==
X-Google-Smtp-Source: ACHHUZ5Zdfzr8CFUDI3hRBkQ5nKeKTTkx1v8rTzg1yj9ZMpNvVo+UG6snFwTJUNOau7ZjJwa7vtkmg==
X-Received: by 2002:a2e:9202:0:b0:2b1:c011:976d with SMTP id k2-20020a2e9202000000b002b1c011976dmr779111ljg.27.1686419623130;
        Sat, 10 Jun 2023 10:53:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id z11-20020a2e964b000000b002af8aaebce4sm932112ljh.8.2023.06.10.10.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 10:53:42 -0700 (PDT)
Message-ID: <d338d802-e1ee-cea1-2eff-e7da36b4829a@linaro.org>
Date:   Sat, 10 Jun 2023 19:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-19-e5934b07d813@linaro.org>
 <ZIS28eN1JEuXV2AT@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 19/22] interconnect: qcom: icc-rpm: Fix bucket number
In-Reply-To: <ZIS28eN1JEuXV2AT@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.06.2023 19:46, Stephan Gerhold wrote:
> On Fri, Jun 09, 2023 at 10:19:24PM +0200, Konrad Dybcio wrote:
>> SMD RPM only provides two buckets, one each for the active-only and
>> active-sleep RPM contexts. Use the correct constant to allocate and
>> operate on them.
>>
>> Fixes: dcbce7b0a79c ("interconnect: qcom: icc-rpm: Support multiple buckets")
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/interconnect/qcom/icc-rpm.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 6d40815c5401..3ac47b818afe 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> [...]
>> @@ -275,7 +275,7 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>>  	if (!tag)
>>  		tag = QCOM_ICC_TAG_ALWAYS;
>>  
>> -	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>> +	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
>>  		if (tag & BIT(i)) {
> 
> Hm, I think QCOM_ICC_NUM_BUCKETS is actually intentional here. There is
> a hint about this in the description of the commit in your Fixes line:
> 
>> This patch studies the implementation from interconnect rpmh driver to
>> support multiple buckets.  The rpmh driver provides three buckets for
>> AMC, WAKE, and SLEEP; this driver only needs to use WAKE and SLEEP
>> buckets, but we keep the same way with rpmh driver, this can allow us
>> to reuse the DT binding and avoid to define duplicated data structures.
> 
> As far as I understand, the idea was to reuse the definitions in
> qcom,icc.h and just ignore the AMC bucket for now. AFAIU AMC (or rather
> the lack thereof) is basically caching: Sending requests without AMC bit
> set is delayed until the next rpmh_flush() call that happens when
> entering a deep idle state. It requires some work but I guess
> theoretically one could implement exactly the same for RPM.
That's trying to shove a cube into a circle-shaped hole.. AMC is a
hardware (well, firmware.. you know what I mean) feature, which SMD
RPM lacks. Plus it'd result in useless allocations.

> 
> What you're actually doing here is not fixing the commit but changing
> the bindings. On MSM8909 I defined the ICC path for CPU<->RAM like this:
> 
> 	interconnects = <&bimc MAS_APPS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> 			 &bimc SLV_EBI QCOM_ICC_TAG_ACTIVE_ONLY>;
> 
> Per definition in qcom,icc.h:
> 
> 	QCOM_ICC_TAG_ACTIVE_ONLY = (AMC | WAKE) = (BIT(0) | BIT(1))
> 
> Without your patch series this behaves correctly. It results in an
> active-only vote.
> 
> The change of behavior is in PATCH 17/22 "interconnect: qcom: icc-rpm:
> Control bus rpmcc from icc". It silently switches from
> QCOM_ICC_BUCKET_WAKE (1) and QCOM_ICC_BUCKET_SLEEP (2) to
> QCOM_SMD_RPM_ACTIVE_STATE (0) and QCOM_SMD_RPM_SLEEP_STATE (1).
> 
> In other words, QCOM_ICC_TAG_ACTIVE_ONLY (BIT(0) | BIT(1)) now results
> in an active+sleep vote, not an active-only one. :)
> 
> There doesn't seem to be an upstream user of the ICC tags/buckets for
> icc-rpm yet so personally I would be fine with changing it. However,
> then qcom,icc.h should get a clear comment that it's rpmh-only and we
> should define a new qcom,icc-rpm.h.
Right, I'd argue the original commit was in the wrong here. It was trying
to reuse bindings which were intended for a different hw architecture (and
perhaps not described very well - there's no word of RPMh neither in the
name nor in the defines themselves). That's an abuse in my view..

I think introducing RPM-specific bindings and communicating the change
clearly is the way to go. As you've noticed, there are no users so that
should not be problematic at all.

Konrad
> 
> Or perhaps we should just drop this patch and continue using
> QCOM_ICC_BUCKET_WAKE and QCOM_ICC_BUCKET_SLEEP as before?
> 
> Thanks,
> Stephan
