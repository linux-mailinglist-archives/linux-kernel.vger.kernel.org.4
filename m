Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE21974D83C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGJNzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJNzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:55:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF0BD2;
        Mon, 10 Jul 2023 06:55:10 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ADPucq026574;
        Mon, 10 Jul 2023 13:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=whUwVB7INIWJNXg+OG8YCm4ASRp/lBqDVjOAb8dV+KY=;
 b=gynTmW7cezZV7+q+Mc/Rr3Q0sCRPndMs8M82x6Yi3ZzTdkixGhXMN3plN5Z1OT9q6hN7
 PGIEK0Crmo+lpRA+aFlChKY78vF/hYu7T4+k4ObskHSQeuyY/yncUYg90VzMuNLbnWrc
 Xyyc1hK4du6YTzFymOPrrLGtkRIZ5oThlNg81ZlvLWGcq7HZtpOvaGp/XD/ygg3A8YOL
 veIbXWPvDTxddTuiLF2cVc4+vesrPLLL8CPfUMmBfRynocQ6Q9Z1aO/Iecg0TTzVZMUv
 1kcuoGfpeD9TUOMcYM6sbmuhSHENPy2FzpA8dOPJ7VDtGubHsdinchZ+JjbjJ8xUiaVP QQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rrf5mgtcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 13:55:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36ADt4vv027070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 13:55:04 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 06:54:59 -0700
Message-ID: <6c2ac08b-c36a-510a-944c-26baffe74b9d@quicinc.com>
Date:   Mon, 10 Jul 2023 19:24:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Content-Language: en-US
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-6-quic_ipkumar@quicinc.com>
 <3f6ab4b4-b5f5-5807-0cb4-8ae782bd6044@linaro.org>
 <b1346bc7-4bf0-e885-c3d4-6fac01516bf4@linaro.org>
 <01149ed4-8a8c-e0e0-d140-1f17a1f0c1fd@quicinc.com>
In-Reply-To: <01149ed4-8a8c-e0e0-d140-1f17a1f0c1fd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rPBxY3TrhAXrbiFmTRmkA1vO92Lmy5f9
X-Proofpoint-ORIG-GUID: rPBxY3TrhAXrbiFmTRmkA1vO92Lmy5f9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100125
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/10/2023 7:04 PM, Praveenkumar I wrote:
>
> On 7/10/2023 5:44 PM, Konrad Dybcio wrote:
>> On 10.07.2023 13:23, Dmitry Baryshkov wrote:
>>> On 10/07/2023 13:37, Praveenkumar I wrote:
>>>> This patch adds thermal zone nodes for sensors present in
>>>> IPQ5332.
>>>>
>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/ipq5332.dtsi | 72 
>>>> +++++++++++++++++++++++++++
>>>>    1 file changed, 72 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi 
>>>> b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>>> index a1e3527178c0..8b276aeca53e 100644
>>>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>>> @@ -527,4 +527,76 @@ timer {
>>>>                     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | 
>>>> IRQ_TYPE_LEVEL_LOW)>,
>>>>                     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | 
>>>> IRQ_TYPE_LEVEL_LOW)>;
>>>>        };
>>>> +
>>>> +    thermal-zones {
>>>> +        rfa-0-thermal{
>> thermal {
> In all other DTS, name is 'thermal-zones". Hence followed the same.
Sorry, understood now. Will give space after "rfa-0-thermal"
>>
>>>> +            polling-delay-passive = <0>;
>>>> +            polling-delay = <0>;
>>>> +            thermal-sensors = <&tsens 11>;
>>>> +
>>>> +            trips {
>> Indentation seems off, tab size for kernel code is 8 spaces.
> Sure, will check the indent and update in next patch.
>>
>> Konrad
>>>> +                rfa-0-critical {
>>>> +                    temperature = <125000>;
>>>> +                    hysteresis = <1000>;
>>>> +                    type = "critical";
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +
>>>> +        rfa-1-thermal {
>>>> +            polling-delay-passive = <0>;
>>>> +            polling-delay = <0>;
>>>> +            thermal-sensors = <&tsens 12>;
>>>> +
>>>> +            trips {
>>>> +                rfa-1-critical {
>>>> +                    temperature = <125000>;
>>>> +                    hysteresis = <1000>;
>>>> +                    type = "critical";
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +
>>>> +        misc-thermal {
>>>> +            polling-delay-passive = <0>;
>>>> +            polling-delay = <0>;
>>>> +            thermal-sensors = <&tsens 13>;
>>>> +
>>>> +            trips {
>>>> +                misc-critical {
>>>> +                    temperature = <125000>;
>>>> +                    hysteresis = <1000>;
>>>> +                    type = "critical";
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +
>>>> +        cpu-top-thermal {
>>>> +            polling-delay-passive = <0>;
>>>> +            polling-delay = <0>;
>>>> +            thermal-sensors = <&tsens 14>;
>>>> +
>>>> +            trips {
>>>> +                cpu-top-critical {
>>>> +                    temperature = <125000>;
>>>> +                    hysteresis = <1000>;
>>>> +                    type = "critical";
>>>> +                };
>>>> +            };
>>> Could you please add a passive cooling devices for the CPU?
>>>
>>>> +        };
>>>> +
>>>> +        top-glue-thermal {
>>>> +            polling-delay-passive = <0>;
>>>> +            polling-delay = <0>;
>>>> +            thermal-sensors = <&tsens 15>;
>>>> +
>>>> +            trips {
>>>> +                top-glue-critical {
>>>> +                    temperature = <125000>;
>>>> +                    hysteresis = <1000>;
>>>> +                    type = "critical";
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +    };
>>>>    };
> -- 
> Thanks,
> Praveenkumar
