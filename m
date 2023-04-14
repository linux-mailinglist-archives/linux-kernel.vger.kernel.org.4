Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F026E1CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDNHGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjDNHGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:06:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA0630F5;
        Fri, 14 Apr 2023 00:05:59 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E6UlGG031289;
        Fri, 14 Apr 2023 07:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1h16hUb3V1HHJiseU1aSCsalqmOi0P1+ZAFDaD80Qt8=;
 b=dMSFJ7NbyEi/5vBUl7A2h6idvDX+qZ5LJJKCfiBRki8EZXV9r7Z3AXllfIlxD/mnYJKd
 6WRfT0bXKQywz5ICcITY1suF7A1kB0RvRgCKlC75jV1Izj5WkqxScqykgXkwlX7h4phV
 ax3ci2KnyiQvqgG/UBKwppoxh89BMiySRe2tvSA2k6LOjvIocnBjIUry54OB/pOlBG4a
 t5S1rEGqV47+E0vKb0PKjHsWeDFK4dVZ83EhUan4D7/n3gYzcGMW150OficPpjqce7EW
 IgNnqDlWI7SQZsSS+4ZLOPGhhCQpzAz/twq8ljmN9Btci4ATJZsk167hMFNg9cbblAQc tg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxqf9964m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 07:05:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33E759T8032286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 07:05:09 GMT
Received: from [10.216.56.7] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 00:05:04 -0700
Message-ID: <3df1ec27-7e4d-1f84-ff20-94e8ea91c86f@quicinc.com>
Date:   Fri, 14 Apr 2023 12:35:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/6] remoteproc: qcom: Move minidump specific data to
 qcom_minidump.h
Content-Language: en-US
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
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <e74fb30d-4268-86b1-cdf7-ad3d104c6c40@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kjd3iZFPQAyO7ZDiYAcbngj41D7Q5c2b
X-Proofpoint-ORIG-GUID: Kjd3iZFPQAyO7ZDiYAcbngj41D7Q5c2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140063
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again for coming back on this.

On 4/14/2023 4:02 AM, Srinivas Kandagatla wrote:
> 
> 
> On 22/03/2023 13:30, Mukesh Ojha wrote:
>> Move minidump specific data types and macros to a separate internal
>> header(qcom_minidump.h) so that it can be shared among different
> 
> minidump.h should be good as we are already in include/soc/qcom/


Initially, i wanted to protect the content of qcom_minidump.h between 
qcom_minidump.c and qcom_common.c

Ideally, here qcom_minidump.h should be supplier/provider header and can 
be shared among above qcom_minidump.c and qcom_common.c but since they 
are not in same directory, moved it inside include/soc/qcom/ as separate 
header than consumer header minidump.h .

-Mukesh
> 
> --srini
> 
>> Qualcomm drivers.
>>
>> There is no change in functional behavior after this.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/remoteproc/qcom_common.c | 56 
>> +---------------------------------
>>   include/soc/qcom/qcom_minidump.h | 66 
>> ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 67 insertions(+), 55 deletions(-)
>>   create mode 100644 include/soc/qcom/qcom_minidump.h
>>
>> diff --git a/drivers/remoteproc/qcom_common.c 
>> b/drivers/remoteproc/qcom_common.c
>> index 805e525..88fc984 100644
>> --- a/drivers/remoteproc/qcom_common.c
>> +++ b/drivers/remoteproc/qcom_common.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/soc/qcom/mdt_loader.h>
>>   #include <linux/soc/qcom/smem.h>
>> +#include <soc/qcom/qcom_minidump.h>
>>   #include "remoteproc_internal.h"
>>   #include "qcom_common.h"
>> @@ -26,61 +27,6 @@
>>   #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, 
>> subdev)
>>   #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
>> -#define MAX_NUM_OF_SS           10
>> -#define MAX_REGION_NAME_LENGTH  16
>> -#define SBL_MINIDUMP_SMEM_ID    602
>> -#define MINIDUMP_REGION_VALID        ('V' << 24 | 'A' << 16 | 'L' << 
>> 8 | 'I' << 0)
>> -#define MINIDUMP_SS_ENCR_DONE        ('D' << 24 | 'O' << 16 | 'N' << 
>> 8 | 'E' << 0)
>> -#define MINIDUMP_SS_ENABLED        ('E' << 24 | 'N' << 16 | 'B' << 8 
>> | 'L' << 0)
>> -
>> -/**
>> - * struct minidump_region - Minidump region
>> - * @name        : Name of the region to be dumped
>> - * @seq_num:        : Use to differentiate regions with same name.
>> - * @valid        : This entry to be dumped (if set to 1)
>> - * @address        : Physical address of region to be dumped
>> - * @size        : Size of the region
>> - */
>> -struct minidump_region {
>> -    char    name[MAX_REGION_NAME_LENGTH];
>> -    __le32    seq_num;
>> -    __le32    valid;
>> -    __le64    address;
>> -    __le64    size;
>> -};
>> -
>> -/**
>> - * struct minidump_subsystem - Subsystem's SMEM Table of content
>> - * @status : Subsystem toc init status
>> - * @enabled : if set to 1, this region would be copied during coredump
>> - * @encryption_status: Encryption status for this subsystem
>> - * @encryption_required : Decides to encrypt the subsystem regions or 
>> not
>> - * @region_count : Number of regions added in this subsystem toc
>> - * @regions_baseptr : regions base pointer of the subsystem
>> - */
>> -struct minidump_subsystem {
>> -    __le32    status;
>> -    __le32    enabled;
>> -    __le32    encryption_status;
>> -    __le32    encryption_required;
>> -    __le32    region_count;
>> -    __le64    regions_baseptr;
>> -};
>> -
>> -/**
>> - * struct minidump_global_toc - Global Table of Content
>> - * @status : Global Minidump init status
>> - * @md_revision : Minidump revision
>> - * @enabled : Minidump enable status
>> - * @subsystems : Array of subsystems toc
>> - */
>> -struct minidump_global_toc {
>> -    __le32                status;
>> -    __le32                md_revision;
>> -    __le32                enabled;
>> -    struct minidump_subsystem    subsystems[MAX_NUM_OF_SS];
>> -};
>> -
>>   struct qcom_ssr_subsystem {
>>       const char *name;
>>       struct srcu_notifier_head notifier_list;
>> diff --git a/include/soc/qcom/qcom_minidump.h 
>> b/include/soc/qcom/qcom_minidump.h
>> new file mode 100644
>> index 0000000..84c8605
>> --- /dev/null
>> +++ b/include/soc/qcom/qcom_minidump.h
>> @@ -0,0 +1,66 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Qualcomm minidump shared data structures and macros
>> + *
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#ifndef _QCOM_MINIDUMP_H_
>> +#define _QCOM_MINIDUMP_H_
>> +
>> +#define MAX_NUM_OF_SS           10
>> +#define MAX_REGION_NAME_LENGTH  16
>> +#define SBL_MINIDUMP_SMEM_ID    602
>> +#define MINIDUMP_REGION_VALID        ('V' << 24 | 'A' << 16 | 'L' << 
>> 8 | 'I' << 0)
>> +#define MINIDUMP_SS_ENCR_DONE        ('D' << 24 | 'O' << 16 | 'N' << 
>> 8 | 'E' << 0)
>> +#define MINIDUMP_SS_ENABLED        ('E' << 24 | 'N' << 16 | 'B' << 8 
>> | 'L' << 0)
>> +
>> +/**
>> + * struct minidump_region - Minidump region
>> + * @name        : Name of the region to be dumped
>> + * @seq_num:        : Use to differentiate regions with same name.
>> + * @valid        : This entry to be dumped (if set to 1)
>> + * @address        : Physical address of region to be dumped
>> + * @size        : Size of the region
>> + */
>> +struct minidump_region {
>> +    char    name[MAX_REGION_NAME_LENGTH];
>> +    __le32    seq_num;
>> +    __le32    valid;
>> +    __le64    address;
>> +    __le64    size;
>> +};
>> +
>> +/**
>> + * struct minidump_subsystem - Subsystem's SMEM Table of content
>> + * @status : Subsystem toc init status
>> + * @enabled : if set to 1, this region would be copied during coredump
>> + * @encryption_status: Encryption status for this subsystem
>> + * @encryption_required : Decides to encrypt the subsystem regions or 
>> not
>> + * @region_count : Number of regions added in this subsystem toc
>> + * @regions_baseptr : regions base pointer of the subsystem
>> + */
>> +struct minidump_subsystem {
>> +    __le32    status;
>> +    __le32    enabled;
>> +    __le32    encryption_status;
>> +    __le32    encryption_required;
>> +    __le32    region_count;
>> +    __le64    regions_baseptr;
>> +};
>> +
>> +/**
>> + * struct minidump_global_toc - Global Table of Content
>> + * @status : Global Minidump init status
>> + * @md_revision : Minidump revision
>> + * @enabled : Minidump enable status
>> + * @subsystems : Array of subsystems toc
>> + */
>> +struct minidump_global_toc {
>> +    __le32                status;
>> +    __le32                md_revision;
>> +    __le32                enabled;
>> +    struct minidump_subsystem    subsystems[MAX_NUM_OF_SS];
>> +};
>> +
>> +#endif  /* _QCOM_MINIDUMP_H_ */
