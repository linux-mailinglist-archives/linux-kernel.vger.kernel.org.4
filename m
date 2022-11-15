Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E928762996A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbiKOM4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiKOM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:56:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083F100F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:56:19 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFCdwOn030296;
        Tue, 15 Nov 2022 12:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=uHNpl+0MKkbqSBfSYu/JfgMqw8KjArqCBUA4q3OOAvY=;
 b=PKE8EWvcBmCg3QxeKS+E1nU6Sex6P4AW4peAx3Uy/lDR2MhmKZGbo29TJ4Hmjz37uEoh
 9BVmdQlP2HONDyjjQb7ESZx86b/SXqg3rqsNeIkzZbhe3CVkFCAUwSyUjtAMtDYqb/wY
 iQZmfKwGlvC4IgPYWQC6gOQglfOMbzy7ntFH6543jz4Qbe77M7vahwI3KRrG+V72fwUB
 Lqevt5DI2/qIA+ayvySCUya98/M/+A49o8BwNr0xhba4oqWTeQiVlI8by4WkrRN2WzU/
 OrbhaS5dU+PqcQnNOIillu5ESnBluzSvEcEiv+G5S1rn3vypLTVWgQv5uSf8VZJ/V3+H xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvanvgksg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 12:55:49 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFCfRjA003378;
        Tue, 15 Nov 2022 12:55:48 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvanvgkrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 12:55:48 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AFCpeCe000979;
        Tue, 15 Nov 2022 12:55:45 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3kt349b710-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 12:55:45 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AFCuMrw44106210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 12:56:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FE36A4054;
        Tue, 15 Nov 2022 12:55:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0548A405F;
        Tue, 15 Nov 2022 12:55:35 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.163.92.18])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Nov 2022 12:55:35 +0000 (GMT)
Date:   Tue, 15 Nov 2022 13:55:31 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     John Stultz <jstultz@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <Y3OMQ+1D+AHbP72+@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
 <Y0+/SAWUNRnhIW9b@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCpQuQn_84yqErF2noAYDwdwNJQF-pr4JKVp1eZzH=+f9w@mail.gmail.com>
 <Y1FDegctcU2LrYGT@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <Y1Q3vYjlFt/Imu5w@google.com>
 <Y1TxCTq5gxh4fIEd@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CANDhNCreB=Bm-X7WFp-oUtfR9uNRD=Vx8TehJ59HvF4Ke48ehQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCreB=Bm-X7WFp-oUtfR9uNRD=Vx8TehJ59HvF4Ke48ehQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0aD6LgasttgDP6UG-rOjnbRAo2ufcTSn
X-Proofpoint-GUID: sZy0vt69zzz8FB0cY1TNZ0josfStXuGR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_07,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011 mlxlogscore=596
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 11:08:36PM -0800, John Stultz wrote:

Hi John,
...
> > Right. So the check to deem a remote CPU unfit would (logically) look like this:
> >
> > (active | pending | ksoftirqd) & LONG_SOFTIRQ_MASK
...
> As run_ksoftirqd() basically looks at the pending set and calls
> __do_softirq() which then moves the bits from the pending mask  to
> active mask while they are being run.
> 
> So (pending|active)&LONG_SOFTIRQ_MASK seems like it should be a
> sufficient check regardless of if the remote cpu is in softirq or
> ksoftirqd, no?

I did not realize run_ksoftirqd()->__do_softirq() covers it.
Sorry for the noise.

Thanks!

> thanks
> -john
