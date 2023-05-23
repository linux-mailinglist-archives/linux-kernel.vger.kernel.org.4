Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE5270D4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjEWHX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjEWHX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:23:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A48109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:23:03 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N5F5Pe011308;
        Tue, 23 May 2023 07:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OS1rzddtJbNukHGnLeVM+JgHde+skfph6hLgMi+ZSws=;
 b=g8eLjS2HirzLmhgXx/Z2rq+EUQ0oX1UX0LrJRWkIpwYq6gtaEEddX3RneeNS8zT16XQ1
 hw9UVwnfDeazIYjPy2BjXxZr60CrzT+Q6WIO1K2PCXSCOopmuIb0oP0VOnXQNrnbpoMI
 rdPUES80vY5Utu9eYo0oZs1UtoAn4buawiQP4PeMnhMFId4dmp9ZTAuX0auR8I8XpU3O
 OTtvX4si9YoFjnTThuE17+FAuoV8sR28dQjJd57X07P1xa4OWxyTqwI6ePFhQD0iOCG5
 y/BSELJmVrQOnn40Xcb//7PaVNrqwb92nJdgvmx34C/WPB/SHMPdEzJqn60OnlxnWaJU TA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qre8p12bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:22:41 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N7Mei9031172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:22:40 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 00:22:34 -0700
Message-ID: <4fb844d4-cb8e-94af-b2bc-2d1e8ea83c09@quicinc.com>
Date:   Tue, 23 May 2023 12:52:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] sched: fair: hide unused init_cfs_bandwidth() stub
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
 <20230522195021.3456768-4-arnd@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230522195021.3456768-4-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _t_YuRBTnmBYE19UOOCtPmq0YYl8eTHr
X-Proofpoint-GUID: _t_YuRBTnmBYE19UOOCtPmq0YYl8eTHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230060
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2023 1:20 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> init_cfs_bandwidth() is only used when CONFIG_FAIR_GROUP_SCHED is
> enabled, and without this causes a W=1 warning for the missing prototype:
> 
> kernel/sched/fair.c:6131:6: error: no previous prototype for 'init_cfs_bandwidth'
> 
> The normal implementation is only defined for CONFIG_CFS_BANDWIDTH,
> so the stub exists when CFS_BANDWIDTH is disabled but FAIR_GROUP_SCHED
> is enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

> ---
>   kernel/sched/fair.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2c1b345c3b8d..a7a8ccde3bd7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6169,9 +6169,8 @@ static inline int throttled_lb_pair(struct task_group *tg,
>   	return 0;
>   }
>   
> -void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
> -
>   #ifdef CONFIG_FAIR_GROUP_SCHED
> +void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
>   static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
>   #endif
>   
