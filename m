Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C297B70628F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjEQIP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEQIPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:15:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080763AAA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:15:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965e93f915aso77609166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684311317; x=1686903317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEe5FsJ/vwnENYwLAm7Rnaraj/b22HuPaXqzWSqjWEc=;
        b=AldKz2t3x6SeZni7O0UeJvok2PBlQ75nnUFErAixCYwRxGPOgLgYJdNycoXO6okk0M
         kHWwmYkjJug7tSPeX3f7R0Vf7Pg6sTGr5i4jNIzLSpJOKbuPAirUjIA01XpyRydk7DzY
         54wLBQOd6a+bFFwKCY+/wlX/YttddYELPmqznUui/qZjJfCvD+KC4UFvh9+ecT1alRoZ
         XbzP3iUIZcLJ2XzGQ7dDBE1axXjfEQvHhESnOtm/LXLy4NVa+txhT7mIc4fQ3Ej+ScHJ
         xlnP24D9EakmKBRsccuqlETmXs7pjU1ZRHmpna+7v/PtdTGwWfZf2XVV8fn9iz2UWIDl
         WeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684311317; x=1686903317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEe5FsJ/vwnENYwLAm7Rnaraj/b22HuPaXqzWSqjWEc=;
        b=E841B38DawJ2B48udMYy5BCIufTaZh1swcEfRNuUoqGIuhCe9y+67rXkfqVY9/SslZ
         YrW+JQUOpZ92hWV5V7878J0C+kTZdaiIHmEdX8v1jB7/dH8A1JJ5zuHn0MS0EH2X1Uie
         9U9jm59U+wAUSYVGRP60+6dirCoP4GdOrv8qzcoboYpDx85vxRsvqjdo/tEYQldOZ6N+
         2q8cWroJBUK8+D815ic4Z+jy+8qAAjbYhoA7exjQCMPoJ3sbdw4f6/MRkhgZt821IHw/
         s4dvQR8P43SCTla+00L6q/OpQT7ELDQQ7s5UcA/rfAtTowPEoxRQ49DOPDhv0+5Q9Uvy
         jLsQ==
X-Gm-Message-State: AC+VfDxQi7unO/wzTAIfPgP+fZcg7dgZCZTWHrEl+D9P3snithArReyz
        cULNM98Lnpwf7oNMN08KBM3tnA==
X-Google-Smtp-Source: ACHHUZ6gRO9CPqhoqv2ttZfqInxP1k1DHikZHSV6X47AFfVd7gqcPWGHfGjXXhM4cr/lhIS+cnO1Kw==
X-Received: by 2002:a17:907:9285:b0:966:484a:3350 with SMTP id bw5-20020a170907928500b00966484a3350mr28458711ejc.35.1684311317473;
        Wed, 17 May 2023 01:15:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090674cd00b0096ae152115bsm6040064ejl.175.2023.05.17.01.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:15:16 -0700 (PDT)
Message-ID: <af3164f1-314f-7e05-738b-808b2ea899c9@linaro.org>
Date:   Wed, 17 May 2023 10:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add PCIe0
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230516133011.108093-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJpoTgseo3j_5Ab7cQs3ZZZymALpRqpuWGPyKpTEbXR-Cqw@mail.gmail.com>
 <2e6f282c-33d9-7f96-0338-c4fd457d04fa@linaro.org>
 <CAA8EJpq0x=H_SirdOwwhuiU7b1GPhP6-3xgR9PTQ_b2HYinMzQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpq0x=H_SirdOwwhuiU7b1GPhP6-3xgR9PTQ_b2HYinMzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 19:15, Dmitry Baryshkov wrote:
> On Tue, 16 May 2023 at 19:43, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/05/2023 18:39, Dmitry Baryshkov wrote:
>>> On Tue, 16 May 2023 at 16:30, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> Add PCIe0 nodes used with WCN7851 device.  The PCIe1 is not connected,
>>>> thus skip pcie_1_phy_aux_clk input clock to GCC.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 32 +++++++++++++++++++++++++
>>>>  1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>>>> index ccc58e6b45bd..e7a2bc5d788b 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>>>> @@ -385,6 +385,38 @@ vreg_l3g_1p2: ldo3 {
>>>>         };
>>>>  };
>>>>
>>>> +&gcc {
>>>> +       clocks = <&bi_tcxo_div2>, <&sleep_clk>,
>>>> +                <&pcie0_phy>,
>>>> +                <&pcie1_phy>,
>>>> +                <0>,
>>>> +                <&ufs_mem_phy 0>,
>>>> +                <&ufs_mem_phy 1>,
>>>> +                <&ufs_mem_phy 2>,
>>>> +                <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>>>> +};
>>>
>>> Is there any reason to disable the PCIe1 PHY AUX clock here? I mean,
>>> the PCIe1 is still enabled in the hardware.
>>
>> I was thinking about this. The AUX clock seems to be an external clock,
>> although I could not find it in schematics. I assume that on QRD8550 it
>> could be missing, if it is really external. OTOH, downstream DTS did not
>> seem to care...
> 
> I might be completely wrong here, but I think that AUX clock is yet
> another clock provided by the PHY to the GCC, which we were just
> ignoring for now. For example, for sm8450 we have <0> there. I don't
> see it as an external clock, so I think it is internal to the SoC.

Hm, in that case it would make sense to keep it here. It's frequency,
with some safe choice, could also go to DTSI.

Best regards,
Krzysztof

