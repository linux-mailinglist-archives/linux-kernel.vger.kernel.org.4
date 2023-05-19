Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0927097FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjESNJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESNJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:09:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158CE119
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:09:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4effb818c37so3709407e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684501747; x=1687093747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Zv1mah4N/HaBlq32OJrOUOQJENrx2Ay1ik5IJM6AVI=;
        b=E1COi7fX2rR/FXALr7SUoo8vmNVfuubFb6T0kKFyjEycRTKBAFRDmAdnqRsiv96QI+
         YuksjYw1TCI8YD7OL1HQrzgBRoCAIAFokNHTHkDVC1hU3qngsBeDaYnHcwPs5B3kG3Es
         u00S6fMxCjT7Mb78GlmwZedLK69dZlMIFKBL02M+7Q+i2qcCqg0QAnEjTlwu+jqP61+t
         XdH1jZt1ZsHLr3eQuYX9Uk+sJk8rDuB0PHuNDxu1ssWyB4KCdzOdVXgajCPByvWxCIDq
         eFyq3BBwUZrDO/qwGY7btyI+X5TzriO5HGMlo/fA56RtJOJp3ByAog9e5a2LPgxKgf2g
         5u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501747; x=1687093747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Zv1mah4N/HaBlq32OJrOUOQJENrx2Ay1ik5IJM6AVI=;
        b=RTlaiYr1pfhLXmzEMRzXNfbeoUnvVrp4/jxCZF8Y2zGa0ewk2Co8PgS4z2PXJKUlEj
         C2f4hG493Zc56M3x2xCFB5M8zPeVH1rkaUo/dJZE/xlaXcIbX0LTvp2fBAJFasIcR3gt
         ZC2CXJP33jAxN53XRAY+ScBSsWoVdRIci69kUGzIckeM1q/o0R0cBPiCLslKohw2Peai
         lyjM0cgifYe0J1/ZLjgGebF/f4utyGX1A0P138xX4v1dVNZ7a0oyeDbc0/oNilsPPsLE
         8+uGlMf51B/ayNil6Z5HAKgEJ8gbMe2d4lYqeE8E6OXUmVDkXuiA0LFjTgt0uYcLJiIw
         Hx0Q==
X-Gm-Message-State: AC+VfDyPZ6W7sHBfhlyKGkJL7NwUN6IwJ3IhRSSqg0UEu4P3gDPdHaaH
        kpyQ80z/zkn4i7D0RNVd5ARZSQ==
X-Google-Smtp-Source: ACHHUZ7c/wlNtcqnvOYUHVFfllflTtq4Bc0T77kg8q0qZWMwJo/oVsLcE8qIc4ULCRXWHIkvU13COQ==
X-Received: by 2002:ac2:5a4d:0:b0:4ed:cb37:7d8c with SMTP id r13-20020ac25a4d000000b004edcb377d8cmr716553lfn.67.1684501747257;
        Fri, 19 May 2023 06:09:07 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id q30-20020ac25a1e000000b004edc7f6ee44sm278767lfn.234.2023.05.19.06.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 06:09:06 -0700 (PDT)
Message-ID: <4a9248c0-96ec-1986-d874-1cb7d8aac0ac@linaro.org>
Date:   Fri, 19 May 2023 15:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] clk: qcom: clk-alpha-pll: Add support for lucid ole
 pll ops
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230509161218.11979-1-quic_jkona@quicinc.com>
 <20230509161218.11979-2-quic_jkona@quicinc.com>
 <019999fd-3c86-8c85-76c7-8d0206e60f4d@linaro.org>
 <55fc32df-f01b-1ba3-3813-26a5f8c7f730@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <55fc32df-f01b-1ba3-3813-26a5f8c7f730@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 14:49, Jagadeesh Kona wrote:
> Hi,
> 
> Thanks Konrad for your review!
> 
> On 5/10/2023 1:36 AM, Konrad Dybcio wrote:
>>
>>
>> On 9.05.2023 18:12, Jagadeesh Kona wrote:
>>> From: Taniya Das <quic_tdas@quicinc.com>
>>>
>>> Add support for lucid ole pll ops to configure and control the
>>> lucid ole pll. The lucid ole pll has an additional test control
>>> register which is required to be programmed, add support to
>>> program the same.
>>>
>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>> ---
>> Isn't this commit "write to PLL_TEST_CTL_U2 on LUCID_EVO" instead?
>>
>> Meaninglessly duplicating ops does not seem useful.
>>
>> Konrad
> 
> Though we are reusing same ops for EVO and OLE, PLL_TEST_CTL_U2 register programming is applicable only to OLE PLL type.
Well, your patch makes it unconditional (modulo programmer error) so
I think that makes little sense.. A comment would be enough, imo.

Konrad
And PLL type is useful to properly refer respective hardware datasheets. Hence added separate ops for OLE PLL type.
> 
> 
>>>   drivers/clk/qcom/clk-alpha-pll.c | 2 ++
>>>   drivers/clk/qcom/clk-alpha-pll.h | 4 ++++
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
>>> index b9f6535a7ba7..f81c7c561352 100644
>>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>>> @@ -55,6 +55,7 @@
>>>   #define PLL_TEST_CTL(p)        ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL])
>>>   #define PLL_TEST_CTL_U(p)    ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U])
>>>   #define PLL_TEST_CTL_U1(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U1])
>>> +#define PLL_TEST_CTL_U2(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U2])
>>>   #define PLL_STATUS(p)        ((p)->offset + (p)->regs[PLL_OFF_STATUS])
>>>   #define PLL_OPMODE(p)        ((p)->offset + (p)->regs[PLL_OFF_OPMODE])
>>>   #define PLL_FRAC(p)        ((p)->offset + (p)->regs[PLL_OFF_FRAC])
>>> @@ -2096,6 +2097,7 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
>>>       clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
>>>       clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
>>>       clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
>>> +    clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U2(pll), config->test_ctl_hi2_val);
>>>         /* Disable PLL output */
>>>       regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
>>> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
>>> index d07b17186b90..4d9b6d5b7062 100644
>>> --- a/drivers/clk/qcom/clk-alpha-pll.h
>>> +++ b/drivers/clk/qcom/clk-alpha-pll.h
>>> @@ -125,6 +125,7 @@ struct alpha_pll_config {
>>>       u32 test_ctl_val;
>>>       u32 test_ctl_hi_val;
>>>       u32 test_ctl_hi1_val;
>>> +    u32 test_ctl_hi2_val;
>>>       u32 main_output_mask;
>>>       u32 aux_output_mask;
>>>       u32 aux2_output_mask;
>>> @@ -171,6 +172,7 @@ extern const struct clk_ops clk_alpha_pll_zonda_ops;
>>>   #define clk_alpha_pll_postdiv_zonda_ops clk_alpha_pll_postdiv_fabia_ops
>>>     extern const struct clk_ops clk_alpha_pll_lucid_evo_ops;
>>> +#define clk_alpha_pll_lucid_ole_ops clk_alpha_pll_lucid_evo_ops
>>>   extern const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops;
>>>   #define clk_alpha_pll_reset_lucid_ole_ops clk_alpha_pll_reset_lucid_evo_ops
>>>   extern const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops;
>>> @@ -196,6 +198,8 @@ void clk_zonda_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>>                    const struct alpha_pll_config *config);
>>>   void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>>                    const struct alpha_pll_config *config);
>>> +#define clk_lucid_ole_pll_configure(pll, regmap, config) \
>>> +            clk_lucid_evo_pll_configure(pll, regmap, config)
>>>   void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>>                     const struct alpha_pll_config *config);
>>>   void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
> 
> Thanks & Regards,
> Jagadeesh
