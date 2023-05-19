Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7C7096E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjESL4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjESL4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:56:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CFEE56;
        Fri, 19 May 2023 04:56:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JBlPiB022113;
        Fri, 19 May 2023 11:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GX9fAx12QWDHgXQjrSIFZn7Fh89w+4jdm1+9nKC5CDI=;
 b=j87dn2onmvQg7l9+E+Kk1Cwo3IzM0++FIFkDUx+sBBAefQOxq1nF+ScwiF98ood5Fr65
 EOtU5otHsNac4Xr6cUTMxH3vwls8L50utijVvaPTteJ3ONqEXXG68E0FWlT/U6CCtLrw
 0qMY5L/YpSvB4oJ4SV9ABWu4LqTJzxQZcYBehpQfN59i9CY5rY5yLAvB781zLfR8PVsS
 gqajKJZzkiN0fmcpY2N5BDSm8Sy/KU9zR26U3l1vsd1xrPJsUoyTpqzJlL1n4gv5t8SG
 eZjBjCq36LV9cr+rVcat5Kxq7LclUtM7NuVy3TsAr8KQRfdJnb7vLads9cZX284kxctN MA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp4ccrhcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:56:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JBu1nN003860
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:56:01 GMT
Received: from [10.217.216.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 04:55:57 -0700
Message-ID: <8836be9f-e357-14f8-16ac-92177706e7e7@quicinc.com>
Date:   Fri, 19 May 2023 17:25:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8550: Add video clock controller
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230509161218.11979-1-quic_jkona@quicinc.com>
 <20230509161218.11979-5-quic_jkona@quicinc.com>
 <7faf4c16-98ff-f27d-d1fd-3058370c06f5@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <7faf4c16-98ff-f27d-d1fd-3058370c06f5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JGW5G8RsxYdGfu40jfSiRUT9tDTZlLdP
X-Proofpoint-ORIG-GUID: JGW5G8RsxYdGfu40jfSiRUT9tDTZlLdP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=994 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190101
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks Konrad for your review!

On 5/15/2023 5:58 PM, Konrad Dybcio wrote:
> 
> 
> On 9.05.2023 18:12, Jagadeesh Kona wrote:
>> Add device node for video clock controller on Qualcomm SM8550 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index 6e9bad8f6f33..e67e7c69dae6 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -7,6 +7,7 @@
>>   #include <dt-bindings/clock/qcom,sm8550-gcc.h>
>>   #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
>>   #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
>> +#include <dt-bindings/clock/qcom,sm8550-videocc.h>
>>   #include <dt-bindings/dma/qcom-gpi.h>
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>> @@ -759,6 +760,17 @@ gcc: clock-controller@100000 {
>>   				 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>>   		};
>>   
>> +		videocc: clock-controller@aaf0000 {
> This node should be moved down. Nodes with unit addresses
> should be sorted alphanumerically.
> 
Sure, will update in the next series.

>> +			compatible = "qcom,sm8550-videocc";
>> +			reg = <0 0x0aaf0000 0 0x10000>;
>> +			clocks = <&bi_tcxo_div2>, <&gcc GCC_VIDEO_AHB_CLK>;
> One per line, please
> 
Okay

> Also, any reason the XO clock does not come from RPMhCC?
> 
> Konrad
>> +			power-domains = <&rpmhpd SM8550_MMCX>;
>> +			required-opps = <&rpmhpd_opp_low_svs>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +		};
>> +
>>   		ipcc: mailbox@408000 {
>>   			compatible = "qcom,sm8550-ipcc", "qcom,ipcc";
>>   			reg = <0 0x00408000 0 0x1000>;

Thanks & Regards,
Jagadeesh
