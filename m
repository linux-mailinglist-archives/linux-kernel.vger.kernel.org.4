Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742CD6726FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjARScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjARScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:32:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C553B0CB;
        Wed, 18 Jan 2023 10:32:03 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IHebue001013;
        Wed, 18 Jan 2023 18:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mhdJfN6MC/RX1BW2utSBLAgdrNwe8Dkh3H8WgTj/kI8=;
 b=MOF7x3EfSQqlSHa6xKtW5+5+/DmW0A0FCfPE/JhDJFkuZc8+WczpE3/kNkw+VwjKtweh
 DchwHPQkQXOTDZq/YOjt303jcO39OZhX0/3wzCNU1ThDftvAQZolWQ5VH9Gi4GXuCSM+
 9ddiQg3nbJUjK5tAOgxxen15qSOAD7Y8UvZPtDs9LcicoAsUw3Q1wu9Ox670O/Go9pyN
 SuC5naj1i+Jkx9zkVx4dNNj4tez0nB4Gnlq+0Y7ujr/sd5MJFcEvGf0OOmhnP+rphiSM
 BlcLZQ4qqmy4z12qEMCKyAC2CAphYFuzZTT92+5N440hicu0BOBDQ5AW1hboqz1N+KLq IQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n602k2shv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:31:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30IIVrjL020308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:31:53 GMT
Received: from [10.216.38.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 10:31:46 -0800
Message-ID: <16ee9cd0-94b4-2fae-f024-63a4d04bafa6@quicinc.com>
Date:   Thu, 19 Jan 2023 00:01:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC v4 5/5] arm: dts: msm: Add multiport controller node for usb
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-6-quic_kriskura@quicinc.com>
 <20230118182847.GB3353734@hu-bjorande-lv.qualcomm.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230118182847.GB3353734@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L5Faig9zkCX0sq5qXHXPlEZtmCU4ZvSV
X-Proofpoint-GUID: L5Faig9zkCX0sq5qXHXPlEZtmCU4ZvSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180156
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 11:58 PM, Bjorn Andersson wrote:
> On Sun, Jan 15, 2023 at 05:11:46PM +0530, Krishna Kurapati wrote:
>> Add USB and DWC3 node for teritiary port of SC8280 along
>> with multiport IRQ's and phy's.
>>
> 
> Very nice.
> 
> Please make the subject prefix "arm64: dts: qcom: sc8280xp:", to match
> other changes in the sc8280xp.dtsi.
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 49 +++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi   | 60 ++++++++++++++++++++++++
>>   2 files changed, 109 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> index 84cb6f3eeb56..f9eb854c3444 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>> @@ -422,6 +422,20 @@ &usb_1_qmpphy {
>>   	status = "okay";
>>   };
>>   
>> +&usb_2 {
>> +	status = "okay";
> 
> Please the status property last in the node.
> 
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&usb2_en_state>,
>> +			<&usb3_en_state>,
>> +			<&usb4_en_state>,
>> +			<&usb5_en_state>;
>> +};
>> +
>> +&usb_2_dwc3 {
>> +	dr_mode = "host";
>> +};
>> +
>>   &usb_2_hsphy0 {
>>   	vdda-pll-supply = <&vreg_l5a>;
>>   	vdda18-supply = <&vreg_l7g>;
>> @@ -472,6 +486,41 @@ &xo_board_clk {
>>   	clock-frequency = <38400000>;
>>   };
>>   
>> +/* PINCTRL */
> 
> No need to repeat this comment, its purpose is to indicate that nodes
> above are sorted alphabetically and pinctrl-related nodes are kept here
> at the end of the file. Please place your nodes below the existing /*
> PINCTRL */ comment below.
> 
> Thanks,
> Bjorn
> 
>> +&pm8450c_gpios {
>> +	usb2_en_state: usb2-en-state {
>> +		pins = "gpio9";
>> +		function = "normal";
>> +		output-high;
>> +		power-source = <0>;
>> +	};
>> +};
>> +
>> +&pm8450e_gpios {
>> +	usb3_en_state: usb3-en-state {
>> +		pins = "gpio5";
>> +		function = "normal";
>> +		output-high;
>> +		power-source = <0>;
>> +	};
>> +};
>> +
>> +&pm8450g_gpios {
>> +	usb4_en_state: usb4-en-state {
>> +		pins = "gpio5";
>> +		function = "normal";
>> +		output-high;
>> +		power-source = <0>;
>> +	};
>> +
>> +	usb5_en_state: usb5-en-state {
>> +		pins = "gpio9";
>> +		function = "normal";
>> +		output-high;
>> +		power-source = <0>;
>> +	};
>> +};
>> +
>>   /* PINCTRL */
>>   
>>   &tlmm {
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index 109c9d2b684d..e9866ab5c6e2 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -1969,6 +1969,66 @@ usb_1_dwc3: usb@a800000 {
>>   			};
>>   		};
>>   
>> +		usb_2: usb@a4f8800 {
>> +			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
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
>> +						<&pdc 16 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			interrupt-names = "dp_hs_phy_irq", "dm_hs_phy_irq",
>> +						"ss_phy_irq";
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
>> +			status = "disabled";
>> +
>> +			usb_2_dwc3: usb@a400000 {
>> +				compatible = "snps,dwc3";
>> +				reg = <0 0x0a400000 0 0xcd00>;
>> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +				iommus = <&apps_smmu 0x800 0x0>;
>> +				num-ports = <4>;
>> +				num-ss-ports = <2>;
>> +				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
>> +					<&usb_2_hsphy1>, <&usb_2_qmpphy1>,
>> +					<&usb_2_hsphy2>,
>> +					<&usb_2_hsphy3>;
>> +				phy-names = "usb2-phy_port0", "usb3-phy_port0",
>> +						"usb2-phy_port1", "usb3-phy_port1",
>> +						"usb2-phy_port2",
>> +						"usb2-phy_port3";
>> +			};
>> +		};
>> +
>>   		pdc: interrupt-controller@b220000 {
>>   			compatible = "qcom,sc8280xp-pdc", "qcom,pdc";
>>   			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
>> -- 
>> 2.39.0
>>

Hi Bjorn,

  Thanks for the review. Will make sure to incorporate these changes in 
the next version.

Regards,
Krishna,
