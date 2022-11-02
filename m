Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C358A615D87
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiKBIUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiKBIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:20:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511427175;
        Wed,  2 Nov 2022 01:20:02 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A26oTe3001526;
        Wed, 2 Nov 2022 08:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=js1Lu0//I9VGl7gfT9uz8O/3ugKZA96/iR1SoLjuf6g=;
 b=D7WKNDLVY5LD7z5t6iX30aZJYQtdPTpyxHEYM3qvw75yAy1AiKFwN0gHMG7pjGpPjbEy
 +HEMaCabMTorWiLlvaCm4IssmnZrFihAttFmHVbTvrly/7kZlWiJDWYNsfPVXcixNyxz
 5/RapZK+UPux6NM6ePZ9e34lF+wqcGkINURoOSM02TTVwN7zlGzwTaPXOFKSY/noGp53
 q92VB9o+4I46kRkXcF8+s5EQMhIMWEXWMb2h8jKeEbI5x2bSDYifJANpo1Yy99FpEyp6
 Ijbhu3/x2N+VJie4OhaJ4wsVY4MNUTEXMbjuXKLmxbhec+z1/Ab7KdCZWKzw0lCc73Ka eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkh3qy1nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 08:19:45 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A28BgR9021824;
        Wed, 2 Nov 2022 08:19:44 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkh3qy1nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 08:19:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A286c8n006948;
        Wed, 2 Nov 2022 08:19:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut969aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 08:19:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A28Jdfb655986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 08:19:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60821A404D;
        Wed,  2 Nov 2022 08:19:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA6D5A4040;
        Wed,  2 Nov 2022 08:19:36 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.40.163])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Nov 2022 08:19:36 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] [perf/core: Update sample_flags for raw_data in
 perf_output_sample
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Y1Fd57P5I+aSNT/V@hirez.programming.kicks-ass.net>
Date:   Wed, 2 Nov 2022 13:49:34 +0530
Cc:     Ian Rogers <irogers@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>, disgoel@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <164ED8DD-C9A0-40C2-AA12-EB8FA9D4C4C1@linux.vnet.ibm.com>
References: <20221020070657.21571-1-atrajeev@linux.vnet.ibm.com>
 <Y1Fd57P5I+aSNT/V@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: adkodxSF1G9EWweVkaq_Agl-B2UyfgJj
X-Proofpoint-GUID: xoh5G8LW7eUt5W0p11G7KN0OWnHqXz64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_04,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 20-Oct-2022, at 8:10 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Thu, Oct 20, 2022 at 12:36:56PM +0530, Athira Rajeev wrote:
>> commit 838d9bb62d13 ("perf: Use sample_flags for raw_data")
>> added check for PERF_SAMPLE_RAW in sample_flags in
>> perf_prepare_sample(). But while copying the sample in memory,
>> the check for sample_flags is not added in perf_output_sample().
>> Fix adds the same in perf_output_sample as well.
>>=20
>> Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> kernel/events/core.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4ec3717003d5..daf387c75d33 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7099,7 +7099,7 @@ void perf_output_sample(struct =
perf_output_handle *handle,
>> 	if (sample_type & PERF_SAMPLE_RAW) {
>> 		struct perf_raw_record *raw =3D data->raw;
>>=20
>> -		if (raw) {
>> +		if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
>> 			struct perf_raw_frag *frag =3D &raw->frag;
>>=20
>> 			perf_output_put(handle, raw->size);
>=20
> Urgh.. something smells here. We already did a PERF_SAMPLE_RAW test.
>=20
> And perf_prepare_sample() explicitly makes data->raw be NULL when not
> set earlier.
>=20
> So what's going wrong?

Hi Peter,

Sorry for late response. I was out on vacation couple of days.

I didn't hit any specific issue or fail with current code. But patch =
intention was
to keep the perf_prepare_sample and perf_output_sample to be in sync =
with the checks that we
are doing.

Thanks
Athira

