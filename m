Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B4F74602E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGCP4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjGCP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:56:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789FFC2;
        Mon,  3 Jul 2023 08:56:02 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363FUOcM031763;
        Mon, 3 Jul 2023 15:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Av3lLX3sN6J40Wcfq3svRclc16LCWMFV9nEGD6f8Qe0=;
 b=kGTndyVbxANG6Spl3MkoMp0oNspAr3+qYh2cfrkwOOYe4hiOQ0HttwrtX0/AeLSCG7zq
 Mx3jTa9vJjGaDkoa7EY3fh7huiK1967IQff9OExKNuSPY+VxyAFPwYaVL0uHxH2qrlrm
 6zCT0DtPE1CmrD6PjeGC6qFIopz8Sj6MgFMEF+HQqCHKdsX2IqL5SowyKeg55MS88hxL
 VqgPIQFSG23yhGYMkKe2gMXlJTKYio1mNbgqfXYXR85fNC9b8DJaKpCXP/rDQmGs0FNH
 A2Ah+HMkRFx+rY7pHvJQN750LJ/rYCq8xoETrvkAaK4ukA/OjWRzzfZv8fS8VMafPaDt og== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rky5mgamw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 15:55:36 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 363FtZGq021971
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Jul 2023 15:55:35 GMT
Received: from [10.216.56.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Jul 2023
 08:55:25 -0700
Message-ID: <ba04bb7b-6599-6f41-09a8-834ee280830d@quicinc.com>
Date:   Mon, 3 Jul 2023 21:25:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 08/21] dt-bindings: reserved-memory: Add qcom,ramoops
 binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-9-git-send-email-quic_mojha@quicinc.com>
 <CAL_JsqJ_TTnGjjB2d8_FKHpWBRG5GHLoWnabCKjsdeZ4QFdNEg@mail.gmail.com>
 <cacbbb02-732e-076e-50bf-292d20a4d722@quicinc.com>
 <58a26b9e-a48d-d567-c310-193a2c52521e@linaro.org>
 <5447f9f8-55b4-8bed-66a6-1c9d62b02c79@quicinc.com>
 <CAGE=qrq0CuO4J-6yC=YZ4xjL67o9QTqpei0ovX-X_8MLVeEH6g@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAGE=qrq0CuO4J-6yC=YZ4xjL67o9QTqpei0ovX-X_8MLVeEH6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Db2EPXBzIBt9vTeo1n-9ktIyz-gVCL0o
X-Proofpoint-GUID: Db2EPXBzIBt9vTeo1n-9ktIyz-gVCL0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030145
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/2023 12:50 PM, Krzysztof Kozlowski wrote:
> On Mon, 3 Jul 2023 at 08:22, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>> On 7/2/2023 1:42 PM, Krzysztof Kozlowski wrote:
>>>>> The big difference is if firmware is not deciding where this log
>>>>> lives, then it doesn't need to be in DT. How does anything except the
>>>>> kernel that allocates the log find the logs?
>>>>
>>>> Yes, you are correct, firmware is not deciding where the logs lives
>>>> instead here, Kernel has reserved the region where the ramoops region
>>>> lives and later with the minidump registration where, physical
>>>> address/size/virtual address(for parsing) are passed and that is how
>>>> firmware is able to know and dump those region before triggering system
>>>> reset.
>>>
>>> Your explanation does not justify storing all this in DT. Kernel can
>>> allocate any memory it wishes, store there logs and pass the address to
>>> the firmware. That's it, no need for DT.
>>
>> If you go through the driver, you will know that what it does, is
> 
> We talk about bindings and I should not be forced to look at the
> driver to be able to understand them. Bindings should stand on their
> own.

Why can't ramoops binding have one more feature where it can add a flag 
*dynamic* to indicate the regions are dynamic and it is for platforms
where there is another entity 'minidump' who is interested in these
regions.

> 
>> just create platform device for actual ramoops driver to probe and to
> 
> Not really justification for Devicetree anyway. Whatever your driver
> is doing, is driver's business, not bindings.
> 
>> provide this it needs exact set of parameters of input what original
>> ramoops DT provides, we need to keep it in DT as maintaining this in
>> driver will not scale well with different size/parameter size
>> requirement for different targets.
> 
> Really? Why? I don't see a problem in scaling. At all.

I had attempted it here,

https://lore.kernel.org/lkml/1683133352-10046-10-git-send-email-quic_mojha@quicinc.com/

but got comments related to hard coding and some in favor of having
the same set of properties what ramoops has/provides

https://lore.kernel.org/lkml/e25723bf-be85-b458-a84c-1a45392683bb@gmail.com/

https://lore.kernel.org/lkml/202305161347.80204C1A0E@keescook/
> 
>>
>>>
>>>>
>>>> A part of this registration code you can find in 11/21
>>>>
>>>>> I'm pretty sure I already said all this before.
>>>>
>>>> Yes, you said this before but that's the reason i came up with vendor
>>>> ramoops instead of changing traditional ramoops binding.
>>>
>>> That's unexpected conclusion. Adding more bindings is not the answer to
>>> comment that it should not be in the DTS in the first place.
>>
>> Please suggest, what is the other way being above text as requirement..
> 
> I do not see any requirement for us there. Forcing me to figure out
> how to add non-hardware property to DT is not the way to convince
> reviewers. But if you insist - we have ABI for this, called sysfs. If
> it is debugging feature, then debugfs.

ramoops already support module params and a way to pass these parameters
from bootargs but it also need to know the hard-codes addresses, so, 
doing something in sysfs will be again duplication with ramoops driver..

If this can be accommodated under ramoops, this will be very small 
change, like this

https://lore.kernel.org/lkml/20230622005213.458236-1-isaacmanjarres@google.com/

-- Mukesh
> 
> Best regards,
> Krzysztof
