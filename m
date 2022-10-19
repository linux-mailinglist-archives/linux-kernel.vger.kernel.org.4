Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DCF6040C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiJSKQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiJSKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:15:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91EBCC83C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:56:55 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J8R9Kg005365;
        Wed, 19 Oct 2022 09:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=kUhM+JrEkg0GKP4psBk3hHpbvhSJTj3J1WFyWEtx75c=;
 b=eTERFuwERrS0VTtOI6XU8tUNQuJrZiy6C4J+WsOwwQdrtibsAF3hZeMdYu7gEdUBzbCa
 zWztAlKaCRlNffCnkYBhmpaulItVmr7orrayJ0zylqeStQ2UCZ5QoaWyQpN9Kd2nV+4W
 FwNLzoEILBEJFjsZX0xdtZuZT2JE6iGbyU600EJBt8VkPWe0xanNnjj59+Tk5PN3xEZ7
 TB2rUPXYK96qa2DtobUGgSz7L0CcGBamx08XdYJRmY7VIoC0viBwzoeJLUN9X6e6LbXd
 tEpb4a22zz6ojGj5Zbj3rTsqERidT2p55IpxZn98aIDGzaBFmlVEClan/lWXJ6stcm7J Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kadr61nkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:11:44 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29J8RDvA006894;
        Wed, 19 Oct 2022 09:11:43 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kadr61nj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:11:43 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29J97Ffa000507;
        Wed, 19 Oct 2022 09:11:40 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3k7m4jpsqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:11:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29J9BcUM63898108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 09:11:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 750FB42041;
        Wed, 19 Oct 2022 09:11:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 999EB4203F;
        Wed, 19 Oct 2022 09:11:37 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.22.115])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Oct 2022 09:11:37 +0000 (GMT)
Date:   Wed, 19 Oct 2022 11:11:36 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <Y0+/SAWUNRnhIW9b@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WPRcgXgmLT9hponGWhGxy3hFDGgp93eT
X-Proofpoint-GUID: XhhxMP4dFBi-Araji4sDoF6MM2QYBAdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_05,2022-10-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 mlxlogscore=840 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 08:42:53PM -0700, John Stultz wrote:
> Hrm. Suggestions? As select_task_rq_rt() is only one of the callers.
> Trying to pass curr into cpu_busy_with_softirqs() would mean
> cpupri_find_fitness() would need to read the cpu_rq(cpu)->curr for the
> specified cpu and pass that in.

May be you could have a lightweight checker that accepts rq and curr
and gets called from select_task_rq_rt(). Then you could call that
same checker from cpu_busy_with_softirqs().

> Just to expand what it should be in detail:
> 1:  (softirqs & LONG_SOFTIRQ_MASK) &&
> 2:  (curr == cpu_ksoftirqd ||
> 3:  task_thread_info(curr)->preempt_count & SOFTIRQ_MASK)
> 
> Where we're checking
> 1) that  the active_softirqs and __cpu_softirq_pending() values on the
> target cpu are running a long softirq.
> AND (
> 2) The current task on the target cpu is ksoftirqd
> OR
> 3) The preempt_count of the current task on the target cpu has SOFTIRQ entries
> )

2) When the target CPU is handling or about to handle long softirqs
already what is the difference if it is also running ksoftirqd or not?

3) What is the point of this check when 1) is true already?

Thanks!
