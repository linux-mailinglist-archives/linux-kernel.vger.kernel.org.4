Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A144F6F6C82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjEDM6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEDM6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:58:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267B0619A;
        Thu,  4 May 2023 05:58:18 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3449ILrK001703;
        Thu, 4 May 2023 12:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J1bg+67OkOUP3/dK1K1LsKhWG0uCqMtDTWZMZgrQfbc=;
 b=Jnd2L3BKOh0hzEf3BHp6OarNMGf67ji3SisnK50NmboWbvZNLNDemWXht0+7/zDtKq+w
 ub5SOCF/iXg13rcImAV+5CzZ68H31uqW5SF4dmqoX5+8jbXqyHkgok3AM4tXVowX5cX4
 Wh9kXPHm43ctsrADpiQbAHHXTyPsDxjgxi2U/Du1YNKaFviiPMRZhbzrPvGMMNbYetNc
 5GQ6IVgDvq6Xz/p6SksudKW1u5Nf7JDrFhRzoczkbuq2D1lbQBEENQdq08FJDfVi2AnZ
 Ir3jyRN3JrHwfmTfSocBFN2VZgqShaDC1o1LExP3i8oM2v4bfcSPZsIu3aF1yEYbNt8H dw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc5041466-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 12:57:58 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 344CvuxW007531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 12:57:56 GMT
Received: from [10.216.46.158] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 4 May 2023
 05:57:48 -0700
Message-ID: <d80868bf-610d-7e79-d279-da704efb38f0@quicinc.com>
Date:   Thu, 4 May 2023 18:27:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 02/18] remoteproc: qcom: Move minidump specific data to
 qcom_minidump.h
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-3-git-send-email-quic_mojha@quicinc.com>
 <fe94ed5c-c444-436d-720a-c96538c1026d@linaro.org>
 <e69862cc-4185-a7a2-07b2-15e331c4678a@quicinc.com>
 <659a9637-f82c-054b-99a8-dc25416c8e13@linaro.org>
 <33ea7c3b-4317-5aff-5e6a-af6e093d45a0@quicinc.com>
 <1a4f4b55-6284-6149-4c7b-7b45fa1de291@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1a4f4b55-6284-6149-4c7b-7b45fa1de291@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9cR2SwDduMYBWJe-GF40DEwl8u4KK33H
X-Proofpoint-ORIG-GUID: 9cR2SwDduMYBWJe-GF40DEwl8u4KK33H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_08,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=1 priorityscore=1501 mlxlogscore=222 mlxscore=1 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040106
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2023 6:06 PM, Krzysztof Kozlowski wrote:
> On 04/05/2023 14:26, Mukesh Ojha wrote:
>>
>>
>> On 5/4/2023 5:33 PM, Krzysztof Kozlowski wrote:
>>> On 04/05/2023 13:58, Mukesh Ojha wrote:
>>>>
>>>>
>>>> On 5/4/2023 5:08 PM, Krzysztof Kozlowski wrote:
>>>>> On 03/05/2023 19:02, Mukesh Ojha wrote:
>>>>>> Move minidump specific data types and macros to a separate internal
>>>>>> header(qcom_minidump.h) so that it can be shared among different
>>>>>> Qualcomm drivers.
>>>>>
>>>>> No, this is not internal header. You moved it to global header.
>>>>>
>>>>> There is no reason driver internals should be exposed to other unrelated
>>>>> subsystems.
>>>>>
>>>>>>
>>>>>> There is no change in functional behavior after this.
>>>>>
>>>>> It is. You made all these internal symbols available to others.
>>>>>
>>>>>>
>>>>>
>>>>> This comes without justification why other drivers needs to access
>>>>> private and internal data. It does not look correct design. NAK.
>>>>
>>>> Thanks for catching outdated commit text, will fix the commit with
>>>> more descriptive reasoning.
>>>>
>>>> It has to be global so that co-processor minidump and apss minidump can
>>>> share data structure and they are lying in different directory.
>>>>
>>>
>>> Then you should not share all the internals of memory layout but only
>>> few pieces necessary to talk with minidump driver. The minidump driver
>>> should organize everything how it wants.
>>
>> These are core data structure which is shared with boot firmware and the
>> one's are moved here all are required by minidump driver .
> 
> I am not sure if I understand correctly. If they are all required by
> minidump driver, then this must not be in include, but stay with
> minidump. Remoteproc then should not touch it.
> 
> I don't understand why internals of minidump should be important for
> remoteproc. If they are, means you broken encapsulation.
> 
>>
>> If you follow here[1], i raised by concern to make this particular one's
>> as private and later to avoid confusion went with single header.
>> But if others agree, I will keep the one that get shared with minidump
>> as separate one or if relative path of headers are allowed that can make
>> it private between these drivers(which i don't think, will be allowed or
>> recommended).
> 
> Let's be specific: why MD_REGION_VALID must be available for remoteproc
> or any other driver after introducing qcom minidump driver?

Forget about this driver for a moment.

I am not sure  how much you know about existing qcom_minidump()
implementation and why is it there in first place in remoteproc
code in driver/remoteproc/qcom_common.c

The idea is, remoteproc co-processor like adsp/cdsp etc. may have their
static predefined region (segments) to be collected on their crash which 
is what exactly existing qcom_minidump() is doing.

Now, after this minidump series, APSS (linux) will have it's
own of collecting linux client region independent of whether
remoteproc minidump collection.

I think, are you hinting to move all minidump related code from 
remoteproc to qcom_minidump driver, is this what are you trying
to say ?

-- Mukesh
> 
> 
> Best regards,
> Krzysztof
> 
