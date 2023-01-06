Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A0C66047F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjAFQjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjAFQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:39:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9217378A65;
        Fri,  6 Jan 2023 08:39:03 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306Fn7S8014062;
        Fri, 6 Jan 2023 16:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CeXlX0s+orjC2dhmPD+GUdFg6bkJa/KBwHIzDdgndjc=;
 b=YVPnDWVbH4QHUZEEIXABNJ4jWVDTOAoHn/rryjnn8TjfZvJTC+9CLp7i9Fqpv0ueA9Pg
 fkBrP/Ii53IV7zzkQVF9UmvhMS2groPV8Vwh756rK4CoRqehWiQp+xr/7S2fs3FQmAZB
 KRQNnCUJjcyEB+/jYwnEgEgUfBzRkSUCTGOWzNzBBLwLf98rVGibUGbzBhmWYTThbfGj
 U49fyeX4pxAt2ThKeo15MVMIEK5WpgzSwQ3xJVl7kCMYYkE/jNijLGH9IzbB8N40ekad
 vSiwsFV0bjLj7pKMfb41PUeS/e+SOfXylxnqa6vDWhIU4ezpzxFSh+FgbWGlSem2MBaO 2A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mx3s1terj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 16:38:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 306GcWrX010026
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Jan 2023 16:38:32 GMT
Received: from [10.216.49.11] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 6 Jan 2023
 08:38:29 -0800
Message-ID: <a613ee3e-e45c-f84a-362f-9b0651a83f5e@quicinc.com>
Date:   Fri, 6 Jan 2023 22:08:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: ERRATUM_858921 is broken on 5.15 kernel
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <maz@kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
References: <ca4679a0-7f29-65f4-54b9-c575248192f1@quicinc.com>
 <Y7bar/zQ4khMDyiv@FVFF77S0Q05N>
From:   Yogesh Lal <quic_ylal@quicinc.com>
In-Reply-To: <Y7bar/zQ4khMDyiv@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ikwzcN-muuQhFcwp8rz7yd8rHXxbYNYB
X-Proofpoint-GUID: ikwzcN-muuQhFcwp8rz7yd8rHXxbYNYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_10,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060128
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2023 7:42 PM, Mark Rutland wrote:
> On Thu, Jan 05, 2023 at 07:03:48PM +0530, Yogesh Lal wrote:
>> Hi,
>>
>> We are observing issue on A73 core where ERRATUM_858921 is broken.
> Do you *only* see this issue on v5.15.y, or is mainline (e.g. v6.2-rc2) also
> broken?

Checked the code path and looks like its broken on mainline also.

> I don't see any fix that fits your exact description below, but I do see that
> we've made a bunch of changes in this area since.
>
>> On 5.15 kernel arch_timer_enable_workaround is set by reading
>> arm64_858921_read_cntpct_el0 and arm64_858921_read_cntvct_el0 during timer
>> register using following path.
>>
>> arch_timer_enable_workaround->atomic_set(&timer_unstable_counter_workaround_in_use,
>> 1);
>>
>> [code snap]
>> 564 static
>> 565 void arch_timer_enable_workaround(const struct
>> arch_timer_erratum_workaround *wa,
>> 566                               bool local)
>> 567 {
>> 568     int i;
>> 569
>> 570     if (local) {
>> 571 __this_cpu_write(timer_unstable_counter_workaround, wa);
>> 572     } else {
>> 573             for_each_possible_cpu(i)
>> 574                     per_cpu(timer_unstable_counter_workaround, i) = wa;
>> 575     }
>> 576
>> 577     if (wa->read_cntvct_el0 || wa->read_cntpct_el0)
>> 578 atomic_set(&timer_unstable_counter_workaround_in_use, 1);
>>
>>
>> and based on above workaround enablement , appropriate function to get
>> counter is used.
>>
>> 1008 static void __init arch_counter_register(unsigned type)
>> 1009 {
>> 1010     u64 start_count;
>> 1011
>> 1012     /* Register the CP15 based counter if we have one */
>> 1013     if (type & ARCH_TIMER_TYPE_CP15) {
>> 1014         u64 (*rd)(void);
>> 1015
>> 1016         if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
>> 1017             arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
>> 1018             if (arch_timer_counter_has_wa())
>> 1019                 rd = arch_counter_get_cntvct_stable;
>> 1020             else
>> 1021                 rd = arch_counter_get_cntvct;
>> 1022         } else {
>> 1023             if (arch_timer_counter_has_wa())
>> 1024                 rd = arch_counter_get_cntpct_stable;
>> 1025             else
>> 1026                 rd = arch_counter_get_cntpct;
>> 1027         }
>> [snap]
>> 1043     /* 56 bits minimum, so we assume worst case rollover */
>> 1044     sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
>>
>>
>> As our boot cores are not impacted by errata sched_clock_register() will
>> register !arch_timer_counter_has_wa() callback.
> It would be helpful to mention this fact (that the system is big.LITTLE, and
> the boot cores are not Cortex-A73) earlier in the report.
will take care
>
>> Now when errata impacted core boots up and sched_clock_register already
>> register will !arch_timer_counter_has_wa() path.
>> As sched_clock_register is not per_cpu bases so arch_timer_read_counter will
>> always point to !arch_timer_counter_has_wa() function calls.
> Hmm... yes, AFAICT this cannot work unless the affected CPUs are up before we
> probe, and it doesn't make much sense for arch_counter_register() to look at
> arch_timer_counter_has_wa() since it can be called before all CPUs are up.
>
>> Looks like this bug is side effect of following patch:
>>
>> commit 0ea415390cd345b7d09e8c9ebd4b68adfe873043
>> Author: Marc Zyngier <marc.zyngier@arm.com>
>> Date:   Mon Apr 8 16:49:07 2019 +0100
>>
>>      clocksource/arm_arch_timer: Use arch_timer_read_counter to access stable
>> counters
>>
>>      Instead of always going via arch_counter_get_cntvct_stable to access the
>>      counter workaround, let's have arch_timer_read_counter point to the
>>      right method.
>>
>>      For that, we need to track whether any CPU in the system has a
>>      workaround for the counter. This is done by having an atomic variable
>>      tracking this.
>>
>>      Acked-by: Mark Rutland <mark.rutland@arm.com>
>>      Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>      Signed-off-by: Will Deacon <will.deacon@arm.com>
>>
> Yeah, that does look to be broken, but I think there are futher issues anyway
> (e.g. late onlining).
>
> AFAICT we need to detect this *stupidly early* in the CPU bringup path in order
> to handle this safely, which is quite painful.
>
> What a great.
>
> Thanks,
> Mark.
