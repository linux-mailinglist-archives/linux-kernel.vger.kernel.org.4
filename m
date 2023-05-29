Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D707F714509
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjE2Gml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjE2Gmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:42:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F590
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:42:38 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T5DgA8015207;
        Mon, 29 May 2023 06:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Lt0aERUVfRMqik1xWn/SqHWOUfW+VPGCzzaeb6+9Lys=;
 b=kvLROsntxs2633pPXLnE8rFAna0Yo8B6FD/qcGIdAH1I0DIog4tNLeA9araI7myEorW3
 Pj8V9MbuqqMG9rAkvo+LTbfiiGFEks8lePT+ZXZOORSPg9uGZi+/fLA0QRsMhiWfwzdT
 xxFUfF8pqs3UwYN/obW6GXdpdiQuSo3CTnp5CEuJR8M/6T3DKlvjdDkREOMLs4M1RNCQ
 dSMoGUN3sbhQz6o05Z+a1BcNywUDeU7JiaBIO/fM6PowKz/dx4vGz0ImZ8oESG8UT4UM
 IYWZ2oKmczoK993/ze5fNZ7fL9YnLkGrP68HlcxT78aNMaO6WprM+ur32iAvMT3l0ss2 EQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3quatsjqyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 06:42:20 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34T6gJo5000358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 06:42:19 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 28 May
 2023 23:42:16 -0700
Message-ID: <010e31f6-113c-82f5-35fd-be6045610ab4@quicinc.com>
Date:   Mon, 29 May 2023 12:12:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] sched/headers: remove duplicate included header files
Content-Language: en-US
To:     "Yan Yan(cailing)" <yanyan.yan@antgroup.com>,
        <linux-kernel@vger.kernel.org>
CC:     =?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
        <christophe.jaillet@wanadoo.fr>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20230522155341.9420-1-yanyan.yan@antgroup.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230522155341.9420-1-yanyan.yan@antgroup.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9Xywe0xppya-SmWfWl-DXMZMWAGbsyP9
X-Proofpoint-GUID: 9Xywe0xppya-SmWfWl-DXMZMWAGbsyP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_04,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290057
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 9:23 PM, Yan Yan(cailing) wrote:
> These headers are included more than once, some also appear in
> kernel/sched/sched.h, so remove them.
> 
> Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

> ---
>   kernel/sched/build_utility.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
> index 99bdd96f454f..b9ae5fe42f7b 100644
> --- a/kernel/sched/build_utility.c
> +++ b/kernel/sched/build_utility.c
> @@ -13,16 +13,10 @@
>   #include <linux/sched/cputime.h>
>   #include <linux/sched/debug.h>
>   #include <linux/sched/isolation.h>
> -#include <linux/sched/loadavg.h>
>   #include <linux/sched/nohz.h>
> -#include <linux/sched/mm.h>
> -#include <linux/sched/rseq_api.h>
>   #include <linux/sched/task_stack.h>
>   
> -#include <linux/cpufreq.h>
> -#include <linux/cpumask_api.h>
>   #include <linux/cpuset.h>
> -#include <linux/ctype.h>
>   #include <linux/debugfs.h>
>   #include <linux/energy_model.h>
>   #include <linux/hashtable_api.h>
> @@ -32,18 +26,12 @@
>   #include <linux/mempolicy.h>
>   #include <linux/nmi.h>
>   #include <linux/nospec.h>
> -#include <linux/proc_fs.h>
> -#include <linux/psi.h>
> -#include <linux/psi.h>
>   #include <linux/ptrace_api.h>
>   #include <linux/sched_clock.h>
>   #include <linux/security.h>
> -#include <linux/spinlock_api.h>
>   #include <linux/swait_api.h>
>   #include <linux/timex.h>
>   #include <linux/utsname.h>
> -#include <linux/wait_api.h>
> -#include <linux/workqueue_api.h>
>   
>   #include <uapi/linux/prctl.h>
>   #include <uapi/linux/sched/types.h>
