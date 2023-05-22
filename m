Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A6470B661
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjEVHVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjEVHVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:21:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55E1BEC
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:19:12 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M6Zn5D018168;
        Mon, 22 May 2023 07:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dev+AotqgSteoLIrQNW8siA37KMiVPTiUkuvQFzZ/9U=;
 b=UPmhw+VeQuHO9oSvdRUxxmIbvPOikbxqWtBFSVNa+EglU2LAE/I6sgdLaXJZDICKxH71
 /CCl2Wo5fYz0Nd4DeMcpP4ttMJMb83Nc39Dv6mX9DB6hxdCIKP/jyKXr6YKYy4g98t0H
 CNxm/n+IesM3PfID/wW629EJAxvZ5TpT6DUTflgAkhexDPM82aubwQKxpS5kE6vquv34
 8USm8CH2Xiydq1yv6IXycBAJVrUtULC+4IMcIuPrgXnuADeYaplVUVMgYohCb/pkXUIa
 vcrjoe4fppnRGUdJMeEPeZnSSI9057NjO/Lbl/57dswC5U7GtvLcPMtF2tycpTyqIzmq Gw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppa1axp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 07:17:58 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34M7HvLn000517
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 07:17:57 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 00:17:53 -0700
Message-ID: <b5e6a3b7-aa72-1070-cb96-abf0a816884d@quicinc.com>
Date:   Mon, 22 May 2023 12:47:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_sched=3a_deadline=3a_Remove_unnecessary?=
 =?UTF-8?B?IOKAmE5VTEzigJkgdmFsdWVzIGZyb20gZGxfdGFza19vZmZsaW5lX21pZ3JhdGlv?=
 =?UTF-8?Q?n?=
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20230523234101.3439-1-zeming@nfschina.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230523234101.3439-1-zeming@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P2wUOJHhJrmtJ6_fEIRw2eEVcG85HaSg
X-Proofpoint-ORIG-GUID: P2wUOJHhJrmtJ6_fEIRw2eEVcG85HaSg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220061
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/2023 5:11 AM, Li zeming wrote:
> later_rq is assigned first, so it does not need to initialize the
> assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>   kernel/sched/deadline.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5a9a4b81c972..d823e608c7f0 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -667,7 +667,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq);
>   
>   static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p)
>   {
> -	struct rq *later_rq = NULL;
> +	struct rq *later_rq;
>   	struct dl_bw *dl_b;
>   
>   	later_rq = find_lock_later_rq(p, rq);

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh
