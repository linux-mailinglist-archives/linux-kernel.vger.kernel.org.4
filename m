Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BED70FAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjEXPrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjEXPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:47:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA995189
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:47:06 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OEwfEm013798;
        Wed, 24 May 2023 15:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=555c+N1KLCBpNsCfoq+DIux9X/yt+A+yKnNeQt4/VpQ=;
 b=mIw7inVeJZe+rRm8X2FEmfaqjT4WfkO4nBKzvkhxYe0w7QXt9NVELhNPi2MFQYb8AU09
 yUb9RNSPpdSYY9LR3/5BX959dOqyCMQTpfxb6QOT0utHYV11qMoQujEAmEMRHwqQWtzv
 7gb/dsqqfEhMXinPdOlBD3K/57zJO5Us6fmjD/5ULAB0NvMO7JMRKaBIeLo+7yTXfNMP
 t9SeRT2K6FxaxlWl1OWmyDzWjPUnOZxlQTZ0nrurMHW+vZI8yUpmOJspXMR739Upienw
 rtMheMGJbg1jBqA4AYMZBB6fUDBTKxImHzh6AFl5nICvqTPH4c4OY+rF8Nsaqh0rZ44W hw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs6981xf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 15:45:54 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OFjrLR025253
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 15:45:53 GMT
Received: from [10.216.59.206] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 08:45:47 -0700
Message-ID: <83a47f89-ed95-b283-2fe7-e6f12d2d37fa@quicinc.com>
Date:   Wed, 24 May 2023 21:15:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sched: fix sched_thermal_decay_shift kernel-doc comment
Content-Language: en-US
To:     Chia Chuan Yu <yujuan476@gmail.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230524143241.146399-1-yujuan476@gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230524143241.146399-1-yujuan476@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E1sckYMl5-Exat0kLYbUhlRfQdaPgaOI
X-Proofpoint-GUID: E1sckYMl5-Exat0kLYbUhlRfQdaPgaOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_10,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240129
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/2023 8:02 PM, Chia Chuan Yu wrote:
> The comment for fix sched_thermal_decay_shift is not in kernel-doc format.
> This patch will fix it.
> 
> Signed-off-by: Chia Chuan Yu <yujuan476@gmail.com>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

- Mukesh
> ---
>   kernel/sched/sched.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 678446251c35..b05861f14543 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1512,7 +1512,7 @@ static inline u64 rq_clock_task(struct rq *rq)
>   	return rq->clock_task;
>   }
>   
> -/**
> +/*
>    * By default the decay is the default pelt decay period.
>    * The decay shift can change the decay period in
>    * multiples of 32.
