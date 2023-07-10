Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4374D799
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGJNbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjGJNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:31:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C4E9;
        Mon, 10 Jul 2023 06:31:14 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A8W9hm014016;
        Mon, 10 Jul 2023 13:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3hwh85pHwsS6x8LnhvlF7324O3jhtNQ7GklRf9cJmts=;
 b=jk/i9G8b5wwlSu0eDSmbmCoNul/VM00OGI99LDi1b4rQoUg+w3P2dB/4a859qvS2kTV/
 YBVB1aS9JcMH7cVPzvuVdVUv3QIYsL/48VDN235x2dF9oMv2ton64dkQ0cCdnOe6ocwa
 0vzFmjsgHZcYuOPsef6ox7ELg7G5Z0UEvqBN+3a872j4EeE4hC+0j3xN+vBBNlnFgd3/
 oYBQaWL/zuiRmv0G3eW6A5pldUEIH8wWYg1B8ptUOo0Q86eam7PbUkDPnbHcfbztpS3t
 SyZUYyS6sGfRWG+4ekG1hsjSnRhzq2A4zseC13cOwXghoJnsn9riXY3PPa5+YBkXhBnC SQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpyd6usyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 13:31:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36ADV63K016422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 13:31:06 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 06:31:01 -0700
Message-ID: <bcd02a91-e7c0-a104-f19c-50b26c86e484@quicinc.com>
Date:   Mon, 10 Jul 2023 19:00:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
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
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <3f6ab4b4-b5f5-5807-0cb4-8ae782bd6044@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OkdKxaFWYqvEpGt7AnvdKcADRr11QWNx
X-Proofpoint-ORIG-GUID: OkdKxaFWYqvEpGt7AnvdKcADRr11QWNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100121
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/10/2023 4:53 PM, Dmitry Baryshkov wrote:
> On 10/07/2023 13:37, Praveenkumar I wrote:
>> This patch adds thermal zone nodes for sensors present in
>> IPQ5332.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 72 +++++++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index a1e3527178c0..8b276aeca53e 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -527,4 +527,76 @@ timer {
>>                    <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>>                    <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>;
>>       };
>> +
>> +    thermal-zones {
>> +        rfa-0-thermal{
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
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>
> Could you please add a passive cooling devices for the CPU?
Sure, will add the passive trip.
>
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
--
Thanks,
Praveenkumar
