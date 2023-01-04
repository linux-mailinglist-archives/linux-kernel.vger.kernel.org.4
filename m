Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0463665CF96
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbjADJeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjADJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:34:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909D4D7B;
        Wed,  4 Jan 2023 01:34:03 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3046NQWk022379;
        Wed, 4 Jan 2023 09:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mtGAGYRS64hk/VrRNgVjHa8uSOXCKXmT/oCzpqvlFNk=;
 b=dtNkw9VRzNGOZEutdGn3quGZt3/GJLhdMvX5WyPzhdpyY64mqleZ3rwfZy5Bon5XjdLC
 R+FKUw7iKAz2Rm/TbX5MmdtzKGFlvZZn3Sg0jvANQmGFRZKH85qSC740cPxj8mntkPSS
 PZ3IBa5VLZTwhrUNKk5mZNauxNSPGvWolnP84YzpvsAzAJ8iE9dWa9NwuiEtgwOPyUtl
 3RfjtM1WeuQIXlAuEgwOljON6zT+P45HdNj07t393ki0eBbIk/lE0GGePAd+4ETqqDEM
 /xDKQKnButnCusjLaw//fQesQWGCZhjLQuGe2t/FIK9q3oFo0N/pb2afhO8CnHPXaxjD CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjd7k8ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 09:33:58 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3049UDiF032012;
        Wed, 4 Jan 2023 09:33:58 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjd7k8xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 09:33:58 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3046YtcT010137;
        Wed, 4 Jan 2023 09:33:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3mtcbfkptw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 09:33:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3049Xqhr49676796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 09:33:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30DF320040;
        Wed,  4 Jan 2023 09:33:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A61E320043;
        Wed,  4 Jan 2023 09:33:51 +0000 (GMT)
Received: from [9.171.83.63] (unknown [9.171.83.63])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jan 2023 09:33:51 +0000 (GMT)
Message-ID: <2d8265c4-6c1d-dbcd-2e85-64a3dd1ddc2c@linux.ibm.com>
Date:   Wed, 4 Jan 2023 10:33:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] perf/test: Fix test case 89 for x86
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <richter@de.ibm.com>
References: <20221228145704.2702487-1-tmricht@linux.ibm.com>
 <20221228145704.2702487-2-tmricht@linux.ibm.com>
 <Y7QrqshCjRocRlWP@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <Y7QrqshCjRocRlWP@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FySZIdU29vtVcL4OFnHTZvsYy00c5QWN
X-Proofpoint-GUID: zTuCrCJ3drGoo2IFgQp1Tuygzoxv1mr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040076
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 14:20, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 28, 2022 at 03:57:04PM +0100, Thomas Richter escreveu:
>> From: Thomas Richter <richter@de.ibm.com>
>>
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
> 
> Humm, I'm testing and invetigating this issue and by looking at the
> backtraces I see that it is just on the first entry that the getaddrinfo
> isn't present, i.e. now there are two inet_pton() calls, one of them
> doesn't come from getaddrinfo():
> 
> [root@quaco ~]# cat /tmp/perf.script.IUC
> ping 623883 [006] 265438.471610: probe_libc:inet_pton: (7f32bcf314c0)
> 	          1314c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> 	           29510 __libc_start_call_main+0x80 (/usr/lib64/libc.so.6)
> 
> ping 623883 [006] 265438.471664: probe_libc:inet_pton: (7f32bcf314c0)
> 	          1314c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> 	           fa6c6 getaddrinfo+0x126 (/usr/lib64/libc.so.6)
> 	            491e [unknown] (/usr/bin/ping)
> 
> The above is the temp file for the perf script output from the collected
> perf.data file See the second entry? Its as we expect:
> 
> [root@quaco ~]# cat /tmp/expected.aT6
> ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)
> .*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc.so.6|inlined\)$
> getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc.so.6\)$
> .*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$
> [root@quaco ~]#
> 
> But if I just ignore that first one and match against the second event
> instance:
> 
> [root@quaco ~]# perf test inet_pton
>  90: probe libc's inet_pton & backtrace it with ping                 : Ok
> [root@quaco ~]# perf test -v inet_pton
>  90: probe libc's inet_pton & backtrace it with ping                 :
> --- start ---
> test child forked, pid 626199
> ping 626222 [007] 266979.123047: probe_libc:inet_pton_1: (7f0650d314c0)
> 1314c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> fa6c6 getaddrinfo+0x126 (/usr/lib64/libc.so.6)
> 491e n (/usr/bin/ping)
> test child finished with 0
> ---- end ----
> probe libc's inet_pton & backtrace it with ping: Ok
> [root@quaco ~]#
> 
> So, can you try with the following patch in your s/390 system?

Thanks Arnaldo,

your patch also works on my s390 system. I applied patch 1/2 which is
necessary and then your change:

  # ./perf test  85
  85: probe libc's inet_pton & backtrace it with ping                 : FAILED!
  # git am your-patch
  # ./perf test  85
  85: probe libc's inet_pton & backtrace it with ping                 : Ok
  #

So for patch 2/2 your have my
Tested-by: Thomas Richter <tmricht@linux.ibm.com>

> 
> I wish 'perf script' had a --skip option that allowed us to ask for just
> the second event, not having that I did a trick with tac + grep -m1 -B :-)
> 
> We can try to revisit your approach for the next merge window, as at
> this point, for 6.2 we want for fixes to be as minimal as possible.
> 

Yes that would be good to make this test case more rebust.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

