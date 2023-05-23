Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEFD70D46D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjEWG6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjEWG63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:58:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C95139
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:58:26 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N5cDbj023991;
        Tue, 23 May 2023 06:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ka4hgeKS4iLi6AZuM7zJORjaH4aXUV4J9FYGU0Q1d+I=;
 b=LXK9CrYPPeY805u9vOb9VEE2jRLBbMaeB8etHO5MO1Mbl4KdRqGOvAFK7FcuUqsGSXPp
 IUVjG2IOq6YDCDabvsDQKcXhQVxD69/9cpS8t404fIhTqiUaPxD7O+4SQAUyI4SZ/ggo
 1t0b4UbRbe4I2Ok2kjDN1CUtJKSZugTxEicwu/G4dp38XgWFo8MbxR425l0uSBt/Hk6A
 GA85TNlSm65AIgil+THnt67cjk6izwbDw7Ei+DKdBjd49eJS6Voo8fCZAZlGVKNgZASO
 Sca2jtJGUWYLc+UQAw1UFjJZzQQbhCEC6tcOao3t443ysNupcxZpHQEllL5D0CE+XN3R QA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qre8p10t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 06:58:09 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N6w87K014082
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 06:58:08 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 23:58:04 -0700
Message-ID: <94f4a866-6f72-631e-360e-2e43ddcb466c@quicinc.com>
Date:   Tue, 23 May 2023 12:28:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] sched: fair: move unused stub functions to header
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20230522195021.3456768-1-arnd@kernel.org>
 <20230522195021.3456768-6-arnd@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230522195021.3456768-6-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mDOXb8Cx07sr8keiXBvUXJY_Te-P1dQM
X-Proofpoint-GUID: mDOXb8Cx07sr8keiXBvUXJY_Te-P1dQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=878 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230056
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2023 1:20 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These four functions have a normal definition for CONFIG_FAIR_GROUP_SCHED,
> and empty one that is only referenced when FAIR_GROUP_SCHED is disabled
> but CGROUP_SCHED is still enabled. If both are turned off, the functions
> are still defined but the misisng prototype causes a W=1 warning:

missing ?

> 
> kernel/sched/fair.c:12544:6: error: no previous prototype for 'free_fair_sched_group'
> kernel/sched/fair.c:12546:5: error: no previous prototype for 'alloc_fair_sched_group'
> kernel/sched/fair.c:12553:6: error: no previous prototype for 'online_fair_sched_group'
> kernel/sched/fair.c:12555:6: error: no previous prototype for 'unregister_fair_sched_group'
> 
> Move the alternatives into the header as static inline functions with
> the correct combination of #ifdef checks to avoid the warning without
> adding even more complexity.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

LGTM.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

> ---
>   kernel/sched/fair.c  | 13 -------------
>   kernel/sched/sched.h | 11 +++++++++++
>   2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a7a8ccde3bd7..bae8907c1635 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12602,19 +12602,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
>   	return 0;
>   }
>   
> -#else /* CONFIG_FAIR_GROUP_SCHED */
> -
> -void free_fair_sched_group(struct task_group *tg) { }
> -
> -int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> -{
> -	return 1;
> -}
> -
> -void online_fair_sched_group(struct task_group *tg) { }
> -
> -void unregister_fair_sched_group(struct task_group *tg) { }
> -
>   #endif /* CONFIG_FAIR_GROUP_SCHED */
>   
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d5ac0af1eede..0584fa15ffeb 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -453,10 +453,21 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
>   
>   extern int tg_nop(struct task_group *tg, void *data);
>   
> +#ifdef CONFIG_FAIR_GROUP_SCHED
>   extern void free_fair_sched_group(struct task_group *tg);
>   extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent);
>   extern void online_fair_sched_group(struct task_group *tg);
>   extern void unregister_fair_sched_group(struct task_group *tg);
> +#else
> +static inline void free_fair_sched_group(struct task_group *tg) { }
> +static inline int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> +{
> +       return 1;
> +}
> +static inline void online_fair_sched_group(struct task_group *tg) { }
> +static inline void unregister_fair_sched_group(struct task_group *tg) { }
> +#endif
> +
>   extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
>   			struct sched_entity *se, int cpu,
>   			struct sched_entity *parent);
