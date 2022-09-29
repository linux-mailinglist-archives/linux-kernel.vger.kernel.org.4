Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC045EFCB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiI2SK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiI2SKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:10:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EA01E722;
        Thu, 29 Sep 2022 11:10:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93BDCB8261E;
        Thu, 29 Sep 2022 18:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E27BC433D7;
        Thu, 29 Sep 2022 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664475046;
        bh=INnFfH3tdYB+C/hvfEcDVOEwuh24J/V1mfziQPv7gmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBsVyqZaDB3Bfnj6UVmY3az7nwUl7HGiYY6p2cn+2nP1AqjmoVyVaFaBmL8iWYb2r
         xu4hSgAb8U4o2YlmjrMNldu6rOlewySzcck0Y2NNuBMs/JugBmVeGDoRu7hDjzhp1O
         OqFYhXgeMXc0FoUg5+HbT9cqndWlDzWhGcLoIJp6znGvYZ7xcstRvW/qnIDa73n0Pw
         8ZnF+QofqcUSJK0jiu7WwF8qqWet+eSII6ajCTgnEGv0TfIeDezmXO10u7USWg1lmz
         clvfsRmja6YqhMkaGzx3a5gZBDrR+MVNGNVBLHrlq3+fSazW5wnVEQH5oaldfieTSO
         XZiyYOoxLO8xA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E04EA405F0; Thu, 29 Sep 2022 15:10:43 -0300 (-03)
Date:   Thu, 29 Sep 2022 15:10:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf tools: Remove unused variable in
 tests/test-basic.c
Message-ID: <YzXfozrpDu0cm2am@kernel.org>
References: <20220929140514.226807-1-jolsa@kernel.org>
 <20220929140514.226807-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929140514.226807-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 29, 2022 at 04:05:14PM +0200, Jiri Olsa escreveu:
> The clang 15 build reveal several unused-but-set variables,
> removing the 'foo' variable in tests/mmap-basic.o object.



Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/mmap-basic.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 21b5e68179d7..8322fc2295fa 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -112,8 +112,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
>  
>  	for (i = 0; i < nsyscalls; ++i)
>  		for (j = 0; j < expected_nr_events[i]; ++j) {
> -			int foo = syscalls[i]();
> -			++foo;
> +			syscalls[i]();
>  		}
>  
>  	md = &evlist->mmap[0];
> -- 
> 2.37.3

-- 

- Arnaldo
