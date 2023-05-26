Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F9C712C63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbjEZSZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbjEZSYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:24:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1985BC;
        Fri, 26 May 2023 11:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EDC96523C;
        Fri, 26 May 2023 18:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACCFC433D2;
        Fri, 26 May 2023 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685125492;
        bh=iS5Q0u6jWqOCDWLbpL0S6ehmQI7x1tzANmo51W13qVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PkgSlkZ086gPKa45iq9Ijr9TAOnzML9ur1Pg3bsmM3H27uj5kklmLUYpv7NvYP2zx
         pS476xA23/xrq3923USG9cWfgGDZ15qpgA2UduK3EaRASo5aW4/WP6qVp+sjNTAwK+
         QDj4N1dBFZPXsQAPpAz5x73iIo47zEeJToh2WYJRmB+5W8o/f3h1danp0ECYk7sbvF
         z/dC7lnJuVhZmgCOYKKG/0LLi1zXS8xTcwk8PptOClLgi8EmSU+4mYWgavPXqnTITd
         NdyvF29t+SkOdT3jeCW5iiazuhFHJnjMikHj/opIu7vTFpeIQHdPG/Vr7zGmziy9j+
         5fxMKBsgWVTCQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A7B47403B5; Fri, 26 May 2023 15:24:49 -0300 (-03)
Date:   Fri, 26 May 2023 15:24:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf arm: Fix include path
Message-ID: <ZHD5cRAR+Sk0bIeA@kernel.org>
References: <20230515165039.544045-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515165039.544045-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 15, 2023 at 09:50:39AM -0700, Ian Rogers escreveu:
> Change "../cs-etm.h" to just "../../../util/cs-etm.h" as ../cs-etm.h
> doesn't exist.

Thanks, applied.

- Arnaldo

 
> Suggested-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index 860a8b42b4b5..a9623b128ece 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -12,7 +12,7 @@
>  #include "arm-spe.h"
>  #include "hisi-ptt.h"
>  #include "../../../util/pmu.h"
> -#include "../cs-etm.h"
> +#include "../../../util/cs-etm.h"
>  
>  struct perf_event_attr
>  *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 

-- 

- Arnaldo
