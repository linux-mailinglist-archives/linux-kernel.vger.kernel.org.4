Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800536E216E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDNK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDNK72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:59:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04A69ECF;
        Fri, 14 Apr 2023 03:59:18 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EAS9kH012550;
        Fri, 14 Apr 2023 10:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hDqRpuaN4PvvGQUgBdd+SN7are6DfzlZ1XCPEcl9Rv4=;
 b=VFygFQ5l6Aii6XwSAr2WkGp9AYBajN3JI95LN+DlfIiFknw97dshJYwNZ9nFOWSv4WIE
 7E92z2vGOFWFSUBbSq3B9S0qSO28HBZcvEg14gki14jZscDlMhivtbQ5V166ZYE+P21i
 0otgAN0ScNhQ9qAxxhPy+EaeF9F8CCCeiBR+9YjDfXk+tVFWHbqoItPB3f/oDVw0Jcyt
 w4vX9KfCkRjKc9wfwrTSy/O0VoRDu5MA1XL0oXdDLwV0LnRsAl54/VG/nn1dEi6zYZlE
 dci8vOyxscXC1ePD6GHcoTam7Z6HBImaz6l5mbVBoiBvcjxY5qOdiIXpppANvL7tUs/R Kw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxdtek2x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 10:58:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EAwiWu002691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 10:58:44 GMT
Received: from [10.216.10.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 03:58:35 -0700
Message-ID: <0fb3c4da-f0e0-eb14-2194-cbf8703f82ab@quicinc.com>
Date:   Fri, 14 Apr 2023 16:28:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V12 3/4] arm64: dts: qcom: Add support for ipq9574 SoC and
 RDP433 variant
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <geert+renesas@glider.be>, <rafal@milecki.pl>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230410135948.11970-1-quic_devipriy@quicinc.com>
 <20230410135948.11970-4-quic_devipriy@quicinc.com>
 <a599d157-002f-26ef-5f31-a3fb0925dfba@linaro.org>
 <da6051dd-1a29-a356-9d6a-a35f20b23fb9@quicinc.com>
 <411c8a57-9c9e-c799-91c4-5338f9d15799@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <411c8a57-9c9e-c799-91c4-5338f9d15799@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w6lTem9mOtoXIEecZ11mV2-6CyvKON3z
X-Proofpoint-GUID: w6lTem9mOtoXIEecZ11mV2-6CyvKON3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_05,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140099
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 4:27 PM, Konrad Dybcio wrote:
> 
> 
> On 14.04.2023 12:01, Devi Priya wrote:
>>
>>
>> On 4/13/2023 2:16 AM, Konrad Dybcio wrote:
>>>
>>>
>>> On 10.04.2023 15:59, Devi Priya wrote:
>>>> Add initial device tree support for Qualcomm IPQ9574 SoC and
>>>> Reference Design Platform(RDP) 433 which is based on IPQ9574
>>>> family of SoCs
>>>>
>>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>>> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>>> ---
>>>
>>>> +    soc: soc@0 {
>>>> +        compatible = "simple-bus";
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <1>;
>>>> +        ranges = <0 0 0 0xffffffff>;
>>> this is equal to:
>>>
>>> ranges;
>>
>> Konrad, on updating (ranges = <0 0 0 0xffffffff>; --> ranges;)
>> we see the below warnings:
>> arch/arm64/boot/dts/qcom/ipq9574.dtsi:103.3-10: Warning (ranges_format):
>> /soc@0:ranges: empty "ranges" property but its #address-cells (1)
>> differs from / (2)
>> arch/arm64/boot/dts/qcom/ipq9574.dtsi:103.3-10: Warning (ranges_format): /soc@0:ranges: empty "ranges" property but its #size-cells (1) differs
>> from / (2)
>>
>> Looks like, empty ranges property isn't supported if the parent and
>> child address spaces are non-identical.
>> Would you suggest to retain the ranges as such?
>> (ranges = <0 0 0 0xffffffff>;)
>>
>> Thanks,
>> Devi Priya
> Oh right, you have address/size cells = 2 at the top level.
> Forget about this change.
Yup, thanks!

Best Regards,
Devi Priya
> 
> Konrad
>>>
>>> Could you fix that up when applying, Bjorn, should there be
>>> no other issues?
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>
>> Thank you!
>>> Konrad
>>>
>>>> +
>>>> +        tlmm: pinctrl@1000000 {
>>>> +            compatible = "qcom,ipq9574-tlmm";
>>>> +            reg = <0x01000000 0x300000>;
>>>> +            interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            gpio-controller;
>>>> +            #gpio-cells = <2>;
>>>> +            gpio-ranges = <&tlmm 0 0 65>;
>>>> +            interrupt-controller;
>>>> +            #interrupt-cells = <2>;
>>>> +
>>>> +            uart2_pins: uart2-state {
>>>> +                pins = "gpio34", "gpio35";
>>>> +                function = "blsp2_uart";
>>>> +                drive-strength = <8>;
>>>> +                bias-disable;
>>>> +            };
>>>> +        };
>>>> +
>>>> +        gcc: clock-controller@1800000 {
>>>> +            compatible = "qcom,ipq9574-gcc";
>>>> +            reg = <0x01800000 0x80000>;
>>>> +            clocks = <&xo_board_clk>,
>>>> +                 <&sleep_clk>,
>>>> +                 <0>,
>>>> +                 <0>,
>>>> +                 <0>,
>>>> +                 <0>,
>>>> +                 <0>;
>>>> +            #clock-cells = <1>;
>>>> +            #reset-cells = <1>;
>>>> +            #power-domain-cells = <1>;
>>>> +        };
>>>> +
>>>> +        sdhc_1: mmc@7804000 {
>>>> +            compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
>>>> +            reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
>>>> +            reg-names = "hc", "cqhci";
>>>> +
>>>> +            interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            interrupt-names = "hc_irq", "pwr_irq";
>>>> +
>>>> +            clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>> +                 <&gcc GCC_SDCC1_APPS_CLK>,
>>>> +                 <&xo_board_clk>;
>>>> +            clock-names = "iface", "core", "xo";
>>>> +            non-removable;
>>>> +            status = "disabled";
>>>> +        };
>>>> +
>>>> +        blsp1_uart2: serial@78b1000 {
>>>> +            compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>>>> +            reg = <0x078b1000 0x200>;
>>>> +            interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
>>>> +                 <&gcc GCC_BLSP1_AHB_CLK>;
>>>> +            clock-names = "core", "iface";
>>>> +            status = "disabled";
>>>> +        };
>>>> +
>>>> +        intc: interrupt-controller@b000000 {
>>>> +            compatible = "qcom,msm-qgic2";
>>>> +            reg = <0x0b000000 0x1000>,  /* GICD */
>>>> +                  <0x0b002000 0x2000>,  /* GICC */
>>>> +                  <0x0b001000 0x1000>,  /* GICH */
>>>> +                  <0x0b004000 0x2000>;  /* GICV */
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <1>;
>>>> +            interrupt-controller;
>>>> +            #interrupt-cells = <3>;
>>>> +            interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>>> +            ranges = <0 0x0b00c000 0x3000>;
>>>> +
>>>> +            v2m0: v2m@0 {
>>>> +                compatible = "arm,gic-v2m-frame";
>>>> +                reg = <0x00000000 0xffd>;
>>>> +                msi-controller;
>>>> +            };
>>>> +
>>>> +            v2m1: v2m@1000 {
>>>> +                compatible = "arm,gic-v2m-frame";
>>>> +                reg = <0x00001000 0xffd>;
>>>> +                msi-controller;
>>>> +            };
>>>> +
>>>> +            v2m2: v2m@2000 {
>>>> +                compatible = "arm,gic-v2m-frame";
>>>> +                reg = <0x00002000 0xffd>;
>>>> +                msi-controller;
>>>> +            };
>>>> +        };
>>>> +
>>>> +        timer@b120000 {
>>>> +            compatible = "arm,armv7-timer-mem";
>>>> +            reg = <0x0b120000 0x1000>;
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <1>;
>>>> +            ranges;
>>>> +
>>>> +            frame@b120000 {
>>>> +                reg = <0x0b121000 0x1000>,
>>>> +                      <0x0b122000 0x1000>;
>>>> +                frame-number = <0>;
>>>> +                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            };
>>>> +
>>>> +            frame@b123000 {
>>>> +                reg = <0x0b123000 0x1000>;
>>>> +                frame-number = <1>;
>>>> +                interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>>>> +                status = "disabled";
>>>> +            };
>>>> +
>>>> +            frame@b124000 {
>>>> +                reg = <0x0b124000 0x1000>;
>>>> +                frame-number = <2>;
>>>> +                interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>>>> +                status = "disabled";
>>>> +            };
>>>> +
>>>> +            frame@b125000 {
>>>> +                reg = <0x0b125000 0x1000>;
>>>> +                frame-number = <3>;
>>>> +                interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>>>> +                status = "disabled";
>>>> +            };
>>>> +
>>>> +            frame@b126000 {
>>>> +                reg = <0x0b126000 0x1000>;
>>>> +                frame-number = <4>;
>>>> +                interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>>>> +                status = "disabled";
>>>> +            };
>>>> +
>>>> +            frame@b127000 {
>>>> +                reg = <0x0b127000 0x1000>;
>>>> +                frame-number = <5>;
>>>> +                interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>>>> +                status = "disabled";
>>>> +            };
>>>> +
>>>> +            frame@b128000 {
>>>> +                reg = <0x0b128000 0x1000>;
>>>> +                frame-number = <6>;
>>>> +                interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>>>> +                status = "disabled";
>>>> +            };
>>>> +        };
>>>> +    };
>>>> +
>>>> +    timer {
>>>> +        compatible = "arm,armv8-timer";
>>>> +        interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>>> +                 <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>>> +                 <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>>> +                 <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>>> +    };
>>>> +};
