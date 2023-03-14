Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E16B951B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjCNNAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjCNNAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:00:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8519A28D36;
        Tue, 14 Mar 2023 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678798556; x=1710334556;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=L19UTwwK3rxG8ZdEmbsy6MiVw+WcWSpPyETe4BCit3Q=;
  b=bR8mb/9Co0I3du3YSPi8L2i3qk1iFSfoB9lFKPGf41tR9hFz2MaSgsBu
   avZ26p6fLdBK2GMLS71DXVPIKAk40IcsvSvgMmWnw0eGCeN6dqmRw3gF8
   QZg4y1xasjRWgCcECuP7VdYGlcPC756DcJYFDtfltblaIbA5oEdF4Hbzw
   HCRWFUGp01e7+xNlFvUV838Zcms0O2+Rn4Fa9R/HOlHBQqTNn0gDU/XMY
   mccpr8ofjqf4nAeGi4jkQEgwb3EPCQo59SH7SphCiLo/ZrX+uoG1Iy8Hq
   N+3kzY26wMuYooVnDrcMQw2preq/b6qAiDXm/C6rMs61rZpcbpHd+Ecbx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="338955356"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="338955356"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 05:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="656324727"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="656324727"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2023 05:54:54 -0700
Received: from [10.209.76.180] (kliang2-mobl1.ccr.corp.intel.com [10.209.76.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4D6B158047E;
        Tue, 14 Mar 2023 05:54:53 -0700 (PDT)
Message-ID: <9379da89-0555-81ab-cdca-983107df1fe4@linux.intel.com>
Date:   Tue, 14 Mar 2023 08:54:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 0/3] Event updates for GNR, MTL and SKL
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
References: <20230314053312.3237390-1-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230314053312.3237390-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-14 1:33 a.m., Ian Rogers wrote:
> Update events for graniterapids and meteorlake, v1.00 to v1.01, as
> well as skylake v54 to v55. All patches generated from:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> 
> Ian Rogers (3):
>   perf vendor events intel: Update graniterapids events
>   perf vendor events intel: Update meteorlake events
>   perf vendor events intel: Update skylake events
> 

Thanks Ian. The patch series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  .../arch/x86/graniterapids/frontend.json      |  2 +-
>  .../arch/x86/graniterapids/pipeline.json      |  4 +--
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  6 ++--
>  .../pmu-events/arch/x86/meteorlake/cache.json |  8 +++++
>  .../arch/x86/meteorlake/frontend.json         |  9 +++++
>  .../arch/x86/meteorlake/memory.json           | 13 +++++--
>  .../pmu-events/arch/x86/meteorlake/other.json |  4 +--
>  .../arch/x86/meteorlake/pipeline.json         | 36 +++++++++++++++++--
>  .../arch/x86/meteorlake/virtual-memory.json   |  4 +++
>  .../pmu-events/arch/x86/skylake/cache.json    |  8 +++++
>  .../arch/x86/skylake/floating-point.json      | 15 ++++++++
>  .../pmu-events/arch/x86/skylake/pipeline.json | 10 ++++++
>  12 files changed, 107 insertions(+), 12 deletions(-)
> 
