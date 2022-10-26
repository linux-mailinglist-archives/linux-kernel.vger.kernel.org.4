Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62D460E374
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiJZOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiJZOg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:36:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45307B14FA;
        Wed, 26 Oct 2022 07:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9924B822AA;
        Wed, 26 Oct 2022 14:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B2EC433D6;
        Wed, 26 Oct 2022 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666794984;
        bh=Ky/FE3/Moh+iG/G3rskZGi3VmMi9zVI+wEL/m6hB8o0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A5hTwyBrs634N2r5h45aU+IHz4Gz984WNVTDFx6etf+eaFueLEkgCf5PS+lPu5puI
         Y8cX4GwNaYj5RfJUgw6tsfpY8PDdkk08eEsCsrc2B7EJOYw0xmc3kSbZ1KFAE3UYPi
         5ew+bb1p0Z/0+3gJw9KTkfxZvgXi4EDv9uQ6I6hzgOYIqhZu4EcwBC6te2QppVaOFR
         XdLbG+0ldcFhohFCskJz5P+1T/SYh9fzQHI49FFT9hqDImGCdODEiPT6Lg2ZUyBBJ9
         W9jHf2Ug6Cv1nbW2LymFmMMuPaxHK/Kb2NmMJsiAOjiAmMGpe/lQg41/+5ubisCXWR
         ZxyoO+fykffAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C28C404BE; Wed, 26 Oct 2022 11:36:22 -0300 (-03)
Date:   Wed, 26 Oct 2022 11:36:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 0/2] perf: Fix "kernel lock contention analysis" test
 by not printing warnings in quiet mode
Message-ID: <Y1lF5lZ26nTBpyaR@kernel.org>
References: <20221018094137.783081-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018094137.783081-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 18, 2022 at 10:41:34AM +0100, James Clark escreveu:
> This is V2, but the previous patch was titled 'perf: Fix "Track with
> sched_switch" test by not printing warnings in quiet mode'
> 
> Changes since V1:
> 
>   * Add a commit to make the behavior consistent between tools and
>     update the docs
>   * Fix the incorrect test name in the commit message

Thanks, applied.

- Arnaldo

 
> James Clark (2):
>   perf: Fix "kernel lock contention analysis" test by not printing
>     warnings in quiet mode
>   perf: Make quiet mode consistent between tools
> 
>  tools/perf/Documentation/perf-annotate.txt | 2 +-
>  tools/perf/Documentation/perf-diff.txt     | 2 +-
>  tools/perf/Documentation/perf-lock.txt     | 2 +-
>  tools/perf/Documentation/perf-probe.txt    | 2 +-
>  tools/perf/Documentation/perf-record.txt   | 2 +-
>  tools/perf/Documentation/perf-report.txt   | 2 +-
>  tools/perf/Documentation/perf-stat.txt     | 4 ++--
>  tools/perf/bench/numa.c                    | 9 +++++----
>  tools/perf/builtin-annotate.c              | 2 +-
>  tools/perf/builtin-diff.c                  | 2 +-
>  tools/perf/builtin-lock.c                  | 2 +-
>  tools/perf/builtin-probe.c                 | 7 +++----
>  tools/perf/builtin-record.c                | 2 +-
>  tools/perf/builtin-report.c                | 2 +-
>  tools/perf/builtin-stat.c                  | 8 ++++----
>  tools/perf/ui/util.c                       | 5 +++++
>  tools/perf/util/stat.h                     | 1 -
>  17 files changed, 30 insertions(+), 26 deletions(-)
> 
> -- 
> 2.28.0

-- 

- Arnaldo
