Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401316C71AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCWUb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:31:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03C6769F;
        Thu, 23 Mar 2023 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679603485; x=1711139485;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=c1VCw3ZQC639BeTLQlwxd0NBnxirj0FA8+Mqu4NR08I=;
  b=UgfGH1SHrn6Eqg9CI8M6DaMKOF2VtcI3fkduV9c89Kmhxe0UbWLEEHuM
   IlwC0AdqQ7AMWV/tHlkiYHl7+MIhpLHvBzAzx7MnONGJxbegGQRDKxWVR
   em8AZNFLhmkFkdBdwIan/CBvRH63jtTWfxkbGGAmcouBFK4iBSEcHXhwE
   aa+7/z6frn7PkDfBiVjMVktKDpCfNLfPUcyPbN30A7jlK9PT9Pwvfau5v
   GvQGxmlzKRlTWBfvFSECafFC9NLGpuQKgfMXfXEwoZmhTLTQqkiCFSdcP
   cul4cUPStfV1J97gf1aDIseCaI2TLVQpqnfMRh6IjeKqQT88Mq0CdwvDB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341174354"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="341174354"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 13:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="1011980787"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="1011980787"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2023 13:31:24 -0700
Received: from [10.212.201.204] (kliang2-mobl1.ccr.corp.intel.com [10.212.201.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 92029580C7C;
        Thu, 23 Mar 2023 13:31:22 -0700 (PDT)
Message-ID: <44476adc-3797-504b-2b82-8ec670c691b6@linux.intel.com>
Date:   Thu, 23 Mar 2023 16:31:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 8/9] perf metrics: Add has_optane literal
Content-Language: en-US
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
        Edward Baker <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
References: <20230323192028.135759-1-irogers@google.com>
 <20230323192028.135759-9-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230323192028.135759-9-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-23 3:20 p.m., Ian Rogers wrote:
> Add literal so that if optane memory isn't installed we can record
> fewer events.  

I think we call it pmem (Persistent Memory) everywhere in the Linux
code. Maybe we should use #has_pmem instead?

Thanks,
Kan
> The file detection mechanism was suggested by Dan
> Williams <dan.j.williams@intel.com> in:
> https://lore.kernel.org/linux-perf-users/641bbe1eced26_1b98bb29440@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index d46a1878bc9e..a43cdda0b044 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -14,6 +14,7 @@
>  #include "util/hashmap.h"
>  #include "smt.h"
>  #include "tsc.h"
> +#include <api/fs/fs.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
> @@ -400,6 +401,20 @@ double arch_get_tsc_freq(void)
>  }
>  #endif
>  
> +static double has_optane(void)
> +{
> +	static bool has_optane, cached;
> +	const char *sysfs = sysfs__mountpoint();
> +	char path[PATH_MAX];
> +
> +	if (!cached) {
> +		snprintf(path, sizeof(path), "%s/firmware/acpi/tables/NFIT", sysfs);
> +		has_optane = access(path, F_OK) == 0;
> +		cached = true;
> +	}
> +	return has_optane ? 1.0 : 0.0;
> +}
> +
>  double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx)
>  {
>  	const struct cpu_topology *topology;
> @@ -449,6 +464,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
>  		result = perf_pmu__cpu_slots_per_cycle();
>  		goto out;
>  	}
> +	if (!strcmp("#has_optane", literal)) {
> +		result = has_optane();
> +		goto out;
> +	}
>  
>  	pr_err("Unrecognized literal '%s'", literal);
>  out:
