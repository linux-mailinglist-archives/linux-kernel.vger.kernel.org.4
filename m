Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60307624066
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiKJKwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKJKwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:52:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1FF85EF94;
        Thu, 10 Nov 2022 02:52:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A49C71FB;
        Thu, 10 Nov 2022 02:52:54 -0800 (PST)
Received: from [10.57.3.204] (unknown [10.57.3.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56BA33F534;
        Thu, 10 Nov 2022 02:52:46 -0800 (PST)
Message-ID: <bf335af0-6340-333d-4b04-5bdc39a75f35@arm.com>
Date:   Thu, 10 Nov 2022 10:52:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] perf vendor events: Add Arm Neoverse V2 PMU events
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, john.garry@huawei.com,
        acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, al.grant@arm.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20221020134512.1345013-1-james.clark@arm.com>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <20221020134512.1345013-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 14:45, James Clark wrote:
> Rename the neoverse-n2 folder to make it clear that it includes V2, and
> add V2 to mapfile.csv. V2 has the same events as N2, visible by running
> the following command in the ARM-software/data github repo [1]:
>
>    diff pmu/neoverse-v2.json pmu/neoverse-n2.json | grep code
>
> Testing:
>
>    $ perf test pmu
>
>    10: PMU events                                           :
>    10.1: PMU event table sanity                             : Ok
>    10.2: PMU event map aliases                              : Ok
>    10.3: Parsing of PMU event table metrics                 : Ok
>    10.4: Parsing of PMU event table metrics with fake PMUs  : Ok
>
> [1]: https://github.com/ARM-software/data
>
> Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Nick Forrington <nick.forrington@arm.com>
