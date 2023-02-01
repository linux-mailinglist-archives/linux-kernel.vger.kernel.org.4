Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89780686EA3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBATHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBATHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:07:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8D911666;
        Wed,  1 Feb 2023 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675278420; x=1706814420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BeV+g4xcrdhiBAPU8q3kcX0q9z2wYQxEEkxTU/6a/uA=;
  b=fgRKPy54Z3Xlf4VZqBWW6OVAHUMNwshmgfnbqWobYPvBXr0iMLg5Arxq
   UiVqJ60ZsdHYiDZa1UyH/Hm7HvLg0T+5V4Wg6gJaSPQUyPvI7vOEDu3nS
   2nxPe9w/ojhFC1PkWW+f8HgDBUAVWeRnIU2WuJoEGwFWzMoUpYN5a1eIv
   ky9BRoxmhob4v7ToHqhk42pqKRC2Doo8qECvKxvxMqBOlHnzN67liiLdq
   nZC5dFi4LUaf0t69SfR8KTJQK1JzezVEzrix4d+EQIv/LTgGPeJQFiQGf
   Xt3lBgCvym+B43sVVxHQyOPtTQ3SyhW8oy2LRTldjq24oayplVjIinh5K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="311889601"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="311889601"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="697384825"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="697384825"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2023 11:06:57 -0800
Received: from [10.255.230.85] (kliang2-mobl1.ccr.corp.intel.com [10.255.230.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F3647580514;
        Wed,  1 Feb 2023 11:06:55 -0800 (PST)
Message-ID: <df8d710c-2543-520e-fe82-dbc8b2a47950@linux.intel.com>
Date:   Wed, 1 Feb 2023 14:06:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [6.1.7][6.2-rc5] perf all metrics test: FAILED!
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     sedat.dilek@gmail.com, "Xing, Zhengjun" <zhengjun.xing@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        llvm@lists.linux.dev, Ben Hutchings <benh@debian.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
References: <CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhNdTDRQfGUBMQ@mail.gmail.com>
 <CAP-5=fULKkEYXOVV5tXd8J0occGJwgV+BiJLkA=exW=bfgyEBw@mail.gmail.com>
 <CA+icZUUOZoLOFiBcYkccWPSusk9G_Rhf3DOZYWat-K+VfWFHQw@mail.gmail.com>
 <c6605d52-b9e1-e8d3-ed29-562146f64eea@arm.com>
 <CAP-5=fWcb8m9vkfqSC9H2Gqi2dBjbPuGb2F27Fq-ejmR25foQw@mail.gmail.com>
 <CA+icZUWKFCdhQ9XN0wLN6BF5ft3WaNrtXDb9D8ckNOPG9gUf+g@mail.gmail.com>
 <CAP-5=fUSyN5wCn5miG79cT30YruJjkAYMeR58XXgRBQw-6hHkQ@mail.gmail.com>
 <20b09a5b-99b3-75b8-3ec8-e978965497f2@linux.intel.com>
 <CAP-5=fXHDuB5G+ujVCoe81H+-Y=J8ig6TZ-dGZHknskb7Z53ig@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXHDuB5G+ujVCoe81H+-Y=J8ig6TZ-dGZHknskb7Z53ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-01 12:02 p.m., Ian Rogers wrote:
> On Wed, Feb 1, 2023 at 7:28 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> Hi Ian,
>>
>> On 2023-01-30 10:55 p.m., Ian Rogers wrote:
>>>>> There's a question about what we should do in the perf test about
>>>>> this? I have a few solutions:
>>>>>
>>>>> 1) try metric tests again with the --metric-no-group flag and don't
>>>>> fail the test if this succeeds. This allows kernel bugs to hide, so
>>>>> I'm not a huge fan.
>>>>>
>>>>> 2) add a new metric flag/constraint to say not to group, this way the
>>>>> metric will automatically apply the "--metric-no-group" flag. It is a
>>>>> bit of work to wire this up but this kind of failure is common enough
>>>>> in PMUs that it is probably worthwhile. We also need to add the flag
>>>>> to metrics and I'm not sure how to get a good list of the metrics that
>>>>> currently fail and require it. This is okay but error prone.
>>>>>
>>>>> 3) fix the kernel bug and let the perf test fail until an adequate
>>>>> kernel is installed. Probably the best option.
>>>>>
>>>> Hi Ian,
>>>>
>>>> I can confirm:
>>>>
>>>> $ echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
>>>> /proc/sys/kernel/perf_event_paranoid
>>>> 0
>>>>
>>>> $ ~/bin/perf stat -M tma_l3_bound --metric-no-group -a sleep 1
>>>>
>>>> Performance counter stats for 'system wide':
>>>>
>>>>         2.058.892      MEM_LOAD_UOPS_RETIRED.LLC_HIT    #      1,5 %
>>>> tma_l3_bound             (99,30%)
>>>>       173.254.697      CYCLE_ACTIVITY.STALLS_L2_PENDING
>>>>                         (99,10%)
>>>>     2.396.130.501      CPU_CLK_UNHALTED.THREAD
>>>>                         (99,60%)
>>>>         1.110.486      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
>>>>                            (99,53%)
>>>>
>>>>       1,001989022 seconds time elapsed
>>>>
>>>> $ ~/bin/perf stat -M tma_dram_bound --metric-no-group -a sleep 1
>>>>
>>>> Performance counter stats for 'system wide':
>>>>
>>>>         1.729.208      MEM_LOAD_UOPS_RETIRED.LLC_HIT    #      1,2 %
>>>> tma_dram_bound           (99,50%)
>>>>        50.346.734      CYCLE_ACTIVITY.STALLS_L2_PENDING
>>>>                         (99,50%)
>>>>     2.354.963.862      CPU_CLK_UNHALTED.THREAD
>>>>                         (99,80%)
>>>>           306.500      MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS
>>>>                            (99,61%)
>>>>
>>>>       1,001981392 seconds time elapsed
>>>>
>>>> Thanks!
>>> Thanks, apparently it is an issue with SandyBridge/IvyBridge that some
>>> counters on one hyperthread will limit what can be on the other. I
>>> believe that's the comment related to EXCL access here:
>>> https://github.com/torvalds/linux/blob/master/arch/x86/events/intel/core.c#L124
>>> So you may have more success with the metric if you disable
>>> hyperthreading, but I imagine that's not a popular option.
>>
>> Thanks for debugging the issue. Yes, it's caused by the HT workaround
>> for SNB/IVB/HSW.
>>
>> The weak group check in the kernel is in validate_group(). It only does
>> a sanity check. It doesn't check all the workarounds and the current
>> status of counters (e.g., whether the fixed counter is occupied by NMI
>> watchdog.) It's possible that a false positive is returned to the perf
>> tool. I once tried to fix the NMI watchdog check in the kernel, but the
>> proposal was rejected. So the metric constraint is introduced.
>>
>> For this issue, I think the above option2 should be a better and
>> practical choice. The issue is only observed on old machines, which
>> usually has a stable kernel running on it. I don't think the user wants
>> to update their kernel just to workaround an issue for several metrics.
>> But it should be much easier for them to update the perf tool.
>>
>> We know that the below events are the problematic events.
>> /* MEM_UOPS_RETIRED.* */
>> /* MEM_LOAD_UOPS_RETIRED.* */
>> /* MEM_LOAD_UOPS_LLC_HIT_RETIRED.* */
>> /* MEM_LOAD_UOPS_LLC_MISS_RETIRED.* */
>> Can we update the convertor script and apply the "--metric-no-group"
>> flag or add a new constraint if the above events are detected in
>> SNB/IVB/HSW?
>>
>> Thanks,
>> Kan
> 
> Thanks Kan,
> 
> We absolutely can do that! In this case should it be --metric-no-group
> only when SMT is enabled? I can do some patches but would like to know
> about whether we need SMT and not SMT versions of --metric-no-group.

The kernel workaround is disabled when SMT is off. So I think we only
need SMT version of --metric-no-group.
https://lore.kernel.org/all/1416251225-17721-13-git-send-email-eranian@google.com/T/#u

> Also, should we just have a list of metrics that need the flag or try
> to automate detection? 

I don't think Intel will update the metrics or events for the old
SNB/IVB/HSW platforms. Hard code a list of metrics may be simpler than
automated detection.

> Some warts in detection are the names of the
> events that vary between Ivybridge and Sandybridge, and how to
> determine which events conflict. For example, the perfmon event data:
> 
> MEM_LOAD_UOPS_RETIRED.LLC_HIT
> https://github.com/intel/perfmon/blob/main/IVB/events/ivybridge_core.json#L5368
> MEM_LOAD_UOPS_RETIRED.LLC_MISS
> https://github.com/intel/perfmon/blob/main/IVB/events/ivybridge_core.json#L5431
> CYCLE_ACTIVITY.STALLS_L2_PENDING
> https://github.com/intel/perfmon/blob/main/IVB/events/ivybridge_core.json#L3541
>

The problematic events should have the same name among platforms. If the
event name doesn't work, the event encoding is exactly the same among
those platforms.


> The events list all counters, there are no errata fields.. Should the
> event data be updated and then in the converter script handle that? If
> I get shown an example I can modify the script accordingly.

If it can helps the converter script, I think we can update the errata
field.

Here are the errata information.
 * SNB: BJ122
 * IVB: BV98
 * HSW: HSD29

Here is the details regarding the issue. (Please search BV98)
https://www.intel.com/content/www/us/en/content-details/619604/desktop-3rd-generation-intel-core-processor-family-specification-update.html
> 
> It is also hard for me to test anything other than SMT on Ivybridge.
> 

I think it's OK to only test on Ivybridge.
The original kernel patch indicates the issue is the same among SNB, IVB
and HSW.
https://lore.kernel.org/all/1416251225-17721-7-git-send-email-eranian@google.com/T/#u

Thanks,
Kan
