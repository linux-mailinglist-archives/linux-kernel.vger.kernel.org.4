Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7934C734CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjFSH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFSH6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:58:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D179E6B;
        Mon, 19 Jun 2023 00:58:37 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J7nrvK004275;
        Mon, 19 Jun 2023 07:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UVc7QTQJZ7JDsfewiDrvsuhEYLKOviG1uZkcmVBxAyA=;
 b=LDBy2qT3oIqeSXDZDGDRkfXRa7VXD6bEM5FWDMyooSE+EMzRS6DdjyiTzrUjweoQg7Pl
 qnV4ubTecMzCYX9sHvJZh+wEdabQ7nS6JJYI8Ljs524oTxqRqul+PJ5Zjcu8wpDib5/4
 5uFmLRAyUgAfzOULt3f7rIRsCd8Tlzt6k+gouvg4Onhp15Ninn8+YJ8WrxPht4RJlYit
 5XTZj0q7rYsvMzNDd3cGhJyi7/ykEs1JvJMNaFqYGix4+gptEuoye6kdWyL0fsi7WWr9
 Fz9Rj0vgZAxjlpaB9fIcavz92hfIQGl/KcFWzRd13PwxhNMJzqhxrVfkuL1SnnfgqQKc bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rajyfg6b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 07:58:34 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35J7oSNa005932;
        Mon, 19 Jun 2023 07:58:34 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rajyfg6ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 07:58:34 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J5pqKn015738;
        Mon, 19 Jun 2023 07:58:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3r943e0x83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 07:58:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35J7wSSB57540958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 07:58:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AEDA2004F;
        Mon, 19 Jun 2023 07:58:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA9442004B;
        Mon, 19 Jun 2023 07:58:27 +0000 (GMT)
Received: from [9.171.51.54] (unknown [9.171.51.54])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jun 2023 07:58:27 +0000 (GMT)
Message-ID: <b938709c-fc80-4801-e70f-5ee70a1ae1bd@linux.ibm.com>
Date:   Mon, 19 Jun 2023 09:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] perf test: fix failing test cases on linux-next for s390
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com
References: <20230616081437.1932003-1-tmricht@linux.ibm.com>
 <ZIxf7A1jPiDUUdDt@kernel.org>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ZIxf7A1jPiDUUdDt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kJ_5xs5yVd8zLCUFf5TAGHQcU_8jHl2i
X-Proofpoint-ORIG-GUID: vO5Npx_Kp1hLPPXoH4xP7YANEPTDhO86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 15:13, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 16, 2023 at 10:14:37AM +0200, Thomas Richter escreveu:
>> In linux-next tree the many test cases fail on s390x when running the
>> perf test suite, sometime the perf tool dumps core.
>>
>> Output before:
>>   6.1: Test event parsing                               : FAILED!
>>  10.3: Parsing of PMU event table metrics               : FAILED!
>>  10.4: Parsing of PMU event table metrics with fake PMUs: FAILED!
>>  17: Setup struct perf_event_attr                       : FAILED!
>>  24: Number of exit events of a simple workload         : FAILED!
>>  26: Object code reading                                : FAILED!
>>  28: Use a dummy software event to keep tracking        : FAILED!
>>  35: Track with sched_switch                            : FAILED!
>>  42.3: BPF prologue generation                          : FAILED!
>>  66: Parse and process metrics                          : FAILED!
>>  68: Event expansion for cgroups                        : FAILED!
>>  69.2: Perf time to TSC                                 : FAILED!
>>  74: build id cache operations                          : FAILED!
>>  86: Zstd perf.data compression/decompression           : FAILED!
>>  87: perf record tests                                  : FAILED!
>> 106: Test java symbol                                   : FAILED!
>>
>> The reason for all these failure is a missing PMU. On s390x
>> the PMU is named cpum_cf which is not detected as core PMU.
>> A similar patch was added before, see
>> commit 9bacbced0e32 ("perf list: Add s390 support for detailed PMU event description")
>> which got lost during the recent reworks. Add it again.
>>
>> Output after:
>>  10.2: PMU event map aliases                            : FAILED!
>>  42.3: BPF prologue generation                          : FAILED!
>>
>> Most test cases now work and there is not core dump anymore.
> 
> So you're not fixing 'perf test', that is just what detects the problem,
> the part being fixed is the PMU code, so I'm rewriting the patch subject
> to:
> 
> [PATCH] perf pmu: Fix core PMU detection on s/390
> 
> Have you bisected the problem to the first patch where this problem
> appears?
> 
> - Arnaldo

Thanks for picking this patch, I noticed it is already in linux-next tree.

No I did not do the bisect. That first patch info came from Ian Rogers.

>  
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: Ian Rogers <irogers@google.com>
>> ---
>>  tools/perf/util/pmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index fe64ad292d36..6142e4710a2f 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1419,7 +1419,7 @@ void perf_pmu__del_formats(struct list_head *formats)
>>  
>>  bool is_pmu_core(const char *name)
>>  {
>> -	return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
>> +	return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sysfs_pmu_core(name);
>>  }
>>  
>>  bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
>> -- 
>> 2.39.2
>>
> 

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

