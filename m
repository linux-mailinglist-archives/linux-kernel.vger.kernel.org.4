Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67392644A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiLFR2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiLFR2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:28:35 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260862FFE8;
        Tue,  6 Dec 2022 09:28:34 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6Fp4oY018757;
        Tue, 6 Dec 2022 17:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=6KyngVsGeTHndunyIhehZIijEgaC7Yd64qTrUX2gGmw=;
 b=OH0OwJQJCQe1DdvFIJZV7GBd8NZvRLLHIkZelZA6+5IbPrNPkZJSXNmLWzO7NN2Z+a75
 XXTsuyOdvHy9JKt/upQCmHy4T/oNU2+tHkh5xb+Jgp1mkvzknFYOx4Z1gOvJpxXo848e
 LhOvDw4hywTzccCBYEAcIxF39g36te//t7QoRN1iZD0WQYZkK9WNdZrj6zGRFMYTWTgo
 FifB1gD7A6RvcyRMO9NldnYkGs6BJ//1fNAiG/DAQLdBz2R838Lz1nWFFJu7Crv/IeYu
 k+v41KQzNifIvU7CBwk10FW+gnJHXibwYeKVljcOFCfxCxBrm/uh6kd4Lsq7GQEfGLF4 Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ma40sjw14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 17:28:14 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B6HFPR3031595;
        Tue, 6 Dec 2022 17:28:14 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ma40sjw03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 17:28:13 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2B6DZAoD016464;
        Tue, 6 Dec 2022 17:28:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3m9m6y1a9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 17:28:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B6HS8OV21168840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Dec 2022 17:28:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 001C32004B;
        Tue,  6 Dec 2022 17:28:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BD2E20043;
        Tue,  6 Dec 2022 17:28:04 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.49.182])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  6 Dec 2022 17:28:04 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v3 2/2] perf test: Add event group test
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20221206043237.12159-3-ravi.bangoria@amd.com>
Date:   Tue, 6 Dec 2022 22:57:44 +0530
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        carsten.haitzler@arm.com, Leo Yan <leo.yan@linaro.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7F7A9B0-421E-40AB-987C-6D250B9633D3@linux.vnet.ibm.com>
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
 <20221206043237.12159-3-ravi.bangoria@amd.com>
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t95Z8NEYB8_1tby92AOoVLST3I708UMK
X-Proofpoint-GUID: 598D7D-lvS7wc0_XS9rwwC68nrkL7Kst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_11,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212060142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 06-Dec-2022, at 10:02 AM, Ravi Bangoria <ravi.bangoria@amd.com> =
wrote:
>=20
> Multiple events in a group can belong to one or more pmus, however
> there are some limitations to it. One of the limitation is, perf
> doesn't allow creating a group of events from different hw pmus.
> Write a simple test to create various combinations of hw, sw and
> uncore pmu events and verify group creation succeeds or fails as
> expected.
>=20
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> tools/perf/tests/Build          |   1 +
> tools/perf/tests/builtin-test.c |   1 +
> tools/perf/tests/event_groups.c | 127 ++++++++++++++++++++++++++++++++
> tools/perf/tests/tests.h        |   1 +
> 4 files changed, 130 insertions(+)
> create mode 100644 tools/perf/tests/event_groups.c
>=20
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 11b69023011b..658b5052c24d 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -67,6 +67,7 @@ perf-y +=3D expand-cgroup.o
> perf-y +=3D perf-time-to-tsc.o
> perf-y +=3D dlfilter-test.o
> perf-y +=3D sigtrap.o
> +perf-y +=3D event_groups.o
>=20
> $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
> 	$(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c =
b/tools/perf/tests/builtin-test.c
> index 4c6ae59a4dfd..ddd8262bfa26 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -110,6 +110,7 @@ static struct test_suite *generic_tests[] =3D {
> 	&suite__perf_time_to_tsc,
> 	&suite__dlfilter,
> 	&suite__sigtrap,
> +	&suite__event_groups,
> 	NULL,
> };
>=20
> diff --git a/tools/perf/tests/event_groups.c =
b/tools/perf/tests/event_groups.c
> new file mode 100644
> index 000000000000..612c0444aaa8
> --- /dev/null
> +++ b/tools/perf/tests/event_groups.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include "linux/perf_event.h"
> +#include "tests.h"
> +#include "debug.h"
> +#include "pmu.h"
> +#include "pmus.h"
> +#include "header.h"
> +#include "../perf-sys.h"
> +
> +/* hw: cycles, sw: context-switch, uncore: [arch dependent] */
> +static int types[] =3D {0, 1, -1};
> +static unsigned long configs[] =3D {0, 3, 0};
> +
> +#define NR_UNCORE_PMUS 5
> +
> +/* Uncore pmus that support more than 3 counters */
> +static struct uncore_pmus {
> +	const char *name;
> +	__u64 config;
> +} uncore_pmus[NR_UNCORE_PMUS] =3D {
> +	{ "amd_l3", 0x0 },
> +	{ "amd_df", 0x0 },
> +	{ "uncore_imc_0", 0x1 },         /* Intel */
> +	{ "core_imc", 0x318 },           /* PowerPC: =
core_imc/CPM_STCX_FIN/ */
> +	{ "hv_24x7", 0x22000000003 },    /* PowerPC: =
hv_24x7/CPM_STCX_FIN/ */
> +};
> +
> +static int event_open(int type, unsigned long config, int group_fd)
> +{
> +	struct perf_event_attr attr;
> +
> +	memset(&attr, 0, sizeof(struct perf_event_attr));
> +	attr.type =3D type;
> +	attr.size =3D sizeof(struct perf_event_attr);
> +	attr.config =3D config;
> +	/*
> +	 * When creating an event group, typically the group leader is
> +	 * initialized with disabled set to 1 and any child events are
> +	 * initialized with disabled set to 0. Despite disabled being 0,
> +	 * the child events will not start until the group leader is
> +	 * enabled.
> +	 */
> +	attr.disabled =3D group_fd =3D=3D -1 ? 1 : 0;
> +
> +	return sys_perf_event_open(&attr, -1, 0, group_fd, 0);
> +}
> +
> +static int setup_uncore_event(void)
> +{
> +	struct perf_pmu *pmu;
> +	int i;
> +
> +	if (list_empty(&pmus))
> +		perf_pmu__scan(NULL);
> +
> +	perf_pmus__for_each_pmu(pmu) {
> +		for (i =3D 0; i < NR_UNCORE_PMUS; i++) {
> +			if (!strcmp(uncore_pmus[i].name, pmu->name)) {
> +				pr_debug("Using %s for uncore pmu =
event\n", pmu->name);
> +				types[2] =3D pmu->type;
> +				configs[2] =3D uncore_pmus[i].config;

Hi Ravi,

Observed failure while running the test on powerpc. It is because the =
uncore PMU ie hv_24x7 needs
performance monitoring to be enabled in powerpc. So to handle such =
cases, can we add an =E2=80=9Cevent_open" check before
proceeding with the test. Below is the change on top of =
=E2=80=9Ctmp.perf/core=E2=80=9D .


=46rom 8b33fb900c26beafc28f75b6f64631f8fdd045c2 Mon Sep 17 00:00:00 2001
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Date: Tue, 6 Dec 2022 20:17:25 +0530
Subject: [PATCH] perf test: Update event group check for support of =
uncore
 event

Event group test checks group creation for combinations of
hw, sw and uncore PMU events. Some of the uncore pmu event
requires performance enablement explicitly. Example, hv_24x7
event in powerpc. Hence add a check to see if event_open
succeeds before proceeding.

Fixes: 5c88101b797d ("perf test: Add event group test for events in =
multiple PMUs")
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/event_groups.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/event_groups.c =
b/tools/perf/tests/event_groups.c
index 612c0444aaa8..ad52e1da259a 100644
--- a/tools/perf/tests/event_groups.c
+++ b/tools/perf/tests/event_groups.c
@@ -51,7 +51,7 @@ static int event_open(int type, unsigned long config, =
int group_fd)
 static int setup_uncore_event(void)
 {
 	struct perf_pmu *pmu;
-	int i;
+	int i, fd;
=20
 	if (list_empty(&pmus))
 		perf_pmu__scan(NULL);
@@ -62,6 +62,10 @@ static int setup_uncore_event(void)
 				pr_debug("Using %s for uncore pmu =
event\n", pmu->name);
 				types[2] =3D pmu->type;
 				configs[2] =3D uncore_pmus[i].config;
+				fd =3D event_open(types[2], configs[2], =
-1);
+				if (fd < 0)
+					return -1;
+				close(fd);
 				return 0;
 			}
 		}
--=20
2.31.1


Ravi, Please share your comments on this. If this looks fine, I can post =
this as separate fix patch.

Thanks
Athira
> +				return 0;
> +			}
> +		}
> +	}
> +	return -1;
> +}
> +
> +static int run_test(int i, int j, int k)
> +{
> +	int erroneous =3D ((((1 << i) | (1 << j) | (1 << k)) & 5) =3D=3D =
5);
> +	int group_fd, sibling_fd1, sibling_fd2;
> +
> +	group_fd =3D event_open(types[i], configs[i], -1);
> +	if (group_fd =3D=3D -1)
> +		return -1;
> +
> +	sibling_fd1 =3D event_open(types[j], configs[j], group_fd);
> +	if (sibling_fd1 =3D=3D -1) {
> +		close(group_fd);
> +		return erroneous ? 0 : -1;
> +	}
> +
> +	sibling_fd2 =3D event_open(types[k], configs[k], group_fd);
> +	if (sibling_fd2 =3D=3D -1) {
> +		close(sibling_fd1);
> +		close(group_fd);
> +		return erroneous ? 0 : -1;
> +	}
> +
> +	close(sibling_fd2);
> +	close(sibling_fd1);
> +	close(group_fd);
> +	return erroneous ? -1 : 0;
> +}
> +
> +static int test__event_groups(struct test_suite *text __maybe_unused, =
int subtest __maybe_unused)
> +{
> +	int i, j, k;
> +	int ret;
> +	int r;
> +
> +	ret =3D setup_uncore_event();
> +	if (ret || types[2] =3D=3D -1)
> +		return TEST_SKIP;
> +
> +	ret =3D TEST_OK;
> +	for (i =3D 0; i < 3; i++) {
> +		for (j =3D 0; j < 3; j++) {
> +			for (k =3D 0; k < 3; k++) {
> +				r =3D run_test(i, j, k);
> +				if (r)
> +					ret =3D TEST_FAIL;
> +
> +				pr_debug("0x%x 0x%lx, 0x%x 0x%lx, 0x%x =
0x%lx: %s\n",
> +					 types[i], configs[i], types[j], =
configs[j],
> +					 types[k], configs[k], r ? =
"Fail" : "Pass");
> +			}
> +		}
> +	}
> +	return ret;
> +}
> +
> +DEFINE_SUITE("Event groups", event_groups);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index e15f24cfc909..fb4b5ad4dd0f 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -147,6 +147,7 @@ DECLARE_SUITE(expand_cgroup_events);
> DECLARE_SUITE(perf_time_to_tsc);
> DECLARE_SUITE(dlfilter);
> DECLARE_SUITE(sigtrap);
> +DECLARE_SUITE(event_groups);
>=20
> /*
>  * PowerPC and S390 do not support creation of instruction breakpoints =
using the
> --=20
> 2.38.1
>=20

