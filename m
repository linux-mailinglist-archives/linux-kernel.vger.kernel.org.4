Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA1719E35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjFANaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjFAN3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:29:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0AB1A1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:29:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so1008628e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685626149; x=1688218149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bi4W45hTLVZELv8za/V/2Zxr2Ta54wvM2WdGCMd0O68=;
        b=usImXdnWeIdqEvzWwlkFEyzWjMmuHQv5QUbYFpAKRMLB8He1y/ZwMjOrjfF1jlFZPJ
         PCf5j44mSgnLPhk/j3P3qzv1eP8CT5YysheWpWPC++9ltw/wFL/7dqkLq5gEcBRYdQ29
         6i5o5oRWrH1HYCLZZnO4SjVOVX4pVjtWDBVMraNHklYD5gxb4gVFg3OtOSB+woHK38Mi
         pj7HWN15JxJAJoggGokB3aBDvvPP39g9cThhZmfktvefJYGhNtyxSGjCQ9dqD+TRatb0
         a4MU+Gl4BfE8Xgmh5lf2nwsznu/7KS6SNnX4UMj88t2IdUBlTf4xaOlj3k0tRY6iODj8
         ypfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685626149; x=1688218149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bi4W45hTLVZELv8za/V/2Zxr2Ta54wvM2WdGCMd0O68=;
        b=iJZ9ZRe6UvJ3nUNsem1uVtPNuceP5s5cPe6HJTGHa1OClN6Ud8FGzxadWbHchMgat1
         wdOaI4FmM/YS1CFiF8uAbkBuW84lsnJiadjgCJjwQ7Oxp1i818FE6A+7A6OHg8EisBcJ
         0kIK/cjaqohPsOIaSrcB8khAQo/DEJGKfA0sZFyRBD0m6Qx6FwsBDzlArDoGu6kpBu/D
         WbY5ZJ4QfyimOz6jVAtL8wuNdsm8GBeHSF36zwkrpvWRHHUfOImfpIEqjhONSWhXbitL
         O9SOrdcSNGalDDJ0YehUVHNhzzl0YzoarNVuvPpmkMw3+LQjgvjhCziPpUCMsjxf1VLb
         mMYg==
X-Gm-Message-State: AC+VfDwnULokyTxDnP7ulQuJXx+oW7b+ovvlfXJTu3uDoaq65KRUtQx+
        uwfx3TZj9L7jfGieD1ud49N1Jg==
X-Google-Smtp-Source: ACHHUZ7xdhJFrnEy0COc6Xnf+tMXkERGlnWTaEpzDFcQgu4QYbHbjeFepEL1SVezrW0HikHmrmE7xQ==
X-Received: by 2002:ac2:4312:0:b0:4f3:afcc:e1bb with SMTP id l18-20020ac24312000000b004f3afcce1bbmr1756419lfh.1.1685626149679;
        Thu, 01 Jun 2023 06:29:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004f20d0ebe50sm1084096lfi.94.2023.06.01.06.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:29:09 -0700 (PDT)
Message-ID: <98c8fb8f-1fe6-1c05-2093-67efc7ec582a@linaro.org>
Date:   Thu, 1 Jun 2023 15:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 20/20] interconnect: qcom: Divide clk rate by src node bus
 width
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
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-20-1bf8e6663c4e@linaro.org>
 <5a26e456-fe45-6def-27f9-26ec00c333e6@linaro.org>
 <ZHZIVJFd-HU_AO2F@gerhold.net>
 <4943572a-3456-ae33-387f-db476ff382e4@linaro.org>
 <ZHib62imkvHds-9a@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZHib62imkvHds-9a@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 15:23, Stephan Gerhold wrote:
> On Thu, Jun 01, 2023 at 02:43:50PM +0200, Konrad Dybcio wrote:
>> On 30.05.2023 21:02, Stephan Gerhold wrote:
>>> On Tue, May 30, 2023 at 06:32:04PM +0200, Konrad Dybcio wrote:
>>>> On 30.05.2023 12:20, Konrad Dybcio wrote:
>>>>> Ever since the introduction of SMD RPM ICC, we've been dividing the
>>>>> clock rate by the wrong bus width. This has resulted in:
>>>>>
>>>>> - setting wrong (mostly too low) rates, affecting performance
>>>>>   - most often /2 or /4
>>>>>   - things like DDR never hit their full potential
>>>>>   - the rates were only correct if src bus width == dst bus width
>>>>>     for all src, dst pairs on a given bus
>>>>>
>>>>> - Qualcomm using the same wrong logic in their BSP driver in msm-5.x
>>>>>   that ships in production devices today
>>>>>
>>>>> - me losing my sanity trying to find this
>>>>>
>>>>> Resolve it by using dst_qn, if it exists.
>>>>>
>>>>> Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>> The problem is deeper.
>>>>
>>>> Chatting with Stephan (+CC), we tackled a few issues (that I will send
>>>> fixes for in v2):
>>>>
>>>> 1. qcom_icc_rpm_set() should take per-node (src_qn->sum_avg, dst_qn->sum_avg)
>>>>    and NOT aggregated bw (unless you want ALL of your nodes on a given provider
>>>>    to "go very fast")
>>>>
>>>> 2. the aggregate bw/clk rate calculation should use the node-specific bus widths
>>>>    and not only the bus width of the src/dst node, otherwise the average bw
>>>>    values will be utterly meaningless
>>>>
>>>
>>> The peak bandwidth / clock rate is wrong as well if you have two paths
>>> with different buswidths on the same bus/NoC. (If someone is interested
>>> in details I can post my specific example I had in the chat, it shows
>>> this more clearly.)
>> agg_peak takes care of that, I believe..
>>
> 
> I was just nitpicking on your description here, I think the solution
> you/we had in mind was already correct. :)
> 
>>
>>>
>>>> 3. thanks to (1) and (2) qcom_icc_bus_aggregate() can be remodeled to instead
>>>>    calculate the clock rates for the two rpm contexts, which we can then max()
>>>>    and pass on to the ratesetting call
>>>>
>>>
>>> Sounds good.
>>>
>>>>
>>>> ----8<---- Cutting off Stephan's seal of approval, this is my thinking ----
>>>>
>>>> 4. I *think* Qualcomm really made a mistake in their msm-5.4 driver where they
>>>>    took most of the logic from the current -next state and should have been
>>>>    setting the rate based on the *DST* provider, or at least that's my
>>>>    understanding trying to read the "known good" msm-4.19 driver
>>>>    (which remembers msm-3.0 lol).. Or maybe we should keep src but ensure there's
>>>>    also a final (dst, dst) vote cast:
>>>>
>>>> provider->inter_set = false // current state upstream
>>>>
>>>> setting apps_proc<->slv_bimc_snoc
>>>> setting mas_bimc_snoc<->slv_snoc_cnoc
>>>> setting mas_snoc_cnoc<->qhs_sdc2
>>>>
>>>>
>>>> provider->inter_set = true // I don't think there's effectively a difference?
>>>>
>>>> setting apps_proc<->slv_bimc_snoc
>>>> setting slv_bimc_snoc<->mas_bimc_snoc
>>>> setting mas_bimc_snoc<->slv_snoc_cnoc
>>>> setting slv_snoc_cnoc<->mas_snoc_cnoc
>>>> setting mas_snoc_cnoc<->qhs_sdc2
>>>>
>>>
>>> I think with our proposed changes above it does no longer matter if a
>>> node is passed as "src" or "dst". This means in your example above you
>>> just waste additional time setting the bandwidth twice for
>>> slv_bimc_snoc, mas_bimc_snoc, slv_snoc_cnoc and mas_snoc_cnoc.
>>> The final outcome is the same with or without "inter_set".
>> Yeah I guess due to the fact that two "real" nodes are always
>> connected by a set of "gateway" nodes, the rate will be applied..
>>
>> I am however not sure if we're supposed to set the bandwidth
>> (via qcom_icc_rpm_set()) on all of them..
>>
> 
> I think so? The nodes RPM doesn't care about shouldn't have
> a slv/mas_rpm_id.
Hm I guess the inter_set doesn't make a difference anyway, as you
pointed out.. Thankfully one thing less to fix :D

Konrad
