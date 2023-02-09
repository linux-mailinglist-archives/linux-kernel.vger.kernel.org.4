Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6CC68FD05
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjBICUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjBICTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:19:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A523233F8;
        Wed,  8 Feb 2023 18:19:48 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3191LpZZ013465;
        Thu, 9 Feb 2023 02:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=G0Wct4skFZ4mzDC58ftjaj74vgAs7Tbd+XhwQZLGwV4=;
 b=JGOkTg0eF8jILRhFqY6u8uyouIVRdVz6+I9yD+e9+fGrYF+Su0OY5vx++eFmZABPVrst
 vEj9BaysglkyhGFA958f378YFm8yBxNpBy5nzs8B9ffP6s5DCg0UydGq+dMAfJkv6VuB
 eR1bDyxxQneX2S4LqGRgTxJIIaKfZgAUofN1Jy+UIqfZRXjnxh96a4zbTp+dTJ0D81Be
 T6j0y+hfnFmD8Rp7SwC972GzCZTqZo1HDTIzKEr4J8ArWxTBrtijOnnk2sW43SARQzTQ
 AIL764cm+WlkwEzn7eR6D7kvvxdak4XhSed9SpKDk/hDWlJVZdQ555BXYI4JbvSxRsCj sA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkga2wyah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 02:19:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3192JASZ029508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 02:19:10 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 18:19:06 -0800
Message-ID: <180a66b1-6996-c705-5d8a-0a69ce0353d7@quicinc.com>
Date:   Thu, 9 Feb 2023 10:16:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] coresight: core: Add coresight name support
Content-Language: en-US
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
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <3c105c79-f523-653e-5154-7ba641e51a96@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XjYfMfdIuh0kTJWqikxNjd3m9KHHSBnS
X-Proofpoint-ORIG-GUID: XjYfMfdIuh0kTJWqikxNjd3m9KHHSBnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 mlxlogscore=887 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090019
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/8/2023 10:26 PM, Suzuki K Poulose wrote:
> On 08/02/2023 11:07, Mao Jinlong wrote:
>> Apart from STM and ETM sources, there will be more sources added to
>> coresight components. For example, there are over 10 TPDM sources.
>> Add coresight name support for custom names which will be
>> easy to identify the source.
>>
>
> As we have previously discussed, please don't make this a generic
> code change. If your device has a "specifici" name, use that for
> allocating in the driver and leave the core code alone.
>
> Suzuki
>
Hi Suzuki,

Not only for TPDMs. There could be dozens of CTI devices.
It is hard for user to know which CTI device it is with current names.

Thanks
Jinlong Mao
>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 34 +++++++++++---------
>>   1 file changed, 19 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index d3bf82c0de1d..5e95d9c7f256 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1733,28 +1733,32 @@ char *coresight_alloc_device_name(struct 
>> coresight_dev_list *dict,
>>   {
>>       int idx;
>>       char *name = NULL;
>> +    const char *coresight_name = NULL;
>>       struct fwnode_handle **list;
>> +    struct device_node *node = dev->of_node;
>>         mutex_lock(&coresight_mutex);
>>   -    idx = coresight_search_device_idx(dict, dev_fwnode(dev));
>> -    if (idx < 0) {
>> -        /* Make space for the new entry */
>> -        idx = dict->nr_idx;
>> -        list = krealloc_array(dict->fwnode_list,
>> -                      idx + 1, sizeof(*dict->fwnode_list),
>> -                      GFP_KERNEL);
>> -        if (ZERO_OR_NULL_PTR(list)) {
>> -            idx = -ENOMEM;
>> -            goto done;
>> +    if (!of_property_read_string(node, "coresight-name", 
>> &coresight_name))
>> +        name = devm_kasprintf(dev, GFP_KERNEL, "%s", coresight_name);
>> +    else {
>> +        idx = coresight_search_device_idx(dict, dev_fwnode(dev));
>> +        if (idx < 0) {
>> +            /* Make space for the new entry */
>> +            idx = dict->nr_idx;
>> +            list = krealloc_array(dict->fwnode_list,
>> +                          idx + 1, sizeof(*dict->fwnode_list),
>> +                          GFP_KERNEL);
>> +            if (ZERO_OR_NULL_PTR(list))
>> +                goto done;
>> +
>> +            list[idx] = dev_fwnode(dev);
>> +            dict->fwnode_list = list;
>> +            dict->nr_idx = idx + 1;
>>           }
>>   -        list[idx] = dev_fwnode(dev);
>> -        dict->fwnode_list = list;
>> -        dict->nr_idx = idx + 1;
>> +        name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
>>       }
>> -
>> -    name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
>>   done:
>>       mutex_unlock(&coresight_mutex);
>>       return name;
>
