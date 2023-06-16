Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3F1733193
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbjFPMrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344910AbjFPMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:47:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66C2977;
        Fri, 16 Jun 2023 05:47:34 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GBQDug032641;
        Fri, 16 Jun 2023 12:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sxXe8Cc7Ys5J6Z/+6o8vSxnTtxZO1/mICBViqzUPqBo=;
 b=iL6+N/JJ5b6gbRLBnN3xYsnL6b3FBYvrgXEery3gRswHPduRmocD3Cj7aaj/tx2VT3+Z
 oY8XuBnwRjcDsjP3YMCVHDdxOAXw6B+CNnsf+NQBJ64XuZ2EEs0OqRvmRsIbSGCNe7mI
 mlvXLRz98IyysMbKtFORJVUTWdS4m6JAyBnS8oKwdmq4iF3pXdx6zBFobbdRD/ox1gzj
 DVKCz/GH+Ql8AkBKtGjR5bg9Cb5lguWZN5chmcfm3cCn+1x2NzRwhX4bjFsIRBCXaKRw
 8SPhGyDSmJEHMM7U6+a/S4rzTN2qEWedh7kpto0BO6RQjzZwxxiinWxsuH3ykloPj75O 3A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r83p9ad3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 12:47:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35GClUOL003326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 12:47:30 GMT
Received: from [10.216.44.30] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 16 Jun
 2023 05:47:23 -0700
Message-ID: <83aa1135-8e66-b153-ab5c-a23df2bce5f5@quicinc.com>
Date:   Fri, 16 Jun 2023 18:17:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: Enable WPS buttons
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230614085040.22071-1-quic_anusha@quicinc.com>
 <20230614085040.22071-3-quic_anusha@quicinc.com>
 <4dede8d5-e665-1cf4-ea27-b2ba99f820e2@linaro.org>
From:   Anusha Canchi <quic_anusha@quicinc.com>
In-Reply-To: <4dede8d5-e665-1cf4-ea27-b2ba99f820e2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z8hrxytxiASmqE1drnaNzbIUwjdGA228
X-Proofpoint-GUID: Z8hrxytxiASmqE1drnaNzbIUwjdGA228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160115
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2023 4:12 PM, Konrad Dybcio wrote:
>
> On 14.06.2023 10:50, Anusha Rao wrote:
>> Add support for wps buttons on GPIO 37.
>>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> ---
>>   .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 23 +++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
>> index 999902bc70bd..fd5326dc1773 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
>> @@ -8,6 +8,8 @@
>>   
>>   /dts-v1/;
>>   
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>>   #include "ipq9574.dtsi"
>>   
>>   / {
>> @@ -18,6 +20,20 @@
>>   	chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-0 = <&gpio_keys_default>;
>> +		pinctrl-names = "default";
>> +
>> +		button-wps {
>> +			label = "wps";
>> +			linux,code = <KEY_WPS_BUTTON>;
>> +			gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
>> +			linux,input-type = <1>;
> This line is unnecessary, it's set to 'key' by default. With that:
Okay, will address in the next patch.

Thanks,
Anusha
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Konrad
>> +			debounce-interval = <60>;
>> +		};
>> +	};
>>   };
>>   
>>   &blsp1_spi0 {
>> @@ -114,6 +130,13 @@
>>   		drive-strength = <8>;
>>   		bias-disable;
>>   	};
>> +
>> +	gpio_keys_default: gpio-keys-default-state {
>> +		pins = "gpio37";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-up;
>> +	};
>>   };
>>   
>>   &xo_board_clk {

