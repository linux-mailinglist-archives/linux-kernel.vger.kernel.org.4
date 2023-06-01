Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82871A0B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjFAOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjFAOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:44:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3701B1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:43:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f5021faa16so1166095e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685630615; x=1688222615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9vPerXquIQBsMeR29IRTLCwtaBHY9UEGu+yqjA2ANM=;
        b=x/qqM/Bjrd4MksXHcIRMXeDh7A69sar4aQzUw7XXhcdu2uJXiRFBmSCANdfAK5CSg5
         qc6w1x5RQhsrBrgTDPlnw9DsMlCnGfAyj2rkeU3iXfs7M2N+A7AlNTApXfDRDANhV6Cs
         aiXwW5Zn6CZSHo2j9qQS4OGa1vpdCCResdu0CUndVEaRsPtT4WnaXnw2s2Exnd9p4k/I
         TrrQzt+MKnTHRylx5GDp6cESTubIGKvpCmtA9Es+MnZTsxU75MqHenu1uHq7QY/ByI12
         nje5hdQKSSl+Iy28B//eGcFMwiexToIRO6bnegU8YVZaeOQ0tIlDp2AMQo1BDlzfQq36
         g4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685630615; x=1688222615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9vPerXquIQBsMeR29IRTLCwtaBHY9UEGu+yqjA2ANM=;
        b=MC0BZHV7w5VZ4WJ1HCtfgJJ4oXQhb/QmI4//C0jzQ6aONr2GS01ypRLWRW5u3gvmdd
         BcKIm4gQ8LAPjis0Z/+v8W5gSXEG0iswFXvS+yr3r7SAZajSUZmYvWq7Onx92yLWNHMj
         20Tm9rjlpCXRqW7janvHoN/vPm/0IksN03p9TJQKf6//JIM0uswKvo/yfpyWEGfpkbgQ
         fh/gKhtNNQi+hm10lR+Z9vExFkOk/BS2pdd4lAMKOpGRI93ROZDb5y+1wSxeM55dwnC8
         HfQB2wWm9NwLzT1uRpAQZr01gW/qnOP2qnbXj6fbRa5Y0ELHK+VYEUdJS1AauK1e7RWM
         gxTg==
X-Gm-Message-State: AC+VfDxPRzRTxM/Jv2kpwVnZ1CDSqusboSwMsst/SxteMbhf2oGC83qN
        YeDFchlEHhWz0Tn98pj8uQ976nnK73tTCBOEA0Y=
X-Google-Smtp-Source: ACHHUZ76ao2NbgDl2Kv9JBguW1m9Ny566OnnpttU/IAXt2WxRdrpKBZk6h9s+DkgkhW451313+K37Q==
X-Received: by 2002:ac2:434e:0:b0:4f6:ab8:bc12 with SMTP id o14-20020ac2434e000000b004f60ab8bc12mr99020lfl.20.1685630614778;
        Thu, 01 Jun 2023 07:43:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm1108910lfi.98.2023.06.01.07.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:43:34 -0700 (PDT)
Message-ID: <c60bb4d9-1b53-6c60-8b9d-13069bdff882@linaro.org>
Date:   Thu, 1 Jun 2023 17:43:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 3/6] clk: qcom: clk-alpha-pll: Remove explicit CAL_L
 configuration for EVO PLL
Content-Language: en-GB
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
 <20230525172142.9039-4-quic_jkona@quicinc.com>
 <6e1d098d-03b9-aa63-a0bf-6cf748a0db0d@linaro.org>
 <7074f718-a3d5-8a03-3830-77a5a0b15500@linaro.org>
 <df7ab6f7-6c5e-9a7d-8d9b-09ff32da34d6@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <df7ab6f7-6c5e-9a7d-8d9b-09ff32da34d6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 17:33, Jagadeesh Kona wrote:
> Hi Dmitry, Konrad,
> 
> On 5/26/2023 9:23 PM, Dmitry Baryshkov wrote:
>> On 26/05/2023 12:33, Konrad Dybcio wrote:
>>>
>>>
>>> On 25.05.2023 19:21, Jagadeesh Kona wrote:
>>>> In lucid evo pll, the CAL_L field is part of L value register 
>>>> itself, and
>>>> the l value configuration passed from clock controller driver includes
>>>> CAL_L and L values as well. Hence remove explicit configuration of 
>>>> CAL_L
>>>> for evo pll.
>>>>
>>>> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL 
>>>> configuration interfaces")
>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> ---
>>> Oh that isn't obvious at first sight, nice find!
>>>
>>> I'd suggest a different solution though:
>>>
>>> #define LUCID_EVO_PLL_L_LVAL    GENMASK(..
>>> #define LUCID_EVO_PLL_L_CAL_L    GENMASK(..
>>>
>>> lval = FIELD_PREP(LUCID_EVO_PLL_L_LVAL, config->l) |
>>>         FIELD_PREP(LUCID_EVO_PLL_L_CAL_L, config->cal_l);
>>>
>>> This would make the separation between the two parts more explicit
>>>
>>> however
>>>
>>> config->l would then represent the L value and not the end value
>>> written to the L register
>>
>> Yes. I think there should be separate config->l and config->cal_l 
>> values (and probably ringosc_cal_l, basing on the comment in the source).
>> Thanks for your suggestions. In all recent chipsets, L & CAL_L fields 
> are encapsulated in the same register, so we feel it is better to 
> directly pass the combined configuration value in config->l itself and 
> program it directly into register without any additional handling 
> required in pll driver code.

My feeling is that it is better to split it, since these are the 
different fields. The value .l = 0x4444003e doesn't mean anything per se.

Three values are much more meaningful:
.l = 0x3e,
.cal_l = 0x44,
.ringosc_cal_l = 0x44,

Not to mention that this way you don't have to touch pll configuration 
for the existing Lucid EVO PLL. Not to mention that for the Lucid ole 
PLLs the cal_l and ringosc_cal_l values seem to be static (0x44), so 
there is no need to put them to the variable data.

> 
> Also the evo pll code is currently reused for both lucid evo and ole 
> pll's. Lucid ole PLL has an additional RINGOSC_CAL_L field along with L, 
> CAL_L fields in the same L register. By passing combined configuration 
> value in config->l itself, we feel we can avoid all the additional 
> handling required in PLL code.
> 
>> Just a question: is camcc-sm8550 using the same PLL type or is it some 
>> kind of subtype of lucid_evo PLL?
>>
> No, it is not the same lucid evo PLL. It uses lucid ole PLL.

Then please don't reuse the clk_lucid_evo_pll_configure() call.
You can add a new one, which will handle L/CAL_L/RINGOSC_CAL_L differences.

-- 
With best wishes
Dmitry

