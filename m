Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5F5643D11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiLFGSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiLFGSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:18:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D709A26569;
        Mon,  5 Dec 2022 22:18:29 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B64FUcA024266;
        Tue, 6 Dec 2022 06:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KO4SFPoY9HxiHfgbl+R2dykJ1y+V6osLOnZPaMBYx0c=;
 b=TarQCoSL2rm8kGoD2NhuKQffJJ+7A8FjDQJnzvK+QOcD8kS9Q9eG4IliCt8Y2uFtwPp+
 61VLMpSfphUbxztgMCQUFkZ09Q7sgoa3akL6X3frMCXkNAWOV07CWnNTsnCvJyIpUp6v
 6INQmDG3KW8qD0Tl6n3L1wUOiYTxcJ2UI/Nqu9SdK1Yp0jUpd5lBdmAFSf7xuDVP5Lo8
 y6KCg1Q/AXbQAEM3D3kpnzwRZQjsJWCM78k2S1rg7eD/gte4ocSyilylwsPV5pw8Y5gF
 36oAckPzqIckPimURboWqkIWvQ2vA0Bg4RM7DZW20MCjpHvMajZInxngIMThtE7aIbWh Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8g7dbe05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 06:18:07 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B6623vl006528;
        Tue, 6 Dec 2022 06:18:06 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8g7dbdyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 06:18:06 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2B5K5GCr016460;
        Tue, 6 Dec 2022 06:18:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3m9m6y0mn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 06:18:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com ([9.149.105.59])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B66HxMN43712832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Dec 2022 06:18:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C80D7A404D;
        Tue,  6 Dec 2022 06:17:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8035A4040;
        Tue,  6 Dec 2022 06:17:55 +0000 (GMT)
Received: from [9.43.11.39] (unknown [9.43.11.39])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Dec 2022 06:17:55 +0000 (GMT)
Message-ID: <95f8295a-9f51-c708-d0f6-e58cd907f23c@linux.ibm.com>
Date:   Tue, 6 Dec 2022 11:47:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/2] perf test: Add event group test
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org
Cc:     kan.liang@linux.intel.com, irogers@google.com, jolsa@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        carsten.haitzler@arm.com, leo.yan@linaro.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, tmricht@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
 <20221206043237.12159-3-ravi.bangoria@amd.com>
Content-Language: en-US
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20221206043237.12159-3-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4xaTP2dRexnC-5HexWwpv_U_t49lejwH
X-Proofpoint-ORIG-GUID: BNIQBocijtwlcJbQXkJjWWrgEzNpyamM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_03,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060049
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/22 10:02 AM, Ravi Bangoria wrote:
> Multiple events in a group can belong to one or more pmus, however
> there are some limitations to it. One of the limitation is, perf
> doesn't allow creating a group of events from different hw pmus.
> Write a simple test to create various combinations of hw, sw and
> uncore pmu events and verify group creation succeeds or fails as
> expected.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>   tools/perf/tests/Build          |   1 +
>   tools/perf/tests/builtin-test.c |   1 +
>   tools/perf/tests/event_groups.c | 127 ++++++++++++++++++++++++++++++++
>   tools/perf/tests/tests.h        |   1 +
>   4 files changed, 130 insertions(+)
>   create mode 100644 tools/perf/tests/event_groups.c
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 11b69023011b..658b5052c24d 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -67,6 +67,7 @@ perf-y += expand-cgroup.o
>   perf-y += perf-time-to-tsc.o
>   perf-y += dlfilter-test.o
>   perf-y += sigtrap.o
> +perf-y += event_groups.o
>   
>   $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>   	$(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 4c6ae59a4dfd..ddd8262bfa26 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -110,6 +110,7 @@ static struct test_suite *generic_tests[] = {
>   	&suite__perf_time_to_tsc,
>   	&suite__dlfilter,
>   	&suite__sigtrap,
> +	&suite__event_groups,
>   	NULL,
>   };
>   
> diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
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
> +static int types[] = {0, 1, -1};
> +static unsigned long configs[] = {0, 3, 0};
> +
> +#define NR_UNCORE_PMUS 5
> +
> +/* Uncore pmus that support more than 3 counters */
> +static struct uncore_pmus {
> +	const char *name;
> +	__u64 config;
> +} uncore_pmus[NR_UNCORE_PMUS] = {
> +	{ "amd_l3", 0x0 },
> +	{ "amd_df", 0x0 },
> +	{ "uncore_imc_0", 0x1 },         /* Intel */
> +	{ "core_imc", 0x318 },           /* PowerPC: core_imc/CPM_STCX_FIN/ */
> +	{ "hv_24x7", 0x22000000003 },    /* PowerPC: hv_24x7/CPM_STCX_FIN/ */


For Powerpc event config values
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>

> +};
> +
> +static int event_open(int type, unsigned long config, int group_fd)
> +{
> +	struct perf_event_attr attr;
> +
> +	memset(&attr, 0, sizeof(struct perf_event_attr));
> +	attr.type = type;
> +	attr.size = sizeof(struct perf_event_attr);
> +	attr.config = config;
> +	/*
> +	 * When creating an event group, typically the group leader is
> +	 * initialized with disabled set to 1 and any child events are
> +	 * initialized with disabled set to 0. Despite disabled being 0,
> +	 * the child events will not start until the group leader is
> +	 * enabled.
> +	 */
> +	attr.disabled = group_fd == -1 ? 1 : 0;
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
> +		for (i = 0; i < NR_UNCORE_PMUS; i++) {
> +			if (!strcmp(uncore_pmus[i].name, pmu->name)) {
> +				pr_debug("Using %s for uncore pmu event\n", pmu->name);
> +				types[2] = pmu->type;
> +				configs[2] = uncore_pmus[i].config;
> +				return 0;
> +			}
> +		}
> +	}
> +	return -1;
> +}
> +
> +static int run_test(int i, int j, int k)
> +{
> +	int erroneous = ((((1 << i) | (1 << j) | (1 << k)) & 5) == 5);
> +	int group_fd, sibling_fd1, sibling_fd2;
> +
> +	group_fd = event_open(types[i], configs[i], -1);
> +	if (group_fd == -1)
> +		return -1;
> +
> +	sibling_fd1 = event_open(types[j], configs[j], group_fd);
> +	if (sibling_fd1 == -1) {
> +		close(group_fd);
> +		return erroneous ? 0 : -1;
> +	}
> +
> +	sibling_fd2 = event_open(types[k], configs[k], group_fd);
> +	if (sibling_fd2 == -1) {
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
> +static int test__event_groups(struct test_suite *text __maybe_unused, int subtest __maybe_unused)
> +{
> +	int i, j, k;
> +	int ret;
> +	int r;
> +
> +	ret = setup_uncore_event();
> +	if (ret || types[2] == -1)
> +		return TEST_SKIP;
> +
> +	ret = TEST_OK;
> +	for (i = 0; i < 3; i++) {
> +		for (j = 0; j < 3; j++) {
> +			for (k = 0; k < 3; k++) {
> +				r = run_test(i, j, k);
> +				if (r)
> +					ret = TEST_FAIL;
> +
> +				pr_debug("0x%x 0x%lx, 0x%x 0x%lx, 0x%x 0x%lx: %s\n",
> +					 types[i], configs[i], types[j], configs[j],
> +					 types[k], configs[k], r ? "Fail" : "Pass");
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
>   DECLARE_SUITE(perf_time_to_tsc);
>   DECLARE_SUITE(dlfilter);
>   DECLARE_SUITE(sigtrap);
> +DECLARE_SUITE(event_groups);
>   
>   /*
>    * PowerPC and S390 do not support creation of instruction breakpoints using the
