Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0D641E25
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 18:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiLDRJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 12:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiLDRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 12:08:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329F712742;
        Sun,  4 Dec 2022 09:08:57 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B4GWZOH001398;
        Sun, 4 Dec 2022 17:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=e2/hc62hPgXVhBLXRN2/ibiyGfbGy7HnDrn4qPtHh1A=;
 b=h56MZ7BoHT6sUNf4J2hBiIYjffwDrT5ye5n5HS35StRj6BK7pWqZfHsuitcphh8eOptv
 yROA8/WjcaW8wR+PHHzBp7Hksk0sVSndLmgRzUC/hhlK+ypzgkJDJ6JA52/Ga8kgUZyT
 IUYGDP6QytPC8AEGgNryeWRuqs4YXYsyr6Zkg0V48cS1lFlgpF9nAS2MMuvqYoZsRE55
 96RNGYdSM70wD3pXhAG/XdnC6BjjoBGEfeQQfR/xBwU+mnH32RITTN3dDmPWwnSakMNK
 FZpIQtE7CJ47L4Wwd7JM39b4G1GLbKvx0RpJLpEexCLmqZUKlxoleUUMxj3Yz/kdr+Ol xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8g9pn0bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Dec 2022 17:08:38 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B4CIQF9018704;
        Sun, 4 Dec 2022 17:08:38 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8g9pn0ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Dec 2022 17:08:38 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B4H58KM022921;
        Sun, 4 Dec 2022 17:08:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3m7wqhs7sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Dec 2022 17:08:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B4H8Wrf17433226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Dec 2022 17:08:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3FC24C040;
        Sun,  4 Dec 2022 17:08:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C5254C044;
        Sun,  4 Dec 2022 17:08:30 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.49.148])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  4 Dec 2022 17:08:30 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] perf stat: Fix invalid output handle
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <a0745ad9-c21e-2c93-9af4-46e60bc301fc@arm.com>
Date:   Sun, 4 Dec 2022 22:38:28 +0530
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E93B2D0E-8862-4873-B49F-F74D83CEEDAD@linux.vnet.ibm.com>
References: <20221130111521.334152-1-james.clark@arm.com>
 <20221130111521.334152-2-james.clark@arm.com>
 <CAM9d7cj0Zrv32CgJ7jSjCY=CsOcF40zC2kxE+NSixG4qZDpXqQ@mail.gmail.com>
 <a0745ad9-c21e-2c93-9af4-46e60bc301fc@arm.com>
To:     James Clark <james.clark@arm.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oa5GRleBRiRA8AcXgABSaPdCgafhZn0p
X-Proofpoint-ORIG-GUID: BEDYMFa7d07Jox-9PnlgIsC0TBD6U3kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-04_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212040155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 01-Dec-2022, at 3:36 PM, James Clark <james.clark@arm.com> wrote:
>=20
>=20
>=20
> On 30/11/2022 18:32, Namhyung Kim wrote:
>> On Wed, Nov 30, 2022 at 3:15 AM James Clark <james.clark@arm.com> =
wrote:
>>>=20
>>> In this context, 'os' is already a pointer so the extra dereference
>>> isn't required. This fixes the following test failure on aarch64:
>>>=20
>>>  $ ./perf test "json output" -vvv
>>>  92: perf stat JSON output linter                                    =
:
>>>  --- start ---
>>>  Checking json output: no args Test failed for input:
>>>  ...
>>>  Fatal error: glibc detected an invalid stdio handle
>>>  ---- end ----
>>>  perf stat JSON output linter: FAILED!
>>>=20
>>> Fixes: e7f4da312259 ("perf stat: Pass struct outstate to =
printout()")
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>=20
>> Thanks for fixing this.  I'm not sure how I missed it.. :(
>>=20
>=20
> It seems to only go down that path on some configuration. At least on
> x86 the test was passing fine for me.
>=20
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>=20
> Thanks for the review!

Faced same issue on powerpc. Tested with this change and it works with =
this patch.

Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira
>=20
>>=20
>> Thanks,
>> Namhyung
>>=20
>>=20
>>> ---
>>> tools/perf/util/stat-display.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/tools/perf/util/stat-display.c =
b/tools/perf/util/stat-display.c
>>> index 847acdb5dc40..eac5ac3a734c 100644
>>> --- a/tools/perf/util/stat-display.c
>>> +++ b/tools/perf/util/stat-display.c
>>> @@ -741,7 +741,7 @@ static void printout(struct perf_stat_config =
*config, struct outstate *os,
>>>                perf_stat__print_shadow_stats(config, counter, uval, =
map_idx,
>>>                                              &out, =
&config->metric_events, &rt_stat);
>>>        } else {
>>> -               pm(config, &os, /*color=3D*/NULL, /*format=3D*/NULL, =
/*unit=3D*/"", /*val=3D*/0);
>>> +               pm(config, os, /*color=3D*/NULL, /*format=3D*/NULL, =
/*unit=3D*/"", /*val=3D*/0);
>>>        }
>>>=20
>>>        if (!config->metric_only) {
>>> --
>>> 2.25.1

