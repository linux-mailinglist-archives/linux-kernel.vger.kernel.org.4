Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCBE6A7916
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCBBlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBBln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:41:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB10957D39;
        Wed,  1 Mar 2023 17:41:11 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321KRMSx003384;
        Thu, 2 Mar 2023 01:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t+ox/ua+WNtH76S6Rpnio0sQR5LltkxRqkoaHGKqzc4=;
 b=Wjh/xxP4FmDM3mBJTljDkC/nVkpZLJlwanXO7Bx16hZN2VPIr5hf1/UHAnCb7oY1d+2p
 ZkII8EV02Y3IEJBXuhVc3LMXfhwY++bCjtmNVm9SM4GkVOvDsEWKY8zGqyo9qGRcx89h
 KmqQqPmlmUAIwYauUu+3/WC4KISw+h1+v9dAKqU8u29tIw1iMd6g4519JfNIj5uNeMgI
 IR7hoqmzimHSozO5HjH4Zsy0Pk7qoYiLvkpqQsEBNJGzJJTekkax4xumn8dSX74S7OB0
 HkIuKST7oq6CZPEPcQccX5euVNEJLt53rrUPeRpGy2O7+KUgh8RBbdugA0osKmo8zejN uQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p25jwj2jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 01:40:29 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3221eSeG023002
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 01:40:28 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Mar 2023
 17:40:27 -0800
Message-ID: <9003dd79-00eb-72d4-18e5-51c0f52833f8@quicinc.com>
Date:   Wed, 1 Mar 2023 17:40:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 03/26] gunyah: Common types and error codes for Gunyah
 hypercalls
Content-Language: en-US
To:     Alex Elder <alex.elder@linaro.org>, Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214211229.3239350-4-quic_eberman@quicinc.com>
 <5d67ee67-e63f-1393-1455-bfb6b2ddaeb5@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <5d67ee67-e63f-1393-1455-bfb6b2ddaeb5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XcWIMnHC-9wL9xi4R89QapkhQrFr9KaT
X-Proofpoint-ORIG-GUID: XcWIMnHC-9wL9xi4R89QapkhQrFr9KaT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_17,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=676 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020011
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 1:58 PM, Alex Elder wrote:
> On 2/14/23 3:12 PM, Elliot Berman wrote:
>> Add architecture-independent standard error codes, types, and macros for
>> Gunyah hypercalls.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   include/linux/gunyah.h | 82 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>   create mode 100644 include/linux/gunyah.h
>>
>> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
>> new file mode 100644
>> index 000000000000..59ef4c735ae8
>> --- /dev/null
>> +++ b/include/linux/gunyah.h
>> @@ -0,0 +1,82 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#ifndef _LINUX_GUNYAH_H
>> +#define _LINUX_GUNYAH_H
>> +
>> +#include <linux/errno.h>
>> +#include <linux/limits.h>
>> +
>> +/******************************************************************************/
>> +/* Common arch-independent definitions for Gunyah 
>> hypercalls                  */
>> +#define GH_CAPID_INVAL    U64_MAX
>> +#define GH_VMID_ROOT_VM    0xff
>> +
>> +enum gh_error {
>> +    GH_ERROR_OK            = 0,
>> +    GH_ERROR_UNIMPLEMENTED        = -1,
>> +    GH_ERROR_RETRY            = -2,
> 
> Do you expect this type to have a particular size?
> Since you specify negative values, it matters, and
> it's possible that this forces it to be a 4-byte value
> (though I'm not sure what the rules are).  In other
> words, UNIMPLEMENTED could conceivably have value 0xff
> or 0xffffffff.  I'm not even sure you can tell whether
> an enum is interpreted as signed or unsigned.

I'm not a C expert, but my understanding is that enums are signed. 
Gunyah will be returning a signed 64-bit register, however there's no 
intention to go beyond 32 bits of error codes since we want to work on 
32-bit architectures.

> 
> It's not usually a good thing to do, but this *could*
> be a case where you do a typedef to represent this as
> a signed value of a certain bit width.  (But don't do
> that unless someone else says that's worth doing.)
> 
>                      -Alex
> 
>> +
>> +    GH_ERROR_ARG_INVAL        = 1,
>> +    GH_ERROR_ARG_SIZE        = 2,
>> +    GH_ERROR_ARG_ALIGN        = 3,
>> +
>> +    GH_ERROR_NOMEM            = 10,
>> +
>> +    GH_ERROR_ADDR_OVFL        = 20,
>> +    GH_ERROR_ADDR_UNFL        = 21,
>> +    GH_ERROR_ADDR_INVAL        = 22,
>> +
>> +    GH_ERROR_DENIED            = 30,
>> +    GH_ERROR_BUSY            = 31,
>> +    GH_ERROR_IDLE            = 32,
>> +
>> +    GH_ERROR_IRQ_BOUND        = 40,
>> +    GH_ERROR_IRQ_UNBOUND        = 41,
>> +
>> +    GH_ERROR_CSPACE_CAP_NULL    = 50,
>> +    GH_ERROR_CSPACE_CAP_REVOKED    = 51,
>> +    GH_ERROR_CSPACE_WRONG_OBJ_TYPE    = 52,
>> +    GH_ERROR_CSPACE_INSUF_RIGHTS    = 53,
>> +    GH_ERROR_CSPACE_FULL        = 54,
>> +
>> +    GH_ERROR_MSGQUEUE_EMPTY        = 60,
>> +    GH_ERROR_MSGQUEUE_FULL        = 61,
>> +};
>> +
>> +/**
>> + * gh_remap_error() - Remap Gunyah hypervisor errors into a Linux 
>> error code
>> + * @gh_error: Gunyah hypercall return value
>> + */
>> +static inline int gh_remap_error(enum gh_error gh_error)
>> +{
>> +    switch (gh_error) {
>> +    case GH_ERROR_OK:
>> +        return 0;
>> +    case GH_ERROR_NOMEM:
>> +        return -ENOMEM;
>> +    case GH_ERROR_DENIED:
>> +    case GH_ERROR_CSPACE_CAP_NULL:
>> +    case GH_ERROR_CSPACE_CAP_REVOKED:
>> +    case GH_ERROR_CSPACE_WRONG_OBJ_TYPE:
>> +    case GH_ERROR_CSPACE_INSUF_RIGHTS:
>> +    case GH_ERROR_CSPACE_FULL:
>> +        return -EACCES;
>> +    case GH_ERROR_BUSY:
>> +    case GH_ERROR_IDLE:
>> +    case GH_ERROR_IRQ_BOUND:
>> +    case GH_ERROR_IRQ_UNBOUND:
>> +    case GH_ERROR_MSGQUEUE_FULL:
>> +    case GH_ERROR_MSGQUEUE_EMPTY:
> 
> Is an empty message queue really busy?
> 

Changed to -EIO.

>> +        return -EBUSY;
>> +    case GH_ERROR_UNIMPLEMENTED:
>> +    case GH_ERROR_RETRY:
>> +        return -EOPNOTSUPP;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +}
>> +
>> +#endif
> 
