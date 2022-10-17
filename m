Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8008600F29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiJQM0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJQM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:26:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31AD3741A;
        Mon, 17 Oct 2022 05:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D68DB811D8;
        Mon, 17 Oct 2022 12:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD64C433D6;
        Mon, 17 Oct 2022 12:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666009179;
        bh=7Y2psqRV47IAZT44nV8wgEA04EZpUiApRke3T532fA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pr/f3gZi2KJaoW12z9VOdzCG9EX+5EmJ+kPY469vVAlZxy+yBpEfB0mAVvQQbbde5
         N3/oaixeEIzMV41RAkkeEAOY9UeyUdQByHBEaNKA0KbFtdQi610dVGIoyy8gNmHhLJ
         rvgNeLSSQN8oysCCXNpWenGJP1miqDZ3Q599EnHIwEuhqSrxsswiytD92//n3tE4dS
         QeFUtfTlg1k6n3rVCjjAIc7HiouZGklmzBREi/Kp6iX9qePTPHFA2QpWNOfWxfKim5
         gXoaPKumaT1m0rBjzmZdDC/iVWQq8zVvdAjy80mG9tXbKOJHto+096uGL6o99JmI+e
         mAuEUjMmeOjNA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CA7C0403B6; Mon, 17 Oct 2022 09:19:36 -0300 (-03)
Date:   Mon, 17 Oct 2022 09:19:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, suzuki.poulose@arm.com,
        linux-perf-users@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        Sven Schnelle <svens@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Carsten Haitzler <carsten.haitzler@foss.arm.com>
Subject: Re: [PATCH] perf tools: Fix man page build wrt perf-arm-coresight.txt
Message-ID: <Y01IWNUOYhfbLsg4@kernel.org>
References: <a176a3e1-6ddc-bb63-e41c-15cda8c2d5d2@intel.com>
 <Y00nFxrcV7TVqmJO@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y00nFxrcV7TVqmJO@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 17, 2022 at 05:57:43PM +0800, Leo Yan escreveu:
> On Mon, Oct 17, 2022 at 12:35:49PM +0300, Adrian Hunter wrote:
> > perf build assumes documentation files starting with "perf-" are man
> > pages but perf-arm-coresight.txt is not a man page:
> > 
> > asciidoc: ERROR: perf-arm-coresight.txt: line 2: malformed manpage title
> > asciidoc: ERROR: perf-arm-coresight.txt: line 3: name section expected
> > asciidoc: FAILED: perf-arm-coresight.txt: line 3: section title expected
> > make[3]: *** [Makefile:266: perf-arm-coresight.xml] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > make[2]: *** [Makefile.perf:895: man] Error 2
> > 
> > Fix by renaming it.
> > 
> > Reported-by: Sven Schnelle <svens@linux.ibm.com>
> > Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Fixes: dc2e0fb00bb2 ("perf test coresight: Add relevant documentation about ARM64 CoreSight testing")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Thanks for fixing, Adrian.  The change LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

 
> > ---
> >  .../Documentation/{perf-arm-coresight.txt => arm-coresight.txt}   | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename tools/perf/Documentation/{perf-arm-coresight.txt => arm-coresight.txt} (100%)
> > 
> > diff --git a/tools/perf/Documentation/perf-arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
> > similarity index 100%
> > rename from tools/perf/Documentation/perf-arm-coresight.txt
> > rename to tools/perf/Documentation/arm-coresight.txt
> > -- 
> > 2.25.1
> > 

-- 

- Arnaldo
