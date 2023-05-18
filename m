Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5090770871A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjERRpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjERRpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:45:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B29E7C;
        Thu, 18 May 2023 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684431910; x=1715967910;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=su2wUu0tkaocZZy2M3phiogxIKayXtt5EEs7IofWPF4=;
  b=byxFPgW4T1UOX7AtUZeMVQCBbNrPOGb+lfGBt4e6tKdS+En4NksQHduy
   m1AKbaion1ROsymjONuwJgWn7u4oxgUm4YCD9953CQwZizN4Uf8tuM8Pk
   QnxYUz8Vli4B/JgGqEpExCU0vuigAMsF26W2eJCaxWXEoBNIeKqYbJtbc
   G06gxyyMCYRMTdwQQsbnyUlStNA5Mvtr1Wqy5GnIIlNXMDmQluSHoOVvJ
   phUUoZU+wm9LYQbghQMF2UZ7hr2b7m6qV+FcG2jcWizxxalHgntXMAeu9
   uYN80ymPBsfD1sxVnAR5YycNlOU5zAOoUSpLlsuWRCnb+8pbYBL4ghGSk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="438484665"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="438484665"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 10:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="792061366"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="792061366"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 18 May 2023 10:45:08 -0700
Received: from [10.209.99.208] (kliang2-mobl1.ccr.corp.intel.com [10.209.99.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 552255808EF;
        Thu, 18 May 2023 10:45:07 -0700 (PDT)
Message-ID: <9178149c-45e8-3de4-58db-b8b8d27b3a08@linux.intel.com>
Date:   Thu, 18 May 2023 13:45:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1 1/2] perf test attr: Update no event/metric
 expectations
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230517225707.2682235-1-irogers@google.com>
 <64f329a9-09a3-aa84-a354-23a919062d09@arm.com> <ZGYYJ/biKyeFNJjL@kernel.org>
 <f753beda-2d5e-c391-520a-450b186fd4d4@linux.intel.com>
In-Reply-To: <f753beda-2d5e-c391-520a-450b186fd4d4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 2023-05-18 8:55 a.m., Liang, Kan wrote:
> On 2023-05-18 8:20 a.m., Arnaldo Carvalho de Melo wrote:
>> Em Thu, May 18, 2023 at 08:50:14AM +0100, James Clark escreveu:
>>>
>>> On 17/05/2023 23:57, Ian Rogers wrote:
>>>> Previously hard coded events/metrics were used, update for the use of
>>>> the TopdownL1 json metric group.
>>>>
>>>> Fixes: 94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default if present")
>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>> ---
>>>>  tools/perf/tests/attr/base-stat            |   2 +-
>>>>  tools/perf/tests/attr/test-stat-default    |  80 ++++++++-----
>>>>  tools/perf/tests/attr/test-stat-detailed-1 |  95 +++++++++------
>>>>  tools/perf/tests/attr/test-stat-detailed-2 | 119 +++++++++++--------
>>>>  tools/perf/tests/attr/test-stat-detailed-3 | 127 ++++++++++++---------
>>>>  5 files changed, 249 insertions(+), 174 deletions(-)
>>>>
>>> Reviewed-by: James Clark <james.clark@arm.com>
>> Thanks, applied both patches to perf-tools.
>>
> Could you please hold patch 1 for a while?

Sorry for the noise.

Ian has addressed my concerns. The patch looks good to me now.
It also fixes a "Failed" on my Cascade Lake machine.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

But for long term, we probably need a better solution to avoid keeping
adding such non-architectural events in the test case.

Thanks,
Kan
