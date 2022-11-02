Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092BE615C7C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKBGvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBGvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:51:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E625F6;
        Tue,  1 Nov 2022 23:51:43 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A26IJIc012406;
        Wed, 2 Nov 2022 06:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=LHqYGDj6v9S6R3aREm6PgatDmspsJeXiILHjBKsg8ZQ=;
 b=JRTIJy1FDSLxKUnCgQOLQcxzukV25k5TaP5Tf3E8liUVzW15zFBvHMYbJ9uBFSXijCtL
 o4FWU22Ho4yBugjQWLrKsTrRgQC17W7hJ4TauctDdW5YyiOjh8qAvLHytEY73Q+q2v0g
 DVniuYv1BybAYBKmkrZ57I7aDph5XxwNUluQMQeAWi2YHNGBF527fEGM46KtOTi7iUC2
 6pgdFfsVWsNC5o+QPY7a7+Dlgcz5rQMxeGFGpjk8Rqe2loNFfRWz8m9QwXr897bhd9+C
 ITwvzwXHtstsDeKQxrn/BlQhPN6Iam9IKFe7wGdnDwYvGh8jvZ6bkQbwNn88i+Titwfx Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjufhrfhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 06:51:23 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A26TuV9001276;
        Wed, 2 Nov 2022 06:51:22 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjufhrfgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 06:51:22 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A26admD028277;
        Wed, 2 Nov 2022 06:51:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut963gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 06:51:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A26pHXA37618270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 06:51:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48F01A405C;
        Wed,  2 Nov 2022 06:51:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1238A405B;
        Wed,  2 Nov 2022 06:51:13 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.40.163])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Nov 2022 06:51:13 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] perf test: Fix skipping branch stack sampling test
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <2265e166-da9c-f540-a108-0d0b133f7da9@arm.com>
Date:   Wed, 2 Nov 2022 12:21:11 +0530
Cc:     LKML <linux-kernel@vger.kernel.org>, Anshuman.Khandual@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F79AE69A-4D87-4F4E-A3FD-EF06A6E12839@linux.vnet.ibm.com>
References: <20221028121913.745307-1-james.clark@arm.com>
 <2265e166-da9c-f540-a108-0d0b133f7da9@arm.com>
To:     James Clark <james.clark@arm.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e-mxlTSTwei_hsaVcn_kOxWIGmXveDU0
X-Proofpoint-ORIG-GUID: h1emuicVceHJGZc-7aq68lCZXPrXyRkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_03,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 28-Oct-2022, at 5:52 PM, James Clark <james.clark@arm.com> wrote:
>=20
>=20
>=20
> On 28/10/2022 13:19, James Clark wrote:
>> Commit f4a2aade6809 ("perf tests powerpc: Fix branch stack sampling =
test
>> to include sanity check for branch filter") added a skip if certain
>> branch options aren't available. But the change added both -b
>> (--branch-any) and --branch-filter options at the same time, which =
will
>> always result in a failure on any platform because the arguments =
can't
>> be used together.
>>=20
>> Fix this by removing -b (--branch-any) and leaving --branch-filter =
which
>> already specifies 'any'. Also add warning messages to the test and =
perf
>> tool.
>>=20
>=20
> Hi Athira,
>=20
> Are you able to check if this still skips for you on PowerPC with this
> new change?
>=20

Hi James,

Sorry for the late response. I was out on vacation couple of days.

I tested with the new change and verified it skips on powerpc.

Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira
> Thanks
> James
>=20
>> Output on x86 before this fix:
>>=20
>>   $ sudo ./perf test branch
>>   108: Check branch stack sampling         : Skip
>>=20
>> After:
>>=20
>>   $ sudo ./perf test branch
>>   108: Check branch stack sampling         : Ok
>>=20
>> Fixes: f4a2aade6809 ("perf tests powerpc: Fix branch stack sampling =
test to include sanity check for branch filter")
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>> tools/perf/tests/shell/test_brstack.sh | 5 ++++-
>> tools/perf/util/parse-branch-options.c | 4 +++-
>> 2 files changed, 7 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tools/perf/tests/shell/test_brstack.sh =
b/tools/perf/tests/shell/test_brstack.sh
>> index ec801cffae6b..d7ff5c4b4da4 100755
>> --- a/tools/perf/tests/shell/test_brstack.sh
>> +++ b/tools/perf/tests/shell/test_brstack.sh
>> @@ -13,7 +13,10 @@ fi
>>=20
>> # skip the test if the hardware doesn't support branch stack sampling
>> # and if the architecture doesn't support filter types: =
any,save_type,u
>> -perf record -b -o- -B --branch-filter any,save_type,u true > =
/dev/null 2>&1 || exit 2
>> +if ! perf record -o- --no-buildid --branch-filter any,save_type,u -- =
true > /dev/null 2>&1 ; then
>> +	echo "skip: system doesn't support filter types: =
any,save_type,u"
>> +	exit 2
>> +fi
>>=20
>> TMPDIR=3D$(mktemp -d /tmp/__perf_test.program.XXXXX)
>>=20
>> diff --git a/tools/perf/util/parse-branch-options.c =
b/tools/perf/util/parse-branch-options.c
>> index 00588b9db474..31faf2bb49ff 100644
>> --- a/tools/perf/util/parse-branch-options.c
>> +++ b/tools/perf/util/parse-branch-options.c
>> @@ -102,8 +102,10 @@ parse_branch_stack(const struct option *opt, =
const char *str, int unset)
>> 	/*
>> 	 * cannot set it twice, -b + --branch-filter for instance
>> 	 */
>> -	if (*mode)
>> +	if (*mode) {
>> +		pr_err("Error: Can't use --branch-any (-b) with =
--branch-filter (-j).\n");
>> 		return -1;
>> +	}
>>=20
>> 	return parse_branch_str(str, mode);
>> }

