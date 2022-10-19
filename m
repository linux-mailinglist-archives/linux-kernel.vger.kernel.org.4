Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82916043A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiJSLph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJSLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:45:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5DD2CE4;
        Wed, 19 Oct 2022 04:25:00 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JAglQW013649;
        Wed, 19 Oct 2022 10:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nsEpiq1myEeobKJUZCMn1hegO3+COswa11ce/K6W+qY=;
 b=LbelrziKqV0189uyMyXwxeU5Fg+a4/8D+q64mfjnfF9WAbHA+PYMnr+3NPgYwU5KCAga
 fekJFcvyDpxFsxXt6rDa7a2jLoika9J/YvxE97EzOACSpxMA9BXGxE0qhrmBp1k3OoKW
 MBieQWHDySOwfW3hViu0dinLxSS+sY9e0he6SmL6C7K0USJoehcjROnlGyB9PpdalgAS
 mVJfHUgctAXHcrEayMiiLYQ8zTHH1I80dKzWuXNpoX/X286E2SZUOxz0n/vcIGVLtCMt
 eairLmOX276sUkvvCjw6SPhkVfx0bHbqwCT3T1I0WqPTGjoeFVegsEPTVMrQ8moTkVD2 /Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kaexbhe9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 10:44:12 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JAZ2b2006209;
        Wed, 19 Oct 2022 10:44:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3k7m4jpwjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 10:44:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JAi8hc43909412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 10:44:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 285A1AE051;
        Wed, 19 Oct 2022 10:44:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B55EAE045;
        Wed, 19 Oct 2022 10:44:06 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.126.22])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Oct 2022 10:44:06 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [tip: perf/core] perf: Use sample_flags for raw_data
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <166434824149.401.4361243714612738808.tip-bot2@tip-bot2>
Date:   Wed, 19 Oct 2022 16:14:03 +0530
Cc:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Message-Id: <824365F4-EA1C-46E1-9C44-D79F1705FD56@linux.vnet.ibm.com>
References: <20220921220032.2858517-2-namhyung@kernel.org>
 <166434824149.401.4361243714612738808.tip-bot2@tip-bot2>
To:     LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XQj7kd_sDHO_-KVy-FtlZS1t_E7g2HGN
X-Proofpoint-ORIG-GUID: XQj7kd_sDHO_-KVy-FtlZS1t_E7g2HGN
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_06,2022-10-19_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 28-Sep-2022, at 12:27 PM, tip-bot2 for Namhyung Kim <tip-bot2@linutron=
ix.de> wrote:
>=20
> The following commit has been merged into the perf/core branch of tip:
>=20
> Commit-ID:     838d9bb62d132ec3baf1b5aba2e95ef9a7a9a3cd
> Gitweb:        https://git.kernel.org/tip/838d9bb62d132ec3baf1b5aba2e95ef=
9a7a9a3cd
> Author:        Namhyung Kim <namhyung@kernel.org>
> AuthorDate:    Wed, 21 Sep 2022 15:00:32 -07:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Tue, 27 Sep 2022 22:50:24 +02:00
>=20
> perf: Use sample_flags for raw_data
>=20
> Use the new sample_flags to indicate whether the raw data field is
> filled by the PMU driver.  Although it could check with the NULL,
> follow the same rule with other fields.
>=20
> Remove the raw field from the perf_sample_data_init() to minimize
> the number of cache lines touched.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20220921220032.2858517-2-namhyung@kernel.=
org

Hi Namhyung,

This commit ("perf: Use sample_flags for raw_data") added
PERF_SAMPLE_RAW check in perf_prepare_sample. To be in sync
while we output sample to memory, do we also need to add
similar check in perf_output_sample ? I am pasting change below.
Please share your thoughts.

From 46d874bc4a915dd710ddbc5198588cbb66d3ea8e Mon Sep 17 00:00:00 2001
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Date: Wed, 19 Oct 2022 13:02:06 +0530
Subject: [PATCH] perf/core: Update sample_flags for raw_data in
 perf_output_sample

commit 838d9bb62d13 ("perf: Use sample_flags for raw_data")
added check for PERF_SAMPLE_RAW in sample_flags in
perf_prepare_sample(). But while copying the sample in memory,
the check for sample_flags is not added in perf_output_sample().
Fix adds the same in perf_output_sample as well.

Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717003d5..daf387c75d33 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7099,7 +7099,7 @@ void perf_output_sample(struct perf_output_handle *ha=
ndle,
 	if (sample_type & PERF_SAMPLE_RAW) {
 		struct perf_raw_record *raw =3D data->raw;
=20
-		if (raw) {
+		if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
 			struct perf_raw_frag *frag =3D &raw->frag;
=20
 			perf_output_put(handle, raw->size);
--=20
2.31.1

Thanks
Athira

> ---
> arch/s390/kernel/perf_cpum_cf.c    | 1 +
> arch/s390/kernel/perf_pai_crypto.c | 1 +
> arch/x86/events/amd/ibs.c          | 1 +
> include/linux/perf_event.h         | 5 ++---
> kernel/events/core.c               | 3 ++-
> 5 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum=
_cf.c
> index f7dd3c8..f043a7f 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c
> @@ -664,6 +664,7 @@ static int cfdiag_push_sample(struct perf_event *even=
t,
> 		raw.frag.data =3D cpuhw->stop;
> 		raw.size =3D raw.frag.size;
> 		data.raw =3D &raw;
> +		data.sample_flags |=3D PERF_SAMPLE_RAW;
> 	}
>=20
> 	overflow =3D perf_event_overflow(event, &data, &regs);
> diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_p=
ai_crypto.c
> index b38b4ae..6826e2a 100644
> --- a/arch/s390/kernel/perf_pai_crypto.c
> +++ b/arch/s390/kernel/perf_pai_crypto.c
> @@ -366,6 +366,7 @@ static int paicrypt_push_sample(void)
> 		raw.frag.data =3D cpump->save;
> 		raw.size =3D raw.frag.size;
> 		data.raw =3D &raw;
> +		data.sample_flags |=3D PERF_SAMPLE_RAW;
> 	}
>=20
> 	overflow =3D perf_event_overflow(event, &data, &regs);
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index ce5720b..c29a006 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -781,6 +781,7 @@ fail:
> 			},
> 		};
> 		data.raw =3D &raw;
> +		data.sample_flags |=3D PERF_SAMPLE_RAW;
> 	}
>=20
> 	/*
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f4a1357..e9b151c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1028,7 +1028,6 @@ struct perf_sample_data {
> 	 * minimize the cachelines touched.
> 	 */
> 	u64				sample_flags;
> -	struct perf_raw_record		*raw;
> 	u64				period;
>=20
> 	/*
> @@ -1040,6 +1039,7 @@ struct perf_sample_data {
> 	union  perf_mem_data_src	data_src;
> 	u64				txn;
> 	u64				addr;
> +	struct perf_raw_record		*raw;
>=20
> 	u64				type;
> 	u64				ip;
> @@ -1078,8 +1078,7 @@ static inline void perf_sample_data_init(struct per=
f_sample_data *data,
> 					 u64 addr, u64 period)
> {
> 	/* remaining struct members initialized in perf_prepare_sample() */
> -	data->sample_flags =3D 0;
> -	data->raw  =3D NULL;
> +	data->sample_flags =3D PERF_SAMPLE_PERIOD;
> 	data->period =3D period;
>=20
> 	if (addr) {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a91f74d..04e19a8 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7332,7 +7332,7 @@ void perf_prepare_sample(struct perf_event_header *=
header,
> 		struct perf_raw_record *raw =3D data->raw;
> 		int size;
>=20
> -		if (raw) {
> +		if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
> 			struct perf_raw_frag *frag =3D &raw->frag;
> 			u32 sum =3D 0;
>=20
> @@ -7348,6 +7348,7 @@ void perf_prepare_sample(struct perf_event_header *=
header,
> 			frag->pad =3D raw->size - sum;
> 		} else {
> 			size =3D sizeof(u64);
> +			data->raw =3D NULL;
> 		}
>=20
> 		header->size +=3D size;

