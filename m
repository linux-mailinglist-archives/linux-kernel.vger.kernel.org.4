Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E15EF300
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiI2KG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiI2KGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:06:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C91138F30
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:06:22 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T9tOgZ017793;
        Thu, 29 Sep 2022 10:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fnEIb/d51NvpxpvCgwnQVvQOt7pugIVPLyBM2zui0V0=;
 b=OafQsFqmwcTs21VG5BYRBGTSesDFvHPHsBntR/qycny6kp+4amlsNlLx/i5YHtP4gdca
 REhFGhJHZihjap64JuNwzbF2NAz4nDLYnufgElSx4TJHSUR8210hUPdM8mdXymeeRDY8
 NV8rGeZ/m3Pdrw3kxT8Y8D9pU/qxaiDA4adM+Un9SvN6xOzLkBhSZnBOE5XNayJn5I1f
 M7B+XW3YadvW1vYy7qupwiS3qF6GD+cqmO5kFt9LkRvZgHj410hzUBzZZMACVWtTBGwx
 tKW1BYgSXQVDnBSDzESKSHbuQKJs6gM2iHMmqGvJ4H2ddZ4lY5oefXiVUDTwxiv+toTr OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw95br8yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:05:12 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28T9v8Gq023379;
        Thu, 29 Sep 2022 10:05:12 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw95br8wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:05:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28T9plx9003120;
        Thu, 29 Sep 2022 10:05:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j6gvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:05:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28TA56o72228972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 10:05:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27C944C04E;
        Thu, 29 Sep 2022 10:05:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 857524C044;
        Thu, 29 Sep 2022 10:05:05 +0000 (GMT)
Received: from osiris (unknown [9.152.212.239])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Sep 2022 10:05:05 +0000 (GMT)
Date:   Thu, 29 Sep 2022 12:05:04 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, kernel-team@android.com,
        kernel test robot <lkp@intel.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [RFC PATCH v3 1/3] softirq: Add generic accessor to percpu
 softirq_pending data
Message-ID: <YzVt0FVDPIPfsQ5t@osiris>
References: <20220921012550.3288570-1-jstultz@google.com>
 <20220921012550.3288570-2-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921012550.3288570-2-jstultz@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tj8eKJgTm82-z18IQu8A3FHBGLQ6igmK
X-Proofpoint-ORIG-GUID: tRJjZMHIS1z-JOkUJrNjC39ZHsdFAFP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_05,2022-09-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=652 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1011 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209290061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 01:25:48AM +0000, John Stultz wrote:
> In a previous iteration of this patch series, I was checking:
> 
>    per_cpu(irq_stat, cpu).__softirq_pending
> 
> which resulted in build errors on s390.
> 
> This patch tries to create a generic accessor to this percpu
> softirq_pending data.
> 
> This interface is inherently racy as its reading percpu data
> without a lock. However, being able to peek at the softirq
> pending data allows us to make better decisions about rt task
> placement vs just ignoring it.
> 
> On s390 this call returns 0, which maybe isn't ideal but
> results in no functional change from what we do now.
> 
> Feedback or suggestions for better approach here would be
> welcome!
...
> diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
> index 58668ffb5488..cd9cc11588ab 100644
> --- a/arch/s390/include/asm/hardirq.h
> +++ b/arch/s390/include/asm/hardirq.h
> @@ -16,6 +16,12 @@
>  #define local_softirq_pending() (S390_lowcore.softirq_pending)
>  #define set_softirq_pending(x) (S390_lowcore.softirq_pending = (x))
>  #define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
> +/*
> + *  Not sure what the right thing is here  for s390,
> + *  but returning 0 will result in no logical change
> + *  from what happens now
> + */
> +#define __cpu_softirq_pending(x) (0)

Hm, yes. This would require some ugly code to make this work properly,
plus might cause unique problems on s390 if the cpu in question is
offline.
So I'd say we might change s390 to use a proper per cpu irqstat
variable instead, if this new interface is being agreed on.
