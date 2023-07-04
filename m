Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FBE746CEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjGDJLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjGDJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:11:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62324B3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:11:30 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36491vaZ028854;
        Tue, 4 Jul 2023 09:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=auLM8XCb45zIEyFKBRvTznnw5zPz5zeVHvh+FnhSYLI=;
 b=say+xf45uyskJ5njZwf60JYcLStDzHb9nUF/DMFnWcsicPUWUiNUxE3fNAupqI0YfhXT
 yYgET/dJcAYFtDxdDQCaKwVmPKdpl6LZrx8iNA9ENRUQAQsQs0TRmUDyxLMbp53AAKus
 M6LZHFr0i9XJ2Zj+N5TcdmAX2LMkuu22P6ilKF5TrlxdyPHw7ajop6S+oF5ENsePNGTC
 dqvOtrYpbb0EoWr3K0/ZMP3UQxac2cm1qU5xi5nA/VurJGD0b+bbeywrKbJKx/TAzx8h
 xuP2cr5FjD16LwgQnlFUmhhYUQxeKxHCXSYMGUezOZu9XA83y2I5XgyVE6KRc1Tfpj3z oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmgeggaqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 09:11:09 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36492FvG030380;
        Tue, 4 Jul 2023 09:11:08 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmgeggak0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 09:11:08 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3647I68F022900;
        Tue, 4 Jul 2023 09:11:02 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rjbs5eg07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 09:11:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3649B0qQ56099274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jul 2023 09:11:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A847858057;
        Tue,  4 Jul 2023 09:11:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33DE058058;
        Tue,  4 Jul 2023 09:11:00 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jul 2023 09:11:00 +0000 (GMT)
MIME-Version: 1.0
Date:   Tue, 04 Jul 2023 11:11:00 +0200
From:   Tobias Huschle <huschle@linux.ibm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, sshegde@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 0/1] sched/fair: Consider asymmetric scheduler groups in
 load balancer
In-Reply-To: <26fe6dc1-33c5-b825-c019-b346e8bedc0a@arm.com>
References: <20230515114601.12737-1-huschle@linux.ibm.com>
 <26fe6dc1-33c5-b825-c019-b346e8bedc0a@arm.com>
Message-ID: <4c28b46b59bcc083956757074d1fe059@linux.ibm.com>
X-Sender: huschle@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0WoULkjnIrHH6q-0CGoEQlxLuGBoNyo3
X-Proofpoint-ORIG-GUID: 4514zQr9IvCDlOJoLXOLTXuwcf_JfAvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-16 18:35, Dietmar Eggemann wrote:
> On 15/05/2023 13:46, Tobias Huschle wrote:
>> The current load balancer implementation implies that scheduler 
>> groups,
>> within the same scheduler domain, all host the same number of CPUs.
>> 
>> This appears to be valid for non-s390 architectures. Nevertheless, 
>> s390
>> can actually have scheduler groups of unequal size.
> 
> Arm (classical) big.Little had this for years before we switched to 
> flat
> scheduling (only MC sched domain) over CPU capacity boundaries for Arm
> DynamIQ.
> 
> Arm64 Juno platform in mainline:
> 
> root@juno:~# cat 
> /sys/devices/system/cpu/cpu*/topology/cluster_cpus_list
> 0,3-5
> 1-2
> 1-2
> 0,3-5
> 0,3-5
> 0,3-5
> 
> root@juno:~# cat /proc/schedstat | grep ^domain | awk '{print $1, $2}'
> 
> domain0 39 <--
> domain1 3f
> domain0 06 <--
> domain1 3f
> domain0 06
> domain1 3f
> domain0 39
> domain1 3f
> domain0 39
> domain1 3f
> domain0 39
> domain1 3f
> 
> root@juno:~# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
> MC
> DIE
> 
> But we don't have SMT on the mobile processors.
> 
> It looks like you are only interested to get group_weight dependency
> into this 'prefer_sibling' condition of find_busiest_group()?
> 
Sorry, looks like your reply hit some bad filter of my mail program.
Let me answer, although it's a bit late.

Yes, I would like to get the group_weight into the prefer_sibling path.
Unfortunately, we cannot go for a flat hierarchy as the s390 hardware
allows to have CPUs to be pretty far apart (cache-wise), which means,
the load balancer should avoid to move tasks back and forth between
those CPUs if possible.

We can't remove SD_PREFER_SIBLING either, as this would cause the load
balancer to aim for having the same number of idle CPUs in all groups,
which is a problem as well in asymmetric groups, for example:

With SD_PREFER_SIBLING, aiming for same number of non-idle CPUs
00 01 02 03 04 05 06 07 08 09 10 11  || 12 13 14 15
                 x     x     x     x      x  x  x  x

Without SD_PREFER_SIBLING, aiming for the same number of idle CPUs
00 01 02 03 04 05 06 07 08 09 10 11  || 12 13 14 15
     x  x  x     x  x     x     x  x


Hence the idea to add the group_weight to the prefer_sibling path.

I was wondering if this would be the right place to address this issue
or if I should go down another route.

> We in (classical) big.LITTLE (sd flag SD_ASYM_CPUCAPACITY) remove
> SD_PREFER_SIBLING from sd->child so we don't run this condition.
> 
>> The current scheduler behavior causes some s390 configs to use SMT
>> while some cores are still idle, leading to a performance degredation
>> under certain levels of workload.
>> 
>> Please refer to the patch's commit message for more details and an
>> example. This patch is a proposal on how to integrate the size of
>> scheduler groups into the decision process.
>> 
>> This patch is the most basic approach to address this issue and does
>> not claim to be perfect as-is.
>> 
>> Other ideas that also proved to address the problem but are more
>> complex but also potentially more precise:
>>   1. On scheduler group building, count the number of CPUs within each
>>      group that are first in their sibling mask. This represents the
>>      number of CPUs that can be used before running into SMT. This
>>      should be slightly more accurate than using the full group weight
>>      if the number of available SMT threads per core varies.
>>   2. Introduce a new scheduler group classification (smt_busy) in
>>      between of fully_busy and has_spare. This classification would
>>      indicate that a group still has spare capacity, but will run
>>      into SMT when using that capacity. This would make the load
>>      balancer prefer groups with fully idle CPUs over ones that are
>>      about to run into SMT.
>> 
>> Feedback would be greatly appreciated.
>> 
>> Tobias Huschle (1):
>>   sched/fair: Consider asymmetric scheduler groups in load balancer
>> 
>>  kernel/sched/fair.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 

