Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360F96AD7BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCGGza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCGGz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:55:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD4E80E22;
        Mon,  6 Mar 2023 22:55:25 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3272qbnm012056;
        Tue, 7 Mar 2023 06:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6qyG8W66Fue/dlI7Zw9rSFpro2Vquj/791dofXZi4jY=;
 b=kfmSUZ/wzqLBnSpk87jdaK97tdlkAxW2VM0Ke794GDEeJJfXWRKOFJtMHK7ht/RryCuf
 +3wffB7JsX8mTs/b5TcTpTgiwVk5/uT2Gvr/6dqLB04aoP4ZHrZbge53kyXX7iPMixzI
 NfEzB3h2Xt/H8Rq6GsaE5u1eBVeM6BlJQpGzAjAYIepke/E3jWVlqnJzw7Fv6M4Kk+DY
 FdKacPlknlt0fO+Y3QIWrG9bnBDARcihCiF7A0K/1Iv48OsK8qbLbl93ZjsMN0Ru88RG
 qXn2xLz1W//NYt3mD4/+z2a6ewXWYMRk5xZ2yVVvfrzc7l5MlYIf5mxd6DQg/JM2J3kD Cw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5usx0pa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 06:55:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3276tHZ1032531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 06:55:18 GMT
Received: from [10.216.11.93] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 22:55:12 -0800
Message-ID: <751e5129-3c11-0156-719e-3fe996a149be@quicinc.com>
Date:   Tue, 7 Mar 2023 12:25:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Devi Priya <quic_devipriy@quicinc.com>
Subject: Re: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the
 bootup voltage
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
 <20230217142030.16012-5-quic_devipriy@quicinc.com>
 <907628d1-b88d-5ac6-ed9d-7f63e2875738@linaro.org>
 <Y/aeu5ua7cY5cGON@sirena.org.uk>
 <39f73580-f263-de0e-6819-89c3f4c75c3a@quicinc.com>
 <8ce07abd-2d02-69d2-8dc6-fe11525aecda@linaro.org>
 <11b05b9f-b969-6648-2204-2da5f8465c96@quicinc.com>
Content-Language: en-US
In-Reply-To: <11b05b9f-b969-6648-2204-2da5f8465c96@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N850cjBQg4iZRhnlJHKtCfuPrcCiZdeV
X-Proofpoint-GUID: N850cjBQg4iZRhnlJHKtCfuPrcCiZdeV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_02,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/2023 6:39 PM, Devi Priya wrote:
> 
> 
> On 3/3/2023 6:57 PM, Konrad Dybcio wrote:
>>
>>
>> On 3.03.2023 14:21, Devi Priya wrote:
>>>
>>>
>>> On 2/23/2023 4:31 AM, Mark Brown wrote:
>>>> On Wed, Feb 22, 2023 at 11:11:42PM +0100, Konrad Dybcio wrote:
>>>>
>>>>> Thinking about it again, this seems like something that could be
>>>>> generalized and introduced into regulator core.. Hardcoding this
>>>>> will not end well.. Not to mention it'll affect all mp5496-using
>>>>> boards that are already upstream.
>>>>
>>>>> WDYT about regulator-init-microvolts Mark?
>>>>
>>>> The overwhelming majority of devices that have variable voltages
>>>> support readback, these Qualcomm firmware devices are pretty much
>>>> unique in this regard.  We don't want a general property to set a
>>>> specific voltage since normally we should be using the
>>>> constraints and don't normally need to adjust things immediately
>>>> since we can tell what the current voltage is.
>>>>
>>>> This is pretty much just going to be a device specific bodge,
>>>> ideally something that does know what the voltage is would be
>>>> able to tell us at runtime but if that's not possible then
>>>> there's no good options.  If the initial voltage might vary based
>>>> on board then a device specific DT property might be less
>>>> terrible, if it's determined by the regulator the current code
>>>> seems fine.  Or just leave the current behavour, if the
>>>> constraints are accurate then hopefully a temporary dip in
>>>> voltage is just inelegant rather than an issue.  Indeed the
>>>> current behaviour might well save power if you've got a voltage
>>>> range configured and nothing actually ever gets round to setting
>>>> the voltage (which is depressingly common, people seem keen on
>>>> setting voltage ranges even when the voltage is never varied in
>>>> practice).
>>>
>>> Hi Mark, The initial bootup voltage is actually blown into the OTP 
>>> register of the PMIC and it remains the same across boards for 
>>> IPQ9574 SoC.
>> But what about IPQ6018 which also uses MP5496? That's also gonna
>> set the voltage on there, it may be too high/low..
For IPQ6018, the bootup voltage is the same as that of IPQ9574 which is
875mV
>>
>>   Initially the SoC runs at 800MHz with a voltage of 875mV set by the 
>> bootloaders. As kernel does not know the initial voltage, during 
>> regulator registration the framework considers the current voltage to 
>> be zero and tries to bring up the regulator to minimum supported 
>> voltage of 600mV. This causes the dip which might be of concern in SS 
>> parts where the voltage might be insufficient leading to silent reboots.
>> That's an SoC-specific thing, the same regulator can be used with
>> many different ones. We can't just assume it'll always be like this.
>> I see the problem, but I believe this is not the correct solution
Okay, As we had discussions on reading back the voltage & the generic
DT property, do you suggest any other possible solutions here?
>>
>> Konrad
>>>
>>> Best Regards,
>>> Devi Priya
