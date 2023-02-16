Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E278D699A47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjBPQlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBPQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:41:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4F4CC9E;
        Thu, 16 Feb 2023 08:41:11 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GAkVuj002877;
        Thu, 16 Feb 2023 16:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=l4RTo9JGHFcyiRzucLkPnt/T4JgiacY5HHnNjWoul1I=;
 b=hvslx0biV/sZMr4s9kx/9FcH1l/pb3DB9N/qUjsa/kj0N5LjB3J85NHlGrucZSR9dOT1
 dPd8VPyFkJuwwfjWMsb6yPIddXttwX5VNV/zunM0d+9ZLBlV4QTr/EDkQLKlLB5ABjsF
 VKLJzMkrThb7yfNWtXNcrV7YrKVLwSxDt5fUAUoNDKzx9ZeRIsKC61w5WJA9vFzVOvh/
 eEsRtHp7Q/601F6q+vgMx983VW6djMC6VDTrc6d8smGYH0e3w4J3pSGzWjq6NFqqB4SO
 n9ar7MFSALgYUDnriuNYk02ZVdsMzPeMJbDsZwiXZVE4I6I+EqIxaDbeJfpX9esYPByq Iw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ns85kactd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 16:41:08 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GGf7SB030429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 16:41:07 GMT
Received: from [10.110.95.168] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 08:41:06 -0800
Message-ID: <ba567710-8ef5-9a18-4c41-0d1124163215@quicinc.com>
Date:   Thu, 16 Feb 2023 08:41:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/3] mailbox: Allow direct registration to a channel
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230213232537.2040976-1-quic_eberman@quicinc.com>
 <20230215101732.pbpom3ub3yh75n4w@bogus>
 <d35633ea-4049-6f51-3a3a-2a258a4af037@quicinc.com>
 <20230216095816.rzhxa2qdexy3ulrz@bogus>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230216095816.rzhxa2qdexy3ulrz@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IDsd8l1mKzSoU3nFAtcP9wAlqZCAQCIn
X-Proofpoint-ORIG-GUID: IDsd8l1mKzSoU3nFAtcP9wAlqZCAQCIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_12,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=548
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160145
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2023 1:58 AM, Sudeep Holla wrote:
> On Wed, Feb 15, 2023 at 08:58:10AM -0800, Elliot Berman wrote:
>>
>>
>> On 2/15/2023 2:17 AM, Sudeep Holla wrote:
>>> On Mon, Feb 13, 2023 at 03:25:34PM -0800, Elliot Berman wrote:
>>>> Two mailbox controllers have channel/client binding mechanisms that are
>>>> controller-specific and not using the devicetree binding mechanisms. Mailbox
>>>> channel/client is conceptually done in two steps: selecting the channel
>>>> and binding the selected to channel to a client. Channel selection is sometimes
>>>> controller specific (pcc and omap are examples). The channel/client binding
>>>> code is all the same.
>>>>
>>>> This small series de-duplicates and refactors the channel/client binding
>>>> into a common framework function: "mbox_bind_client" which all of the
>>>> channel selection mechanisms can use.
>>>>
>>>> I found this duplicate code while working on the support for Gunyah hypervisor
>>>> message queues [1]. I've only been able to compile-test omap-maiblox and pcc,
>>>> however it is a straightforward conversion here.
>>>>
>>>> [1]: https://lore.kernel.org/all/20230120224627.4053418-9-quic_eberman@quicinc.com/
>>>>
>>>> Elliot Berman (3):
>>>>     mailbox: Allow direct registration to a channel
>>>
>>> I am unable to find the above patch either in my inbox or in lore[1].
>>> Can you please repost the same ? I would like to test/review w.r.t PCC
>>> driver.
>>>
>>
>> Hi Sudeep,
>>
>> Not sure why the patch didn't end up your inbox; lore seems to have linked
>> it correctly and indicates you were in To:. If I missed something, let me
>> know and I'll make sure you're properly included if future versions needed.
>>
>> https://lore.kernel.org/all/20230213232537.2040976-4-quic_eberman@quicinc.com/
> 
> No, I do have patch 2/3 and 3/3 in my inbox along with the cover letter.
> Patch 1/3 is missing in both my inbox and lore. Can you send me the lore
> link for patch 1/3 if you are able to find it ? Or just repost the series
> if you can't.
> 

Huh, not sure what happened there. I got a copy of Patch 1/3 but I also 
don't see it in lore. Resent:

https://lore.kernel.org/all/20230216163804.456714-1-quic_eberman@quicinc.com/
