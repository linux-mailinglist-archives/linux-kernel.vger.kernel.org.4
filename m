Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E002D5B943A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIOGUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIOGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:20:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107A786C12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 23:20:36 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F4fTj5027215;
        Thu, 15 Sep 2022 06:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=0QCkSf6gFwxLMIZPx2yxReIVBzztJVmr8VKWdZE286E=;
 b=UOWDyaiNRww9eK/j3dO/1kBE3YgT9lXeRkv3fDsqw/lTpSimKhUMAGWf4yOuXC5FtVAF
 ymrqZmx2XTGY+VTETxF21FrlRHYcGqoOq+Y4fhu6n4JhRfi3gQiVj90BYKWH09V2livF
 wpZ//PANXmbjgzkvv6a18du9XzwcHB5cLn/DBsO5GMHizNy1v0YoreV0ncK7Su4wbaXB
 oLJn32tb9K8X1htVkceVnEo2ZLPbUOdtaEcsLK/lI0LONeeEetO8Gs5AXWhNwwxCsksW
 v1dsu+KPJQhkYUQz8kF0vzmhvUDSf4FOZwDrAHZx1I0U3Z7eaJ6XrpOBRjHd1EvGm7nm UQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jkd9hu5vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 06:20:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28F6KXG3025600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 06:20:33 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 14 Sep 2022 23:20:31 -0700
Date:   Thu, 15 Sep 2022 11:50:27 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
CC:     <linux-kernel@vger.kernel.org>, <quic_charante@quicinc.com>
Subject: Re: PSI idle-shutoff
Message-ID: <20220915062027.GA14713@hu-pkondeti-hyd.qualcomm.com>
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AyIrcLYdueU_5JJqEPFa0cOwIXdh6XgJ
X-Proofpoint-GUID: AyIrcLYdueU_5JJqEPFa0cOwIXdh6XgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_02,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150033
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 07:38:17PM +0530, Pavan Kondeti wrote:
> Hi
> 
> The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
> run from a kworker thread, PSI_NONIDLE condition would be observed as
> there is a RUNNING task. So we would always end up re-arming the work.
> 
> If the work is re-armed from the psi_avgs_work() it self, the backing off
> logic in psi_task_change() (will be moved to psi_task_switch soon) can't
> help. The work is already scheduled. so we don't do anything there.
> 
> Probably I am missing some thing here. Can you please clarify how we
> shut off re-arming the psi avg work?
> 

I have collected traces on an idle system (running android12-5.10 with minimal
user space). This is a older kernel, however the issue remain on latest kernel
as per code inspection.

I have eliminated noise created by other work items. For example, vmstat_work.
This is a deferrable work but gets executed since this is queued on the same
CPU on which PSI work timer is queued. So I have increased
sysctl_stat_interval to 60 * HZ to supress this work.

As we can see from the traces, CPU#7 comes out of idle only to execute PSI
work for every 2 seconds. The work is always re-armed from the psi_avgs_work()
as it finds PSI_NONIDLE condition. The non-idle time is essentially

non_idle_time = (work_start_now - wakeup_now) + (sleep_prev - work_end_prev)

The first term accounts the non-idle time since the task woken up (queued) to
the execution of the work item. It is around ~4 usec (54.119420 - 54.119416)

The second term account for the previous update. ~2 usec (52.135424 -
52.135422).

PSI work needs to be run when there is some activity after the last update is done
i.e last time the work is run. Since we use non-deferrable timer, the other
deferrable timers gets woken up and they might queue work or wakeup other threads
and creates activity which inturn makes PSI work to be scheduled.

PSI work can't just be made deferrable work. Because, it is a system level
work and if the CPU on which it is queued is idle for longer duration but the
other CPUs are active, we miss PSI updates. What we probably need is a global
deferrable timers [1] i.e this timer should not be bound to any CPU but
run when any of the CPU comes out of idle. As long as one CPU is busy, we keep
running the PSI but if the whole system is idle, we never wakeup.

          <idle>-0     [007]    52.135402: cpu_idle:             state=4294967295 cpu_id=7
          <idle>-0     [007]    52.135415: workqueue_activate_work: work struct 0xffffffc011bd5010
          <idle>-0     [007]    52.135417: sched_wakeup:         comm=kworker/7:3 pid=196 prio=120 target_cpu=007
          <idle>-0     [007]    52.135421: sched_switch:         prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/7:3 next_pid=196 next_prio=120
     kworker/7:3-196   [007]    52.135421: workqueue_execute_start: work struct 0xffffffc011bd5010: function psi_avgs_work
     kworker/7:3-196   [007]    52.135422: timer_start:          timer=0xffffffc011bd5040 function=delayed_work_timer_fn expires=4294905814 [timeout=494] cpu=7 idx=123 flags=D|P|I
     kworker/7:3-196   [007]    52.135422: workqueue_execute_end: work struct 0xffffffc011bd5010: function psi_avgs_work
     kworker/7:3-196   [007]    52.135424: sched_switch:         prev_comm=kworker/7:3 prev_pid=196 prev_prio=120 prev_state=I ==> next_comm=swapper/7 next_pid=0 next_prio=120
          <idle>-0     [007]    52.135428: cpu_idle:             state=0 cpu_id=7

	  <system is idle and gets woken up after 2 seconds due to PSI work>

          <idle>-0     [007]    54.119402: cpu_idle:             state=4294967295 cpu_id=7
          <idle>-0     [007]    54.119414: workqueue_activate_work: work struct 0xffffffc011bd5010
          <idle>-0     [007]    54.119416: sched_wakeup:         comm=kworker/7:3 pid=196 prio=120 target_cpu=007
          <idle>-0     [007]    54.119420: sched_switch:         prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/7:3 next_pid=196 next_prio=120
     kworker/7:3-196   [007]    54.119420: workqueue_execute_start: work struct 0xffffffc011bd5010: function psi_avgs_work
     kworker/7:3-196   [007]    54.119421: timer_start:          timer=0xffffffc011bd5040 function=delayed_work_timer_fn expires=4294906315 [timeout=499] cpu=7 idx=122 flags=D|P|I
     kworker/7:3-196   [007]    54.119422: workqueue_execute_end: work struct 0xffffffc011bd5010: function psi_avgs_work

[1]
https://lore.kernel.org/lkml/1430188744-24737-1-git-send-email-joonwoop@codeaurora.org/

Thanks,
Pavan
