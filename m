Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70136F3F41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjEBIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEBIhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:37:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C77DEB;
        Tue,  2 May 2023 01:37:38 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3426Zasb028189;
        Tue, 2 May 2023 08:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=90UgHp4VYN1Z25zyNC4eoJd76M71nk5scFed1XlQ52Q=;
 b=PoQELODDHm8ai1Purwkmd7Iq3KhnJpTNlbOUmXYyW4cJ+XnfkdRp5jg8qD1BHGXFduSQ
 GIwfqVU+EQKGWXpsCgxO6X9mJotLURdBVAC4IyRw7DwUcArnDgEOoyV5WDxdcXHGBP91
 yuLe2lDKWMgmst/i3nTEbnu09UVuCl37WRin1+wNiUL862RLmnUHH7DD8gfJeMD9msJC
 NfW5Y38BwJJsTIchNPAZ8BUKIZ6a+R7PMMHNU8LlvkIsfFzO36FJQ1ZiNbvQYKAPoJWN
 v85MalMX3leKh1WEILoRHXCHe43KIBC3izdkJNBGSlY+Bg2DmNtYAOM57xWzIwDZWflV Sw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qawct870h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 08:37:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3428bQlE019722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 May 2023 08:37:27 GMT
Received: from [10.216.63.8] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 2 May 2023
 01:37:20 -0700
Message-ID: <ca4da3c1-29dd-6d7d-6fe6-dd6ecc7fff88@quicinc.com>
Date:   Tue, 2 May 2023 14:07:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 7/9] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-8-quic_kriskura@quicinc.com>
 <57d2405f-7bd2-0ca3-a119-55b7bf0f36f9@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <57d2405f-7bd2-0ca3-a119-55b7bf0f36f9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5UlUhnTEOiXe1B0PVNyd0QibpQZMGJMT
X-Proofpoint-GUID: 5UlUhnTEOiXe1B0PVNyd0QibpQZMGJMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020075
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2023 1:17 PM, Krzysztof Kozlowski wrote:
> On 01/05/2023 16:34, Krishna Kurapati wrote:
>> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
>> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
>> platforms.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 64 ++++++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index 8fa9fbfe5d00..0e4fb286956b 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -3133,6 +3133,70 @@ usb_1_role_switch: endpoint {
>>   			};
>>   		};
>>   
>> +		usb_2: usb@a4f8800 {
> 
> Nodes are ordered by unit address, more or less >
>> +			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
>> +			reg = <0 0x0a4f8800 0 0x400>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +
>> +			clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
>> +				 <&gcc GCC_USB30_MP_MASTER_CLK>,
>> +				 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
>> +				 <&gcc GCC_USB30_MP_SLEEP_CLK>,
>> +				 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
>> +				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
>> +				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
>> +			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi",
>> +				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";
>> +
>> +			assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
>> +					  <&gcc GCC_USB30_MP_MASTER_CLK>;
>> +			assigned-clock-rates = <19200000>, <200000000>;
>> +
>> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
>> +						<&pdc 126 IRQ_TYPE_EDGE_RISING>,
>> +						<&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
>> +						<GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
>> +						<GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
>> +						<GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
>> +						<GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
> 
> Does not look aligned. >
>> +
>> +			interrupt-names = "dp_hs_phy_irq", "dm_hs_phy_irq",
>> +						"ss_phy_irq", "pwr_event_1",
> 
> Does not look aligned.
> 
Sure, will fix up the indentation issues.
>> +						"pwr_event_2", "pwr_event_3",
>> +						"pwr_event_4";
>> +
>> +			power-domains = <&gcc USB30_MP_GDSC>;
>> +
>> +			resets = <&gcc GCC_USB30_MP_BCR>;
>> +
>> +			interconnects = <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI1 0>,
>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
>> +			interconnect-names = "usb-ddr", "apps-usb";
>> +
>> +			required-opps = <&rpmhpd_opp_nom>;
>> +
> 
> Please open the DTSI and look how this is organized there. I don't think
> doing this differently - with different order - helps to review.
> required-opps is next to power-domains.
Sure. Will fix it up.
> 
>> +			status = "disabled";
>> +
>> +			usb_2_dwc3: usb@a400000 {
>> +				compatible = "snps,dwc3";
>> +				reg = <0 0x0a400000 0 0xcd00>;
>> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +				iommus = <&apps_smmu 0x800 0x0>;
>> +				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
>> +					<&usb_2_hsphy1>, <&usb_2_qmpphy1>,
>> +					<&usb_2_hsphy2>,
>> +					<&usb_2_hsphy3>;
>> +				phy-names = "usb2-port0", "usb3-port0",
>> +						"usb2-port1", "usb3-port1",
>> +						"usb2-port2",
>> +						"usb2-port3";
>> +			};
>> +		};
>> +
>>   		mdss0: display-subsystem@ae00000 {
>>   			compatible = "qcom,sc8280xp-mdss";
>>   			reg = <0 0x0ae00000 0 0x1000>;
> 

Thanks,
Krishna,
