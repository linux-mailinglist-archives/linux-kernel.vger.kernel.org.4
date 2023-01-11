Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E416654C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjAKGpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjAKGpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:45:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C04BD1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:45:37 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B6Zc1A016157;
        Wed, 11 Jan 2023 06:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=6SfqsB7uOTMixKdljrlYl/aZI4YHiF759X7UGEKKCzQ=;
 b=o+6Xg+2b5bXhcIEwRsJWTDvjs0tx6XT4cPZUnwVotV3wpo7qoe2j5OUbLfRntGPWuSjW
 hl0jlzaBDpQSiFpKhvauJ69GgTmR1SAyBTzW/36RyU3BxPw2KHAEh+2ObxeZHse+FL8L
 xdi0xb48SBcPKdpUNU+6opSzo+8cC3RtfWUnrv+GV9ys++H//h8iSIgHBULtcO2nrjxq
 +NVffsztrLa2UvkfJyc7lBWjSN1+yimBikw9SAAjz/dmJ8ZPuIP61mQ0Obh0zHYK3Buy
 IdlBOyQigbizLPmL4Dwhom7TUo/Jfx4FJz1eB4zHVMyw6zverpXmFr3TIhRz4+QZJKfM wQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1qyx05ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 06:45:09 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30B1ROgL030869;
        Wed, 11 Jan 2023 06:45:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n1kf7gb54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 06:45:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30B6j5cv46596544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 06:45:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75FBD20049;
        Wed, 11 Jan 2023 06:45:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A61720043;
        Wed, 11 Jan 2023 06:45:05 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 11 Jan 2023 06:45:05 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] nolibc: add support for the s390 platform
References: <20230109080910.26594-1-w@1wt.eu>
        <20230109191534.GU4028633@paulmck-ThinkPad-P17-Gen-1>
        <20230110073242.GB3229@1wt.eu> <20230110092517.GA4626@1wt.eu>
        <20230110145334.GL4028633@paulmck-ThinkPad-P17-Gen-1>
        <20230110161249.GB4649@1wt.eu>
        <20230110163210.GP4028633@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 11 Jan 2023 07:45:05 +0100
In-Reply-To: <20230110163210.GP4028633@paulmck-ThinkPad-P17-Gen-1> (Paul
        E. McKenney's message of "Tue, 10 Jan 2023 08:32:10 -0800")
Message-ID: <yt9dh6wxa7ta.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 48F-YycRd3ZTLLDVwwGkxa1ymnvpijVc
X-Proofpoint-GUID: 48F-YycRd3ZTLLDVwwGkxa1ymnvpijVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_02,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Tue, Jan 10, 2023 at 05:12:49PM +0100, Willy Tarreau wrote:
>> On Tue, Jan 10, 2023 at 06:53:34AM -0800, Paul E. McKenney wrote:
>> > Here is one of them, based on both the fixes and Sven's s390 support.
>> > Please let me know if you need any other combination.
>> 
>> Thanks, here's the problem:
>> 
>> > 0 getpid = 1                             [OK]
>> > 1 getppid = 0                            [OK]
>> > 3 gettid = 1                             [OK]
>> > 5 getpgid_self = 0                       [OK]
>> > 6 getpgid_bad = -1 ESRCH                 [OK]
>> > 7 kill_0[    1.940442] tsc: Refined TSC clocksource calibration: 2399.981 MHz
>> > [    1.942334] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x229825a5278, max_idle_ns: 440795306804 ns
>> >  = 0                             [OK]
>> > 8 kill_CONT = 0           [    1.944987] clocksource: Switched to clocksource tsc
>> >                [OK]
>> > 9 kill_BADPID = -1 ESRCH                 [OK]
>> (...)
>> 
>> It's clear that "grep -c ^[0-9].*OK" will not count all of them (2 are
>> indeed missing).
>> 
>> We could probably start with "quiet" but that would be against the
>> principle of using this to troubleshoot issues. I think we just stick
>> to the current search of "FAIL" and that as long as a success is
>> reported and the number of successes is within the expected range
>> that could be OK. At least I guess :-/
>
> Huh.  Would it make sense to delay the start of the nolibc testing by a
> few seconds in order to avoid this sort of thing?  Or would that cause
> other problems?

Or define a second serial port (or something similar) in qemu and run the
kernel console on ttyS0, and the init process writes to /dev/ttyS1? So the
output of the test program could be redirected to a file on the host?
