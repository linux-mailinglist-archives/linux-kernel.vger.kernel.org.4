Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CA46E49D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjDQNXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDQNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:23:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F1830DC;
        Mon, 17 Apr 2023 06:23:36 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H8skMm024804;
        Mon, 17 Apr 2023 13:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XwpxomG3rWLUbB1XoGemSNYyJ/Toe7thPIH7pe9chAk=;
 b=S8FqyamOHb23BHlkjwJs5p3YHjKG7n+qkDhbcxKA5hVZ/bzWzAM46ueheZg2eU7pljTT
 2AYLpWanpCzCRUkisn5h0bTZOvgFppSboeHIK2K8Bbn/XyVUdmDMbgt6LXOcLmgLbqUS
 O6e/pP1vZp+lbKlq0A89ujQ0rQkP3TDZBsIIg425x/dGpcGXnvPfo+MXLbrmQzz0bWw+
 vPnCj6iUf+0nMfwCjYixXuV5O9BASf2o0yBYYBszXlJFi52fmsFkmfm/OkT/uJRSALWk
 UCccXUiSAMdJRnIvheMmZ916Qao3WL+PT6AxcwpPJ6dTQ+n7e49WM9Z1OGB4fuY47re1 6w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymneuk0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 13:23:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HDNA82020535
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 13:23:10 GMT
Received: from [10.216.21.23] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 06:23:04 -0700
Message-ID: <a33e2d43-d6a6-f830-8421-ec68baf8159d@quicinc.com>
Date:   Mon, 17 Apr 2023 18:52:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/6] remoteproc: qcom: Move minidump specific data to
 qcom_minidump.h
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
 <1679491817-2498-3-git-send-email-quic_mojha@quicinc.com>
 <e74fb30d-4268-86b1-cdf7-ad3d104c6c40@linaro.org>
 <3df1ec27-7e4d-1f84-ff20-94e8ea91c86f@quicinc.com>
 <040a1992-baff-c3e4-69a9-ff3110de62e7@linaro.org>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <040a1992-baff-c3e4-69a9-ff3110de62e7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Btf2zd7RS_BmGpJ7-xz9tMB6k9gpt69W
X-Proofpoint-GUID: Btf2zd7RS_BmGpJ7-xz9tMB6k9gpt69W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_08,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170120
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 4:10 PM, Srinivas Kandagatla wrote:
> 
> 
> On 14/04/2023 08:05, Mukesh Ojha wrote:
>> Thanks again for coming back on this.
>>
>> On 4/14/2023 4:02 AM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 22/03/2023 13:30, Mukesh Ojha wrote:
>>>> Move minidump specific data types and macros to a separate internal
>>>> header(qcom_minidump.h) so that it can be shared among different
>>>
>>> minidump.h should be good as we are already in include/soc/qcom/
>>
>>
>> Initially, i wanted to protect the content of qcom_minidump.h between 
>> qcom_minidump.c and qcom_common.c
>>
>> Ideally, here qcom_minidump.h should be supplier/provider header and can 
> 
> Am not sure if I understand the supplier concept correctly.
> AFAIU, we have a 2 sets of apis
> 
> 1. get hold of minidump descriptor based on minidump_id fro gtoc using 
> qcom_minidump_subsystem_desc(). Am assuming which ever driver uses this 
> api will set there segments and regions in there respective drivers.
> 
> 2. setting regions/segments in APSS minidump descriptors which are done 
> via qcom_minidump_region_register(). TBH this should be renamed to 
> qcom_apss_minidump_region_register().
> 
> mixing of thsee apis makes it bit confusing, specially we have these two 
> category of apis that deal with different things.
> 
> Does it make sense to spit and abstract them properly by doing?
> 
> 
> 1. minidump driver to deal with handling gtoc and providing descriptors 
> to the consumers like remoteproc or apss, This can probably live within 
> smem driver as loc for this support is very minimal and proabably rename 
> the api accordingly.
> 

> 2. apss_minidump driver to allow other qcom drivers to 
> register/unregister regions within apss minidump descriptor.
> 
> did I miss something?

No, you are correct with your understanding.

To your suggestion to split code and to keep 
qcom_minidump_subsystem_desc() live inside smem driver,

And how about the header qcom_minidump.h, should we keep it separate 
than the apss minidump client header minidump.h ?

Since, you kind of understand the driver now, do you think it is worth
to create platform device for minidump from smem driver, and
have a probe inside apss minidump driver to solve chicken and egg 
problem for the clients who comes before minidump and try to register 
itself without doing ready check and apss_minidump can note this client 
entry and only register this region once minidump probe success and then 
it can register all the noted clients in one go.

The reason to do this would be apss_minidump driver has no meaning 
without smem, and for this reason checking qcom_minidump_ready() would 
not be ideal for at least qcom clients and for core kernel may be.

--Mukesh
> 
> thanks,
> Srini
> 
>> be shared among above qcom_minidump.c and qcom_common.c but since they 
>> are not in same directory, moved it inside include/soc/qcom/ as 
>> separate header than consumer header minidump.h . >
>> -Mukesh
>>>
>>> --srini
>>>
>>>> Qualcomm drivers.
>>>>
>>>> There is no change in functional behavior after this.
>>>>
>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>> ---
>>>>   drivers/remoteproc/qcom_common.c | 56 
>>>> +---------------------------------
>>>>   include/soc/qcom/qcom_minidump.h | 66 
>>>> ++++++++++++++++++++++++++++++++++++++++
>>>>   2 files changed, 67 insertions(+), 55 deletions(-)
>>>>   create mode 100644 include/soc/qcom/qcom_minidump.h
>>>>
>>>> diff --git a/drivers/remoteproc/qcom_common.c 
>>>> b/drivers/remoteproc/qcom_common.c
>>>> index 805e525..88fc984 100644
>>>> --- a/drivers/remoteproc/qcom_common.c
>>>> +++ b/drivers/remoteproc/qcom_common.c
>>>> @@ -18,6 +18,7 @@
>>>>   #include <linux/slab.h>
>>>>   #include <linux/soc/qcom/mdt_loader.h>
>>>>   #include <linux/soc/qcom/smem.h>
>>>> +#include <soc/qcom/qcom_minidump.h>
>>>>   #include "remoteproc_internal.h"
>>>>   #include "qcom_common.h"
>>>> @@ -26,61 +27,6 @@
>>>>   #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, 
>>>> subdev)
>>>>   #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, 
>>>> subdev)
>>>> -#define MAX_NUM_OF_SS           10
>>>> -#define MAX_REGION_NAME_LENGTH  16
>>>> -#define SBL_MINIDUMP_SMEM_ID    602
>>>> -#define MINIDUMP_REGION_VALID        ('V' << 24 | 'A' << 16 | 'L' 
>>>> << 8 | 'I' << 0)
>>>> -#define MINIDUMP_SS_ENCR_DONE        ('D' << 24 | 'O' << 16 | 'N' 
>>>> << 8 | 'E' << 0)
>>>> -#define MINIDUMP_SS_ENABLED        ('E' << 24 | 'N' << 16 | 'B' << 
>>>> 8 | 'L' << 0)
>>>> -
>>>> -/**
>>>> - * struct minidump_region - Minidump region
>>>> - * @name        : Name of the region to be dumped
>>>> - * @seq_num:        : Use to differentiate regions with same name.
>>>> - * @valid        : This entry to be dumped (if set to 1)
>>>> - * @address        : Physical address of region to be dumped
>>>> - * @size        : Size of the region
>>>> - */
>>>> -struct minidump_region {
>>>> -    char    name[MAX_REGION_NAME_LENGTH];
>>>> -    __le32    seq_num;
>>>> -    __le32    valid;
>>>> -    __le64    address;
>>>> -    __le64    size;
>>>> -};
>>>> -
>>>> -/**
>>>> - * struct minidump_subsystem - Subsystem's SMEM Table of content
>>>> - * @status : Subsystem toc init status
>>>> - * @enabled : if set to 1, this region would be copied during coredump
>>>> - * @encryption_status: Encryption status for this subsystem
>>>> - * @encryption_required : Decides to encrypt the subsystem regions 
>>>> or not
>>>> - * @region_count : Number of regions added in this subsystem toc
>>>> - * @regions_baseptr : regions base pointer of the subsystem
>>>> - */
>>>> -struct minidump_subsystem {
>>>> -    __le32    status;
>>>> -    __le32    enabled;
>>>> -    __le32    encryption_status;
>>>> -    __le32    encryption_required;
>>>> -    __le32    region_count;
>>>> -    __le64    regions_baseptr;
>>>> -};
>>>> -
>>>> -/**
>>>> - * struct minidump_global_toc - Global Table of Content
>>>> - * @status : Global Minidump init status
>>>> - * @md_revision : Minidump revision
>>>> - * @enabled : Minidump enable status
>>>> - * @subsystems : Array of subsystems toc
>>>> - */
>>>> -struct minidump_global_toc {
>>>> -    __le32                status;
>>>> -    __le32                md_revision;
>>>> -    __le32                enabled;
>>>> -    struct minidump_subsystem    subsystems[MAX_NUM_OF_SS];
>>>> -};
>>>> -
>>>>   struct qcom_ssr_subsystem {
>>>>       const char *name;
>>>>       struct srcu_notifier_head notifier_list;
>>>> diff --git a/include/soc/qcom/qcom_minidump.h 
>>>> b/include/soc/qcom/qcom_minidump.h
>>>> new file mode 100644
>>>> index 0000000..84c8605
>>>> --- /dev/null
>>>> +++ b/include/soc/qcom/qcom_minidump.h
>>>> @@ -0,0 +1,66 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Qualcomm minidump shared data structures and macros
>>>> + *
>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>>>> reserved.
>>>> + */
>>>> +
>>>> +#ifndef _QCOM_MINIDUMP_H_
>>>> +#define _QCOM_MINIDUMP_H_
>>>> +
>>>> +#define MAX_NUM_OF_SS           10
>>>> +#define MAX_REGION_NAME_LENGTH  16
>>>> +#define SBL_MINIDUMP_SMEM_ID    602
>>>> +#define MINIDUMP_REGION_VALID        ('V' << 24 | 'A' << 16 | 'L' 
>>>> << 8 | 'I' << 0)
>>>> +#define MINIDUMP_SS_ENCR_DONE        ('D' << 24 | 'O' << 16 | 'N' 
>>>> << 8 | 'E' << 0)
>>>> +#define MINIDUMP_SS_ENABLED        ('E' << 24 | 'N' << 16 | 'B' << 
>>>> 8 | 'L' << 0)
>>>> +
>>>> +/**
>>>> + * struct minidump_region - Minidump region
>>>> + * @name        : Name of the region to be dumped
>>>> + * @seq_num:        : Use to differentiate regions with same name.
>>>> + * @valid        : This entry to be dumped (if set to 1)
>>>> + * @address        : Physical address of region to be dumped
>>>> + * @size        : Size of the region
>>>> + */
>>>> +struct minidump_region {
>>>> +    char    name[MAX_REGION_NAME_LENGTH];
>>>> +    __le32    seq_num;
>>>> +    __le32    valid;
>>>> +    __le64    address;
>>>> +    __le64    size;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct minidump_subsystem - Subsystem's SMEM Table of content
>>>> + * @status : Subsystem toc init status
>>>> + * @enabled : if set to 1, this region would be copied during coredump
>>>> + * @encryption_status: Encryption status for this subsystem
>>>> + * @encryption_required : Decides to encrypt the subsystem regions 
>>>> or not
>>>> + * @region_count : Number of regions added in this subsystem toc
>>>> + * @regions_baseptr : regions base pointer of the subsystem
>>>> + */
>>>> +struct minidump_subsystem {
>>>> +    __le32    status;
>>>> +    __le32    enabled;
>>>> +    __le32    encryption_status;
>>>> +    __le32    encryption_required;
>>>> +    __le32    region_count;
>>>> +    __le64    regions_baseptr;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct minidump_global_toc - Global Table of Content
>>>> + * @status : Global Minidump init status
>>>> + * @md_revision : Minidump revision
>>>> + * @enabled : Minidump enable status
>>>> + * @subsystems : Array of subsystems toc
>>>> + */
>>>> +struct minidump_global_toc {
>>>> +    __le32                status;
>>>> +    __le32                md_revision;
>>>> +    __le32                enabled;
>>>> +    struct minidump_subsystem    subsystems[MAX_NUM_OF_SS];
>>>> +};
>>>> +
>>>> +#endif  /* _QCOM_MINIDUMP_H_ */
