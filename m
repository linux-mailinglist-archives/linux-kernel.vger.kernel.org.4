Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7171D65D78A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbjADPtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbjADPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:49:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC64395CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:49:22 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304Dx1pJ031849;
        Wed, 4 Jan 2023 15:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4lJyuPNiQW8qHMyevoofdcjpd8Ynmga4SEw5YlgIFfQ=;
 b=lRahzr0H5zcjV8Ny97tG2dQSqHh3UeJLvDmnoESJGcX6BWZpEk4nC8GiKBdxvn9VyP53
 4Kw6yv2edlJdWC9yTLDRKhHKLKZlG3pywNE7FgUOqnjuyjPdiXFxz9C2m2uGXtK8rH5G
 8rpaFXF9Ab7YJ41r8aZMXeKGY4r6MDZ9Kf4bwXn2pKp4MZWm+/6EOy0sfQNIgkoYdpE8
 3zwGW+XhdNT3vI6C1v1WkygWCCOFDWgYmKwCt9sbgLVM7rqSM7VckiNxHSfDDuToreKc
 FYp4tlMJbujIVweUE/fMYrYF9PZ1VcrWlAj1M+B4DbOLy+YQDghCEIcWD0NCv4Ul8dGG 3g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvva8nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 15:49:19 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 304FnIQo025356
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 15:49:18 GMT
Received: from [10.216.46.206] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 4 Jan 2023
 07:49:16 -0800
Message-ID: <c40486a0-2e5f-bbdb-c93b-8740154fce78@quicinc.com>
Date:   Wed, 4 Jan 2023 21:19:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Query about IPI as NMI (pseudo-NMI) support patches
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>
References: <5bed08c5-8663-4e68-27b4-8b6d3957a880@quicinc.com>
 <86zgb07tfs.wl-maz@kernel.org>
 <a20a9592-05e7-c529-5ab1-d7d52fffa59a@quicinc.com>
 <86v8ln7bqw.wl-maz@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <86v8ln7bqw.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KDubjNrGhlNAd3y3YB1UJQwrtPcFdhA8
X-Proofpoint-GUID: KDubjNrGhlNAd3y3YB1UJQwrtPcFdhA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1031 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040131
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thanks for your patience in replying queries

On 1/3/2023 11:15 PM, Marc Zyngier wrote:
> On Tue, 03 Jan 2023 16:45:04 +0000,
> Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>> Hi,
>>
>> Thanks for your reply.
>>
>> On 1/2/2023 10:41 PM, Marc Zyngier wrote:
>>> Hi Mukesh,
>>>
>>> On Mon, 02 Jan 2023 16:44:59 +0000,
>>> Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>>>
>>>> Hi Marc,
>>>>
>>>> I was looking similar support mentioned in below patch series.
>>>>
>>>> https://lore.kernel.org/lkml/CAFA6WYO0+LQ=mB1spCstt0cNZ0G+sZu_+Wrv6BKSeXqF5SRq4A@mail.gmail.com/#t
>>>>
>>>> Wanted to check if there is chance of these patches to land in
>>>> mainline ?
>>>
>>> I certainly have no intention to merge it as is, specially as there is
>>> no good usage model for it other than "but think of debug!".
>>>
>>> We have exactly *one* SGI left. If we are going to lose it over such a
>>> feature, I'd want a description of how we are going to share it
>>> between potential users, and how we claw some currently used SGIs
>>> back.
>>
>>
>> But, looks like patch will fail if SGI is not available.
>>
>> https://lore.kernel.org/lkml/1604317487-14543-4-git-send-email-sumit.garg@linaro.org/
>>
>>
>>
>> set_smp_ipi_range(base_sgi, 8);
>>
>> +	if (n > nr_ipi)
>> +		set_smp_dynamic_ipi(ipi_base + nr_ipi);
>> +
>>
>> So, static SGI allocation still has higher priority than dynamic
>> one.  Would you be accepting if we keep it under some
>> CONFIG_ARM64_IPI_NMI_DEBUG ?
> 
> But why should this thing have priority over other potential features?
> As I said above, there are two requirements:
> 
> - being able to share a single NMI SGI amongst multiple users
> 
> - being able to free existing SGIs in case we absolutely need an SGI
>    for some other purposes
> 
> In both cases, this is about making the SGI space scale *beyond* the 8
> possible interrupts that we have. This needs to be solved to get
> something like this in.

Agree, we have shortage of SGI's, Will try to think if we can fix this.

However, I think IPI_CPU_STOP is something which can be used as an NMI, 
As this will be used only(once) during panic()->send_smp_stop().

Can we do some special handling for IPI_CPU_STOP similar to pmu 
interrupts like request it as NMI and fallback to normal irq if not 
supported/on error ?


> 
> And I don't think hiding this behind an obscure "debug" configuration
> option that will get abused with out of tree stuff is a good move.
> Quite the opposite.
> 

Thanks, Make sense.

> Thanks,
> 
> 	M.
> 

-Mukesh
