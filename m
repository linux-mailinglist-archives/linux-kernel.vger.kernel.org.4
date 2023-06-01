Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE43719C63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjFAMn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjFAMn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:43:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA54D13D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:43:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso926565e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685623434; x=1688215434;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZj6+TO9cetRqFmZScJnzrH91ahC5Pe0XUE1xU0CNO0=;
        b=rSQYgK6Tpo+MABXaIL1N2j7Fn0MuV25MUc6OWn4uinv1045fU2ZTGiwD/vsQMZ38xC
         Mm6RDZNcLCHjgJMZ+EXnUaxoe0gVFEkdrc/A0K5VYFY3e/lsEaQjDKsTOOHG8GIQC+pj
         XN4vyxARephQWmvC4c/zQBnyv9R4VXRkHmtAExxRhbrlBrC9TabmFXqA16IiPTVXMWcn
         bnTAso+N1SM/nC1xCAe3UcCP1wozeaBIckVVh5j4f+elbDxBCsCKM9+/I1h0Xk1qJaqA
         3S86f3ztabuvewtdjYEmggS0P7t+Ab7vIxdoWwZkWSTraqsrjw1f1edG25lp/2CJ3FtB
         kwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685623434; x=1688215434;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZj6+TO9cetRqFmZScJnzrH91ahC5Pe0XUE1xU0CNO0=;
        b=T96LFYS0A55a6qGCAEZHlKGqOkEQIGUOwDelSVni5TdXo24cWomiD7V6F48bQbYsP5
         d6WKkcEjmoz9oPCg5BVR+7uDnEvAExxqeJgPHFGRqSIXOxg6Z0iRgmBOzlg9iGwfNwTw
         4m+GlRh9cOUMQ5x3fsFhOop5XWMtjlKrA1gtvVAREW6D/ckpUHHDUVcWObfSriTsksDh
         R+wzaYZjsND4/Fwzwmy08cH0Qv0nJZfC+CFEGeFR2cPRicDuz8CaQ6kntQGMpZPdw97K
         Ol8MJTjRrlwZweogmHxPGk+JVnYMKuOotc9chhFWYIZYqdG+XuX1FVP8gIBedQcdhVp9
         SvLA==
X-Gm-Message-State: AC+VfDzciCXINyb7f2qWkeXV6KIdOS3eswr0L1V3IPeGJrRpaocpZ/0Q
        dskMs23K0SK2o76Lvw0Ckg7BPA==
X-Google-Smtp-Source: ACHHUZ6FJWrak/ultHHEb2CoK21JhwC0uCB93REGoqO+GGWVnkSpZNI4KWn+YR8yS6VhHa25ulvB5g==
X-Received: by 2002:ac2:44d8:0:b0:4f3:859c:a01d with SMTP id d24-20020ac244d8000000b004f3859ca01dmr1465371lfm.69.1685623433986;
        Thu, 01 Jun 2023 05:43:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id h6-20020a197006000000b004f608eb50d7sm140878lfc.232.2023.06.01.05.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 05:43:52 -0700 (PDT)
Message-ID: <4943572a-3456-ae33-387f-db476ff382e4@linaro.org>
Date:   Thu, 1 Jun 2023 14:43:50 +0200
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
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-20-1bf8e6663c4e@linaro.org>
 <5a26e456-fe45-6def-27f9-26ec00c333e6@linaro.org>
 <ZHZIVJFd-HU_AO2F@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 20/20] interconnect: qcom: Divide clk rate by src node bus
 width
In-Reply-To: <ZHZIVJFd-HU_AO2F@gerhold.net>
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



On 30.05.2023 21:02, Stephan Gerhold wrote:
> On Tue, May 30, 2023 at 06:32:04PM +0200, Konrad Dybcio wrote:
>> On 30.05.2023 12:20, Konrad Dybcio wrote:
>>> Ever since the introduction of SMD RPM ICC, we've been dividing the
>>> clock rate by the wrong bus width. This has resulted in:
>>>
>>> - setting wrong (mostly too low) rates, affecting performance
>>>   - most often /2 or /4
>>>   - things like DDR never hit their full potential
>>>   - the rates were only correct if src bus width == dst bus width
>>>     for all src, dst pairs on a given bus
>>>
>>> - Qualcomm using the same wrong logic in their BSP driver in msm-5.x
>>>   that ships in production devices today
>>>
>>> - me losing my sanity trying to find this
>>>
>>> Resolve it by using dst_qn, if it exists.
>>>
>>> Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>> The problem is deeper.
>>
>> Chatting with Stephan (+CC), we tackled a few issues (that I will send
>> fixes for in v2):
>>
>> 1. qcom_icc_rpm_set() should take per-node (src_qn->sum_avg, dst_qn->sum_avg)
>>    and NOT aggregated bw (unless you want ALL of your nodes on a given provider
>>    to "go very fast")
>>
>> 2. the aggregate bw/clk rate calculation should use the node-specific bus widths
>>    and not only the bus width of the src/dst node, otherwise the average bw
>>    values will be utterly meaningless
>>
> 
> The peak bandwidth / clock rate is wrong as well if you have two paths
> with different buswidths on the same bus/NoC. (If someone is interested
> in details I can post my specific example I had in the chat, it shows
> this more clearly.)
agg_peak takes care of that, I believe..


> 
>> 3. thanks to (1) and (2) qcom_icc_bus_aggregate() can be remodeled to instead
>>    calculate the clock rates for the two rpm contexts, which we can then max()
>>    and pass on to the ratesetting call
>>
> 
> Sounds good.
> 
>>
>> ----8<---- Cutting off Stephan's seal of approval, this is my thinking ----
>>
>> 4. I *think* Qualcomm really made a mistake in their msm-5.4 driver where they
>>    took most of the logic from the current -next state and should have been
>>    setting the rate based on the *DST* provider, or at least that's my
>>    understanding trying to read the "known good" msm-4.19 driver
>>    (which remembers msm-3.0 lol).. Or maybe we should keep src but ensure there's
>>    also a final (dst, dst) vote cast:
>>
>> provider->inter_set = false // current state upstream
>>
>> setting apps_proc<->slv_bimc_snoc
>> setting mas_bimc_snoc<->slv_snoc_cnoc
>> setting mas_snoc_cnoc<->qhs_sdc2
>>
>>
>> provider->inter_set = true // I don't think there's effectively a difference?
>>
>> setting apps_proc<->slv_bimc_snoc
>> setting slv_bimc_snoc<->mas_bimc_snoc
>> setting mas_bimc_snoc<->slv_snoc_cnoc
>> setting slv_snoc_cnoc<->mas_snoc_cnoc
>> setting mas_snoc_cnoc<->qhs_sdc2
>>
> 
> I think with our proposed changes above it does no longer matter if a
> node is passed as "src" or "dst". This means in your example above you
> just waste additional time setting the bandwidth twice for
> slv_bimc_snoc, mas_bimc_snoc, slv_snoc_cnoc and mas_snoc_cnoc.
> The final outcome is the same with or without "inter_set".
Yeah I guess due to the fact that two "real" nodes are always
connected by a set of "gateway" nodes, the rate will be applied..

I am however not sure if we're supposed to set the bandwidth
(via qcom_icc_rpm_set()) on all of them..

Konrad
> 
> Thanks,
> Stephan
