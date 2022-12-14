Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB73C64C74B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 11:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbiLNKk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 05:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiLNKkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:40:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3189823167;
        Wed, 14 Dec 2022 02:40:47 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEA9ouf026381;
        Wed, 14 Dec 2022 10:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rmj01O8aWT7Pquub7N1Da9OFDIr52FoA27MQJjM3mek=;
 b=FRxQnbYXsbHLr9dCBHW7xe4wGNGA+DuW0ogijblnicpu7AKY2QutftUicFnooPG+BAox
 m0r05AaMHZl6v5MYODEqBODbjMtHQKX1LXSp9oTlWF0S3/yDXD+Cr5O5T2wq2/M0iI5m
 eOOveQcqBKPhfRiOvduHWDzIGRd6/MLXONCxqdZmsUbBS8ovGxB+QrHSIonUCcmnvkom
 ac4xKBubR+DbCgxYS6MRZMGn9E/u4swzlWvx3sXGrag8+0DRHzuDW4I4suERHXFyK6kG
 q79sQY6hh5MznZtIQ92+TcOYAorK1ghBhX9BNbDZ1/AgKcm+4p1/e79f5JKKHiA/NjPK sg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mfc6vh2av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 10:40:38 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEA5c46023755;
        Wed, 14 Dec 2022 10:40:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3meypygxjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 10:40:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BEAeWAq46137656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 10:40:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7FEA20040;
        Wed, 14 Dec 2022 10:40:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8388E2004B;
        Wed, 14 Dec 2022 10:40:32 +0000 (GMT)
Received: from [9.152.212.244] (unknown [9.152.212.244])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 14 Dec 2022 10:40:32 +0000 (GMT)
Message-ID: <f5e69102-ed17-1f2d-3a09-3c7968b611ff@linux.ibm.com>
Date:   Wed, 14 Dec 2022 11:40:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] perf/test: Fix perf test 89 on x86
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        svens@linux.ibm.com
References: <20221213105729.1447368-1-tmricht@linux.ibm.com>
 <20221213105729.1447368-2-tmricht@linux.ibm.com>
 <Y5iQXJaQOrhjLZQW@kernel.org>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <Y5iQXJaQOrhjLZQW@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r5Oda6Ph7KcVf90S7ur8gGOowfJsZBgB
X-Proofpoint-ORIG-GUID: r5Oda6Ph7KcVf90S7ur8gGOowfJsZBgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_04,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 15:46, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 13, 2022 at 11:57:29AM +0100, Thomas Richter escreveu:
>> perf test '89: probe libc's inet_pton & backtrace it with ping'
>> fails on x86. Debugging revealed a changed stack trace for the
>> ping command using probes:
>>
>> ping 35729 [002]  8006.365063: probe_libc:inet_pton: (3ff9603e7c0)
>>                   12be50 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
>>                   4fca main+0x139b (/usr/bin/ping)
>>
>> The line getaddrinfo.... in the call stack is gone.
>> It was introduced with glibc version 2.36.8 released
>> with Fedora 37.
>>
>> Output before on x86
>>  # ./perf test 89
>>  89: probe libc's inet_pton & backtrace it with ping   : FAILED!
>>  #
>>
>> Output after on x86:
>>  # ./perf test 89
>>  89: probe libc's inet_pton & backtrace it with ping   : Ok
>>  #
> 
> Not having at the current state of that script, that $expected may be a
> subset of the actual backtrace, i.e. will this continue working with
> the systems where that getaddrinfo line appear?
> 
> - Arnaldo
>  

No, that is not the case.
Taking this into account requires a larger rework of the call stack
checking. Not just simple line by line matching which is done now.
It also raises the question of how far to go back
in glibc history. Different versions of glibc have different call stacks.

I will rethink this...
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

