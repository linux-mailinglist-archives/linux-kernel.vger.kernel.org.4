Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A965EEBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiI2C2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiI2C2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:28:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1E106F65
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:28:07 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T161j1016901;
        Thu, 29 Sep 2022 02:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=HtXlvrbeHdiDOnPs6PRb5YdWRt2AZq9egCHt1luwPPo=;
 b=LbDboNjKzJIYkH5CjsMsmQp94Ol25n9Og8c7UTr1vTGFMSBtXJBmFF1nSQX83fyVvUM5
 oyX+5wl6iJj+xxvINL/vh7jOqzYoj8Z4T++NNDEp0fbqD3Zo5nvCv/xPkWyZjmlifU9k
 hU+MKgTdyffXDu0efVQuakgZX5WQcUzVZWWHRZTW73cHMeB5TXN7aCStp+G5klgrXeCB
 KEHG4zeMdc3zopYc4HAw3e4J0ar/RPjX4VkGk/76mKB/ZPVDMzgsS8AIX6+26NjWCUiZ
 7/cTNxjqDmnrFQEE3ZE0vpdyfkGH6BVkZe8WqlJaFh7S4CIr6RPMzKEqefLN98BbFgcD Sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvpuva52x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 02:27:59 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28T2O9Zg013058;
        Thu, 29 Sep 2022 02:27:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3jstyksbfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 02:27:58 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28T2RwOA015810;
        Thu, 29 Sep 2022 02:27:58 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 28T2RwdA015809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 02:27:58 +0000
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 19:27:56 -0700
Date:   Thu, 29 Sep 2022 07:57:52 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Kassey Li <quic_yingangl@quicinc.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_namajain@quicinc.com>
Subject: Re: [PATCH v2] kernel/hung_task: add option to ignore task
Message-ID: <20220929022752.GA28684@hu-pkondeti-hyd.qualcomm.com>
References: <20220928074841.22545-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220928074841.22545-1-quic_yingangl@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 48KfgKXVaTBG248K02K505GSxBddqqkY
X-Proofpoint-ORIG-GUID: 48KfgKXVaTBG248K02K505GSxBddqqkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_01,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290014
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 03:48:41PM +0800, Kassey Li wrote:
> By default, hung_task will iterate the tasklist and check
> state in TASK_UNINTERRUPTIBLE with a given timeout value.
> 
> Here we add an option for task_struct so it can be ignored.
> Set this flag to default true, it do not break the origin design.
> 
> This is useful when we set timeout value to 5s, where we just want
> to detect some tasks interested.
> 
> Suggested-by: Naman Jain <quic_namajain@quicinc.com>
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  include/linux/sched.h | 1 +
>  kernel/fork.c         | 1 +
>  kernel/hung_task.c    | 3 ++-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e7b2f8a5c711..7c8596fea1f6 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1071,6 +1071,7 @@ struct task_struct {
>  #ifdef CONFIG_DETECT_HUNG_TASK
>  	unsigned long			last_switch_count;
>  	unsigned long			last_switch_time;
> +	bool			hung_task_detect;
>  #endif
>  	/* Filesystem information: */
>  	struct fs_struct		*fs;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 90c85b17bf69..5c461a37a26e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1552,6 +1552,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
>  #ifdef CONFIG_DETECT_HUNG_TASK
>  	tsk->last_switch_count = tsk->nvcsw + tsk->nivcsw;
>  	tsk->last_switch_time = 0;
> +	tsk->hung_task_detect = 1;
>  #endif
>  
>  	tsk->mm = NULL;
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index bb2354f73ded..74bf4cef857f 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -119,7 +119,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  	if (sysctl_hung_task_panic) {
>  		console_verbose();
>  		hung_task_show_lock = true;
> -		hung_task_call_panic = true;
> +		if (t->hung_task_detect)
> +			hung_task_call_panic = true;
>  	}
>  
>  	/*
> -- 
> 2.17.1
> 

This patch does not seems to be complete. Do you plan to provide an interface
to set/clear task_struct::hung_task_detect? Please explain the motivation and
the problems solved by this interface.

Thanks,
Pavan
