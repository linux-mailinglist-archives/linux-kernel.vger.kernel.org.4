Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ED17232F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjFEWLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFEWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:11:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D696EC;
        Mon,  5 Jun 2023 15:11:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EA95C14;
        Mon,  5 Jun 2023 15:12:15 -0700 (PDT)
Received: from [10.57.25.141] (unknown [10.57.25.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 139703F663;
        Mon,  5 Jun 2023 15:11:26 -0700 (PDT)
Message-ID: <362032af-382e-d367-a655-1c25407309a0@arm.com>
Date:   Mon, 5 Jun 2023 23:11:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH 1/4] perf cs-etm: Only track threads instead of PID and
 TIDs
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        denik@chromium.org
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230524131958.2139331-1-james.clark@arm.com>
 <20230524131958.2139331-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230524131958.2139331-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 14:19, James Clark wrote:
> PIDs and TIDs are already contained within the thread struct, so to
> avoid inconsistencies drop the extra members on the etm queue and only
> use the thread struct.
> 
> At the same time stop using the 'unknown' thread. In a later commit
> we will be making samples from multiple machines so it will be better
> to use the idle thread of each machine rather than overlapping unknown
> threads. Using the idle thread is also better because kernel addresses
> with a previously unknown thread will now be assigned to a real kernel
> thread.
> 
> Signed-off-by: James Clark <james.clark@arm.com>


Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


