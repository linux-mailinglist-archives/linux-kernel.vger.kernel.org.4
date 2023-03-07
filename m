Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ECA6ADDFC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjCGLvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjCGLvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:51:00 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32454DBD9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:49:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bi9so16725079lfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678189781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NLnfgcJkBrupO9VeOIsatAqwiLwPWa5rkw2fb5PnaE=;
        b=UYvQ5bO2RzR51Mh38ODTgBjtWo2rd01w2DzKJ+NpS1vMuXxsIZJk1UL0Y9tvMY/erS
         WdcNtewN6BoWBvzNWdC7D5OzAVWUwrl418t7qzmoVXLW7HeQHGUJUllTxOAxPKMuos/I
         FnEFJdlTkGoepl4EBTUDhWvpEm1hlggXZgbJrM2QDGjqMvK09RAhyBe4g/zdhhWeZs19
         2H7fcl1zyhk9DpjhmRDIDtaXkwftLIFWTRPHIHuoKTmaWO3N6eMFm5Cla1kFSe7fPjxJ
         Tas0sI2JB1IcP++DNwbqE8ksYqoqgZh125kLDgfhq0VIpwRgE5vveM3yXSMv/dLCUqEN
         /+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NLnfgcJkBrupO9VeOIsatAqwiLwPWa5rkw2fb5PnaE=;
        b=rEKbLCYxtMO1sOJi0WntAu6gqlM+9+TPSiJFSFG0/lbPiCEhawAj5ReiQUM/A6yHqJ
         hKeMDdx++ZHvTUWfFGn9ikrQJmvVkCGSGM6bxxxlERe9O/cCmNGpy92PKODVz5bZC1An
         JzI3GR2NZdvejvOkjnvaq9hjWB0L2aU9u7H+mNcv5QgNDfBB/HV1uPd4FRueSPTK06pi
         wFdM72j9D0bov/oJOd4k3ZZRRaYO1OogJ/wgo/qHTvoWjI9SCZ0FiOfJX5dHca2oIubt
         5QUGFM2ah6DjYHypOl4v/TuVb+bGBxogsBs8d3GCWZBtLmWOWfKEr5fK5TSJS2COqZcj
         noDA==
X-Gm-Message-State: AO0yUKVeXAutNlf3OQ1Tv1Ru5ULUIUPKc2/m7pirTiMcE6XqIFKHPPCe
        vfGbga1lOAySArpszxKOcUSrAQ==
X-Google-Smtp-Source: AK7set820Wh82BGJ6Ihvrw7CYOrPuMDU5y9XvpQtW63tea7D4cxj+nT71DKMYqTpL9A9f0fzFll76w==
X-Received: by 2002:ac2:558e:0:b0:4dc:852d:9b88 with SMTP id v14-20020ac2558e000000b004dc852d9b88mr3812252lfg.45.1678189781415;
        Tue, 07 Mar 2023 03:49:41 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j19-20020a19f513000000b004dc721ea6a1sm1997226lfb.273.2023.03.07.03.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 03:49:40 -0800 (PST)
Message-ID: <47b591c0-2f68-429d-6d1b-fa8b701785ac@linaro.org>
Date:   Tue, 7 Mar 2023 13:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Georgi Djakov <djakov@kernel.org>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
 <CAA8EJprbMybV0o1-436yLhVnnEX6qywrj=JmWDCL5usaH0DXiQ@mail.gmail.com>
 <61e8c730-e46d-728d-d770-f1ead4405d12@quicinc.com>
 <83184da4-b183-3271-983f-3a1a62fb9f1a@linaro.org>
 <365f2609-d3b4-df23-5b6e-7a190815a640@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <365f2609-d3b4-df23-5b6e-7a190815a640@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 08:36, Varadarajan Narayanan wrote:
> 
> On 3/6/2023 5:21 PM, Dmitry Baryshkov wrote:
>> On 06/03/2023 13:26, Varadarajan Narayanan wrote:
>>> Dmitry,
>>>
>>> On 3/2/2023 9:52 PM, Dmitry Baryshkov wrote:
>>>> On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
>>>> <quic_varada@quicinc.com> wrote:
>>>>> Add USB phy and controller related nodes
>>>>>
>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>> ---
>>>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 92 
>>>>> +++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 92 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi 
>>>>> b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>>> index 2bb4053..319b5bd 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>
>> [skipped]
>>
>>
>>>>> +               usb3: usb3@8A00000 {
>>>> You know the drill. This node is in the wrong place.
>>>>
>>>>> +                       compatible = "qcom,dwc3";
>>>>> +                       reg = <0x8AF8800 0x400>;
>>>>> +                       #address-cells = <1>;
>>>>> +                       #size-cells = <1>;
>>>>> +                       ranges;
>>>>> +
>>>>> +                       clocks = <&gcc GCC_SNOC_USB_CLK>,
>>>>> +                               <&gcc GCC_ANOC_USB_AXI_CLK>,
>>>>> +                               <&gcc GCC_USB0_MASTER_CLK>,
>>>>> +                               <&gcc GCC_USB0_SLEEP_CLK>,
>>>>> +                               <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>>>>> +
>>>>> +                       clock-names = "sys_noc_axi",
>>>>> +                               "anoc_axi",
>>>>> +                               "master",
>>>>> +                               "sleep",
>>>>> +                               "mock_utmi";
>>>> Please fix the indentation of the lists.
>>>>
>>>>> +
>>>>> +                       assigned-clocks = <&gcc GCC_SNOC_USB_CLK>,
>>>>> +                                         <&gcc GCC_ANOC_USB_AXI_CLK>,
>>>> Why do you assign clock rates to the NOC clocks? Should they be set
>>>> using the interconnect instead?
>>>
>>> The SNOC and ANOC run at a fixed speed of 350MHz and 342MHz 
>>> respectively and are not scaled. These clocks are for the interface 
>>> between the USB block and the SNOC/ANOC. Do we still need to use 
>>> interconnect?
>>
>> Maybe I misunderstand something here. If the snoc and anoc speeds are 
>> at 350 MHz and 342 MHz, why do you assign clock-rates of 200 MHz?
>>
>> Is it enough to call clk_prepare_enable() for these clocks or the rate 
>> really needs to be set?
> 
> The rate of 200MHz is not being set for the SNOC/ANOC. It is for the
> NIU that connects the USB and SNOC/ANOC. The reason for setting the
> rate to 200MHz is to configure the RCG parent for these interface
> clocks. That said can we configure this RCG standalone in the driver
> and enable these clocks?

We discussed this separately with Georgi Djakov. Let me quote his IRC 
message: "it sounds like this is for USB port that connects to the NOC. 
if bandwidth scaling is not needed (or other interconnect 
configuration), then maybe this can go without interconnect provider 
driver."

However as we discover more and more about this platform (e.g. PCIe 
using the aggre_noc region to setup some magic registers, see [1]), I'm 
more and more biased towards suggesting implementing the interconnect 
driver to setup all these tiny little things. With the DT tree being an 
ABI, it is much preferable to overestimate the needs rather than 
underestimating them (and having to cope with the backwards 
compatibility issues).

Generally I think that PCIe/USB/whatever should not poke into NoC 
registers or NoC/NIU clocks directly (because this is a very 
platform-specific item). Rather than that it should tell the 
icc/opp/whatever subsystem, "please configure the SoC for me to work".

[1] 
https://lore.kernel.org/linux-arm-msm/30cf9717-dcca-e984-c506-c71b7f8e32cd@quicinc.com/

> 
> Thanks
> Varada
> 
> 
>>
>>
>>>
>>>>> + <&gcc GCC_USB0_MASTER_CLK>,
>>>>> +                                         <&gcc 
>>>>> GCC_USB0_MOCK_UTMI_CLK>;
>>>>> +                       assigned-clock-rates = <200000000>,
>>>>> + <200000000>,
>>>>> + <200000000>,
>>>>> + <24000000>;
>>>>> +
>>>>> +                       resets = <&gcc GCC_USB_BCR>;
>>>>> +                       status = "disabled";
>>>>> +
>>>>> +                       dwc_0: dwc3@8A00000 {
>>>>> +                               compatible = "snps,dwc3";
>>>>> +                               reg = <0x8A00000 0xcd00>;
>>>>> +                               clock-names = "ref";
>>>>> +                               clocks = <&gcc 
>>>>> GCC_USB0_MOCK_UTMI_CLK>;
>>>> clocks before clock-names
>>>>
>>>>> + interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +                               phys = <&qusb_phy_0>, <&usb0_ssphy>;
>>>>> +                               phy-names = "usb2-phy", "usb3-phy";
>>>>> +                               tx-fifo-resize;
>>>>> +                               snps,dis_ep_cache_eviction;
>>>>> +                               snps,is-utmi-l1-suspend;
>>>>> +                               snps,hird-threshold = /bits/ 8 <0x0>;
>>>>> +                               snps,dis_u2_susphy_quirk;
>>>>> +                               snps,dis_u3_susphy_quirk;
>>>>> + snps,quirk-frame-length-adjustment = <0x0A87F0A0>;
>>>>> +                               dr_mode = "host";
>>>>> +                       };
>>>>> +               };
>>>>> +
>>>>>                  pcie0_phy: phy@84000 {
>>>>>                          compatible = 
>>>>> "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>>>>>                          reg = <0x00084000 0x1bc>; /* Serdes PLL */
>>>>> -- 
>>>>> 2.7.4
>>>
>>> Will address these and post a new revision.
>>>
>>> Thanks
>>>
>>> Varada
>>>
>>

-- 
With best wishes
Dmitry

