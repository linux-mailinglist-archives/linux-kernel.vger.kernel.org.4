Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6001B687F7B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjBBOBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:01:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8242A49564
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:01:50 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312DK09v035941;
        Thu, 2 Feb 2023 14:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=aOJxgCZ6f0Yzo8ikMQNr+/LNb1OMA0y2U06rz9ATOyo=;
 b=qeXR3+3CYFyWR7ieSTSVwiLgPCCZmZR7ZstAW8DIAe4Ksnowgtxt7dX+s1uHmFJqDdtx
 AZ0XhhTDoL06cSOHoVJzYpWAZwl5F4+j2UeIRasJkY1crFQeIHZDDgmYHnV1B2oIBdpZ
 JfpZbCpL01tFcMG5Y90ePIstImtSCq6YZbcUsCol762QXT/rLZzlZwLC5TZhLN+QMlwj
 8dMYPONoWt7fObG95O3dV630Z6ZWzOJXXYhEDNT3eSC49l9ZwPFEdYd1v74IMS+tbwoF
 1jSWSay3XgVVNkKhoKggZQduRB0j1KKy8vJu8QOKYUxi6MkQqhY33+v4vsAcpf9m5zno Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngbasw8ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 14:01:36 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312DZWs6028918;
        Thu, 2 Feb 2023 14:01:35 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngbasw8sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 14:01:35 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312DgrmT014953;
        Thu, 2 Feb 2023 14:01:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ncvttx8g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 14:01:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312E1Udd49938804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 14:01:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B35F42004E;
        Thu,  2 Feb 2023 14:01:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 288AB20043;
        Thu,  2 Feb 2023 14:01:29 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.126.173])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 14:01:28 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: WARN include/linux/trace_recursion.h:162 (powerpc)
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <Y9t6yoafrO5YqVgM@hirez.programming.kicks-ass.net>
Date:   Thu, 2 Feb 2023 19:31:18 +0530
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, bsingharora@gmail.com,
        dja@axtens.net, paulus@ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Transfer-Encoding: 7bit
Message-Id: <FD2608B2-6A0F-4235-9D54-55C067777E79@linux.ibm.com>
References: <4C073F6A-C812-4C4A-BB7A-ECD10B75FB88@linux.ibm.com>
 <Y9t6yoafrO5YqVgM@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gZKMzera-RCEUVveEvJFUKN-35xgIDYW
X-Proofpoint-ORIG-GUID: 5u-KdGSWJEcRBp8g_ddfYh3PlYOeX2XJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=844
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> ---[ end trace 0000000000000000 ]---
>> ------------[ cut here ]------------
>> RCU not on for: shared_cede_loop+0xc/0x170
>> 
>> The code in question was added by
>> commit d099dbfd330686a8c09cd8944bcc77a56f9e7815
>>    cpuidle: tracing: Warn about !rcu_is_watching()
> 
> Note that by selecting ARCH_WANTS_NO_INSTR you effectively state to
> abide by its rules.
> 
>  41b7a347bf14 ("powerpc: Book3S 64-bit outline-only KASAN support")
> 
> AFAICT the power code does not even attempt to do this.
> 
> For your idle path you want at least something like the below, but given
> you don't have build time validation of noinstr I can't really tell and
> you'll just have to run chase the stragglers.
> 

Thanks for the feedback Peter. With the interim patch submitted by
Michael, I no longer see this warning.

