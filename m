Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985A8742DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjF2Txe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjF2Txa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:53:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC21FC0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:53:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so1338627e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688068407; x=1690660407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pBbaluuyzwVXP1sHmiMWy/GcrSJJh0VQlK5YIkf6P0=;
        b=edlVolaaYSWq+gCodM88LdgZ4bBSQjITOlBT06sdJFFBKOONKbSncjMaF8s29wapuZ
         xoDUSGdULdCvp20rQCZwzxTBDsG6wVNxGsiAS2PkdRP6dZDjyNVk+0Q/9vCM1yly3VPK
         ESCVLcOqp2KI7Gnl1tmpwKrxG3gUWO/KLmggO+nhdVnbXNh+X9nOVfDwc/C9a5pMJcEz
         e3YTyQxg570Ov6g4ZPwM9FW4o33BAWcV99xTboRQl7WJmZl9cKckH24H+RDj6b6F5nrv
         kBXah+OGDyawAGKb9ol5gZDn+5Ph3G0ai61YWnM1AP+hqa7tRQcp1gYUWWD0C2jrCDIH
         16Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068407; x=1690660407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pBbaluuyzwVXP1sHmiMWy/GcrSJJh0VQlK5YIkf6P0=;
        b=beu6PdLgpIUUU35fy/7kVhoby5oBN5980ZwlbczSe6q+VcYkhx37uxTniACxzBHsu6
         g6rS6ccLuXCQLI9iiTBHOPVeuxEpSB91QbsWMnpCZB7e1HNMqnBz1DwcjVP1PSTrqLf9
         vhDrD4UrNvB+QKTK/Ixu230rYQgBosUJaU8gXArCO1SAdQ82URK/PPKnQFvYd8nEyrxv
         sSQ3BzcSzU4p6S/I5crW873MyNxB918kwBBp+s/Amp1+WCtUzge8bT3Ik0eb9+OUlSdy
         syhT05jtPCpnj49zOytqaRhEgkPukFK54W+s7f8cL/M9BSsRMLZMnXUTm5kxg3JDwy8T
         P3NQ==
X-Gm-Message-State: ABy/qLZJ8xXxQ+xuyBqSqJ+rmC+NXjhUKM65rUcVhwDeaKpqU/UoqMxY
        EZX1mjSyEQFzpF9vFprhBrcs6Q==
X-Google-Smtp-Source: APBJJlFEtRmdUeebJYgWsqZgvE8IML5SO44xmsVeT9iQKxrK3gpe0zDMG+bTdRHWyp3TXD/N+iKJaw==
X-Received: by 2002:a05:6512:3994:b0:4f8:5dd2:21fb with SMTP id j20-20020a056512399400b004f85dd221fbmr312467lfu.8.1688068406682;
        Thu, 29 Jun 2023 12:53:26 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id n30-20020ac2491e000000b004fb82d7532dsm1219419lfi.177.2023.06.29.12.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 12:53:26 -0700 (PDT)
Message-ID: <13f29231-692e-b624-bdbd-fa1b2b3e793b@linaro.org>
Date:   Thu, 29 Jun 2023 21:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 13/15] arm64: dts: qcom: sm6125: Add dispcc node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-13-03e430a2078c@somainline.org>
 <4a267feb-5855-1427-c378-b2615eae4f84@linaro.org>
 <kisifidg4bdb4v6fb6nvgt5omsprssd4bxrn6wqehjo66l2y4a@7nfaydtafzpn>
 <CAA8EJpr+PyjehSd4SEUVfh13+i=+-7v1esQasc+7gNaL2iqWJA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpr+PyjehSd4SEUVfh13+i=+-7v1esQasc+7gNaL2iqWJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.06.2023 14:24, Dmitry Baryshkov wrote:
> On Thu, 29 Jun 2023 at 15:14, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
>>
>> On 2023-06-29 13:56:25, Dmitry Baryshkov wrote:
>>> On 27/06/2023 23:14, Marijn Suijten wrote:
>>>> Enable and configure the dispcc node on SM6125 for consumption by MDSS
>>>> later on.
>>>>
>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 25 +++++++++++++++++++++++++
>>>>   1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>>> index edb03508dba3..a5cc0d43d2d9 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>>> @@ -3,6 +3,7 @@
>>>>    * Copyright (c) 2021, Martin Botka <martin.botka@somainline.org>
>>>>    */
>>>>
>>>> +#include <dt-bindings/clock/qcom,dispcc-sm6125.h>
>>>>   #include <dt-bindings/clock/qcom,gcc-sm6125.h>
>>>>   #include <dt-bindings/clock/qcom,rpmcc.h>
>>>>   #include <dt-bindings/dma/qcom-gpi.h>
>>>> @@ -1203,6 +1204,30 @@ sram@4690000 {
>>>>                     reg = <0x04690000 0x10000>;
>>>>             };
>>>>
>>>> +           dispcc: clock-controller@5f00000 {
>>>> +                   compatible = "qcom,sm6125-dispcc";
>>>> +                   reg = <0x05f00000 0x20000>;
>>>> +                   clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>>> +                            <0>,
>>>> +                            <0>,
>>>> +                            <0>,
>>>> +                            <0>,
>>>> +                            <0>,
>>>> +                            <&gcc GCC_DISP_AHB_CLK>,
>>>> +                            <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
>>>> +                   clock-names = "bi_tcxo",
>>>> +                                 "dsi0_phy_pll_out_byteclk",
>>>> +                                 "dsi0_phy_pll_out_dsiclk",
>>>> +                                 "dsi1_phy_pll_out_dsiclk",
>>>> +                                 "dp_phy_pll_link_clk",
>>>> +                                 "dp_phy_pll_vco_div_clk",
>>>> +                                 "cfg_ahb_clk",
>>>> +                                 "gcc_disp_gpll0_div_clk_src";
>>>> +                   power-domains = <&rpmpd SM6125_VDDCX>;
>>>
>>> Would it be logical to specify the required-opps too?
>>
>> Perhaps, but barely any other SoC aside from sm8x50 sets it on dispcc.
>> What should it be, rpmhpd_opp_low_svs?  IIRC we used "svs" for the DSI
>> PHY despite not having a reference value downstream (it sets a range of
>> NOM-TURBO_NO_CPR, and RETENTION when it's off).
> 
> Then for DSI PHY the required-opps should be rpmpd_opp_nom.
Yes

> 
> For the dispcc I think the rpmpd_opp_ret, the lowest possible vote,
> should be enough.
I'm not 100% sure but not specifying an opp and turning on the domain
*******probably******* just sticks with the lowest vote

Konrad
> 
>>
>> - Marijn
>>
>>>
>>>> +                   #clock-cells = <1>;
>>>> +                   #power-domain-cells = <1>;
>>>> +           };
>>>> +
>>>>             apps_smmu: iommu@c600000 {
>>>>                     compatible = "qcom,sm6125-smmu-500", "qcom,smmu-500", "arm,mmu-500";
>>>>                     reg = <0x0c600000 0x80000>;
>>>>
>>>
>>> --
>>> With best wishes
>>> Dmitry
>>>
> 
> 
> 
