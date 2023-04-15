Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4846E333D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 21:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDOTFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDOTFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 15:05:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D4D30C2;
        Sat, 15 Apr 2023 12:05:28 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33FJ0pd0008891;
        Sat, 15 Apr 2023 19:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=s3lmJdZsVQSb4x/Nw5+R4LJcx3rNKra67fOywpTjJSk=;
 b=UZQ7rg4jtkD+G+8Z9PfQjObnOfJL/EgB6dnbZ3oMTFrX0/UwckQbGCKEH/o45ZKvxV3s
 eAB/j5R1K7r2XToW3jTGnjt5cFth9YNmVWJFH3I+zCkfpt3iJEGIq7kYeGCnu1OwdyHf
 077Vpl59y80MPJ1GvRml9Hu4XPywA7HDWfd8a8AjBH/WuglpQtIgCNpiLDb8+DTdTGuy
 QQiFUdZ4LjCgMTof4rVBW6E8GWaipca2A79SfsU0LR00rVDseUc3YUd0NEjg8lu6rg/M
 C0mCKgmUeAs0TgycG7sghwL7gR81ljbXlU4pZDewJAr3zTUaiWNwSaqKcHnWaqUwNctX Aw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymnerv2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Apr 2023 19:05:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33FJ54VI007336
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Apr 2023 19:05:04 GMT
Received: from [10.216.37.89] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 15 Apr
 2023 12:04:58 -0700
Message-ID: <333ce700-8ca2-e230-3b5a-a95e4c021e45@quicinc.com>
Date:   Sun, 16 Apr 2023 00:34:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 6/8] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>, <quic_shazhuss@quicinc.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <20230405125759.4201-7-quic_kriskura@quicinc.com>
 <20230414154527.vsjtgtfsd5kc7vww@halaney-x13s>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230414154527.vsjtgtfsd5kc7vww@halaney-x13s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dSxKuSYbVuo1lC3gFi5IP51i7PMGkpgj
X-Proofpoint-GUID: dSxKuSYbVuo1lC3gFi5IP51i7PMGkpgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_10,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=860 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304150177
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 9:15 PM, Andrew Halaney wrote:
> On Wed, Apr 05, 2023 at 06:27:57PM +0530, Krishna Kurapati wrote:
>> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
>> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
>> platforms.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>> Link to v5: https://lore.kernel.org/all/20230310163420.7582-7-quic_kriskura@quicinc.com/
>>
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 58 ++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index 42bfa9fa5b96..7b81f2b0449d 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -3108,6 +3108,64 @@ usb_1_role_switch: endpoint {
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
> 
> This is breaking the current schema (with the full series applied),
> I am not sure if a pwr_event IRQ exists or but it maybe necessary to
> modify qcom,dwc3.yaml in order to explain hardware if it doesn't exist:
> 
> (dtschema) ahalaney@halaney-x13s ~/git/linux-next (git)-[718f2024524f] % make CHECK_DTBS=y DT_SCHEMA_FILES=/usb/qcom,dwc3.yaml qcom/sa8540p-ride.dtb                                                                                   :(
>    LINT    Documentation/devicetree/bindings
>    CHKDT   Documentation/devicetree/bindings/processed-schema.json
>    SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>    DTC_CHK arch/arm64/boot/dts/qcom/sa8540p-ride.dtb
> /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names:0: 'pwr_event' was expected
> 	From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names:1: 'dp_hs_phy_irq' was expected
> 	From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names:2: 'dm_hs_phy_irq' was expected
> 	From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names: ['dp_hs_phy_irq', 'dm_hs_phy_irq', 'ss_phy_irq'] is too short
> 	From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupts-extended: [[99, 127, 1], [99, 126, 1], [99, 16, 4]] is too short
> 	From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> make CHECK_DTBS=y DT_SCHEMA_FILES=/usb/qcom,dwc3.yaml qcom/sa8540p-ride.dtb  22.61s user 0.54s system 99% cpu 23.172 total
> (dtschema) ahalaney@halaney-x13s ~/git/linux-next (git)-[718f2024524f] %
> 
> Thanks,
> Andrew
> 

Hi Andrew,

  Thanks for pointing it out. Let me check and get back on the 
pwr_event_irq.

Probably I might have missed it 😅. If so, will make sure to add it in 
next version.

Regards,
Krishna,
