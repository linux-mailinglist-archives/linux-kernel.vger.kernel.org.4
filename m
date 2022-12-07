Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC50E645378
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLGFhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiLGFhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:37:06 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE4758008;
        Tue,  6 Dec 2022 21:37:05 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B75Ucol025934;
        Wed, 7 Dec 2022 05:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6+j+cskD4HTAaN8ItrN4IUmM0V8Z1VFX4R/8vqJuw+g=;
 b=oD3fisdtUc0pYNKbCAEkyKXZuu7OisvLcNnXBaNV/35RsQLN8+3VFm3p2pqss5dSqzgA
 TvelEeoGwFKiJVj4uTPo2csg16E6dPZ/6oIP+Ym93yIan2nGxKwcP2mQkkzdQQayZSGP
 5ObddOJvEnRReqrDLXQfzSSyhCWWf3K3UqSJN7dPnb/P/qVds+502R9FqpwWrLCmHUVT
 pfZsT4cvJlPcEvsqzfLw8qYS2QI14HzzlB3LsvXmlGE1HJVxoOpInvX1wnbaoe9MX55b
 Zq7sFNPA2ZpRebsVSzoMZTyLn30w8kzElF3nfk+mvUB18hEkNHQInwoK4UMBg4tjFpjc tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mamreg44x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 05:36:49 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B75UmUX026288;
        Wed, 7 Dec 2022 05:36:48 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mamreg448-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 05:36:48 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2B6DMVUe016460;
        Wed, 7 Dec 2022 05:31:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3m9m6y1s8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 05:31:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B75Vg2p19792570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Dec 2022 05:31:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 240B520040;
        Wed,  7 Dec 2022 05:31:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04FCF20043;
        Wed,  7 Dec 2022 05:31:37 +0000 (GMT)
Received: from [9.43.83.42] (unknown [9.43.83.42])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  7 Dec 2022 05:31:36 +0000 (GMT)
Message-ID: <2f0f83f3-91a9-a719-c36e-ca1ff5c9b6f8@linux.ibm.com>
Date:   Wed, 7 Dec 2022 11:01:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/2] perf test: Add event group test
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        carsten.haitzler@arm.com, Leo Yan <leo.yan@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
 <20221206043237.12159-3-ravi.bangoria@amd.com>
 <C7F7A9B0-421E-40AB-987C-6D250B9633D3@linux.vnet.ibm.com>
 <2e45a93d-56fd-b18e-de61-51ceccfee8a3@amd.com>
Content-Language: en-US
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <2e45a93d-56fd-b18e-de61-51ceccfee8a3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V7Xzhf7WfmIbbq3-ysEezoggGeaO1SfN
X-Proofpoint-GUID: szfonUSxKYe21_Q_vdNfrcZ6CNsMIiW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_02,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070043
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/22 9:56 AM, Ravi Bangoria wrote:
> Hi Athira,
>
>>> +static int setup_uncore_event(void)
>>> +{
>>> +	struct perf_pmu *pmu;
>>> +	int i;
>>> +
>>> +	if (list_empty(&pmus))
>>> +		perf_pmu__scan(NULL);
>>> +
>>> +	perf_pmus__for_each_pmu(pmu) {
>>> +		for (i = 0; i < NR_UNCORE_PMUS; i++) {
>>> +			if (!strcmp(uncore_pmus[i].name, pmu->name)) {
>>> +				pr_debug("Using %s for uncore pmu event\n", pmu->name);
>>> +				types[2] = pmu->type;
>>> +				configs[2] = uncore_pmus[i].config;
>> Hi Ravi,
>>
>> Observed failure while running the test on powerpc. It is because the uncore PMU ie hv_24x7 needs
>> performance monitoring to be enabled in powerpc. So to handle such cases, can we add an “event_open" check before
>> proceeding with the test. Below is the change on top of “tmp.perf/core” .
>>
>>
>>  From 8b33fb900c26beafc28f75b6f64631f8fdd045c2 Mon Sep 17 00:00:00 2001
>> From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> Date: Tue, 6 Dec 2022 20:17:25 +0530
>> Subject: [PATCH] perf test: Update event group check for support of uncore
>>   event
>>
>> Event group test checks group creation for combinations of
>> hw, sw and uncore PMU events. Some of the uncore pmu event
>> requires performance enablement explicitly.
> You need to open an event to activate hv_24x7 pmu?
hv_24x7 pmu supports events which can also provide system-wide resource data
and partition should have permissions to access those, hence the check.

Maddy
>
>> Example, hv_24x7
>> event in powerpc. Hence add a check to see if event_open
>> succeeds before proceeding.
>>
>> Fixes: 5c88101b797d ("perf test: Add event group test for events in multiple PMUs")
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>>   tools/perf/tests/event_groups.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
>> index 612c0444aaa8..ad52e1da259a 100644
>> --- a/tools/perf/tests/event_groups.c
>> +++ b/tools/perf/tests/event_groups.c
>> @@ -51,7 +51,7 @@ static int event_open(int type, unsigned long config, int group_fd)
>>   static int setup_uncore_event(void)
>>   {
>>   	struct perf_pmu *pmu;
>> -	int i;
>> +	int i, fd;
>>   
>>   	if (list_empty(&pmus))
>>   		perf_pmu__scan(NULL);
>> @@ -62,6 +62,10 @@ static int setup_uncore_event(void)
>>   				pr_debug("Using %s for uncore pmu event\n", pmu->name);
>>   				types[2] = pmu->type;
>>   				configs[2] = uncore_pmus[i].config;
> Sure. Just add a comment here to explain why are we opening a
> standalone event here.
>
>> +				fd = event_open(types[2], configs[2], -1);
>> +				if (fd < 0)
>> +					return -1;
>> +				close(fd);
>>   				return 0;
>>   			}
>>   		}
> Thanks,
> Ravi
