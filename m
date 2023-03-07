Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160CB6AD77B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCGGhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCGGg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:36:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9526C51F9B;
        Mon,  6 Mar 2023 22:36:56 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327301Hu025572;
        Tue, 7 Mar 2023 06:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4fvhnr5vH27mkKMa9NDeUgruEyc4XN63yU0+6CoAjlI=;
 b=BohYWvg3dhPGhxo/7nGUO/2Ad0XoNgb1S1KIblJ1Budyhd6NZ8IOn1ZJFDn8WKtDr1sl
 yGrHXb+eKcrbACHPRMRSweOa5vjdz4IUBefIajGzCTB7MK6r9OhNNzQxP8kmsmu23d4i
 MgS2A8hpOITa0Fo9gduwzb9axovCKYdG/xJiOQTAkUJyiPrtQ0uaa1XbFXh+odKtVN2H
 L2xmkG+DhAB54D8wFD0Aovc4sS72ZUYF8axPjALNtMuUixyGK934T5rMdKev1zyUsp0N
 Xs81REeSbhKKDMyynGDfZT8nejc5rtG91ngFjDChI7j6O0fllkSZh7S0/glu3IEIxRf/ Bg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p4g3mwyd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 06:36:52 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3276apTs015072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 06:36:51 GMT
Received: from [10.201.3.167] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 22:36:48 -0800
Message-ID: <365f2609-d3b4-df23-5b6e-7a190815a640@quicinc.com>
Date:   Tue, 7 Mar 2023 12:06:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
 <CAA8EJprbMybV0o1-436yLhVnnEX6qywrj=JmWDCL5usaH0DXiQ@mail.gmail.com>
 <61e8c730-e46d-728d-d770-f1ead4405d12@quicinc.com>
 <83184da4-b183-3271-983f-3a1a62fb9f1a@linaro.org>
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <83184da4-b183-3271-983f-3a1a62fb9f1a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vaygtlT1dA1GpQymuseMb4YWzl_V4hT0
X-Proofpoint-GUID: vaygtlT1dA1GpQymuseMb4YWzl_V4hT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303070057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/6/2023 5:21 PM, Dmitry Baryshkov wrote:
> On 06/03/2023 13:26, Varadarajan Narayanan wrote:
>> Dmitry,
>>
>> On 3/2/2023 9:52 PM, Dmitry Baryshkov wrote:
>>> On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
>>> <quic_varada@quicinc.com> wrote:
>>>> Add USB phy and controller related nodes
>>>>
>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 92 
>>>> +++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 92 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi 
>>>> b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>> index 2bb4053..319b5bd 100644
>>>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>
> [skipped]
>
>
>>>> +               usb3: usb3@8A00000 {
>>> You know the drill. This node is in the wrong place.
>>>
>>>> +                       compatible = "qcom,dwc3";
>>>> +                       reg = <0x8AF8800 0x400>;
>>>> +                       #address-cells = <1>;
>>>> +                       #size-cells = <1>;
>>>> +                       ranges;
>>>> +
>>>> +                       clocks = <&gcc GCC_SNOC_USB_CLK>,
>>>> +                               <&gcc GCC_ANOC_USB_AXI_CLK>,
>>>> +                               <&gcc GCC_USB0_MASTER_CLK>,
>>>> +                               <&gcc GCC_USB0_SLEEP_CLK>,
>>>> +                               <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>>>> +
>>>> +                       clock-names = "sys_noc_axi",
>>>> +                               "anoc_axi",
>>>> +                               "master",
>>>> +                               "sleep",
>>>> +                               "mock_utmi";
>>> Please fix the indentation of the lists.
>>>
>>>> +
>>>> +                       assigned-clocks = <&gcc GCC_SNOC_USB_CLK>,
>>>> +                                         <&gcc GCC_ANOC_USB_AXI_CLK>,
>>> Why do you assign clock rates to the NOC clocks? Should they be set
>>> using the interconnect instead?
>>
>> The SNOC and ANOC run at a fixed speed of 350MHz and 342MHz 
>> respectively and are not scaled. These clocks are for the interface 
>> between the USB block and the SNOC/ANOC. Do we still need to use 
>> interconnect?
>
> Maybe I misunderstand something here. If the snoc and anoc speeds are 
> at 350 MHz and 342 MHz, why do you assign clock-rates of 200 MHz?
>
> Is it enough to call clk_prepare_enable() for these clocks or the rate 
> really needs to be set?

The rate of 200MHz is not being set for the SNOC/ANOC. It is for the
NIU that connects the USB and SNOC/ANOC. The reason for setting the
rate to 200MHz is to configure the RCG parent for these interface
clocks. That said can we configure this RCG standalone in the driver
and enable these clocks?

Thanks
Varada


>
>
>>
>>>> + <&gcc GCC_USB0_MASTER_CLK>,
>>>> +                                         <&gcc 
>>>> GCC_USB0_MOCK_UTMI_CLK>;
>>>> +                       assigned-clock-rates = <200000000>,
>>>> + <200000000>,
>>>> + <200000000>,
>>>> + <24000000>;
>>>> +
>>>> +                       resets = <&gcc GCC_USB_BCR>;
>>>> +                       status = "disabled";
>>>> +
>>>> +                       dwc_0: dwc3@8A00000 {
>>>> +                               compatible = "snps,dwc3";
>>>> +                               reg = <0x8A00000 0xcd00>;
>>>> +                               clock-names = "ref";
>>>> +                               clocks = <&gcc 
>>>> GCC_USB0_MOCK_UTMI_CLK>;
>>> clocks before clock-names
>>>
>>>> + interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>>>> +                               phys = <&qusb_phy_0>, <&usb0_ssphy>;
>>>> +                               phy-names = "usb2-phy", "usb3-phy";
>>>> +                               tx-fifo-resize;
>>>> +                               snps,dis_ep_cache_eviction;
>>>> +                               snps,is-utmi-l1-suspend;
>>>> +                               snps,hird-threshold = /bits/ 8 <0x0>;
>>>> +                               snps,dis_u2_susphy_quirk;
>>>> +                               snps,dis_u3_susphy_quirk;
>>>> + snps,quirk-frame-length-adjustment = <0x0A87F0A0>;
>>>> +                               dr_mode = "host";
>>>> +                       };
>>>> +               };
>>>> +
>>>>                  pcie0_phy: phy@84000 {
>>>>                          compatible = 
>>>> "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>>>>                          reg = <0x00084000 0x1bc>; /* Serdes PLL */
>>>> -- 
>>>> 2.7.4
>>
>> Will address these and post a new revision.
>>
>> Thanks
>>
>> Varada
>>
>
