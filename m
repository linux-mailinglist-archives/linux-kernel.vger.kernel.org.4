Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE25E5770
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 02:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIVAjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 20:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIVAjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:39:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2DFA98D5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 17:39:00 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28M0EEY7015983;
        Thu, 22 Sep 2022 00:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WOKnIKyfnSQpXihINowX2QmhIeEEpjddrkKFnyBcaDQ=;
 b=PnW0qtQehedV7849wzvDD0pzXZlxvWyyLSXQ6kEPqmjd8pIIEL43uYUbAPdxh09QXwMv
 uGLnQ5IQFgM6r+J2d3EF49b+wdhn4/cneeroH4Hbwwx8OueTS/P6G/TlQQmbwgTm8WHy
 nToRy8CidvUN7KCHpwujpskGV4TjCU51uBNMA9FSvWBEkET/QPJUzVyugWzwrFzscmK/
 PHam23hjy2OZGt8YrHrNsZrFoa6VpZ8VTxLk2FIVAwV9MHOiBpDvqIoIOa3nkca9kq/O
 9kJX/YYdDL0tQq5D/t2hvTCYn4EGxVSjwgSEEefIGz3yuDvlDoSrrQt/UOv/wxYAOliU dQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jr4ge1pwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 00:38:46 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28M0Q3M8032182;
        Thu, 22 Sep 2022 00:33:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jnqr800b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 00:33:40 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28M0Xd0g008432;
        Thu, 22 Sep 2022 00:33:39 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 28M0Xdii008430
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 00:33:39 +0000
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 17:33:38 -0700
Message-ID: <feb725ce-6368-d499-a28e-db1ecdfc03d3@quicinc.com>
Date:   Thu, 22 Sep 2022 08:33:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
From:   Kassey Li <quic_yingangl@quicinc.com>
Subject: Re: [PATCH] cgroup: align the comm length with TASK_COMM_LEN
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <tj@kernel.org>,
        <william.kucharski@oracle.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20220920084923.18476-1-quic_yingangl@quicinc.com>
Content-Language: en-US
In-Reply-To: <20220920084923.18476-1-quic_yingangl@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S2d9lGKw8KUWOXQfboA_4O-kfBG6L4KA
X-Proofpoint-ORIG-GUID: S2d9lGKw8KUWOXQfboA_4O-kfBG6L4KA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_13,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=677 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220002
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello:
    here is the instance of the problem：
    may you kindly review this change  ?

Unable to handle kernel write to read-only memory at virtual address 
ffffffbcf7450000

Call trace:
  dump_backtrace.cfi_jt+0x0/0x4
  show_stack+0x14/0x1c
  dump_stack+0xa0/0xd8
  die_callback+0x248/0x24c
  notify_die+0x7c/0xf8
  die+0xac/0x290
  die_kernel_fault+0x88/0x98
  die_kernel_fault+0x0/0x98
  do_page_fault+0xa0/0x544
  do_mem_abort+0x60/0x10c
  el1_da+0x1c/0xc4
  trace_event_raw_event_cgroup_migrate+0x124/0x170
  cgroup_attach_task+0x2e8/0x41c
  __cgroup1_procs_write+0x114/0x1ec
  cgroup1_tasks_write+0x10/0x18
  cgroup_file_write+0xa4/0x208
  kernfs_fop_write+0x1f0/0x2f4
  __vfs_write+0x5c/0x200
  vfs_write+0xe0/0x1a0
  ksys_write+0x74/0xdc
  __arm64_sys_write+0x18/0x20
  el0_svc_common+0xc0/0x1a4
  el0_svc_compat_handler+0x18/0x20
  el0_svc_compat+0x8/0x2c



On 9/20/2022 4:49 PM, Kassey Li wrote:
> __string could get a dst string with length less than
> TASK_COMM_LEN.
> 
> a task->comm possbile change dynamic that can cause
> out of bounds access for the dst string buffer.
> 
> change it as arrary with same length TASK_COMM_LEN,
> this aligns the same usage of include/trace on task->comm.
> 
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>   include/trace/events/cgroup.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
> index dd7d7c9efecd..d0c5f93e3611 100644
> --- a/include/trace/events/cgroup.h
> +++ b/include/trace/events/cgroup.h
> @@ -130,7 +130,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>   		__field(	u64,		dst_id			)
>   		__field(	int,		pid			)
>   		__string(	dst_path,	path			)
> -		__string(	comm,		task->comm		)
> +		__array(char,   comm, TASK_COMM_LEN)
>   	),
>   
>   	TP_fast_assign(
> @@ -139,12 +139,12 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>   		__entry->dst_level = dst_cgrp->level;
>   		__assign_str(dst_path, path);
>   		__entry->pid = task->pid;
> -		__assign_str(comm, task->comm);
> +		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
>   	),
>   
>   	TP_printk("dst_root=%d dst_id=%llu dst_level=%d dst_path=%s pid=%d comm=%s",
>   		  __entry->dst_root, __entry->dst_id, __entry->dst_level,
> -		  __get_str(dst_path), __entry->pid, __get_str(comm))
> +		  __get_str(dst_path), __entry->pid, __entry->comm)
>   );
>   
>   DEFINE_EVENT(cgroup_migrate, cgroup_attach_task,
