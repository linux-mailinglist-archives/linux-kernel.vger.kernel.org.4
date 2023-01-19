Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F1673F57
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjASQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjASQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:52:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723398CE66;
        Thu, 19 Jan 2023 08:52:02 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JDoehu011854;
        Thu, 19 Jan 2023 16:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bfWor0xqewZyj21QtzzyDo7CaQ3qAeAWgzAps0t0FEc=;
 b=bcbpjYjdthie7Y2f4Kl1qycrUrkwZOQWn0DRdIGNjVzSuCDmn4G1LwVp0WJ3CfLCe8vV
 +5VtTsFQ9SUaN52slM15CZtPD2EK2e9lsW3zdyW2iIbpbiXx6BkARlUbEhHeLh0O8i74
 tVLdHYaEe+XQz4zBNgsuOmFPdGldpDSSkrL2Du6bxNa68/UJpREmYBs//RJBJn+9WtZj
 CaHxd081LIbSd6NHUcsF79wAXwyQu5ib6gkCRmqaX6Yye8cSZHgXe1fkLD2vck3ccb8i
 sihlRY7NFPilddUhnJCg3Syiwofs5pzLQUrr+kjQVn3ZLR+vvFRLMzF5V2PzK4k54ijG 1g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7593rknc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:51:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JGpogD006643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:51:50 GMT
Received: from [10.50.23.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 08:51:48 -0800
Message-ID: <ea3e6838-a656-9a20-8240-b312dd54f285@quicinc.com>
Date:   Thu, 19 Jan 2023 22:21:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V0 1/1] bootconfig: Increase max size of bootconfig from
 32 KB to 256 KB for DCC support
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1673261071.git.quic_schowdhu@quicinc.com>
 <654357bcbfd3974072a558c494a51edafaa73e1a.1673261071.git.quic_schowdhu@quicinc.com>
 <20230110001820.5ca81344286f614ed4ccec77@kernel.org>
 <e2ac0fa4-28f0-f4d8-e02a-b2a5d6131a48@quicinc.com>
 <20230110234643.7bbd340ece99c28f25fe7ad7@kernel.org>
 <9545ca51-ccda-64f0-bdd4-3b53e06785ad@quicinc.com>
 <20230112160128.600f9e7257d67aa63a5fbcb9@kernel.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20230112160128.600f9e7257d67aa63a5fbcb9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 43zltKugorCf6LKon1rBTKjhbCvzIXrO
X-Proofpoint-ORIG-GUID: 43zltKugorCf6LKon1rBTKjhbCvzIXrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_10,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301190135
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2023 12:31 PM, Masami Hiramatsu (Google) wrote:
> On Tue, 10 Jan 2023 20:38:54 +0530
> Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:
> 
>>
>>
>> On 1/10/2023 8:16 PM, Masami Hiramatsu (Google) wrote:
>>> On Tue, 10 Jan 2023 17:26:07 +0530
>>> Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:
>>>
>>>>
>>>>
>>>> On 1/9/2023 8:48 PM, Masami Hiramatsu (Google) wrote:
>>>>> On Mon, 9 Jan 2023 20:01:05 +0530
>>>>> Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:
>>>>>
>>>>>> Increasing the memory size of bootconfig to be able to handle a max number of
>>>>>> 8192 nodes to be fitted in memory size of 256KB.
>>>>>
>>>>> Sorry, but you missed the 'xbc_node::data' stores the index of the data and
>>>>> that is uint16_t. So the XBC_DATA_MAX is fixed limitation.
>>>>>
>>>>> The number of nodes (XBC_NODE_MAX) can be expanded because I just decided it
>>>>> to keep the pre-compiled array size ~8KB. Maybe expanding it to 64KB just
>>>>> increase the size of kernel on init memory (and freed after boot).
>>>>>
>>>>> Could you tell me why you need such a big data for your DCC?
>>>>>
>>>>> Thank you,
>>>>
>>>> DCC is a debugging tool used in qcom which is needed to debug crashes
>>>> that can happen at boot-time. For debugging purposes a large number of
>>>> registers need to be configured in DCC driver which is to be fed via the
>>>> bootconfig file. For that we need to expand the nodes as well as memory
>>>> for using bootconfig.
>>>
>>> Hmm, how many registers does DCC usually use? And how big the bootconfig
>>> file is usually? I have no idea about that.
>>
>> So a typical bootconfig file for consumption of DCC looks like as follows
>>
>> dcc_config {
>>           link_list_0 {
>>                   qcom-curr-link-list = 6
>>                   qcom-link-list = R_0x1781005c_1_apb,
>>                                    R_0x1782005c_1_apb
>>           }
>>           link_list_1 {
>>                   qcom-curr-link-list = 5
>>                   qcom-link-list = R_0x1784005c_1_apb
>>           }
>> }
>>
>> The "qcom-link-list" field can have 1000s of register , based on that
>> max nodes is increased to 8192.
> 
> OK, then the number of fields can be larger than 1000. I got it.
> 
>>
>>>
>>>> Can you let us know the changes that you suggest for doing the same? Is
>>>> it fine to just increase the XBC_NODE_MAX, do we also need to
>>>> change the uint16_t to u32 for proper storing of index values?
>>>
>>> Expanding the number of max nodes is easy, just increase the XBC_NODE_MAX
>>> (must be less than 64k). That will also increase the memory consumption
>>> during the boot time even if the bootconfig is small. Anyway, it will be
>>> freed after boot, so it maybe OK.
>>
>> So since the limit is 64K, 8192 is a valid value for max nodes.
> 
> Yes. Expanding the number of node is OK to me.
> 
>>
>>>
>>> But expanding the size of max bootconfig needs to change the type of
>>> the 'data' field to uint32_t (since that will be used for building
>>> bootconfig tool) and you also must confirm that `tools/bootconfig/bootconfig`
>>> can be built and pass the test-bootconfig.sh.
>>> Hmm, comparing with expanding the max number of XBC node, changing the
>>> 'data' type to uint32_t may not have much impact on memory consumption point
>>> of view, because it may increase only 20% of memory, but expanding the
>>> MAX_XBC_NODE always increases more than double.
>>>
>>> Thus, if we can accept increasing the number of node, it should be OK to
>>> change the 'data' type.
>>
>> That means from DCC point of view only increasing the max nodes is
>> enough as increasing the data size is unrelated to increasing the max nodes?
> 
> Yes, if it is less than 32KB, you just need to increase the XBC_NODE_MAX.
> But if you think the size of bootconfig, we have to change the type of
> xbc_node::data field.
> 
> Can you check the DCC also need to expand the size of bootconfig limitation?
> 
> Thank you!

Yes, I don't think the index needs to be increased from u16 to u32 for 
dcc. Will be sending out the next version accordingly.

Thanks
> 
>>
>>>
>>> BTW, I think now we don't need the ' __attribute__ ((__packed__))' for
>>> struct xbc_node. It was packed for reducing the size of array and able to
>>> pass 'compiled' bootconfig, but now it is just passed as a text data for
>>> safety.
>>
>>>
>>> Thank you,
>>>
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>>>>>> ---
>>>>>>     include/linux/bootconfig.h | 6 +++---
>>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
>>>>>> index 1611f9d..64d233b 100644
>>>>>> --- a/include/linux/bootconfig.h
>>>>>> +++ b/include/linux/bootconfig.h
>>>>>> @@ -55,11 +55,11 @@ struct xbc_node {
>>>>>>     } __attribute__ ((__packed__));
>>>>>>     
>>>>>>     #define XBC_KEY		0
>>>>>> -#define XBC_VALUE	(1 << 15)
>>>>>> -/* Maximum size of boot config is 32KB - 1 */
>>>>>> +#define XBC_VALUE	(1 << 18)
>>>>>> +/* Maximum size of boot config is 256KB - 1 */
>>>>>>     #define XBC_DATA_MAX	(XBC_VALUE - 1)
>>>>>>     
>>>>>> -#define XBC_NODE_MAX	1024
>>>>>> +#define XBC_NODE_MAX	8192
>>>>>>     #define XBC_KEYLEN_MAX	256
>>>>>>     #define XBC_DEPTH_MAX	16
>>>>>>     
>>>>>> -- 
>>>>>> 2.7.4
>>>>>>
>>>>>
>>>>>
>>>
>>>
> 
> 
