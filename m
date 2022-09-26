Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7327B5E97E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 04:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiIZCYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 22:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIZCYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 22:24:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8227B2F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 19:24:11 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q1YOtP006527;
        Mon, 26 Sep 2022 02:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pL5lXV/Bwp9tO/0Weca3iph6KRFwcLc69m/lA7gV6Xs=;
 b=g3q5loGssi3tN06UAWhHpKOx1HrsISDgdTmBDtsoYNpvLQlbQhyCfcuzU6JoXtbO4JhB
 L0MhDfCwuNz6yoUndxSCqbCHdggF84D9aW1ErPp6exYgDx8WIoBq3KGzJ1RPy+rnUcnF
 7z/xYh5jZF5/rRCEDAXaury2MykyfWUl4PJcOwEF+BvTjXubFSmBwxJ6ZZMFQFII9UVn
 woRc9vB2puqZH9lj5wOsnWAjFaQX/1WMB+Q5P1xoYA78OmK5iy4NvC/OWO++CdwckN6V
 Pz9Wb5JnGDdIiRvVo43YYUmrBwsEdg6sruWv0LJxKnWdG6Ksk0Vymc2PuCh1fyXts0Ms pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jstnnatsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 02:24:00 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q2H03Z016726;
        Mon, 26 Sep 2022 02:18:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jstykc7g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 02:18:59 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28Q2Gxe0016714;
        Mon, 26 Sep 2022 02:18:59 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 28Q2Ixkb018839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 02:18:59 +0000
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 25 Sep
 2022 19:18:57 -0700
Message-ID: <fee4b5ec-0e0d-8158-7e60-90f0918cab51@quicinc.com>
Date:   Mon, 26 Sep 2022 10:18:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v2] cgroup: align the comm length with TASK_COMM_LEN
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <tj@kernel.org>,
        <william.kucharski@oracle.com>, <linux-kernel@vger.kernel.org>
References: <20220923075105.28251-1-quic_yingangl@quicinc.com>
 <20220923110044.7261afa0@gandalf.local.home>
Content-Language: en-US
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <20220923110044.7261afa0@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xcAbFbI6CnfY7rb6SdVsAbGLv-nb4F9k
X-Proofpoint-ORIG-GUID: xcAbFbI6CnfY7rb6SdVsAbGLv-nb4F9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 mlxlogscore=897
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209260014
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/2022 11:00 PM, Steven Rostedt wrote:
> On Fri, 23 Sep 2022 15:51:05 +0800
> Kassey Li <quic_yingangl@quicinc.com> wrote:
> 
>> __string could get a dst string with length less than
>> TASK_COMM_LEN.
>>
>> A task->comm may change that can cause out of bounds access
>> for the dst string buffer, e.g in the call trace of below:
>>
>> Call trace:
>>
>>      dump_backtrace.cfi_jt+0x0/0x4
>>      show_stack+0x14/0x1c
>>      dump_stack+0xa0/0xd8
>>      die_callback+0x248/0x24c
>>      notify_die+0x7c/0xf8
>>      die+0xac/0x290
>>      die_kernel_fault+0x88/0x98
>>      die_kernel_fault+0x0/0x98
>>      do_page_fault+0xa0/0x544
>>      do_mem_abort+0x60/0x10c
>>      el1_da+0x1c/0xc4
>>      trace_event_raw_event_cgroup_migrate+0x124/0x170
>>      cgroup_attach_task+0x2e8/0x41c
>>      __cgroup1_procs_write+0x114/0x1ec
>>      cgroup1_tasks_write+0x10/0x18
>>      cgroup_file_write+0xa4/0x208
>>      kernfs_fop_write+0x1f0/0x2f4
>>      __vfs_write+0x5c/0x200
>>      vfs_write+0xe0/0x1a0
>>      ksys_write+0x74/0xdc
>>      __arm64_sys_write+0x18/0x20
>>      el0_svc_common+0xc0/0x1a4
>>      el0_svc_compat_handler+0x18/0x20
>>      el0_svc_compat+0x8/0x2c
>>
>> Change it as arrary with same length TASK_COMM_LEN,
>> This idea is from commit d1eb650ff413 ("tracepoint: Move signal sending
>> tracepoint to events/signal.h").
> 
> This does not make sense. What exactly is the bug here?
hi, Steven:
     hope below info can give you idea on this , let me know if you need 
more info.

kernel log:
	Unable to handle kernel write to read-only memory at virtual address 
ffffffbcf7450000

"SharedPreferenc" is task name/comm.

memory/ddr dump:

   FFFFFFBCF744FFE0| 00090020 000B0029 706F742F 7070612D 61685300 
50646572 65666572 636E6572  ...).../top-app.SharedPreferenc
   FFFFFFBCF7450000|>52800101 97FD3A05 140000B3 AA1303E0 9400193C 
B0000F88 90000D89 9137FD08 ...R.:..........<.............7.

trace stack:

-000|strcpy(inline)
-000|trace_event_raw_event_cgroup_migrate
-001|trace_cgroup_attach_task(inline)
-001|cgroup_attach_task()
-002|__read_once_size(inline)
-002|atomic_read(inline)
-002|static_key_count(inline)
-002|static_key_false(inline)
-002|trace_android_vh_cgroup_set_task(inline)
-002|__cgroup1_procs_write()
-003|cgroup1_tasks_write
-004|cgroup_file_write
-005|kernfs_fop_write$
-006|__vfs_write()
-007|vfs_write()
-008|ksys_write()
-009|__se_sys_write(inline)
-009|__arm64_sys_write()
-010|__invoke_syscall(inline)
-010|invoke_syscall(inline)
-010|el0_svc_common()
-011|el0_svc_compat_handler()
-012|el0_svc_compat(asm)




> 
> __string() will do a strlen(task->comm) + 1 to allocate on the ring buffer.
> It should not be less that task->comm. The above stack dump does not show
> what happened.
> 
> This looks like another bug and I do not see how this patch addresses
> the issue.
> 
> -- Steve
> 
>>
>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>> ---
>>   include/trace/events/cgroup.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
>> index dd7d7c9efecd..b4ef0ffa38a4 100644
>> --- a/include/trace/events/cgroup.h
>> +++ b/include/trace/events/cgroup.h
>> @@ -130,7 +130,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>>   		__field(	u64,		dst_id			)
>>   		__field(	int,		pid			)
>>   		__string(	dst_path,	path			)
>> -		__string(	comm,		task->comm		)
>> +		__array(char, comm, TASK_COMM_LEN)
>>   	),
>>   
>>   	TP_fast_assign(
>> @@ -139,12 +139,12 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>>   		__entry->dst_level = dst_cgrp->level;
>>   		__assign_str(dst_path, path);
>>   		__entry->pid = task->pid;
>> -		__assign_str(comm, task->comm);
>> +		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
	I think the problem is here, __assign_str using strcpy
	the task->comm here tail is not '\0'
	that's why it out of bounds access.

	do you want to this version or just modify the memcpy or strncpy to do 
with a known length ?  please give suggest so I can modify .

>>   	),
>>   
>>   	TP_printk("dst_root=%d dst_id=%llu dst_level=%d dst_path=%s pid=%d comm=%s",
>>   		  __entry->dst_root, __entry->dst_id, __entry->dst_level,
>> -		  __get_str(dst_path), __entry->pid, __get_str(comm))
>> +		  __get_str(dst_path), __entry->pid, __entry->comm)
>>   );
>>   
>>   DEFINE_EVENT(cgroup_migrate, cgroup_attach_task,
> 
