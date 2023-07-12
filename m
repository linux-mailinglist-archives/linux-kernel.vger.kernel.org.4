Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3547508BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjGLMuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGLMus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:50:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357731739;
        Wed, 12 Jul 2023 05:50:47 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CBOZwL021802;
        Wed, 12 Jul 2023 12:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MSlRrlrkNONpM5Ltq+59x/PksIVcHq4OWeir5J/w6Co=;
 b=or1WzR2csVNn5PKv/lbPhcyuhhiKsfMHCh9nQ+5Tm57fT8yT7jMPXKV4QON67BbvQdyN
 77DwwRUJJ6hQush3Jj6wCAIKGCOs0wu841xAhAL8d1G60CG6XiMfbLVKMoT+XT6Zf+Cr
 2qWGLa+RPigQHhNWhWf2GhVrQLGAFwebuZyKMWf0zYqeszrkXR09HUOgGkmAqAwGUzzz
 OUfNbnRgGpCJH/lnNB3v6zeQTt+fsmrLa56A5JXFfXNSyjG/LB7yB2PTFp/8F5q1y4w/
 9MNyLA9jqb8HrFqizl4Z/0mfAXFu64xJyA+ekHrxZ8vnh1tbWEVSkYoxZ8mafHohrewr ig== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgar9bq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 12:50:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CCoe6r007232
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 12:50:40 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 05:50:35 -0700
Message-ID: <f4bc9c49-3db8-5ca5-7326-413d823e338d@quicinc.com>
Date:   Wed, 12 Jul 2023 18:20:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
 <20230712113539.4029941-5-quic_ipkumar@quicinc.com>
 <a33368ef-f68c-d7ee-922a-8896a5d1f158@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <a33368ef-f68c-d7ee-922a-8896a5d1f158@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -IZUWQt9wmgEKBND0MxlwCH5f8NTpsqs
X-Proofpoint-ORIG-GUID: -IZUWQt9wmgEKBND0MxlwCH5f8NTpsqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120115
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/2023 5:55 PM, Dmitry Baryshkov wrote:
> On 12/07/2023 14:35, Praveenkumar I wrote:
>> This patch adds thermal zone nodes for sensors present in
>> IPQ5332.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>> [v2]:
>>     Added passive trips and alignment change.
>>
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 78 +++++++++++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index 0eef77e36609..a1f59af97ee8 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -480,4 +480,82 @@ timer {
>>                    <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>>                    <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>;
>>       };
>> +
>> +    thermal-zones {
>> +        rfa-0-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 11>;
>> +
>> +            trips {
>> +                rfa-0-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        rfa-1-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 12>;
>> +
>> +            trips {
>> +                rfa-1-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        misc-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 13>;
>> +
>> +            trips {
>> +                misc-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        cpu-top-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 14>;
>> +
>> +            trips {
>> +                cpu-top-critical {
>> +                    temperature = <115000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +
>> +                cpu-passive {
>> +                    temperature = <105000>;
>> +                    hysteresis = <1000>;
>> +                    type = "passive";
>
> cooling device for this trip point?

CPU Frequency scaling support is not yet added for IPQ5332. Planning to 
add the cooling device after that in next set of patches.

- Praveenkumar

>
>> +                };
>> +            };
>> +        };
>> +
>> +        top-glue-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 15>;
>> +
>> +            trips {
>> +                top-glue-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +    };
>>   };
>
