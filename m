Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7B6F0B68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244348AbjD0Ruu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244105AbjD0Rur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:50:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B061B0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:50:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50a145a0957so9214699a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682617842; x=1685209842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0RanLx/6AEy/8D1MbP9QBdlEEiZGpiLjh28jdSQewY=;
        b=ZU7urcH/DiF8AzmgSHXv7tdjNUaBv/l4TE+hlu3vZTlxJN12W6wLHDt7MXSmS67UWA
         pYTMdITf4M0IvYkgvkRHrbI8E1CJo0dMCwGbJEaECisX3jHLp8TyAemkVWtVS53UQY/n
         4Hyr3VEB+TBwtbvdx3Ve6c7K5KzLCLnqsVVH8sxWJUHOW7Q4az3Whkry7igeJgdLwfDX
         VlsuNQxLuhNBJMjdfTs0WTKUYFHcG22FmhUAwKuNtE4os/7sQwkjunE0Toh3ZgjHIHf/
         4WPNAr5Ee5nIs+pGa+NAAXiz0foc1R/B2mb5YNyGWBnW0a6OSnT+TFVFAl/yCWbB3Cbq
         3vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682617842; x=1685209842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0RanLx/6AEy/8D1MbP9QBdlEEiZGpiLjh28jdSQewY=;
        b=TpD4NW35b+b0K4eIXpffg8ChyEtRf3ggN45bdEZbmFgbZx5vVFgbV5CcYxH+eQq6rF
         +62N2nCtY1ERzu+pb9HxNBLxpPbghEEQ2eHipmswWwKoq1TpieMLOIQQ5UqEtqVMPZi3
         U1fsZXwEIK2cxesCpC3l6xvsHsMXmqQ8eq5llIN/3ZhXIF0P1iV0eQHIp4AorQ7P3dVt
         SZ8EtNrkHDFEMVTrpW5Bnby15sJRdQDvF26FdML4xPU31fUpngxdG3dVGmB5QgfGWqct
         5LSYmN+ziDXxPpC8fGASQ8X5ivS1JWyXVF0rjzieFZ2Nbu7xiwrdwy7czwiu2FC0z2Mc
         I5og==
X-Gm-Message-State: AC+VfDzQsy7tUJ7zk24l+DxXxibhnV1eXvm0wFC2DnjFWJTgxk6xH3X2
        Uoe1TMkAF3O3k0n8huGUHrEvoQ==
X-Google-Smtp-Source: ACHHUZ5XJ6WcNyPw3Vm7tdrrduEu6mH122BbzbER9mAczURLJ4xh4bqkVcL3W7fBXnyZguZj/WPquQ==
X-Received: by 2002:a17:906:4492:b0:953:834d:899b with SMTP id y18-20020a170906449200b00953834d899bmr6434300ejo.29.1682617841668;
        Thu, 27 Apr 2023 10:50:41 -0700 (PDT)
Received: from [172.23.2.5] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id z26-20020a170906715a00b0094f0237c32bsm9823283ejj.208.2023.04.27.10.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 10:50:40 -0700 (PDT)
Message-ID: <8f2eefc5-abc9-4cce-2170-7202b148e9c7@linaro.org>
Date:   Thu, 27 Apr 2023 20:50:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Content-Language: en-GB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1680693149.git.quic_varada@quicinc.com>
 <55db8487a7cbf3354749dd2d3a35c05bfd9fa4fc.1680693149.git.quic_varada@quicinc.com>
 <e142ff5d-543f-80bb-94f9-3f1fb90f1b83@linaro.org>
 <20230424090402.GB21232@varda-linux.qualcomm.com>
 <CAA8EJprqH5esxQkH3v-1i539OO3jQG9fN-YOqjZTwEqqgUfUyg@mail.gmail.com>
 <20230426095157.GA884@varda-linux.qualcomm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230426095157.GA884@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 12:51, Varadarajan Narayanan wrote:
> On Mon, Apr 24, 2023 at 02:17:06PM +0300, Dmitry Baryshkov wrote:
>> On Mon, 24 Apr 2023 at 12:04, Varadarajan Narayanan
>> <quic_varada@quicinc.com> wrote:
>>>
>>> On Sat, Apr 22, 2023 at 12:07:01AM +0300, Dmitry Baryshkov wrote:
>>>> On 05/04/2023 14:41, Varadarajan Narayanan wrote:
>>>>> Add USB phy and controller related nodes
>>>>>
>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>> ---
>>>>>   Changes in v8:
>>>>>      - Change clocks order to match the bindings
>>>>>   Changes in v7:
>>>>>      - Change com_aux -> cfg_ahb
>>>>>   Changes in v6:
>>>>>      - Introduce fixed regulators for the phy
>>>>>      - Resolved all 'make dtbs_check' messages
>>>>>
>>>>>   Changes in v5:
>>>>>      - Fix additional comments
>>>>>      - Edit nodes to match with qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>>>      - 'make dtbs_check' giving the following messages since
>>>>>        ipq9574 doesn't have power domains. Hope this is ok
>>>>>
>>>>>              /local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: phy@7d000: 'power-domains' is a required property
>>>>>              From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>>>              /local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: usb@8a00000: 'power-domains' is a required property
>>>>>              From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>>>>>
>>>>>   Changes in v4:
>>>>>      - Use newer bindings without subnodes
>>>>>      - Fix coding style issues
>>>>>
>>>>>   Changes in v3:
>>>>>      - Insert the nodes at proper location
>>>>>
>>>>>   Changes in v2:
>>>>>      - Fixed issues flagged by Krzysztof
>>>>>      - Fix issues reported by make dtbs_check
>>>>>      - Remove NOC related clocks (to be added with proper
>>>>>        interconnect support)
>>>>> ---
>>>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 120 ++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 120 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>>> index 43a3dbe..1242382 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>>> @@ -150,6 +150,33 @@
>>>>>              method = "smc";
>>>>>      };
>>>>> +    reg_usb_3p3: s3300 {
>>>>
>>>> The node names do not look generic enough. Please take a look at other
>>>> platforms.
>>>
>>> Please see below.
>>>
>>>>> +            compatible = "regulator-fixed";
>>>>> +            regulator-min-microvolt = <3300000>;
>>>>> +            regulator-max-microvolt = <3300000>;
>>>>> +            regulator-boot-on;
>>>>> +            regulator-always-on;
>>>>> +            regulator-name = "usb-phy-vdd-dummy";
>>>>
>>>> This also doesn't look correct. This regulator should not just fill the gap.
>>>> Does it represent a generic voltage network on the board?
>>>>
>>>> Please do not add 'dummy' voltage regulators if there is no real voltage
>>>> wire.
>>>
>>> These are real voltage wires. I used dummy since they are
>>> always-on and cannot be increased/decreased (i.e. fixed).
>>> Would something along the following lines be appropriate?
>>
>> Still not fully correct. Please use regulator name that corresponds to
>> the power grid on the board schematics. I don't think that you have a
>> separate power grids for USB PHY.
>>
>>>
>>>          vreg_ae10_3p3: s3300 {
>>
>> Naming suggests that these voltages are generated by some PMIC. Is
>> this correct? If so, please describe the PMIC instead.
> 
> SS PHY needs two supplies and HS PHY needs three supplies. 3.3V
> and 0.925V are from fixed DC - DC regulators and 1.8V is
> generated from MP5496 PMIC. Would the following node definitions
> be ok?
> 
> usb_hs_vreg0: usb_hs_vreg0 {
> 	compatible = "regulator-fixed";
> 	regulator-min-microvolt = <3300000>;
> 	regulator-max-microvolt = <3300000>;
> 	regulator-boot-on;
> 	regulator-always-on;
> 	regulator-name = "usb-phy-vdd";
> };
> 
> usb_hs_vreg1: usb_hs_vreg1 {
> 	compatible = "regulator-fixed";
> 	regulator-min-microvolt = <925000>;
> 	regulator-max-microvolt = <925000>;
> 	regulator-boot-on;
> 	regulator-always-on;
> 	regulator-name = "usb-phy";
> };

Again. The voltage rails on the board are not USB-specific, are they? So 
why are you declaring usb-phy regulators? Would another consumer of 3.3V 
rail use the same usb-phy-vdd regulator?

> 
> &rpm_requests {
> 	regulators {
> 		compatible = "qcom,rpm-mp5496-regulators";
> 		.
> 		.
> 		.
> 		ipq9574_l2: l2 {

mp5496_l2

> 			regulator-min-microvolt = <1800000>;
> 			regulator-max-microvolt = <1800000>;
> 			regulator-boot-on;
> 			regulator-always-on;
> 		};
> 	};
> };
> 
> Thanks
> Varada
> 
>>>                  compatible = "regulator-fixed";
>>>                  regulator-min-microvolt = <3300000>;
>>>                  regulator-max-microvolt = <3300000>;
>>>                  regulator-boot-on;
>>>                  regulator-always-on;
>>>                  regulator-name = "usb-phy-vdd";
>>>          };
>>>
>>>          vreg_ad8_1p8: s1800 {
>>>                  compatible = "regulator-fixed";
>>>                  regulator-min-microvolt = <1800000>;
>>>                  regulator-max-microvolt = <1800000>;
>>>                  regulator-boot-on;
>>>                  regulator-always-on;
>>>                  regulator-name = "usb-phy-pll";
>>>          };
>>>
>>>          vreg_ad9_0p925: s0925 {
>>>                  compatible = "regulator-fixed";
>>>                  regulator-min-microvolt = <925000>;
>>>                  regulator-max-microvolt = <925000>;
>>>                  regulator-boot-on;
>>>                  regulator-always-on;
>>>                  regulator-name = "usb-phy";
>>>          };
>>>
>>> Thanks
>>> Varada
>>>
>>>>> +    };
>>>>> +
>>>>> +    reg_usb_1p8: s1800 {
>>>>> +            compatible = "regulator-fixed";
>>>>> +            regulator-min-microvolt = <1800000>;
>>>>> +            regulator-max-microvolt = <1800000>;
>>>>> +            regulator-boot-on;
>>>>> +            regulator-always-on;
>>>>> +            regulator-name = "usb-phy-pll-dummy";
>>>>> +    };
>>>>> +
>>>>> +    reg_usb_0p925: s0925 {
>>>>> +            compatible = "regulator-fixed";
>>>>> +            regulator-min-microvolt = <925000>;
>>>>> +            regulator-max-microvolt = <925000>;
>>>>> +            regulator-boot-on;
>>>>> +            regulator-always-on;
>>>>> +            regulator-name = "usb-phy-dummy";
>>>>> +    };
>>>>> +
>>>>>      reserved-memory {
>>>>>              #address-cells = <2>;
>>>>>              #size-cells = <2>;
>>>>> @@ -179,6 +206,52 @@
>>>>>              #size-cells = <1>;
>>>>>              ranges = <0 0 0 0xffffffff>;
>>>>> +            usb_0_qusbphy: phy@7b000 {
>>>>> +                    compatible = "qcom,ipq9574-qusb2-phy";
>>>>> +                    reg = <0x0007b000 0x180>;
>>>>> +                    #phy-cells = <0>;
>>>>> +
>>>>> +                    clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
>>>>> +                             <&xo_board_clk>;
>>>>> +                    clock-names = "cfg_ahb",
>>>>> +                                  "ref";
>>>>> +
>>>>> +                    vdd-supply = <&reg_usb_0p925>;
>>>>> +                    vdda-pll-supply = <&reg_usb_1p8>;
>>>>> +                    vdda-phy-dpdm-supply = <&reg_usb_3p3>;
>>>>> +
>>>>> +                    resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
>>>>> +                    status = "disabled";
>>>>> +            };
>>>>> +
>>>>> +            usb_0_qmpphy: phy@7d000 {
>>>>> +                    compatible = "qcom,ipq9574-qmp-usb3-phy";
>>>>> +                    reg = <0x0007d000 0xa00>;
>>>>> +                    #phy-cells = <0>;
>>>>> +
>>>>> +                    clocks = <&gcc GCC_USB0_AUX_CLK>,
>>>>> +                             <&xo_board_clk>,
>>>>> +                             <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
>>>>> +                             <&gcc GCC_USB0_PIPE_CLK>;
>>>>> +                    clock-names = "aux",
>>>>> +                                  "ref",
>>>>> +                                  "cfg_ahb",
>>>>> +                                  "pipe";
>>>>> +
>>>>> +                    resets = <&gcc GCC_USB0_PHY_BCR>,
>>>>> +                             <&gcc GCC_USB3PHY_0_PHY_BCR>;
>>>>> +                    reset-names = "phy",
>>>>> +                                  "phy_phy";
>>>>> +
>>>>> +                    vdda-pll-supply = <&reg_usb_1p8>;
>>>>> +                    vdda-phy-supply = <&reg_usb_0p925>;
>>>>> +
>>>>> +                    status = "disabled";
>>>>> +
>>>>> +                    #clock-cells = <0>;
>>>>> +                    clock-output-names = "usb0_pipe_clk";
>>>>> +            };
>>>>> +
>>>>>              pcie0_phy: phy@84000 {
>>>>>                      compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>>>>>                      reg = <0x00084000 0x1000>;
>>>>> @@ -548,6 +621,53 @@
>>>>>                      status = "disabled";
>>>>>              };
>>>>> +            usb3: usb@8a00000 {
>>>>> +                    compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
>>>>> +                    reg = <0x08af8800 0x400>;
>>>>> +                    #address-cells = <1>;
>>>>> +                    #size-cells = <1>;
>>>>> +                    ranges;
>>>>> +
>>>>> +                    clocks = <&gcc GCC_SNOC_USB_CLK>,
>>>>> +                             <&gcc GCC_USB0_MASTER_CLK>,
>>>>> +                             <&gcc GCC_ANOC_USB_AXI_CLK>,
>>>>> +                             <&gcc GCC_USB0_SLEEP_CLK>,
>>>>> +                             <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>>>>> +
>>>>> +                    clock-names = "cfg_noc",
>>>>> +                                  "core",
>>>>> +                                  "iface",
>>>>> +                                  "sleep",
>>>>> +                                  "mock_utmi";
>>>>> +
>>>>> +                    assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
>>>>> +                                      <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>>>>> +                    assigned-clock-rates = <200000000>,
>>>>> +                                           <24000000>;
>>>>> +
>>>>> +                    interrupts-extended = <&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +                    interrupt-names = "pwr_event";
>>>>> +
>>>>> +                    resets = <&gcc GCC_USB_BCR>;
>>>>> +                    status = "disabled";
>>>>> +
>>>>> +                    dwc_0: usb@8a00000 {
>>>>> +                            compatible = "snps,dwc3";
>>>>> +                            reg = <0x8a00000 0xcd00>;
>>>>> +                            clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>>>>> +                            clock-names = "ref";
>>>>> +                            interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +                            phys = <&usb_0_qusbphy>, <&usb_0_qmpphy>;
>>>>> +                            phy-names = "usb2-phy", "usb3-phy";
>>>>> +                            tx-fifo-resize;
>>>>> +                            snps,is-utmi-l1-suspend;
>>>>> +                            snps,hird-threshold = /bits/ 8 <0x0>;
>>>>> +                            snps,dis_u2_susphy_quirk;
>>>>> +                            snps,dis_u3_susphy_quirk;
>>>>> +                            dr_mode = "host";
>>>>> +                    };
>>>>> +            };
>>>>> +
>>>>>              intc: interrupt-controller@b000000 {
>>>>>                      compatible = "qcom,msm-qgic2";
>>>>>                      reg = <0x0b000000 0x1000>,  /* GICD */
>>>>
>>>> --
>>>> With best wishes
>>>> Dmitry
>>>>
>>
>>
>>
>> --
>> With best wishes
>> Dmitry

-- 
With best wishes
Dmitry

