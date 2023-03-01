Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976746A6F11
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCAPMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCAPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:12:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3A149B0;
        Wed,  1 Mar 2023 07:12:10 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321F0LFL028502;
        Wed, 1 Mar 2023 15:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Q5//b5Cfae/cAkb40PAPzUYQjwIyjf+4kpcHa68BpQ8=;
 b=mDpVk0+DGGkdv1e2aYfwwdHGIoWyNLL1vjwpFWZ7Hf0p3/Tr6U01XFE3cIwalore9LMD
 fhvD8AEp2TZgDdzNsil8F2EBOCi4a3ORDVMLEYmwjmISyDd3hYbGpNkrn3rjpvBVo5eL
 HJca2s7U4aFzbVpFG9iZrk7rs/WZVBhRUXOf8GzAxV33Q2jZA6mFbbLiEzNMyRd5Bzip
 QJB2LxTmc6oT3dBSRnKrbrBX9+3xBMnEX0p6wkNK3eEToOKSvCQJfxzTthj2dMAbx8wY
 UlNdLyy6hdDkqUIcs7c+fjsuM0ZMvOyaF7Wsy7ul5G3vkpF3BOXutjqksGb/dcsVw9He HQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1vgej6n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 15:11:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 321FBvUf000474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 15:11:57 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Mar 2023
 07:11:54 -0800
Message-ID: <b7abee2a-99ca-26d6-5850-60ee19d9c0e9@quicinc.com>
Date:   Wed, 1 Mar 2023 23:11:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] coresight: core: Add coresight name support
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Tingwei Zhang" <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230208110716.18321-1-quic_jinlmao@quicinc.com>
 <3c105c79-f523-653e-5154-7ba641e51a96@arm.com>
 <180a66b1-6996-c705-5d8a-0a69ce0353d7@quicinc.com>
In-Reply-To: <180a66b1-6996-c705-5d8a-0a69ce0353d7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GnYacKV0I-gpdE6AQlbENdKxrczBbbhb
X-Proofpoint-ORIG-GUID: GnYacKV0I-gpdE6AQlbENdKxrczBbbhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_10,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010125
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 2/9/2023 10:16 AM, Jinlong Mao wrote:
>
> On 2/8/2023 10:26 PM, Suzuki K Poulose wrote:
>> On 08/02/2023 11:07, Mao Jinlong wrote:
>>> Apart from STM and ETM sources, there will be more sources added to
>>> coresight components. For example, there are over 10 TPDM sources.
>>> Add coresight name support for custom names which will be
>>> easy to identify the source.
>>>
>>
>> As we have previously discussed, please don't make this a generic
>> code change. If your device has a "specifici" name, use that for
>> allocating in the driver and leave the core code alone.
>>
>> Suzuki
>>
> Hi Suzuki,
>
> Not only for TPDMs. There could be dozens of CTI devices.
> It is hard for user to know which CTI device it is with current names.
>
> Thanks
> Jinlong Mao

The coresight name support is applicable to CTI and TPDM devices.
This is a generic change for the source which has dozens of devices.

Thanks
Jinlong Mao

>>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-core.c | 34 
>>> +++++++++++---------
>>>   1 file changed, 19 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>> b/drivers/hwtracing/coresight/coresight-core.c
>>> index d3bf82c0de1d..5e95d9c7f256 100644
>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>> @@ -1733,28 +1733,32 @@ char *coresight_alloc_device_name(struct 
>>> coresight_dev_list *dict,
>>>   {
>>>       int idx;
>>>       char *name = NULL;
>>> +    const char *coresight_name = NULL;
>>>       struct fwnode_handle **list;
>>> +    struct device_node *node = dev->of_node;
>>>         mutex_lock(&coresight_mutex);
>>>   -    idx = coresight_search_device_idx(dict, dev_fwnode(dev));
>>> -    if (idx < 0) {
>>> -        /* Make space for the new entry */
>>> -        idx = dict->nr_idx;
>>> -        list = krealloc_array(dict->fwnode_list,
>>> -                      idx + 1, sizeof(*dict->fwnode_list),
>>> -                      GFP_KERNEL);
>>> -        if (ZERO_OR_NULL_PTR(list)) {
>>> -            idx = -ENOMEM;
>>> -            goto done;
>>> +    if (!of_property_read_string(node, "coresight-name", 
>>> &coresight_name))
>>> +        name = devm_kasprintf(dev, GFP_KERNEL, "%s", coresight_name);
>>> +    else {
>>> +        idx = coresight_search_device_idx(dict, dev_fwnode(dev));
>>> +        if (idx < 0) {
>>> +            /* Make space for the new entry */
>>> +            idx = dict->nr_idx;
>>> +            list = krealloc_array(dict->fwnode_list,
>>> +                          idx + 1, sizeof(*dict->fwnode_list),
>>> +                          GFP_KERNEL);
>>> +            if (ZERO_OR_NULL_PTR(list))
>>> +                goto done;
>>> +
>>> +            list[idx] = dev_fwnode(dev);
>>> +            dict->fwnode_list = list;
>>> +            dict->nr_idx = idx + 1;
>>>           }
>>>   -        list[idx] = dev_fwnode(dev);
>>> -        dict->fwnode_list = list;
>>> -        dict->nr_idx = idx + 1;
>>> +        name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, 
>>> idx);
>>>       }
>>> -
>>> -    name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
>>>   done:
>>>       mutex_unlock(&coresight_mutex);
>>>       return name;
>>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
