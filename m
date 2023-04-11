Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5C6DD959
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDKL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDKL1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:27:22 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399BE35AB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:27:21 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x31so4087181ljq.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681212439;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mO52s6mKQHmY0l0OyHS8ECqMNi9aQa6bkpfbk2zZBzI=;
        b=j7Pt8ae8gKTdfQX0/1NJQfb8hKrdEeyPzRerwfez1/I2fK3jK3W4BNfQa4Q6a42vmV
         7qI0iuY9Q+0fHNXNKNhWFofsiXJdG6mz8/6O80H4DDuW3/RIuDwz1ybPAr2Lucq2allR
         ZSVPxjhXxYZnja3uqyCyLC/W6qaBmmyfiNgW3tilT7PKr2rVN+VW0Ak+0NQHW2rU8rwh
         zgVSr9G+cXHy7dEwRVcDIlykcNEm3CcJfcQ59RcOyKheecqppez+jtOnZuypa14/8vjx
         IFKlh1y5ul2PXkIIZGXW+66Vj5UEH7Y4lIL7jjf9+5HHg4YeUKbzDgjI66eVBmczKMC4
         malQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681212439;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mO52s6mKQHmY0l0OyHS8ECqMNi9aQa6bkpfbk2zZBzI=;
        b=f4WA1Jxwejggsn+daeEwY+netWEgsD9N4D+qir95xNPMNJJ9fM1kCoTOElORACfuSW
         v60uvbQYmqw7ZRUI6UifHtcNnsei7C1mbN3MvSkfppGH5lsMVstLCa4vkgIgE4DVwgaB
         3+3suCTs5jPNAXAB61f5ej8IBYIJ8bLZNprdzcDGc3XBj1SX+EwWVSHBeENkM+d1q+d5
         7n0jrI+p/XGJZ199Qn4w4l1mxp81RIbVcr1lP4rijcBTKStXMsc33cqJJkRDnkPl543N
         5g6f99X9Auc7bSzmJ9Hwh4c/cfQ2c+TNWixT6jexs3ykeoRUa9mLXW6E8zHKQF9Shsqg
         x4pg==
X-Gm-Message-State: AAQBX9eJ76nfa2u/5MpD3kXGFibDH3OnbnD409EPrw46RyH5SXFN9sx9
        chw6Ht/MTJPR03zp31o0adCEsA==
X-Google-Smtp-Source: AKy350aejn/8Hcjtk66/DqgIybyC1DZcxyDNOI/nSDQVYWI3mRsceJbmbDV+4ggUY4QIULbx1kPfsA==
X-Received: by 2002:a2e:6a06:0:b0:293:4e6d:9194 with SMTP id f6-20020a2e6a06000000b002934e6d9194mr2813065ljc.24.1681212439462;
        Tue, 11 Apr 2023 04:27:19 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id i15-20020a2e940f000000b002a615c75bf2sm2751558ljh.6.2023.04.11.04.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 04:27:19 -0700 (PDT)
Message-ID: <c70c1a4d-50c5-2b50-18c9-7c46c3803cd4@linaro.org>
Date:   Tue, 11 Apr 2023 13:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/3] dt-bindings: clock: qcom,gcc-sc7180: document CX
 power domain
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
 <20230408134820.76050-2-krzysztof.kozlowski@linaro.org>
 <4757c33c-7e71-262d-a51a-c5f9fb53ff41@linaro.org>
 <d4a8054c-443e-d9ba-9641-ff721254d254@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d4a8054c-443e-d9ba-9641-ff721254d254@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.04.2023 06:56, Rajendra Nayak wrote:
> 
> 
> On 4/8/2023 7:33 PM, Konrad Dybcio wrote:
>>
>>
>> On 8.04.2023 15:48, Krzysztof Kozlowski wrote:
>>> The GCC clock controller needs CX power domain, at least according to
>>> DTS:
>>>
>>>    sc7180-trogdor-pompom-r3.dtb: clock-controller@100000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>> +CC Rajendra (author of 5d6fc6321db1 ("arm64: dts: qcom:
>> sc7180: Add required-opps for USB"))
>>
>> Rajendra, shouldn't SC7180 GCC have PM ops to make sure a vote
>> is only there when AP is active?
So IIUC, CX is never supposed to be shut down?

Konrad
> 
> hmm, I am not quite sure why we would want the performance votes
> from peripherals dropped when CPUs go down in idle?
> 
>> Are all GDSCs powered by CX?
>> If not, wouldn't this also need power-domain-names to
>> facilitate e.g. potential MX-powered ones?
> 
> For sc7180 GCC, yes.
> 
>>
>> Konrad
>>>   .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml         | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
>>> index 06dce0c6b7d0..8bf9b6f49550 100644
>>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
>>> @@ -32,6 +32,10 @@ properties:
>>>         - const: bi_tcxo_ao
>>>         - const: sleep_clk
>>>   +  power-domains:
>>> +    items:
>>> +      - description: CX domain
>>> +
>>>   required:
>>>     - compatible
>>>     - clocks
>>> @@ -45,6 +49,8 @@ unevaluatedProperties: false
>>>   examples:
>>>     - |
>>>       #include <dt-bindings/clock/qcom,rpmh.h>
>>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>>> +
>>>       clock-controller@100000 {
>>>         compatible = "qcom,gcc-sc7180";
>>>         reg = <0x00100000 0x1f0000>;
>>> @@ -52,6 +58,7 @@ examples:
>>>                  <&rpmhcc RPMH_CXO_CLK_A>,
>>>                  <&sleep_clk>;
>>>         clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
>>> +      power-domains = <&rpmhpd SC7180_CX>;
>>>         #clock-cells = <1>;
>>>         #reset-cells = <1>;
>>>         #power-domain-cells = <1>;
