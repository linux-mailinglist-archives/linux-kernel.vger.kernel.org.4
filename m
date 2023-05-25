Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3B71115B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjEYQwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:52:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDB183;
        Thu, 25 May 2023 09:52:16 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PFADEJ023020;
        Thu, 25 May 2023 16:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rEOZjTCbEveyPPxwTpzB7ykcc97gLlUlUbyicAo//Ww=;
 b=nvWSgQYEEGYsXvElhfFOHSru5QyRNGggToIrmaz5WWsyARt1HW/zxH5U3bICIuj1ySgr
 3JqvRR0xjf1QeMtMUpqXRa4MZse7dZehYVohW/i0x2oEf9rQ6mTLAZpuQbfkz8B2VGrF
 MXHAJORDJA+T/V8CDeoet5NjMlBokvbq1AH6wiMeg/qD6kG5Rz1dFFww4eZxoYiJRqxf
 2/4YEI374k2ipW7jPVBN1+AgOzQEw4kLSW3GEQjkk70oCL1cq9mMJc4wZzi4vkhjPg7G
 qkzkRDAAqTHVhjfYoJruI2AGzZDyIYmsiQ2gKfOAEL5uJ4xox4pNWQBtyxjCCdUpJAQu tw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt02a9kqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:52:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PGqBbM019664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:52:12 GMT
Received: from [10.216.52.104] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 09:52:05 -0700
Message-ID: <46b4a123-af3d-0605-f3ef-1fd6db1d5d1a@quicinc.com>
Date:   Thu, 25 May 2023 22:22:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8550: Add camera clock controller
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        <quic_imrashai@quicinc.com>, <quic_ajipan@quicinc.com>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
 <20230519155602.6642-5-quic_jkona@quicinc.com>
 <634c80b4-5007-4f66-9114-1dedf3c95f1f@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <634c80b4-5007-4f66-9114-1dedf3c95f1f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GFvbzxS7s2KFfo8YZUbiWUs_hrp24bIE
X-Proofpoint-ORIG-GUID: GFvbzxS7s2KFfo8YZUbiWUs_hrp24bIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_09,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250140
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for your review!

On 5/19/2023 10:22 PM, Konrad Dybcio wrote:
> 
> 
> On 19.05.2023 17:56, Jagadeesh Kona wrote:
>> Add device node for camera clock controller on Qualcomm
>> SM8550 platform.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index e67e7c69dae6..ac82d3774ed8 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -4,6 +4,7 @@
>>    */
>>   
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/clock/qcom,sm8550-camcc.h>
>>   #include <dt-bindings/clock/qcom,sm8550-gcc.h>
>>   #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
>>   #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
>> @@ -2397,6 +2398,20 @@ opp-202000000 {
>>   			};
>>   		};
>>   
>> +		camcc: clock-controller@ade0000 {
>> +			compatible = "qcom,sm8550-camcc";
>> +			reg = <0 0xade0000 0 0x20000>;
> Please pad the non-zero address part to 8 hex digits
> 
Will take care of this in next series.

> Konrad
>> +			clocks = <&bi_tcxo_div2>,
>> +				 <&bi_tcxo_ao_div2>,
>> +				 <&sleep_clk>,
>> +				 <&gcc GCC_CAMERA_AHB_CLK>;
>> +			power-domains = <&rpmhpd SM8550_MMCX>;
>> +			required-opps = <&rpmhpd_opp_low_svs>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +		};
>> +
>>   		mdss: display-subsystem@ae00000 {
>>   			compatible = "qcom,sm8550-mdss";
>>   			reg = <0 0x0ae00000 0 0x1000>;

Thanks & Regards,
Jagadeesh
