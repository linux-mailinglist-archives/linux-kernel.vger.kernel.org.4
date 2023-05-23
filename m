Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DC870D47B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjEWHDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjEWHDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:03:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2672F118
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:03:07 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6qFV6025365;
        Tue, 23 May 2023 07:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KdVhtHdOnWIZUYhKerQpaXS/ZJ9W0ck7VHG9hfMhg+c=;
 b=AxAeBoRBrgVIHE8zA5JudeMYpNa5U64tRZ1L87q4vlhRJmx8NuwVe5k+Ltn3iKDP+Glj
 qOB0lhugX597WtMuu0YqMarSF5s1MF6onUflZAuCHGJo5aoliVJrAsM/hMbYH9dTU0Mt
 J24svLZQc0Oq2qAaK670OuYQdlUqycNdhW+9ItGEQUE2tOF1BiEiMQqmepjlmV4rbso4
 jfAm+Ja68jJ17M78Y+rn9XObjgl4pzBS9/gkn1IcxwMXxvjUCyPq/pYlLWBfjZRSZHT1
 Fu/IOtTTEEleJjywCgb+t70d9v6Oitto3D192S4VZVnk9E2R981yvLnDsLRD/DwHCcGB Zw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qraassm1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:02:49 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N72lHL023404
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:02:47 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 00:02:44 -0700
Message-ID: <c183a3d8-f2d8-b31e-4121-5e04c26114d9@quicinc.com>
Date:   Tue, 23 May 2023 12:32:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/5] sched: make task_vruntime_update() prototype visible
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
 <20230522195021.3456768-5-arnd@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230522195021.3456768-5-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DrKuMfCWkakdZ5IECBIsYa3JsZNo8CY5
X-Proofpoint-ORIG-GUID: DrKuMfCWkakdZ5IECBIsYa3JsZNo8CY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230057
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
> Having the prototype next to the caller but not visible to the callee causes
> a W=1 warning:
> 
> kernel/sched/fair.c:11985:6: error: no previous prototype for 'task_vruntime_update' [-Werror=missing-prototypes]
> 
> Move this to a header, as we do for all other function declarations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

> ---
>   kernel/sched/core.c  | 2 --
>   kernel/sched/sched.h | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 044bcdf4181a..aae6ff717c55 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6030,8 +6030,6 @@ static inline struct task_struct *pick_task(struct rq *rq)
>   	BUG(); /* The idle class should always have a runnable task. */
>   }
>   
> -extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
> -
>   static void queue_core_balance(struct rq *rq);
>   
>   static struct task_struct *
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 44b34836bb60..d5ac0af1eede 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1245,6 +1245,7 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
>   
>   bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
>   			bool fi);
> +void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
>   
>   /*
>    * Helpers to check if the CPU's core cookie matches with the task's cookie
