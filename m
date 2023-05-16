Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037AE7042E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEPB0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEPB02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:26:28 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC542269F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:26:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ac836f4447so138174611fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684200384; x=1686792384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCXuzrQVE7NqQDfgmpBc13d69ZLB2zjvkbjuCp0orcg=;
        b=fo7JEKjFInLMQlPsQc9w3oWP9T2Aj3MwuPxcvyHykOb2kVt4FarGuSfCQP4XU4Xnn5
         x5GH+EB4iUanMe7Bfr7LNvrgKn3WpFmIzLB0BdD7ArHp+OQKi244DylCU+iCmzRRyOvB
         YUaC+Sve3s2lOHw85mHDkjdteeYJfIA3SYA2Vumbsg5KhYoXmqTEoDE8CuRZ6xsS54WD
         s+v/0xEmG/HaXwivV50aKTUSU83U9wFHWwmdPQ1FEwYgtrlzAaWGeKImVizgwaxfRdDG
         qEuPlIASiqDQquTEvvyuZneyvqtcnEODZ6i+p2UFNPdAMbXlyJxkzsz70wwLnYvfKwrz
         IhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200384; x=1686792384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCXuzrQVE7NqQDfgmpBc13d69ZLB2zjvkbjuCp0orcg=;
        b=UWD0Sm1d2yeK0uJmJGv4jYVM5mtcBuKv5bjKasi00IDZxl1PKQCfIbQ3lSWPN+I9Ra
         mH6xtmWiVsXj7JCJF1z8+cB3mL1IHVi5j4G7PjQH34/owvOpEVpaPblx1LFVtII14kyk
         VI+AUxJ3ozXSCvfAQJvJsE2OF0mNyRFkxJp2iXhq7sedOhRLvpsudeiEegoX4wh2SD9/
         nGvN5mGCd/FP26OAHaxZU4WRuKj0AZsYH7qVCxfg+HKYErTq2rIsManep8Fdi7Knn9ee
         s4exPECulhlQhSl06MQgfQo8PXbaBQMIrCte9HGh3j60L664fbwarbgxZn8xgCtGR8oH
         VxMg==
X-Gm-Message-State: AC+VfDzbyQKgztBZX/ymqJ/b0wqUl3JJdm/eIUBJ8lCoErQejRQAmz5v
        Hilf+61kDaSZfj9p4BdtghJrUA==
X-Google-Smtp-Source: ACHHUZ4v2kFHkHVE+gkX96V7S+QQVZsWTNBB9cJxYxR5LY8juK88Lz0HRrauXlwj+MM81B5kOulXgw==
X-Received: by 2002:a2e:2c09:0:b0:2ad:bb53:8b9a with SMTP id s9-20020a2e2c09000000b002adbb538b9amr6041019ljs.20.1684200384228;
        Mon, 15 May 2023 18:26:24 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id h4-20020a2e3a04000000b002adbe01cd69sm1912340lja.9.2023.05.15.18.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:26:23 -0700 (PDT)
Message-ID: <1801db13-aeb7-ba50-6939-d194a9029f18@linaro.org>
Date:   Tue, 16 May 2023 03:26:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
 <20230411-topic-straitlagoon_mdss-v3-5-9837d6b3516d@linaro.org>
 <4a563d96-ec59-7db3-d288-1ba3bb9d8eb7@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4a563d96-ec59-7db3-d288-1ba3bb9d8eb7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.05.2023 10:20, Krzysztof Kozlowski wrote:
> On 05/05/2023 23:40, Konrad Dybcio wrote:
>> Document the SM6375 MDSS.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
>>  1 file changed, 216 insertions(+)
>>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,rpmcc.h>
>> +    #include <dt-bindings/clock/qcom,sm6375-gcc.h>
>> +    #include <dt-bindings/clock/qcom,sm6375-dispcc.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>> +
>> +    display-subsystem@5e00000 {
>> +        compatible = "qcom,sm6375-mdss";
>> +        reg = <0x05e00000 0x1000>;
>> +        reg-names = "mdss";
>> +
>> +        power-domains = <&dispcc MDSS_GDSC>;
>> +
>> +        clocks = <&gcc GCC_DISP_AHB_CLK>,
>> +                 <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
>> +        clock-names = "iface", "ahb", "core";
>> +
>> +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <1>;
>> +
>> +        iommus = <&apps_smmu 0x820 0x2>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges;
>> +
>> +        display-controller@5e01000 {
>> +            compatible = "qcom,sm6375-dpu";
>> +            reg = <0x05e01000 0x8e030>,
>> +                  <0x05eb0000 0x2008>;
>> +            reg-names = "mdp", "vbif";
>> +
>> +            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +                     <&gcc GCC_DISP_HF_AXI_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_ROT_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
>> +                     <&gcc GCC_DISP_THROTTLE_CORE_CLK>;
>> +            clock-names = "iface",
>> +                          "bus",
>> +                          "core",
>> +                          "lut",
>> +                          "rot",
>> +                          "vsync",
>> +                          "throttle";
> 
> Are you sure you have clocks in correct order? I see warnings...
Right, testing *both* the DTs and bindings after making changes sounds
like a good thing to stop forgetting..

Konrad
> 
> Best regards,
> Krzysztof
> 
