Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036297482DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjGELVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGELVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:21:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516631996;
        Wed,  5 Jul 2023 04:20:36 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3658dRFG016367;
        Wed, 5 Jul 2023 11:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KcOexi0Vm5W4JbwHJG0UH3/06wW8o2L6Y2Xo4Fh42Ok=;
 b=Oc2Nzcp+jqISN5auqULXdAHC+BnOzhn5miyvXhxFQjg9pzo4jjoKPBDbgFWbaO5pJckq
 Zbgshcc1JKPgx9lCKgjcrq6sf1ldRpie3XmlSOVR1K/FCVKD5yoKTMeYJvm/HtbXuEe0
 udLIucCcdv4j2SmXDyskrO6BCtZNG/WWmgXarErTbMAm3301X5RhTDAqZt7LKyQfucqK
 zA2FcxoCtAPsQbUEWoKX4AraoE78R6NVw3ARasffHosBR29qMXkhioq/OhGC2gSSoO1l
 qgO5PE+2wky0lLiwL5voo4/LM6/SWfOf+tmEiFVvGGql5kly+yPSxuJOB+e6KBxsPONP fg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2cp8knh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:20:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 365BKTn1010550
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 11:20:29 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 5 Jul
 2023 04:20:24 -0700
Message-ID: <17dc53d0-2f30-1d54-ccbe-d829a681ad06@quicinc.com>
Date:   Wed, 5 Jul 2023 16:50:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 02/10] dt-bindings: power: Add rpm power domains for SDX75
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <sboyd@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688395346-3126-3-git-send-email-quic_rohiagar@quicinc.com>
 <0d468d08-6410-e424-b4f3-5245cdb0334a@linaro.org>
 <85456057-c4ef-68a6-4fc5-c9fd03b01b71@quicinc.com>
 <06506ed7-f861-0bca-8b87-e2da6a6bc789@quicinc.com>
 <553bd028-aaf3-b128-ae4c-7f938c23e889@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <553bd028-aaf3-b128-ae4c-7f938c23e889@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V_BG9uQ6c6RhpPFu5K3vUkLH-8H6W2Nt
X-Proofpoint-ORIG-GUID: V_BG9uQ6c6RhpPFu5K3vUkLH-8H6W2Nt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_02,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=644
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050100
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/5/2023 4:13 PM, Konrad Dybcio wrote:
> On 5.07.2023 10:54, Rohit Agarwal wrote:
>> On 7/4/2023 11:47 AM, Rohit Agarwal wrote:
>>> On 7/3/2023 8:29 PM, Konrad Dybcio wrote:
>>>> On 3.07.2023 16:42, Rohit Agarwal wrote:
>>>>> Add RPM power domain bindings for the SDX75 SoC.
>>>>>
>>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>>>>>    include/dt-bindings/power/qcom-rpmpd.h                  | 8 ++++++++
>>>>>    2 files changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>>>> index afad313..58e1be8 100644
>>>>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>>>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>>>> @@ -40,6 +40,7 @@ properties:
>>>>>          - qcom,sdm845-rpmhpd
>>>>>          - qcom,sdx55-rpmhpd
>>>>>          - qcom,sdx65-rpmhpd
>>>>> +      - qcom,sdx75-rpmhpd
>>>>>          - qcom,sm6115-rpmpd
>>>>>          - qcom,sm6125-rpmpd
>>>>>          - qcom,sm6350-rpmhpd
>>>>> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
>>>>> index 1bf8e87..8092d0d 100644
>>>>> --- a/include/dt-bindings/power/qcom-rpmpd.h
>>>>> +++ b/include/dt-bindings/power/qcom-rpmpd.h
>>>>> @@ -57,6 +57,14 @@
>>>>>    #define SDX65_CX_AO    4
>>>>>    #define SDX65_MXC    5
>>>>>    +/* SDX75 Power Domain Indexes */
>>>>> +#define SDX75_CX    0
>>>>> +#define SDX75_CX_AO    1
>>>>> +#define SDX75_MSS    2
>>>>> +#define SDX75_MX    3
>>>>> +#define SDX75_MX_AO    4
>>>>> +#define SDX75_MXC    5
>>>> Please instead introduce a set of defines without the SoC prefix
>>>> (i.e. CX, CX_AO, MX etc.). We've been putting this off for too long
>>>> and you're the first unlucky guy that submitted new RPMhPD support after
>>>> we've concluded it'd be the way to go! :D Sadly, we can't replace the
>>>> existing ones retroactively..
>>> Surely No issues. Will update it.
>> I have a doubt here. Cant we completely omit the #defines here and directly index this as 0,1,...
>> because if the intention of this #defines is to understand the name of the pd then we can get
>> it from the .name attribute in rpmhpd as well, right?
>>
>> The problems with a common set of #define would be, lets say if we define CX_AO as 1 and some platform
>> doesn't have CX_AO then wouldnt it leave a null entry in the driver entry of that platform?
> Yes.
>
> We already do this in the rpmh clock driver, as:
>
> 1. there are domains that all chips share (like CX etc.)
> 2. wasting a couple of bytes lets us massively save on convolution
Ok, got it. Looks cleaner.

Thanks,
Rohit.
>
> Konrad
>> Thanks,
>> Rohit.
>>
>>> Thanks,
>>> Rohit.
>>>> Konrad
>>>>> +
>>>>>    /* SM6350 Power Domain Indexes */
>>>>>    #define SM6350_CX    0
>>>>>    #define SM6350_GFX    1
