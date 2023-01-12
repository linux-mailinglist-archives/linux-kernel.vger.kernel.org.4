Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E1766728C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjALMtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjALMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:48:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01A4D48B;
        Thu, 12 Jan 2023 04:48:22 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CCBNUg005248;
        Thu, 12 Jan 2023 12:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CFdM1omF0Dr/kBzLaSaXcUlDHFRRHkojFaPFXE91R6s=;
 b=FkkwKW/waQJ258WKGrq223clkR/Ze96qDmd9dlFsttqRrvHldNxyconsclh33e2qtS8t
 J7O/+H6a0eJTmKYpTWFcql2QH8Ryrb6PR1/MWMEuM+Z/V3vbvozI+YqCLZ3rM4tDT9nb
 67r8rfN+C3F0QUhJqNxZadGkiqLE2CVuK8jjQnMkhrTKvGFW3q0Rrkg9+Om/g+8xyMBE
 yr6QgG6ooe7fUkBqVgLVZWL5nkCHixju8xP4b/rqB9VEyhJb+NvKTqz/ut+tY0yi1XiJ
 yPVtfm3WI7Db+cFdLPhP6MDZDGR79IMA8m+qnJJPZH7ja3i+UCUm+z/OLsEfqJuqgqcG yQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2fwprctw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 12:47:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30CClkjF001242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 12:47:46 GMT
Received: from [10.216.63.5] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 12 Jan
 2023 04:47:43 -0800
Message-ID: <ac581485-029a-f8e6-4f66-0a21f4e5bf33@quicinc.com>
Date:   Thu, 12 Jan 2023 18:17:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: ERRATUM_858921 is broken on 5.15 kernel
To:     Marc Zyngier <maz@kernel.org>
CC:     <mark.rutland@arm.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
References: <ca4679a0-7f29-65f4-54b9-c575248192f1@quicinc.com>
 <86sfgpnjsg.wl-maz@kernel.org>
 <9aafa9d9-70f8-67de-df43-e2fb282a4a67@quicinc.com>
 <86ilhgng9n.wl-maz@kernel.org>
Content-Language: en-US
From:   Yogesh Lal <quic_ylal@quicinc.com>
In-Reply-To: <86ilhgng9n.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y5Gr1o2smgwGkoC4l4GET-AuZuzdDsNK
X-Proofpoint-ORIG-GUID: y5Gr1o2smgwGkoC4l4GET-AuZuzdDsNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_07,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/2023 4:09 PM, Marc Zyngier wrote:
> On Mon, 09 Jan 2023 06:52:20 +0000,
> Yogesh Lal <quic_ylal@quicinc.com> wrote:
>> tested it on affected h/w but looks like sched_clock is still pointing
>> to !arch_timer_counter_has_wa() function calls,
>> may be due to sched_clock_register will register once during non
>> errata impacted core booting.
> Ah, of course. We register the function itself instead of an
> indirection. Please try this on top of the previous patch.
Thanks for the patch, its working fine now.
>
> Thanks,
>
> 	M.
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index a7cf0a2c86d3..8232c86b9e7c 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -217,7 +217,12 @@ static notrace u64 arch_counter_get_cntvct(void)
>    * to exist on arm64. arm doesn't use this before DT is probed so even
>    * if we don't have the cp15 accessors we won't have a problem.
>    */
> -u64 (*arch_timer_read_counter)(void) __ro_after_init = arch_counter_get_cntvct;
> +static u64 (*__arch_timer_read_counter)(void) __ro_after_init = arch_counter_get_cntvct;
> +
> +u64 arch_timer_read_counter(void)
> +{
> +	return __arch_timer_read_counter();
> +}
>   EXPORT_SYMBOL_GPL(arch_timer_read_counter);
>   
>   static u64 arch_counter_read(struct clocksource *cs)
> @@ -595,7 +600,7 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
>   
>   	if (wa->read_cntvct_el0 || wa->read_cntpct_el0) {
>   		atomic_set(&timer_unstable_counter_workaround_in_use, 1);
> -		arch_timer_read_counter = arch_counter_get_read_fn();
> +		__arch_timer_read_counter = arch_counter_get_read_fn();
>   	}
>   
>   	/*
> @@ -1103,10 +1108,10 @@ static void __init arch_counter_register(unsigned type)
>   
>   	/* Register the CP15 based counter if we have one */
>   	if (type & ARCH_TIMER_TYPE_CP15) {
> -		arch_timer_read_counter = arch_counter_get_read_fn();
> +		__arch_timer_read_counter = arch_counter_get_read_fn();
>   		clocksource_counter.vdso_clock_mode = vdso_default;
>   	} else {
> -		arch_timer_read_counter = arch_counter_get_cntvct_mem;
> +		__arch_timer_read_counter = arch_counter_get_cntvct_mem;
>   	}
>   
>   	width = arch_counter_get_width();
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index e3c3816d19ba..3ac297a756e8 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -89,7 +89,7 @@ struct arch_timer_mem {
>   #ifdef CONFIG_ARM_ARCH_TIMER
>   
>   extern u32 arch_timer_get_rate(void);
> -extern u64 (*arch_timer_read_counter)(void);
> +extern u64 arch_timer_read_counter(void);
>   extern struct arch_timer_kvm_info *arch_timer_get_kvm_info(void);
>   extern bool arch_timer_evtstrm_available(void);
>   
>
