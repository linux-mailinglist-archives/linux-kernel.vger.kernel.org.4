Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593025B5EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiILRNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiILRNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:13:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56D5313CD8;
        Mon, 12 Sep 2022 10:13:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56BCC106F;
        Mon, 12 Sep 2022 10:13:49 -0700 (PDT)
Received: from [10.57.17.34] (unknown [10.57.17.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2E443F73D;
        Mon, 12 Sep 2022 10:13:40 -0700 (PDT)
Message-ID: <c8af4295-0e28-d205-3220-f3e00ab509de@arm.com>
Date:   Mon, 12 Sep 2022 18:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] perf vendor events: Update events for Neoverse E1
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220905153020.1792-1-nick.forrington@arm.com>
 <YxdGFAYHeO/j5uJF@kernel.org>
 <496f98ce-a0c4-9587-853c-9ba05323523a@huawei.com>
 <Yxo2ZSKtne7E/2Sn@kernel.org>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <Yxo2ZSKtne7E/2Sn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/09/2022 19:37, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 06, 2022 at 02:22:54PM +0100, John Garry escreveu:
>> On 06/09/2022 14:07, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Sep 05, 2022 at 04:30:19PM +0100, Nick Forrington escreveu:
>>>> Based on updated data from:
>>>> https://github.com/ARM-software/data/blob/master/pmu/neoverse-e1.json
>>>>
>>>> which is based on PMU event descriptions from the Arm Neoverse E1
>>>> Technical Reference Manual.
>>>>
>>>> This includes additional implementation defined fields not previously
>>>> included, and removes unimplemented events related to Arm's Statistical
>>>> Profiling Extension (SPE).
>>> Applied locally, would be good to have an Acked-by or Reviewed-by, John?
>> Regardless of comment, below:
>> Reviewed-by: John Garry <john.garry@huawei.com>
> So, I removed this one, applied v2, now trying to apply the other patch
> from Nick, the one moving some events to a different file, but not being
> able to:
>
> ⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers 39abfee9-4a9b-ec44-9b02-a6cd34cfe64d@huawei.com
> Grabbing thread from lore.kernel.org/all/39abfee9-4a9b-ec44-9b02-a6cd34cfe64d%40huawei.com/t.mbox.gz
> Checking for newer revisions on https://lore.kernel.org/all/
> Analyzing 3 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>    [PATCH] perf vendor events arm64: Move REMOTE_ACCESS to "memory" category
>      + Reviewed-by: John Garry <john.garry@huawei.com>
> ---
> Total patches: 1
> ---
>   Link: https://lore.kernel.org/r/20220908112519.64614-1-nick.forrington@arm.com
>   Base: not specified
>         git am ./20220908_nick_forrington_perf_vendor_events_arm64_move_remote_access_to_memory_category.mbx
> ⬢[acme@toolbox perf]$        git am ./20220908_nick_forrington_perf_vendor_events_arm64_move_remote_access_to_memory_category.mbx
> Applying: perf vendor events arm64: Move REMOTE_ACCESS to "memory" category
> error: patch failed: tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json:3
> error: tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json: patch does not apply
> error: tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json: does not exist in index
> error: patch failed: tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json:2
> error: tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json: patch does not apply
> error: tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json: does not exist in index
> error: patch failed: tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json:2
> error: tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json: patch does not apply
> error: tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json: does not exist in index
> Patch failed at 0001 perf vendor events arm64: Move REMOTE_ACCESS to "memory" category
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> ⬢[acme@toolbox perf]$

I think this was already applied via 
1081fb0f6d6e68186e1088db33396b11770a0710

All 3 patches appear to be present.

Thanks, Nick

