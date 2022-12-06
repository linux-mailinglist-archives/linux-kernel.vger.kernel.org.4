Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80F8644565
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiLFOQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiLFOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:15:58 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEF927FD8;
        Tue,  6 Dec 2022 06:15:57 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6E6j2W018855;
        Tue, 6 Dec 2022 14:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=BIFSDAVv2wI7a1dgcEbJwYvbTwm8r1AUFBpBrgN4MxQ=;
 b=L86W99yVsxXZESeG9pZBWzWi1tf7cyhbDtA4J5fTQH+cjJWy9hB3yFdVIDvkpUXcMJfl
 jw4WOLFfC0l2CAIjFWbPBLHODMue95zhsqELDM5aag04hpN0sqcJJKZtAEM/Zmg4xjmD
 GFBaluCZJn6pB0xbhBLaSMHyrNJkbco2AQBJ+xIuQqcYaXb7bfIjcXrM3fHUzG/Ospll
 Bm4WcQtH+Q+yU5pb+O3XdEiZRP+JR01uU6Me1YaRDWAND8waMAtetc7m2olJnAc0wfGQ
 lQ1FEE9Yd/Avimsr9KDWaYM2zas5iny0ZT8bhwVU67DczYqWEH1W6a+ksjmKSGKlTiyO iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ma40sdkbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 14:15:40 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B6Dwtrt019889;
        Tue, 6 Dec 2022 14:15:39 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ma40sdkap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 14:15:39 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6954Wp008303;
        Tue, 6 Dec 2022 14:15:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3m9m5y1h09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 14:15:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com ([9.149.105.160])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B6EFYbN40501616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Dec 2022 14:15:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A513CA405B;
        Tue,  6 Dec 2022 14:15:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A222FA4054;
        Tue,  6 Dec 2022 14:15:31 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.125.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  6 Dec 2022 14:15:31 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] perf stat: Update event skip condition
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20221205231630.319759-1-namhyung@kernel.org>
Date:   Tue, 6 Dec 2022 19:45:29 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED791914-FA30-410A-8BD8-735248940A72@linux.vnet.ibm.com>
References: <20221205231630.319759-1-namhyung@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2neSzjaQHMB1SLNful9yVl1dZmRp8VLC
X-Proofpoint-GUID: F0Xo3C86T5Jln62e6lhTz9QSGA2oYmFk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_09,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212060115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 06-Dec-2022, at 4:46 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> In print_counter_aggrdata(), it skips some events that has no =
aggregate
> count.  It's actually for system-wide per-thread mode and merged =
uncore
> and hybrid events.
>=20
> Let's update the condition to check them explicitly.
>=20
> Fixes: 91f85f98da7a ("Display event stats using aggr counts")
> Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> Athira, could you please check this fixes the problem?
>=20
> tools/perf/util/stat-display.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/perf/util/stat-display.c =
b/tools/perf/util/stat-display.c
> index 847acdb5dc40..6c0de52ac4be 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -814,7 +814,8 @@ static void print_counter_aggrdata(struct =
perf_stat_config *config,
> 	os->nr =3D aggr->nr;
> 	os->evsel =3D counter;
>=20
> -	if (counter->supported && aggr->nr =3D=3D 0)
> +	/* Skip already merged uncore/hybrid events */
> +	if (counter->merged_stat)
> 		return;

Hi Namhyung,

Thanks for the fix.

This patch removes the merged_stat checks from print_aggr and =
print_aggr_cgroup.
We also have this check in print_counter which needs to be removed.

With that change,=20

Acked-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

>=20
> 	uniquify_counter(config, counter);
> @@ -823,6 +824,13 @@ static void print_counter_aggrdata(struct =
perf_stat_config *config,
> 	ena =3D aggr->counts.ena;
> 	run =3D aggr->counts.run;
>=20
> +	/*
> +	 * Skip value 0 when enabling --per-thread globally, otherwise =
it will
> +	 * have too many 0 output.
> +	 */
> +	if (val =3D=3D 0 && config->aggr_mode =3D=3D AGGR_THREAD && =
config->system_wide)
> +		return;
> +
> 	if (!metric_only) {
> 		if (config->json_output)
> 			fputc('{', output);
> @@ -899,9 +907,6 @@ static void print_aggr(struct perf_stat_config =
*config,
> 		print_metric_begin(config, evlist, os, s);
>=20
> 		evlist__for_each_entry(evlist, counter) {
> -			if (counter->merged_stat)
> -				continue;
> -
> 			print_counter_aggrdata(config, counter, s, os);
> 		}
> 		print_metric_end(config, os);
> @@ -928,9 +933,6 @@ static void print_aggr_cgroup(struct =
perf_stat_config *config,
> 			print_metric_begin(config, evlist, os, s);
>=20
> 			evlist__for_each_entry(evlist, counter) {
> -				if (counter->merged_stat)
> -					continue;
> -
> 				if (counter->cgrp !=3D os->cgrp)
> 					continue;
>=20
> --=20
> 2.39.0.rc0.267.gcb52ba06e7-goog
>=20

