Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36A4653418
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiLUQcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiLUQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:31:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21755248D1;
        Wed, 21 Dec 2022 08:31:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2EC9B81BA9;
        Wed, 21 Dec 2022 16:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F61C43396;
        Wed, 21 Dec 2022 16:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671640274;
        bh=ytY2pnVKtBHX6tUn6fSepmOt2D0eU5Ff/O3eWDQNHF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OO+PTYN0WupGmezr2PigE6bA97h577cK/221c0WtQVZVAQDaT0RCP31BnELKMt3jF
         UWKZJOnJ5ZrvEs2XSLaLAMSSXNuPlRQ/JXZ1fLgLZtDSTl9u4+DVb6I2Su853gjlKT
         ZlieolnLr57YhARCWdzIb8Jdatan+fk2QHMYrXdZCY/vskCNXon6NWnlcr5R4k3CNc
         aTcuKtPWGZ46x8WY6YUNHakBmLxJWOS7mh733RjQgh0mXqX+i7eoYg4ohLf8MR956t
         /+uWpgjZ5tuju5URH6o+JYuv23yH6QREs/AxNd/j6zfmC7DvlXXTda2K7PdvdSow2K
         B/ntAXscFPrOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BABE940367; Wed, 21 Dec 2022 13:31:11 -0300 (-03)
Date:   Wed, 21 Dec 2022 13:31:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [PATCH v1 00/32] Refresh Intel vendor events
Message-ID: <Y6M0zwN+1yovTeZH@kernel.org>
References: <20221215064755.1620246-1-irogers@google.com>
 <bbbe8cb7-bc12-537f-0977-e96ab7cf3cfa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbbe8cb7-bc12-537f-0977-e96ab7cf3cfa@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 15, 2022 at 12:23:14PM -0500, Liang, Kan escreveu:
> 
> 
> On 2022-12-15 1:47 a.m., Ian Rogers wrote:
> > Use new repository [1] and converter script to regenerate Intel vendor
> > metrics. In particular this change removes unnecessary json fields and
> > correct uncore events that previously had a buggy converter.
> > 
> 
> Thanks Ian.
> 
> The patch series looks good to me.
> 
> Acked-by: Kan Liang <kan.liang@linux.intel.com>

b4 doesn't like it, I'll apply it manually, probably some went over
message size limits?

- Arnaldo

⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers bbbe8cb7-bc12-537f-0977-e96ab7cf3cfa@linux.intel.com
Grabbing thread from lore.kernel.org/all/bbbe8cb7-bc12-537f-0977-e96ab7cf3cfa%40linux.intel.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 7 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v1 1/32] perf test pmu-events: Fake PMU metric workaround
    ✓ Signed: DKIM/google.com
    + Acked-by: Kan Liang <kan.liang@linux.intel.com> (✓ DKIM/intel.com)
    + Link: https://lore.kernel.org/r/20221215064755.1620246-2-irogers@google.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v1 2/32] perf vendor events intel: Refresh alderlake metrics
    ✓ Signed: DKIM/google.com
    + Acked-by: Kan Liang <kan.liang@linux.intel.com> (✓ DKIM/intel.com)
    + Link: https://lore.kernel.org/r/20221215064755.1620246-3-irogers@google.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v1 3/32] perf vendor events intel: Refresh alderlake-n metrics
    ✓ Signed: DKIM/google.com
    + Acked-by: Kan Liang <kan.liang@linux.intel.com> (✓ DKIM/intel.com)
    + Link: https://lore.kernel.org/r/20221215064755.1620246-4-irogers@google.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v1 4/32] perf vendor events intel: Refresh bonnell events
    ✓ Signed: DKIM/google.com
    + Acked-by: Kan Liang <kan.liang@linux.intel.com> (✓ DKIM/intel.com)
    + Link: https://lore.kernel.org/r/20221215064755.1620246-5-irogers@google.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v1 5/32] perf vendor events intel: Refresh broadwell metrics and events
    ✓ Signed: DKIM/google.com
    + Acked-by: Kan Liang <kan.liang@linux.intel.com> (✓ DKIM/intel.com)
    + Link: https://lore.kernel.org/r/20221215064755.1620246-6-irogers@google.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ERROR: missing [6/32]!
  ERROR: missing [7/32]!
  ERROR: missing [8/32]!
  ERROR: missing [9/32]!
  ERROR: missing [10/32]!
  ERROR: missing [11/32]!
  ERROR: missing [12/32]!

