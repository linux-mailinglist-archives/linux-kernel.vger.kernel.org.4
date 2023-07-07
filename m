Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0966C74AC2D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjGGHpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjGGHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:45:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ABE1FE6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:45:09 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3677bX8l007925;
        Fri, 7 Jul 2023 07:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=8ep86cX17JOSxyOTKT9MTlQ6kpZ7bA49qQeWK6Rv0F4=;
 b=SAajDl57mD2rTwLNjdDIHQDgkROzwPDPqms69r3kMoqA2bdKD+tXI3tIlB0pFLcXx01G
 w40is5DvSKrI1UZO0LryuvfWNnnlNA9rxG+5OwXdiF7kDDDRCsMU8KqeikuL6FVgQtI7
 yDyacchLYnipqqomucqvnZbF1X0R969J0YxVmcvMP2PGeB6ZmmP4TfMHKaaQCct3AxjI
 abybq0Lg5PaVH8WTzf/2rufW+0fC/8/HcxjwFVM5Id/gPQi5DDYe2l27Er7vrcGH77mv
 6VmlQkEV1q6BKfSr0coQ7QZ4p9bTVbJq+4Vr55oRbu+8K1My2DrHV16BBx0xoqqxp3yC Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpebmr80s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 07:44:59 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3677bQ6W007269;
        Fri, 7 Jul 2023 07:44:58 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpebmr80j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 07:44:58 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36774S6c008696;
        Fri, 7 Jul 2023 07:44:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3rjbs6m3ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 07:44:58 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3677iugk31260980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 07:44:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D92958043;
        Fri,  7 Jul 2023 07:44:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C35658061;
        Fri,  7 Jul 2023 07:44:55 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 07:44:55 +0000 (GMT)
MIME-Version: 1.0
Date:   Fri, 07 Jul 2023 09:44:55 +0200
From:   Tobias Huschle <huschle@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 1/1] sched/fair: Consider asymmetric scheduler groups in
 load balancer
In-Reply-To: <20230704134024.GV4253@hirez.programming.kicks-ass.net>
References: <20230515114601.12737-1-huschle@linux.ibm.com>
 <20230515114601.12737-2-huschle@linux.ibm.com>
 <20230704134024.GV4253@hirez.programming.kicks-ass.net>
Message-ID: <0fb7f422555d725f5f7f2e009c3d6df7@linux.ibm.com>
X-Sender: huschle@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cFZiwiH2Eiejg8ZHpU5X-sE9E7gF9tFs
X-Proofpoint-ORIG-GUID: oZ2AVvGrbRYO9oBYRDfWvHWzmyBh5x9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-04 15:40, Peter Zijlstra wrote:
> On Mon, May 15, 2023 at 01:46:01PM +0200, Tobias Huschle wrote:
>> The current load balancer implementation implies that scheduler 
>> groups,
>> within the same domain, all host the same number of CPUs. This is
>> reflected in the condition, that a scheduler group, which is load
>> balancing and classified as having spare capacity, should pull work
>> from the busiest group, if the local group runs less processes than
>> the busiest one. This implies that these two groups should run the
>> same number of processes, which is problematic if the groups are not
>> of the same size.
>> 
>> The assumption that scheduler groups within the same scheduler domain
>> host the same number of CPUs appears to be true for non-s390
>> architectures.
> 
> Mostly; there's historically the cpuset case where we can create
> lopsided groups like that. And today we're growing all these hybrid
> things that will also tickle this, except they're looking towards
> different balancer extentions to deal with the IPC difference so might
> not be immediately caring about this here issue.
> 
> 
>> Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
>> ---
>>  kernel/sched/fair.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 48b6f0ca13ac..b1307d7e4065 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10426,7 +10426,8 @@ static struct sched_group 
>> *find_busiest_group(struct lb_env *env)
>>  	 * group's child domain.
>>  	 */
>>  	if (sds.prefer_sibling && local->group_type == group_has_spare &&
>> -	    busiest->sum_nr_running > local->sum_nr_running + 1)
>> +	    busiest->sum_nr_running * local->group_weight >
>> +			local->sum_nr_running * busiest->group_weight + 1)
> 
> Should that not be: busiest->group_weight * (local->sum_nr_running + 1) 
> ?

I agree, adding the brackets makes more sense and is clearer on what's
intended by this check while also preserving the original behavior for
local->group_weight == busiest->group_weight

> 
> I'm not opposed to this -- it seems fairly straight forward.

Appreciated, I will go ahead and send a patch once I incorporated the 
other feedback I got.
Thanks.

> 
>>  		goto force_balance;
>> 
>>  	if (busiest->group_type != group_overloaded) {
>> --
>> 2.34.1
>> 
