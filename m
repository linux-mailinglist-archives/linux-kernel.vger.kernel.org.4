Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1E6ECF77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjDXNnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjDXNni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:43:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94C5975F;
        Mon, 24 Apr 2023 06:43:07 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OBvEGA012942;
        Mon, 24 Apr 2023 13:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cVqPvvQlpQHEtwMA0GHXvEDbmIKaWD6JR6LYtWuYSjs=;
 b=AIdr4/EqKtx0U/k5kB4OVSdEENwX52rHQc+USUWu8PVhpoy9Mw3b/YLs+ZT2pU0xK4mu
 DVxy4+pTdmxMeJD1nCCPsPoWUexOfMwMeZi6+1YmXU+HpU+PTpK1MpEDjQzgCNoV8XF/
 YYJGec4UeClsSQQRTVaJZ6xgH2+lhFf6ZTumEvLgGQcb8455d8jogI7ng6OZRopcpk/F
 e5FxsC/rN4PlNEUne7rk9eOrb5VfB5nk+vcdf96XKldqXBfW1esSTV/oPjzjpK7XBMsz
 Jb5SVbbV7D3UOc+AeFkT04+PUuzA32qGtry2B1myoRPuQC7Csnt0iqxxx69akqhLFSW2 RA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5r0urdy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 13:42:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ODgUY8027454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 13:42:30 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 24 Apr
 2023 06:42:26 -0700
Message-ID: <a9d4e5d1-0e1f-13b5-cf3a-464e61594990@quicinc.com>
Date:   Mon, 24 Apr 2023 21:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] coresight: core: Add coresight name support
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "Sudeep Holla" <sudeep.holla@arm.com>
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
 <b7abee2a-99ca-26d6-5850-60ee19d9c0e9@quicinc.com>
 <619818ad-71cb-6c07-bcae-ea9398f08878@arm.com>
 <6b976d2b-3c78-96e4-bf35-3ef88828a9dd@quicinc.com>
 <f5a1d873-8aa0-ea11-28df-8857fc256862@arm.com>
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <f5a1d873-8aa0-ea11-28df-8857fc256862@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oHW-G3COBQcgsMcVL-mSsb11yCwyJTzb
X-Proofpoint-ORIG-GUID: oHW-G3COBQcgsMcVL-mSsb11yCwyJTzb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240123
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/2023 10:25 PM, Suzuki K Poulose wrote:

> On 17/03/2023 05:34, Jinlong Mao wrote:
>>
>> On 3/13/2023 5:16 PM, Suzuki K Poulose wrote:
>>> Cc: Rob
>>>
>>> On 01/03/2023 15:11, Jinlong Mao wrote:
>>>> Hi Suzuki,
>>>>
>>>> On 2/9/2023 10:16 AM, Jinlong Mao wrote:
>>>>>
>>>>> On 2/8/2023 10:26 PM, Suzuki K Poulose wrote:
>>>>>> On 08/02/2023 11:07, Mao Jinlong wrote:
>>>>>>> Apart from STM and ETM sources, there will be more sources added to
>>>>>>> coresight components. For example, there are over 10 TPDM sources.
>>>>>>> Add coresight name support for custom names which will be
>>>>>>> easy to identify the source.
>>>>>>>
>>>>>>
>>>>>> As we have previously discussed, please don't make this a generic
>>>>>> code change. If your device has a "specifici" name, use that for
>>>>>> allocating in the driver and leave the core code alone.
>>>>>>
>>>>>> Suzuki
>>>>>>
>>>>> Hi Suzuki,
>>>>>
>>>>> Not only for TPDMs. There could be dozens of CTI devices.
>>>>> It is hard for user to know which CTI device it is with current 
>>>>> names.
>>>>>
>>>>> Thanks
>>>>> Jinlong Mao
>>>>
>>>> The coresight name support is applicable to CTI and TPDM devices.
>>>> This is a generic change for the source which has dozens of devices.
>>>
>>> I took a look at the CTI situation and I agree that the situation
>>> is a bit tricky. The CTI could be connected to multiple devices,
>>> some of them may not be even CoreSight devices. Given there could
>>> be numerous of them, we need some way to make the "devices" naming
>>> a bit more intuitive.
>>>
>>> Before we go ahead and add something specific to coresight, I would
>>> like to see if there is a generic property. Ideally, the "labels"
>>> in the DTS sources would have been an ideal choice, but can't
>>> see how that is available in the FDT.
>>>
>>> Suzuki
>> Hi Suzuki,
>>
>> Shall we use the full_name of device_node struct as coresight 
>> component's name ?
>>
>>    struct device_node {
>>      const char *name;
>>      phandle phandle;
>> *    const char *full_name;
>>
>> *For component below, the full_name will be "coresight-tpdm-ipcc".
>> *
>> **coresight-tpdm-ipcc* {
>
> Does that go against the convention of naming the DT nodes ?
> I am not sure. Also, we would need a way to solve this for ACPI too.
>
> Suzuki
Hi Suzuki,

Does ACPI device also use "coresight_alloc_device_name" to get the 
device's name ?

Thanks
Jinlong Mao

>
>
>>      compatible = "qcom,coresight-tpdm", "arm,primecell";
>>      reg = <0 0x10c29000 0 0x1000>;
>>
>>      clocks = <&aoss_qmp>;
>>      clock-names = "apb_pclk";
>>
>>      out-ports {
>>              port {
>>                      tpdm_ipcc_out_tpda_dl_center_27: endpoint {
>>                              remote-endpoint =
>> <&tpda_dl_center_27_in_tpdm_ipcc>;
>>                      };
>>              };
>>      };
>> };*
>>
>> *Thanks
>> Jinlong Mao
>>>
>>>
>>>>
>>>> Thanks
>>>> Jinlong Mao
>>>>
>>>>>>
>>>>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>>>>> ---
>>>>>>>   drivers/hwtracing/coresight/coresight-core.c | 34 
>>>>>>> +++++++++++---------
>>>>>>>   1 file changed, 19 insertions(+), 15 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>>>>>> b/drivers/hwtracing/coresight/coresight-core.c
>>>>>>> index d3bf82c0de1d..5e95d9c7f256 100644
>>>>>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>>>>>> @@ -1733,28 +1733,32 @@ char *coresight_alloc_device_name(struct 
>>>>>>> coresight_dev_list *dict,
>>>>>>>   {
>>>>>>>       int idx;
>>>>>>>       char *name = NULL;
>>>>>>> +    const char *coresight_name = NULL;
>>>>>>>       struct fwnode_handle **list;
>>>>>>> +    struct device_node *node = dev->of_node;
>>>>>>>         mutex_lock(&coresight_mutex);
>>>>>>>   -    idx = coresight_search_device_idx(dict, dev_fwnode(dev));
>>>>>>> -    if (idx < 0) {
>>>>>>> -        /* Make space for the new entry */
>>>>>>> -        idx = dict->nr_idx;
>>>>>>> -        list = krealloc_array(dict->fwnode_list,
>>>>>>> -                      idx + 1, sizeof(*dict->fwnode_list),
>>>>>>> -                      GFP_KERNEL);
>>>>>>> -        if (ZERO_OR_NULL_PTR(list)) {
>>>>>>> -            idx = -ENOMEM;
>>>>>>> -            goto done;
>>>>>>> +    if (!of_property_read_string(node, "coresight-name", 
>>>>>>> &coresight_name))
>>>>>>> +        name = devm_kasprintf(dev, GFP_KERNEL, "%s", 
>>>>>>> coresight_name);
>>>>>>> +    else {
>>>>>>> +        idx = coresight_search_device_idx(dict, dev_fwnode(dev));
>>>>>>> +        if (idx < 0) {
>>>>>>> +            /* Make space for the new entry */
>>>>>>> +            idx = dict->nr_idx;
>>>>>>> +            list = krealloc_array(dict->fwnode_list,
>>>>>>> +                          idx + 1, sizeof(*dict->fwnode_list),
>>>>>>> +                          GFP_KERNEL);
>>>>>>> +            if (ZERO_OR_NULL_PTR(list))
>>>>>>> +                goto done;
>>>>>>> +
>>>>>>> +            list[idx] = dev_fwnode(dev);
>>>>>>> +            dict->fwnode_list = list;
>>>>>>> +            dict->nr_idx = idx + 1;
>>>>>>>           }
>>>>>>>   -        list[idx] = dev_fwnode(dev);
>>>>>>> -        dict->fwnode_list = list;
>>>>>>> -        dict->nr_idx = idx + 1;
>>>>>>> +        name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", 
>>>>>>> dict->pfx, idx);
>>>>>>>       }
>>>>>>> -
>>>>>>> -    name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, 
>>>>>>> idx);
>>>>>>>   done:
>>>>>>>       mutex_unlock(&coresight_mutex);
>>>>>>>       return name;
>>>>>>
>>>>> _______________________________________________
>>>>> CoreSight mailing list -- coresight@lists.linaro.org
>>>>> To unsubscribe send an email to coresight-leave@lists.linaro.org
>>>
>
