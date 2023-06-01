Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B883719A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjFALGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFALGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:06:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E1F2;
        Thu,  1 Jun 2023 04:06:12 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351At57K018580;
        Thu, 1 Jun 2023 11:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Tfr0WJBAMZ7HcGa+FXMjnKOcQ5ZhtjrOBu2OYyx3ED0=;
 b=tL3hWm/r5T0lnpg6UdAPPiu1deHgZMVnPah+kHQO3o1ovspZ9h+zEYKZRrWO1VsGELf6
 KqQXdDuyUE7wMkrUsXsF0veeZ5kMPwib2L5ZurlrZI9lH8LLNcXgJjw9B6QbevMKtttU
 H4rdCrZ4hEEaGcFeT9/P7p6sTnNhhUJc14TJliaNnTrow3bssBBSwLL+GgGc6Y5t7ApU
 lctHuXCFLi1xQcMiPIastEih1pRlKLJYiKmBKzVr6cdsRSRMJu/OXoTZoGqeZG9r323Y
 OYLTDXNf7bKnpPSbA81mjlf4V9cHZ6Ezv6ZgT08BUD6R+cEGuHSkS0bdM98ybFml1BCg eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxt0hr79u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 11:02:37 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351At6hJ018630;
        Thu, 1 Jun 2023 11:02:36 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxt0hr78c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 11:02:36 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 351704I8011520;
        Thu, 1 Jun 2023 11:02:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qu9g522ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 11:02:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 351B2Vdm42140272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jun 2023 11:02:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 522BD2004E;
        Thu,  1 Jun 2023 11:02:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C92EE20043;
        Thu,  1 Jun 2023 11:02:30 +0000 (GMT)
Received: from [9.152.212.239] (unknown [9.152.212.239])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jun 2023 11:02:30 +0000 (GMT)
Message-ID: <aa2f8581-6440-87c0-1578-157719f7543e@linux.ibm.com>
Date:   Thu, 1 Jun 2023 13:02:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
To:     Ian Rogers <irogers@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Nathan Chancellor <nathan@kernel.org>, namhyung@kernel.org,
        eranian@google.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, bp@alien8.de, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, kvmarm@lists.linux.dev
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-4-ravi.bangoria@amd.com>
 <20230524214133.GA2359762@dev-arch.thelio-3990X>
 <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com> <ZG8KLbZSECiYaKFc@linux.dev>
 <20230525142031.GU83892@hirez.programming.kicks-ass.net>
 <ZG+FLdP2kkfI1m2Z@linux.dev>
 <CAP-5=fWYbzmTETgqJ11y22=JaXDM0gnb4qR6KYeRGmFXw08f-Q@mail.gmail.com>
 <86jzwtdhmk.wl-maz@kernel.org>
 <CAP-5=fVW6KbUbbEfF3mEFvTfFDC5yKSjSpa+w3D55dG3CNUERw@mail.gmail.com>
 <86h6rxd3gh.wl-maz@kernel.org>
 <0075d8a9-2df4-86eb-8171-8995f59904e0@linux.ibm.com>
 <CAP-5=fXo0t+buDrmf7SyTD97gmTWGoDAO2YXWyav+_79O3MZ0w@mail.gmail.com>
 <a1f27798-0b06-7dc3-028b-038512947306@linux.ibm.com>
 <CAP-5=fVw3vSEu7yGFDnZi8c3VUFJu_XEZtY9ZcTsD7ip2imR6Q@mail.gmail.com>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fVw3vSEu7yGFDnZi8c3VUFJu_XEZtY9ZcTsD7ip2imR6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o3n4wIYJTnGjfax92N3nUdByl_UpL3Zo
X-Proofpoint-GUID: lyONYjpzQy5cwArCYVv9fVjBxg18AULn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_07,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 22:20, Ian Rogers wrote:
> On Wed, May 31, 2023 at 2:09 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> On 5/30/23 16:00, Ian Rogers wrote:
>>> ls /sys/devices/*/cpu*
>>
>> Hi Ian,
>>
>> here is the output yo requested:
>>
>> # ls /sys/devices/*/cpu*
>> cpu0  cpu3  cpu6         hotplug     modalias  possible  smt
>> cpu1  cpu4  cpu7         isolated    offline   present   uevent
>> cpu2  cpu5  dispatching  kernel_max  online    rescan    vulnerabilities
>> #
>>
>> In fact it is the same as
>> # ls  /sys/devices/system/cpu/
>> cpu0  cpu3  cpu6         hotplug     modalias  possible  smt
>> cpu1  cpu4  cpu7         isolated    offline   present   uevent
>> cpu2  cpu5  dispatching  kernel_max  online    rescan    vulnerabilities
>> #
>> This directory tree has nothing to do with events for perf, it is
>> merely used to support CPU hotplug on s390.
>>
>> The PMUs on s390 are
>> # ls -ld /sys/devices/{cpum_,pai_}*
>> drwxr-xr-x 4 root root 0 May 25 15:45 /sys/devices/cpum_cf
>> drwxr-xr-x 4 root root 0 May 25 15:45 /sys/devices/cpum_cf_diag
>> drwxr-xr-x 4 root root 0 May 25 15:45 /sys/devices/cpum_sf
>> drwxr-xr-x 4 root root 0 May 25 15:45 /sys/devices/pai_crypto
>> drwxr-xr-x 4 root root 0 May 25 15:45 /sys/devices/pai_ext
>> #
>>
>> I hope his helps.
> 
> Thanks Thomas,
> 
> The perf tool has a notion of "core" and "other" PMUs - other means
> uncore and things like interconnect PMUs. The distinction matters as
> PMUs may have a list of CPUs with them, for "other" PMUs the CPU list
> (known in the tool as the CPU map) is a suggestion of the CPU to open
> events on. For example, on my laptop:
> ```
> $ cat /sys/devices/system/cpu/online
> 0-15
> $ cat /sys/devices/uncore_imc_free_running_0/cpumask
> 0
> ```
> So I have 16 "CPUs" and the memory controller is suggesting opening
> the events on CPU 0. However, if I do:
> ```
> $ sudo perf stat -e 'uncore_imc_free_running_0/data_read/' -C 8 -a -A sleep 1
> 
> Performance counter stats for 'system wide':
> 
> CPU8                 4,617.60 MiB
> uncore_imc_free_running_0/data_read/
> 
> 
>       1.001094684 seconds time elapsed
> ```
> Then things are good and the event was recorded on CPU 8, even though
> the cpumask of the PMU only said CPU 0.
> 
> For "core" PMUs the CPU map works differently. A CPU outside of the
> map is an error. For example, if I have a heterogeneous system with 2
> CPUs, the first CPU on 1 PMU and the second CPU on a different PMU, if
> I try to open events for the wrong PMU  type for the CPU then it
> should fail. The CPU map should be interpreted as the set of CPUs
> events are valid on.
> 
> The logic to determine if a PMU is "core" or "other" is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n1417
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n609
> 
> That is, a PMU is a "core" PMU if it is called "cpu" or if there is a
> file called "cpus" inside the PMU's sysfs directory. It seems on s390
> none of the PMUs are considered "core" and this is why we're having
> issues.
> 
> Looking at:
> https://lore.kernel.org/lkml/20180416132314.33249-1-tmricht@linux.ibm.com/
> 
> It would seem to make sense that "cpu", "cpum_cf" and "cpum_sf" should
> all cause "is_pmu_core" to return true, From your output I suspect the
> issue is that cpum_cf and cpum_sf both lack the "cpus" file - which is
> also true on homogeneous x86's "cpu" PMU. We can fix the code with:
> 
> ```
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 0520aa9fe991..bdc3f3b148fc 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1414,7 +1414,9 @@ void perf_pmu__del_formats(struct list_head *formats)
> 
> bool is_pmu_core(const char *name)
> {
> -       return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
> +       return !strcmp(name, "cpu") ||
> +              !strcmp(name, "cpum_cf") || !strcmp(name, "cpum_sf") ||
> +              is_sysfs_pmu_core(name);
> }
> 
> bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
> ```
> 
> Wdyt? Thanks,
> Ian
> 

Ian, thanks very much for your help. I changed the code as you
suggested and added s390's PMU cpum_cf as in

bool is_pmu_core(const char *name)
{
        return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") ||
               is_sysfs_pmu_core(name);
}

The result is much better, now the
- test case 6.1 fails only 2 times and for a different reason:
  running test 2 'r1a'
  FAILED tests/parse-events.c:125 Raw PMU not matched
  Event test failure: test 2 'r1a' rc -1
  ...
  running test 14 'r1a:kp'
  FAILED tests/parse-events.c:125 Raw PMU not matched
  Event test failure: test 14 'r1a:kp' rc -1
  
- test case 10.2 fails for an unknown event bp_l1_btb_correct.
   10.2: PMU event map aliases         :
   --- start ---
   Using CPUID IBM,8561,703,T01,3.6,002f
   testing aliases core PMU cpum_cf: no alias, alias_table->name=bp_l1_btb_correct
   testing core PMU cpum_cf aliases: failed
   ---- end ----
   PMU events subtest 2: FAILED!
- test case 68 now succeeds:
  # ./perf test  68
  68: Parse and process metrics        : Ok
  #

Regarding test case 6.1: 
Raw PMU not matched is printed in tests/parse-events.c::125
Debugging revealed that function
  test_event()
  +--> parse_events() which returns 0
  +--> e->check() ---> test__checkevent_raw()
This function has TEST_ASSERT_VAL("Raw PMU not matched", raw_type_match);
triggering -1 because the PMU has type 8 which is not PERF_TYPE_RAW

Maybe make type >= PERF_TYPE_RAW to succeed the test?

Regarding test case 10.2: the event bp_l1_btb_correct does not exist on
s390. It is defined in
- pmu-events/empty-pmu-events.c
- pmu-events/arch/test/test_soc/cpu/branch.json
Not sure which one is used.
But this event is unknown on s390

What is the best way to fix these issues.

PS: I have the feeling, it gets complicated to have multiple hardware PMUs
per platform.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

