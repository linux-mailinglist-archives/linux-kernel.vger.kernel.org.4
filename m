Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1714874A0F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjGFP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjGFP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:28:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDA91997;
        Thu,  6 Jul 2023 08:28:46 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366DS67V013756;
        Thu, 6 Jul 2023 15:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UkairyfpuiaeRoJqCuD+B/mkgvE5+Xv+oU/yB+A/dT4=;
 b=kZv97BVjWBgrxx9l30pXJpC1pwzCg+UjTEjgbdN3KN77bnn0YwC5X4RbnN3Jilf70bOL
 Lyl6tVxj7YEOM6JGyiK8KC4dP9DWhdSPZKZed+kD+ctLuluDiEzY5Zd7jhkaOCQRppcx
 nsY65kQkY8GwrdDmwuo8f/PtkyzoSlVSYwajmzssbS+VudUNAbdZmwQW4xbFYR3g2H/E
 wHnfGvklFptLei5mcx+P55aPHZiQZ8lhhYd7HcGSkzCYXUY92hIuCTKvj1RBMA8Rba7u
 V4tvNj7uzZVVU9b6y34tylsJfjsbUIWipVlxSsmkrEg9taA+Xqx2F8BKGM3D2Bkf9h+l eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnb5a2hew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 15:28:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366FSfxJ018530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 15:28:41 GMT
Received: from [10.216.13.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 08:28:37 -0700
Message-ID: <4e865652-1efc-75b1-ed6f-33ec84184d6c@quicinc.com>
Date:   Thu, 6 Jul 2023 20:58:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] dt-bindings: power: rpmpd: Add Generic RPM(h) PD
 indexes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1688647793-20950-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688647793-20950-2-git-send-email-quic_rohiagar@quicinc.com>
 <35b6b086-9b03-49df-b80d-863218b42fae@quicinc.com>
 <a6241054-0f66-53c4-af59-31ceca13bf7c@quicinc.com>
 <b7376555-3ffd-3587-bc91-6c407c43e72e@linaro.org>
 <2d0b3769-ca87-3e18-160d-604c24fac52d@quicinc.com>
 <d9b08d1b-17b2-00ad-6ffb-c1641eb2cb6f@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <d9b08d1b-17b2-00ad-6ffb-c1641eb2cb6f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: auabJ-jfliqTr_Sr-4aFmMy_QDHKH8tl
X-Proofpoint-ORIG-GUID: auabJ-jfliqTr_Sr-4aFmMy_QDHKH8tl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=642
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060139
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/2023 8:52 PM, Konrad Dybcio wrote:
> On 6.07.2023 17:15, Rohit Agarwal wrote:
>> On 7/6/2023 8:30 PM, Konrad Dybcio wrote:
>>> On 6.07.2023 16:47, Rohit Agarwal wrote:
>>>> On 7/6/2023 8:00 PM, Pavan Kondeti wrote:
>>>>> On Thu, Jul 06, 2023 at 06:19:51PM +0530, Rohit Agarwal wrote:
>>>>>> Add Generic RPM(h) Power Domain indexes that can be used
>>>>>> for all the Qualcomm SoC henceforth.
>>>>>>
>>>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>>>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> Does it make sense to give this link [1] so that we know what is
>>>>> Konrad's suggestion and the discussion around it?
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/all/0d468d08-6410-e424-b4f3-5245cdb0334a@linaro.org/
>>>> Yes, could be given in the cover letter.
>>>>>> ---
>>> [...]
>>>
>>>>>> +#define RPMPD_VDDMD        22
>>>>>> +#define RPMPD_VDDMD_AO        23
>>>>>> +#define RPMPD_LPICX_VFL        24
>>>>>> +#define RPMPD_LPIMX_VFL        25
>>>>>> +
>>>>> How did you come up with this list? A union of all SoCs supported by
>>>>> RPMh driver?
>>>> Yes, union of all the SoCs and arranged based on frequencies of usage.
>>> The latter part is very thoughtful, thanks for taking that into account.
>>>
>>> That said (and I really don't wanna be picky here, I'm just coming up with
>>> ideas a bit later than I'd like to).. Perhaps this patch should be limited
>>> to RPMhPD [1] and the definitions could be moved to a new binding, so:
>> So should we not update anything in this old binding and completely move to the new bindings?
> Yes, create qcom,rpmhpd.h and add new common entries there and let this
> ship sink
>
>> rpmhpd.h?
>> Not even rpmpd_* bindings?
> Again, due to [1], let's not touch that for now. We'll worry about that
> when somebody will try to add a new entry to that driver.
Yes.

Thanks,
Rohit.
>
> Konrad
>> Thanks,
>> Rohit.
>>> include/dt-bindings/power/qcom,rpmhpd.h
>>> // this way we don't have to add RPMHPD_
>>> #define CX    0
>> Ok, will remove this as well.
>>> which would result in us being able to do:
>>>
>>> #include ....rpmhpd.h
>>> [...]
>>> power-domains = <&rpmhpd CX>;
>>>
>>> in the device tree
>>>
>>> which is even more concise!
>> Yes
>>
>> Thanks,
>> Rohit.
>>
>>> [1] The old RPM SMD platforms have some duplications in the names..
>>>       No point in duplicating that. The oldest entries remember 2013 so
>>>       it's easy to see how we had some dirt build up there.
>>>
>>> Konrad
>>>> Thanks,
>>>> Rohit.
>>>>>>     /* SA8775P Power Domain Indexes */
>>>>>>     #define SA8775P_CX    0
>>>>>>     #define SA8775P_CX_AO    1
>>>>>> -- 
>>>>>> 2.7.4
>>>>>>
>>>>> Thanks,
>>>>> Pavan
