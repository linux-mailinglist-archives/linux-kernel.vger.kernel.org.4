Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E635B5EA8E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiIZOqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiIZOqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E5615704;
        Mon, 26 Sep 2022 06:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3364A60DBB;
        Mon, 26 Sep 2022 13:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F77C433C1;
        Mon, 26 Sep 2022 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664197791;
        bh=fUkQsM05ndYllEVHPF4gn/Cm7t6E7FR+wFCGj541yaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RBc1XjpWEq865feN6CsA5BAvN5mE064a7G63tCvqSJIL+1qnvWQSSTcRWrkqvhgFO
         Sahb3ZdyaAXTgCXaq5YUvQ7QTlwieeK+15W896zM27QMRy7jxQdC+Bwc5KX0Hbejtv
         CwKRzykmhIza2P+7sHNvpjRpICa7nVpTmjZda2SyDa1cnstyTg+m14Zy3UCwRSr5bA
         qTYTceL6RBhnxYyRXpbl7C0kC0GkqkSJb939WRQ7jC82V/3dQw/G8rwfzswtYEi/kB
         SUiIgfdf1/AmrXeJ3NQDXRayriWHaZTwG77zu8OiwluNRa+IsZy9IpSbMlKHnH56oq
         GPNbCqFIxnYhg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 65A1F403B0; Mon, 26 Sep 2022 14:09:49 +0100 (IST)
Date:   Mon, 26 Sep 2022 14:09:49 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/4] perf tools: Assorted random fixes and updates
Message-ID: <YzGknQlI15jk4Mzq@kernel.org>
References: <20220923173142.805896-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923173142.805896-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 23, 2022 at 10:31:38AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> This is collection of random fixes and updates.
> And I'm resending them as they seem to be lost in the list.

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf record: Fix a segfault in record__read_lost_samples()
>   perf inject: Clarify build-id options a little bit
>   perf tools: Add 'addr' sort key
>   perf annotate: Toggle full address <-> offset display
> 
>  tools/perf/Documentation/perf-inject.txt |  6 ++--
>  tools/perf/Documentation/perf-report.txt |  3 +-
>  tools/perf/builtin-record.c              |  6 ++++
>  tools/perf/ui/browsers/annotate.c        |  6 +++-
>  tools/perf/util/annotate.c               | 19 +++++++++++-
>  tools/perf/util/annotate.h               |  4 ++-
>  tools/perf/util/hist.c                   |  1 +
>  tools/perf/util/hist.h                   |  1 +
>  tools/perf/util/sort.c                   | 38 ++++++++++++++++++++++++
>  tools/perf/util/sort.h                   |  1 +
>  10 files changed, 79 insertions(+), 6 deletions(-)
> 
> -- 
> 2.37.3.998.g577e59143f-goog

-- 

- Arnaldo
