Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420BC607590
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJUK7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJUK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:59:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8068915A27;
        Fri, 21 Oct 2022 03:59:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF9C71063;
        Fri, 21 Oct 2022 03:59:37 -0700 (PDT)
Received: from [10.57.2.49] (unknown [10.57.2.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AFEE3F792;
        Fri, 21 Oct 2022 03:59:29 -0700 (PDT)
Message-ID: <39c5a7cb-076a-a6ba-df27-7dee7d98a2a5@arm.com>
Date:   Fri, 21 Oct 2022 11:59:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] perf vendor events: Add Arm Neoverse V2 PMU events
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, nick.forrington@arm.com,
        al.grant@arm.com, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
References: <20221020134512.1345013-1-james.clark@arm.com>
 <dcf5d62d-8163-dfee-a6b7-e75207650551@huawei.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <dcf5d62d-8163-dfee-a6b7-e75207650551@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/10/2022 11:47, John Garry wrote:
> On 20/10/2022 14:45, James Clark wrote:
>> Rename the neoverse-n2 folder to make it clear that it includes V2, and
>> add V2 to mapfile.csv. V2 has the same events as N2, visible by running
>> the following command in the ARM-software/data github repo [1]:
>>
>>    diff pmu/neoverse-v2.json pmu/neoverse-n2.json | grep code
>>
>> Testing:
>>
>>    $ perf test pmu
>>
>>    10: PMU events                                           :
>>    10.1: PMU event table sanity                             : Ok
>>    10.2: PMU event map aliases                              : Ok
>>    10.3: Parsing of PMU event table metrics                 : Ok
>>    10.4: Parsing of PMU event table metrics with fake PMUs  : Ok
>>
>> [1]:https://github.com/ARM-software/data
>>
>> Signed-off-by: James Clark<james.clark@arm.com>
>> ---
> 
> This looks ok. Out of curiosity, do you know how the naming works for
> these neoverse cores? Were "n" a predecessor to "v"?

Thanks for the review. No, they're more like different product lines
than predecessors. From the image on this article [1], N are focused on
performance per watt and V are high performance.

[1]:
https://www.arm.com/company/news/2022/09/redefining-the-global-computing-infrastructure-with-next-generation-arm-neoverse-platforms

> 
> thanks,
> John
