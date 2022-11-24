Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF176379AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiKXNGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiKXNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:06:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD55FBA91;
        Thu, 24 Nov 2022 05:06:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EE51B827EE;
        Thu, 24 Nov 2022 13:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8BEC43154;
        Thu, 24 Nov 2022 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669295190;
        bh=5atKmu+LimHjj9MQX9Ir5iz49+5tOoSHFNYiiXlQhB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yi6PQLXRnLDZDM3rdl1alX91n056o3/UviZKosI/TA1h55aPt5R9DtjjJhl3H/FY1
         Y7key/Zd415uyA8OgkYvD+BjCYJXDWmbY03LNlXW6GNkFuDO19cebjZDtJXfsSoC/V
         nbx6I1XZdE5QyA5K0mUC2ZJ979BRITJwSie52rbaRz+ens07si+fkpcJ2ZywRSEoZu
         k1zSv0fZU+RZspX0zEE/8E4tFWwNvwQmTdQzZvEr+VxxQAra4jQ7XFVC2O5hChf/J+
         ouBxzk8u89ol3hY7GSz3iNJ14jjDV2Ivbx0DMdKUsGd2SwaT50I0Id+/UO8MT5nDkF
         UEPiYevX+zPcA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C6924034E; Thu, 24 Nov 2022 10:06:27 -0300 (-03)
Date:   Thu, 24 Nov 2022 10:06:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 0/3] perf list libpfm fixes
Message-ID: <Y39sU1uiB5CG1s4s@kernel.org>
References: <20221118024607.409083-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118024607.409083-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 17, 2022 at 06:46:04PM -0800, Ian Rogers escreveu:
> Fix a lack of libpfm support with the refactored perf list code. Add
> some improvements to wordwrap and the escape printing for json to aid
> this.
> 
> v2. Rebased on acme/linux.git tmp.perf/core

Applied, and added missing __maybe_unused to the HAVE_LIBPFM else block
for the new function args.

- Arnaldo
 
> Ian Rogers (3):
>   perf list: Support newlines in wordwrap
>   perf list: Json escape encoding improvements
>   perf list: List callback support for libpfm
> 
>  tools/perf/builtin-list.c | 120 +++++++++++++++++------------
>  tools/perf/util/pfm.c     | 154 +++++++++++++++++---------------------
>  tools/perf/util/pfm.h     |   6 +-
>  3 files changed, 144 insertions(+), 136 deletions(-)
> 
> -- 
> 2.38.1.584.g0f3c55d4c2-goog

-- 

- Arnaldo
