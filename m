Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24A5739A08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjFVIiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFVIiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:38:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18A310F4;
        Thu, 22 Jun 2023 01:38:15 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M8GtHL017113;
        Thu, 22 Jun 2023 08:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IdBmjBd+d+wipgVHMjHdZuz/Q2bcPY1vZInPBSwjan8=;
 b=P4OUVdrGwddumfa3+4B43ZMolycnNWHfHx7EIytH9BLnKT6B6g5LLGwWQ8R2cSrwQqUh
 aJK5JvIVWUsrtOEU+gm2PDNOhnxduR02tM7A3sIDKxLd3wRf47y023QYm9twuokea0W2
 I2E2ukG1woZwz5jvMnpvguHVqrM2L7+9gEB/5w3zircvsDdSqFSB4S+Is/qoauR74HpU
 2QjZKTQN0XKBVBDo1SVZapcSyOcTZhaOhGB5rnhUSULFNZr2wdaXay6/zqL8UdeKF1UQ
 A1mZhlXBZRzCDOziiQvMQWKZKAHTXVs6cEf3uCAQ+FUMg1wLeS507Rml2XeJBXtzAt94 gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcjb3s4w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 08:37:48 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35M8HYZS019453;
        Thu, 22 Jun 2023 08:37:24 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcjb3s338-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 08:37:24 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M4l6ju007666;
        Thu, 22 Jun 2023 08:35:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r94f52h7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 08:35:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35M8Zv5e46661956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 08:35:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C5AA200B0;
        Thu, 22 Jun 2023 08:35:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C44BE200B1;
        Thu, 22 Jun 2023 08:35:56 +0000 (GMT)
Received: from [9.152.212.165] (unknown [9.152.212.165])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 22 Jun 2023 08:35:56 +0000 (GMT)
Message-ID: <6c6dc916-7a1a-f5da-a975-af2701a6fb65@linux.ibm.com>
Date:   Thu, 22 Jun 2023 10:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/2] perf pmu: Remove a hard coded cpu PMU assumption
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230622050330.3733114-1-irogers@google.com>
 <20230622050330.3733114-2-irogers@google.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20230622050330.3733114-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RRrUpgmXwJzNN0s6u1DMJdTF18OjoytI
X-Proofpoint-GUID: MaSCIiYK1ZjjD7eZAqQ4kd88rW1m0tPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 07:03, Ian Rogers wrote:
> The property of "cpu" when it has no cpu map is true on S390 with the
> PMU cpum_cf. Rather than maintain a list of such PMUs, reuse the
> is_core test result from the caller.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 963c12f910c5..64fa568a5426 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -551,7 +551,7 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
>   * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
>   * may have a "cpus" file.
>   */
> -static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name)
> +static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name, bool is_core)
>  {
>  	struct perf_cpu_map *cpus;
>  	const char *templates[] = {
> @@ -575,7 +575,8 @@ static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name)
>  			return cpus;
>  	}
>  
> -	return !strcmp(name, "cpu") ? perf_cpu_map__get(cpu_map__online()) : NULL;
> +	/* Nothing found, for core PMUs assume this means all CPUs. */
> +	return is_core ? perf_cpu_map__get(cpu_map__online()) : NULL;
>  }
>  
>  static bool pmu_is_uncore(int dirfd, const char *name)
> @@ -886,7 +887,8 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
>  	if (!pmu)
>  		return NULL;
>  
> -	pmu->cpus = pmu_cpumask(dirfd, name);
> +	pmu->is_core = is_pmu_core(name);
> +	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
>  	pmu->name = strdup(name);
>  	if (!pmu->name)
>  		goto err;
> @@ -903,7 +905,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
>  	}
>  
>  	pmu->type = type;
> -	pmu->is_core = is_pmu_core(name);
>  	pmu->is_uncore = pmu_is_uncore(dirfd, name);
>  	if (pmu->is_uncore)
>  		pmu->id = pmu_id(name);

Looks good to me, for both patches:

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

