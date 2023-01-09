Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFB2661ED9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 07:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjAIGw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 01:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjAIGwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:52:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C12C6;
        Sun,  8 Jan 2023 22:52:54 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3096qQF4006380;
        Mon, 9 Jan 2023 06:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/4LTZOeHs3JtCWA0sn1Y+q63qqWVR6fK/3fO1Ovfnvw=;
 b=esauW/ZPQ+Ne4N13Y1vNFx1x8Sy8rwaNwU6ynOLNno2BDe7FxBLv8WXK01o9YE3g2JjS
 PJCx7JIdYp+gh+1Z3ZELCyyOFkrEhctd/FIea9zqeso36FCyRlcZe0TTZ6r0M9jgxAN3
 epW9lshTB3xaFNy63abkIyoNvSJXJAzMitd5OMMu1uwrjSmZvP2FloKs6jAGLm80++cH
 LY7h7nuTVg+nQBXpTn2vrEoL9+/TQ6mBIOKhon0e8JtUmuJ4VIr7ap+s14NtSVltTBVC
 natddfiZ2eWOeLEO88Gt21J7GP95zJoPZfEWpgc+dJr7Y7/qUwPgpdFIBqcZgQ+7a1gJ lw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my1grjevt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 06:52:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3096qSp0021567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 06:52:28 GMT
Received: from [10.216.44.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 8 Jan 2023
 22:52:25 -0800
Message-ID: <9aafa9d9-70f8-67de-df43-e2fb282a4a67@quicinc.com>
Date:   Mon, 9 Jan 2023 12:22:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: ERRATUM_858921 is broken on 5.15 kernel
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     <mark.rutland@arm.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
References: <ca4679a0-7f29-65f4-54b9-c575248192f1@quicinc.com>
 <86sfgpnjsg.wl-maz@kernel.org>
From:   Yogesh Lal <quic_ylal@quicinc.com>
In-Reply-To: <86sfgpnjsg.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 350X-AN40CTTsfrzKc2-li_M-kLguSBE
X-Proofpoint-GUID: 350X-AN40CTTsfrzKc2-li_M-kLguSBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_02,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090048
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2023 7:52 PM, Marc Zyngier wrote:
> On Thu, 05 Jan 2023 13:33:48 +0000,
> Yogesh Lal <quic_ylal@quicinc.com> wrote:
>> Hi,
>>
>> We are observing issue on A73 core where ERRATUM_858921 is broken.
>>
>> On 5.15 kernel arch_timer_enable_workaround is set by reading
>> arm64_858921_read_cntpct_el0 and arm64_858921_read_cntvct_el0 during
>> timer register using following path.
> Have you checked whether the issue is still present on 6.1?
yes, its preset there as well.
>
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
>> As our boot cores are not impacted by errata sched_clock_register()
>> will register !arch_timer_counter_has_wa() callback.
>>
>> Now when errata impacted core boots up and sched_clock_register
>> already register will !arch_timer_counter_has_wa() path.
>> As sched_clock_register is not per_cpu bases so
>> arch_timer_read_counter will always point to
>> !arch_timer_counter_has_wa() function calls.
> Please try the following hack, only compile tested as I do not have
> access to any affected HW, and report whether this solves your issue
> or not. Note that this is based on 6.2-rc2.

tested it on affected h/w but looks like sched_clock is still pointing 
to !arch_timer_counter_has_wa() function calls,
may be due to sched_clock_register will register once during non errata 
impacted core booting.

1007 static void __init arch_counter_register(unsigned type)
1008 {
[snap]
1043     /* 56 bits minimum, so we assume worst case rollover */
1044     sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);


Also update_clock_read_data will called with 
!arch_timer_counter_has_wa() read function calls.

153 void sched_clock_register(u64 (*read)(void), int bits, unsigned long 
rate)
[snap]
183     cd.actual_read_sched_clock = read;
184
185     rd.read_sched_clock    = read;
186     rd.sched_clock_mask    = new_mask;
187     rd.mult            = new_mult;
188     rd.shift        = new_shift;
189     rd.epoch_cyc        = new_epoch;
190     rd.epoch_ns        = ns;
191
192     update_clock_read_data(&rd);

> Thanks,
>
> 	M.
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index e09d4427f604..a7cf0a2c86d3 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -230,6 +230,28 @@ static u64 arch_counter_read_cc(const struct cyclecounter *cc)
>   	return arch_timer_read_counter();
>   }
>   
> +static bool arch_timer_counter_has_wa(void);
> +
> +static u64 (*arch_counter_get_read_fn(void))(void)
> +{
> +	u64 (*rd)(void);
> +
> +	if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
> +	    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
> +		if (arch_timer_counter_has_wa())
> +			rd = arch_counter_get_cntvct_stable;
> +		else
> +			rd = arch_counter_get_cntvct;
> +	} else {
> +		if (arch_timer_counter_has_wa())
> +			rd = arch_counter_get_cntpct_stable;
> +		else
> +			rd = arch_counter_get_cntpct;
> +	}
> +
> +	return rd;
> +}
> +
>   static struct clocksource clocksource_counter = {
>   	.name	= "arch_sys_counter",
>   	.id	= CSID_ARM_ARCH_COUNTER,
> @@ -571,8 +593,10 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
>   			per_cpu(timer_unstable_counter_workaround, i) = wa;
>   	}
>   
> -	if (wa->read_cntvct_el0 || wa->read_cntpct_el0)
> +	if (wa->read_cntvct_el0 || wa->read_cntpct_el0) {
>   		atomic_set(&timer_unstable_counter_workaround_in_use, 1);
> +		arch_timer_read_counter = arch_counter_get_read_fn();
> +	}
>   
>   	/*
>   	 * Don't use the vdso fastpath if errata require using the
> @@ -641,7 +665,7 @@ static bool arch_timer_counter_has_wa(void)
>   #else
>   #define arch_timer_check_ool_workaround(t,a)		do { } while(0)
>   #define arch_timer_this_cpu_has_cntvct_wa()		({false;})
> -#define arch_timer_counter_has_wa()			({false;})
> +static bool arch_timer_counter_has_wa(void)		{ return false; }
>   #endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
>   
>   static __always_inline irqreturn_t timer_handler(const int access,
> @@ -1079,22 +1103,7 @@ static void __init arch_counter_register(unsigned type)
>   
>   	/* Register the CP15 based counter if we have one */
>   	if (type & ARCH_TIMER_TYPE_CP15) {
> -		u64 (*rd)(void);
> -
> -		if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
> -		    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
> -			if (arch_timer_counter_has_wa())
> -				rd = arch_counter_get_cntvct_stable;
> -			else
> -				rd = arch_counter_get_cntvct;
> -		} else {
> -			if (arch_timer_counter_has_wa())
> -				rd = arch_counter_get_cntpct_stable;
> -			else
> -				rd = arch_counter_get_cntpct;
> -		}
> -
> -		arch_timer_read_counter = rd;
> +		arch_timer_read_counter = arch_counter_get_read_fn();
>   		clocksource_counter.vdso_clock_mode = vdso_default;
>   	} else {
>   		arch_timer_read_counter = arch_counter_get_cntvct_mem;
>
