Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A723272FD99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbjFNL4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbjFNL4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:56:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F452122;
        Wed, 14 Jun 2023 04:56:24 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EAkA8c001433;
        Wed, 14 Jun 2023 11:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lGvKgI0vmHHE67M00EyD0hJsM7VocyVHE9KVPqBmkP8=;
 b=bpdTxDbjpev2zRy+rhxfe/HqffHqGTEiv9zJM8bHw4xanZ0ovBVHnszFHpafD9bEAErL
 WxY2HVWLhFaRow0vTNMrDdfSS9tfJPJdg+61DCRhFeHi/qgU0iVJfQXxhK9qUSTvV/F3
 5CSjM32tTK75Gk5F0tihJDZloNXIM3lOJo+Xm2oAB5Xl2aAEQrjYevhwuWgci/73o4QJ
 t6ZAV3jULvHcCWZewuYcDKMqcgCFQIATt1wdb6VnQDzAJmtS0U69uSbDmAxDDx9YUWB4
 +OqD4rgxKAXze4yBLdTiwot/HswwpO7Rv1cJ6rmsVB43IXaTzukmmS96BR6Wmb1u3rcq uQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6s3wtpqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:56:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EBuIL6013343
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:56:18 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 04:56:13 -0700
Message-ID: <a3652f67-3e48-db33-1dd2-c17abdbdae41@quicinc.com>
Date:   Wed, 14 Jun 2023 17:26:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V4 4/4] arm64: dts: qcom: sm8550: Add camera clock
 controller
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230609115058.9059-1-quic_jkona@quicinc.com>
 <20230609115058.9059-5-quic_jkona@quicinc.com>
 <8d1ead23-8361-7943-baba-baf20d16cbe5@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <8d1ead23-8361-7943-baba-baf20d16cbe5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wfffZtK1VCpBnwTJuIfFBGtlvMEmyrk3
X-Proofpoint-GUID: wfffZtK1VCpBnwTJuIfFBGtlvMEmyrk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_08,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140102
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2023 6:22 PM, Konrad Dybcio wrote:
> 
> 
> On 9.06.2023 13:50, Jagadeesh Kona wrote:
>> Add device node for camera clock controller on Qualcomm
>> SM8550 platform.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>> Changes since V3:
>>   - No changes
>> Changes since V2:
>>   - No changes
>> Changes since V1:
>>   - Padded non-zero address part to 8 hex digits
>>
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index 75cd374943eb..4d2d610fc66a 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -5,6 +5,7 @@
>>   
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>   #include <dt-bindings/clock/qcom,sm8450-videocc.h>
>> +#include <dt-bindings/clock/qcom,sm8550-camcc.h>
>>   #include <dt-bindings/clock/qcom,sm8550-gcc.h>
>>   #include <dt-bindings/clock/qcom,sm8550-gpucc.h>
>>   #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
>> @@ -2419,6 +2420,20 @@ videocc: clock-controller@aaf0000 {
>>   			#power-domain-cells = <1>;
>>   		};
>>   
>> +		camcc: clock-controller@ade0000 {
>> +			compatible = "qcom,sm8550-camcc";
>> +			reg = <0 0x0ade0000 0 0x20000>;
>> +			clocks = <&gcc GCC_CAMERA_AHB_CLK>,
>> +				 <&bi_tcxo_div2>,
>> +				 <&bi_tcxo_ao_div2>,
>> +				 <&sleep_clk>;
>> +			power-domains = <&rpmhpd SM8550_MMCX>;
> I see that both MMCX ("mmcx.lvl") and MXC ("mxc.lvl") (and MX, FWIW)
> are consumed on msm-5.15, with the latter one powering camcc PLLs..
> 
> How are they related? Is that resolved internally or does it need
> manual intervention?
> 
> Konrad

These are just different voltage rails, camcc clocks are powered by MMCX 
rail and camcc pll's are powered by MXC rail. Consumer drivers need to 
take care of voting on these rails properly based on the frequency of 
clocks requested.

Thanks,
Jagadeesh

>> +			required-opps = <&rpmhpd_opp_low_svs>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +		};
>> +
>>   		mdss: display-subsystem@ae00000 {
>>   			compatible = "qcom,sm8550-mdss";
>>   			reg = <0 0x0ae00000 0 0x1000>;
