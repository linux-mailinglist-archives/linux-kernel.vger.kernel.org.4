Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3376ABEBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCFLwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:51:59 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0C428235
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:51:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ec29so6508200edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678103515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSAV2m6KPnFi6yjsalmahzmYCHOYaQ3prrwvNZxIwUk=;
        b=lSPY5dswBAhuVTG7FDrB7pDSL8QXUWReKgCO5HiLMYm/YEJ/Y7XrsV7R2P6J57XtAE
         3vS/tWEzT9qVwbWbjqDOq9HF1xxtjC/bE1Wl1wwAlOiAcHr+q7d7S/oVid6pxGjZLYz8
         CJyPL9sjKZrI8zYMOmyV+Bo5/VmQZbxfRCk4DP1HySHRsKbnnlOJrETeiVBGAar/Vxj6
         a/PXcfbKU+9yn0a+XrZG2FmMUdJ17stvk+cbrCsMEXNVsVktotWMtxIMKKXJc8EnxFtO
         W8nlURVuJOTe275dv0AVvqIwsroqkKUpFG0AvalViKQ8rdSzOnij7JXswuJgdiZc7Pb6
         vxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678103515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSAV2m6KPnFi6yjsalmahzmYCHOYaQ3prrwvNZxIwUk=;
        b=RI+r5r8pXir3piISQ38bNIlRIJBUwSoAY23+A4BRTi2xTBv/HIQpv3DcBEfrMrwlpY
         boVpkKhrs59EkM/avQ6LLAel/aMbMIW9g9Qw8iybpRgmgeN4xqfKajFDFKO6QFVurmgj
         VoxM2TmhCS/ncUXhaeo64BAwxMmS3WcCrEAMJekKuRnRlm4aI/be4i3Uus6EOUkuOfAq
         QZJWnPYlIdEfkhADlj9DE7Zh5wDIK62Aq5YPoQqfphQkijNRydg/A/xwUWpl/JQ7bviW
         +U1eAYBLx0KpuL9pl6OR0mEXkHE3sI38sakSqkZt/Su6Bu08+y4x4kW7VT3fUDzcgloK
         uivQ==
X-Gm-Message-State: AO0yUKWDnbjH1Lv6wl5BHEX/M4cvOj2D3jd8NlWye3wh1qvZYNjvi6Zy
        cUFoNaaj7mH3uhZEMMGn/GCJlA==
X-Google-Smtp-Source: AK7set/vC98WymMaTZojQxVThW3BMzKq0AfTssygkCIDMIaOQFrL22hYj+heOJimoqFt0Z71CfI6sw==
X-Received: by 2002:a17:907:3da7:b0:8de:baf0:338c with SMTP id he39-20020a1709073da700b008debaf0338cmr11663314ejc.14.1678103515621;
        Mon, 06 Mar 2023 03:51:55 -0800 (PST)
Received: from [10.203.3.194] ([185.202.34.81])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906a21000b008cafeec917dsm4469267ejy.101.2023.03.06.03.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 03:51:55 -0800 (PST)
Message-ID: <83184da4-b183-3271-983f-3a1a62fb9f1a@linaro.org>
Date:   Mon, 6 Mar 2023 13:51:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Content-Language: en-GB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
 <CAA8EJprbMybV0o1-436yLhVnnEX6qywrj=JmWDCL5usaH0DXiQ@mail.gmail.com>
 <61e8c730-e46d-728d-d770-f1ead4405d12@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <61e8c730-e46d-728d-d770-f1ead4405d12@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 13:26, Varadarajan Narayanan wrote:
> Dmitry,
> 
> On 3/2/2023 9:52 PM, Dmitry Baryshkov wrote:
>> On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
>> <quic_varada@quicinc.com> wrote:
>>> Add USB phy and controller related nodes
>>>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 92 
>>> +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 92 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi 
>>> b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> index 2bb4053..319b5bd 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi

[skipped]


>>> +               usb3: usb3@8A00000 {
>> You know the drill. This node is in the wrong place.
>>
>>> +                       compatible = "qcom,dwc3";
>>> +                       reg = <0x8AF8800 0x400>;
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <1>;
>>> +                       ranges;
>>> +
>>> +                       clocks = <&gcc GCC_SNOC_USB_CLK>,
>>> +                               <&gcc GCC_ANOC_USB_AXI_CLK>,
>>> +                               <&gcc GCC_USB0_MASTER_CLK>,
>>> +                               <&gcc GCC_USB0_SLEEP_CLK>,
>>> +                               <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>>> +
>>> +                       clock-names = "sys_noc_axi",
>>> +                               "anoc_axi",
>>> +                               "master",
>>> +                               "sleep",
>>> +                               "mock_utmi";
>> Please fix the indentation of the lists.
>>
>>> +
>>> +                       assigned-clocks = <&gcc GCC_SNOC_USB_CLK>,
>>> +                                         <&gcc GCC_ANOC_USB_AXI_CLK>,
>> Why do you assign clock rates to the NOC clocks? Should they be set
>> using the interconnect instead?
> 
> The SNOC and ANOC run at a fixed speed of 350MHz and 342MHz respectively 
> and are not scaled. These clocks are for the interface between the USB 
> block and the SNOC/ANOC. Do we still need to use interconnect?

Maybe I misunderstand something here. If the snoc and anoc speeds are at 
350 MHz and 342 MHz, why do you assign clock-rates of 200 MHz?

Is it enough to call clk_prepare_enable() for these clocks or the rate 
really needs to be set?


> 
>>> +                                         <&gcc GCC_USB0_MASTER_CLK>,
>>> +                                         <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>>> +                       assigned-clock-rates = <200000000>,
>>> +                                              <200000000>,
>>> +                                              <200000000>,
>>> +                                              <24000000>;
>>> +
>>> +                       resets = <&gcc GCC_USB_BCR>;
>>> +                       status = "disabled";
>>> +
>>> +                       dwc_0: dwc3@8A00000 {
>>> +                               compatible = "snps,dwc3";
>>> +                               reg = <0x8A00000 0xcd00>;
>>> +                               clock-names = "ref";
>>> +                               clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>> clocks before clock-names
>>
>>> +                               interrupts = <GIC_SPI 140 
>>> IRQ_TYPE_LEVEL_HIGH>;
>>> +                               phys = <&qusb_phy_0>, <&usb0_ssphy>;
>>> +                               phy-names = "usb2-phy", "usb3-phy";
>>> +                               tx-fifo-resize;
>>> +                               snps,dis_ep_cache_eviction;
>>> +                               snps,is-utmi-l1-suspend;
>>> +                               snps,hird-threshold = /bits/ 8 <0x0>;
>>> +                               snps,dis_u2_susphy_quirk;
>>> +                               snps,dis_u3_susphy_quirk;
>>> +                               snps,quirk-frame-length-adjustment = 
>>> <0x0A87F0A0>;
>>> +                               dr_mode = "host";
>>> +                       };
>>> +               };
>>> +
>>>                  pcie0_phy: phy@84000 {
>>>                          compatible = 
>>> "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>>>                          reg = <0x00084000 0x1bc>; /* Serdes PLL */
>>> -- 
>>> 2.7.4
> 
> Will address these and post a new revision.
> 
> Thanks
> 
> Varada
> 

-- 
With best wishes
Dmitry

