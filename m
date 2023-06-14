Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0677972FBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjFNLAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbjFNK77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:59:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5841FCC;
        Wed, 14 Jun 2023 03:59:50 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E7Wd0K005534;
        Wed, 14 Jun 2023 10:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pFB2zle8zvQ5Dvf2ladBy5VQhLpt1izhuEISpUUuX2o=;
 b=hcDZWGRxTKrOCgs9PoW/WifyBcEvE/Vef4/srq/2DaL5vr7hwYPzz/XgRyWi3rRBwhom
 5kmjZ3nv1J8tlFHfpWHdCQGmd2AlFzhPzGdF4DdHDNadelDhQJffOOY1rXFNbx8XU5dK
 1pgBLPdMhga3wdcx3W+3ArItcyYTQvjIjDRjpASn4Zw/IpwFAd2chQ0AS74vLSLYj/Ln
 /SK6xuxF13dEKhMIoi/rmClsCkxw2siCBBxgFZmbZARKQx4yeJUihsDvmITYiXFM7061
 EA4xpmW87U3JMySQbfFPLFccrkYyHmMJRWfXbJtyDZy78jkEdLfhnsdWDwNTbY+P8XoB xQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6vx81t7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 10:59:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EAxkG4024676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 10:59:46 GMT
Received: from [10.201.197.30] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 03:59:41 -0700
Message-ID: <83be6c80-adb6-2670-1d65-769a7fbe8a98@quicinc.com>
Date:   Wed, 14 Jun 2023 16:29:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5332: add support for the RDP446
 variant
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230606095732.12884-1-quic_harihk@quicinc.com>
 <20230606095732.12884-3-quic_harihk@quicinc.com>
 <0848ee8e-f520-06a1-9a15-f6dadc2fd69e@linaro.org>
From:   Hariharan K <quic_harihk@quicinc.com>
In-Reply-To: <0848ee8e-f520-06a1-9a15-f6dadc2fd69e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RBdn5wEMxROTqhvy33FikR5r5YPy_f1M
X-Proofpoint-GUID: RBdn5wEMxROTqhvy33FikR5r5YPy_f1M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_07,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140094
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipq5332-rdp-common.dtsi will be posted shortly. This patch will be 
re-based on top of it.

Regards,
Hariharan K

On 6/14/2023 4:13 PM, Konrad Dybcio wrote:
> 
> 
> On 6.06.2023 11:57, Hariharan K wrote:
>> Add the initial device tree support for the Reference Design
>> Platform(RDP) 446 based on IPQ5332 family of SoC. This patch carries
>> the support for Console UART, SPI NOR and I2C.
>>
>> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
>> ---
> Please consider making a common dtsi, like for 9574 here:
> 
> https://lore.kernel.org/linux-arm-msm/20230614085040.22071-1-quic_anusha@quicinc.com
> 
> Konrad
>>   arch/arm64/boot/dts/qcom/Makefile           |  1 +
>>   arch/arm64/boot/dts/qcom/ipq5332-rdp446.dts | 83 +++++++++++++++++++++
>>   2 files changed, 84 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp446.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 4f9e81253e18..f962e1b7cf7a 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp446.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp446.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp446.dts
>> new file mode 100644
>> index 000000000000..0e1d98b093e4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp446.dts
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * IPQ5332 AP-MI04.1 board device tree source
>> + *
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq5332.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ5332 MI04.1";
>> +	compatible = "qcom,ipq5332-ap-mi04.1", "qcom,ipq5332";
>> +
>> +	aliases {
>> +		serial0 = &blsp1_uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0";
>> +	};
>> +};
>> +
>> +&blsp1_uart0 {
>> +	pinctrl-0 = <&serial_0_pins>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +};
>> +
>> +&blsp1_i2c1 {
>> +	clock-frequency  = <400000>;
>> +	pinctrl-0 = <&i2c_1_pins>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +};
>> +
>> +&blsp1_spi0 {
>> +	pinctrl-0 = <&spi_0_data_clk_pins &spi_0_cs_pins>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +
>> +	flash@0 {
>> +		compatible = "micron,n25q128a11", "jedec,spi-nor";
>> +		reg = <0>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		spi-max-frequency = <50000000>;
>> +	};
>> +};
>> +
>> +&sleep_clk {
>> +	clock-frequency = <32000>;
>> +};
>> +
>> +&xo_board {
>> +	clock-frequency = <24000000>;
>> +};
>> +
>> +/* PINCTRL */
>> +
>> +&tlmm {
>> +	i2c_1_pins: i2c-1-state {
>> +		pins = "gpio29", "gpio30";
>> +		function = "blsp1_i2c0";
>> +		drive-strength = <8>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	spi_0_data_clk_pins: spi-0-data-clk-state {
>> +		pins = "gpio14", "gpio15", "gpio16";
>> +		function = "blsp0_spi";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	spi_0_cs_pins: spi-0-cs-state {
>> +		pins = "gpio17";
>> +		function = "blsp0_spi";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +};
