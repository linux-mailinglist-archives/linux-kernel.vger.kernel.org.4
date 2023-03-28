Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02096CC09D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjC1NY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjC1NYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:24:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813ECBDE3;
        Tue, 28 Mar 2023 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680009854; x=1711545854;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=c5NZ8J85PtsVwH4TYBDukAvhMm76lbQ4ukarN3NWcis=;
  b=OIjpSHE/nVqROh8+uMKldHmwQ3DgNF0tW9ykEfrGJcPnG6kL8F7skf7M
   7MnTigg7/+9c7yxFVyZaCWF4P7DrG/Z41s0/5X6P6GnFJXzECUPQxFFLL
   ehRxyH9N0GTpzAIsxwg5EklFubM85WI2KoUXQ5RHKTlCUl2ourVERL0xs
   uwItS919juFNXTc5mf8fBBriLjdhKP2dMN65JyrMBZX5nVF5kkGqtVGkC
   eJdLWCKvs20CmJ0iKE5pNZBIZTPgQmJrU+q6NT7A/Ud0PRmcRpNt8p6ze
   JJHjEgaLxiZtCAUWIBBDoqSwrwWY9keQDZ7F6fDJ1vqrvjGKYFL9tf19m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="329020086"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="329020086"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 06:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929875313"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="929875313"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.32.11])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 06:24:06 -0700
Message-ID: <fe36e38f-d42f-efe5-bb3c-cf802f8001a9@intel.com>
Date:   Tue, 28 Mar 2023 16:24:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v1 0/6] Simplify linking against tools/perf code
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Raul Silvera <rsilvera@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230328014058.870413-1-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230328014058.870413-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/23 04:40, Ian Rogers wrote:
> When fuzzing something like parse-events, having the main function in
> perf.c alongside global variables like input_name means that
> input_name must be redeclared with the fuzzer function's
> main. However, as the fuzzer is using the tools/perf code as a library
> this causes backward linking reference that the linker may warn
> about. Reorganize perf.c and perf.h to avoid potential backward
> references, or so that the declaration/definition locations are more
> consistent.
> 

Seems like it could be a pain to maintain.

Did you consider just adding:

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 82bbe0ca858b..a75dd47d68ee 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -456,6 +456,7 @@ static int libperf_print(enum libperf_print_level level,
 	return veprintf(level, verbose, fmt, ap);
 }
 
+#ifndef CUSTOM_MAIN
 int main(int argc, const char **argv)
 {
 	int err;
@@ -576,3 +577,4 @@ int main(int argc, const char **argv)
 out:
 	return 1;
 }
+#endif

