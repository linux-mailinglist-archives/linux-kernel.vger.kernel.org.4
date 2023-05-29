Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A41714962
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjE2MWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjE2MWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:22:46 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65581DE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:22:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af316b4515so32314831fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685362960; x=1687954960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKA7/hMqgo/H6bsA9YWjEB8LXPpVeFefHtEv+Ra/8S4=;
        b=R27sLwYuiCRCMjqMGuKtvYkajRc9K6BF7541pRI1LprNUjwVpsUbwcL5nrqoArXUpH
         rca4GzEKl/v2ML1orSY+R5aGxOkr5nWrJZ+tQUWOMIKgNruzbI5ntc67pQsun6iOwvZL
         JqZKvc9UQoNhSObJ4W1FfTy8Yr4Kj2XUFXQ4dTP19meD7l77J6N1aZs/K/3TJg41gW3R
         9wxc6MUO9HjZJ8dOepjLTijzOs3mdbsUssWGrc+ute04IZRyc2MItRRSv7L2WeoiOCMi
         IuSfNVTEZB494tvEtc9U5eay1SCHTZcrvDtAoIeZmte3ww9KfXjxLm5i7LX5Rljg8jgf
         qveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685362960; x=1687954960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKA7/hMqgo/H6bsA9YWjEB8LXPpVeFefHtEv+Ra/8S4=;
        b=Sy4WwdaGrF+jtLqSoikyFUsuuYIV6rpp1wqn4Krr7mbUWkkhi1Nti7GP0fyDillK94
         uYxW38qcSWU9RP5gkRNjFcZli2nJVI67GMKjvjqmI+cXNmawzo/+zOi5JpHmOG2OmiR0
         /C6ATwgpxztS9tUD0q8g9qSQR7DJRgJxW26/io5GtiK/jeIVZ1E6+7CKSa8Qk322zU5f
         rHP8w0RrUCuYuhGHt6ghDt0+JbsBBMGWEocHFSdon7YuX4L4FwIhTph6kLI/MP/qmjWb
         poHaCXSgOZUtumeCUaW1+vZTVaNciCu01U3v6GjM1LhafH7vxDzdKjs469x6gRQybf2O
         8v2Q==
X-Gm-Message-State: AC+VfDy8M/HBQ/D46SM1CmVF1n5huGS+R6iWl2syFAdbVdD77rk4Z30h
        jwTiyM/j2BywcknbYiDBf65k9w==
X-Google-Smtp-Source: ACHHUZ5JcAkkevtvFEwgxbEKu/NiJIB1tIffr4Xka3MEQnnoSH+uJnyR56/szW/OTdR2f5nyn5vK6Q==
X-Received: by 2002:a2e:9796:0:b0:29c:921c:4eb0 with SMTP id y22-20020a2e9796000000b0029c921c4eb0mr4737453lji.22.1685362960650;
        Mon, 29 May 2023 05:22:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id y28-20020a05651c021c00b002adf8d948dasm2412411ljn.35.2023.05.29.05.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 05:22:40 -0700 (PDT)
Message-ID: <16ab0b91-1f8b-94ff-6fa6-1d879abc18e4@linaro.org>
Date:   Mon, 29 May 2023 14:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 7/7] ARM: dts: qcom: msm8226: Add mdss nodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
 <20230308-msm8226-mdp-v1-7-679f335d3d5b@z3ntu.xyz>
 <6c79b99e-cc69-8cd9-c990-5c0373e1f09c@linaro.org>
 <58e7e5ff-5e40-7871-efe2-bfe88bd19dad@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <58e7e5ff-5e40-7871-efe2-bfe88bd19dad@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 29.05.2023 14:19, Dmitry Baryshkov wrote:
> On 29/05/2023 15:10, Konrad Dybcio wrote:
>>
>>
>> On 29.05.2023 11:44, Luca Weiss wrote:
>>> Add the nodes that describe the mdss so that display can work on
>>> MSM8226.
>>>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>>   arch/arm/boot/dts/qcom-msm8226.dtsi | 118 ++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 118 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
>>> index 42acb9ddb8cc..182d6405032f 100644
>>> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
>>> @@ -636,6 +636,124 @@ smd-edge {
>>>                   label = "lpass";
>>>               };
>>>           };
>>> +
>>> +        mdss: display-subsystem@fd900000 {
>>> +            compatible = "qcom,mdss";
>>> +            reg = <0xfd900000 0x100>, <0xfd924000 0x1000>;
>>> +            reg-names = "mdss_phys", "vbif_phys";
>>> +
>>> +            power-domains = <&mmcc MDSS_GDSC>;
>>> +
>>> +            clocks = <&mmcc MDSS_AHB_CLK>,
>>> +                 <&mmcc MDSS_AXI_CLK>,
>>> +                 <&mmcc MDSS_VSYNC_CLK>;
>>> +            clock-names = "iface", "bus", "vsync";
>> One per line, please
>>
>>> +
>>> +            interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +            interrupt-controller;
>>> +            #interrupt-cells = <1>;
>> We're not using the irq cell, is that necessary/should that be 0?
> 
> No. With 0 it would mean that there is a single interrupt for mdss source, which clearly is not the case.
Obviously. Derp, sorry.

Konrad
> 
>>
>>> +
>>> +            status = "disabled";
>> status should go last
>>
>>> +
>>> +            #address-cells = <1>;
>>> +            #size-cells = <1>;
>>> +            ranges;
>>> +
>>> +            mdp: display-controller@fd900000 {
>>> +                compatible = "qcom,msm8226-mdp5", "qcom,mdp5";
>>> +                reg = <0xfd900100 0x22000>;
>>> +                reg-names = "mdp_phys";
>>> +
>>> +                interrupt-parent = <&mdss>;
>>> +                interrupts = <0>;
>>> +
>>> +                clocks = <&mmcc MDSS_AHB_CLK>,
>>> +                     <&mmcc MDSS_AXI_CLK>,
>>> +                     <&mmcc MDSS_MDP_CLK>,
>>> +                     <&mmcc MDSS_VSYNC_CLK>;
>>> +                clock-names = "iface", "bus", "core", "vsync";
>> One per line, please
>>
>>> +
>>> +                ports {
>>> +                    #address-cells = <1>;
>>> +                    #size-cells = <0>;
>> Would port { work here? I remember one mdss component's bindings
>> didn't allow it but don't recall which one
> 
> Let's use ports /port@0 for uniformity even if there is just a single port always.
> 
>>
>>> +
>>> +                    port@0 {
>>> +                        reg = <0>;
>>> +                        mdp5_intf1_out: endpoint {
>>> +                            remote-endpoint = <&dsi0_in>;
>>> +                        };
>>> +                    };
>>> +                };
>>> +            };
>>> +-- 
> With best wishes
> Dmitry
> 
