Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225C9729A5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbjFIMtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbjFIMse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:48:34 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D5DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:48:31 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1a3fa2cd2so18873211fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686314910; x=1688906910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qlHjtuka3EM/1icDFeEAuKFU7NF/3XuZyw3Kr6tzfg=;
        b=XFLZgz7HRBazltMXr83B4K7+r4xSmd9LBYKNmCz6YiNg+otbkE3CdlSC8iF1ayMycB
         0kTql6CJHTwbHQ+9oNgBEQ1/WhrHZnsP6e4YQ6lgbom9odac3HIS19Bj/K5O06/jXfu+
         c6dVVZ3zp2n35+tcUG0Yrmr/5MpmSbOEeQ6wCsoiaYJ5H0e7iTcag+74Z0HL+lDNkuXr
         swFpC7CVsbSQ/82RIOWQRxsc9NQwndUqwW+hJ201xwVINPNAeDG6/wTeHkP6jybH3qMw
         Klbqf+ldHjz5H8cEvYpuJYzoFlcA/2zZ5dMYzx7/KuUqDZSqW5fjOGGr7/l45Xd1qTYF
         uD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686314910; x=1688906910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qlHjtuka3EM/1icDFeEAuKFU7NF/3XuZyw3Kr6tzfg=;
        b=kfyQpDm+MlrkkUM7lhGZek/PkW93oJBUDZAZkXQPhaU/SITN+bFpRRGuBT17xuhAVy
         aOikov3VBSgy4v0pOIPxe2+GXFPV7EryhQNSgkaAII1O50gg9HrNDP85tf/RuTzqS4XJ
         exyikNokCDeywjw19wE31BOsgXkDDXJ5z+Nv/Y3ZJnZkmfRd5D+ayTbAs6rHkkBQYUl6
         RFjZ4hWJsFBj81sM7squEtXEE5XB9cOYfX9q76j2LMAYkLctvwLfEw1oQ2O3fTcz+bCx
         0WyPJBWtJ0ItQjNgd22Z4dsdMqHP+EGV/cJkm7ygChfeQDfmlXW0VQPYIndCRnyXL0+G
         6mwQ==
X-Gm-Message-State: AC+VfDzUqcDgrkypslTKfT6IE3xiVm9Mqwwt8hsakVT5meHLU2/hCIyZ
        dhcuRA/za7fKq1bCavj5JjWmKA==
X-Google-Smtp-Source: ACHHUZ5yx9VjMx2ZIe/pGjV83p8dB2ckRHwUMfi322J85Y4uRvUT/L/D19DQ+nIEO1j2HjYxd4clKg==
X-Received: by 2002:a2e:8186:0:b0:2ae:e214:482f with SMTP id e6-20020a2e8186000000b002aee214482fmr1073617ljg.52.1686314910088;
        Fri, 09 Jun 2023 05:48:30 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id s4-20020a2e98c4000000b002b1a8e9d728sm372596ljj.64.2023.06.09.05.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 05:48:29 -0700 (PDT)
Message-ID: <71d5758c-793a-3e9a-543f-19e326ecfcd4@linaro.org>
Date:   Fri, 9 Jun 2023 14:48:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V3 2/5] clk: qcom: Remove support to set CAL_L field in
 lucid evo pll configure
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230601143430.5595-1-quic_jkona@quicinc.com>
 <20230601143430.5595-3-quic_jkona@quicinc.com>
 <1d29bc3f-12db-a676-56f8-b8c1a09063dc@linaro.org>
 <e9781cda-8eb4-99e0-8ed7-09c2534638e0@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e9781cda-8eb4-99e0-8ed7-09c2534638e0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.06.2023 13:49, Jagadeesh Kona wrote:
> Hi Dmitry,
> 
> Thanks for your review!
> 
> On 6/1/2023 8:16 PM, Dmitry Baryshkov wrote:
>> On 01/06/2023 17:34, Jagadeesh Kona wrote:
>>> For lucid evo and ole pll's the CAL_L, RINGOSC_CAL_L and L_VAL are
>>> part of the same register, hence update the l configuration value
>>> to include these fields across all the chipsets.
>>>
>>> Since the l configuration value now includes both L and CAL_L fields,
>>> there is no need to explicitly set CAL_L field again in lucid evo pll
>>> configure, Hence remove support to explicity set CAL_L field for evo pll.
>>>
>>> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>> ---
>>> Changes since V2:
>>>   - Squashed update L val and remove explicit cal_l configuration to single patch
>>>   - Updated L configuration for gpucc-sm8450 as well which was merged recently
>>> Changes since V1:
>>>   - Newly added.
>>>
>>>   drivers/clk/qcom/camcc-sm8450.c  | 24 ++++++++++++++++--------
>>>   drivers/clk/qcom/clk-alpha-pll.c |  6 +-----
>>>   drivers/clk/qcom/dispcc-sm8450.c |  6 ++++--
>>>   drivers/clk/qcom/dispcc-sm8550.c |  6 ++++--
>>>   drivers/clk/qcom/gpucc-sa8775p.c |  6 ++++--
>>>   drivers/clk/qcom/gpucc-sm8450.c  |  6 ++++--
>>>   6 files changed, 33 insertions(+), 21 deletions(-)
>>
>> I'd say, this is still not a correct solution from my point of view. A correct solution would be to follow the existing code and use constants for the constant values (of CAL_L, and RINGOSC_CAL_L).
>>
> 
> Sure, will keep the existing code as is and will remove this patch in the next series.
> 
>>>
>>> diff --git a/drivers/clk/qcom/camcc-sm8450.c b/drivers/clk/qcom/camcc-sm8450.c
>>> index 51338a2884d2..6a5a08f88598 100644
>>> --- a/drivers/clk/qcom/camcc-sm8450.c
>>> +++ b/drivers/clk/qcom/camcc-sm8450.c
>>> @@ -57,7 +57,8 @@ static const struct pll_vco rivian_evo_vco[] = {
>>>   static const struct clk_parent_data pll_parent_data_tcxo = { .index = DT_BI_TCXO };
>>>   static const struct alpha_pll_config cam_cc_pll0_config = {
>>> -    .l = 0x3e,
>>> +    /* .l includes CAL_L_VAL, L_VAL fields */
>>> +    .l = 0x0044003e,
>>>       .alpha = 0x8000,
>>>       .config_ctl_val = 0x20485699,
>>>       .config_ctl_hi_val = 0x00182261,
>>> @@ -128,7 +129,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll0_out_odd = {
>>>   };
> 
> [skipped]
> 
> Thanks & Regards,
> Jagadeesh
Another non-patch-related nit, you don't have to (and shouldn't) cut off
parts of the email unless it helps you "get to the point". You can also
include your signature after the last paragraph you reply with.

Konrad
