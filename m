Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689FD6A9480
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCCJxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCCJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:53:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE274212;
        Fri,  3 Mar 2023 01:53:08 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3236NO76031936;
        Fri, 3 Mar 2023 09:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=br9VDlwrrZqq0MKPIV7Q8tN9gDoCB+CrqUsEZlSlqiQ=;
 b=MLJ5SwDOA3NPF66GxkSXFeIcRh3c6yyXdM19mepE7ZDKii0YuA6Nbqt4fqhr7/HKDhN0
 sXt5uGJtKubf/6yGJUC593j2DDIkO1o1iRXpA2mPh45eiwj38iBivEej04zdXqQ3BkXg
 XsMpU9exwjLc8fFLLgwWa4YiE490LGehNLazWBv3NSbGL5YybI2+w/OJ9jo4T+gZVfwQ
 FM7KzXMhY57qbpR9hFz75RxrLN3OJ/YCUstxyTyUIXX71JTnH+6XUmebQS5643t2lNRx
 zhMhJgZitrV2yCJuTXGJcpxJ1ZwO06CiDMwOSER6dbcRShtcuOF3jaJs1/ETulBTcU5f Iw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p32ty1q11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 09:53:05 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3239r4Im013881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 09:53:04 GMT
Received: from [10.50.35.127] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 01:53:01 -0800
Message-ID: <93ec4d79-3d24-2a2a-30eb-ea7bab92f8b7@quicinc.com>
Date:   Fri, 3 Mar 2023 15:22:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
 <1c692257-44b5-c443-33d8-1516da3be722@linaro.org>
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <1c692257-44b5-c443-33d8-1516da3be722@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7hkKHw-gMBX4bWk5ztAzu54Bopd6lIxu
X-Proofpoint-ORIG-GUID: 7hkKHw-gMBX4bWk5ztAzu54Bopd6lIxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030087
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/3/2023 1:09 PM, Krzysztof Kozlowski wrote:
> On 02/03/2023 10:55, Varadarajan Narayanan wrote:
>> Add USB phy and controller related nodes
>>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 92 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 2bb4053..319b5bd 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -215,6 +215,98 @@
>>   		#size-cells = <1>;
>>   		ranges = <0 0 0 0xffffffff>;
>>   
>> +		ssphy_0: ssphy@7D000 {
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
>
>> +			compatible = "qcom,ipq9574-qmp-usb3-phy";
>> +			reg = <0x7D000 0x1C4>;
>> +			#clock-cells = <1>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			clocks = <&gcc GCC_USB0_AUX_CLK>,
>> +				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
>> +			clock-names = "aux", "cfg_ahb";
>> +
>> +			resets =  <&gcc GCC_USB0_PHY_BCR>,
>> +				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
>> +			reset-names = "phy","common";
>> +			status = "disabled";
>> +
>> +			usb0_ssphy: lane@7D200 {
>> +				reg = <0x0007D200 0x130>,	/* Tx */
>> +				      <0x0007D400 0x200>,	/* Rx */
>> +				      <0x0007D800 0x1F8>,	/* PCS  */
>> +				      <0x0007D600 0x044>;	/* PCS misc */
>> +				#phy-cells = <0>;
>> +				clocks = <&gcc GCC_USB0_PIPE_CLK>;
>> +				clock-names = "pipe0";
>> +				clock-output-names = "gcc_usb0_pipe_clk_src";
>> +			};
>> +		};
>> +
>> +		qusb_phy_0: qusb@7B000 {
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
>
>> +			compatible = "qcom,ipq9574-qusb2-phy";
>> +			reg = <0x07B000 0x180>;
> Lowercase hex everywhere.
>
>> +			#phy-cells = <0>;
>> +
>> +			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
>> +				<&xo_board_clk>;
>> +			clock-names = "cfg_ahb", "ref";
>> +
>> +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
>> +			status = "disabled";
>> +		};
>> +
>> +		usb3: usb3@8A00000 {
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
>
>> +			compatible = "qcom,dwc3";
>> +			reg = <0x8AF8800 0x400>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			clocks = <&gcc GCC_SNOC_USB_CLK>,
>> +				<&gcc GCC_ANOC_USB_AXI_CLK>,
>> +				<&gcc GCC_USB0_MASTER_CLK>,
>> +				<&gcc GCC_USB0_SLEEP_CLK>,
>> +				<&gcc GCC_USB0_MOCK_UTMI_CLK>;
>> +
>> +			clock-names = "sys_noc_axi",
>> +				"anoc_axi",
>> +				"master",
>> +				"sleep",
>> +				"mock_utmi";
>> +
>> +			assigned-clocks = <&gcc GCC_SNOC_USB_CLK>,
>> +					  <&gcc GCC_ANOC_USB_AXI_CLK>,
>> +					  <&gcc GCC_USB0_MASTER_CLK>,
>> +					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>> +			assigned-clock-rates = <200000000>,
>> +					       <200000000>,
>> +					       <200000000>,
>> +					       <24000000>;
>> +
>> +			resets = <&gcc GCC_USB_BCR>;
>> +			status = "disabled";
>> +
>> +			dwc_0: dwc3@8A00000 {
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
>
>
> Best regards,
> Krzysztof
>
Sorry. Will rectify and post a new version.

Thank

Varada

